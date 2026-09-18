import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../history/domain/history_entry.dart';
import '../application/clinical_note_form_notifier.dart';

/// Nota de contexto sobre una comida o un sintoma (US13 CA01 y CA02).
///
/// Llega desde el historial con la entrada a la que se adjunta. Esa entrada ya
/// esta sincronizada: el historial no ofrece la accion para las que no lo
/// estan, porque `CreateClinicalNoteRequest` exige un identificador del
/// servidor.
class ClinicalNoteFormScreen extends ConsumerStatefulWidget {
  const ClinicalNoteFormScreen({required this.entry, super.key});

  final HistoryEntry entry;

  @override
  ConsumerState<ClinicalNoteFormScreen> createState() =>
      _ClinicalNoteFormScreenState();
}

class _ClinicalNoteFormScreenState
    extends ConsumerState<ClinicalNoteFormScreen> {
  final TextEditingController _content = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final serverId = widget.entry.serverId;
      ref.read(clinicalNoteFormNotifierProvider.notifier).attachTo(
            mealId:
                widget.entry.kind == HistoryEntryKind.meal ? serverId : null,
            symptomId:
                widget.entry.kind == HistoryEntryKind.symptom ? serverId : null,
          );
    });
  }

  @override
  void dispose() {
    _content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(clinicalNoteFormNotifierProvider);
    final notifier = ref.read(clinicalNoteFormNotifierProvider.notifier);

    if (state.createdId != null) {
      return CauceScaffold(
        appBar: CauceAppBar(title: l10n.clinicalNoteTitle),
        scrollable: true,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              l10n.clinicalNoteSaved,
              key: const Key('clinical_note_saved'),
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: CauceSpacing.space6),
            CauceButton(
              key: const Key('clinical_note_back'),
              label: l10n.commonBack,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      );
    }

    final overLimit = state.remaining < 0;

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.clinicalNoteTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (state.error != null) ...<Widget>[
            CauceErrorBanner(error: state.error!),
            const SizedBox(height: CauceSpacing.space4),
          ],
          Text(
            l10n.clinicalNoteSubtitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceTextField(
            key: const Key('clinical_note_content'),
            controller: _content,
            label: l10n.clinicalNoteContentLabel,
            hint: l10n.clinicalNoteContentHint,
            maxLines: 5,
            enabled: !state.submitting,
            // El texto **no** se recorta al tope: se deja escribir y se avisa.
            // Truncar en silencio le borraria al paciente lo que acaba de
            // escribir sin decirle por que (CA02).
            errorText: overLimit ? l10n.clinicalNoteTooLong : null,
            onChanged: notifier.setContent,
          ),
          const SizedBox(height: CauceSpacing.space2),
          Text(
            l10n.clinicalNoteRemaining(state.remaining),
            key: const Key('clinical_note_counter'),
            textAlign: TextAlign.right,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: overLimit
                      ? CauceColors.dangerText
                      : CauceColors.textSecondary,
                ),
          ),
          const SizedBox(height: CauceSpacing.space6),
          CauceButton(
            key: const Key('clinical_note_submit'),
            label: l10n.clinicalNoteSubmit,
            loading: state.submitting,
            onPressed: state.canSubmit ? notifier.submit : null,
          ),
        ],
      ),
    );
  }
}
