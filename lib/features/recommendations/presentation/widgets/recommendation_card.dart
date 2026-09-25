import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/recommendation_detail_providers.dart';
import '../../domain/recommendation.dart';
import '../../domain/recommendation_headline.dart';
import '../recommendation_texts.dart';
import 'recommendation_origin_pill.dart';

/// Tarjeta de una recomendacion (mockup 10, `.rec-card`).
///
/// **Pide su propio detalle**, porque el resumen del listado no trae items,
/// revisor ni nota, y sin eso no hay titulo, icono ni pildora que componer
/// (decisiones 3, 5 y 10; acta M47). Es una lectura silenciosa: no entrega la
/// recomendacion. Mientras llega, la tarjeta se dibuja con lo que trae el
/// resumen.
///
/// La usan Consejos e Inicio. Tocarla abre el detalle con `go`: desde Inicio
/// cambia de pestana y deja la lista de Consejos debajo, de modo que volver
/// atras lleva a la lista y no a Inicio.
class RecommendationCard extends ConsumerWidget {
  const RecommendationCard({required this.summary, super.key});

  final RecommendationSummary summary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final detail =
        ref.watch(recommendationDetailProvider(summary.id)).valueOrNull;

    final headline = detail == null ? null : RecommendationHeadline.of(detail);
    final origin = detail?.origin;
    final title = headline == null || origin == null
        ? l10n.recommendationFallbackTitle
        : RecommendationTexts.title(l10n, headline, origin: origin);
    final description = headline == null
        ? null
        : RecommendationTexts.description(l10n, headline);
    final icon = headline == null
        ? TablerIcons.bulb
        : RecommendationTexts.icon(headline);
    final isNew = detail?.isNew ?? summary.status.isDeliverable;
    final date = detail?.reviewedAt ?? summary.generatedAt;

    return Padding(
      padding: const EdgeInsets.only(bottom: CauceSpacing.space2),
      child: Material(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderMd,
        child: InkWell(
          key: Key('recommendation_card_${summary.id}'),
          borderRadius: CauceRadii.borderMd,
          onTap: () =>
              context.go(AppRoutes.recommendationDetailPath(summary.id)),
          child: Container(
            padding: const EdgeInsets.all(CauceSpacing.space4),
            decoration: BoxDecoration(
              borderRadius: CauceRadii.borderMd,
              border: Border.all(
                color: CauceColors.bgDivider,
                width: CauceBorders.subtle,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 42,
                  height: 42,
                  decoration: const BoxDecoration(
                    color: CauceColors.brandSoft,
                    borderRadius: CauceRadii.borderMd,
                  ),
                  child: Icon(icon, size: 22, color: CauceColors.brandBase),
                ),
                const SizedBox(width: CauceSpacing.space3),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        key: Key('recommendation_card_title_${summary.id}'),
                        style: textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (description != null) ...<Widget>[
                        const SizedBox(height: CauceSpacing.space1),
                        Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.bodyMedium?.copyWith(
                            color: CauceColors.textSecondary,
                          ),
                        ),
                      ],
                      const SizedBox(height: CauceSpacing.space2),
                      Wrap(
                        spacing: CauceSpacing.space2,
                        runSpacing: CauceSpacing.space1,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: <Widget>[
                          if (detail != null && origin != null)
                            RecommendationOriginPill(
                              origin: origin,
                              reviewerName: detail.reviewerName,
                            ),
                          if (isNew)
                            CauceBadge(
                              key: Key('recommendation_new_${summary.id}'),
                              label: l10n.recommendationNewBadge,
                              icon: TablerIcons.point_filled,
                              tone: CauceBadgeTone.brand,
                              compact: true,
                            ),
                          Text(
                            RecommendationTexts.relativeDate(
                              l10n,
                              date,
                              DateTime.now(),
                              locale: locale,
                            ),
                            style: textTheme.labelSmall?.copyWith(
                              color: CauceColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: CauceSpacing.space2),
                const Padding(
                  padding: EdgeInsets.only(top: CauceSpacing.space3),
                  child: Icon(
                    TablerIcons.chevron_right,
                    size: 18,
                    color: CauceColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
