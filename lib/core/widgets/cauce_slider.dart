import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';

/// Control de escala numerica del design system.
///
/// Nacio como el control del cuestionario IBS-SSS (US04), donde las cinco
/// dimensiones se puntuan de 0 a 100 sobre una escala analogica visual, y Mobile-3
/// lo reusa para la intensidad de un sintoma (US11).
///
/// **Los extremos son parametros desde Mobile-3**, con los mismos valores por
/// defecto de siempre, de modo que el cuestionario no cambia una linea. El
/// motivo del cambio es clinico y no estetico: el backend acepta la intensidad
/// de un sintoma entre **1 y 100** (`Symptom.MinIntensity`,
/// `InclusiveBetween(1, 100)`), asi que dejar el cero disponible le ofreceria al
/// paciente un valor que el servidor rechaza con un 400.
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
    this.min = 0,
    this.max = 100,
    this.minLabel,
    this.maxLabel,
    this.semanticLabel,
    this.enabled = true,
    super.key,
  }) : assert(min < max, 'El extremo inferior debe ser menor que el superior');

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

  /// Extremo inferior de la escala.
  ///
  /// El default de 0 es el del instrumento IBS-SSS. La intensidad de un sintoma
  /// lo instancia con 1, porque el backend rechaza el cero.
  final int min;

  /// Extremo superior de la escala. 100 en los dos usos actuales.
  final int max;

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
            // El lector anuncia el rango real de **esta** instancia y no un
            // 0 a 100 fijo: en la intensidad de un sintoma la escala empieza en
            // 1, y decir lo contrario mandaria a quien usa lector de pantalla a
            // buscar un valor que no existe.
            value: _answered ? '$value de $min a $max' : null,
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
