import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_feedback_outbox_store.dart';
import 'package:cauce_mobile/features/recommendations/domain/pending_recommendation_feedback.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/symptoms/data/symptoms_repository.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_recommendations_repository.dart';
import '../../../helpers/paged_history_fakes.dart';
import '../../../helpers/sync_fixtures.dart';
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

    group('datos de respaldo por tipo de sintoma (CP042, CP077)', () {
      final data = approvedDetail.supportingData!;

      SymptomRecord record(int i, SymptomTypeOption type) => SymptomRecord(
            symptomId: 'symptom-$type-$i',
            occurredAt: data.windowTo
                .subtract(Duration(days: i + 1))
                .add(const Duration(hours: 2)),
            intensity: 65,
            symptomType: type,
          );

      List<SymptomRecord> records(int count, SymptomTypeOption type) =>
          <SymptomRecord>[for (var i = 0; i < count; i++) record(i, type)];

      Future<void> openWith(
        WidgetTester tester, {
        required int symptomCount,
        SymptomsRepository? symptoms,
      }) async {
        final detail = approvedDetail.copyWith(
          supportingData: data.copyWith(symptomCount: symptomCount),
        );
        await pumpRecommendations(
          tester,
          repository: FakeRecommendationsRepository(details: [detail]),
          initialLocation: AppRoutes.recommendationDetailPath(detail.id),
          symptoms: symptoms,
        );
        await _scrollTo(
          tester,
          find.byKey(const Key('recommendation_supporting_data')),
        );
      }

      testWidgets('el historial sembrado dice 4 registros de dolor abdominal',
          (tester) async {
        await openWith(
          tester,
          symptomCount: 4,
          symptoms: PagedSymptomsRepository(
            records(4, SymptomTypeOption.abdominalPain),
          ),
        );

        expect(
          find.text('registros de dolor abdominal en los últimos 14 días'),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('recommendation_data_symptoms_abdominalPain')),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('recommendation_data_symptoms')),
          findsNothing,
        );
        // Comidas, alimentos y ventana siguen como estaban.
        expect(find.text(l10n.recommendationDataMeals(9, 14)), findsOneWidget);
        expect(
          find.byKey(const Key('recommendation_data_top_foods')),
          findsOneWidget,
        );
        expect(find.text('4 h'), findsOneWidget);
      });

      testWidgets('un solo registro va en singular', (tester) async {
        await openWith(
          tester,
          symptomCount: 1,
          symptoms: PagedSymptomsRepository(
            records(1, SymptomTypeOption.abdominalPain),
          ),
        );

        expect(
          find.text('registro de dolor abdominal en los últimos 14 días'),
          findsOneWidget,
        );
      });

      testWidgets('varios tipos: tres nombrados y el resto agrupado',
          (tester) async {
        await openWith(
          tester,
          symptomCount: 10,
          symptoms: PagedSymptomsRepository(<SymptomRecord>[
            ...records(4, SymptomTypeOption.abdominalPain),
            ...records(3, SymptomTypeOption.bloating),
            ...records(1, SymptomTypeOption.diarrhea),
            ...records(1, SymptomTypeOption.nausea),
            ...records(1, SymptomTypeOption.other),
          ]),
        );

        final labels = <String>[
          'registros de dolor abdominal en los últimos 14 días',
          'registros de distensión abdominal en los últimos 14 días',
          'registro de diarrea en los últimos 14 días',
          l10n.recommendationDataSymptomsOther(2, 14),
        ];
        final tops = <double>[
          for (final label in labels) tester.getTopLeft(find.text(label)).dy,
        ];
        expect(tops, orderedEquals(List<double>.of(tops)..sort()));
        expect(
          find.text('registros de otros síntomas en los últimos 14 días'),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('recommendation_data_symptoms_nausea')),
          findsNothing,
        );
      });

      testWidgets('sin sintomas queda la linea del total en cero',
          (tester) async {
        final symptoms = PagedSymptomsRepository(const <SymptomRecord>[]);
        await openWith(tester, symptomCount: 0, symptoms: symptoms);

        expect(
          find.text(l10n.recommendationDataSymptoms(0, 14)),
          findsOneWidget,
        );
        expect(symptoms.calls, isEmpty);
      });

      testWidgets('si no se pueden contar, la linea del total', (tester) async {
        await openWith(
          tester,
          symptomCount: 4,
          symptoms: PagedSymptomsRepository(
            records(4, SymptomTypeOption.abdominalPain),
            failOnPage: 1,
          ),
        );

        expect(
          find.text(l10n.recommendationDataSymptoms(4, 14)),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('recommendation_data_symptoms_abdominalPain')),
          findsNothing,
        );
      });
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

      // El texto se muestra entero; FODMAP queda tocable dentro de el.
      expect(
        find.textContaining(
          'Se sugiere evitar 2 alimento(s) en función del perfil ',
          findRichText: true,
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('recommendation_term_FODMAP')),
        findsOneWidget,
      );
      expect(
        find.textContaining(' identificado.', findRichText: true),
        findsOneWidget,
      );
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

    testWidgets(
        'una manual muestra su titulo y su descripcion entera (acta M49)',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [writtenManualDetail]),
        writtenManualDetail.id,
      );

      expect(
        tester.widget<Text>(find.byKey(const Key('recommendation_title'))).data,
        'Hidratación en ayunas',
      );
      final description = find.byKey(const Key('recommendation_description'));
      expect(description, findsOneWidget);
      // Entera, sin recortar: en la tarjeta va a dos lineas, aca no.
      expect(
        find.descendant(
          of: description,
          matching: find.text(writtenManualDetail.descriptionText!),
        ),
        findsOneWidget,
      );
      expect(
        find.text(l10n.recommendationSectionDescription.toUpperCase()),
        findsOneWidget,
      );
      // La nota sigue en su bloque, aparte de la descripcion.
      expect(find.byKey(const Key('recommendation_note')), findsOneWidget);
      expect(
        tester.getTopLeft(description).dy,
        lessThan(
          tester.getTopLeft(find.byKey(const Key('recommendation_note'))).dy,
        ),
      );
      expect(find.text('Indicación de $demoNutritionistName'), findsOneWidget);
      expect(find.byKey(const Key('recommendation_confidence')), findsNothing);
    });

    testWidgets(
        'una modificada con textos del servidor los muestra y sigue siendo '
        'del motor', (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [rewrittenModifiedDetail]),
        rewrittenModifiedDetail.id,
      );

      expect(
        tester.widget<Text>(find.byKey(const Key('recommendation_title'))).data,
        'Reduce la cebolla en los almuerzos',
      );
      expect(
        find.text(
          'Evitar 2 alimentos, sustituir 1 alimento, incorporar 1 alimento',
        ),
        findsNothing,
      );
      // La descripcion va antes que la explicacion del sistema.
      final description = find.byKey(const Key('recommendation_description'));
      final explanation = find.byKey(const Key('recommendation_explanation'));
      expect(description, findsOneWidget);
      expect(explanation, findsOneWidget);
      expect(
        tester.getTopLeft(description).dy,
        lessThan(tester.getTopLeft(explanation).dy),
      );
      // Del motor: confianza, atribucion y pildora de modificada intactas.
      expect(find.text(l10n.recommendationConfidenceMedium), findsOneWidget);
      expect(find.text('Modificada por $demoNutritionistName'), findsOneWidget);
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_attribution')),
      );
      expect(
        find.byKey(const Key('recommendation_attribution')),
        findsOneWidget,
      );
    });

    testWidgets('una del motor sin descripcion no dibuja el bloque',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [approvedDetail]),
        approvedDetail.id,
      );

      expect(
        find.byKey(const Key('recommendation_description')),
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

  group('RecommendationDetailScreen · terminos del glosario (CP068)', () {
    final withTerm = approvedDetail.copyWith(
      id: 'rec-glossary',
      explanation: 'Algunos de los alimentos que consumes tienen un '
          'contenido alto de FODMAP y podrían relacionarse con tus síntomas.',
    );

    testWidgets('el termino marcado se ve subrayado y se anuncia como tal',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [withTerm]),
        withTerm.id,
      );

      final term = find.byKey(const Key('recommendation_term_FODMAP'));
      expect(term, findsOneWidget);
      final text = tester.widget<Text>(term);
      expect(text.style?.decoration, TextDecoration.underline);
      expect(
        find.ancestor(
          of: term,
          matching: find.byWidgetPredicate(
            (w) =>
                w is Semantics &&
                (w.properties.button ?? false) &&
                w.properties.label ==
                    l10n.recommendationGlossaryTermSemantics('FODMAP'),
          ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('tocarlo abre la definicion con su tipo (paso 7)',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [withTerm]),
        withTerm.id,
      );

      await _tapVisible(
        tester,
        find.byKey(const Key('recommendation_term_FODMAP')),
      );

      final sheet = find.byKey(const Key('glossary_term_sheet'));
      expect(sheet, findsOneWidget);
      expect(
        find.descendant(of: sheet, matching: find.text('FODMAP')),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: sheet,
          matching: find.textContaining('azúcares y fibras'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: sheet,
          matching: find.text(l10n.glossaryCategoryNutritional),
        ),
        findsOneWidget,
      );
    });

    testWidgets('sin terminos del glosario el texto queda igual',
        (tester) async {
      await _openDetail(
        tester,
        FakeRecommendationsRepository(details: [approvedDetail]),
        approvedDetail.id,
      );

      expect(find.textContaining('alimento alto en fructanos'), findsOneWidget);
      expect(
        find.byWidgetPredicate(
          (w) =>
              w.key is ValueKey<String> &&
              (w.key! as ValueKey<String>).value.startsWith(
                    'recommendation_term_',
                  ),
        ),
        findsNothing,
      );
    });
  });

  group('RecommendationDetailScreen · espera de 24 horas (CP043)', () {
    testWidgets('recibida hace 20 h: no pide respuesta y explica cuando',
        (tester) async {
      final recent = approvedDetail.copyWith(
        reviewedAt: recommendationsNow.subtract(const Duration(hours: 20)),
      );
      final repository = FakeRecommendationsRepository(details: [recent]);
      await _openDetail(tester, repository, recent.id);

      expect(repository.deliveredIds, <String>[recent.id]);
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_feedback_not_yet')),
      );
      expect(find.text(l10n.recommendationFeedbackNotYet), findsOneWidget);
      expect(
        find.byKey(const Key('recommendation_feedback_form')),
        findsNothing,
      );
    });

    testWidgets('la nota vacia es valida al responder (CP043 paso 9)',
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
        find.text(l10n.recommendationFeedbackOutcomeWorsening),
      );
      await _tapVisible(
        tester,
        find.byKey(const Key('recommendation_feedback_submit')),
      );

      expect(repository.feedbackDrafts, hasLength(1));
      expect(repository.feedbackDrafts.single.commentToSend, isNull);
      expect(find.text(l10n.recommendationFeedbackSent), findsOneWidget);
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

    testWidgets('sin red: queda registrada y pendiente de envio (CP044)',
        (tester) async {
      final repository = FakeRecommendationsRepository(
        details: [
          approvedDetail.copyWith(status: RecommendationStatusOption.delivered),
        ],
      );
      final connectivity = FakeConnectivityMonitor(online: false);
      addTearDown(connectivity.dispose);
      await pumpRecommendations(
        tester,
        repository: repository,
        initialLocation: AppRoutes.recommendationDetailPath(approvedDetail.id),
        connectivity: connectivity,
      );
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
        find.text(l10n.recommendationFeedbackOutcomeNoChange),
      );
      await _tapVisible(
        tester,
        find.byKey(const Key('recommendation_feedback_submit')),
      );

      expect(repository.feedbackKeys, isEmpty);
      expect(find.text(l10n.recommendationFeedbackQueued), findsOneWidget);
      expect(
        find.byKey(const Key('recommendation_feedback_form')),
        findsNothing,
      );
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_feedback_pending')),
      );
      expect(
        find.descendant(
          of: find.byKey(const Key('recommendation_feedback_summary')),
          matching: find.text(l10n.recommendationFeedbackQueuedBody),
        ),
        findsOneWidget,
      );
      expect(
        find.text(l10n.recommendationFeedbackSummaryNoChange),
        findsOneWidget,
      );
    });

    testWidgets('con una respuesta guardada muestra su resumen pendiente',
        (tester) async {
      final delivered =
          approvedDetail.copyWith(status: RecommendationStatusOption.delivered);
      final database = AppDatabase.memory();
      addTearDown(database.close);
      await RecommendationFeedbackOutboxStore(database).save(
        PendingRecommendationFeedback(
          recommendationId: delivered.id,
          idempotencyKey: 'clave-1',
          wasApplied: false,
          outcome: FeedbackOutcomeOption.worsening,
          comment: 'Más hinchazón',
          createdAt: recommendationsNow,
        ),
        userId: demoUser.userId,
      );
      await pumpRecommendations(
        tester,
        repository: FakeRecommendationsRepository(details: [delivered]),
        initialLocation: AppRoutes.recommendationDetailPath(delivered.id),
        database: database,
      );
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_feedback_pending')),
      );

      expect(find.text('Más hinchazón'), findsOneWidget);
      expect(
        find.text(l10n.recommendationFeedbackSummaryNotApplied),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('recommendation_feedback_form')),
        findsNothing,
      );
    });

    testWidgets('rechazada: avisa y permite responder de nuevo',
        (tester) async {
      final delivered =
          approvedDetail.copyWith(status: RecommendationStatusOption.delivered);
      final database = AppDatabase.memory();
      addTearDown(database.close);
      final outbox = RecommendationFeedbackOutboxStore(database);
      await outbox.save(
        PendingRecommendationFeedback(
          recommendationId: delivered.id,
          idempotencyKey: 'clave-1',
          wasApplied: true,
          outcome: FeedbackOutcomeOption.improvement,
          createdAt: recommendationsNow,
        ),
        userId: demoUser.userId,
      );
      await outbox.markRejected(
        delivered.id,
        userId: demoUser.userId,
        errorCode: 'validation_error',
      );
      await pumpRecommendations(
        tester,
        repository: FakeRecommendationsRepository(details: [delivered]),
        initialLocation: AppRoutes.recommendationDetailPath(delivered.id),
        database: database,
      );
      await _scrollTo(
        tester,
        find.byKey(const Key('recommendation_feedback_answer_again')),
      );

      expect(
        find.text(l10n.recommendationFeedbackRejectedTitle),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('recommendation_feedback_pending')),
        findsNothing,
      );
      await _tapVisible(
        tester,
        find.byKey(const Key('recommendation_feedback_answer_again')),
      );

      expect(
        find.byKey(const Key('recommendation_feedback_form')),
        findsOneWidget,
      );
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
