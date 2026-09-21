import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/application/session_notifier.dart';
import '../../ibs_sss/application/periodic_assessment_notifier.dart';
import '../../onboarding/application/onboarding_notifier.dart';
import 'widgets/home_cards.dart';

/// Pestana de Inicio.
///
/// Desde Mobile-3.1 es la raiz de la primera rama del shell, y por eso pierde
/// dos cosas que tenia cuando era la unica pantalla autenticada: el boton de
/// cerrar sesion, que se mudo a Perfil con su confirmacion (CP020 paso 3), y
/// el icono que abria el perfil, que ahora es una pestana de la barra.
///
/// Mobile-3.2 le puso contenido. Hasta entonces era un saludo y aire, porque
/// se le habian quitado el cierre de sesion y el icono de perfil sin poner
/// nada en su lugar, y asi se vio en el celular.
///
/// Es la version minima del mockup `06-home-dashboard`, armada **solo con
/// datos que ya existen**: el puntaje IBS-SSS con su cambio contra la linea
/// base y la fecha del proximo cuestionario, y el resumen de lo registrado
/// hoy. El grafico grande con eje temporal llega en Mobile-4 con HU0023, y la
/// seccion "Para hoy" en Mobile-5 con EP0003.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final user = ref.watch(sessionNotifierProvider).user;
    final onboarding = ref.watch(resolvedOnboardingProvider);

    return CauceScaffold(
      // Sin flecha de retroceso: es una raiz de pestana, no hay a donde
      // volver.
      appBar: CauceAppBar(title: l10n.navHome),
      scrollable: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (onboarding.showsReminder) ...<Widget>[
            _OnboardingReminder(step: onboarding.step!),
            const SizedBox(height: CauceSpacing.space6),
          ],
          // US12 CA01: el acceso al cuestionario periodico. Sin mecanismo de
          // notificacion en este bloque, este aviso es la via que el propio CA
          // contempla con "o desde el menu principal".
          const _IbsSssReminder(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              l10n.homeGreeting(user?.fullName ?? ''),
              style: textTheme.headlineMedium,
            ),
          ),
          const SizedBox(height: CauceSpacing.space6),
          const HomeScoreCard(),
          const HomeTodayCard(),
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
/// recibirlo sin Firebase, que el acta M13 difirio. Este aviso cubre mientras
/// tanto el acceso que el CA pide, y desde Mobile-3.1 lo acompana el item del
/// menu del FAB, alcanzable desde cualquier pestana.
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
