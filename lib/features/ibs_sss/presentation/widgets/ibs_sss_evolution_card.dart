import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/ibs_sss_assessment.dart';

/// Evolucion del puntaje IBS-SSS (US12 CA03).
///
/// Combina el grafico con el dato en texto. El grafico muestra la **forma** de
/// la serie; los numeros van al lado, donde se pueden leer y donde un lector de
/// pantalla los alcanza.
///
/// El eje vertical se fija en la escala completa del instrumento, 0 a 500, y no
/// en los extremos de la serie. Con dos evaluaciones parecidas el encuadre
/// automatico exagera una diferencia clinicamente irrelevante hasta que parece
/// un derrumbe, y este grafico lo va a mirar un paciente sin su nutricionista
/// al lado.
class IbsSssEvolutionCard extends StatelessWidget {
  const IbsSssEvolutionCard({required this.points, super.key});

  final List<IbsSssEvolutionPoint> points;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: const Key('ibs_sss_evolution'),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderLg,
        border: Border.all(color: CauceColors.bgDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.ibsSssEvolutionTitle, style: textTheme.titleMedium),
          const SizedBox(height: CauceSpacing.space3),
          if (points.length < 2)
            Text(
              l10n.ibsSssEvolutionEmpty,
              key: const Key('ibs_sss_evolution_empty'),
              style: textTheme.bodyMedium?.copyWith(
                color: CauceColors.textSecondary,
              ),
            )
          else ...<Widget>[
            CauceSparkline(
              key: const Key('ibs_sss_evolution_sparkline'),
              points: <CauceSparklinePoint>[
                for (final point in points)
                  CauceSparklinePoint(
                    value: point.totalScore.toDouble(),
                    label: '${point.totalScore}',
                    highlighted:
                        point.assessmentType == IbsSssAssessmentType.baseline,
                  ),
              ],
              minValue: IbsSssScale.totalMin.toDouble(),
              maxValue: IbsSssScale.totalMax.toDouble(),
              semanticLabel: l10n.ibsSssEvolutionRange(
                points.first.totalScore,
                points.last.totalScore,
              ),
            ),
            const SizedBox(height: CauceSpacing.space2),
            Text(
              l10n.ibsSssEvolutionRange(
                points.first.totalScore,
                points.last.totalScore,
              ),
              key: const Key('ibs_sss_evolution_range'),
              style: textTheme.bodyMedium,
            ),
          ],
          ..._deltaSection(l10n, textTheme),
        ],
      ),
    );
  }

  /// Diferencia contra la linea base, cuando el servidor la informa.
  ///
  /// `deltaFromBaseline` llega `null` para la propia linea base y cuando el
  /// paciente todavia no tiene una: en esos casos no hay nada que comparar y la
  /// seccion no aparece.
  List<Widget> _deltaSection(AppLocalizations l10n, TextTheme textTheme) {
    if (points.isEmpty) {
      return const <Widget>[];
    }

    final latest = points.last;
    final delta = latest.deltaFromBaseline;
    if (delta == null) {
      return const <Widget>[];
    }

    return <Widget>[
      const SizedBox(height: CauceSpacing.space2),
      Text(
        l10n.ibsSssEvolutionDelta(delta),
        key: const Key('ibs_sss_evolution_delta'),
        style: textTheme.bodyMedium,
      ),
      // La mejoria clinicamente significativa se enuncia como dato, no como
      // felicitacion: quien la interpreta es el nutricionista, y celebrarla
      // aca cargaria de sentido un numero que el paciente no tiene contexto
      // para leer solo.
      if (latest.isClinicallySignificantImprovement) ...<Widget>[
        const SizedBox(height: CauceSpacing.space1),
        Text(
          l10n.ibsSssEvolutionImprovement,
          key: const Key('ibs_sss_evolution_improvement'),
          style: textTheme.bodySmall?.copyWith(
            color: CauceColors.textSecondary,
          ),
        ),
      ],
    ];
  }
}
