import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:cauce_mobile/features/meals/data/meals_repository.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';

const String _clientGuid = '11111111-1111-4111-8111-111111111111';

const FoodItem _arroz = FoodItem(
  foodId: 'f1',
  name: 'Arroz blanco cocido',
  category: 'cereales',
  isPeruvian: true,
);

final MealDraft _draft = MealDraft(
  mealTime: MealTimeOption.lunch,
  consumedAt: DateTime.utc(2026, 9, 18, 13),
  items: const <MealItemDraft>[
    MealItemDraft(
      quantity: 150,
      unit: MeasurementUnitOption.grams,
      food: _arroz,
    ),
  ],
);

({MealsRepository repository, CannedHttpAdapter adapter}) _harness(
  CannedResponse response,
) {
  final adapter = CannedHttpAdapter(response);
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(dio: dio, interceptors: const <Interceptor>[]);
  return (repository: MealsRepository(client.getMealsApi()), adapter: adapter);
}

void main() {
  group('MealsRepository · registro (CA01, CP022)', () {
    test('manda el clientGuid en el cuerpo, no en el header', () async {
      // La §6.3 del CLAUDE.md describia un `Idempotency-Key` universal que el
      // contrato no declara: para /meals el OpenAPI solo expone `clientGuid`
      // dentro del request. La via tipada es el cuerpo.
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{'mealId': 'server-1'}),
      );

      await h.repository.create(_draft, clientGuid: _clientGuid);

      final body = h.adapter.lastRequest.body;
      expect(body['clientGuid'], _clientGuid);
      expect(body['mealTime'], 'Lunch');
      expect(
        h.adapter.lastRequest.headers.containsKey('Idempotency-Key'),
        isFalse,
      );
    });

    test('serializa los items con su unidad de contrato', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{'mealId': 'server-1'}),
      );

      await h.repository.create(_draft, clientGuid: _clientGuid);

      final items = h.adapter.lastRequest.body['items'] as List<dynamic>;
      expect(items.single, <String, dynamic>{
        'foodId': 'f1',
        'quantity': 150.0,
        'unit': 'Grams',
      });
    });

    test('las fechas viajan en UTC', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{'mealId': 'server-1'}),
      );

      await h.repository.create(_draft, clientGuid: _clientGuid);

      expect(h.adapter.lastRequest.body['consumedAt'], endsWith('Z'));
      expect(h.adapter.lastRequest.body['clientCreatedAt'], endsWith('Z'));
    });

    test('devuelve el mealId y la carga FODMAP que calculo el servidor',
        () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{
          'mealId': 'server-1',
          'aggregatedFodmap': 'Moderate',
        }),
      );

      final created =
          await h.repository.create(_draft, clientGuid: _clientGuid);

      expect(created.mealId, 'server-1');
      expect(created.aggregatedFodmap, FodmapLoad.moderate);
      expect(created.wasReplay, isFalse);
    });

    test('un 200 se reconoce como reintento deduplicado', () async {
      // El endpoint es idempotente respecto del `client_guid`: 201 es creacion
      // nueva, 200 es que el servidor ya lo tenia.
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{'mealId': 'server-1'}),
      );

      final created =
          await h.repository.create(_draft, clientGuid: _clientGuid);

      expect(created.wasReplay, isTrue);
      expect(created.mealId, 'server-1');
    });

    test('una respuesta sin mealId no se acepta a medias', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{
          'aggregatedFodmap': 'Low',
        }),
      );

      await expectLater(
        h.repository.create(_draft, clientGuid: _clientGuid),
        throwsA(
          isA<UnknownError>().having((e) => e.statusCode, 'statusCode', 201),
        ),
      );
    });

    test('traduce el 404 del alimento', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 404,
          errorCode: 'food_item_not_found',
        ),
      );

      await expectLater(
        h.repository.create(_draft, clientGuid: _clientGuid),
        throwsA(isA<FoodItemNotFoundError>()),
      );
    });

    test('traduce el 409 de idempotencia', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 409,
          errorCode: 'idempotency_mismatch',
        ),
      );

      await expectLater(
        h.repository.create(_draft, clientGuid: _clientGuid),
        throwsA(isA<IdempotencyMismatchError>()),
      );
    });

    test('un borrador incompleto ni siquiera sale del dispositivo', () async {
      final h = _harness(const CannedResponse.noContent());

      expect(
        () => h.repository.create(
          const MealDraft(mealTime: MealTimeOption.lunch),
          clientGuid: _clientGuid,
        ),
        throwsA(isA<StateError>()),
      );
      expect(h.adapter.requests, isEmpty);
    });
  });

  group('MealsRepository · historial (CP024)', () {
    test('traduce la pagina al dominio', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'items': <dynamic>[
            <String, dynamic>{
              'mealId': 'server-1',
              'clientGuid': _clientGuid,
              'mealTime': 'Breakfast',
              'consumedAt': '2026-09-18T12:30:00Z',
              'syncStatus': 'SyncCompleted',
              'aggregatedFodmap': 'High',
              'items': <dynamic>[
                <String, dynamic>{
                  'foodId': 'f1',
                  'quantity': 150.0,
                  'unit': 'Grams',
                },
              ],
            },
          ],
          'page': 1,
          'pageSize': 50,
          'totalCount': 1,
        }),
      );

      final result = await h.repository.history();

      expect(result.items, hasLength(1));
      final meal = result.items.single;
      expect(meal.mealId, 'server-1');
      expect(meal.mealTime, MealTimeOption.breakfast);
      expect(meal.aggregatedFodmap, FodmapLoad.high);
      expect(meal.items.single.unit, MeasurementUnitOption.grams);
      expect(result.hasMore, isFalse);
    });

    test('descarta una entrada sin mealId o sin fecha', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'items': <dynamic>[
            <String, dynamic>{'mealTime': 'Lunch'},
            <String, dynamic>{'mealId': 'server-2'},
            <String, dynamic>{
              'mealId': 'server-3',
              'consumedAt': '2026-09-18T12:30:00Z',
            },
          ],
          'page': 1,
          'pageSize': 50,
          'totalCount': 3,
        }),
      );

      final result = await h.repository.history();

      expect(result.items, hasLength(1));
      expect(result.items.single.mealId, 'server-3');
    });

    test('SIEMPRE manda un rango, aunque no se lo pidan', () async {
      // El contrato declara `from` y `to` opcionales, pero el controlador los
      // recibe como `DateTime` **no nullable**: omitirlos los enlaza a
      // `0001-01-01` y la consulta filtra por un rango vacio. El endpoint
      // responde 200 con cero resultados, que parece un historial vacio.
      // Verificado contra el backend el 2026-09-18: sin rango totalCount da 0,
      // con rango da 8 sobre los mismos datos.
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'items': <dynamic>[],
          'page': 1,
          'pageSize': 50,
          'totalCount': 0,
        }),
      );

      await h.repository.history(now: DateTime.utc(2026, 9, 18, 12));

      final query = h.adapter.lastRequest.queryParameters;
      expect(query['from'], isNotNull);
      expect(query['to'], isNotNull);
      expect(query['from'], isNot(startsWith('0001')));
    });

    test('la ventana por defecto mira noventa dias hacia atras', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'items': <dynamic>[],
          'page': 1,
          'pageSize': 50,
          'totalCount': 0,
        }),
      );

      await h.repository.history(now: DateTime.utc(2026, 9, 18, 12));

      final query = h.adapter.lastRequest.queryParameters;
      expect(
        DateTime.parse(query['from']! as String).toUtc(),
        DateTime.utc(2026, 9, 18, 12).subtract(MealsRepository.defaultWindow),
      );
      // Un dia de margen hacia adelante, para no dejar afuera lo que el
      // paciente acaba de registrar.
      expect(
        DateTime.parse(query['to']! as String).toUtc(),
        DateTime.utc(2026, 9, 18, 12).add(MealsRepository.forwardMargin),
      );
    });

    test('un rango explicito manda', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'items': <dynamic>[],
          'page': 1,
          'pageSize': 50,
          'totalCount': 0,
        }),
      );

      await h.repository.history(
        from: DateTime.utc(2026, 9, 1),
        to: DateTime.utc(2026, 9, 15),
      );

      final query = h.adapter.lastRequest.queryParameters;
      expect(
        DateTime.parse(query['from']! as String).toUtc(),
        DateTime.utc(2026, 9, 1),
      );
      expect(
        DateTime.parse(query['to']! as String).toUtc(),
        DateTime.utc(2026, 9, 15),
      );
    });

    test('hasMore es true cuando quedan paginas', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'items': <dynamic>[],
          'page': 1,
          'pageSize': 50,
          'totalCount': 120,
        }),
      );

      expect((await h.repository.history()).hasMore, isTrue);
    });
  });
}
