import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/recommendations/application/recommendations_feed_notifier.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/recommendations/domain/pending_recommendation_request.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_recommendations_repository.dart';
import '../../../helpers/fake_token_storage.dart';

final DateTime _now = DateTime.utc(2026, 9, 24, 12);

GeneratedRecommendation _pendingResult({String id = 'rec-new'}) =>
    GeneratedRecommendation(
      id: id,
      status: RecommendationStatusOption.pendingReview,
      generatedAt: _now,
      expiresAt: _now.add(const Duration(hours: 72)),
    );

/// Contenedor con sesion del paciente demo, repositorio y marcador falsos.
Future<ProviderContainer> _container({
  required FakeRecommendationsRepository repository,
  required InMemoryRecommendationRequestStore store,
  DateTime Function()? clock,
}) async {
  final container = ProviderContainer(
    overrides: <Override>[
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
      recommendationsRepositoryProvider.overrideWithValue(repository),
      recommendationRequestStoreProvider.overrideWithValue(store),
      recommendationsClockProvider.overrideWithValue(clock ?? () => _now),
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

Future<RecommendationsFeed> _open(
  ProviderContainer container, {
  bool refresh = false,
}) async {
  await container
      .read(recommendationsFeedNotifierProvider.notifier)
      .openAdviceTab(refresh: refresh);
  return container.read(recommendationsFeedNotifierProvider).requireValue;
}

void main() {
  group('RecommendationsFeedNotifier · decision 2', () {
    test('con recomendaciones visibles no pide ninguna', () async {
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail]);
      final store = InMemoryRecommendationRequestStore();
      final container = await _container(repository: repository, store: store);

      final feed = await _open(container);

      expect(feed.summaries.map((s) => s.id), <String>[approvedDetail.id]);
      expect(repository.generationKeys, isEmpty);
      expect(store.value, isNull);
    });

    test('con la lista vacia pide una y guarda el marcador', () async {
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult());
      final store = InMemoryRecommendationRequestStore();
      final container = await _container(repository: repository, store: store);

      final feed = await _open(container);

      expect(repository.generationKeys, hasLength(1));
      expect(feed.awaitingReview, isTrue);
      expect(feed.generating, isFalse);
      final marker = store.value!;
      expect(marker.ownerUserId, demoUser.userId);
      expect(marker.recommendationId, 'rec-new');
      expect(marker.idempotencyKey, repository.generationKeys.single);
      expect(marker.expiresAt, _now.add(const Duration(hours: 72)));
    });

    test('reabrir Consejos con una en revision no pide otra', () async {
      // El backend no evita duplicados: esta guarda es la unica barrera.
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult());
      final store = InMemoryRecommendationRequestStore();
      final container = await _container(repository: repository, store: store);

      await _open(container);
      await _open(container, refresh: true);
      final feed = await _open(container, refresh: true);

      expect(repository.generationKeys, hasLength(1));
      expect(feed.awaitingReview, isTrue);
    });

    test('el marcador sobrevive a un reinicio de la app', () async {
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult());
      final store = InMemoryRecommendationRequestStore(
        PendingRecommendationRequest(
          ownerUserId: demoUser.userId,
          idempotencyKey: 'key-anterior',
          requestedAt: _now.subtract(const Duration(hours: 5)),
          recommendationId: 'rec-anterior',
          expiresAt: _now.add(const Duration(hours: 67)),
        ),
      );
      final container = await _container(repository: repository, store: store);

      final feed = await _open(container);

      expect(repository.generationKeys, isEmpty);
      expect(feed.awaitingReview, isTrue);
    });

    test('dos entradas simultaneas piden una sola vez', () async {
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult())
            ..generationDelay = const Duration(milliseconds: 20);
      final store = InMemoryRecommendationRequestStore();
      final container = await _container(repository: repository, store: store);
      final notifier = container.read(
        recommendationsFeedNotifierProvider.notifier,
      );

      await Future.wait(<Future<void>>[
        notifier.openAdviceTab(),
        notifier.openAdviceTab(refresh: true),
      ]);

      expect(repository.generationKeys, hasLength(1));
    });

    test('borra el marcador cuando la recomendacion aparece aprobada', () {
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail]);
      final store = InMemoryRecommendationRequestStore(
        PendingRecommendationRequest(
          ownerUserId: demoUser.userId,
          idempotencyKey: 'key-1',
          requestedAt: _now,
          recommendationId: approvedDetail.id,
          expiresAt: _now.add(const Duration(hours: 10)),
        ),
      );

      return _container(repository: repository, store: store)
          .then(_open)
          .then((feed) {
        expect(feed.awaitingReview, isFalse);
        expect(store.value, isNull);
      });
    });

    test('vencido el marcador, vuelve a pedir con una clave nueva', () async {
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult());
      final store = InMemoryRecommendationRequestStore(
        PendingRecommendationRequest(
          ownerUserId: demoUser.userId,
          idempotencyKey: 'key-vieja',
          requestedAt: _now.subtract(const Duration(hours: 80)),
          recommendationId: 'rec-vencida',
          expiresAt: _now.subtract(const Duration(hours: 8)),
        ),
      );
      final container = await _container(repository: repository, store: store);

      await _open(container);

      expect(repository.generationKeys, hasLength(1));
      expect(repository.generationKeys.single, isNot('key-vieja'));
      expect(store.value!.recommendationId, 'rec-new');
    });

    test('ignora el marcador de otra cuenta del dispositivo', () async {
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult());
      final store = InMemoryRecommendationRequestStore(
        PendingRecommendationRequest(
          ownerUserId: 'otro-paciente',
          idempotencyKey: 'key-ajena',
          requestedAt: _now,
          recommendationId: 'rec-ajena',
          expiresAt: _now.add(const Duration(hours: 60)),
        ),
      );
      final container = await _container(repository: repository, store: store);

      await _open(container);

      expect(repository.generationKeys, hasLength(1));
      expect(store.value!.ownerUserId, demoUser.userId);
    });

    test('los 422 de negocio no se muestran y no dejan marcador', () async {
      for (final error in <CauceApiError>[
        const CauceApiError.insufficientClinicalHistory(),
        const CauceApiError.allCandidatesFilteredByAllergies(),
        const CauceApiError.noActiveModelVersion(),
        const CauceApiError.patientProfileNotFound(),
      ]) {
        final repository = FakeRecommendationsRepository()
          ..generationError = error;
        final store = InMemoryRecommendationRequestStore();
        final container =
            await _container(repository: repository, store: store);

        final feed = await _open(container);

        expect(feed.generationError, isNull, reason: '$error');
        expect(feed.awaitingReview, isFalse, reason: '$error');
        expect(store.value, isNull, reason: '$error');
      }
    });

    test('sin red se muestra el error y el reintento repite la clave',
        () async {
      // Si el pedido llego y se perdio la respuesta, repetir la clave hace
      // que el servidor devuelva la misma recomendacion en vez de otra.
      final repository = FakeRecommendationsRepository()
        ..generationError = const CauceApiError.network();
      final store = InMemoryRecommendationRequestStore();
      final container = await _container(repository: repository, store: store);

      final failed = await _open(container);
      expect(failed.generationError, isA<NetworkError>());
      expect(store.value!.recommendationId, isNull);

      repository
        ..generationError = null
        ..generationResult = _pendingResult();
      final retried = await _open(container, refresh: true);

      expect(repository.generationKeys, hasLength(2));
      expect(repository.generationKeys.last, repository.generationKeys.first);
      expect(retried.awaitingReview, isTrue);
      expect(retried.generationError, isNull);
    });

    test('un error que no es de red se muestra y no conserva la clave',
        () async {
      final repository = FakeRecommendationsRepository()
        ..generationError = const CauceApiError.forbidden();
      final store = InMemoryRecommendationRequestStore();
      final container = await _container(repository: repository, store: store);

      final feed = await _open(container);

      expect(feed.generationError, isA<ForbiddenError>());
      expect(store.value, isNull);
    });

    test('una auto-aprobada se lista de inmediato, sin aviso', () async {
      final repository = FakeRecommendationsRepository(
        generationResult: GeneratedRecommendation(
          id: approvedDetail.id,
          status: RecommendationStatusOption.approved,
          generatedAt: _now,
        ),
      );
      final store = InMemoryRecommendationRequestStore();
      final container = await _container(repository: repository, store: store);

      await container
          .read(recommendationsFeedNotifierProvider.notifier)
          .openAdviceTab();
      repository.put(approvedDetail);
      final feed =
          await container.read(recommendationsFeedNotifierProvider.future);

      expect(feed.summaries.map((s) => s.id), <String>[approvedDetail.id]);
      expect(feed.awaitingReview, isFalse);
      expect(store.value, isNull);
    });

    test('leer el estado desde Inicio no pide nada', () async {
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult());
      final store = InMemoryRecommendationRequestStore();
      final container = await _container(repository: repository, store: store);

      await container.read(recommendationsFeedNotifierProvider.future);

      expect(repository.generationKeys, isEmpty);
    });
  });

  group('pendingRecommendationRequestProvider · decision 1', () {
    test('expone la recomendacion en revision', () async {
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult());
      final store = InMemoryRecommendationRequestStore();
      final container = await _container(repository: repository, store: store);

      await _open(container);
      final pending =
          await container.read(pendingRecommendationRequestProvider.future);

      expect(pending?.recommendationId, 'rec-new');
    });

    test('sin red sigue en pie, porque lee el marcador local', () async {
      final repository = FakeRecommendationsRepository()
        ..listError = const CauceApiError.network();
      final store = InMemoryRecommendationRequestStore(
        PendingRecommendationRequest(
          ownerUserId: demoUser.userId,
          idempotencyKey: 'key-1',
          requestedAt: _now,
          recommendationId: 'rec-pending',
          expiresAt: _now.add(const Duration(hours: 10)),
        ),
      );
      final container = await _container(repository: repository, store: store);

      // La lista falla primero, como en pantalla sin conexion. El aviso se lee
      // despues, cuando el feed ya se asento.
      await expectLater(
        container.read(recommendationsFeedNotifierProvider.future),
        throwsA(isA<NetworkError>()),
      );
      final pending =
          await container.read(pendingRecommendationRequestProvider.future);

      expect(pending?.recommendationId, 'rec-pending');
    });

    test('un pedido en curso sin resultado no es "en revision"', () async {
      final store = InMemoryRecommendationRequestStore(
        PendingRecommendationRequest(
          ownerUserId: demoUser.userId,
          idempotencyKey: 'key-1',
          requestedAt: _now,
        ),
      );
      final container = await _container(
        repository: FakeRecommendationsRepository(),
        store: store,
      );

      expect(
        await container.read(pendingRecommendationRequestProvider.future),
        isNull,
      );
    });
  });
}
