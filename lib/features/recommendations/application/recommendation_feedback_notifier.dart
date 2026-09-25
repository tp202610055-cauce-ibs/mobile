import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/recommendations_repository.dart';
import '../domain/recommendation.dart';
import '../domain/recommendation_feedback_draft.dart';
import 'recommendation_detail_providers.dart';
import 'recommendations_feed_notifier.dart';

part 'recommendation_feedback_notifier.freezed.dart';
part 'recommendation_feedback_notifier.g.dart';

/// Estado del formulario de retroalimentacion (HU0016 CA1).
@freezed
abstract class RecommendationFeedbackFormState
    with _$RecommendationFeedbackFormState {
  const factory RecommendationFeedbackFormState({
    @Default(RecommendationFeedbackDraft()) RecommendationFeedbackDraft draft,
    @Default(false) bool submitting,
    @Default(false) bool sent,

    /// `Idempotency-Key` del intento en curso. Se conserva ante un fallo para
    /// que el reintento de la misma respuesta la repita, y se descarta en
    /// cuanto el paciente cambia algo: la misma clave con otra carga daria
    /// 409 `idempotency_mismatch`.
    String? pendingKey,
    CauceApiError? error,
  }) = _RecommendationFeedbackFormState;

  const RecommendationFeedbackFormState._();

  bool get canSubmit => draft.canSubmit && !submitting && !sent;
}

/// Gobierna la respuesta del paciente sobre una recomendacion entregada.
///
/// **Solo en linea** (decision 8). Sin conexion el envio falla con
/// [NetworkError] y la pantalla ofrece reintentar; no hay cola local ni
/// migracion del esquema drift en este bloque. **Sin compuerta de 24 h**
/// (decision 9): el backend no la exige, las 24 h son solo la hora de su
/// recordatorio push.
@riverpod
class RecommendationFeedbackForm extends _$RecommendationFeedbackForm {
  bool _disposed = false;

  @override
  RecommendationFeedbackFormState build(String id) {
    ref.onDispose(() => _disposed = true);
    return const RecommendationFeedbackFormState();
  }

  void setApplied(bool value) => _edit(state.draft.copyWith(wasApplied: value));

  void setOutcome(FeedbackOutcomeOption value) =>
      _edit(state.draft.copyWith(outcome: value));

  void setComment(String value) => _edit(state.draft.copyWith(comment: value));

  void _edit(RecommendationFeedbackDraft draft) {
    state = state.copyWith(draft: draft, pendingKey: null, error: null);
  }

  /// Envia la respuesta. Devuelve `true` si el servidor la acepto.
  ///
  /// Ante un fallo lo escrito queda intacto, con el mismo criterio que la
  /// nota de contexto: perderlo obligaria al paciente a responder de nuevo.
  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    final key = state.pendingKey ?? const Uuid().v4();
    state = state.copyWith(submitting: true, error: null, pendingKey: key);

    try {
      await ref.read(recommendationsRepositoryProvider).submitFeedback(
            id,
            draft: state.draft,
            idempotencyKey: key,
          );
    } on CauceApiError catch (error) {
      if (_disposed) {
        return false;
      }
      state = state.copyWith(submitting: false, error: error);
      // 409 `conflict_state`: ya tenia respuesta, o dejo de estar entregada.
      // Se refresca el detalle para que la pantalla muestre lo que es.
      if (error is ConflictStateError) {
        ref.invalidate(recommendationDetailProvider(id));
      }
      return false;
    }

    if (_disposed) {
      return true;
    }
    state = state.copyWith(submitting: false, sent: true, pendingKey: null);
    ref.invalidate(recommendationDetailProvider(id));
    ref.invalidate(recommendationsFeedNotifierProvider);
    return true;
  }
}
