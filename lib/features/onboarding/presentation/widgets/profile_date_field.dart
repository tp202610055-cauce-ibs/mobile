import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'onboarding_labels.dart';

/// Campo de fecha de solo lectura que abre el calendario al tocarlo.
///
/// Lo usa la fecha de diagnostico, que es opcional y no se escribe a mano.
class ProfileDateField extends StatelessWidget {
  const ProfileDateField({
    required this.fieldKey,
    required this.label,
    required this.value,
    required this.onTap,
    this.errorText,
    this.enabled = true,
    super.key,
  });

  final Key fieldKey;
  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final current = value;
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(label, style: textTheme.bodyMedium),
        const SizedBox(height: CauceSpacing.space2),
        InkWell(
          key: fieldKey,
          onTap: enabled ? onTap : null,
          borderRadius: CauceRadii.borderMd,
          child: Container(
            constraints: const BoxConstraints(
              minHeight: CauceSizes.touchTargetMin,
            ),
            padding: CauceSizes.inputPadding,
            decoration: BoxDecoration(
              color: CauceColors.bgCard,
              borderRadius: CauceRadii.borderMd,
              border: Border.all(
                color:
                    hasError ? CauceColors.dangerText : CauceColors.bgDivider,
                width: CauceBorders.strong,
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                current == null
                    ? l10n.clinicalProfileDatePlaceholder
                    : OnboardingLabels.date(current),
                style: textTheme.bodyLarge?.copyWith(
                  color: current == null
                      ? CauceColors.textTertiary
                      : CauceColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
        if (hasError) ...<Widget>[
          const SizedBox(height: CauceSpacing.space1),
          Text(
            errorText!,
            style: textTheme.labelSmall?.copyWith(
              color: CauceColors.dangerText,
            ),
          ),
        ],
      ],
    );
  }
}
