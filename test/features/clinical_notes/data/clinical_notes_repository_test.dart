import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/clinical_notes/data/clinical_notes_repository.dart';
import 'package:cauce_mobile/features/clinical_notes/domain/clinical_note_draft.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';

/// Arma el repositorio sobre el cliente OpenAPI real, con la red sustituida.
///
/// Es el test que faltaba: el del notifier usa un repositorio mockeado y no
/// podia ver que el `clientGuid` no viajaba en el cuerpo, que es justo lo que
/// hacia que el backend respondiera 400 a toda nota (acta M48).
({ClinicalNotesRepository repository, CannedHttpAdapter adapter}) _harness(
  CannedResponse response,
) {
  final adapter = CannedHttpAdapter(response);
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(dio: dio, interceptors: const <Interceptor>[]);
  return (
    repository: ClinicalNotesRepository(client.getClinicalNotesApi()),
    adapter: adapter,
  );
}

const String _clientGuid = '0b4f6a7e-2c1d-4e9a-8f3b-5d6c7e8f9a01';
const String _noteId = '7d1e2f3a-4b5c-4d6e-8f7a-9b0c1d2e3f40';

const CannedResponse _created = CannedResponse.created(<String, dynamic>{
  'noteId': _noteId,
});

void main() {
  group('ClinicalNotesRepository · POST /clinical-notes', () {
    test('el clientGuid viaja en el cuerpo del pedido', () async {
      final h = _harness(_created);

      await h.repository.create(
        const ClinicalNoteDraft(
          mealId: 'server-meal',
          content: 'Comi apurado',
        ),
        clientGuid: _clientGuid,
      );

      final request = h.adapter.lastRequest;
      expect(request.method, 'POST');
      expect(request.path, endsWith('/api/v1/clinical-notes'));
      expect(request.body['clientGuid'], _clientGuid);
    });

    test('manda la asociacion y el texto recortado junto con la clave',
        () async {
      final h = _harness(_created);

      final noteId = await h.repository.create(
        const ClinicalNoteDraft(
          symptomId: 'server-symptom',
          content: '  Empezo despues del almuerzo  ',
        ),
        clientGuid: _clientGuid,
      );

      expect(noteId, _noteId);
      final body = h.adapter.lastRequest.body;
      expect(body['clientGuid'], _clientGuid);
      expect(body['symptomId'], 'server-symptom');
      expect(body['mealId'], isNull);
      expect(body['content'], 'Empezo despues del almuerzo');
    });

    test('un reintento con la misma clave repite la clave y el cuerpo',
        () async {
      // El servidor deduplica por clave y cuerpo: el reintento tiene que
      // repetir los dos, o responde 409 idempotency_mismatch.
      final h = _harness(_created);
      const draft = ClinicalNoteDraft(mealId: 'server-meal', content: 'Nota');

      await h.repository.create(draft, clientGuid: _clientGuid);
      h.adapter.response = const CannedResponse(
        statusCode: 200,
        body: <String, dynamic>{'noteId': _noteId},
      );
      final replayed = await h.repository.create(
        draft,
        clientGuid: _clientGuid,
      );

      expect(replayed, _noteId);
      final bodies = h.adapter.requests.map((r) => r.body).toList();
      expect(bodies, hasLength(2));
      expect(bodies.last, bodies.first);
    });

    test('409 idempotency_mismatch llega tipado', () {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 409,
          errorCode: 'idempotency_mismatch',
        ),
      );

      expect(
        h.repository.create(
          const ClinicalNoteDraft(mealId: 'server-meal', content: 'Nota'),
          clientGuid: _clientGuid,
        ),
        throwsA(isA<IdempotencyMismatchError>()),
      );
    });

    test('un borrador invalido no llega a la red', () {
      final h = _harness(_created);

      expect(
        () => h.repository.create(
          const ClinicalNoteDraft(content: 'Sin asociacion'),
          clientGuid: _clientGuid,
        ),
        throwsStateError,
      );
      expect(h.adapter.requests, isEmpty);
    });
  });
}
