import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/utils/validators.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Requisitos de una contrasena nueva, siempre visibles bajo el campo.
///
/// Reemplaza al hint "Minimo 8 caracteres", que desaparecia al empezar a
/// escribir y no decia nada de mayuscula, minuscula ni digito: el paciente
/// recien descubria las reglas cuando el formulario lo rechazaba (revision
/// manual del 28-sep). Es la lista de requisitos del mockup
/// `02-registro-codigo-invitacion`, con la minuscula que el mockup no tiene y
/// que el backend y Keycloak si exigen.
///
/// Cada regla marca su cumplimiento mientras se escribe, con la misma
/// evaluacion que usa [Validators.newPassword]. Sin la barra de fortaleza del
/// mockup: una barra resume lo que la lista ya dice regla por regla.
///
/// Vive en la feature y no como un `helperText` de `CauceTextField`: ampliar
/// ese atomo compartido queda para cuando otra pantalla lo necesite.
class PasswordRequirements extends StatelessWidget {
  const PasswordRequirements({required this.controller, super.key});

  /// El campo de la contrasena nueva.
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        final rules = Validators.passwordRules(value.text);

        return Container(
          key: const Key('password_requirements'),
          margin: const EdgeInsets.only(top: CauceSpacing.space2),
          padding: const EdgeInsets.symmetric(
            horizontal: CauceSpacing.space3,
            vertical: CauceSpacing.space2,
          ),
          decoration: const BoxDecoration(
            color: CauceColors.bgSubtle,
            borderRadius: CauceRadii.borderMd,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _Rule(
                key: const Key('password_rule_length'),
                label: l10n.passwordRuleLength,
                met: rules.length,
              ),
              _Rule(
                key: const Key('password_rule_uppercase'),
                label: l10n.passwordRuleUppercase,
                met: rules.uppercase,
              ),
              _Rule(
                key: const Key('password_rule_lowercase'),
                label: l10n.passwordRuleLowercase,
                met: rules.lowercase,
              ),
              _Rule(
                key: const Key('password_rule_digit'),
                label: l10n.passwordRuleDigit,
                met: rules.digit,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _Rule extends StatelessWidget {
  const _Rule({required this.label, required this.met, super.key});

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    // El cumplimiento se lee por el icono y el color juntos, nunca solo por
    // el color, y el lector de pantalla lo anuncia en palabras.
    final color = met ? CauceColors.successText : CauceColors.textTertiary;

    return Semantics(
      label: '$label, ${met ? l10n.passwordRuleMet : l10n.passwordRulePending}',
      excludeSemantics: true,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: <Widget>[
            Icon(
              met ? TablerIcons.circle_check_filled : TablerIcons.circle,
              size: 14,
              color: color,
            ),
            const SizedBox(width: CauceSpacing.space2),
            Flexible(
              child: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .labelSmall
                    ?.copyWith(color: color),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
