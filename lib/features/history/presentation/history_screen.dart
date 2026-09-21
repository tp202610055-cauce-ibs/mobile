import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../onboarding/application/onboarding_notifier.dart';
import '../application/history_notifier.dart';
import '../domain/history_entry.dart';
import 'widgets/history_cards.dart';

/// Pestana de Diario: el registro unificado de comidas y sintomas.
///
/// Lista unica y no pestanas separadas por tipo: lo que el paciente quiere
/// reconstruir es la secuencia de su dia, donde una comida y el sintoma que
/// vino despues se leen juntos. Separarlos obligaria a cruzar dos listas a
/// mano.
///
/// Se agrupa por dia con **Hoy primero**, que es lo que CP022 paso 2 llama "el
/// diario clinico del dia". Los dias anteriores quedan debajo, en orden
/// descendente.
class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(historyNotifierProvider.notifier).load();
    });
  }

  void _openMealForm() => context.push(AppRoutes.mealNew);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(historyNotifierProvider);
    final notifier = ref.read(historyNotifierProvider.notifier);
    final onboarding = ref.watch(resolvedOnboardingProvider);

    // HU0003 CA01: guardar el perfil clinico habilita el diario. La
    // restriccion explica y ofrece el camino, nunca se queda en un cartel.
    if (!onboarding.allowsJournal) {
      return CauceScaffold(
        appBar: CauceAppBar(title: l10n.historyTitle),
        body: CauceEmptyState(
          key: const Key('history_locked'),
          icon: TablerIcons.lock,
          title: l10n.journalLockedTitle,
          message: l10n.journalLockedBody,
          actionLabel: l10n.journalLockedAction,
          onAction: () =>
              ref.read(onboardingNotifierProvider.notifier).resume(),
        ),
      );
    }

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.historyTitle),
      padding: EdgeInsets.zero,
      body: RefreshIndicator(
        // Reemplaza al boton de "Actualizar" que tenia la pantalla: el gesto
        // de tirar para refrescar es el que un paciente ya conoce, y libera
        // el pie de la lista.
        color: CauceColors.brandBase,
        onRefresh: notifier.load,
        child: _Body(
          state: state,
          onDiscard: notifier.discard,
          onOpenMealForm: _openMealForm,
        ),
      ),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body({
    required this.state,
    required this.onDiscard,
    required this.onOpenMealForm,
  });

  final HistoryState state;
  final Future<void> Function(String clientGuid) onDiscard;
  final VoidCallback onOpenMealForm;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (state.loading && state.entries.isEmpty) {
      return const CauceLoadingIndicator.fullscreen();
    }

    final groups = _groupByDay(state.entries);
    final today = _dayOf(DateTime.now().toLocal());
    final hasToday = groups.isNotEmpty && groups.first.day == today;

    return ListView(
      // Siempre desplazable, incluso vacia: sin esto el gesto de refrescar no
      // funciona justamente cuando el paciente mas lo necesita.
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: CauceSpacing.space4,
        vertical: CauceSpacing.space4,
      ),
      children: <Widget>[
        // Un fallo del servidor no vacia la lista: lo registrado en el
        // dispositivo sigue ahi, que es lo que el paciente no puede consultar
        // en ningun otro lado.
        if (state.error != null) ...<Widget>[
          CauceErrorBanner(error: state.error!),
          const SizedBox(height: CauceSpacing.space4),
        ],

        // Sin un solo registro, el estado vacio completo de la seccion I.
        if (state.entries.isEmpty)
          CauceEmptyState(
            key: const Key('history_empty'),
            icon: TablerIcons.bowl,
            title: l10n.historyEmptyTodayTitle,
            message: l10n.historyEmptyTodayBody,
            actionLabel: l10n.historyEmptyTodayAction,
            onAction: onOpenMealForm,
          )
        else ...<Widget>[
          // Hoy sin registros pero con dias anteriores: una invitacion corta
          // con el mismo destino, sin el bloque entero, que empujaria el
          // historial fuera de la pantalla.
          if (!hasToday) ...<Widget>[
            _DayHeading(label: l10n.historyToday),
            _TodayInvitation(onTap: onOpenMealForm),
            const SizedBox(height: CauceSpacing.space4),
          ],
          for (final group in groups) ...<Widget>[
            _DayHeading(
              label: group.day == today
                  ? l10n.historyToday
                  : _formatDay(context, group.day),
            ),
            for (final (index, entry) in group.entries.indexed)
              HistoryCard(
                key: Key('history_entry_${group.day.toIso8601String()}_$index'),
                entry: entry,
                onDiscard: entry.clientGuid == null
                    ? null
                    : () => onDiscard(entry.clientGuid!),
                onAddNote: () => context.push(
                  AppRoutes.clinicalNoteNew,
                  extra: entry,
                ),
              ),
            const SizedBox(height: CauceSpacing.space2),
          ],
        ],
      ],
    );
  }
}

/// Encabezado de un grupo del diario.
class _DayHeading extends StatelessWidget {
  const _DayHeading({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: CauceSpacing.space3),
      child: Text(label, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

/// Invitacion corta cuando hoy no tiene registros pero el historial si.
class _TodayInvitation extends StatelessWidget {
  const _TodayInvitation({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: const Key('history_today_invitation'),
      margin: const EdgeInsets.only(bottom: CauceSpacing.space3),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: const BoxDecoration(
        color: CauceColors.bgSubtle,
        borderRadius: CauceRadii.borderLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.historyTodayNothingYet, style: textTheme.bodyMedium),
          const SizedBox(height: CauceSpacing.space2),
          CauceButton.tertiary(
            key: const Key('history_today_log_meal'),
            label: l10n.historyEmptyTodayAction,
            onPressed: onTap,
          ),
        ],
      ),
    );
  }
}

/// Un dia del diario con sus entradas, ya ordenadas.
typedef _DayGroup = ({DateTime day, List<HistoryEntry> entries});

DateTime _dayOf(DateTime value) => DateTime(value.year, value.month, value.day);

/// Agrupa por dia local, de mas reciente a mas antiguo.
///
/// El dia se calcula sobre la hora **local** y no sobre UTC: un registro de
/// las 22:00 de Lima cae al dia siguiente en UTC, y el paciente lo buscaria
/// bajo el dia en que lo vivio.
List<_DayGroup> _groupByDay(List<HistoryEntry> entries) {
  final byDay = <DateTime, List<HistoryEntry>>{};
  for (final entry in entries) {
    final day = _dayOf(entry.occurredAt.toLocal());
    byDay.putIfAbsent(day, () => <HistoryEntry>[]).add(entry);
  }

  final days = byDay.keys.toList()..sort((a, b) => b.compareTo(a));
  return <_DayGroup>[
    for (final day in days)
      (
        day: day,
        entries: byDay[day]!
          ..sort((a, b) => b.occurredAt.compareTo(a.occurredAt)),
      ),
  ];
}

/// Fecha del encabezado, en el locale de la aplicacion.
String _formatDay(BuildContext context, DateTime day) {
  return DateFormat.yMMMMd(
    Localizations.localeOf(context).toLanguageTag(),
  ).format(day);
}
