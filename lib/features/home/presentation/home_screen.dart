import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/application/session_notifier.dart';
import '../../ibs_sss/application/periodic_assessment_notifier.dart';
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
      appBar: CauceAppBar(
        title: l10n.appTitle,
        actions: <Widget>[
          IconButton(
            key: const Key('home_open_profile'),
            icon: const Icon(TablerIcons.user_circle),
            tooltip: l10n.profileOpen,
            // push y no go: el perfil se abre encima de home, de modo que la
            // barra conserva su flecha de retroceso. Con go la pila se
            // reemplaza y `GoRouter.canPop()` devuelve false, que es lo que
            // dejaba la pantalla sin salida visible.
            onPressed: () => context.push(AppRoutes.profile),
          ),
        ],
      ),
      scrollable: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (onboarding.showsReminder) ...<Widget>[
            _OnboardingReminder(step: onboarding.step!),
            const SizedBox(height: CauceSpacing.space6),
          ],
          // US12 CA01: el acceso al cuestionario periodico. Sin mecanismo de
          // notificacion en este bloque, este aviso es la via que el propio CA
          // contempla con "o desde el menu principal".
          const _IbsSssReminder(),
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

/// Aviso del cuestionario IBS-SSS periodico vencido (US12 CA01).
///
/// Aparece cuando el ciclo de catorce dias que agenda el backend ya vencio,
/// segun el `nextAssessmentDate` de la evaluacion mas reciente.
///
/// **Sin mecanismo de notificacion en este bloque**, por decision explicita: el
/// servidor ya tiene armado el camino de push (`IbsSssReminderWorker` agenda
/// una `Notification` a las 48 horas del vencimiento), pero el movil no puede
/// recibirlo sin Firebase, que el acta M13 difirio a Mobile-4. Este aviso cubre
/// mientras tanto el acceso que el CA pide.
///
/// Mientras el estado se resuelve, o si falla, **no muestra nada**: un aviso
/// que aparece por las dudas mandaria al paciente a responder un cuestionario
/// que quiza no le toca, y el ciclo es irrepetible dentro de su ventana.
class _IbsSssReminder extends ConsumerWidget {
  const _IbsSssReminder();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final latest = ref.watch(latestIbsSssAssessmentProvider);

    final assessment = latest.valueOrNull;
    if (assessment == null || !assessment.isDue()) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: CauceSpacing.space6),
      child: Container(
        key: const Key('home_ibs_sss_reminder'),
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
              l10n.ibsSssReminderTitle,
              style: textTheme.titleMedium?.copyWith(
                color: CauceColors.infoText,
              ),
            ),
            const SizedBox(height: CauceSpacing.space1),
            Text(l10n.ibsSssReminderBody, style: textTheme.bodyMedium),
            const SizedBox(height: CauceSpacing.space3),
            CauceButton.tertiary(
              key: const Key('home_ibs_sss_resume'),
              label: l10n.ibsSssReminderAction,
              onPressed: () => context.push(AppRoutes.ibsSssPeriodic),
            ),
          ],
        ),
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
