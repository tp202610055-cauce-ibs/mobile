import 'package:freezed_annotation/freezed_annotation.dart';

import 'recommendation.dart';

part 'recommendation_feedback_draft.freezed.dart';

/// Retroalimentacion en construccion (HU0016 CA1).
@freezed
abstract class RecommendationFeedbackDraft with _$RecommendationFeedbackDraft {
  const factory RecommendationFeedbackDraft({
    bool? wasApplied,
    FeedbackOutcomeOption? outcome,
    @Default('') String comment,
  }) = _RecommendationFeedbackDraft;

  const RecommendationFeedbackDraft._();

  /// Tope de `SubmitFeedbackCommandValidator` del backend.
  static const int maxCommentLength = 500;

  /// Caracteres que le quedan al paciente.
  ///
  /// En unidades UTF-16, igual que el `MaximumLength` del validador, por el
  /// mismo motivo que el contador de la nota de contexto.
  int get remaining => maxCommentLength - comment.length;

  bool get commentTooLong => comment.length > maxCommentLength;

  /// Las dos respuestas son obligatorias; el comentario no.
  ///
  /// El contrato exige `outcome` aunque el paciente no la haya aplicado:
  /// igual puede contar como siguen sus sintomas.
  bool get canSubmit =>
      wasApplied != null && outcome != null && !commentTooLong;

  /// Comentario tal como viaja: recortado, o `null` si quedo vacio.
  String? get commentToSend {
    final text = comment.trim();
    return text.isEmpty ? null : text;
  }
}
