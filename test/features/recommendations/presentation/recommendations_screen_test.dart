import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/recommendations/domain/pending_recommendation_request.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/presentation/recommendation_detail_screen.dart';
import 'package:cauce_mobile/features/recommendations/presentation/widgets/recommendation_origin_pill.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_recommendations_repository.dart';
import 'recommendations_harness.dart';

GeneratedRecommendation _pendingResult() => GeneratedRecommendation(
      id: 'rec-new',
      status: RecommendationStatusOption.pendingReview,
      generatedAt: recommendationsNow,
      expiresAt: recommendationsNow.add(const Duration(hours: 72)),
    );

void main() {
  group('RecommendationsScreen · estados (mockup 10)', () {
    testWidgets('restringida con el onboarding pendiente, sin pedir nada',
        (tester) async {
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult());

      await pumpRecommendations(
        tester,
        repository: repository,
        onboardingCompleted: false,
      );

      expect(find.byKey(const Key('recommendations_locked')), findsOneWidget);
      expect(repository.generationKeys, isEmpty);
    });

    testWidgets('lista vacia y 422: estado vacio, sin error (decision 2)',
        (tester) async {
      final repository = FakeRecommendationsRepository()
        ..generationError = const CauceApiError.insufficientClinicalHistory();

      await pumpRecommendations(tester, repository: repository);

      expect(repository.generationKeys, hasLength(1));
      expect(find.byKey(const Key('recommendations_empty')), findsOneWidget);
      expect(find.text(l10n.recommendationsEmptyTitle), findsOneWidget);
      expect(find.byKey(const Key('recommendations_error')), findsNothing);
    });

    testWidgets('el estado vacio invita a registrar una comida',
        (tester) async {
      final repository = FakeRecommendationsRepository()
        ..generationError = const CauceApiError.insufficientClinicalHistory();
      await pumpRecommendations(tester, repository: repository);

      await tester.tap(find.text(l10n.recommendationsEmptyAction));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('meal_form_stub')), findsOneWidget);
    });

    testWidgets('lista vacia: pide una y muestra "en revision" (CP037)',
        (tester) async {
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult());

      await pumpRecommendations(tester, repository: repository);

      expect(repository.generationKeys, hasLength(1));
      expect(find.byKey(const Key('recommendations_pending')), findsOneWidget);
      expect(find.text(l10n.recommendationsPendingTitle), findsOneWidget);
    });

    testWidgets('con una en revision guardada no vuelve a pedir',
        (tester) async {
      final repository =
          FakeRecommendationsRepository(generationResult: _pendingResult());
      final store = InMemoryRecommendationRequestStore(
        PendingRecommendationRequest(
          ownerUserId: demoUser.userId,
          idempotencyKey: 'key-1',
          requestedAt: recommendationsNow,
          recommendationId: 'rec-pending',
          expiresAt: recommendationsNow.add(const Duration(hours: 40)),
        ),
      );

      await pumpRecommendations(tester, repository: repository, store: store);

      expect(repository.generationKeys, isEmpty);
      expect(find.byKey(const Key('recommendations_pending')), findsOneWidget);
    });

    testWidgets('sin red al pedir: banner y reintento con la misma clave',
        (tester) async {
      final repository = FakeRecommendationsRepository()
        ..generationError = const CauceApiError.network();
      await pumpRecommendations(tester, repository: repository);

      expect(find.byKey(const Key('recommendations_error')), findsOneWidget);

      repository
        ..generationError = null
        ..generationResult = _pendingResult();
      await tester.tap(find.byKey(const Key('recommendations_retry')));
      await tester.pumpAndSettle();

      expect(repository.generationKeys, hasLength(2));
      expect(repository.generationKeys.last, repository.generationKeys.first);
      expect(find.byKey(const Key('recommendations_pending')), findsOneWidget);
    });

    testWidgets('si la lista no carga, error con reintento', (tester) async {
      final repository = FakeRecommendationsRepository(
        details: [approvedDetail],
      )..listError = const CauceApiError.network();
      await pumpRecommendations(tester, repository: repository);

      expect(find.byKey(const Key('recommendations_error')), findsOneWidget);
      expect(repository.generationKeys, isEmpty);

      repository.listError = null;
      await tester.tap(find.byKey(const Key('recommendations_retry')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('recommendations_list')), findsOneWidget);
    });
  });

  group('RecommendationsScreen · tarjetas (decisiones 3, 5 y 10)', () {
    testWidgets('titulo y descripcion compuestos desde los items',
        (tester) async {
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail]);

      await pumpRecommendations(tester, repository: repository);

      expect(
        find.text(
          'Evitar 2 alimentos, sustituir 1 alimento, incorporar 1 alimento',
        ),
        findsOneWidget,
      );
      expect(
        find.text('Cebolla, Ajo, Leche entera y 1 más'),
        findsOneWidget,
      );
      expect(find.text(l10n.recommendationOriginSystem), findsOneWidget);
      expect(
        find.byKey(Key('recommendation_new_${approvedDetail.id}')),
        findsOneWidget,
      );
    });

    testWidgets('modificada y manual llevan el nombre real en la lista',
        (tester) async {
      final modified = approvedDetail.copyWith(
        id: 'rec-modified',
        status: RecommendationStatusOption.modifiedApproved,
      );
      final repository = FakeRecommendationsRepository(
        details: [modified, manualDetail],
      );

      await pumpRecommendations(tester, repository: repository);

      expect(find.text('Modificada por $demoNutritionistName'), findsOneWidget);
      expect(find.text('Indicación de $demoNutritionistName'), findsOneWidget);
      // Sin items, la indicacion manual se describe con la nota.
      expect(find.text(l10n.recommendationManualTitle), findsOneWidget);
      expect(find.text(manualDetail.note!), findsOneWidget);
    });

    testWidgets('sin nombre del revisor, "tu nutricionista" de respaldo',
        (tester) async {
      final repository = FakeRecommendationsRepository(
        details: [manualDetail.copyWith(reviewerName: null)],
      );

      await pumpRecommendations(tester, repository: repository);

      // El titulo de una indicacion sin items dice lo mismo; se mira la
      // pildora.
      expect(
        find.descendant(
          of: find.byType(RecommendationOriginPill),
          matching: find.text('Indicación de tu nutricionista'),
        ),
        findsOneWidget,
      );
    });

    testWidgets(
        'una entregada del motor dice "Sugerencia del sistema", '
        'nunca "Entregada"', (tester) async {
      final repository = FakeRecommendationsRepository(
        details: [
          approvedDetail.copyWith(
            status: RecommendationStatusOption.feedbackReceived,
          ),
        ],
      );

      await pumpRecommendations(tester, repository: repository);

      expect(find.text(l10n.recommendationOriginSystem), findsOneWidget);
      expect(find.textContaining('Entregada'), findsNothing);
      expect(find.textContaining('Con feedback'), findsNothing);
      expect(
        find.byKey(Key('recommendation_new_${approvedDetail.id}')),
        findsNothing,
      );
    });

    testWidgets('pintar las tarjetas no entrega ninguna recomendacion',
        (tester) async {
      // El detalle que pide cada tarjeta es una lectura silenciosa: solo abrir
      // el detalle entrega (decision 7, indicacion de Trigo).
      final repository = FakeRecommendationsRepository(
        details: [approvedDetail, manualDetail],
      );

      await pumpRecommendations(tester, repository: repository);

      expect(repository.detailCalls, greaterThanOrEqualTo(2));
      expect(repository.deliveredIds, isEmpty);
    });

    testWidgets('tocar una tarjeta abre su detalle y la entrega',
        (tester) async {
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail]);
      await pumpRecommendations(tester, repository: repository);

      await tester.tap(
        find.byKey(Key('recommendation_card_${approvedDetail.id}')),
      );
      await tester.pumpAndSettle();

      expect(find.byType(RecommendationDetailScreen), findsOneWidget);
      expect(repository.deliveredIds, <String>[approvedDetail.id]);
    });
  });
}
