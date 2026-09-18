import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/clinical_note_draft.dart';

part 'clinical_notes_repository.g.dart';

/// Notas de contexto sobre una comida o un sintoma (US13).
///
/// **Este endpoint no es idempotente.** `CreateClinicalNoteRequest` no tiene
/// `clientGuid` y `ClinicalNotesController` tampoco lee el header
/// `Idempotency-Key`, de modo que un reintento crea una nota duplicada. Por eso
/// las notas **no entran a la cola de sincronizacion** de este bloque y exigen
/// conexion activa.
///
/// Si mas adelante hiciera falta crearlas sin conexion, es un pedido de backend
/// (agregar `client_guid` a la peticion), no algo que el cliente pueda resolver
/// por su cuenta sin arriesgar duplicados en el registro clinico.
class ClinicalNotesRepository {
  const ClinicalNotesRepository(this._api);

  final ClinicalNotesApi _api;

  /// `POST /api/v1/clinical-notes`. Devuelve el identificador de la nota.
  Future<String> create(ClinicalNoteDraft draft) {
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
