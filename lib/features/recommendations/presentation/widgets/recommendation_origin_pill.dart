import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/recommendation_origin.dart';
import '../recommendation_texts.dart';

/// Pildora de origen del mockup 11 (`.source-pill`, decision 10).
///
/// Contorno y no relleno a proposito: dice de donde salio la recomendacion,
/// no juzga nada, y un fondo de color competiria con el badge de confianza.
/// Vive en la feature y no en `core/widgets/`: es de un solo uso.
class RecommendationOriginPill extends StatelessWidget {
  const RecommendationOriginPill({
    required this.origin,
    this.reviewerName,
    super.key,
  });

  final RecommendationOrigin origin;
  final String? reviewerName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CauceSpacing.space2,
        vertical: CauceSpacing.space1,
      ),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: const BorderRadius.all(Radius.circular(CauceRadii.full)),
        border: Border.all(
          color: CauceColors.bgDivider,
          width: CauceBorders.normal,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(
            RecommendationTexts.originIcon(origin),
            size: 13,
            color: CauceColors.brandBase,
          ),
          const SizedBox(width: CauceSpacing.space1),
          Flexible(
            child: Text(
              RecommendationTexts.originLabel(l10n, origin, reviewerName),
              overflow: TextOverflow.ellipsis,
              style: textTheme.labelSmall?.copyWith(
                color: CauceColors.textSecondary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
