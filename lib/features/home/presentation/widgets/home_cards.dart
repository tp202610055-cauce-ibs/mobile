import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../history/application/history_notifier.dart';
import '../../../history/domain/history_entry.dart';
import '../../../ibs_sss/application/periodic_assessment_notifier.dart';
import '../../../ibs_sss/domain/ibs_sss_assessment.dart';

/// Tarjeta del puntaje IBS-SSS (mockup `06-home-dashboard`, version minima).
///
/// Muestra lo que ya existe en el dispositivo: el ultimo puntaje, el cambio
/// contra la linea base y cuando toca el proximo cuestionario. **Sin
/// endpoints nuevos**: los dos providers que alimenta ya se consumian.
///
/// **Encuadre neutro, deliberado.** No hay verde de felicitacion ni rojo de
/// alarma sobre el puntaje: es el mismo criterio con el que se dibujo
/// `CauceSparkline`, porque esto lo mira un paciente sin su nutricionista al
/// lado. El numero se informa; interpretarlo es de la consulta.
///
/// El grafico grande con eje temporal y el porcentaje contra la linea base
/// llegan en Mobile-4 con HU0023.
class HomeScoreCard extends ConsumerWidget {
  const HomeScoreCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final latest = ref.watch(latestIbsSssAssessmentProvider).valueOrNull;
    final evolution = ref.watch(ibsSssEvolutionProvider).valueOrNull;

    // Mientras no resuelve, no se dibuja nada. Una tarjeta con un hueco es
    // peor que ninguna tarjeta.
    if (latest == null) {
      return const SizedBox.shrink();
    }

    final delta =
        evolution?.isEmpty ?? true ? null : evolution!.last.deltaFromBaseline;
    final due = latest.nextAssessmentDate;

    return _Card(
      cardKey: const Key('home_score_card'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.homeScoreTitle, style: textTheme.labelLarge),
          const SizedBox(height: CauceSpacing.space2),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              Text(
                '${latest.totalScore}',
                key: const Key('home_score_value'),
                style: textTheme.displayLarge?.copyWith(
                  color: CauceColors.brandStrong,
                ),
              ),
              const SizedBox(width: CauceSpacing.space2),
              Text('/ ${IbsSssScale.totalMax}', style: textTheme.labelSmall),
            ],
          ),
          const SizedBox(height: CauceSpacing.space2),
          Text(
            // Sin delta, el paciente esta en su linea base: se dice eso, que
            // es informacion, en vez de dejar el hueco.
            delta == null
                ? l10n.homeScoreBaseline
                : l10n.homeScoreDelta(_signed(delta)),
            style: textTheme.bodyMedium,
          ),
          if (due != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space3),
            Row(
              children: <Widget>[
                Icon(
                  latest.isDue()
                      ? TablerIcons.clipboard_text
                      : TablerIcons.calendar,
                  size: 16,
                  color: CauceColors.textTertiary,
                ),
                const SizedBox(width: CauceSpacing.space2),
                Flexible(
                  child: Text(
                    latest.isDue()
                        ? l10n.homeScoreDue
                        : l10n.homeScoreNext(_date(context, due)),
                    style: textTheme.labelSmall,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  /// El signo se muestra siempre: "-70" y "+15" se leen distinto de "70".
  static String _signed(int delta) => delta > 0 ? '+$delta' : '$delta';

  static String _date(BuildContext context, DateTime value) => DateFormat.yMMMd(
        Localizations.localeOf(context).toLanguageTag(),
      ).format(value.toLocal());
}

/// Resumen de lo registrado hoy, con la puerta al Diario.
///
/// Lee el mismo `HistoryNotifier` que el Diario, de modo que no agrega ni una
/// peticion: lo que ya esta cargado se cuenta y se muestra.
class HomeTodayCard extends ConsumerWidget {
  const HomeTodayCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final entries = ref.watch(historyNotifierProvider).entries;

    final today = DateTime.now().toLocal();
    final hoy = entries.where((HistoryEntry entry) {
      final when = entry.occurredAt.toLocal();
      return when.year == today.year &&
          when.month == today.month &&
          when.day == today.day;
    }).toList();

    final comidas = hoy.where((e) => e.kind == HistoryEntryKind.meal).length;
    final sintomas =
        hoy.where((e) => e.kind == HistoryEntryKind.symptom).length;

    return _Card(
      cardKey: const Key('home_today_card'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.homeTodayTitle, style: textTheme.labelLarge),
          const SizedBox(height: CauceSpacing.space2),
          Text(
            hoy.isEmpty
                ? l10n.homeTodayEmpty
                : '${l10n.homeTodayMeals(comidas)}, '
                    '${l10n.homeTodaySymptoms(sintomas)}',
            key: const Key('home_today_summary'),
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: CauceSpacing.space3),
          Align(
            alignment: Alignment.centerLeft,
            child: CauceButton.tertiary(
              key: const Key('home_open_journal'),
              label: l10n.homeTodayOpen,
              // `go` y no `push`: el Diario es una pestana, no una pantalla
              // que se apila encima de Inicio.
              onPressed: () => context.go(AppRoutes.history),
            ),
          ),
        ],
      ),
    );
  }
}

/// Contenedor comun de las tarjetas de Inicio, con el registro del design
/// system: superficie de tarjeta, radio grande y borde sutil.
class _Card extends StatelessWidget {
  const _Card({required this.cardKey, required this.child});

  final Key cardKey;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: cardKey,
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: CauceSpacing.space4),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderLg,
        border: Border.all(
          color: CauceColors.bgDivider,
          width: CauceBorders.subtle,
        ),
      ),
      child: child,
    );
  }
}
