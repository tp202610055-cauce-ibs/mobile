import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';

/// Encabezado de seccion del mockup 11 (`.section-head`).
class RecommendationSectionHead extends StatelessWidget {
  const RecommendationSectionHead({
    required this.icon,
    required this.title,
    super.key,
  });

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: CauceSpacing.space4,
        bottom: CauceSpacing.space2,
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 14, color: CauceColors.brandBase),
          const SizedBox(width: CauceSpacing.space1),
          Expanded(
            child: Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: CauceColors.textTertiary,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.6,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Contenedor de seccion del mockup 11 (`.detail-section`).
class RecommendationSectionCard extends StatelessWidget {
  const RecommendationSectionCard({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: CauceSpacing.space4,
        vertical: CauceSpacing.space3,
      ),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderMd,
        border: Border.all(
          color: CauceColors.bgDivider,
          width: CauceBorders.subtle,
        ),
      ),
      child: child,
    );
  }
}
