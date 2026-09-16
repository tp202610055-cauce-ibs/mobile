import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';

/// Control de escala 0 a 100 del design system.
///
/// Es el control del cuestionario IBS-SSS (US04), donde las cinco dimensiones
/// se puntuan sobre una escala analogica visual.
///
/// **Derivado, no transcrito.** El HTML del design system no esta disponible
/// en el checkout y no define este componente, asi que su estilo se compone
/// desde los tokens de [design_tokens.dart] con el mismo criterio que
/// `CauceTextField` y `CauceButton`. Si el documento reaparece y define un
/// slider, corresponde cotejarlo y ajustar.
///
/// Tres decisiones que el widget aporta sobre el `Slider` de Material:
///
/// 1. **[value] es nullable.** Un slider de Material siempre tiene posicion, y
///    eso haria indistinguible "el paciente eligio 0" de "todavia no
///    respondio". La distincion importa: las cinco dimensiones son
///    obligatorias y un cero es una respuesta clinica valida.
/// 2. **El valor se muestra como numero.** Una escala de 0 a 100 sin el dato
///    a la vista obliga a estimar la posicion del pulgar.
/// 3. **Area tactil de 48px**, el minimo de accesibilidad que fija el design
///    system y que el `Slider` de Material no garantiza por si solo.
class CauceSlider extends StatelessWidget {
  const CauceSlider({
    required this.value,
    required this.onChanged,
    this.minLabel,
    this.maxLabel,
    this.semanticLabel,
    this.enabled = true,
    super.key,
  });

  /// Valor actual, o `null` si la pregunta sigue sin responder.
  final int? value;

  final ValueChanged<int>? onChanged;

  /// Texto bajo el extremo izquierdo, por ejemplo "Sin dolor".
  final String? minLabel;

  /// Texto bajo el extremo derecho, por ejemplo "Muy intenso".
  final String? maxLabel;

  /// Etiqueta para lectores de pantalla. Sin ella, el lector anuncia un
  /// numero suelto sin decir de que pregunta es.
  final String? semanticLabel;

  final bool enabled;

  /// Extremos de la escala, fijados por el instrumento IBS-SSS.
  static const int min = 0;
  static const int max = 100;

  bool get _answered => value != null;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final active = enabled && onChanged != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // El valor arranca en el centro cuando no hay respuesta, pero pintado
        // en gris y sin numero: indica donde caeria el pulgar sin afirmar que
        // esa sea la respuesta del paciente.
        SizedBox(
          height: CauceSizes.touchTargetMin,
          child: Semantics(
            label: semanticLabel,
            value: _answered ? '$value' : null,
            slider: true,
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor:
                    _answered ? CauceColors.brandBase : CauceColors.bgDivider,
                thumbColor: _answered
                    ? CauceColors.brandBase
                    : CauceColors.textTertiary,
              ),
              child: Slider(
                value: (value ?? (min + max) ~/ 2).toDouble(),
                min: min.toDouble(),
                max: max.toDouble(),
                // Una division por unidad: la escala es de enteros y permitir
                // decimales daria un dato que el backend rechaza.
                divisions: max - min,
                label: _answered ? '$value' : null,
                onChanged: active ? (raw) => onChanged!(raw.round()) : null,
              ),
            ),
          ),
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Text(
                minLabel ?? '$min',
                style: textTheme.labelSmall,
              ),
            ),
            // El numero solo aparece cuando hay respuesta. Mostrar "50" de
            // arranque leeria como una respuesta que el paciente no dio.
            Text(
              _answered ? '$value' : '',
              key: const Key('cauce_slider_value'),
              style: textTheme.titleMedium?.copyWith(
                color: CauceColors.brandStrong,
              ),
            ),
            Expanded(
              child: Text(
                maxLabel ?? '$max',
                style: textTheme.labelSmall,
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
