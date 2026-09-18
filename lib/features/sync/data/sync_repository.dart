import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/sync/sync_queue_store.dart';
import '../domain/sync_batch_report.dart';

part 'sync_repository.g.dart';

/// Envia a `POST /api/v1/sync/batch` lo que el paciente registro sin conexion.
///
/// Es el unico endpoint del cliente con rate limit `sync` (120/min por
/// usuario) en vez de `default-auth`. A volumen de un paciente no se alcanza.
///
/// **Las notas de contexto no viajan en el lote.** `SyncBatchRequest` solo
/// acepta comidas y sintomas, y `CreateClinicalNoteRequest` ni siquiera tiene
/// `clientGuid`, asi que crear una nota exige conexion (US13).
class SyncRepository {
  const SyncRepository(this._api);

  final SyncApi _api;

  /// Sincroniza el lote y devuelve la clasificacion que hizo el servidor.
  Future<SyncBatchReport> push({
    required List<PendingMeal> meals,
    required List<SymptomLocal> symptoms,
  }) {
    return guardApiCall(() async {
      final response = await _api.apiV1SyncBatchPost(
        // Se puebla con `addAll` sobre el builder que ya trae `built_value` en
        // vez de construir un `ListBuilder`: `built_collection` es una
        // dependencia transitiva del cliente generado, no una del proyecto, y
        // nombrar su tipo aca la volveria directa sin declararla en el pubspec.
        syncBatchRequest: SyncBatchRequest(
          (b) => b
            ..meals.addAll(meals.map(_toMealBatchItem))
            ..symptoms.addAll(symptoms.map(_toSymptomItem)),
        ),
      );

      final result = response.data;
      if (result == null) {
        throw const FormatException('El lote respondio con un cuerpo vacio.');
      }

      return SyncBatchReport(
        accepted: result.accepted
                ?.map(
                  (entry) => SyncAccepted(
                    clientGuid: entry.clientGuid ?? '',
                    serverId: entry.serverId,
                    entityType: entry.entityType,
                  ),
                )
                .where((entry) => entry.clientGuid.isNotEmpty)
                .toList() ??
            const <SyncAccepted>[],
        duplicates: result.duplicates
                ?.map(
                  (entry) => SyncDuplicate(
                    clientGuid: entry.clientGuid ?? '',
                    existingServerId: entry.existingServerId,
                  ),
                )
                .where((entry) => entry.clientGuid.isNotEmpty)
                .toList() ??
            const <SyncDuplicate>[],
        errors: result.errors
                ?.map(
                  (entry) => SyncRejected(
                    clientGuid: entry.clientGuid ?? '',
                    errorCode: entry.errorCode,
                    message: entry.message,
                  ),
                )
                .where((entry) => entry.clientGuid.isNotEmpty)
                .toList() ??
            const <SyncRejected>[],
      );
    });
  }

  // Los enums se resuelven con los `serializers` generados y no con
  // `MealTime.valueOf`, que espera el nombre del enum de Dart (`lunch`) y no el
  // del contrato (`Lunch`). Las tablas locales guardan la forma que viaja, asi
  // que la traduccion tiene que usar el mismo mapa `wireName` que escribio el
  // generador. Se llama en linea, sin un helper generico, para no nombrar
  // `Serializer<T>`: `built_value` es una dependencia transitiva del cliente
  // generado y no una del proyecto.

  MealBatchItem _toMealBatchItem(PendingMeal pending) {
    return MealBatchItem(
      (b) => b
        ..clientGuid = pending.meal.clientGuid
        ..mealTime = serializers.deserializeWith(
          MealTime.serializer,
          pending.meal.mealTime,
        )
        ..consumedAt = pending.meal.consumedAt.toUtc()
        ..clientCreatedAt = pending.meal.clientCreatedAt.toUtc()
        ..items.addAll(
          pending.items.map(
            (item) => MealItemRequest(
              (i) => i
                ..foodId = item.foodId
                ..customFoodId = item.customFoodId
                ..quantity = item.quantity
                ..unit = serializers.deserializeWith(
                  MeasurementUnit.serializer,
                  item.unit,
                ),
            ),
          ),
        ),
    );
  }

  SymptomBatchItem _toSymptomItem(SymptomLocal symptom) {
    return SymptomBatchItem(
      (b) => b
        ..clientGuid = symptom.clientGuid
        ..symptomType = serializers.deserializeWith(
          SymptomType.serializer,
          symptom.symptomType,
        )
        ..intensity = symptom.intensity
        ..occurredAt = symptom.occurredAt.toUtc()
        ..clientCreatedAt = symptom.clientCreatedAt.toUtc(),
    );
  }
}

@Riverpod(keepAlive: true)
SyncRepository syncRepository(Ref ref) {
  return SyncRepository(ref.watch(syncApiProvider));
}
