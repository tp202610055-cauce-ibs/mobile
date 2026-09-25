import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/confidence_level.dart';
import '../recommendation_texts.dart';

/// Indicador de confianza del modelo (seccion F del design system,
/// "Confianza del modelo · 3 niveles visuales").
///
/// Tres barras con las llenas segun el nivel, y la etiqueta al lado: nunca
/// solo color (WCAG 1.4.1, igual que los badges). Tocarlo despliega que
/// significa ese nivel en terminos practicos, que es lo que piden HU0015 CA1
/// y CP040 paso 5.
///
/// Vive en la feature y no en `core/widgets/`: es de un solo uso, y promoverlo
/// ampliaria el design system compartido.
class RecommendationConfidenceIndicator extends StatefulWidget {
  const RecommendationConfidenceIndicator({required this.level, super.key});

  final ConfidenceLevel level;

  @override
  State<RecommendationConfidenceIndicator> createState() =>
      _RecommendationConfidenceIndicatorState();
}

class _RecommendationConfidenceIndicatorState
    extends State<RecommendationConfidenceIndicator> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final (Color background, Color foreground) = switch (widget.level) {
      ConfidenceLevel.high => (CauceColors.successBg, CauceColors.successText),
      ConfidenceLevel.medium => (
          CauceColors.warningBg,
          CauceColors.warningText,
        ),
      ConfidenceLevel.low => (CauceColors.dangerBg, CauceColors.dangerText),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Semantics(
          button: true,
          hint: l10n.recommendationConfidenceHint,
          child: Material(
            color: background,
            borderRadius: CauceRadii.borderSm,
            child: InkWell(
              key: const Key('recommendation_confidence'),
              borderRadius: CauceRadii.borderSm,
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: CauceSpacing.space3,
                  vertical: CauceSpacing.space2,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    for (int i = 0; i < 3; i++) ...<Widget>[
                      if (i > 0) const SizedBox(width: 3),
                      Container(
                        width: 8,
                        height: 16,
                        decoration: BoxDecoration(
                          color: i < widget.level.filledBars
                              ? foreground
                              : CauceColors.bgDivider,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(2)),
                        ),
                      ),
                    ],
                    const SizedBox(width: CauceSpacing.space2),
                    Text(
                      RecommendationTexts.confidenceLabel(l10n, widget.level),
                      style: textTheme.labelLarge?.copyWith(color: foreground),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        if (_expanded) ...<Widget>[
          const SizedBox(height: CauceSpacing.space2),
          Text(
            RecommendationTexts.confidenceBody(l10n, widget.level),
            key: const Key('recommendation_confidence_body'),
            textAlign: TextAlign.center,
            style: textTheme.bodyMedium?.copyWith(
              color: CauceColors.textSecondary,
            ),
          ),
        ],
      ],
    );
  }
}
