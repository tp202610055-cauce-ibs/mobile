import 'package:cauce_mobile/core/onboarding/onboarding_draft_store.dart';
import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/push/push_messaging.dart';
import 'package:cauce_mobile/core/push/push_permission.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/recommendations/application/recommendations_feed_notifier.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_feedback_outbox_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/recommendations/domain/pending_recommendation_feedback.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/presentation/recommendation_detail_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../helpers/fake_onboarding_draft_store.dart';
import '../helpers/app_borders.dart';
import '../helpers/fake_auth_repository.dart';
import '../helpers/fake_ibs_sss_repository.dart';
import '../helpers/fake_patients_repository.dart';
import '../helpers/fake_push_messaging.dart';
import '../helpers/fake_recommendations_repository.dart';
import '../helpers/fake_token_storage.dart';

/// La respuesta a una recomendacion desde la raiz: la invitacion lleva al
/// formulario (CP043, CP044) y sin red la respuesta sale sola al reconectar.

final AppLocalizations _l10n = AppLocalizationsEs();

final DateTime _now = DateTime.utc(2026, 9, 24, 12);

/// «Reducir cebolla y ajo», entregada hace 30 horas y sin respuesta.
final RecommendationDetail _received = approvedDetail.copyWith(
  id: 'f1e2d3c4-0000-4000-8000-000000000044',
  status: RecommendationStatusOption.delivered,
  reviewedAt: _now.subtract(const Duration(hours: 31)),
  deliveredAt: _now.subtract(const Duration(hours: 30)),
);

typedef _Harness = ({ProviderContainer container, AppBorders borders});

Future<_Harness> _pumpApp(
  WidgetTester tester,
  FakeRecommendationsRepository server,
) async {
  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: demoUser,
  );
  final borders = appBorders(storage: storage);
  final push = FakePushMessaging();
  addTearDown(push.dispose);

  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(storage),
      pushMessagingProvider.overrideWithValue(push),
      pushPermissionStoreProvider
          .overrideWithValue(MemoryPushPermissionStore()),
      onboardingDraftStoreProvider
          .overrideWithValue(FakeOnboardingDraftStore()),
      patientsRepositoryProvider.overrideWithValue(
        FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      ),
      ibsSssRepositoryProvider.overrideWithValue(FakeIbsSssRepository()),
      recommendationsRepositoryProvider.overrideWithValue(server),
      recommendationRequestStoreProvider.overrideWithValue(
        InMemoryRecommendationRequestStore(),
      ),
      recommendationsClockProvider.overrideWithValue(() => _now),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  await tester.tap(find.byKey(const Key('nav_advice')));
  await tester.pumpAndSettle();
  return (container: container, borders: borders);
}

Finder get _invite =>
    find.byKey(Key('recommendation_feedback_invite_${_received.id}'));

Finder get _cardPending =>
    find.byKey(Key('recommendation_feedback_pending_${_received.id}'));

Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _backToAdvice(WidgetTester tester) async {
  GoRouter.of(tester.element(find.byType(RecommendationDetailScreen))).pop();
  await tester.pumpAndSettle();
}

/// `true` si el formulario de respuesta empieza dentro de la pantalla.
bool _formOnScreen(WidgetTester tester) {
  final form = find.byKey(const Key('recommendation_feedback_form'));
  if (form.evaluate().isEmpty) {
    return false;
  }
  final top = tester.getTopLeft(form).dy;
  final screen = tester.view.physicalSize.height / tester.view.devicePixelRatio;
  return top >= 0 && top < screen;
}

double _detailOffset(WidgetTester tester) {
  final scrollable = find.descendant(
    of: find.byType(RecommendationDetailScreen),
    matching: find.byType(Scrollable),
  );
  return tester.state<ScrollableState>(scrollable.first).position.pixels;
}

void main() {
  group('La invitacion lleva al formulario (CP043 paso 3, CP044 paso 2)', () {
    testWidgets('abrirla desde Consejos deja el formulario a la vista',
        (tester) async {
      final server = FakeRecommendationsRepository(details: [_received]);
      await _pumpApp(tester, server);

      await tester.tap(_invite);
      await tester.pumpAndSettle();

      expect(find.byType(RecommendationDetailScreen), findsOneWidget);
      expect(_formOnScreen(tester), isTrue);
    });

    testWidgets('abrir la tarjeta sin invitacion no desplaza', (tester) async {
      final answered = _received.copyWith(
        status: RecommendationStatusOption.feedbackReceived,
        feedback: RecommendationFeedback(
          wasApplied: true,
          outcome: FeedbackOutcomeOption.improvement,
          submittedAt: _now,
        ),
      );
      final server = FakeRecommendationsRepository(details: [answered]);
      await _pumpApp(tester, server);

      await tester.tap(find.byKey(Key('recommendation_card_${answered.id}')));
      await tester.pumpAndSettle();

      expect(_detailOffset(tester), 0);
    });

    testWidgets('con el formulario ya a la vista no desplaza', (tester) async {
      tester.view.physicalSize = const Size(1080, 9000);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      final server = FakeRecommendationsRepository(details: [_received]);
      await _pumpApp(tester, server);

      await tester.tap(_invite);
      await tester.pumpAndSettle();

      expect(_formOnScreen(tester), isTrue);
      expect(_detailOffset(tester), 0);
    });
  });

  group('CP044 · respuesta sin conexion, desde la raiz', () {
    testWidgets('queda pendiente, sale sola al volver la red y una sola vez',
        (tester) async {
      final server = FakeRecommendationsRepository(details: [_received]);
      final h = await _pumpApp(tester, server);
      expect(_invite, findsOneWidget);

      // Pasos 2 y 3: abre la invitacion y el telefono queda sin red.
      await tester.tap(_invite);
      await tester.pumpAndSettle();
      h.borders.connectivity.online = false;

      // Pasos 4 a 6: Si, Siguen igual, enviar.
      await _tapVisible(
        tester,
        find.text(_l10n.recommendationFeedbackAppliedYes),
      );
      await _tapVisible(
        tester,
        find.text(_l10n.recommendationFeedbackOutcomeNoChange),
      );
      await _tapVisible(
        tester,
        find.byKey(const Key('recommendation_feedback_submit')),
      );

      // Paso 7: registrada y pendiente de envio, en el detalle y en la tarjeta.
      expect(find.text(_l10n.recommendationFeedbackQueued), findsOneWidget);
      expect(
        find.byKey(const Key('recommendation_feedback_pending')),
        findsOneWidget,
      );
      expect(server.feedbackKeys, isEmpty);
      await _backToAdvice(tester);
      expect(_cardPending, findsOneWidget);
      expect(_invite, findsNothing);

      // Paso 8: vuelve la red y nadie toca nada.
      h.borders.connectivity.emitReconnection();
      await tester.pumpAndSettle();

      // Paso 9: ya no pide respuesta ni queda la marca.
      expect(_cardPending, findsNothing);
      expect(_invite, findsNothing);

      // Paso 10: una sola carga, con la clave guardada.
      expect(server.feedbackDrafts, hasLength(1));
      final sent = server.feedbackDrafts.single;
      expect(sent.wasApplied, isTrue);
      expect(sent.outcome, FeedbackOutcomeOption.noChange);
      expect(sent.commentToSend, isNull);
      final outbox = RecommendationFeedbackOutboxStore(h.borders.database);
      expect(await outbox.pending(userId: demoUser.userId), isEmpty);
    });

    testWidgets('cada reintento manda la misma clave', (tester) async {
      final server = FakeRecommendationsRepository(details: [_received])
        ..feedbackErrorQueue.add(const CauceApiError.unknown(statusCode: 500));
      final h = await _pumpApp(tester, server);
      await RecommendationFeedbackOutboxStore(h.borders.database).save(
        PendingRecommendationFeedback(
          recommendationId: _received.id,
          idempotencyKey: '0b0b0b0b-0000-4000-8000-000000000044',
          wasApplied: true,
          outcome: FeedbackOutcomeOption.noChange,
          createdAt: _now,
        ),
        userId: demoUser.userId,
      );

      h.borders.connectivity.emitReconnection();
      await tester.pumpAndSettle();
      h.borders.connectivity.emitReconnection();
      await tester.pumpAndSettle();

      expect(server.feedbackKeys, <String>[
        '0b0b0b0b-0000-4000-8000-000000000044',
        '0b0b0b0b-0000-4000-8000-000000000044',
      ]);
      expect(_cardPending, findsNothing);
    });

    testWidgets('409 sin respuesta en el servidor vuelve a invitar',
        (tester) async {
      final server = FakeRecommendationsRepository(details: [_received])
        ..feedbackError = const CauceApiError.conflictState();
      final h = await _pumpApp(tester, server);
      await RecommendationFeedbackOutboxStore(h.borders.database).save(
        PendingRecommendationFeedback(
          recommendationId: _received.id,
          idempotencyKey: '0c0c0c0c-0000-4000-8000-000000000044',
          wasApplied: true,
          outcome: FeedbackOutcomeOption.noChange,
          createdAt: _now,
        ),
        userId: demoUser.userId,
      );
      await tester.pumpAndSettle();
      expect(_cardPending, findsOneWidget);

      h.borders.connectivity.emitReconnection();
      await tester.pumpAndSettle();

      expect(server.feedbackKeys, hasLength(1));
      expect(_cardPending, findsNothing);
      expect(_invite, findsOneWidget);
    });
  });
}
