import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../onboarding/presentation/widgets/onboarding_labels.dart';
import '../application/periodic_assessment_notifier.dart';
import '../domain/ibs_sss_evolution_series.dart';
import 'widgets/ibs_sss_evolution_chart.dart';

/// Evolucion del puntaje IBS-SSS (HU0023).
///
/// **Es la primera pantalla del proyecto construida sin mockup.** El design
/// system no tiene una seccion para ella y `docs/03-mockups/mobile/` no la
/// incluye: el set se cierra en P12. La estructura sale de CP060 y CP061, que
/// son la especificacion aprobada.
///
/// Dos estados, y los dos son normales:
///
/// - **CP060**, con dos evaluaciones o mas: la linea de tiempo, el cambio
///   porcentual contra la linea base y el filtro de rango.
/// - **CP061**, con solo la linea base: su puntaje, por que todavia no hay
///   grafico, y cuando toca la proxima evaluacion.
class EvolutionScreen extends ConsumerStatefulWidget {
  const EvolutionScreen({super.key});

  @override
  ConsumerState<EvolutionScreen> createState() => _EvolutionScreenState();
}

class _EvolutionScreenState extends ConsumerState<EvolutionScreen> {
  /// Rango elegido. Arranca en la serie completa (decision 3.2 del bloque).
  IbsSssEvolutionRange _range = IbsSssEvolutionRange.all;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final evolution = ref.watch(ibsSssEvolutionProvider);

    return CauceScaffold(
      appBar: CauceAppBar(
        title: l10n.ibsSssEvolutionTitle,
        showBackButton: true,
      ),
      scrollable: true,
      body: evolution.when(
        loading: () => CauceLoadingIndicator.fullscreen(
          message: l10n.commonLoading,
        ),
        error: (error, _) => _LoadFailure(error: error),
        data: (points) {
          final series = IbsSssEvolutionSeries.from(points);

          if (series.isEmpty) {
            return CauceEmptyState(
              key: const Key('evolution_empty'),
              icon: TablerIcons.chart_line,
              title: l10n.ibsSssEvolutionTitle,
              message: l10n.evolutionEmpty,
            );
          }

          // CP061: con una sola evaluacion no hay linea que dibujar.
          if (!series.hasTimeline) {
            return _BaselineOnly(series: series);
          }

          return _Timeline(
            series: series,
            range: _range,
            onRangeChanged: (value) => setState(() => _range = value),
          );
        },
      ),
    );
  }
}

/// Fallo de carga, con su reintento.
class _LoadFailure extends ConsumerWidget {
  const _LoadFailure({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final failure = error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (failure is CauceApiError)
          CauceErrorBanner(error: failure)
        else
          Text(l10n.evolutionLoadError, textAlign: TextAlign.center),
        const SizedBox(height: CauceSpacing.space4),
        CauceButton.secondary(
          key: const Key('evolution_retry'),
          label: l10n.commonRetry,
          onPressed: () => ref.invalidate(ibsSssEvolutionProvider),
        ),
      ],
    );
  }
}

/// CP061: solo linea base.
///
/// Muestra el puntaje que el paciente si tiene, explica que el grafico llega
/// despues de la primera periodica, y anuncia cuando es. La fecha no se
/// calcula: la agenda el backend y viaja en la propia entrada de la serie.
class _BaselineOnly extends StatelessWidget {
  const _BaselineOnly({required this.series});

  final IbsSssEvolutionSeries series;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final baseline = series.baseline ?? series.points.first;
    final next = series.nextAssessmentDate;

    return Container(
      key: const Key('evolution_baseline_only'),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.evolutionBaselineOnlyTitle, style: textTheme.titleMedium),
          const SizedBox(height: CauceSpacing.space2),
          Text(
            l10n.evolutionScore(baseline.totalScore),
            key: const Key('evolution_baseline_score'),
            style: textTheme.headlineSmall?.copyWith(
              color: CauceColors.brandBase,
            ),
          ),
          const SizedBox(height: CauceSpacing.space3),
          Text(l10n.evolutionBaselineOnlyBody, style: textTheme.bodyMedium),
          if (next != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space4),
            Row(
              children: <Widget>[
                const Icon(
                  TablerIcons.calendar_event,
                  size: 18,
                  color: CauceColors.brandBase,
                ),
                const SizedBox(width: CauceSpacing.space2),
                Expanded(
                  child: Text(
                    l10n.evolutionNextAssessment(
                      OnboardingLabels.date(next.toLocal()),
                    ),
                    key: const Key('evolution_next_assessment'),
                    style: textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

/// CP060: cambio porcentual, filtro y linea de tiempo.
class _Timeline extends StatelessWidget {
  const _Timeline({
    required this.series,
    required this.range,
    required this.onRangeChanged,
  });

  final IbsSssEvolutionSeries series;
  final IbsSssEvolutionRange range;
  final ValueChanged<IbsSssEvolutionRange> onRangeChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final visible = series.within(range);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _PercentChange(series: series),
        const SizedBox(height: CauceSpacing.space6),
        CauceChoiceField<IbsSssEvolutionRange>(
          key: const Key('evolution_range'),
          label: l10n.evolutionRangeLabel,
          value: range,
          onChanged: onRangeChanged,
          choices: <CauceChoice<IbsSssEvolutionRange>>[
            CauceChoice<IbsSssEvolutionRange>(
              value: IbsSssEvolutionRange.lastMonth,
              label: l10n.evolutionRangeLastMonth,
            ),
            CauceChoice<IbsSssEvolutionRange>(
              value: IbsSssEvolutionRange.lastQuarter,
              label: l10n.evolutionRangeLastQuarter,
            ),
            CauceChoice<IbsSssEvolutionRange>(
              value: IbsSssEvolutionRange.all,
              label: l10n.evolutionRangeAll,
            ),
          ],
        ),
        const SizedBox(height: CauceSpacing.space4),
        if (visible.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: CauceSpacing.space6),
            child: Text(
              l10n.evolutionRangeEmpty,
              key: const Key('evolution_range_empty'),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          )
        else
          IbsSssEvolutionChart(points: visible),
      ],
    );
  }
}

/// Cambio porcentual contra la linea base.
///
/// **No depende del filtro.** Cambiar el rango cambia que puntos se dibujan, no
/// este numero: CP060 lo pide contra la linea base real.
class _PercentChange extends StatelessWidget {
  const _PercentChange({required this.series});

  final IbsSssEvolutionSeries series;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final percent = series.percentChangeFromBaseline;

    return Container(
      key: const Key('evolution_percent_change'),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.evolutionPercentLabel, style: textTheme.labelSmall),
          const SizedBox(height: CauceSpacing.space2),
          Text(
            _label(l10n, percent),
            key: const Key('evolution_percent_value'),
            style: textTheme.headlineSmall?.copyWith(
              // Verde solo si bajo. Un empeoramiento va en el color de texto
              // normal y nunca en rojo, igual que en Perfil.
              color: percent != null && percent < 0
                  ? CauceColors.fodmapLowText
                  : CauceColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _label(AppLocalizations l10n, double? percent) {
    if (percent == null || percent == 0) {
      return l10n.evolutionPercentSame;
    }

    final magnitude = percent.abs().toStringAsFixed(1);
    return percent < 0
        ? l10n.evolutionPercentDown(magnitude)
        : l10n.evolutionPercentUp(magnitude);
  }
}
