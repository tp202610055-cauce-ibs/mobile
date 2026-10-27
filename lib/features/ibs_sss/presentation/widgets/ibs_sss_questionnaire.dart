import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../onboarding/presentation/widgets/onboarding_labels.dart';
import '../../domain/ibs_sss_assessment.dart';

/// Las cinco preguntas del IBS-SSS con su escala.
///
/// Extraido de `IbsSssBaselineScreen` en Mobile-3 para que la linea base (US04)
/// y las evaluaciones periodicas (US12) compartan el instrumento en vez de
/// duplicarlo. Es exactamente el mismo cuestionario: lo unico que cambia entre
/// los dos usos es el `assessmentType` con el que se envia.
///
/// El widget **no** conoce el ciclo de envio ni el resultado: recibe las
/// respuestas y avisa los cambios. Quien lo monta decide el envoltorio, que en
/// el onboarding es un paso del wizard y en US12 una pantalla propia.
class IbsSssQuestionnaire extends StatelessWidget {
  const IbsSssQuestionnaire({
    required this.answers,
    required this.onAnswer,
    this.enabled = true,
    this.highlightMissing = false,
    super.key,
  });

  final IbsSssAnswers answers;
  final void Function(IbsSssDimension dimension, int value) onAnswer;
  final bool enabled;

  /// Marca las preguntas sin respuesta, tras un intento de envío incompleto.
  final bool highlightMissing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        for (final dimension in IbsSssDimension.values) ...<Widget>[
          _Question(
            dimension: dimension,
            value: answers.valueFor(dimension),
            enabled: enabled,
            missing: highlightMissing && answers.valueFor(dimension) == null,
            onChanged: (value) => onAnswer(dimension, value),
          ),
          const SizedBox(height: CauceSpacing.space6),
        ],
      ],
    );
  }
}

/// Una pregunta con su escala.
class _Question extends StatelessWidget {
  const _Question({
    required this.dimension,
    required this.value,
    required this.enabled,
    required this.missing,
    required this.onChanged,
  });

  final IbsSssDimension dimension;
  final int? value;
  final bool enabled;
  final bool missing;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final question = OnboardingLabels.ibsSssQuestion(l10n, dimension);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(question, style: Theme.of(context).textTheme.titleMedium),
        if (missing) ...<Widget>[
          const SizedBox(height: CauceSpacing.space1),
          Text(
            l10n.ibsSssQuestionMissing,
            key: Key('ibs_sss_missing_${dimension.name}'),
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: CauceColors.brandBase),
          ),
        ],
        const SizedBox(height: CauceSpacing.space2),
        if (dimension == IbsSssDimension.painFrequency)
          _DaysScale(
            question: question,
            value: value,
            enabled: enabled,
            onChanged: onChanged,
          )
        else
          // Escala 0 a 100: el cero es una respuesta clínica válida.
          CauceSlider(
            key: Key('ibs_sss_${dimension.name}'),
            value: value,
            enabled: enabled,
            onChanged: onChanged,
            minLabel: OnboardingLabels.ibsSssMinLabel(l10n, dimension),
            maxLabel: OnboardingLabels.ibsSssMaxLabel(l10n, dimension),
            semanticLabel: question,
          ),
      ],
    );
  }
}

/// Días con dolor de los últimos 10; cada día aporta 10 puntos al instrumento.
class _DaysScale extends StatelessWidget {
  const _DaysScale({
    required this.question,
    required this.value,
    required this.enabled,
    required this.onChanged,
  });

  static const int pointsPerDay = 10;
  static const int maxDays = 10;

  final String question;
  final int? value;
  final bool enabled;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final days = value == null ? null : value! ~/ pointsPerDay;
    const dimension = IbsSssDimension.painFrequency;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CauceSlider(
          key: Key('ibs_sss_${dimension.name}'),
          value: days,
          max: maxDays,
          enabled: enabled,
          onChanged: (selected) => onChanged(selected * pointsPerDay),
          minLabel: OnboardingLabels.ibsSssMinLabel(l10n, dimension),
          maxLabel: OnboardingLabels.ibsSssMaxLabel(l10n, dimension),
          semanticLabel: question,
        ),
        if (days != null)
          Text(
            l10n.ibsSssPainFrequencyDays(days),
            key: const Key('ibs_sss_painFrequency_days'),
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
