import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/recommendations/application/recommendation_feedback_notifier.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_recommendations_repository.dart';
import '../../../helpers/fake_token_storage.dart';

final RecommendationDetail _delivered = approvedDetail.copyWith(
  status: RecommendationStatusOption.delivered,
);

Future<
    ({
      ProviderContainer container,
      RecommendationFeedbackForm notifier,
    })> _harness(FakeRecommendationsRepository repository) async {
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
  final provider = recommendationFeedbackFormProvider(_delivered.id);
  container.listen(provider, (_, __) {});
  return (container: container, notifier: container.read(provider.notifier));
}

void _answer(RecommendationFeedbackForm notifier) {
  notifier
    ..setApplied(true)
    ..setOutcome(FeedbackOutcomeOption.improvement)
    ..setComment('Menos hinchazón en las noches');
}

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
      // Decision 9: el backend no exige esperar; se envia en cuanto se
      // completa, aunque la entrega haya sido recien.
      final repository = FakeRecommendationsRepository(details: [_delivered]);
      final h = await _harness(repository);

      _answer(h.notifier);
      final ok = await h.notifier.submit();

      expect(ok, isTrue);
      final draft = repository.feedbackDrafts.single;
      expect(draft.wasApplied, isTrue);
      expect(draft.outcome, FeedbackOutcomeOption.improvement);
      expect(draft.commentToSend, 'Menos hinchazón en las noches');
      final state =
          h.container.read(recommendationFeedbackFormProvider(_delivered.id));
      expect(state.sent, isTrue);
      expect(state.pendingKey, isNull);
    });

    test('sin red: el reintento repite la misma clave y lo escrito', () async {
      // Decision 8: solo en linea, sin cola local.
      final repository = FakeRecommendationsRepository(details: [_delivered])
        ..feedbackError = const CauceApiError.network();
      final h = await _harness(repository);

      _answer(h.notifier);
      expect(await h.notifier.submit(), isFalse);
      final failed =
          h.container.read(recommendationFeedbackFormProvider(_delivered.id));
      expect(failed.error, isA<NetworkError>());
      expect(failed.draft.outcome, FeedbackOutcomeOption.improvement);

      repository.feedbackError = null;
      expect(await h.notifier.submit(), isTrue);

      expect(repository.feedbackKeys, hasLength(2));
      expect(repository.feedbackKeys.last, repository.feedbackKeys.first);
    });

    test('cambiar la respuesta despues de un fallo genera otra clave',
        () async {
      // La misma clave con otra carga daria 409 idempotency_mismatch.
      final repository = FakeRecommendationsRepository(details: [_delivered])
        ..feedbackError = const CauceApiError.network();
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
      expect(
        h.container
            .read(recommendationFeedbackFormProvider(_delivered.id))
            .error,
        isA<ConflictStateError>(),
      );
    });
  });
}
