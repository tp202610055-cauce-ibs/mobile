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
    super.key,
  });

  final IbsSssAnswers answers;
  final void Function(IbsSssDimension dimension, int value) onAnswer;
  final bool enabled;

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
    required this.onChanged,
  });

  final IbsSssDimension dimension;
  final int? value;
  final bool enabled;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final question = OnboardingLabels.ibsSssQuestion(l10n, dimension);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(question, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: CauceSpacing.space2),
        // Escala 0 a 100, la del instrumento: aca el cero es una respuesta
        // clinica valida y por eso se usan los extremos por defecto.
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
