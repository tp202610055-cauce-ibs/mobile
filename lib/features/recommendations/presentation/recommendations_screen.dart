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
import '../../onboarding/application/onboarding_notifier.dart';
import '../application/recommendations_feed_notifier.dart';
import 'widgets/recommendation_card.dart';

/// Pestana de Consejos (EP0003, mockup 10).
///
/// Cinco estados:
/// - **restringida**, con el onboarding pendiente (CP011 paso 6);
/// - **lista** de recomendaciones visibles, cada una con su tarjeta;
/// - **en revision**, cuando este dispositivo pidio una y el nutricionista
///   todavia no la aprobo (HU0014 CA2, CP037);
/// - **vacia**, cuando no hay nada visible ni en revision;
/// - **error**, de carga o del pedido, siempre con reintento.
///
/// **Entrar a la pestana puede pedir una recomendacion** sin que el paciente
/// toque nada, si la lista esta vacia y no hay una en revision (decision 2).
/// Lo resuelve [RecommendationsFeedNotifier.openAdviceTab]; la pantalla solo
/// lo dispara.
class RecommendationsScreen extends ConsumerStatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  ConsumerState<RecommendationsScreen> createState() =>
      _RecommendationsScreenState();
}

class _RecommendationsScreenState extends ConsumerState<RecommendationsScreen> {
  bool _opened = false;

  /// Dispara la entrada a Consejos una sola vez por montaje, y solo con el
  /// onboarding completo: con el perfil a medias no hay recomendacion posible.
  void _openOnce() {
    if (_opened) {
      return;
    }
    _opened = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      unawaited(
        ref.read(recommendationsFeedNotifierProvider.notifier).openAdviceTab(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final onboarding = ref.watch(resolvedOnboardingProvider);
    final locked = !onboarding.allowsAdvice;
    if (!locked) {
      _openOnce();
    }

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.recommendationsTitle),
      scrollable: true,
      body: locked
          ? CauceEmptyState(
              key: const Key('recommendations_locked'),
              icon: TablerIcons.lock,
              title: l10n.recommendationsLockedTitle,
              message: l10n.recommendationsLockedBody,
              actionLabel: l10n.recommendationsLockedAction,
              // Publica el paso pendiente y deja que el guard navegue, igual
              // que el recordatorio de la home. La pantalla no navega sola.
              onAction: () =>
                  ref.read(onboardingNotifierProvider.notifier).resume(),
            )
          : const _Feed(),
    );
  }
}

class _Feed extends ConsumerWidget {
  const _Feed();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final feed = ref.watch(recommendationsFeedNotifierProvider);

    return feed.when(
      loading: () => CauceLoadingIndicator.fullscreen(
        message: l10n.commonLoading,
      ),
      error: (error, _) => _Failure(error: error),
      data: (value) => _FeedBody(feed: value),
    );
  }
}

class _FeedBody extends ConsumerWidget {
  const _FeedBody({required this.feed});

  final RecommendationsFeed feed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final error = feed.generationError;

    // El pedido silencioso puede tardar: el backend espera hasta 15 s al
    // modelo de lenguaje antes de caer a la plantilla de respaldo.
    if (feed.generating && feed.summaries.isEmpty) {
      return CauceLoadingIndicator.fullscreen(message: l10n.commonLoading);
    }

    if (feed.summaries.isEmpty) {
      if (error != null) {
        return _Failure(error: error);
      }
      if (feed.awaitingReview) {
        return CauceEmptyState(
          key: const Key('recommendations_pending'),
          icon: TablerIcons.hourglass_high,
          title: l10n.recommendationsPendingTitle,
          message: l10n.recommendationsPendingBody,
        );
      }
      // Cubre tambien los 422 del pedido automatico, que no se muestran como
      // error: el paciente no pidio nada (decision 2).
      return CauceEmptyState(
        key: const Key('recommendations_empty'),
        icon: TablerIcons.bulb,
        title: l10n.recommendationsEmptyTitle,
        message: l10n.recommendationsEmptyBody,
        actionLabel: l10n.recommendationsEmptyAction,
        onAction: () => context.push(AppRoutes.mealNew),
      );
    }

    return Column(
      key: const Key('recommendations_list'),
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (feed.awaitingReview) ...<Widget>[
          const _PendingNote(),
          const SizedBox(height: CauceSpacing.space4),
        ],
        Text(l10n.recommendationsListHeader, style: textTheme.titleMedium),
        Text(
          l10n.recommendationsListHint,
          style: textTheme.labelSmall?.copyWith(
            color: CauceColors.textTertiary,
          ),
        ),
        const SizedBox(height: CauceSpacing.space3),
        for (final summary in feed.summaries)
          RecommendationCard(
            key: ValueKey<String>(summary.id),
            summary: summary,
          ),
      ],
    );
  }
}

/// Aviso compacto de una recomendacion en revision cuando ya hay otras
/// visibles.
class _PendingNote extends StatelessWidget {
  const _PendingNote();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: const Key('recommendations_pending_note'),
      padding: const EdgeInsets.all(CauceSpacing.space3),
      decoration: const BoxDecoration(
        color: CauceColors.infoBg,
        borderRadius: CauceRadii.borderMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            TablerIcons.hourglass_high,
            size: 18,
            color: CauceColors.infoText,
          ),
          const SizedBox(width: CauceSpacing.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.recommendationsPendingTitle,
                  style: textTheme.labelLarge?.copyWith(
                    color: CauceColors.infoText,
                  ),
                ),
                Text(
                  l10n.recommendationsPendingBody,
                  style: textTheme.bodySmall?.copyWith(
                    color: CauceColors.infoText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Fallo de carga o del pedido, con su reintento.
class _Failure extends ConsumerWidget {
  const _Failure({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final failure = error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (failure is CauceApiError)
          CauceErrorBanner(
            key: const Key('recommendations_error'),
            error: failure,
          )
        else
          Text(
            l10n.recommendationsLoadError,
            key: const Key('recommendations_error'),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: CauceSpacing.space4),
        CauceButton.secondary(
          key: const Key('recommendations_retry'),
          label: l10n.commonRetry,
          onPressed: () => unawaited(
            ref
                .read(recommendationsFeedNotifierProvider.notifier)
                .openAdviceTab(refresh: true),
          ),
        ),
      ],
    );
  }
}
