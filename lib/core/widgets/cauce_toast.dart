import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../theme/design_tokens.dart';

/// Clave del contenido del toast, para ubicarlo en tests.
const Key cauceToastKey = Key('cauce_toast');

/// Toasts del design system (seccion I).
///
/// Se montan sobre `ScaffoldMessenger`, de modo que sobreviven a un cambio de
/// pantalla y se encolan solos. Cada variante trae su color, su icono y su
/// borde izquierdo de 4, que es lo que el design system usa para distinguirlas
/// sin depender del color.
///
/// El `SnackBarThemeData` del theme pinta un toast oscuro generico, que es lo
/// correcto para un aviso suelto pero no es lo que pide la seccion I. Aca se
/// neutraliza con fondo transparente, elevacion cero y relleno cero, y el
/// contenedor del design system se hace cargo de todo el aspecto. Es preferible
/// a cambiar el theme, que afectaria a cualquier `SnackBar` futuro.
abstract final class CauceToast {
  /// Duracion de un aviso sin accion.
  static const Duration _plain = Duration(seconds: 3);

  /// Duracion de un aviso con accion.
  ///
  /// Mas larga a proposito: un toast que ofrece reintentar y se va antes de
  /// que el paciente alcance el boton ofrece una salida que no existe.
  static const Duration _actionable = Duration(seconds: 6);

  /// Confirmacion de exito.
  static void success(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    _show(
      context,
      title: title,
      message: message,
      icon: TablerIcons.circle_check,
      background: CauceColors.successBg,
      foreground: CauceColors.successText,
      duration: _plain,
    );
  }

  /// Aviso informativo, sin exito ni problema.
  ///
  /// **Variante propia, no esta en la seccion I**, que define exito y error.
  /// Hace falta para explicar por que algo esta cerrado: decirlo en rojo
  /// convertiria en un fallo lo que es solo un "todavia no". Usa los mismos
  /// tokens `info` con los que [CauceBadge] pinta lo que esta en curso.
  static void info(
    BuildContext context, {
    required String title,
    String? message,
  }) {
    _show(
      context,
      title: title,
      message: message,
      icon: TablerIcons.info_circle,
      background: CauceColors.infoBg,
      foreground: CauceColors.infoText,
      duration: _plain,
    );
  }

  /// Aviso de error, con reintento opcional.
  static void error(
    BuildContext context, {
    required String title,
    String? message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(
      context,
      title: title,
      message: message,
      icon: TablerIcons.alert_circle,
      background: CauceColors.dangerBg,
      foreground: CauceColors.dangerText,
      duration: actionLabel != null && onAction != null ? _actionable : _plain,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void _show(
    BuildContext context, {
    required String title,
    required String? message,
    required IconData icon,
    required Color background,
    required Color foreground,
    required Duration duration,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final messenger = ScaffoldMessenger.of(context);

    // Un toast encima de otro apila dos avisos que dicen cosas distintas
    // sobre la misma accion. El ultimo es el que vale.
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        duration: duration,
        content: _CauceToastContent(
          title: title,
          message: message,
          icon: icon,
          background: background,
          foreground: foreground,
          actionLabel: actionLabel,
          onAction: onAction == null
              ? null
              : () {
                  messenger.hideCurrentSnackBar();
                  onAction();
                },
        ),
      ),
    );
  }
}

class _CauceToastContent extends StatelessWidget {
  const _CauceToastContent({
    required this.title,
    required this.message,
    required this.icon,
    required this.background,
    required this.foreground,
    required this.actionLabel,
    required this.onAction,
  });

  final String title;
  final String? message;
  final IconData icon;
  final Color background;
  final Color foreground;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final body = message;
    final label = actionLabel;

    return Container(
      key: cauceToastKey,
      padding: const EdgeInsets.symmetric(
        horizontal: CauceSpacing.space4,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: CauceRadii.borderMd,
        border: Border(left: BorderSide(color: foreground, width: 4)),
      ),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 22, color: foreground),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  title,
                  style: CauceTypography.bodyLarge.copyWith(
                    fontSize: 15,
                    fontWeight: CauceTypography.medium,
                    height: 1.3,
                    color: foreground,
                  ),
                ),
                if (body != null)
                  Text(
                    body,
                    style: CauceTypography.labelSmall.copyWith(
                      fontWeight: CauceTypography.regular,
                      letterSpacing: 0,
                      color: foreground,
                    ),
                  ),
              ],
            ),
          ),
          if (label != null && onAction != null) ...<Widget>[
            const SizedBox(width: CauceSpacing.space2),
            // Boton propio y no `CauceButton`: el secundario del design system
            // se contornea en coral de marca, y aca el contorno tiene que
            // seguir al color del aviso para no meter un tercer color en una
            // pieza de 48 de alto.
            OutlinedButton(
              onPressed: onAction,
              style: OutlinedButton.styleFrom(
                foregroundColor: foreground,
                side: BorderSide(color: foreground),
                padding: const EdgeInsets.symmetric(
                  horizontal: CauceSpacing.space3,
                  vertical: 6,
                ),
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                shape: const RoundedRectangleBorder(
                  borderRadius: CauceRadii.borderSm,
                ),
                textStyle: CauceTypography.labelSmall.copyWith(
                  letterSpacing: 0,
                ),
              ),
              child: Text(label),
            ),
          ],
        ],
      ),
    );
  }
}
