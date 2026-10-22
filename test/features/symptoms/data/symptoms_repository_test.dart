import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/symptoms/data/symptoms_repository.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';

const String _clientGuid = '22222222-2222-4222-8222-222222222222';

/// Momento del registro con microsegundos, para probar que viaja intacto.
final DateTime _createdAt = DateTime.utc(2026, 9, 18, 15, 5, 7, 123, 456);

final SymptomDraft _draft = SymptomDraft(
  symptomType: SymptomTypeOption.bloating,
  intensity: 60,
  occurredAt: DateTime.utc(2026, 9, 18, 14, 30),
);

({SymptomsRepository repository, CannedHttpAdapter adapter}) _harness(
  CannedResponse response,
) {
  final adapter = CannedHttpAdapter(response);
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(dio: dio, interceptors: const <Interceptor>[]);
  return (
    repository: SymptomsRepository(client.getSymptomsApi()),
    adapter: adapter,
  );
}

CannedResponse _page(List<Map<String, dynamic>> items, {int total = 0}) {
  return CannedResponse.ok(<String, dynamic>{
    'items': items,
    'page': 1,
    'pageSize': 50,
    'totalCount': total,
  });
}

void main() {
  group('SymptomsRepository · registro (HU0011)', () {
    test('manda el clientGuid en el cuerpo y las fechas en UTC', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{'symptomId': 's-1'}),
      );

      await h.repository.create(
        _draft,
        clientGuid: _clientGuid,
        clientCreatedAt: _createdAt.toLocal(),
      );

      final body = h.adapter.lastRequest.body;
      expect(body['clientGuid'], _clientGuid);
      expect(body['symptomType'], 'Bloating');
      expect(body['intensity'], 60);
      expect(body['occurredAt'], '2026-09-18T14:30:00.000Z');
      expect(body['clientCreatedAt'], _createdAt.toIso8601String());
    });

    test('sin fecha del sintoma usa el momento del registro', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{'symptomId': 's-1'}),
      );

      await h.repository.create(
        const SymptomDraft(
          symptomType: SymptomTypeOption.nausea,
          intensity: 20,
        ),
        clientGuid: _clientGuid,
        clientCreatedAt: _createdAt,
      );

      final body = h.adapter.lastRequest.body;
      expect(body['occurredAt'], body['clientCreatedAt']);
    });

    test('devuelve la asociacion que resolvio el servidor', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{
          'symptomId': 's-1',
          'associatedMealId': 'meal-1',
          'hasMealAssociation': true,
        }),
      );

      final created = await h.repository.create(
        _draft,
        clientGuid: _clientGuid,
        clientCreatedAt: _createdAt,
      );

      expect(created.symptomId, 's-1');
      expect(created.associatedMealId, 'meal-1');
      expect(created.hasMealAssociation, isTrue);
    });

    test('sin hasMealAssociation en la respuesta se lee como false', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{'symptomId': 's-1'}),
      );

      final created = await h.repository.create(
        _draft,
        clientGuid: _clientGuid,
        clientCreatedAt: _createdAt,
      );

      expect(created.hasMealAssociation, isFalse);
    });

    test('un 201 sin symptomId es un error', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{}),
      );

      await expectLater(
        h.repository.create(
          _draft,
          clientGuid: _clientGuid,
          clientCreatedAt: _createdAt,
        ),
        throwsA(isA<UnknownError>()),
      );
    });

    test('sin tipo o sin intensidad no sale a la red', () {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{'symptomId': 's-1'}),
      );

      expect(
        () => h.repository.create(
          const SymptomDraft(intensity: 60),
          clientGuid: _clientGuid,
          clientCreatedAt: _createdAt,
        ),
        throwsStateError,
      );
      expect(h.adapter.requests, isEmpty);
    });
  });

  group('SymptomsRepository · historial (GET /symptoms)', () {
    test('manda from y to en UTC con Z, page y pageSize', () async {
      final h = _harness(_page(const <Map<String, dynamic>>[]));

      await h.repository.history(
        from: DateTime.utc(2026, 7, 13, 20),
        to: DateTime.utc(2026, 10, 12, 20),
        page: 3,
        pageSize: 100,
      );

      final query = h.adapter.lastRequest.queryParameters;
      expect(query['from'], '2026-07-13T20:00:00.000Z');
      expect(query['to'], '2026-10-12T20:00:00.000Z');
      expect(query['page'], 3);
      expect(query['pageSize'], 100);
    });

    test('la ventana por defecto mira noventa dias atras y uno adelante',
        () async {
      final h = _harness(_page(const <Map<String, dynamic>>[]));

      await h.repository.history(now: DateTime.utc(2026, 10, 11, 12));

      final query = h.adapter.lastRequest.queryParameters;
      expect(
        DateTime.parse(query['from']! as String),
        DateTime.utc(2026, 10, 11, 12).subtract(const Duration(days: 90)),
      );
      expect(
        DateTime.parse(query['to']! as String),
        DateTime.utc(2026, 10, 12, 12),
      );
    });

    test('traduce tipo, intensidad, asociacion y clientGuid', () async {
      final h = _harness(
        _page(
          <Map<String, dynamic>>[
            <String, dynamic>{
              'symptomId': 's-1',
              'clientGuid': _clientGuid,
              'symptomType': 'AbdominalPain',
              'intensity': 70,
              'occurredAt': '2026-09-18T15:00:00Z',
              'associatedMealId': 'meal-1',
              'hasMealAssociation': true,
            },
          ],
          total: 1,
        ),
      );

      final record = (await h.repository.history()).items.single;

      expect(record.symptomId, 's-1');
      expect(record.clientGuid, _clientGuid);
      expect(record.symptomType, SymptomTypeOption.abdominalPain);
      expect(record.intensity, 70);
      expect(record.occurredAt, DateTime.utc(2026, 9, 18, 15));
      expect(record.associatedMealId, 'meal-1');
      expect(record.hasMealAssociation, isTrue);
    });

    test('descarta una entrada sin symptomId, sin fecha o sin intensidad',
        () async {
      final h = _harness(
        _page(
          <Map<String, dynamic>>[
            <String, dynamic>{
              'occurredAt': '2026-09-18T15:00:00Z',
              'intensity': 40,
            },
            <String, dynamic>{'symptomId': 's-2', 'intensity': 40},
            <String, dynamic>{
              'symptomId': 's-3',
              'occurredAt': '2026-09-18T15:00:00Z',
            },
            <String, dynamic>{
              'symptomId': 's-4',
              'occurredAt': '2026-09-18T15:00:00Z',
              'intensity': 40,
            },
          ],
          total: 4,
        ),
      );

      final result = await h.repository.history();

      expect(result.items.map((r) => r.symptomId), <String>['s-4']);
      expect(result.items.single.hasMealAssociation, isFalse);
    });

    test('hasMore es true cuando quedan paginas', () async {
      final h = _harness(_page(const <Map<String, dynamic>>[], total: 120));

      expect((await h.repository.history()).hasMore, isTrue);
    });
  });
}
