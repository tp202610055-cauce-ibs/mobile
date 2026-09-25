import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation_feedback_draft.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RecommendationFeedbackDraft · HU0016 CA1', () {
    test('exige si se aplico y el resultado; el comentario no', () {
      const empty = RecommendationFeedbackDraft();
      const onlyApplied = RecommendationFeedbackDraft(wasApplied: true);
      const complete = RecommendationFeedbackDraft(
        wasApplied: false,
        outcome: FeedbackOutcomeOption.noChange,
      );

      expect(empty.canSubmit, isFalse);
      expect(onlyApplied.canSubmit, isFalse);
      expect(complete.canSubmit, isTrue);
    });

    test('el comentario tiene tope de 500 y no se recorta solo', () {
      final atLimit = RecommendationFeedbackDraft(
        wasApplied: true,
        outcome: FeedbackOutcomeOption.improvement,
        comment: 'a' * 500,
      );
      final overLimit = atLimit.copyWith(comment: 'a' * 501);

      expect(atLimit.remaining, 0);
      expect(atLimit.canSubmit, isTrue);
      expect(overLimit.remaining, -1);
      expect(overLimit.commentTooLong, isTrue);
      expect(overLimit.canSubmit, isFalse);
    });

    test('el comentario viaja recortado, o nulo si quedo vacio', () {
      const withText = RecommendationFeedbackDraft(
        comment: '  Menos hinchazón en las noches  ',
      );
      const blank = RecommendationFeedbackDraft(comment: '   ');

      expect(withText.commentToSend, 'Menos hinchazón en las noches');
      expect(blank.commentToSend, isNull);
    });
  });
}
