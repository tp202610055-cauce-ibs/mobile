import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/domain/pending_recommendation_request.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

final PendingRecommendationRequest _marker = PendingRecommendationRequest(
  ownerUserId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  idempotencyKey: '11111111-2222-4333-8444-555555555555',
  requestedAt: DateTime.utc(2026, 9, 24, 12),
  recommendationId: 'rec-1',
  expiresAt: DateTime.utc(2026, 9, 27, 12),
);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('SecureRecommendationRequestStore · serializacion', () {
    test('va y vuelve sin perder nada', () {
      final raw = SecureRecommendationRequestStore.encode(_marker);

      expect(SecureRecommendationRequestStore.decode(raw), _marker);
    });

    test('un pedido en curso, sin resultado, tambien', () {
      final inFlight = _marker.copyWith(
        recommendationId: null,
        expiresAt: null,
      );
      final raw = SecureRecommendationRequestStore.encode(inFlight);

      expect(SecureRecommendationRequestStore.decode(raw), inFlight);
    });

    test('un valor corrupto se lee como ausente, sin lanzar', () {
      for (final raw in <String>[
        'no es json',
        '[]',
        '{"ownerUserId": 7}',
        '{"ownerUserId": "a", "idempotencyKey": "b"}',
      ]) {
        expect(
          SecureRecommendationRequestStore.decode(raw),
          isNull,
          reason: raw,
        );
      }
    });
  });

  group('SecureRecommendationRequestStore · almacenamiento', () {
    test('escribe, lee y borra bajo su propia clave', () async {
      FlutterSecureStorage.setMockInitialValues(<String, String>{});
      final store = SecureRecommendationRequestStore(
        const FlutterSecureStorage(),
      );

      await store.write(_marker);
      expect(await store.read(), _marker);

      await store.clear();
      expect(await store.read(), isNull);
    });

    test('no toca las claves de la sesion', () async {
      FlutterSecureStorage.setMockInitialValues(<String, String>{
        'auth_access_token': 'access-1',
      });
      const storage = FlutterSecureStorage();
      final store = SecureRecommendationRequestStore(storage);

      await store.write(_marker);
      await store.clear();

      expect(await storage.read(key: 'auth_access_token'), 'access-1');
    });
  });
}
