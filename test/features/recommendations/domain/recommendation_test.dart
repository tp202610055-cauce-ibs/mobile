import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:cauce_mobile/features/recommendations/domain/confidence_level.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation_origin.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_recommendations_repository.dart';

void main() {
  group('RecommendationStatusOption', () {
    test('mapea los nueve valores del contrato', () {
      final cases = <api.RecommendationStatus, RecommendationStatusOption>{
        api.RecommendationStatus.generated:
            RecommendationStatusOption.generated,
        api.RecommendationStatus.pendingReview:
            RecommendationStatusOption.pendingReview,
        api.RecommendationStatus.approved: RecommendationStatusOption.approved,
        api.RecommendationStatus.modifiedApproved:
            RecommendationStatusOption.modifiedApproved,
        api.RecommendationStatus.manualApproved:
            RecommendationStatusOption.manualApproved,
        api.RecommendationStatus.rejected: RecommendationStatusOption.rejected,
        api.RecommendationStatus.delivered:
            RecommendationStatusOption.delivered,
        api.RecommendationStatus.feedbackReceived:
            RecommendationStatusOption.feedbackReceived,
        api.RecommendationStatus.expired: RecommendationStatusOption.expired,
      };

      expect(cases, hasLength(api.RecommendationStatus.values.length));
      for (final entry in cases.entries) {
        expect(RecommendationStatusOption.fromApi(entry.key), entry.value);
      }
      expect(RecommendationStatusOption.fromApi(null), isNull);
    });

    test('el paciente ve exactamente cinco estados (acta A24)', () {
      final visible = RecommendationStatusOption.values
          .where((status) => status.isVisibleToPatient)
          .toSet();

      expect(visible, <RecommendationStatusOption>{
        RecommendationStatusOption.approved,
        RecommendationStatusOption.modifiedApproved,
        RecommendationStatusOption.manualApproved,
        RecommendationStatusOption.delivered,
        RecommendationStatusOption.feedbackReceived,
      });
    });

    test(
        'solo los tres aprobados se entregan, y solo Delivered admite '
        'feedback', () {
      expect(
        RecommendationStatusOption.values.where((s) => s.isDeliverable).toSet(),
        <RecommendationStatusOption>{
          RecommendationStatusOption.approved,
          RecommendationStatusOption.modifiedApproved,
          RecommendationStatusOption.manualApproved,
        },
      );
      expect(
        RecommendationStatusOption.values.where((s) => s.acceptsFeedback),
        <RecommendationStatusOption>[RecommendationStatusOption.delivered],
      );
    });
  });

  group('enums del detalle', () {
    test('ExplanationOrigin y ActionType mapean todos sus valores', () {
      expect(
        api.ExplanationSource.values.map(ExplanationOrigin.fromApi),
        everyElement(isNotNull),
      );
      expect(
        api.ActionType.values.map(RecommendationAction.fromApi),
        everyElement(isNotNull),
      );
    });

    test('FeedbackOutcomeOption va y vuelve sin perder nada', () {
      for (final outcome in FeedbackOutcomeOption.values) {
        expect(FeedbackOutcomeOption.fromApi(outcome.toApi()), outcome);
      }
    });
  });

  group('RecommendationDetail', () {
    test('una indicacion manual oculta la confianza y la atribucion', () {
      // Llega con confidenceScore 1.0: "confianza alta" seria enganoso.
      expect(manualDetail.isManual, isTrue);
      expect(manualDetail.confidenceLevel, isNull);
      expect(manualDetail.showsAttribution, isFalse);
      expect(manualDetail.origin, RecommendationOrigin.manual);
    });

    test('una del motor muestra confianza y atribucion (decision 6)', () {
      expect(approvedDetail.isManual, isFalse);
      expect(approvedDetail.confidenceLevel, ConfidenceLevel.medium);
      expect(approvedDetail.showsAttribution, isTrue);
    });

    test('la atribucion tambien va con la explicacion de respaldo', () {
      // HU0015 CA4: el respaldo sigue siendo una explicacion del sistema.
      final fallback = approvedDetail.copyWith(
        explanationSource: ExplanationOrigin.fallback,
      );

      expect(fallback.showsAttribution, isTrue);
      expect(fallback.explanationText, isNotNull);
    });

    test('la nota se muestra tambien en Approved (acta M47)', () {
      expect(approvedDetail.status, RecommendationStatusOption.approved);
      expect(approvedDetail.note, isNotNull);
    });

    test('nota y explicacion en blanco se leen como ausentes', () {
      final blank = approvedDetail.copyWith(
        nutritionistNote: '   ',
        explanation: '\n',
      );

      expect(blank.note, isNull);
      expect(blank.explanationText, isNull);
    });

    test('nueva mientras no se entrega; revisada si hubo nutricionista', () {
      expect(approvedDetail.isNew, isTrue);
      expect(approvedDetail.wasReviewed, isTrue);

      final delivered = approvedDetail.copyWith(
        status: RecommendationStatusOption.delivered,
      );
      expect(delivered.isNew, isFalse);

      final auto = approvedDetail.copyWith(autoApproved: true);
      expect(auto.wasReviewed, isFalse);
    });

    test('la ventana de los datos de respaldo es de 14 dias', () {
      expect(approvedDetail.supportingData!.windowDays, 14);
    });
  });
}
