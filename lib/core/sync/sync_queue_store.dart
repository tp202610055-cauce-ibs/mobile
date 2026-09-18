import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/app_database.dart';
import '../database/app_database_provider.dart';
import '../database/local_sync_status.dart';

part 'sync_queue_store.g.dart';

/// Una comida local con sus items, lista para armar el lote.
class PendingMeal {
  const PendingMeal({required this.meal, required this.items});

  final MealLocal meal;
  final List<MealItemLocal> items;
}

/// Acceso a la cola de sincronizacion sobre `meals_local` y `symptoms_local`.
///
/// Vive en `core/` y no en una feature porque atiende a dos: el worker
/// sincroniza comidas y sintomas en un mismo lote, y partir estas consultas
/// dejaria la reconciliacion del `SyncBatchResult` repartida en dos lugares.
/// Las features escriben sus propios registros; esta clase solo los mueve
/// entre estados.
class SyncQueueStore {
  const SyncQueueStore(this._db);

  final AppDatabase _db;

  /// Comidas pendientes, con sus items, de la mas vieja a la mas nueva.
  ///
  /// El orden importa: el servidor asocia un sintoma con la comida mas reciente
  /// dentro de la ventana de 4 horas, y mandar las comidas desordenadas podria
  /// dejar esa ventana resuelta contra la comida equivocada.
  Future<List<PendingMeal>> pendingMeals() async {
    final meals = await (_db.select(_db.mealsLocal)
          ..where((row) => row.syncStatus.equalsValue(LocalSyncStatus.pending))
          ..orderBy(<OrderClauseGenerator<$MealsLocalTable>>[
            (row) => OrderingTerm.asc(row.clientCreatedAt),
          ]))
        .get();

    if (meals.isEmpty) {
      return const <PendingMeal>[];
    }

    final guids = meals.map((meal) => meal.clientGuid).toSet();
    final items = await (_db.select(_db.mealItemsLocal)
          ..where((row) => row.mealClientGuid.isIn(guids)))
        .get();

    final byMeal = <String, List<MealItemLocal>>{};
    for (final item in items) {
      byMeal
          .putIfAbsent(item.mealClientGuid, () => <MealItemLocal>[])
          .add(item);
    }

    return meals
        .map(
          (meal) => PendingMeal(
            meal: meal,
            items: byMeal[meal.clientGuid] ?? const <MealItemLocal>[],
          ),
        )
        .toList();
  }

  /// Sintomas pendientes, de la mas vieja a la mas nueva.
  Future<List<SymptomLocal>> pendingSymptoms() {
    return (_db.select(_db.symptomsLocal)
          ..where((row) => row.syncStatus.equalsValue(LocalSyncStatus.pending))
          ..orderBy(<OrderClauseGenerator<$SymptomsLocalTable>>[
            (row) => OrderingTerm.asc(row.clientCreatedAt),
          ]))
        .get();
  }

  /// Marca una fila como sincronizada y guarda el identificador del servidor.
  ///
  /// Se usa tanto para `accepted[]` como para `duplicates[]`: en los dos casos
  /// el dato clinico ya esta a salvo del lado del servidor, y la unica
  /// diferencia es que el duplicado ya estaba.
  Future<void> markCompleted(String clientGuid, String? serverId) async {
    await (_db.update(_db.mealsLocal)
          ..where((row) => row.clientGuid.equals(clientGuid)))
        .write(
      MealsLocalCompanion(
        syncStatus: const Value<LocalSyncStatus>(LocalSyncStatus.completed),
        serverId: Value<String?>(serverId),
        lastErrorCode: const Value<String?>(null),
      ),
    );

    await (_db.update(_db.symptomsLocal)
          ..where((row) => row.clientGuid.equals(clientGuid)))
        .write(
      SymptomsLocalCompanion(
        syncStatus: const Value<LocalSyncStatus>(LocalSyncStatus.completed),
        serverId: Value<String?>(serverId),
        lastErrorCode: const Value<String?>(null),
      ),
    );
  }

  /// Anota el error de una fila y decide si sigue esperando o queda terminal.
  ///
  /// El `errorCode` se guarda siempre, tambien cuando la fila queda pendiente:
  /// sin el, el paciente no tendria como saber por que su registro no sube.
  Future<void> markFailure(
    String clientGuid,
    String? errorCode, {
    required bool permanent,
  }) async {
    final status = permanent ? LocalSyncStatus.failed : LocalSyncStatus.pending;

    await (_db.update(_db.mealsLocal)
          ..where((row) => row.clientGuid.equals(clientGuid)))
        .write(
      MealsLocalCompanion(
        syncStatus: Value<LocalSyncStatus>(status),
        lastErrorCode: Value<String?>(errorCode),
      ),
    );

    await (_db.update(_db.symptomsLocal)
          ..where((row) => row.clientGuid.equals(clientGuid)))
        .write(
      SymptomsLocalCompanion(
        syncStatus: Value<LocalSyncStatus>(status),
        lastErrorCode: Value<String?>(errorCode),
      ),
    );
  }

  /// Guarda la asociacion con una comida que resolvio el servidor.
  Future<void> applyMealAssociation(
    String clientGuid, {
    required String? associatedMealId,
    required bool hasMealAssociation,
  }) {
    return (_db.update(_db.symptomsLocal)
          ..where((row) => row.clientGuid.equals(clientGuid)))
        .write(
      SymptomsLocalCompanion(
        associatedMealId: Value<String?>(associatedMealId),
        hasMealAssociation: Value<bool?>(hasMealAssociation),
      ),
    );
  }

  /// Filas que quedaron en estado terminal y esperan una decision del paciente.
  Future<List<MealLocal>> failedMeals() {
    return (_db.select(_db.mealsLocal)
          ..where((row) => row.syncStatus.equalsValue(LocalSyncStatus.failed)))
        .get();
  }

  Future<List<SymptomLocal>> failedSymptoms() {
    return (_db.select(_db.symptomsLocal)
          ..where((row) => row.syncStatus.equalsValue(LocalSyncStatus.failed)))
        .get();
  }

  /// Borra una fila local que el paciente decidio descartar.
  ///
  /// Es la salida del atasco: sin ella, una fila permanentemente rechazada solo
  /// se volveria visible en vez de resolverse. Los items de una comida se van
  /// con ella por la clave foranea en cascada.
  ///
  /// Solo borra lo que **no** llego al servidor. Una fila `completed` ya es un
  /// registro clinico del paciente y se elimina desde el backend, no de aca.
  Future<int> discard(String clientGuid) async {
    final meals = await (_db.delete(_db.mealsLocal)
          ..where(
            (row) =>
                row.clientGuid.equals(clientGuid) &
                row.syncStatus.equalsValue(LocalSyncStatus.completed).not(),
          ))
        .go();

    final symptoms = await (_db.delete(_db.symptomsLocal)
          ..where(
            (row) =>
                row.clientGuid.equals(clientGuid) &
                row.syncStatus.equalsValue(LocalSyncStatus.completed).not(),
          ))
        .go();

    return meals + symptoms;
  }
}

@Riverpod(keepAlive: true)
SyncQueueStore syncQueueStore(Ref ref) {
  return SyncQueueStore(ref.watch(appDatabaseProvider));
}
