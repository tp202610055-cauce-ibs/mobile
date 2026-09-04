import 'package:flutter/material.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/design_tokens.dart';

/// Indicador de carga del design system.
///
/// Dos formas: [CauceLoadingIndicator.inline], del tamano de un icono, para
/// meter dentro de un boton; y [CauceLoadingIndicator.fullscreen], centrado y
/// con texto, para una pantalla que todavia no tiene contenido.
class CauceLoadingIndicator extends StatelessWidget {
  /// Indicador compacto, sin texto.
  const CauceLoadingIndicator.inline({this.color, super.key})
      : _fullscreen = false,
        message = null;

  /// Indicador centrado con mensaje opcional.
  const CauceLoadingIndicator.fullscreen({this.message, super.key})
      : _fullscreen = true,
        color = null;

  final bool _fullscreen;
  final Color? color;

  /// Texto bajo el indicador. Si es null se usa el generico de l10n.
  final String? message;

  @override
  Widget build(BuildContext context) {
    if (!_fullscreen) {
      return SizedBox(
        width: 20,
        height: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: color ?? CauceColors.brandBase,
          // El indicador dentro de un boton es decorativo: el estado de carga
          // ya lo comunica el propio boton deshabilitado.
          semanticsLabel: null,
        ),
      );
    }

    final l10n = AppLocalizations.of(context);
    final text = message ?? l10n.commonLoading;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          CircularProgressIndicator(strokeWidth: 3, semanticsLabel: text),
          const SizedBox(height: CauceSpacing.space4),
          Text(text, style: CauceTypography.bodyMedium),
        ],
      ),
    );
  }
}
