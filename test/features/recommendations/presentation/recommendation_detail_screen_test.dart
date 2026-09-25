import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_recommendations_repository.dart';
import 'recommendations_harness.dart';

Future<void> _openDetail(
  WidgetTester tester,
  FakeRecommendationsRepository repository,
  String id,
) async {
  await pumpRecommendations(
    tester,
    repository: repository,
    initialLocation: AppRoutes.recommendationDetailPath(id),
  );
}

Future<void> _scrollTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

/// Lleva el elemento a la vista antes de tocarlo: el formulario es mas alto
/// que la pantalla.
Future<void> _tapVisible(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  group('RecommendationDetailScreen · cuatro bloques (HU0015 CA3, CP042)', () {
    testWidgets('encabezado con titulo, origen, revision y confianza',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [approvedDetail]),
        approvedDetail.id,
      );

      expect(
        find.text(
          'Evitar 2 alimentos, sustituir 1 alimento, incorporar 1 alimento',
        ),
        findsOneWidget,
      );
      expect(find.text(l10n.recommendationOriginSystem), findsOneWidget);
      // CP041: la revision y el nombre, visibles en el encabezado.
      expect(
        find.text('Revisada y validada por $demoNutritionistName'),
        findsOneWidget,
      );
      expect(find.text(l10n.recommendationConfidenceMedium), findsOneWidget);
    });

    testWidgets('tocar la confianza explica el nivel (CP040 paso 5)',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [approvedDetail]),
        approvedDetail.id,
      );

      expect(
        find.text(l10n.recommendationConfidenceMediumBody),
        findsNothing,
      );
      await tester.tap(find.byKey(const Key('recommendation_confidence')));
      await tester.pumpAndSettle();

      expect(
        find.text(l10n.recommendationConfidenceMediumBody),
        findsOneWidget,
      );
    });

    testWidgets('explicacion con la atribucion literal del mockup 11',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [approvedDetail]),
        approvedDetail.id,
      );

      expect(find.text(approvedDetail.explanation!), findsOneWidget);
      expect(
        find.text(
          'Clasificación FODMAP basada en el catálogo de Monash University '
          '(2019).',
        ),
        findsOneWidget,
      );
    });

    testWidgets('items por accion, con sustituto y justificacion (CP036)',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [approvedDetail]),
        approvedDetail.id,
      );
      await _scrollTo(tester, find.byKey(const Key('recommendation_items')));

      expect(find.text(l10n.recommendationItemsAvoid), findsOneWidget);
      expect(find.text(l10n.recommendationItemsSubstitute), findsOneWidget);
      expect(find.text(l10n.recommendationItemsSuggest), findsOneWidget);
      expect(find.text('Leche entera por Bebida de almendras'), findsOneWidget);
      expect(
        find.text('Justificación por contenido de FODMAP.'),
        findsOneWidget,
      );
      expect(find.text('Zanahoria cocida'), findsOneWidget);
    });

    testWidgets('nota del nutricionista aparte, tambien en Approved',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [approvedDetail]),
        approvedDetail.id,
      );
      await _scrollTo(tester, find.byKey(const Key('recommendation_note')));

      expect(find.text(approvedDetail.note!), findsOneWidget);
      expect(
        find.byKey(const Key('recommendation_note_author')),
        findsOneWidget,
      );
    });

    testWidgets('los tres pasos y las cifras de respaldo', (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [approvedDetail]),
        approvedDetail.id,
      );
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_supporting_data')),
      );

      for (final step in approvedDetail.steps) {
        expect(find.text(step), findsOneWidget);
      }
      expect(find.text('4'), findsOneWidget);
      expect(
        find.text(l10n.recommendationDataSymptoms(4, 14)),
        findsOneWidget,
      );
      expect(find.text(l10n.recommendationDataMeals(9, 14)), findsOneWidget);
      expect(find.text('4 h'), findsOneWidget);
    });

    testWidgets('la explicacion de respaldo se muestra igual (CP077)',
        (tester) async {
      // HU0015 CA4: el LLM fallo y llego la plantilla. No es un error.
      final fallback = approvedDetail.copyWith(
        explanation: 'Se sugiere evitar 2 alimento(s) en función del perfil '
            'FODMAP identificado.',
        explanationSource: ExplanationOrigin.fallback,
      );
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [fallback]),
        fallback.id,
      );

      expect(find.text(fallback.explanation!), findsOneWidget);
      expect(
        find.byKey(const Key('recommendation_attribution')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('recommendation_error')), findsNothing);
    });
  });

  group('RecommendationDetailScreen · variantes de origen', () {
    testWidgets('una indicacion manual: sin confianza, XAI ni atribucion',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [manualDetail]),
        manualDetail.id,
      );

      expect(find.text('Indicación de $demoNutritionistName'), findsOneWidget);
      expect(find.byKey(const Key('recommendation_confidence')), findsNothing);
      expect(
        find.byKey(const Key('recommendation_explanation')),
        findsNothing,
      );
      expect(
        find.byKey(const Key('recommendation_attribution')),
        findsNothing,
      );
      expect(
        find.byKey(const Key('recommendation_supporting_data')),
        findsNothing,
      );
      expect(find.text(manualDetail.note!), findsOneWidget);
    });

    testWidgets('una modificada conserva su pildora despues de entregarse',
        (tester) async {
      // Abrirla la entrega y el detalle se refresca como Delivered, que en el
      // contrato ya no distingue modificada de aprobada. La memoria de origen
      // de la sesion evita que la pildora cambie mientras el paciente lee.
      final modified = approvedDetail.copyWith(
        status: RecommendationStatusOption.modifiedApproved,
      );
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [modified]),
        modified.id,
      );

      expect(find.text('Modificada por $demoNutritionistName'), findsOneWidget);
      expect(
        find.byKey(const Key('recommendation_reviewed_by')),
        findsNothing,
      );
    });

    testWidgets('una no visible responde "ya no esta disponible" (CP038)',
        (tester) async {
      // La lista de Consejos queda debajo y, vacia, pide una recomendacion:
      // se le responde el 422 silencioso para que no interfiera.
      await _openDetail(
        tester,
        FakeRecommendationsRepository()
          ..generationError = const CauceApiError.insufficientClinicalHistory(),
        'rec-pending-review',
      );

      expect(
        find.byKey(const Key('recommendation_not_available')),
        findsOneWidget,
      );
    });
  });

  group('RecommendationDetailScreen · entrega y feedback (HU0016)', () {
    testWidgets('abrirla la entrega una vez y habilita la respuesta',
        (tester) async {
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail]);
      await _openDetail(tester, repository, approvedDetail.id);

      expect(repository.deliveredIds, <String>[approvedDetail.id]);
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_feedback_submit')),
      );
      expect(
        find.byKey(const Key('recommendation_feedback_form')),
        findsOneWidget,
      );
    });

    testWidgets('responder: se envia y queda el resumen (CP043)',
        (tester) async {
      final repository =
          FakeRecommendationsRepository(details: [approvedDetail]);
      await _openDetail(tester, repository, approvedDetail.id);
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_feedback_submit')),
      );

      await _tapVisible(
        tester,
        find.text(l10n.recommendationFeedbackAppliedYes),
      );
      await _tapVisible(
        tester,
        find.text(l10n.recommendationFeedbackOutcomeImprovement),
      );
      final comment = find.descendant(
        of: find.byKey(const Key('recommendation_feedback_comment')),
        matching: find.byType(EditableText),
      );
      await tester.ensureVisible(comment);
      await tester.enterText(comment, 'Menos hinchazón en las noches');
      await tester.pumpAndSettle();
      await _tapVisible(
        tester,
        find.byKey(const Key('recommendation_feedback_submit')),
      );

      expect(repository.feedbackDrafts, hasLength(1));
      expect(find.text(l10n.recommendationFeedbackSent), findsOneWidget);
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_feedback_summary')),
      );
      expect(
        find.text(l10n.recommendationFeedbackSummaryImprovement),
        findsOneWidget,
      );
    });

    testWidgets('sin red: toast de error con reintento, sin cola (decision 8)',
        (tester) async {
      final repository = FakeRecommendationsRepository(
        details: [
          approvedDetail.copyWith(status: RecommendationStatusOption.delivered),
        ],
      )..feedbackError = const CauceApiError.network();
      await _openDetail(tester, repository, approvedDetail.id);
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_feedback_submit')),
      );

      await _tapVisible(
        tester,
        find.text(l10n.recommendationFeedbackAppliedNo),
      );
      await _tapVisible(
        tester,
        find.text(l10n.recommendationFeedbackOutcomeNoChange),
      );
      await _tapVisible(
        tester,
        find.byKey(const Key('recommendation_feedback_submit')),
      );

      expect(
        find.text(l10n.recommendationFeedbackNetworkError),
        findsOneWidget,
      );

      repository.feedbackError = null;
      await tester.tap(find.text(l10n.commonRetry));
      await tester.pumpAndSettle();

      expect(repository.feedbackKeys, hasLength(2));
      expect(repository.feedbackKeys.last, repository.feedbackKeys.first);
      expect(find.text(l10n.recommendationFeedbackSent), findsOneWidget);
    });

    testWidgets('con respuesta previa muestra el resumen y no el formulario',
        (tester) async {
      final answered = approvedDetail.copyWith(
        status: RecommendationStatusOption.feedbackReceived,
        feedback: RecommendationFeedback(
          wasApplied: true,
          outcome: FeedbackOutcomeOption.worsening,
          submittedAt: recommendationsNow,
        ),
      );
      final repository = FakeRecommendationsRepository(details: [answered]);
      await _openDetail(tester, repository, answered.id);
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_feedback_summary')),
      );

      expect(
        find.text(l10n.recommendationFeedbackSummaryWorsening),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('recommendation_feedback_form')),
        findsNothing,
      );
      expect(repository.deliveredIds, isEmpty);
    });
  });
}
