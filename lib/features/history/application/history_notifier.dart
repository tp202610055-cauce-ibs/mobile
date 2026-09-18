import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/local_sync_status.dart';
import '../../../core/errors/cauce_api_error.dart';
import '../../../core/sync/sync_queue_store.dart';
import '../../foods/data/food_catalog_store.dart';
import '../../foods/domain/food_item.dart';
import '../../meals/data/meals_local_store.dart';
import '../../meals/data/meals_repository.dart';
import '../../meals/domain/meal_draft.dart';
import '../../symptoms/data/symptoms_local_store.dart';
import '../../symptoms/data/symptoms_repository.dart';
import '../../symptoms/domain/symptom_draft.dart';
import '../domain/history_entry.dart';

part 'history_notifier.freezed.dart';
part 'history_notifier.g.dart';

/// Estado del historial del paciente.
@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default(<HistoryEntry>[]) List<HistoryEntry> entries,
    @Default(false) bool loading,

    /// Error de la lectura remota. **No vacia la lista**: lo local sigue ahi.
    CauceApiError? error,
  }) = _HistoryState;

  const HistoryState._();

  /// Entradas que todavia no llegaron al servidor.
  List<HistoryEntry> get unsynced => entries
      .where((entry) => entry.syncState != HistoryEntrySyncState.synced)
      .toList();
}

/// Arma el historial unificado de comidas y sintomas.
///
/// **No usa `GET /api/v1/history`.** El contrato aplana su jerarquia
/// polimorfica y el cliente generado descarta el payload en silencio, asi que
/// el historial se compone desde `/meals` y `/symptoms`, que si devuelven tipos
/// completos, mas lo que todavia esta en la cola local.
///
/// Lo local va primero en el merge para que una fila que ya sincronizo no
/// aparezca dos veces: se deduplica por `clientGuid`.
@riverpod
class HistoryNotifier extends _$HistoryNotifier {
  @override
  HistoryState build() => const HistoryState();

  /// Relee todo: lo local siempre, lo remoto si el servidor responde.
  Future<void> load({DateTime? from, DateTime? to}) async {
    state = state.copyWith(loading: true, error: null);

    final local = await _localEntries();

    try {
      final remote = await _remoteEntries(from: from, to: to);
      state = state.copyWith(
        loading: false,
        entries: _merge(local: local, remote: remote),
      );
    } on CauceApiError catch (error) {
      // Sin servidor el paciente igual ve lo que registro en el dispositivo,
      // que es justamente lo que no puede consultar en ningun otro lado.
      state = state.copyWith(loading: false, entries: local, error: error);
    }
  }

  /// Descarta una fila local que quedo trabada y el paciente reconocio.
  Future<void> discard(String clientGuid) async {
    await ref.read(syncQueueStoreProvider).discard(clientGuid);
    await load();
  }

  /// Entradas que viven en el dispositivo, sincronizadas o no.
  Future<List<HistoryEntry>> _localEntries() async {
    final meals = await ref.read(mealsLocalStoreProvider).recent();
    final symptoms = await ref.read(symptomsLocalStoreProvider).recent();
    final mealsStore = ref.read(mealsLocalStoreProvider);
    final catalog = ref.read(foodCatalogStoreProvider);

    final entries = <HistoryEntry>[];

    for (final meal in meals) {
      final items = await mealsStore.itemsOf(meal.clientGuid);
      final foodIds = items.map((item) => item.foodId).nonNulls.toList();
      final foods = await catalog.findByIds(foodIds);
      final byId = <String, FoodItem>{
        for (final food in foods) food.foodId: food,
      };

      entries.add(
        HistoryEntry(
          kind: HistoryEntryKind.meal,
          occurredAt: meal.consumedAt,
          syncState: _toSyncState(meal.syncStatus),
          serverId: meal.serverId,
          clientGuid: meal.clientGuid,
          lastErrorCode: meal.lastErrorCode,
          mealTime: MealTimeOption.fromWire(meal.mealTime),
          itemNames:
              items.map((item) => byId[item.foodId]?.name).nonNulls.toList(),
        ),
      );
    }

    for (final symptom in symptoms) {
      entries.add(
        HistoryEntry(
          kind: HistoryEntryKind.symptom,
          occurredAt: symptom.occurredAt,
          syncState: _toSyncState(symptom.syncStatus),
          serverId: symptom.serverId,
          clientGuid: symptom.clientGuid,
          lastErrorCode: symptom.lastErrorCode,
          symptomType: SymptomTypeOption.fromWire(symptom.symptomType),
          intensity: symptom.intensity,
          hasMealAssociation: symptom.hasMealAssociation,
        ),
      );
    }

    return entries;
  }

  /// Entradas que devuelve el servidor.
  Future<List<HistoryEntry>> _remoteEntries({
    DateTime? from,
    DateTime? to,
  }) async {
    final meals =
        await ref.read(mealsRepositoryProvider).history(from: from, to: to);
    final symptoms =
        await ref.read(symptomsRepositoryProvider).history(from: from, to: to);
    final catalog = ref.read(foodCatalogStoreProvider);

    final entries = <HistoryEntry>[];

    for (final meal in meals.items) {
      final foodIds = meal.items.map((item) => item.foodId).nonNulls.toList();
      final foods = await catalog.findByIds(foodIds);
      final byId = <String, FoodItem>{
        for (final food in foods) food.foodId: food,
      };

      entries.add(
        HistoryEntry(
          kind: HistoryEntryKind.meal,
          occurredAt: meal.consumedAt,
          syncState: HistoryEntrySyncState.synced,
          serverId: meal.mealId,
          clientGuid: meal.clientGuid,
          mealTime: meal.mealTime,
          aggregatedFodmap: meal.aggregatedFodmap,
          itemNames: meal.items
              .map((item) => byId[item.foodId]?.name)
              .nonNulls
              .toList(),
        ),
      );
    }

    for (final symptom in symptoms.items) {
      entries.add(
        HistoryEntry(
          kind: HistoryEntryKind.symptom,
          occurredAt: symptom.occurredAt,
          syncState: HistoryEntrySyncState.synced,
          serverId: symptom.symptomId,
          clientGuid: symptom.clientGuid,
          symptomType: symptom.symptomType,
          intensity: symptom.intensity,
          hasMealAssociation: symptom.hasMealAssociation,
        ),
      );
    }

    return entries;
  }

  /// Une lo remoto con lo local, sin duplicar.
  ///
  /// Una fila que ya sincronizo esta en las dos listas: la del servidor manda,
  /// porque trae datos que la local no tiene (la carga FODMAP agregada, la
  /// asociacion resuelta). Se identifica por `clientGuid`, que es exactamente
  /// para lo que existe.
  List<HistoryEntry> _merge({
    required List<HistoryEntry> local,
    required List<HistoryEntry> remote,
  }) {
    final remoteGuids =
        remote.map((entry) => entry.clientGuid).nonNulls.toSet();

    final merged = <HistoryEntry>[
      ...remote,
      ...local.where(
        (entry) =>
            entry.clientGuid == null || !remoteGuids.contains(entry.clientGuid),
      ),
    ]..sort((a, b) => b.occurredAt.compareTo(a.occurredAt));

    return merged;
  }

  HistoryEntrySyncState _toSyncState(LocalSyncStatus status) =>
      switch (status) {
        LocalSyncStatus.pending => HistoryEntrySyncState.pending,
        LocalSyncStatus.completed => HistoryEntrySyncState.synced,
        LocalSyncStatus.failed => HistoryEntrySyncState.failed,
      };
}
