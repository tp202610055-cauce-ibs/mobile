import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/recommendations/application/recommendation_feedback_notifier.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_feedback_outbox_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/recommendations/domain/pending_recommendation_feedback.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_recommendations_repository.dart';
import '../../../helpers/fake_token_storage.dart';
import '../../../helpers/sync_fixtures.dart';

final RecommendationDetail _delivered = approvedDetail.copyWith(
  status: RecommendationStatusOption.delivered,
);

const String _otherUserId = 'e1f2a3b4-0000-0000-0000-000000000000';

typedef _Harness = ({
  ProviderContainer container,
  RecommendationFeedbackForm notifier,
  RecommendationFeedbackOutboxStore outbox,
  FakeConnectivityMonitor connectivity,
});

Future<_Harness> _harness(
  FakeRecommendationsRepository repository, {
  bool online = true,
}) async {
  final database = AppDatabase.memory();
  addTearDown(database.close);
  final connectivity = FakeConnectivityMonitor(online: online);
  addTearDown(connectivity.dispose);
  final container = ProviderContainer(
    overrides: <Override>[
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
      recommendationsRepositoryProvider.overrideWithValue(repository),
      recommendationRequestStoreProvider.overrideWithValue(
        InMemoryRecommendationRequestStore(),
      ),
      appDatabaseProvider.overrideWithValue(database),
      connectivityMonitorProvider.overrideWithValue(connectivity),
    ],
  );
  addTearDown(container.dispose);
  await container.read(sessionNotifierProvider.notifier).loginSucceeded(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: demoUser,
      );
  final provider = recommendationFeedbackFormProvider(_delivered.id);
  container.listen(provider, (_, __) {});
  return (
    container: container,
    notifier: container.read(provider.notifier),
    outbox: container.read(recommendationFeedbackOutboxStoreProvider),
    connectivity: connectivity,
  );
}

void _answer(RecommendationFeedbackForm notifier) {
  notifier
    ..setApplied(true)
    ..setOutcome(FeedbackOutcomeOption.improvement)
    ..setComment('  Menos hinchazón en las noches  ');
}

RecommendationFeedbackFormState _state(_Harness h) =>
    h.container.read(recommendationFeedbackFormProvider(_delivered.id));

void main() {
  group('RecommendationFeedbackForm · HU0016 CA1 (CP043)', () {
    test('no envia sin las dos respuestas obligatorias', () async {
      final repository = FakeRecommendationsRepository(details: [_delivered]);
      final h = await _harness(repository);

      h.notifier.setApplied(true);

      expect(await h.notifier.submit(), isFalse);
      expect(repository.feedbackKeys, isEmpty);
    });

    test('envia la respuesta completa, sin compuerta de 24 h', () async {
      final repository = FakeRecommendationsRepository(details: [_delivered]);
      final h = await _harness(repository);

      _answer(h.notifier);
      final ok = await h.notifier.submit();

      expect(ok, isTrue);
      final draft = repository.feedbackDrafts.single;
      expect(draft.wasApplied, isTrue);
      expect(draft.outcome, FeedbackOutcomeOption.improvement);
      expect(draft.commentToSend, 'Menos hinchazón en las noches');
      expect(_state(h).sent, isTrue);
      expect(_state(h).queued, isFalse);
      expect(_state(h).pendingKey, isNull);
      expect(await h.outbox.pending(userId: demoUser.userId), isEmpty);
    });

    test('un fallo del servidor conserva la clave para el reintento', () async {
      final repository = FakeRecommendationsRepository(details: [_delivered])
        ..feedbackError = const CauceApiError.unknown(statusCode: 500);
      final h = await _harness(repository);

      _answer(h.notifier);
      expect(await h.notifier.submit(), isFalse);
      expect(_state(h).error, isA<UnknownError>());
      expect(_state(h).draft.outcome, FeedbackOutcomeOption.improvement);

      repository.feedbackError = null;
      expect(await h.notifier.submit(), isTrue);

      expect(repository.feedbackKeys, hasLength(2));
      expect(repository.feedbackKeys.last, repository.feedbackKeys.first);
      expect(await h.outbox.pending(userId: demoUser.userId), isEmpty);
    });

    test('cambiar la respuesta despues de un fallo genera otra clave',
        () async {
      // La misma clave con otra carga daria 409 idempotency_mismatch.
      final repository = FakeRecommendationsRepository(details: [_delivered])
        ..feedbackError = const CauceApiError.unknown(statusCode: 500);
      final h = await _harness(repository);

      _answer(h.notifier);
      await h.notifier.submit();
      h.notifier.setOutcome(FeedbackOutcomeOption.noChange);
      await h.notifier.submit();

      expect(repository.feedbackKeys, hasLength(2));
      expect(
        repository.feedbackKeys.last,
        isNot(repository.feedbackKeys.first),
      );
    });

    test('409 conflict_state queda como error del formulario', () async {
      final repository = FakeRecommendationsRepository(details: [_delivered])
        ..feedbackError = const CauceApiError.conflictState();
      final h = await _harness(repository);

      _answer(h.notifier);

      expect(await h.notifier.submit(), isFalse);
      expect(_state(h).error, isA<ConflictStateError>());
    });
  });

  group('RecommendationFeedbackForm · sin conexion (HU0016 CA2, CP044)', () {
    test('sin red al pulsar enviar la guarda en el telefono sin llamar',
        () async {
      final repository = FakeRecommendationsRepository(details: [_delivered]);
      final h = await _harness(repository, online: false);

      _answer(h.notifier);
      final ok = await h.notifier.submit();

      expect(ok, isTrue);
      expect(repository.feedbackKeys, isEmpty);
      expect(_state(h).queued, isTrue);
      expect(_state(h).submitting, isFalse);
      final row = (await h.outbox.pending(userId: demoUser.userId)).single;
      expect(row.recommendationId, _delivered.id);
      expect(row.wasApplied, isTrue);
      expect(row.outcome, FeedbackOutcomeOption.improvement);
      expect(row.comment, 'Menos hinchazón en las noches');
      expect(row.idempotencyKey, isNotEmpty);
    });

    test('un fallo de red al enviar la guarda con la clave del intento',
        () async {
      final repository = FakeRecommendationsRepository(details: [_delivered])
        ..feedbackError = const CauceApiError.network();
      final h = await _harness(repository);

      _answer(h.notifier);
      final ok = await h.notifier.submit();

      expect(ok, isTrue);
      expect(_state(h).queued, isTrue);
      expect(_state(h).error, isNull);
      final row = (await h.outbox.pending(userId: demoUser.userId)).single;
      expect(row.idempotencyKey, repository.feedbackKeys.single);
    });

    test('sin red no guarda una respuesta que no cumple la validacion',
        () async {
      final repository = FakeRecommendationsRepository(details: [_delivered]);
      final h = await _harness(repository, online: false);

      _answer(h.notifier);
      h.notifier.setComment('x' * 501);

      expect(await h.notifier.submit(), isFalse);
      expect(await h.outbox.pending(userId: demoUser.userId), isEmpty);
    });

    test('la respuesta guardada no existe para otra cuenta', () async {
      final repository = FakeRecommendationsRepository(details: [_delivered]);
      final h = await _harness(repository, online: false);

      _answer(h.notifier);
      await h.notifier.submit();

      expect(await h.outbox.pending(userId: _otherUserId), isEmpty);
      expect(
        await h.outbox.watch(_delivered.id, userId: _otherUserId).first,
        isNull,
      );
    });

    test('responder de nuevo borra la rechazada y genera otra clave', () async {
      final repository = FakeRecommendationsRepository(details: [_delivered]);
      final h = await _harness(repository);
      await h.outbox.save(
        PendingRecommendationFeedback(
          recommendationId: _delivered.id,
          idempotencyKey: 'clave-rechazada',
          wasApplied: true,
          outcome: FeedbackOutcomeOption.noChange,
          createdAt: DateTime.utc(2026, 9, 22),
        ),
        userId: demoUser.userId,
      );
      await h.outbox.markRejected(
        _delivered.id,
        userId: demoUser.userId,
        errorCode: 'validation_error',
      );

      await h.notifier.answerAgain();
      _answer(h.notifier);
      await h.notifier.submit();

      expect(
        await h.outbox.watch(_delivered.id, userId: demoUser.userId).first,
        isNull,
      );
      expect(repository.feedbackKeys.single, isNot('clave-rechazada'));
    });
  });
}
