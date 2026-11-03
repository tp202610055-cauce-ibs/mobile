import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../symptoms/presentation/widgets/symptom_labels.dart';
import '../../application/recommendation_symptom_breakdown.dart';
import '../../domain/recommendation.dart';
import '../../domain/symptom_breakdown.dart';
import 'recommendation_detail_sections.dart';

/// Cifras de respaldo (bloque 4): numero en mono de marca y su contexto.
/// Los sintomas van por tipo; mientras no se puedan contar, va el total.
class RecommendationSupportingDataCard extends ConsumerWidget {
  const RecommendationSupportingDataCard({
    required this.recommendationId,
    required this.data,
    super.key,
  });

  final String recommendationId;
  final RecommendationSupportingData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final days = data.windowDays;
    final breakdown = ref
        .watch(recommendationSymptomBreakdownProvider(recommendationId))
        .valueOrNull;

    return RecommendationSectionCard(
      key: const Key('recommendation_supporting_data'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          ..._symptomRows(l10n, breakdown, days),
          _DataRow(
            key: const Key('recommendation_data_meals'),
            number: '${data.mealCount}',
            label: l10n.recommendationDataMeals(data.mealCount, days),
          ),
          _DataRow(
            key: const Key('recommendation_data_window'),
            number: l10n.recommendationDataHours(data.correlationWindowHours),
            label: l10n.recommendationDataWindow,
          ),
          if (data.topHighFodmapFoods.isNotEmpty)
            Text(
              l10n.recommendationDataTopFoods(
                data.topHighFodmapFoods.join(', '),
              ),
              key: const Key('recommendation_data_top_foods'),
              style: textTheme.bodySmall?.copyWith(
                color: CauceColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  List<Widget> _symptomRows(
    AppLocalizations l10n,
    SymptomBreakdown? breakdown,
    int days,
  ) {
    if (breakdown == null || breakdown.leading.isEmpty) {
      return <Widget>[
        _DataRow(
          key: const Key('recommendation_data_symptoms'),
          number: '${data.symptomCount}',
          label: l10n.recommendationDataSymptoms(data.symptomCount, days),
        ),
      ];
    }
    return <Widget>[
      for (final (:type, :count) in breakdown.leading)
        _DataRow(
          key: Key('recommendation_data_symptoms_${type.name}'),
          number: '$count',
          label: l10n.recommendationDataSymptomsOfType(
            count,
            _lowerFirst(SymptomLabels.symptomType(l10n, type)),
            days,
          ),
        ),
      if (breakdown.others > 0)
        _DataRow(
          key: const Key('recommendation_data_symptoms_others'),
          number: '${breakdown.others}',
          label: l10n.recommendationDataSymptomsOther(breakdown.others, days),
        ),
    ];
  }

  static String _lowerFirst(String text) => text.isEmpty
      ? text
      : '${text.substring(0, 1).toLowerCase()}${text.substring(1)}';
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.number, required this.label, super.key});

  final String number;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CauceSpacing.space2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          SizedBox(
            width: 44,
            child: Text(
              number,
              textAlign: TextAlign.right,
              style: CauceTypography.mono.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: CauceColors.brandBase,
              ),
            ),
          ),
          const SizedBox(width: CauceSpacing.space3),
          Expanded(
            child: Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CauceColors.textSecondary,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
