import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/sync/sync_queue_store.dart';
import 'package:cauce_mobile/features/sync/data/sync_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';
import '../../../helpers/sync_fixtures.dart';

const String _mealGuid = '11111111-1111-4111-8111-111111111111';
const String _symptomGuid = '22222222-2222-4222-8222-222222222222';

({SyncRepository repository, CannedHttpAdapter adapter}) _harness(
  CannedResponse response,
) {
  final adapter = CannedHttpAdapter(response);
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(dio: dio, interceptors: const <Interceptor>[]);
  return (repository: SyncRepository(client.getSyncApi()), adapter: adapter);
}

void main() {
  late AppDatabase database;
  late SyncQueueStore queue;

  setUp(() {
    database = AppDatabase.memory();
    queue = SyncQueueStore(database);
  });
  tearDown(() => database.close());

  group('SyncRepository · forma del lote', () {
    test('serializa comidas con sus items y sintomas en un solo cuerpo',
        () async {
      await insertPendingMeal(database, _mealGuid);
      await insertPendingSymptom(database, _symptomGuid);
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'accepted': <dynamic>[],
          'duplicates': <dynamic>[],
          'errors': <dynamic>[],
        }),
      );

      await h.repository.push(
        meals: await queue.pendingMeals(),
        symptoms: await queue.pendingSymptoms(),
      );

      final body = h.adapter.lastRequest.body;
      final meals = body['meals'] as List<dynamic>;
      final symptoms = body['symptoms'] as List<dynamic>;

      expect(meals, hasLength(1));
      expect(symptoms, hasLength(1));

      final meal = meals.single as Map<String, dynamic>;
      expect(meal['clientGuid'], _mealGuid);
      // Los enums viajan en PascalCase, que es la forma del contrato.
      expect(meal['mealTime'], 'Lunch');
      expect((meal['items'] as List<dynamic>).single, <String, dynamic>{
        'foodId': 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa',
        'quantity': 150.0,
        'unit': 'Grams',
      });

      final symptom = symptoms.single as Map<String, dynamic>;
      expect(symptom['clientGuid'], _symptomGuid);
      expect(symptom['symptomType'], 'Bloating');
      expect(symptom['intensity'], 40);
    });

    test('las marcas de tiempo viajan en UTC con la Z explicita', () async {
      // El backend valida contra su propio reloj UTC y calcula sobre estos
      // valores la ventana de 4 horas. Mandarlos en hora local seria un dato
      // clinico equivocado, no un detalle de formato.
      await insertPendingMeal(
        database,
        _mealGuid,
        clientCreatedAt: DateTime.utc(2026, 9, 18, 3, 15, 42),
      );
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'accepted': <dynamic>[],
          'duplicates': <dynamic>[],
          'errors': <dynamic>[],
        }),
      );

      await h.repository.push(
        meals: await queue.pendingMeals(),
        symptoms: const <SymptomLocal>[],
      );

      final meal = (h.adapter.lastRequest.body['meals'] as List<dynamic>).single
          as Map<String, dynamic>;

      expect(meal['clientCreatedAt'], endsWith('Z'));
      expect(meal['clientCreatedAt'], startsWith('2026-09-18T03:15:42'));
    });

    test('un lote vacio se serializa igual, con las dos listas vacias',
        () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'accepted': <dynamic>[],
          'duplicates': <dynamic>[],
          'errors': <dynamic>[],
        }),
      );

      await h.repository.push(
        meals: const <PendingMeal>[],
        symptoms: const <SymptomLocal>[],
      );

      expect(h.adapter.lastRequest.body['meals'], isEmpty);
      expect(h.adapter.lastRequest.body['symptoms'], isEmpty);
    });
  });

  group('SyncRepository · lectura de la respuesta', () {
    test('traduce las tres listas al dominio', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'accepted': <dynamic>[
            <String, dynamic>{
              'clientGuid': _mealGuid,
              'serverId': 'server-1',
              'entityType': 'meal',
            },
          ],
          'duplicates': <dynamic>[
            <String, dynamic>{
              'clientGuid': _symptomGuid,
              'existingServerId': 'server-previo',
            },
          ],
          'errors': <dynamic>[
            <String, dynamic>{
              'clientGuid': '33333333-3333-4333-8333-333333333333',
              'errorCode': 'food_item_not_found',
              'message': 'El alimento no existe.',
            },
          ],
        }),
      );

      final report = await h.repository.push(
        meals: const <PendingMeal>[],
        symptoms: const <SymptomLocal>[],
      );

      expect(report.accepted.single.serverId, 'server-1');
      expect(report.accepted.single.entityType, 'meal');
      expect(report.duplicates.single.existingServerId, 'server-previo');
      expect(report.errors.single.errorCode, 'food_item_not_found');
      expect(report.settledCount, 2);
      expect(report.isClean, isFalse);
    });

    test('un lote sin rechazos queda limpio', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'accepted': <dynamic>[
            <String, dynamic>{'clientGuid': _mealGuid, 'serverId': 'server-1'},
          ],
          'duplicates': <dynamic>[],
          'errors': <dynamic>[],
        }),
      );

      final report = await h.repository.push(
        meals: const <PendingMeal>[],
        symptoms: const <SymptomLocal>[],
      );

      expect(report.isClean, isTrue);
      expect(report.settledCount, 1);
    });

    test('descarta una entrada sin clientGuid', () async {
      // Sin el identificador no hay fila local que reconciliar: aplicarla a
      // ciegas podria cerrar el registro equivocado.
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'accepted': <dynamic>[
            <String, dynamic>{'serverId': 'server-huerfano'},
          ],
          'duplicates': <dynamic>[],
          'errors': <dynamic>[],
        }),
      );

      final report = await h.repository.push(
        meals: const <PendingMeal>[],
        symptoms: const <SymptomLocal>[],
      );

      expect(report.accepted, isEmpty);
    });

    test('traduce un 429 al dominio', () async {
      // El lote tiene rate limit propio, `sync`, de 120/min por usuario.
      final h = _harness(
        CannedResponse.problem(
          statusCode: 429,
          extra: const <String, dynamic>{'retryAfterSeconds': 30},
        ),
      );

      await expectLater(
        h.repository.push(
          meals: const <PendingMeal>[],
          symptoms: const <SymptomLocal>[],
        ),
        throwsA(isA<RateLimitedError>()),
      );
    });
  });
}
