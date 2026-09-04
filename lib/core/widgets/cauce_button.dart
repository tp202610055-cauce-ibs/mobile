import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';
import 'cauce_loading_indicator.dart';

/// Jerarquia visual del boton, segun el design system.
enum CauceButtonVariant {
  /// Accion principal de la pantalla. Fondo de marca solido.
  primary,

  /// Accion secundaria. Contorno de marca sobre fondo transparente.
  secondary,

  /// Accion terciaria, de bajo peso. Solo texto.
  tertiary,
}

/// Boton del design system.
///
/// Tres variantes y cuatro estados: normal, presionado, deshabilitado y
/// cargando. El estilo sale del theme, de modo que este widget aporta la
/// semantica (que variante, si esta cargando) y no colores literales.
///
/// Mientras [loading] es true el boton queda deshabilitado ademas de mostrar
/// el indicador: un boton que gira pero sigue aceptando toques deja emitir la
/// misma peticion dos veces.
class CauceButton extends StatelessWidget {
  const CauceButton({
    required this.label,
    required this.onPressed,
    this.variant = CauceButtonVariant.primary,
    this.loading = false,
    this.icon,
    this.expand = true,
    super.key,
  });

  /// Atajo para la variante secundaria.
  const CauceButton.secondary({
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.icon,
    this.expand = true,
    super.key,
  }) : variant = CauceButtonVariant.secondary;

  /// Atajo para la variante terciaria.
  const CauceButton.tertiary({
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.icon,
    this.expand = false,
    super.key,
  }) : variant = CauceButtonVariant.tertiary;

  final String label;

  /// `null` deja el boton deshabilitado.
  final VoidCallback? onPressed;

  final CauceButtonVariant variant;
  final bool loading;
  final IconData? icon;

  /// Si ocupa todo el ancho disponible. Los terciarios no, por defecto.
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final effectiveOnPressed = loading ? null : onPressed;
    final child = loading
        ? CauceLoadingIndicator.inline(color: _spinnerColor)
        : _label(context);

    final button = switch (variant) {
      CauceButtonVariant.primary => ElevatedButton(
          onPressed: effectiveOnPressed,
          child: child,
        ),
      CauceButtonVariant.secondary => OutlinedButton(
          onPressed: effectiveOnPressed,
          child: child,
        ),
      CauceButtonVariant.tertiary => TextButton(
          onPressed: effectiveOnPressed,
          child: child,
        ),
    };

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }

  Widget _label(BuildContext context) {
    if (icon == null) {
      return Text(label);
    }
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon, size: 20),
        const SizedBox(width: CauceSpacing.space2),
        Flexible(child: Text(label, overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  /// El indicador va en el color del texto de la variante, no en el de marca:
  /// sobre el fondo coral del primario, un spinner coral seria invisible.
  Color get _spinnerColor => switch (variant) {
        CauceButtonVariant.primary => CauceColors.textOnBrand,
        CauceButtonVariant.secondary => CauceColors.brandStrong,
        CauceButtonVariant.tertiary => CauceColors.brandBase,
      };
}
