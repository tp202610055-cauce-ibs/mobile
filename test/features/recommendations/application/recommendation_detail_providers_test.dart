import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/recommendations/application/recommendation_detail_providers.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation_origin.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_recommendations_repository.dart';
import '../../../helpers/fake_token_storage.dart';

Future<ProviderContainer> _container(
  FakeRecommendationsRepository repository,
) async {
  final container = ProviderContainer(
    overrides: <Override>[
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
      recommendationsRepositoryProvider.overrideWithValue(repository),
      recommendationRequestStoreProvider.overrideWithValue(
        InMemoryRecommendationRequestStore(),
      ),
    ],
  );
  addTearDown(container.dispose);
  await container.read(sessionNotifierProvider.notifier).loginSucceeded(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: demoUser,
      );
  return container;
}

/// Mantiene vivos los providers `autoDispose`, como lo haria la pantalla.
void _keepAlive(ProviderContainer container, String id) {
  container
    ..listen(recommendationDetailProvider(id), (_, __) {})
    ..listen(recommendationDeliveryProvider(id), (_, __) {});
}

void main() {
  group('recommendationDetailProvider', () {
    test('leer el detalle no entrega la recomendacion', () async {
      // Es lo que hace la tarjeta de la lista: una lectura silenciosa.
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail]);
      final container = await _container(repository);
      _keepAlive(container, approvedDetail.id);

      await container
          .read(recommendationDetailProvider(approvedDetail.id).future);

      expect(repository.deliveredIds, isEmpty);
    });
  });

  group('RecommendationOriginMemory · decision 10', () {
    test('una modificada vista antes de entregarse sigue siendo modificada',
        () async {
      final modified = approvedDetail.copyWith(
        status: RecommendationStatusOption.modifiedApproved,
      );
      final repository = FakeRecommendationsRepository(details: [modified]);
      final container = await _container(repository);
      _keepAlive(container, modified.id);

      await container.read(recommendationDetailProvider(modified.id).future);
      await container
          .read(recommendationDeliveryProvider(modified.id).notifier)
          .ensureDelivered();
      final delivered = await container
          .read(recommendationDetailProvider(modified.id).future);

      expect(delivered.status, RecommendationStatusOption.delivered);
      expect(delivered.origin, RecommendationOrigin.modified);
    });

    test('sin haberla visto antes, cae en la inferencia del contrato',
        () async {
      // Es lo que pasa tras reiniciar la app: la memoria dura la sesion.
      final delivered = approvedDetail.copyWith(
        status: RecommendationStatusOption.delivered,
      );
      final repository = FakeRecommendationsRepository(details: [delivered]);
      final container = await _container(repository);
      _keepAlive(container, delivered.id);

      final detail = await container
          .read(recommendationDetailProvider(delivered.id).future);

      expect(detail.knownOrigin, isNull);
      expect(detail.origin, RecommendationOrigin.system);
    });
  });

  group('RecommendationDelivery · decision 7', () {
    test('entrega una aprobada y refresca su detalle', () async {
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail]);
      final container = await _container(repository);
      _keepAlive(container, approvedDetail.id);

      await container
          .read(recommendationDeliveryProvider(approvedDetail.id).notifier)
          .ensureDelivered();
      final detail = await container
          .read(recommendationDetailProvider(approvedDetail.id).future);

      expect(repository.deliveredIds, <String>[approvedDetail.id]);
      expect(detail.status, RecommendationStatusOption.delivered);
      expect(
        container.read(recommendationDeliveryProvider(approvedDetail.id)),
        DeliveryStatus.settled,
      );
    });

    test('una ya entregada no se vuelve a entregar', () async {
      final delivered = approvedDetail.copyWith(
        status: RecommendationStatusOption.delivered,
      );
      final repository = FakeRecommendationsRepository(details: [delivered]);
      final container = await _container(repository);
      _keepAlive(container, delivered.id);

      await container
          .read(recommendationDeliveryProvider(delivered.id).notifier)
          .ensureDelivered();

      expect(repository.deliveredIds, isEmpty);
    });

    test('una segunda llamada en la misma apertura no hace nada', () async {
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail]);
      final container = await _container(repository);
      _keepAlive(container, approvedDetail.id);
      final notifier = container
          .read(recommendationDeliveryProvider(approvedDetail.id).notifier);

      await notifier.ensureDelivered();
      await notifier.ensureDelivered();

      expect(repository.deliveredIds, hasLength(1));
    });

    test('sin red queda sin entregar, para reintentar al reabrir', () async {
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail])
            ..deliveryError = const CauceApiError.network();
      final container = await _container(repository);
      _keepAlive(container, approvedDetail.id);

      await container
          .read(recommendationDeliveryProvider(approvedDetail.id).notifier)
          .ensureDelivered();

      expect(
        container.read(recommendationDeliveryProvider(approvedDetail.id)),
        DeliveryStatus.idle,
      );
    });

    test('vencida al entregar: se resuelve y el detalle pasa a no visible',
        () async {
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail])
            ..deliveryError = const CauceApiError.recommendationExpired();
      final container = await _container(repository);
      _keepAlive(container, approvedDetail.id);

      await container
          .read(recommendationDeliveryProvider(approvedDetail.id).notifier)
          .ensureDelivered();

      expect(
        container.read(recommendationDeliveryProvider(approvedDetail.id)),
        DeliveryStatus.settled,
      );
    });
  });
}
