import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/symptom_draft.dart';

/// Intensidad del síntoma: un campo que acepta cualquier número y el
/// deslizador como ayuda; los dos muestran el mismo valor.
class SymptomIntensityInput extends StatefulWidget {
  const SymptomIntensityInput({
    required this.value,
    required this.enabled,
    required this.onSlide,
    required this.onTyped,
    this.errorText,
    super.key,
  });

  final int? value;
  final bool enabled;
  final ValueChanged<int> onSlide;
  final ValueChanged<String> onTyped;
  final String? errorText;

  @override
  State<SymptomIntensityInput> createState() => _SymptomIntensityInputState();
}

class _SymptomIntensityInputState extends State<SymptomIntensityInput> {
  late final TextEditingController _text =
      TextEditingController(text: widget.value?.toString() ?? '');

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  bool get _inRange {
    final value = widget.value;
    return value != null &&
        value >= SymptomDraft.minIntensity &&
        value <= SymptomDraft.maxIntensity;
  }

  void _slide(int value) {
    _text.text = '$value';
    widget.onSlide(value);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CauceTextField(
          key: const Key('symptom_intensity_input'),
          controller: _text,
          label: l10n.symptomsIntensityInputLabel,
          errorText: widget.errorText,
          keyboardType: const TextInputType.numberWithOptions(signed: true),
          enabled: widget.enabled,
          onChanged: widget.onTyped,
        ),
        const SizedBox(height: CauceSpacing.space2),
        // El deslizador solo admite el rango válido: fuera de él queda vacío.
        CauceSlider(
          key: const Key('symptom_intensity_field'),
          value: _inRange ? widget.value : null,
          min: SymptomDraft.minIntensity,
          max: SymptomDraft.maxIntensity,
          step: SymptomDraft.intensityStep,
          enabled: widget.enabled,
          onChanged: _slide,
          minLabel: l10n.symptomsIntensityMin,
          maxLabel: l10n.symptomsIntensityMax,
          semanticLabel: l10n.symptomsIntensityLabel,
        ),
      ],
    );
  }
}
