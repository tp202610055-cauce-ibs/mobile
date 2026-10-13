import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/local_sync_status.dart';
import '../../../core/errors/cauce_api_error.dart';
import '../../foods/data/food_catalog_store.dart';
import '../../meals/data/meals_local_store.dart';
import '../../meals/data/meals_repository.dart';
import '../../meals/domain/meal_draft.dart';
import '../../meals/domain/meal_record.dart';
import '../../symptoms/data/symptoms_local_store.dart';
import '../../symptoms/data/symptoms_repository.dart';
import '../../symptoms/domain/symptom_draft.dart';
import '../domain/history_entry.dart';

part 'history_composer.g.dart';

/// Reloj del historial, sobreescribible en las pruebas.
@Riverpod(keepAlive: true)
DateTime Function() historyClock(Ref ref) => DateTime.now;

/// Tiempo en que una carga sigue fresca al volver a la pestana.
const Duration historyFreshness = Duration(seconds: 30);

/// Rango de `clientCreatedAt` que se pide al servidor y al almacen local.
typedef HistoryWindow = ({DateTime from, DateTime to});

/// Historial compuesto y el primer error remoto, si lo hubo.
typedef ComposedHistory = ({List<HistoryEntry> entries, CauceApiError? error});

typedef _RemoteSlice<T> = ({List<T> items, CauceApiError? error});

/// Arma el historial desde `GET /meals`, `GET /symptoms` y el almacen local.
///
/// Cada fuente remota es independiente: si una pagina falla se conserva lo que
/// ya llego, y lo local se muestra siempre.
class HistoryComposer {
  HistoryComposer({
    required MealsRepository meals,
    required SymptomsRepository symptoms,
    required MealsLocalStore mealsStore,
    required SymptomsLocalStore symptomsStore,
    required FoodCatalogStore catalog,
  })  : _meals = meals,
        _symptoms = symptoms,
        _mealsStore = mealsStore,
        _symptomsStore = symptomsStore,
        _catalog = catalog;

  /// Registros por pagina: el maximo que acepta el servidor.
  static const int pageSize = 100;

  /// Paginas por tipo como tope de seguridad.
  static const int maxPages = 10;

  static const int _idsPerQuery = 500;

  final MealsRepository _meals;
  final SymptomsRepository _symptoms;
  final MealsLocalStore _mealsStore;
  final SymptomsLocalStore _symptomsStore;
  final FoodCatalogStore _catalog;

  /// Lee la ventana completa. Un fallo local se propaga; uno remoto no.
  Future<ComposedHistory> compose(HistoryWindow window) async {
    final localMeals = await _mealsStore.forHistory(from: window.from);
    final localSymptoms = await _symptomsStore.forHistory(from: window.from);
    final localItems = await _mealsStore.itemsOfMany(
      localMeals.map((meal) => meal.clientGuid),
    );

    final meals = await _collect<MealRecord>(
      (page) async {
        final result = await _meals.history(
          from: window.from,
          to: window.to,
          page: page,
          pageSize: pageSize,
        );
        return (items: result.items, hasMore: result.hasMore);
      },
      (meal) => meal.mealId,
    );
    final symptoms = await _collect<SymptomRecord>(
      (page) async {
        final result = await _symptoms.history(
          from: window.from,
          to: window.to,
          page: page,
          pageSize: pageSize,
        );
        return (items: result.items, hasMore: result.hasMore);
      },
      (symptom) => symptom.symptomId,
    );

    final names = await _foodNames(<String>{
      ...localItems.map((item) => item.foodId).nonNulls,
      for (final meal in meals.items)
        ...meal.items.map((item) => item.foodId).nonNulls,
    });

    final remote = <HistoryEntry>[
      ...meals.items.map((meal) => _remoteMeal(meal, names)),
      ..._remoteSymptoms(symptoms.items, meals.items),
    ];
    final local = <HistoryEntry>[
      ..._localMeals(localMeals, localItems, names),
      ...localSymptoms.map(_localSymptom),
    ];

    return (
      entries: _merge(local: local, remote: remote),
      error: meals.error ?? symptoms.error,
    );
  }

  /// Pide paginas en serie hasta `hasMore` falso, una pagina vacia o el tope.
  Future<_RemoteSlice<T>> _collect<T>(
    Future<({List<T> items, bool hasMore})> Function(int page) fetch,
    String Function(T item) idOf,
  ) async {
    // Un registro nuevo a mitad de la carga corre el resto un lugar.
    final byId = <String, T>{};
    try {
      for (var page = 1; page <= maxPages; page++) {
        final result = await fetch(page);
        for (final item in result.items) {
          byId.putIfAbsent(idOf(item), () => item);
        }
        if (result.items.isEmpty || !result.hasMore) {
          break;
        }
      }
    } on CauceApiError catch (error) {
      return (items: byId.values.toList(), error: error);
    }
    return (items: byId.values.toList(), error: null);
  }

  /// Nombres del catalogo local para [foodIds], en tandas de 500 claves.
  Future<Map<String, String>> _foodNames(Set<String> foodIds) async {
    final ids = foodIds.toList();
    final names = <String, String>{};
    for (var start = 0; start < ids.length; start += _idsPerQuery) {
      final end = math.min(start + _idsPerQuery, ids.length);
      for (final food in await _catalog.findByIds(ids.sublist(start, end))) {
        names[food.foodId] = food.name;
      }
    }
    return names;
  }

  HistoryEntry _remoteMeal(MealRecord meal, Map<String, String> names) {
    return HistoryEntry(
      kind: HistoryEntryKind.meal,
      occurredAt: meal.consumedAt,
      syncState: HistoryEntrySyncState.synced,
      serverId: meal.mealId,
      clientGuid: meal.clientGuid,
      mealTime: meal.mealTime,
      aggregatedFodmap: meal.aggregatedFodmap,
      items: <HistoryMealItem>[
        for (final item in meal.items)
          HistoryMealItem(
            name: names[item.foodId],
            quantity: item.quantity,
            unit: item.unit,
          ),
      ],
    );
  }

  /// La comida asociada se busca entre todas las comidas cargadas; la ventana
  /// de cuatro horas ya la resolvio el servidor.
  Iterable<HistoryEntry> _remoteSymptoms(
    List<SymptomRecord> symptoms,
    List<MealRecord> meals,
  ) {
    final mealsById = <String, MealRecord>{
      for (final meal in meals) meal.mealId: meal,
    };

    return symptoms.map((symptom) {
      final associatedId = symptom.associatedMealId;
      final associated = associatedId == null ? null : mealsById[associatedId];

      return HistoryEntry(
        kind: HistoryEntryKind.symptom,
        occurredAt: symptom.occurredAt,
        syncState: HistoryEntrySyncState.synced,
        serverId: symptom.symptomId,
        clientGuid: symptom.clientGuid,
        symptomType: symptom.symptomType,
        intensity: symptom.intensity,
        hasMealAssociation: symptom.hasMealAssociation,
        associatedMealTime: associated?.mealTime,
        associatedMealDelay: associated == null
            ? null
            : symptom.occurredAt.difference(associated.consumedAt),
      );
    });
  }

  Iterable<HistoryEntry> _localMeals(
    List<MealLocal> meals,
    List<MealItemLocal> items,
    Map<String, String> names,
  ) {
    final byMeal = <String, List<MealItemLocal>>{};
    for (final item in items) {
      byMeal
          .putIfAbsent(item.mealClientGuid, () => <MealItemLocal>[])
          .add(item);
    }

    return meals.map(
      (meal) => HistoryEntry(
        kind: HistoryEntryKind.meal,
        occurredAt: meal.consumedAt,
        syncState: _toSyncState(meal.syncStatus),
        serverId: meal.serverId,
        clientGuid: meal.clientGuid,
        lastErrorCode: meal.lastErrorCode,
        mealTime: MealTimeOption.fromWire(meal.mealTime),
        items: <HistoryMealItem>[
          for (final item in byMeal[meal.clientGuid] ?? <MealItemLocal>[])
            HistoryMealItem(
              name: names[item.foodId],
              quantity: item.quantity,
              unit: MeasurementUnitOption.fromWire(item.unit),
            ),
        ],
      ),
    );
  }

  HistoryEntry _localSymptom(SymptomLocal symptom) {
    return HistoryEntry(
      kind: HistoryEntryKind.symptom,
      occurredAt: symptom.occurredAt,
      syncState: _toSyncState(symptom.syncStatus),
      serverId: symptom.serverId,
      clientGuid: symptom.clientGuid,
      lastErrorCode: symptom.lastErrorCode,
      symptomType: SymptomTypeOption.fromWire(symptom.symptomType),
      intensity: symptom.intensity,
      hasMealAssociation: symptom.hasMealAssociation,
    );
  }

  /// Une lo remoto con lo local sin duplicar por `clientGuid`; la fila del
  /// servidor manda porque trae la carga FODMAP y la asociacion resuelta.
  List<HistoryEntry> _merge({
    required List<HistoryEntry> local,
    required List<HistoryEntry> remote,
  }) {
    final remoteGuids =
        remote.map((entry) => entry.clientGuid).nonNulls.toSet();

    return <HistoryEntry>[
      ...remote,
      ...local.where(
        (entry) =>
            entry.clientGuid == null || !remoteGuids.contains(entry.clientGuid),
      ),
    ]..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));
  }

  HistoryEntrySyncState _toSyncState(LocalSyncStatus status) =>
      switch (status) {
        LocalSyncStatus.pending => HistoryEntrySyncState.pending,
        LocalSyncStatus.completed => HistoryEntrySyncState.synced,
        LocalSyncStatus.failed => HistoryEntrySyncState.failed,
      };
}

@Riverpod(keepAlive: true)
HistoryComposer historyComposer(Ref ref) {
  return HistoryComposer(
    meals: ref.watch(mealsRepositoryProvider),
    symptoms: ref.watch(symptomsRepositoryProvider),
    mealsStore: ref.watch(mealsLocalStoreProvider),
    symptomsStore: ref.watch(symptomsLocalStoreProvider),
    catalog: ref.watch(foodCatalogStoreProvider),
  );
}
