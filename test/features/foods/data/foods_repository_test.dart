import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/foods/data/foods_repository.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';

/// Arma el repositorio sobre el cliente OpenAPI real, con la red sustituida.
///
/// Mismo harness que usan `AuthRepository` y `PatientsRepository`: ejercita el
/// camino completo, incluida la deserializacion `built_value`, que es donde se
/// detecta que el contrato y el cliente dejaron de coincidir.
({FoodsRepository repository, CannedHttpAdapter adapter}) _harness(
  CannedHttpAdapter adapter,
) {
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(dio: dio, interceptors: const <Interceptor>[]);
  return (repository: FoodsRepository(client.getFoodsApi()), adapter: adapter);
}

Map<String, dynamic> _summaryJson(String id, String name) {
  return <String, dynamic>{
    'foodId': id,
    'name': name,
    'category': 'cereales',
    'fodmapLevel': 'Low',
    'isPeruvian': true,
  };
}

Map<String, dynamic> _page(
  List<Map<String, dynamic>> items, {
  required int page,
  required int totalCount,
}) {
  return <String, dynamic>{
    'items': items,
    'page': page,
    'pageSize': 100,
    'totalCount': totalCount,
  };
}

void main() {
  group('FoodsRepository · recorrido paginado del catalogo', () {
    test('junta todas las paginas en una sola lista', () async {
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/foods': <CannedResponse>[
          CannedResponse.ok(
            _page(
              <Map<String, dynamic>>[
                for (var i = 0; i < 100; i++)
                  _summaryJson('p1-$i', 'Alimento $i'),
              ],
              page: 1,
              totalCount: 150,
            ),
          ),
          CannedResponse.ok(
            _page(
              <Map<String, dynamic>>[
                for (var i = 0; i < 50; i++)
                  _summaryJson('p2-$i', 'Alimento $i'),
              ],
              page: 2,
              totalCount: 150,
            ),
          ),
        ],
      });
      final h = _harness(adapter);

      final catalog = await h.repository.fetchCatalog();

      expect(catalog, hasLength(150));
      expect(h.adapter.requestsFor('GET', '/api/v1/foods'), hasLength(2));
    });

    test('con una sola pagina no pide una segunda', () async {
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/foods': CannedResponse.ok(
          _page(
            <Map<String, dynamic>>[_summaryJson('f1', 'Arroz blanco cocido')],
            page: 1,
            totalCount: 1,
          ),
        ),
      });
      final h = _harness(adapter);

      final catalog = await h.repository.fetchCatalog();

      expect(catalog, hasLength(1));
      expect(h.adapter.requestsFor('GET', '/api/v1/foods'), hasLength(1));
    });

    test('una pagina vacia corta el recorrido', () async {
      // Protege contra un `totalCount` inconsistente, que sin este corte
      // dejaria al cliente pidiendo paginas hasta el tope de seguridad.
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/foods': <CannedResponse>[
          CannedResponse.ok(
            _page(
              <Map<String, dynamic>>[_summaryJson('f1', 'Arroz')],
              page: 1,
              totalCount: 9999,
            ),
          ),
          CannedResponse.ok(
            _page(<Map<String, dynamic>>[], page: 2, totalCount: 9999),
          ),
        ],
      });
      final h = _harness(adapter);

      final catalog = await h.repository.fetchCatalog();

      expect(catalog, hasLength(1));
      expect(h.adapter.requestsFor('GET', '/api/v1/foods'), hasLength(2));
    });

    test('traduce el resumen al dominio', () async {
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/foods': CannedResponse.ok(
          _page(
            <Map<String, dynamic>>[
              <String, dynamic>{
                'foodId': 'f1',
                'name': 'Pan de trigo blanco',
                'category': 'cereales',
                'fodmapLevel': 'High',
                'isPeruvian': false,
              },
            ],
            page: 1,
            totalCount: 1,
          ),
        ),
      });
      final h = _harness(adapter);

      final item = (await h.repository.fetchCatalog()).single;

      expect(item.foodId, 'f1');
      expect(item.name, 'Pan de trigo blanco');
      expect(item.category, 'cereales');
      expect(item.fodmapLevel, FodmapLoad.high);
      expect(item.isPeruvian, isFalse);
      // El listado devuelve resumenes: la composicion llega con el detalle.
      expect(item.hasNutrition, isFalse);
    });

    test('descarta la entrada sin foodId o sin name sin tumbar el refresco',
        () async {
      // Mismo criterio que `PatientsRepository` con el catalogo de alergias:
      // una fila corrupta no debe costar el catalogo entero.
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/foods': CannedResponse.ok(
          _page(
            <Map<String, dynamic>>[
              <String, dynamic>{'name': 'Sin identificador'},
              <String, dynamic>{'foodId': 'f2'},
              <String, dynamic>{'foodId': 'f3', 'name': ''},
              _summaryJson('f4', 'Arroz blanco cocido'),
            ],
            page: 1,
            totalCount: 4,
          ),
        ),
      });
      final h = _harness(adapter);

      final catalog = await h.repository.fetchCatalog();

      expect(catalog, hasLength(1));
      expect(catalog.single.foodId, 'f4');
    });

    test('traduce un 401 a CauceApiError', () async {
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/foods': CannedResponse.problem(
          statusCode: 401,
          errorCode: 'invalid_refresh_token',
        ),
      });
      final h = _harness(adapter);

      await expectLater(
        h.repository.fetchCatalog(),
        throwsA(isA<InvalidRefreshTokenError>()),
      );
    });
  });

  group('FoodsRepository · detalle de un alimento', () {
    test('trae la composicion nutricional completa', () async {
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/foods/f1': const CannedResponse.ok(<String, dynamic>{
          'foodId': 'f1',
          'name': 'Plátano de la isla maduro',
          'category': 'frutas',
          'caloriesPer100g': 89.0,
          'proteinGPer100g': 1.1,
          'carbsGPer100g': 22.8,
          'fatGPer100g': 0.3,
          'fiberGPer100g': 2.6,
          'fodmapLevel': 'Low',
          'fodmapTags': 'fructans,polyols',
          'isPeruvian': true,
          'isActive': true,
        }),
      });
      final h = _harness(adapter);

      final item = await h.repository.fetchDetail('f1');

      expect(item.hasNutrition, isTrue);
      expect(item.nutrition?.caloriesPer100g, 89.0);
      expect(item.nutrition?.fiberGPer100g, 2.6);
      expect(item.nutrition?.fodmapTagList, <String>['fructans', 'polyols']);
      expect(item.fodmapLevel, FodmapLoad.low);
    });

    test('un detalle sin foodId o sin name no se acepta a medias', () async {
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/foods/f1': const CannedResponse.ok(<String, dynamic>{
          'category': 'frutas',
          'caloriesPer100g': 89.0,
        }),
      });
      final h = _harness(adapter);

      await expectLater(
        h.repository.fetchDetail('f1'),
        throwsA(isA<UnknownError>()),
      );
    });

    test('traduce el 404 del contrato', () async {
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/foods/f9': CannedResponse.problem(
          statusCode: 404,
          errorCode: 'food_item_not_found',
        ),
      });
      final h = _harness(adapter);

      await expectLater(
        h.repository.fetchDetail('f9'),
        throwsA(isA<FoodItemNotFoundError>()),
      );
    });

    test('sin etiquetas FODMAP la lista queda vacia, no null', () async {
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/foods/f1': const CannedResponse.ok(<String, dynamic>{
          'foodId': 'f1',
          'name': 'Pollo a la plancha',
          'category': 'proteinas',
          'caloriesPer100g': 165.0,
          'proteinGPer100g': 31.0,
          'carbsGPer100g': 0.0,
          'fatGPer100g': 3.6,
          'fiberGPer100g': 0.0,
          'fodmapLevel': 'Low',
          'isPeruvian': false,
          'isActive': true,
        }),
      });
      final h = _harness(adapter);

      final item = await h.repository.fetchDetail('f1');

      expect(item.nutrition?.fodmapTags, isNull);
      expect(item.nutrition?.fodmapTagList, isEmpty);
    });
  });
}
