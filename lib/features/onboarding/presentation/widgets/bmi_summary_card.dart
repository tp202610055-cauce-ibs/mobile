import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../patients/domain/patient_profile.dart';
import 'onboarding_labels.dart';

/// Vista previa del IMC mientras el paciente completa peso y estatura
/// (US03 CA04).
///
/// **Registro clinico neutro a proposito.** Se muestra el valor, su categoria
/// segun la OMS y quien lo interpreta. Sin adjetivos de alarma ni colores
/// semaforo: la categoria es un dato informativo para el paciente y su
/// nutricionista, no un veredicto, y pintar "Obesidad" en rojo convierte un
/// dato en un juicio.
class BmiSummaryCard extends StatelessWidget {
  const BmiSummaryCard({required this.bmi, required this.category, super.key});

  final double? bmi;
  final BmiCategory? category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final value = bmi;
    final resolved = category;

    return Container(
      key: const Key('bmi_summary'),
      width: double.infinity,
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderMd,
        border: Border.all(color: CauceColors.bgDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.bmiTitle, style: textTheme.labelSmall),
          const SizedBox(height: CauceSpacing.space1),
          if (value == null)
            Text(
              l10n.bmiPending,
              key: const Key('bmi_pending'),
              style: textTheme.bodyMedium,
            )
          else ...<Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: <Widget>[
                Text(
                  l10n.bmiValue(value.toStringAsFixed(2)),
                  key: const Key('bmi_value'),
                  style: textTheme.headlineMedium,
                ),
                if (resolved != null) ...<Widget>[
                  const SizedBox(width: CauceSpacing.space2),
                  Flexible(
                    child: Text(
                      OnboardingLabels.bmiCategory(l10n, resolved),
                      key: const Key('bmi_category'),
                      style: textTheme.bodyLarge?.copyWith(
                        color: CauceColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: CauceSpacing.space2),
            Text(l10n.bmiNote, style: textTheme.labelSmall),
          ],
        ],
      ),
    );
  }
}
