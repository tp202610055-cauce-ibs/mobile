import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/custom_foods/data/custom_foods_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';

const String _foodId = 'f-queso-fresco';

/// Arma el repositorio sobre el cliente OpenAPI real, con la red sustituida.
({CustomFoodsRepository repository, CannedHttpAdapter adapter}) _harness(
  CannedResponse response, {
  bool withFoodsApi = true,
}) {
  final adapter = CannedHttpAdapter(response);
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(dio: dio, interceptors: const <Interceptor>[]);
  return (
    repository: CustomFoodsRepository(
      client.getCustomFoodsApi(),
      withFoodsApi ? client.getFoodsApi() : null,
    ),
    adapter: adapter,
  );
}

Map<String, dynamic> _check({
  required bool conflict,
  List<String>? allergens,
}) =>
    <String, dynamic>{
      'foodId': _foodId,
      'foodName': 'Queso fresco',
      'hasAllergenConflict': conflict,
      'allergens': allergens,
    };

void main() {
  group('CustomFoodsRepository · allergenConflicts (HU0010 CA03, CP027)', () {
    test('pide el chequeo del ingrediente elegido', () async {
      final h = _harness(CannedResponse.ok(_check(conflict: false)));

      await h.repository.allergenConflicts(_foodId);

      final request = h.adapter.lastRequest;
      expect(request.method, 'GET');
      expect(request.path, endsWith('/api/v1/foods/$_foodId/allergen-check'));
    });

    test('con conflicto devuelve las alergias declaradas que choca', () async {
      final h = _harness(
        CannedResponse.ok(
          _check(conflict: true, allergens: <String>['Lactosa']),
        ),
      );

      expect(
        await h.repository.allergenConflicts(_foodId),
        <String>['Lactosa'],
      );
    });

    test('sin conflicto devuelve vacia aunque lleguen alergenos', () async {
      final h = _harness(
        CannedResponse.ok(
          _check(conflict: false, allergens: <String>['Lactosa']),
        ),
      );

      expect(await h.repository.allergenConflicts(_foodId), isEmpty);
    });

    test('con conflicto pero sin lista devuelve vacia', () async {
      final h = _harness(CannedResponse.ok(_check(conflict: true)));

      expect(await h.repository.allergenConflicts(_foodId), isEmpty);
    });

    test('sin API de alimentos no sale a la red', () async {
      final h = _harness(
        CannedResponse.ok(_check(conflict: true, allergens: <String>['x'])),
        withFoodsApi: false,
      );

      expect(await h.repository.allergenConflicts(_foodId), isEmpty);
      expect(h.adapter.requests, isEmpty);
    });

    test('un fallo del servidor llega como CauceApiError', () async {
      final h = _harness(
        CannedResponse.problem(statusCode: 404, errorCode: 'food_not_found'),
      );

      await expectLater(
        h.repository.allergenConflicts(_foodId),
        throwsA(isA<CauceApiError>()),
      );
    });
  });
}
