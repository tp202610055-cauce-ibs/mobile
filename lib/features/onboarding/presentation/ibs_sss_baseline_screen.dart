import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../ibs_sss/domain/ibs_sss_assessment.dart';
import '../../ibs_sss/presentation/widgets/ibs_sss_questionnaire.dart';
import '../application/ibs_sss_baseline_notifier.dart';
import '../application/onboarding_notifier.dart';
import 'widgets/onboarding_labels.dart';
import 'widgets/onboarding_scaffold.dart';

/// Paso 2 del wizard: cuestionario IBS-SSS de linea base (US04).
///
/// La pantalla tiene dos caras. Mientras no hay resultado muestra las cinco
/// preguntas; con resultado muestra el resumen y recien al confirmarlo cierra
/// el onboarding. Sin esa segunda cara el guard llevaria a la home en el
/// instante del envio y el paciente nunca veria lo que registro.
class IbsSssBaselineScreen extends ConsumerWidget {
  const IbsSssBaselineScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(ibsSssBaselineNotifierProvider);
    final notifier = ref.read(ibsSssBaselineNotifierProvider.notifier);
    final result = state.result;

    if (result != null) {
      return _ResultView(
        result: result,
        onContinue: notifier.acknowledgeResult,
      );
    }

    final missing = state.answers.missing.length;

    return OnboardingStepScaffold(
      step: 2,
      title: l10n.ibsSssTitle,
      subtitle: l10n.ibsSssSubtitle,
      busy: state.submitting,
      onDefer: () => ref.read(onboardingNotifierProvider.notifier).defer(),
      children: <Widget>[
        if (state.error != null) ...<Widget>[
          CauceErrorBanner(error: state.error!),
          const SizedBox(height: CauceSpacing.space4),
        ],
        // El cuestionario en si vive en `features/ibs_sss/presentation/`: lo
        // comparte con las evaluaciones periodicas de US12, que son el mismo
        // instrumento con otro envoltorio.
        IbsSssQuestionnaire(
          answers: state.answers,
          enabled: !state.submitting,
          onAnswer: notifier.answer,
        ),
        // El contador aparece solo mientras falte algo. Con las cinco
        // respondidas seria ruido bajo un boton ya habilitado.
        if (missing > 0) ...<Widget>[
          Text(
            l10n.ibsSssPending(missing),
            key: const Key('ibs_sss_pending'),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CauceSpacing.space3),
        ],
        CauceButton(
          key: const Key('ibs_sss_submit'),
          label: l10n.ibsSssSubmit,
          loading: state.submitting,
          // US04 CA02. Sin las cinco, el envio no existe como accion: nada
          // parcial sale del dispositivo, y la linea base es irrepetible.
          onPressed: state.canSubmit ? notifier.submit : null,
        ),
      ],
    );
  }
}

/// Resumen del cuestionario ya registrado.
///
/// **Registro clinico neutro.** Se muestra el puntaje con su escala completa y
/// la categoria tal como la devolvio el servidor, mas quien la interpreta. Sin
/// colores de alarma ni adjetivos: es el punto de partida de una medicion, no
/// un diagnostico.
class _ResultView extends StatelessWidget {
  const _ResultView({required this.result, required this.onContinue});

  final IbsSssResult result;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final severity = result.severity;

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.appTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            l10n.ibsSssResultTitle,
            key: const Key('ibs_sss_result_title'),
            style: textTheme.headlineLarge,
          ),
          const SizedBox(height: CauceSpacing.space6),
          Container(
            padding: const EdgeInsets.all(CauceSpacing.space4),
            decoration: BoxDecoration(
              color: CauceColors.bgCard,
              borderRadius: CauceRadii.borderLg,
              border: Border.all(color: CauceColors.bgDivider),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.ibsSssResultScore(result.totalScore),
                  key: const Key('ibs_sss_result_score'),
                  style: textTheme.headlineMedium,
                ),
                if (severity != null) ...<Widget>[
                  const SizedBox(height: CauceSpacing.space1),
                  Text(
                    OnboardingLabels.ibsSssSeverity(l10n, severity),
                    key: const Key('ibs_sss_result_severity'),
                    style: textTheme.bodyLarge?.copyWith(
                      color: CauceColors.textSecondary,
                    ),
                  ),
                ],
                const SizedBox(height: CauceSpacing.space3),
                Text(l10n.ibsSssResultNote, style: textTheme.bodyMedium),
              ],
            ),
          ),
          const SizedBox(height: CauceSpacing.space6),
          CauceButton(
            key: const Key('ibs_sss_result_continue'),
            label: l10n.ibsSssResultContinue,
            onPressed: onContinue,
          ),
        ],
      ),
    );
  }
}
