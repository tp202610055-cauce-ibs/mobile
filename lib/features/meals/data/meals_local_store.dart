import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/app_database_provider.dart';
import '../../../core/database/local_sync_status.dart';
import '../domain/meal_draft.dart';

part 'meals_local_store.g.dart';

/// Escribe en el dispositivo las comidas que el paciente registra sin conexion
/// (HU0009 CA02, CP023).
///
/// La cola la lee el worker de sincronizacion desde `core/sync/`; esta clase
/// solo crea las filas y las lee para mostrarlas en el historial.
class MealsLocalStore {
  const MealsLocalStore(this._db, this._uuid);

  final AppDatabase _db;
  final Uuid _uuid;

  /// Guarda la comida como pendiente y devuelve su `client_guid`.
  ///
  /// **La clave la decide el formulario, una sola vez por comida** (acta M50,
  /// que extiende M48). El backend deduplica por ella: un reintento tiene que
  /// repetirla intacta, y reusarla con otra carga da 409
  /// `idempotency_mismatch`. Antes se generaba aca en cada llamada, y cada
  /// toque de "Registrar" tras un corte de red dejaba una comida nueva que el
  /// servidor no podia reconocer como la misma. Sin [clientGuid] se genera
  /// una.
  ///
  /// **Con una clave que ya existe, reemplaza la fila** en vez de insertar
  /// otra: el paciente pudo corregir el formulario entre un intento y el
  /// siguiente, y la cola tiene que subir lo ultimo que confirmo. Una fila que
  /// ya llego al servidor no se toca.
  ///
  /// La comida y sus items se escriben en una transaccion. Sin eso, un corte a
  /// mitad dejaria una comida sin items, que el backend rechaza por la
  /// invariante de 1 a 50, y la fila quedaria trabada en la cola.
  Future<String> enqueue(
    MealDraft draft, {
    String? clientGuid,
    DateTime? now,
  }) async {
    final key = clientGuid ?? _uuid.v4();
    final createdAt = (now ?? DateTime.now()).toUtc();
    final mealTime = draft.mealTime;

    if (mealTime == null || draft.items.isEmpty) {
      throw StateError(
        'La comida exige momento del dia y al menos un alimento. '
        'La pantalla ya lo bloquea antes de llegar aca.',
      );
    }

    await _db.transaction(() async {
      final existing = await (_db.select(_db.mealsLocal)
            ..where((row) => row.clientGuid.equals(key)))
          .getSingleOrNull();
      if (existing != null) {
        if (existing.syncStatus == LocalSyncStatus.completed) {
          return;
        }
        // Los items se van con la comida por la clave foranea en cascada.
        await (_db.delete(_db.mealsLocal)
              ..where((row) => row.clientGuid.equals(key)))
            .go();
      }

      await _db.into(_db.mealsLocal).insert(
            MealsLocalCompanion.insert(
              clientGuid: key,
              mealTime: mealTime.wireValue,
              consumedAt: (draft.consumedAt ?? createdAt).toUtc(),
              clientCreatedAt: createdAt,
              syncStatus: LocalSyncStatus.pending,
            ),
          );

      for (final item in draft.items) {
        await _db.into(_db.mealItemsLocal).insert(
              MealItemsLocalCompanion.insert(
                mealClientGuid: key,
                quantity: item.quantity,
                unit: item.unit.wireValue,
                foodId: Value<String?>(item.foodId),
                customFoodId: Value<String?>(item.customFoodId),
              ),
            );
      }
    });

    return key;
  }

  /// Cierra una fila local que el servidor ya acepto en el momento.
  ///
  /// El camino con conexion escribe primero la fila local y despues envia, de
  /// modo que el `client_guid` que viaja es el mismo que quedo guardado. Si la
  /// respuesta se perdiera, el reintento repite ese UUID y el backend deduplica
  /// en vez de crear una segunda comida.
  ///
  /// Guardar tambien lo que se sincronizo al instante hace que el historial
  /// local muestre lo mismo con red y sin red, y que el paciente no vea sus
  /// registros aparecer y desaparecer segun la cobertura.
  Future<void> markSynced(String clientGuid, String serverId) async {
    await (_db.update(_db.mealsLocal)
          ..where((row) => row.clientGuid.equals(clientGuid)))
        .write(
      MealsLocalCompanion(
        syncStatus: const Value<LocalSyncStatus>(LocalSyncStatus.completed),
        serverId: Value<String?>(serverId),
        lastErrorCode: const Value<String?>(null),
      ),
    );
  }

  /// Comidas locales, de la mas reciente a la mas vieja.
  Future<List<MealLocal>> recent({int limit = 50}) {
    return (_db.select(_db.mealsLocal)
          ..orderBy(<OrderClauseGenerator<$MealsLocalTable>>[
            (row) => OrderingTerm.desc(row.clientCreatedAt),
          ])
          ..limit(limit))
        .get();
  }

  /// Items de una comida local.
  Future<List<MealItemLocal>> itemsOf(String clientGuid) {
    return (_db.select(_db.mealItemsLocal)
          ..where((row) => row.mealClientGuid.equals(clientGuid)))
        .get();
  }
}

@Riverpod(keepAlive: true)
MealsLocalStore mealsLocalStore(Ref ref) {
  return MealsLocalStore(ref.watch(appDatabaseProvider), const Uuid());
}
