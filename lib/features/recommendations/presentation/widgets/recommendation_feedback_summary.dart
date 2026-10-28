import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/recommendation.dart';

/// Estado de una respuesta que el paciente ya dio.
enum FeedbackSummaryState {
  /// El servidor la tiene.
  received,

  /// Guardada en el telefono, a la espera de conexion.
  pending,

  /// El servidor la rechazo y el paciente puede responder de nuevo.
  rejected,
}

/// Lo que el paciente conto sobre una recomendacion, con su estado de envio.
class RecommendationFeedbackSummary extends StatelessWidget {
  const RecommendationFeedbackSummary({
    required this.wasApplied,
    required this.outcome,
    this.comment,
    this.state = FeedbackSummaryState.received,
    this.onAnswerAgain,
    super.key,
  });

  final bool wasApplied;
  final FeedbackOutcomeOption outcome;
  final String? comment;
  final FeedbackSummaryState state;
  final VoidCallback? onAnswerAgain;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final comment = this.comment;

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
          if (state == FeedbackSummaryState.pending) ...<Widget>[
            const SizedBox(height: CauceSpacing.space2),
            CauceBadge(
              key: const Key('recommendation_feedback_pending'),
              label: l10n.recommendationFeedbackPendingBadge,
              icon: TablerIcons.cloud_upload,
              tone: CauceBadgeTone.info,
            ),
            const SizedBox(height: CauceSpacing.space1),
            Text(
              l10n.recommendationFeedbackQueuedBody,
              style: textTheme.bodyMedium?.copyWith(
                color: CauceColors.textSecondary,
              ),
            ),
          ],
          const SizedBox(height: CauceSpacing.space2),
          Text(
            wasApplied
                ? l10n.recommendationFeedbackSummaryApplied
                : l10n.recommendationFeedbackSummaryNotApplied,
            style: textTheme.bodyMedium,
          ),
          Text(
            switch (outcome) {
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
          if (state == FeedbackSummaryState.rejected) ...<Widget>[
            const SizedBox(height: CauceSpacing.space4),
            const _RejectedNotice(),
            const SizedBox(height: CauceSpacing.space2),
            CauceButton.tertiary(
              key: const Key('recommendation_feedback_answer_again'),
              label: l10n.recommendationFeedbackAnswerAgain,
              onPressed: onAnswerAgain,
            ),
          ],
        ],
      ),
    );
  }
}

/// Aviso de rechazo con los tokens del banner de error del design system.
class _RejectedNotice extends StatelessWidget {
  const _RejectedNotice();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: CauceColors.dangerText,
        );
    return Container(
      key: const Key('recommendation_feedback_rejected'),
      width: double.infinity,
      padding: const EdgeInsets.all(CauceSpacing.space3),
      decoration: const BoxDecoration(
        color: CauceColors.dangerBg,
        borderRadius: CauceRadii.borderMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            TablerIcons.alert_circle,
            color: CauceColors.dangerText,
            size: 20,
          ),
          const SizedBox(width: CauceSpacing.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.recommendationFeedbackRejectedTitle,
                  style: style?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(l10n.recommendationFeedbackRejectedBody, style: style),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
