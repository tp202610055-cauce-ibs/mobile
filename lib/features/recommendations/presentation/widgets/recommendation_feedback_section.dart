import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/errors/cauce_api_error.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/recommendation_feedback_notifier.dart';
import '../../domain/recommendation.dart';

/// Retroalimentacion del paciente sobre una recomendacion (HU0016 CA1,
/// CP043).
///
/// **Sin mockup.** El 10 ubica esta accion "dentro del detalle P11", y el 11
/// no la dibuja. Va al pie del detalle, despues de leer el porque, que es lo
/// que el mockup 10 justifica: marcarla sin haber leido seria una
/// microaccion sin contexto.
///
/// Tres estados, segun el detalle:
/// - **ya respondida**: el resumen de lo que conto;
/// - **entregada, sin respuesta**: el formulario;
/// - **cualquier otro**: nada. El backend solo acepta feedback desde
///   `Delivered`, y la entrega ocurre al abrir el detalle.
class RecommendationFeedbackSection extends StatelessWidget {
  const RecommendationFeedbackSection({required this.detail, super.key});

  final RecommendationDetail detail;

  @override
  Widget build(BuildContext context) {
    final feedback = detail.feedback;
    if (feedback != null) {
      return _FeedbackSummary(feedback: feedback);
    }
    if (detail.status.acceptsFeedback) {
      return _FeedbackForm(recommendationId: detail.id);
    }
    return const SizedBox.shrink();
  }
}

class _FeedbackForm extends ConsumerStatefulWidget {
  const _FeedbackForm({required this.recommendationId});

  final String recommendationId;

  @override
  ConsumerState<_FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends ConsumerState<_FeedbackForm> {
  final TextEditingController _comment = TextEditingController();

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final notifier = ref.read(
      recommendationFeedbackFormProvider(widget.recommendationId).notifier,
    );
    final ok = await notifier.submit();
    if (!mounted) {
      return;
    }
    if (ok) {
      CauceToast.success(context, title: l10n.recommendationFeedbackSent);
      return;
    }
    final error = ref
        .read(recommendationFeedbackFormProvider(widget.recommendationId))
        .error;
    // Decision 8: solo en linea. Sin conexion no se encola: se avisa y se
    // ofrece reintentar con la misma clave y lo mismo escrito.
    if (error is NetworkError) {
      CauceToast.error(
        context,
        title: l10n.recommendationFeedbackNetworkError,
        message: l10n.recommendationFeedbackNetworkErrorBody,
        actionLabel: l10n.commonRetry,
        onAction: _submit,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final provider =
        recommendationFeedbackFormProvider(widget.recommendationId);
    final state = ref.watch(provider);
    final notifier = ref.read(provider.notifier);
    final draft = state.draft;
    final error = state.error;
    final enabled = !state.submitting;

    return Container(
      key: const Key('recommendation_feedback_form'),
      margin: const EdgeInsets.only(top: CauceSpacing.space6),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderLg,
        border: Border.all(
          color: CauceColors.bgDivider,
          width: CauceBorders.subtle,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l10n.recommendationFeedbackTitle, style: textTheme.titleMedium),
          const SizedBox(height: CauceSpacing.space1),
          Text(l10n.recommendationFeedbackIntro, style: textTheme.bodyMedium),
          if (error != null && error is! NetworkError) ...<Widget>[
            const SizedBox(height: CauceSpacing.space4),
            CauceErrorBanner(
              key: const Key('recommendation_feedback_error'),
              error: error,
            ),
          ],
          const SizedBox(height: CauceSpacing.space4),
          CauceChoiceField<bool>(
            key: const Key('recommendation_feedback_applied'),
            label: l10n.recommendationFeedbackAppliedLabel,
            value: draft.wasApplied,
            enabled: enabled,
            choices: <CauceChoice<bool>>[
              CauceChoice<bool>(
                value: true,
                label: l10n.recommendationFeedbackAppliedYes,
              ),
              CauceChoice<bool>(
                value: false,
                label: l10n.recommendationFeedbackAppliedNo,
              ),
            ],
            onChanged: notifier.setApplied,
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceChoiceField<FeedbackOutcomeOption>(
            key: const Key('recommendation_feedback_outcome'),
            label: l10n.recommendationFeedbackOutcomeLabel,
            value: draft.outcome,
            enabled: enabled,
            choices: <CauceChoice<FeedbackOutcomeOption>>[
              CauceChoice<FeedbackOutcomeOption>(
                value: FeedbackOutcomeOption.improvement,
                label: l10n.recommendationFeedbackOutcomeImprovement,
              ),
              CauceChoice<FeedbackOutcomeOption>(
                value: FeedbackOutcomeOption.noChange,
                label: l10n.recommendationFeedbackOutcomeNoChange,
              ),
              CauceChoice<FeedbackOutcomeOption>(
                value: FeedbackOutcomeOption.worsening,
                label: l10n.recommendationFeedbackOutcomeWorsening,
              ),
            ],
            onChanged: notifier.setOutcome,
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceTextField(
            key: const Key('recommendation_feedback_comment'),
            controller: _comment,
            label: l10n.recommendationFeedbackCommentLabel,
            hint: l10n.recommendationFeedbackCommentHint,
            maxLines: 3,
            enabled: enabled,
            // Igual que la nota de contexto: no se recorta al tope, se avisa.
            errorText: draft.commentTooLong
                ? l10n.recommendationFeedbackTooLong
                : null,
            onChanged: notifier.setComment,
          ),
          const SizedBox(height: CauceSpacing.space2),
          Text(
            l10n.recommendationFeedbackRemaining(draft.remaining),
            key: const Key('recommendation_feedback_counter'),
            textAlign: TextAlign.right,
            style: textTheme.labelSmall?.copyWith(
              color: draft.commentTooLong
                  ? CauceColors.dangerText
                  : CauceColors.textSecondary,
            ),
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceButton(
            key: const Key('recommendation_feedback_submit'),
            label: l10n.recommendationFeedbackSubmit,
            loading: state.submitting,
            onPressed: state.canSubmit ? _submit : null,
          ),
        ],
      ),
    );
  }
}

/// Lo que el paciente ya conto. El backend no admite una segunda respuesta.
class _FeedbackSummary extends StatelessWidget {
  const _FeedbackSummary({required this.feedback});

  final RecommendationFeedback feedback;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final comment = feedback.comment;

    return Container(
      key: const Key('recommendation_feedback_summary'),
      margin: const EdgeInsets.only(top: CauceSpacing.space6),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: const BoxDecoration(
        color: CauceColors.bgSubtle,
        borderRadius: CauceRadii.borderLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                TablerIcons.message_circle,
                size: 18,
                color: CauceColors.brandBase,
              ),
              const SizedBox(width: CauceSpacing.space2),
              Expanded(
                child: Text(
                  l10n.recommendationFeedbackSummaryTitle,
                  style: textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: CauceSpacing.space2),
          Text(
            feedback.wasApplied
                ? l10n.recommendationFeedbackSummaryApplied
                : l10n.recommendationFeedbackSummaryNotApplied,
            style: textTheme.bodyMedium,
          ),
          Text(
            switch (feedback.outcome) {
              FeedbackOutcomeOption.improvement =>
                l10n.recommendationFeedbackSummaryImprovement,
              FeedbackOutcomeOption.noChange =>
                l10n.recommendationFeedbackSummaryNoChange,
              FeedbackOutcomeOption.worsening =>
                l10n.recommendationFeedbackSummaryWorsening,
            },
            style: textTheme.bodyMedium,
          ),
          if (comment != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space2),
            Text(
              comment,
              style: textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: CauceColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
