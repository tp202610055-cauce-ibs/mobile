import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/symptom_form_notifier.dart';
import '../domain/symptom_draft.dart';
import 'widgets/symptom_labels.dart';

/// Registro de un sintoma (US11 CA01 y CA02).
class SymptomFormScreen extends ConsumerWidget {
  const SymptomFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(symptomFormNotifierProvider);
    final notifier = ref.read(symptomFormNotifierProvider.notifier);

    if (state.outcome == SymptomSubmitOutcome.registered ||
        state.outcome == SymptomSubmitOutcome.queuedOffline) {
      return _SymptomConfirmation(state: state, onAgain: notifier.reset);
    }

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.symptomsTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (state.error != null) ...<Widget>[
            CauceErrorBanner(error: state.error!),
            const SizedBox(height: CauceSpacing.space4),
          ],
          CauceChoiceField<SymptomTypeOption>(
            key: const Key('symptom_type_field'),
            label: l10n.symptomsTypeLabel,
            value: state.draft.symptomType,
            enabled: !state.submitting,
            onChanged: notifier.selectType,
            choices: <CauceChoice<SymptomTypeOption>>[
              for (final option in SymptomTypeOption.values)
                CauceChoice<SymptomTypeOption>(
                  value: option,
                  label: SymptomLabels.symptomType(l10n, option),
                ),
            ],
          ),
          const SizedBox(height: CauceSpacing.space6),
          Text(
            l10n.symptomsIntensityLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: CauceSpacing.space2),
          // `min: 1` y no el default de 0: el backend rechaza la intensidad
          // cero (`Symptom.MinIntensity`), y ofrecerla seria ofrecer un valor
          // que termina en un 400.
          CauceSlider(
            key: const Key('symptom_intensity_field'),
            value: state.draft.intensity,
            // De diez en diez, no de uno en uno (acta M40). El dominio sigue
            // aceptando 1 a 100, que es lo que valida el backend: la escala
            // de la pantalla es un subconjunto suyo.
            min: SymptomDraft.intensityStep,
            max: SymptomDraft.maxIntensity,
            step: SymptomDraft.intensityStep,
            enabled: !state.submitting,
            onChanged: notifier.setIntensity,
            minLabel: l10n.symptomsIntensityMin,
            maxLabel: l10n.symptomsIntensityMax,
            semanticLabel: l10n.symptomsIntensityLabel,
          ),
          const SizedBox(height: CauceSpacing.space6),
          for (final issue in state.issues)
            Padding(
              padding: const EdgeInsets.only(bottom: CauceSpacing.space1),
              child: Text(
                SymptomLabels.issue(l10n, issue),
                key: Key('symptom_issue_${issue.name}'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: CauceColors.textSecondary,
                    ),
              ),
            ),
          const SizedBox(height: CauceSpacing.space3),
          CauceButton(
            key: const Key('symptom_submit'),
            label: l10n.symptomsSubmit,
            loading: state.submitting,
            onPressed: state.canSubmit ? notifier.submit : null,
          ),
        ],
      ),
    );
  }
}

/// Confirmacion del registro, con lo que el servidor dijo de la ventana de 4
/// horas.
///
/// **Sin comida asociada no es un error** (CA02): el sintoma queda registrado
/// igual y el mensaje lo dice sin dramatismo. Que no haya una comida en la
/// ventana es un dato clinico mas, no una falla del paciente ni de la app.
class _SymptomConfirmation extends StatelessWidget {
  const _SymptomConfirmation({required this.state, required this.onAgain});

  final SymptomFormState state;
  final VoidCallback onAgain;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final queued = state.outcome == SymptomSubmitOutcome.queuedOffline;
    final result = state.result;

    final String associationMessage;
    final String associationKey;
    if (queued || result == null) {
      // La ventana la resuelve el servidor: sin sincronizar todavia no hay nada
      // que afirmar en ningun sentido.
      associationMessage = l10n.symptomsMealPending;
      associationKey = 'symptom_meal_pending';
    } else if (result.hasMealAssociation) {
      associationMessage = l10n.symptomsMealAssociated;
      associationKey = 'symptom_meal_associated';
    } else {
      associationMessage = l10n.symptomsMealNotAssociated;
      associationKey = 'symptom_meal_not_associated';
    }

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.symptomsTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            queued ? l10n.symptomsQueuedOffline : l10n.symptomsRegistered,
            key: Key(
              queued ? 'symptom_queued_offline' : 'symptom_registered',
            ),
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: CauceSpacing.space4),
          Container(
            padding: const EdgeInsets.all(CauceSpacing.space4),
            decoration: BoxDecoration(
              color: CauceColors.bgCard,
              borderRadius: CauceRadii.borderLg,
              border: Border.all(color: CauceColors.bgDivider),
            ),
            child: Text(
              associationMessage,
              key: Key(associationKey),
              style: textTheme.bodyMedium,
            ),
          ),
          const SizedBox(height: CauceSpacing.space6),
          CauceButton(
            key: const Key('symptom_register_another'),
            label: l10n.symptomsRegisterAnother,
            onPressed: onAgain,
          ),
        ],
      ),
    );
  }
}
