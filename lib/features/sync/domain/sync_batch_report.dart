import 'package:freezed_annotation/freezed_annotation.dart';

part 'sync_batch_report.freezed.dart';

/// Una fila del lote que el servidor acepto y persistio.
@freezed
abstract class SyncAccepted with _$SyncAccepted {
  const factory SyncAccepted({
    required String clientGuid,
    String? serverId,

    /// `meal` o `symptom`, segun lo que el servidor haya creado.
    String? entityType,
  }) = _SyncAccepted;

  const SyncAccepted._();
}

/// Una fila que el servidor ya tenia, deduplicada por `client_guid`.
///
/// Para el cliente equivale a aceptada: el dato clinico esta a salvo del lado
/// del servidor y la fila local puede cerrarse igual. Pasa cuando un envio
/// anterior prospero pero la respuesta no llego al dispositivo.
@freezed
abstract class SyncDuplicate with _$SyncDuplicate {
  const factory SyncDuplicate({
    required String clientGuid,
    String? existingServerId,
  }) = _SyncDuplicate;

  const SyncDuplicate._();
}

/// Una fila que el servidor rechazo, con el motivo.
@freezed
abstract class SyncRejected with _$SyncRejected {
  const factory SyncRejected({
    required String clientGuid,

    /// `errorCode` del contrato. Decide si la fila reintenta o queda terminal.
    String? errorCode,

    /// Mensaje del servidor, en español y sin garantia de estabilidad. Sirve
    /// para diagnostico, no para mostrarselo al paciente tal cual.
    String? message,
  }) = _SyncRejected;

  const SyncRejected._();
}

/// Clasificacion que devolvio `POST /sync/batch` para un lote.
@freezed
abstract class SyncBatchReport with _$SyncBatchReport {
  const factory SyncBatchReport({
    @Default(<SyncAccepted>[]) List<SyncAccepted> accepted,
    @Default(<SyncDuplicate>[]) List<SyncDuplicate> duplicates,
    @Default(<SyncRejected>[]) List<SyncRejected> errors,
  }) = _SyncBatchReport;

  const SyncBatchReport._();

  /// Filas que quedaron resueltas: aceptadas mas duplicadas.
  int get settledCount => accepted.length + duplicates.length;

  /// `true` si el servidor no rechazo nada.
  bool get isClean => errors.isEmpty;
}
