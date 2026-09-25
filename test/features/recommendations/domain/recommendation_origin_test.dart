import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation_origin.dart';
import 'package:flutter_test/flutter_test.dart';

RecommendationOrigin _resolve(
  RecommendationStatusOption status, {
  ExplanationOrigin? source = ExplanationOrigin.llmGenerated,
  int items = 2,
}) {
  return RecommendationOrigin.resolve(
    status: status,
    explanationSource: source,
    itemsCount: items,
  );
}

void main() {
  group('RecommendationOrigin.resolve · decision 10', () {
    test('los tres estados aprobados lo dicen directo', () {
      expect(
        _resolve(RecommendationStatusOption.approved),
        RecommendationOrigin.system,
      );
      expect(
        _resolve(RecommendationStatusOption.modifiedApproved),
        RecommendationOrigin.modified,
      );
      expect(
        _resolve(
          RecommendationStatusOption.manualApproved,
          source: ExplanationOrigin.manual,
          items: 0,
        ),
        RecommendationOrigin.manual,
      );
    });

    test('entregada o con feedback: manual si la explicacion es manual', () {
      for (final status in <RecommendationStatusOption>[
        RecommendationStatusOption.delivered,
        RecommendationStatusOption.feedbackReceived,
      ]) {
        expect(
          _resolve(status, source: ExplanationOrigin.manual, items: 0),
          RecommendationOrigin.manual,
          reason: '$status',
        );
      }
    });

    test('entregada del motor: sistema, este o no revisada', () {
      // Una aprobada y una modificada son indistinguibles tras la entrega:
      // el backend escribe los mismos campos en los dos caminos. Sistema es
      // verdad para las dos; "modificada" seria falso para una sin cambios.
      expect(
        _resolve(RecommendationStatusOption.delivered),
        RecommendationOrigin.system,
      );
      expect(
        _resolve(
          RecommendationStatusOption.feedbackReceived,
          source: ExplanationOrigin.fallback,
        ),
        RecommendationOrigin.system,
      );
    });

    test('sin explicacion informada, cero items tambien es manual', () {
      // El motor nunca genera una recomendacion vacia.
      expect(
        _resolve(RecommendationStatusOption.delivered, source: null, items: 0),
        RecommendationOrigin.manual,
      );
      expect(
        _resolve(RecommendationStatusOption.delivered, source: null, items: 3),
        RecommendationOrigin.system,
      );
    });

    test('solo sistema omite el nombre del nutricionista', () {
      expect(RecommendationOrigin.system.namesNutritionist, isFalse);
      expect(RecommendationOrigin.modified.namesNutritionist, isTrue);
      expect(RecommendationOrigin.manual.namesNutritionist, isTrue);
    });
  });
}
