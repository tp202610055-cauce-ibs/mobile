import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../onboarding/presentation/widgets/onboarding_labels.dart';
import '../application/periodic_assessment_notifier.dart';
import '../domain/ibs_sss_assessment.dart';
import 'widgets/ibs_sss_evolution_card.dart';
import 'widgets/ibs_sss_questionnaire.dart';

/// Cuestionario IBS-SSS periodico (US12 CA01, CA03 y CA04).
///
/// Pantalla propia y **no** un paso de `OnboardingStepScaffold`: aquello es un
/// wizard de onboarding y esto no lo es. Lo que si se reusa es el patron de dos
/// caras que ya tenia la linea base, formulario y despues resultado.
class PeriodicAssessmentScreen extends ConsumerStatefulWidget {
  const PeriodicAssessmentScreen({super.key});

  @override
  ConsumerState<PeriodicAssessmentScreen> createState() =>
      _PeriodicAssessmentScreenState();
}

class _PeriodicAssessmentScreenState
    extends ConsumerState<PeriodicAssessmentScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(periodicAssessmentNotifierProvider.notifier).loadEvolution();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(periodicAssessmentNotifierProvider);
    final notifier = ref.read(periodicAssessmentNotifierProvider.notifier);
    final result = state.result;

    // Segunda cara: el resultado, con la evolucion en contexto (CA03).
    if (result != null) {
      return _ResultView(state: state, result: result);
    }

    // Primera cara: el cuestionario.
    //
    // CA04 sale gratis por construccion. El puntaje no existe de este lado
    // hasta que el servidor lo devuelve, asi que no hay nada que ocultar: no
    // se puede exponer lo que todavia no se calculo en ningun lado.
    final missing = state.missing.length;

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.ibsSssPeriodicTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (state.error != null) ...<Widget>[
            CauceErrorBanner(error: state.error!),
            const SizedBox(height: CauceSpacing.space4),
          ],
          Text(
            l10n.ibsSssPeriodicSubtitle,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: CauceSpacing.space6),
          IbsSssQuestionnaire(
            answers: state.answers,
            enabled: !state.submitting,
            onAnswer: notifier.answer,
          ),
          if (missing > 0) ...<Widget>[
            Text(
              l10n.ibsSssPending(missing),
              key: const Key('ibs_sss_periodic_pending'),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CauceSpacing.space3),
          ],
          CauceButton(
            key: const Key('ibs_sss_periodic_submit'),
            label: l10n.ibsSssPeriodicSubmit,
            loading: state.submitting,
            onPressed: state.canSubmit ? notifier.submit : null,
          ),
        ],
      ),
    );
  }
}

/// Resultado de la evaluacion, con la evolucion.
///
/// **Registro clinico neutro**, igual que la linea base: el puntaje con su
/// escala, la categoria tal como la devolvio el servidor y quien la interpreta.
/// Sin colores de alarma ni adjetivos.
class _ResultView extends ConsumerWidget {
  const _ResultView({required this.state, required this.result});

  final PeriodicAssessmentState state;
  final IbsSssResult result;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final severity = result.severity;

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.ibsSssPeriodicTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            l10n.ibsSssResultTitle,
            key: const Key('ibs_sss_periodic_result_title'),
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
                  key: const Key('ibs_sss_periodic_result_score'),
                  style: textTheme.headlineMedium,
                ),
                if (severity != null) ...<Widget>[
                  const SizedBox(height: CauceSpacing.space1),
                  Text(
                    OnboardingLabels.ibsSssSeverity(l10n, severity),
                    key: const Key('ibs_sss_periodic_result_severity'),
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
          IbsSssEvolutionCard(points: state.evolution),
          const SizedBox(height: CauceSpacing.space6),
          CauceButton(
            key: const Key('ibs_sss_periodic_result_continue'),
            label: l10n.ibsSssResultContinue,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
