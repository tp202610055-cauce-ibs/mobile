import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../patients/domain/allergy.dart';
import 'onboarding_labels.dart';

/// Seleccion multiple de alergias del catalogo, con severidad y nota por cada
/// una (US03).
///
/// La severidad y la nota aparecen recien cuando la alergia se marca. Pedir
/// una severidad por cada entrada del catalogo, marcada o no, llenaria la
/// pantalla de controles que el paciente no va a usar.
class AllergyPicker extends StatelessWidget {
  const AllergyPicker({
    required this.catalog,
    required this.selected,
    required this.onToggle,
    required this.onSeverityChanged,
    required this.onNotesChanged,
    this.enabled = true,
    super.key,
  });

  final List<AllergyCatalogEntry> catalog;

  /// Declaraciones marcadas, por `allergyId`.
  final Map<String, AllergyDeclarationDraft> selected;

  final void Function(AllergyCatalogEntry entry, bool value) onToggle;
  final void Function(String allergyId, AllergySeverityLevel value)
      onSeverityChanged;
  final void Function(String allergyId, String value) onNotesChanged;

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    if (catalog.isEmpty) {
      return Text(
        l10n.allergiesEmpty,
        key: const Key('allergies_empty'),
        style: textTheme.bodyMedium,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final entry in catalog)
          _AllergyRow(
            entry: entry,
            declaration: selected[entry.allergyId],
            enabled: enabled,
            onToggle: (value) => onToggle(entry, value),
            onSeverityChanged: (value) =>
                onSeverityChanged(entry.allergyId, value),
            onNotesChanged: (value) => onNotesChanged(entry.allergyId, value),
          ),
      ],
    );
  }
}

class _AllergyRow extends StatelessWidget {
  const _AllergyRow({
    required this.entry,
    required this.declaration,
    required this.enabled,
    required this.onToggle,
    required this.onSeverityChanged,
    required this.onNotesChanged,
  });

  final AllergyCatalogEntry entry;
  final AllergyDeclarationDraft? declaration;
  final bool enabled;
  final ValueChanged<bool> onToggle;
  final ValueChanged<AllergySeverityLevel> onSeverityChanged;
  final ValueChanged<String> onNotesChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final current = declaration;
    final type = entry.type;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CheckboxListTile(
          key: Key('allergy_${entry.allergyId}'),
          value: current != null,
          onChanged: enabled ? (value) => onToggle(value ?? false) : null,
          title: Text(entry.name, style: textTheme.bodyLarge),
          subtitle: type == null
              ? null
              : Text(
                  OnboardingLabels.allergyType(l10n, type),
                  style: textTheme.labelSmall,
                ),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
          dense: true,
        ),
        if (current != null)
          Padding(
            padding: const EdgeInsets.only(
              left: CauceSpacing.space8,
              bottom: CauceSpacing.space4,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                CauceChoiceField<AllergySeverityLevel>(
                  key: Key('allergy_severity_${entry.allergyId}'),
                  label: l10n.allergySeverityLabel,
                  value: current.severity,
                  enabled: enabled,
                  onChanged: onSeverityChanged,
                  choices: <CauceChoice<AllergySeverityLevel>>[
                    for (final level in AllergySeverityLevel.values)
                      CauceChoice<AllergySeverityLevel>(
                        value: level,
                        label: OnboardingLabels.allergySeverity(l10n, level),
                      ),
                  ],
                ),
                const SizedBox(height: CauceSpacing.space3),
                CauceTextField(
                  key: Key('allergy_notes_${entry.allergyId}'),
                  label: l10n.allergyNotesLabel,
                  enabled: enabled,
                  onChanged: onNotesChanged,
                  validator: (value) => Validators.allergyNotes(value, l10n),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
