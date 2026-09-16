import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/application/session_notifier.dart';
import '../../onboarding/application/onboarding_notifier.dart';

/// Raiz autenticada, provisional (US08 CA01).
///
/// Mobile-3 la reemplaza por el tablero real del paciente. Por ahora demuestra
/// que la sesion llego, ofrece el cierre, y recuerda el onboarding aplazado.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _loggingOut = false;

  Future<void> _logout() async {
    if (_loggingOut) {
      return;
    }
    setState(() => _loggingOut = true);

    // El notifier avisa al backend y limpia el almacenamiento. No falla nunca:
    // si el aviso no prospera, la sesion local se cierra igual.
    await ref.read(sessionNotifierProvider.notifier).logout();

    // El guard del router se encarga de llevar al login en cuanto el estado
    // pasa a no autenticado. Esta pantalla no navega por su cuenta.
    if (mounted) {
      setState(() => _loggingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final user = ref.watch(sessionNotifierProvider).user;
    final onboarding = ref.watch(resolvedOnboardingProvider);

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.appTitle),
      scrollable: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (onboarding.showsReminder) ...<Widget>[
            _OnboardingReminder(step: onboarding.step!),
            const SizedBox(height: CauceSpacing.space6),
          ],
          Text(
            l10n.homeGreeting(user?.fullName ?? ''),
            style: textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CauceSpacing.space6),
          CauceButton.secondary(
            key: const Key('home_logout'),
            label: l10n.homeLogout,
            loading: _loggingOut,
            onPressed: _logout,
          ),
        ],
      ),
    );
  }
}

/// Recordatorio del onboarding aplazado (US03 CA05, US04 CA05).
///
/// Es la contraparte de aplazar: el paciente sigue usando la app, y este
/// banner le deja el camino de vuelta a la vista. Reanudar publica el estado
/// pendiente y el guard hace el resto; el banner no navega por su cuenta.
///
/// Deliberadamente sobrio. Un aviso de advertencia en rojo por un formulario a
/// medias seria desproporcionado para algo que el paciente eligio posponer.
class _OnboardingReminder extends ConsumerWidget {
  const _OnboardingReminder({required this.step});

  final OnboardingStep step;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: const Key('home_onboarding_reminder'),
      width: double.infinity,
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: const BoxDecoration(
        color: CauceColors.infoBg,
        borderRadius: CauceRadii.borderMd,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            l10n.onboardingReminderTitle,
            style: textTheme.titleMedium?.copyWith(
              color: CauceColors.infoText,
            ),
          ),
          const SizedBox(height: CauceSpacing.space1),
          Text(
            switch (step) {
              OnboardingStep.clinicalProfile =>
                l10n.onboardingReminderBodyProfile,
              OnboardingStep.ibsSssBaseline =>
                l10n.onboardingReminderBodyBaseline,
            },
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: CauceSpacing.space3),
          CauceButton.tertiary(
            key: const Key('home_onboarding_resume'),
            label: l10n.onboardingReminderAction,
            onPressed: () =>
                ref.read(onboardingNotifierProvider.notifier).resume(),
          ),
        ],
      ),
    );
  }
}
