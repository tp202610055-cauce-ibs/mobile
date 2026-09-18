import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../meals/presentation/widgets/meal_labels.dart';
import '../../symptoms/presentation/widgets/symptom_labels.dart';
import '../application/history_notifier.dart';
import '../domain/history_entry.dart';

/// Historial unificado de comidas y sintomas.
///
/// Sirve a dos cosas: que el paciente vea lo que registro, y que pueda llegar a
/// un registro pasado para adjuntarle una nota de contexto (US13).
///
/// Lista unica y no pestanas separadas: lo que el paciente quiere reconstruir
/// es la secuencia de su dia, donde una comida y el sintoma que vino despues se
/// leen juntos. Separarlos por tipo obligaria a cruzar dos listas a mano.
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(historyNotifierProvider);
    final notifier = ref.read(historyNotifierProvider.notifier);

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.historyTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Un fallo del servidor no vacia la lista: lo registrado en el
          // dispositivo sigue ahi, que es lo que el paciente no puede consultar
          // en ningun otro lado.
          if (state.error != null) ...<Widget>[
            CauceErrorBanner(error: state.error!),
            const SizedBox(height: CauceSpacing.space4),
          ],
          if (state.loading && state.entries.isEmpty)
            const CauceLoadingIndicator.fullscreen()
          else if (state.entries.isEmpty)
            Text(
              l10n.historyEmpty,
              key: const Key('history_empty'),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CauceColors.textSecondary,
                  ),
            )
          else
            for (final (index, entry) in state.entries.indexed)
              _EntryCard(
                key: Key('history_entry_$index'),
                entry: entry,
                onDiscard: entry.clientGuid == null
                    ? null
                    : () => notifier.discard(entry.clientGuid!),
                onAddNote: () => context.push(
                  AppRoutes.clinicalNoteNew,
                  extra: entry,
                ),
              ),
          const SizedBox(height: CauceSpacing.space6),
          CauceButton.tertiary(
            key: const Key('history_refresh'),
            label: l10n.historyRefresh,
            onPressed: notifier.load,
          ),
        ],
      ),
    );
  }
}

class _EntryCard extends StatelessWidget {
  const _EntryCard({
    required this.entry,
    required this.onDiscard,
    required this.onAddNote,
    super.key,
  });

  final HistoryEntry entry;
  final VoidCallback? onDiscard;
  final VoidCallback onAddNote;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final when = DateFormat.yMMMd().add_Hm().format(entry.occurredAt.toLocal());

    return Container(
      margin: const EdgeInsets.only(bottom: CauceSpacing.space3),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderLg,
        border: Border.all(color: CauceColors.bgDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(_title(l10n), style: textTheme.titleMedium),
          const SizedBox(height: CauceSpacing.space1),
          Text(
            when,
            style: textTheme.bodySmall?.copyWith(
              color: CauceColors.textSecondary,
            ),
          ),
          ..._details(context, l10n, textTheme),
          if (entry.syncState != HistoryEntrySyncState.synced) ...<Widget>[
            const SizedBox(height: CauceSpacing.space2),
            Text(
              entry.syncState == HistoryEntrySyncState.pending
                  ? l10n.historyStatePending
                  : l10n.historyStateFailed,
              key: Key(
                entry.syncState == HistoryEntrySyncState.pending
                    ? 'history_state_pending'
                    : 'history_state_failed',
              ),
              style: textTheme.labelMedium?.copyWith(
                color: CauceColors.textSecondary,
              ),
            ),
          ],
          // Una fila terminal necesita una salida, no solo un cartel: sin el
          // descarte el atasco se vuelve visible pero no se resuelve.
          if (entry.isDiscardable) ...<Widget>[
            const SizedBox(height: CauceSpacing.space1),
            Text(l10n.historyFailedExplanation, style: textTheme.bodySmall),
            const SizedBox(height: CauceSpacing.space2),
            CauceButton.tertiary(
              key: const Key('history_discard'),
              label: l10n.historyDiscard,
              onPressed: onDiscard,
            ),
          ],
          const SizedBox(height: CauceSpacing.space2),
          // US13 exige un mealId o symptomId **del servidor**. Sin sincronizar
          // no existe, y dejar el boton activo llevaria a un 404 despues de
          // escribir la nota.
          if (entry.acceptsNote)
            CauceButton.tertiary(
              key: const Key('history_add_note'),
              label: l10n.historyAddNote,
              onPressed: onAddNote,
            )
          else
            Text(
              l10n.historyNoteUnavailable,
              key: const Key('history_note_unavailable'),
              style: textTheme.labelSmall?.copyWith(
                color: CauceColors.textTertiary,
              ),
            ),
        ],
      ),
    );
  }

  String _title(AppLocalizations l10n) {
    return switch (entry.kind) {
      HistoryEntryKind.meal => entry.mealTime == null
          ? l10n.mealsTitle
          : MealLabels.mealTime(l10n, entry.mealTime!),
      HistoryEntryKind.symptom => entry.symptomType == null
          ? l10n.symptomsTitle
          : SymptomLabels.symptomType(l10n, entry.symptomType!),
    };
  }

  List<Widget> _details(
    BuildContext context,
    AppLocalizations l10n,
    TextTheme textTheme,
  ) {
    return switch (entry.kind) {
      HistoryEntryKind.meal => <Widget>[
          if (entry.itemNames.isNotEmpty) ...<Widget>[
            const SizedBox(height: CauceSpacing.space2),
            Text(entry.itemNames.join(', '), style: textTheme.bodyMedium),
          ],
          if (entry.aggregatedFodmap != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space1),
            Text(
              MealLabels.fodmapLoad(l10n, entry.aggregatedFodmap!),
              style: textTheme.bodySmall?.copyWith(
                color: CauceColors.textSecondary,
              ),
            ),
          ],
        ],
      HistoryEntryKind.symptom => <Widget>[
          if (entry.intensity != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space2),
            Text(
              l10n.historyMealIntensity(entry.intensity!),
              style: textTheme.bodyMedium,
            ),
          ],
          if (entry.hasMealAssociation ?? false) ...<Widget>[
            const SizedBox(height: CauceSpacing.space1),
            Text(
              l10n.historyMealAssociated,
              key: const Key('history_meal_associated'),
              style: textTheme.bodySmall?.copyWith(
                color: CauceColors.textSecondary,
              ),
            ),
          ],
        ],
    };
  }
}
