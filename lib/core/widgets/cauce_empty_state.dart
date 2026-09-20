import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';
import 'cauce_button.dart';

/// Estado vacio del design system (seccion I).
///
/// Circulo crema de 72 con el icono en coral, titulo, cuerpo y una accion
/// opcional. El design system lo justifica asi: los estados vacios bien
/// disenados "reducen ansiedad del paciente al transmitir que el sistema esta
/// bajo control". Una lista que aparece en blanco se lee como una falla.
///
/// La accion es opcional porque no todo vacio tiene salida. El diario sin
/// registros ofrece registrar el primero; una seccion restringida por el
/// onboarding ofrece completarlo; una busqueda sin resultados ofrece crear un
/// plato. Un vacio sin nada que hacer se queda solo con el texto.
class CauceEmptyState extends StatelessWidget {
  const CauceEmptyState({
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    super.key,
  });

  final IconData icon;

  /// Que pasa, en positivo. "Aun no tienes comidas registradas hoy", no
  /// "Sin datos".
  final String title;

  /// Que va a pasar cuando haya contenido, o por que no lo hay.
  final String message;

  /// Etiqueta de la accion. Sin ella y sin [onAction] no se dibuja boton.
  final String? actionLabel;

  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final label = actionLabel;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: CauceSpacing.space6,
        vertical: CauceSpacing.space12,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 72,
            height: 72,
            decoration: const BoxDecoration(
              color: CauceColors.bgSubtle,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 36, color: CauceColors.brandBase),
          ),
          const SizedBox(height: CauceSpacing.space4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: CauceTypography.titleMedium,
          ),
          const SizedBox(height: CauceSpacing.space2),
          Text(
            message,
            textAlign: TextAlign.center,
            style: CauceTypography.bodyMedium,
          ),
          if (label != null && onAction != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space6),
            // Sin `expand`: un boton a todo el ancho bajo un bloque centrado
            // rompe el eje vertical que arma el circulo con los dos textos.
            CauceButton(
              label: label,
              onPressed: onAction,
              expand: false,
            ),
          ],
        ],
      ),
    );
  }
}
