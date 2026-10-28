import 'package:freezed_annotation/freezed_annotation.dart';

import 'recommendation.dart';
import 'recommendation_feedback_draft.dart';

part 'pending_recommendation_feedback.freezed.dart';

/// Respuesta guardada en el telefono que todavia no llego al servidor.
///
/// Lleva la carga exacta del primer intento y su clave: cada reintento manda
/// lo mismo, de modo que el servidor reconoce la respuesta si ya la tenia.
@freezed
abstract class PendingRecommendationFeedback
    with _$PendingRecommendationFeedback {
  const factory PendingRecommendationFeedback({
    required String recommendationId,
    required String idempotencyKey,
    required bool wasApplied,
    required FeedbackOutcomeOption outcome,
    String? comment,
    required DateTime createdAt,

    /// El servidor la rechazo por algo que no mejora reintentando.
    @Default(false) bool rejected,
    String? lastErrorCode,
  }) = _PendingRecommendationFeedback;

  const PendingRecommendationFeedback._();

  /// Fila nueva desde un borrador completo, con el comentario tal como viaja.
  factory PendingRecommendationFeedback.fromDraft(
    String recommendationId,
    RecommendationFeedbackDraft draft, {
    required String idempotencyKey,
    required DateTime createdAt,
  }) {
    final wasApplied = draft.wasApplied;
    final outcome = draft.outcome;
    if (wasApplied == null || outcome == null) {
      throw ArgumentError('La respuesta exige si se aplico y el resultado.');
    }
    return PendingRecommendationFeedback(
      recommendationId: recommendationId,
      idempotencyKey: idempotencyKey,
      wasApplied: wasApplied,
      outcome: outcome,
      comment: draft.commentToSend,
      createdAt: createdAt,
    );
  }

  /// Borrador equivalente, para enviar la misma carga que se guardo.
  RecommendationFeedbackDraft toDraft() => RecommendationFeedbackDraft(
        wasApplied: wasApplied,
        outcome: outcome,
        comment: comment ?? '',
      );
}
