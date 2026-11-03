import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/sync/connectivity_monitor.dart';
import '../../auth/application/session_notifier.dart';
import '../data/recommendation_feedback_outbox_store.dart';
import '../data/recommendations_repository.dart';
import '../domain/pending_recommendation_feedback.dart';
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

    /// La respuesta quedo en el telefono y se enviara al volver la red.
    @Default(false) bool queued,

    /// `Idempotency-Key` del intento en curso. Se conserva ante un fallo para
    /// que el reintento la repita, y se descarta si el paciente cambia algo.
    String? pendingKey,
    CauceApiError? error,
  }) = _RecommendationFeedbackFormState;

  const RecommendationFeedbackFormState._();

  bool get canSubmit => draft.canSubmit && !submitting && !sent && !queued;
}

/// Gobierna la respuesta del paciente sobre una recomendacion entregada.
///
/// Sin red la respuesta se guarda en el telefono con su clave y la envia
/// `RecommendationFeedbackSender` al volver la conexion (HU0016 CA2).
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

  /// Envia la respuesta, o la guarda si no hay red. Devuelve `true` si quedo
  /// registrada de cualquiera de las dos formas; [queued] dice cual.
  ///
  /// Ante un rechazo lo escrito queda intacto, para no obligar a responder de
  /// nuevo.
  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    final key = state.pendingKey ?? const Uuid().v4();
    state = state.copyWith(submitting: true, error: null, pendingKey: key);

    if (!await ref.read(connectivityMonitorProvider).isOnline()) {
      return _queue(key);
    }

    try {
      await ref.read(recommendationsRepositoryProvider).submitFeedback(
            id,
            draft: state.draft,
            idempotencyKey: key,
          );
    } on NetworkError {
      return _queue(key);
    } on CauceApiError catch (error) {
      if (_disposed) {
        return false;
      }
      state = state.copyWith(submitting: false, error: error);
      // 409 `conflict_state`: ya tenia respuesta, o dejo de estar entregada.
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

  /// Borra una respuesta que el servidor rechazo y deja el formulario limpio.
  ///
  /// La clave rechazada no se reusa: con otra carga daria `idempotency_mismatch`.
  Future<void> answerAgain() async {
    final userId = ref.read(sessionNotifierProvider).user?.userId;
    if (userId != null) {
      await ref
          .read(recommendationFeedbackOutboxStoreProvider)
          .remove(id, userId: userId);
    }
    if (!_disposed) {
      state = const RecommendationFeedbackFormState();
    }
  }

  Future<bool> _queue(String key) async {
    final userId = ref.read(sessionNotifierProvider).user?.userId;
    if (userId == null) {
      if (!_disposed) {
        state = state.copyWith(
          submitting: false,
          error: const CauceApiError.network(),
        );
      }
      return false;
    }
    await ref.read(recommendationFeedbackOutboxStoreProvider).save(
          PendingRecommendationFeedback.fromDraft(
            id,
            state.draft,
            idempotencyKey: key,
            createdAt: ref.read(recommendationsClockProvider)().toUtc(),
          ),
          userId: userId,
        );
    if (!_disposed) {
      state = state.copyWith(submitting: false, queued: true);
    }
    return true;
  }
}

/// Respuesta guardada en el telefono para una recomendacion, de la cuenta de
/// la sesion. `null` si no hay.
@riverpod
Stream<PendingRecommendationFeedback?> pendingRecommendationFeedback(
  Ref ref,
  String id,
) {
  final userId = ref.watch(
    sessionNotifierProvider.select((session) => session.user?.userId),
  );
  if (userId == null) {
    return Stream<PendingRecommendationFeedback?>.value(null);
  }
  return ref
      .watch(recommendationFeedbackOutboxStoreProvider)
      .watch(id, userId: userId);
}
