import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/clinical_note_draft.dart';

part 'clinical_notes_repository.g.dart';

/// Notas de contexto sobre una comida o un sintoma (US13).
///
/// **El endpoint es idempotente por `clientGuid`** desde el backend
/// `d557e8d` (2026-09-22), con el mismo patron que `/meals` y `/symptoms`: el
/// `clientGuid` viaja en el **cuerpo**. `ResolveClientGuid` acepta tambien el
/// header `Idempotency-Key`, pero sin ninguno de los dos el validador responde
/// 400: el campo es opcional en el esquema y obligatorio en el servidor. Un
/// reintento con la misma clave y el mismo cuerpo devuelve la nota ya creada
/// (200), y con otro cuerpo, 409 `idempotency_mismatch`.
///
/// Las notas **siguen exigiendo conexion activa**: no entran a la cola de
/// sincronizacion ni se guardan en el dispositivo. La idempotencia cubre el
/// reintento desde la pantalla, no el envio diferido (acta M48).
class ClinicalNotesRepository {
  const ClinicalNotesRepository(this._api);

  final ClinicalNotesApi _api;

  /// `POST /api/v1/clinical-notes`. Devuelve el identificador de la nota.
  ///
  /// [clientGuid] lo genera quien llama, una vez por nota, y lo repite en cada
  /// reintento.
  Future<String> create(ClinicalNoteDraft draft, {required String clientGuid}) {
    if (!draft.canSubmit) {
      throw StateError(
        'La nota exige contenido y exactamente una asociacion. La pantalla ya '
        'lo bloquea antes de llegar aca.',
      );
    }

    return guardApiCall(
      () async {
        final response = await _api.apiV1ClinicalNotesPost(
          createClinicalNoteRequest: CreateClinicalNoteRequest(
            (b) => b
              ..clientGuid = clientGuid
              ..mealId = draft.mealId
              ..symptomId = draft.symptomId
              ..content = draft.content.trim(),
          ),
        );

        final noteId = response.data?.noteId;
        if (noteId == null) {
          throw const FormatException('La nota respondio sin noteId.');
        }
        return noteId;
      },
      malformedResponseStatus: 201,
    );
  }

  /// `GET /api/v1/clinical-notes`. Notas del paciente en un rango de fechas.
  Future<List<ClinicalNoteSummary>> list({DateTime? from, DateTime? to}) {
    return guardApiCall(() async {
      final response = await _api.apiV1ClinicalNotesGet(
        from: from?.toUtc(),
        to: to?.toUtc(),
      );

      return response.data?.toList() ?? const <ClinicalNoteSummary>[];
    });
  }
}

@Riverpod(keepAlive: true)
ClinicalNotesRepository clinicalNotesRepository(Ref ref) {
  return ClinicalNotesRepository(ref.watch(clinicalNotesApiProvider));
}
