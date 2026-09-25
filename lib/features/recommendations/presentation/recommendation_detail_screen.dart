import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/recommendation_detail_providers.dart';
import '../domain/recommendation.dart';
import '../domain/recommendation_headline.dart';
import '../domain/recommendation_origin.dart';
import 'recommendation_texts.dart';
import 'widgets/recommendation_confidence_indicator.dart';
import 'widgets/recommendation_feedback_section.dart';
import 'widgets/recommendation_origin_pill.dart';

/// Detalle de una recomendacion (mockup 11 v2, HU0014 CA1, HU0015, HU0016).
///
/// Los bloques van en el orden del mockup, con dos agregados que el mockup no
/// tiene y las historias si piden:
///
/// - **"Que te proponemos"**, los items por accion con sus sustitutos y su
///   justificacion (HU0014 CA1, CP036). El mockup los daba por contenidos en
///   un titulo de plantilla que el backend no implementa.
/// - **La retroalimentacion** (HU0016), al pie, solo con la recomendacion ya
///   entregada.
///
/// **Abrirla la entrega** (decision 7): al montarse dispara
/// [RecommendationDelivery], una sola vez. Es la unica via que entrega; la
/// tarjeta de la lista lee el mismo detalle sin entregarlo.
class RecommendationDetailScreen extends ConsumerStatefulWidget {
  const RecommendationDetailScreen({required this.recommendationId, super.key});

  final String recommendationId;

  @override
  ConsumerState<RecommendationDetailScreen> createState() =>
      _RecommendationDetailScreenState();
}

class _RecommendationDetailScreenState
    extends ConsumerState<RecommendationDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      final delivery = recommendationDeliveryProvider(widget.recommendationId);
      unawaited(ref.read(delivery.notifier).ensureDelivered());
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final id = widget.recommendationId;
    // Se observa para que la entrega siga viva mientras la pantalla lo este:
    // el provider se libera solo sin nadie que lo escuche.
    ref.watch(recommendationDeliveryProvider(id));
    final detail = ref.watch(recommendationDetailProvider(id));

    return CauceScaffold(
      appBar: CauceAppBar(
        title: l10n.recommendationDetailTitle,
        showBackButton: true,
      ),
      scrollable: true,
      body: detail.when(
        loading: () => CauceLoadingIndicator.fullscreen(
          message: l10n.commonLoading,
        ),
        error: (error, _) => switch (error) {
          // HU0014 CA3 / CP038: una recomendacion no visible responde 404, y
          // una que vencio al intentar entregarla, 409. Para el paciente las
          // dos son lo mismo: ya no esta.
          RecommendationNotFoundError() ||
          RecommendationExpiredError() =>
            const _NotAvailable(),
          _ => _LoadFailure(
              error: error,
              onRetry: () => ref.invalidate(recommendationDetailProvider(id)),
            ),
        },
        data: (value) => _DetailBody(detail: value),
      ),
    );
  }
}

class _DetailBody extends StatelessWidget {
  const _DetailBody({required this.detail});

  final RecommendationDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final explanation = detail.explanationText;
    final note = detail.note;
    final data = detail.supportingData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _Hero(detail: detail),
        // Bloque 1 (HU0015 CA3): explicacion XAI. Una indicacion manual no la
        // tiene. Si el LLM fallo, llega la plantilla de respaldo y se muestra
        // igual, sin marcarla como error (HU0015 CA4, CP077).
        if (explanation != null) ...<Widget>[
          _SectionHead(
            icon: TablerIcons.sparkles,
            title: l10n.recommendationSectionWhy,
          ),
          _SectionCard(
            key: const Key('recommendation_explanation'),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(explanation, style: _bodyStyle(context)),
                if (detail.showsAttribution) const _Attribution(),
              ],
            ),
          ),
        ],
        if (detail.items.isNotEmpty) ...<Widget>[
          _SectionHead(
            icon: TablerIcons.salad,
            title: l10n.recommendationSectionItems,
          ),
          _ItemsCard(items: detail.items),
        ],
        // Bloque 2: nota del nutricionista, en cualquier estado en que exista
        // (acta M47). HU0015 CA2 y CP041 la piden aunque el mockup 11 la omita
        // en `Approved`.
        if (note != null) ...<Widget>[
          _SectionHead(
            icon: TablerIcons.stethoscope,
            title: l10n.recommendationSectionNote,
          ),
          _NutritionistNote(detail: detail, note: note),
        ],
        // Bloque 3: pasos, solo si los hay (mockup 11, variante B).
        if (detail.steps.isNotEmpty) ...<Widget>[
          _SectionHead(
            icon: TablerIcons.list_check,
            title: l10n.recommendationSectionSteps,
          ),
          _StepsCard(steps: detail.steps),
        ],
        // Bloque 4: cifras de respaldo. Se omiten en una indicacion manual,
        // que no salio de estos datos (mockup 11, "estado vacio sin datos de
        // sustento").
        if (data != null && !detail.isManual) ...<Widget>[
          _SectionHead(
            icon: TablerIcons.chart_dots,
            title: l10n.recommendationSectionData,
          ),
          _SupportingDataCard(data: data),
        ],
        RecommendationFeedbackSection(detail: detail),
        const _InfoBanner(),
      ],
    );
  }

  static TextStyle? _bodyStyle(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.55);
}

/// Encabezado: icono, titulo compuesto, origen, fecha, revision y confianza.
class _Hero extends StatelessWidget {
  const _Hero({required this.detail});

  final RecommendationDetail detail;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final headline = RecommendationHeadline.of(detail);
    final origin = detail.origin;
    final confidence = detail.confidenceLevel;

    return Container(
      key: const Key('recommendation_hero'),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: const BoxDecoration(
        color: CauceColors.brandSoft,
        borderRadius: CauceRadii.borderLg,
      ),
      child: Column(
        children: <Widget>[
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: CauceColors.bgCard.withValues(alpha: 0.7),
              borderRadius: CauceRadii.borderMd,
            ),
            child: Icon(
              RecommendationTexts.icon(headline),
              size: 28,
              color: CauceColors.brandBase,
            ),
          ),
          const SizedBox(height: CauceSpacing.space3),
          Text(
            RecommendationTexts.title(l10n, headline, origin: origin),
            key: const Key('recommendation_title'),
            textAlign: TextAlign.center,
            style: textTheme.titleLarge,
          ),
          const SizedBox(height: CauceSpacing.space3),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: CauceSpacing.space2,
            runSpacing: CauceSpacing.space1,
            children: <Widget>[
              RecommendationOriginPill(
                key: const Key('recommendation_origin'),
                origin: origin,
                reviewerName: detail.reviewerName,
              ),
              Text(
                RecommendationTexts.relativeDate(
                  l10n,
                  detail.reviewedAt ?? detail.generatedAt,
                  DateTime.now(),
                  locale: locale,
                ),
                style: textTheme.labelSmall?.copyWith(
                  color: CauceColors.textTertiary,
                ),
              ),
            ],
          ),
          // HU0015 CA2 / CP041: la revision del nutricionista, con su nombre,
          // visible en el encabezado. Para una modificada o una manual ya lo
          // dice la pildora.
          if (origin == RecommendationOrigin.system &&
              detail.wasReviewed) ...<Widget>[
            const SizedBox(height: CauceSpacing.space2),
            Row(
              key: const Key('recommendation_reviewed_by'),
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Icon(
                  TablerIcons.user_check,
                  size: 16,
                  color: CauceColors.brandStrong,
                ),
                const SizedBox(width: CauceSpacing.space1),
                Flexible(
                  child: Text(
                    l10n.recommendationReviewedBy(
                      detail.reviewerName ??
                          l10n.recommendationYourNutritionist,
                    ),
                    style: textTheme.labelLarge?.copyWith(
                      color: CauceColors.brandStrong,
                    ),
                  ),
                ),
              ],
            ),
          ],
          if (confidence != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space3),
            RecommendationConfidenceIndicator(level: confidence),
          ],
        ],
      ),
    );
  }
}

/// Encabezado de seccion del mockup 11 (`.section-head`).
class _SectionHead extends StatelessWidget {
  const _SectionHead({required this.icon, required this.title});

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
class _SectionCard extends StatelessWidget {
  const _SectionCard({required this.child, super.key});

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

/// Atribucion FODMAP fija al pie de la explicacion (decision 6).
///
/// Texto literal del mockup 11, no generado. Se muestra siempre que la
/// explicacion no sea manual: el contrato no dice si el texto del LLM nombra
/// una clasificacion FODMAP, y una recomendacion del motor siempre sale de
/// ella.
class _Attribution extends StatelessWidget {
  const _Attribution();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: CauceSpacing.space3),
      padding: const EdgeInsets.only(top: CauceSpacing.space2),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CauceColors.bgDivider,
            width: CauceBorders.subtle,
          ),
        ),
      ),
      child: Text(
        AppLocalizations.of(context).recommendationAttribution,
        key: const Key('recommendation_attribution'),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: CauceColors.textTertiary,
            ),
      ),
    );
  }
}

/// Items agrupados por accion (HU0014 CA1): lo que se incorpora, lo que se
/// reduce o evita, y los sustitutos con su justificacion.
class _ItemsCard extends StatelessWidget {
  const _ItemsCard({required this.items});

  final List<RecommendationItem> items;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final groups = <(RecommendationAction, List<RecommendationItem>)>[
      for (final action in RecommendationAction.displayOrder)
        if (items.any((item) => item.action == action))
          (action, items.where((item) => item.action == action).toList()),
    ];

    return _SectionCard(
      key: const Key('recommendation_items'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int g = 0; g < groups.length; g++) ...<Widget>[
            if (g > 0) const SizedBox(height: CauceSpacing.space3),
            Text(
              RecommendationTexts.actionGroup(l10n, groups[g].$1),
              style: textTheme.labelLarge,
            ),
            for (final item in groups[g].$2)
              Padding(
                padding: const EdgeInsets.only(top: CauceSpacing.space2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      RecommendationTexts.actionIcon(item.action),
                      size: 18,
                      color: CauceColors.brandBase,
                    ),
                    const SizedBox(width: CauceSpacing.space2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            item.substituteFoodName == null
                                ? item.foodName
                                : l10n.recommendationSubstituteBy(
                                    item.foodName,
                                    item.substituteFoodName!,
                                  ),
                            style: textTheme.bodyMedium,
                          ),
                          if (item.reasoning != null)
                            Text(
                              item.reasoning!,
                              style: textTheme.bodySmall?.copyWith(
                                color: CauceColors.textSecondary,
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ],
      ),
    );
  }
}

/// Nota del nutricionista, diferenciada del texto del sistema (HU0015 CA2):
/// fondo de marca, franja lateral y cursiva, como cita (mockup 11).
///
/// La franja va dentro del recorte y no como borde, por el mismo motivo que
/// en las tarjetas del Diario: un `Border` no uniforme junto con
/// `borderRadius` hace que Flutter no pinte la tarjeta.
class _NutritionistNote extends StatelessWidget {
  const _NutritionistNote({required this.detail, required this.note});

  final RecommendationDetail detail;
  final String note;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final name = detail.reviewerName;

    return ClipRRect(
      key: const Key('recommendation_note'),
      borderRadius: CauceRadii.borderMd,
      child: ColoredBox(
        color: CauceColors.brandSoft,
        child: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(
                CauceSpacing.space4 + 3,
                CauceSpacing.space3,
                CauceSpacing.space4,
                CauceSpacing.space3,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      color: CauceColors.bgCard,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      TablerIcons.user,
                      size: 16,
                      color: CauceColors.brandBase,
                    ),
                  ),
                  const SizedBox(width: CauceSpacing.space3),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (name != null)
                          Text(
                            name,
                            key: const Key('recommendation_note_author'),
                            style: textTheme.labelLarge?.copyWith(
                              color: CauceColors.brandStrong,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        Text(
                          l10n.recommendationSectionNote,
                          style: textTheme.labelSmall?.copyWith(
                            color: CauceColors.textTertiary,
                          ),
                        ),
                        const SizedBox(height: CauceSpacing.space2),
                        Text(
                          note,
                          style: textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 3,
              child: ColoredBox(color: CauceColors.brandBase),
            ),
          ],
        ),
      ),
    );
  }
}

/// Pasos para aplicarla (bloque 3), con el bullet de check del mockup 11.
class _StepsCard extends StatelessWidget {
  const _StepsCard({required this.steps});

  final List<String> steps;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return _SectionCard(
      key: const Key('recommendation_steps'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          for (int i = 0; i < steps.length; i++)
            Padding(
              padding: EdgeInsets.only(top: i == 0 ? 0 : CauceSpacing.space2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Icon(
                    TablerIcons.circle_check,
                    size: 17,
                    color: CauceColors.brandBase,
                  ),
                  const SizedBox(width: CauceSpacing.space2),
                  Expanded(
                    child: Text(steps[i], style: textTheme.bodyMedium),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Cifras de respaldo (bloque 4): numero en mono de marca y su contexto.
class _SupportingDataCard extends StatelessWidget {
  const _SupportingDataCard({required this.data});

  final RecommendationSupportingData data;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final days = data.windowDays;

    Widget row(String number, String label, {Key? key}) {
      return Padding(
        key: key,
        padding: const EdgeInsets.only(bottom: CauceSpacing.space2),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            SizedBox(
              width: 44,
              child: Text(
                number,
                textAlign: TextAlign.right,
                style: CauceTypography.mono.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: CauceColors.brandBase,
                ),
              ),
            ),
            const SizedBox(width: CauceSpacing.space3),
            Expanded(
              child: Text(
                label,
                style: textTheme.bodyMedium?.copyWith(
                  color: CauceColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return _SectionCard(
      key: const Key('recommendation_supporting_data'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          row(
            '${data.symptomCount}',
            l10n.recommendationDataSymptoms(data.symptomCount, days),
            key: const Key('recommendation_data_symptoms'),
          ),
          row(
            '${data.mealCount}',
            l10n.recommendationDataMeals(data.mealCount, days),
            key: const Key('recommendation_data_meals'),
          ),
          row(
            l10n.recommendationDataHours(data.correlationWindowHours),
            l10n.recommendationDataWindow,
            key: const Key('recommendation_data_window'),
          ),
          if (data.topHighFodmapFoods.isNotEmpty)
            Text(
              l10n.recommendationDataTopFoods(
                data.topHighFodmapFoods.join(', '),
              ),
              key: const Key('recommendation_data_top_foods'),
              style: textTheme.bodySmall?.copyWith(
                color: CauceColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }
}

/// Banner informativo del pie del mockup 11, en lugar de un boton.
class _InfoBanner extends StatelessWidget {
  const _InfoBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: CauceSpacing.space4),
      padding: const EdgeInsets.all(CauceSpacing.space3),
      decoration: const BoxDecoration(
        color: CauceColors.infoBg,
        borderRadius: CauceRadii.borderMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            TablerIcons.info_circle,
            size: 18,
            color: CauceColors.infoText,
          ),
          const SizedBox(width: CauceSpacing.space2),
          Expanded(
            child: Text(
              AppLocalizations.of(context).recommendationInfoBanner,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: CauceColors.infoText,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

/// La recomendacion ya no es visible: vencio, fue archivada o nunca lo fue.
class _NotAvailable extends StatelessWidget {
  const _NotAvailable();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return CauceEmptyState(
      key: const Key('recommendation_not_available'),
      icon: TablerIcons.bulb_off,
      title: l10n.recommendationNotAvailableTitle,
      message: l10n.recommendationNotAvailableBody,
      actionLabel: l10n.recommendationNotAvailableAction,
      onAction: () => context.go(AppRoutes.recommendations),
    );
  }
}

/// Fallo de carga, con su reintento.
class _LoadFailure extends StatelessWidget {
  const _LoadFailure({required this.error, required this.onRetry});

  final Object error;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final failure = error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (failure is CauceApiError)
          CauceErrorBanner(
            key: const Key('recommendation_error'),
            error: failure,
          )
        else
          Text(
            l10n.recommendationsLoadError,
            key: const Key('recommendation_error'),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: CauceSpacing.space4),
        CauceButton.secondary(
          key: const Key('recommendation_retry'),
          label: l10n.commonRetry,
          onPressed: onRetry,
        ),
      ],
    );
  }
}
