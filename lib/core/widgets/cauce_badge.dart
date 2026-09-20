import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';

/// Registro semantico de un [CauceBadge], segun la seccion F del design
/// system.
///
/// Los nombres son del tono y no del dominio: un badge no sabe de FODMAP ni de
/// sincronizacion, con el mismo criterio con que `CauceSparkline` no sabe de
/// IBS-SSS. Cada feature traduce su dominio a un tono y elige su icono. Meter
/// aca `fodmapHigh` o `syncPending` ataria un atomo transversal al vocabulario
/// de dos features.
enum CauceBadgeTone {
  /// Gris. Estado sin carga valorativa.
  neutral,

  /// Azul. Informacion en curso, sin exito ni problema.
  info,

  /// Verde. Confirmado, completado, sin riesgo.
  success,

  /// Ambar. Atencion, valor intermedio.
  warning,

  /// Rojo. Problema, rechazo, nivel alto.
  danger,

  /// Coral de marca. Pertenencia al producto, no juicio clinico.
  brand,
}

/// Badge del design system (seccion F).
///
/// **El icono no es decorativo y por eso es obligatorio.** El design system
/// dibuja los cinco grupos de badges con icono y texto juntos, y la regla de
/// accesibilidad del proyecto es que un estado nunca se comunica solo por
/// color. Un badge sin icono seria un badge que alguien con daltonismo lee
/// mal, asi que el parametro no es opcional.
///
/// El tamano de fuente sale de [CauceTypography.labelSmall], que el propio
/// token declara como el estilo de "caption, badge y timestamp".
class CauceBadge extends StatelessWidget {
  const CauceBadge({
    required this.label,
    required this.icon,
    required this.tone,
    this.compact = false,
    super.key,
  });

  final String label;

  final IconData icon;

  final CauceBadgeTone tone;

  /// Reduce el relleno para las filas densas del timeline.
  ///
  /// La seccion G aprieta el badge dentro de la tarjeta de comida y de
  /// sintoma, donde comparte fila con el tipo y la hora. Fuera de esa fila el
  /// badge va con el relleno normal de la seccion F.
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final colors = _colors;

    return Container(
      padding: compact
          ? const EdgeInsets.symmetric(
              horizontal: CauceSpacing.space2,
              vertical: 3,
            )
          : const EdgeInsets.symmetric(
              horizontal: CauceSpacing.space3,
              vertical: 6,
            ),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: CauceRadii.borderSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 14, color: colors.foreground),
          const SizedBox(width: 6),
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: CauceTypography.labelSmall.copyWith(
                color: colors.foreground,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// El tono neutro usa [CauceColors.bgSubtle] y no el `#F1EFE8` literal del
  /// HTML: ese valor no esta tokenizado y los dos crema son indistinguibles a
  /// simple vista. Preferimos el token antes que sumar un color suelto.
  ({Color background, Color foreground}) get _colors => switch (tone) {
        CauceBadgeTone.neutral => (
            background: CauceColors.bgSubtle,
            foreground: CauceColors.textTertiary,
          ),
        CauceBadgeTone.info => (
            background: CauceColors.infoBg,
            foreground: CauceColors.infoText,
          ),
        CauceBadgeTone.success => (
            background: CauceColors.successBg,
            foreground: CauceColors.successText,
          ),
        CauceBadgeTone.warning => (
            background: CauceColors.warningBg,
            foreground: CauceColors.warningText,
          ),
        CauceBadgeTone.danger => (
            background: CauceColors.dangerBg,
            foreground: CauceColors.dangerText,
          ),
        CauceBadgeTone.brand => (
            background: CauceColors.brandSoft,
            foreground: CauceColors.brandStrong,
          ),
      };
}
