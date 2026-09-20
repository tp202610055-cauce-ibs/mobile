import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../onboarding/application/onboarding_notifier.dart';

/// Pestana de consejos (EP0003).
///
/// Feature con una sola capa y sin `data/`, con el mismo criterio del acta M30
/// para el onboarding: todavia no hay nada que traer. Mobile-5 la llena con
/// `GET /recommendations/me` y sus tarjetas con XAI y HITL (seccion G del
/// design system).
///
/// Hasta entonces la pestana no es un hueco: muestra el estado que corresponde
/// al paciente. Con el onboarding pendiente explica por que esta restringida y
/// ofrece la vuelta al wizard, que es lo que pide CP011 paso 6 y la regla de
/// que nada se deshabilita sin explicacion.
class RecommendationsScreen extends ConsumerWidget {
  const RecommendationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final onboarding = ref.watch(resolvedOnboardingProvider);

    final locked = !onboarding.allowsAdvice;

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.recommendationsTitle),
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
          : CauceEmptyState(
              key: const Key('recommendations_empty'),
              icon: TablerIcons.bulb,
              title: l10n.recommendationsEmptyTitle,
              message: l10n.recommendationsEmptyBody,
            ),
    );
  }
}
