import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';
import 'cauce_button.dart';

/// Claves del dialogo de confirmacion, para ubicarlo en tests.
const Key cauceConfirmDialogKey = Key('cauce_confirm_dialog');
const Key cauceConfirmAcceptKey = Key('cauce_confirm_accept');
const Key cauceConfirmCancelKey = Key('cauce_confirm_cancel');

/// Dialogo de confirmacion, derivado de los tokens.
///
/// El design system no define un dialogo modal. Se construye con el mismo
/// criterio que `CauceSlider` y `CauceChoiceField`: superficie de tarjeta,
/// radio grande, el espaciado de la escala y los botones del design system,
/// sin inventar colores ni medidas sueltas.
///
/// Devuelve `true` solo si el paciente confirmo. Descartar el dialogo tocando
/// fuera equivale a cancelar, y por eso el `null` de `showDialog` se traduce a
/// `false` en vez de propagarse: quien llama no deberia tener que distinguir
/// "cancele" de "me fui", que para una accion irreversible son lo mismo.
abstract final class CauceConfirmDialog {
  /// Pregunta y espera. Ver la nota de la clase sobre el valor devuelto.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmLabel,
    required String cancelLabel,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext dialogContext) => _CauceConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
      ),
    );
    return confirmed ?? false;
  }
}

class _CauceConfirmDialog extends StatelessWidget {
  const _CauceConfirmDialog({
    required this.title,
    required this.message,
    required this.confirmLabel,
    required this.cancelLabel,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      key: cauceConfirmDialogKey,
      backgroundColor: CauceColors.bgCard,
      shape: const RoundedRectangleBorder(
        borderRadius: CauceRadii.borderLg,
      ),
      insetPadding: const EdgeInsets.all(CauceSpacing.space6),
      child: Padding(
        padding: const EdgeInsets.all(CauceSpacing.space6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(title, style: CauceTypography.titleMedium),
            const SizedBox(height: CauceSpacing.space2),
            Text(message, style: CauceTypography.bodyMedium),
            const SizedBox(height: CauceSpacing.space6),
            CauceButton(
              key: cauceConfirmAcceptKey,
              label: confirmLabel,
              onPressed: () => Navigator.of(context).pop(true),
            ),
            const SizedBox(height: CauceSpacing.space2),
            // Cancelar va debajo y en terciario, no al costado. En una fila
            // de dos botones del mismo peso, confirmar y cancelar compiten; en
            // columna, la jerarquia es la que ya define el design system y el
            // escape queda siempre visible sin disputarle el ojo a la accion.
            CauceButton.tertiary(
              key: cauceConfirmCancelKey,
              label: cancelLabel,
              expand: true,
              onPressed: () => Navigator.of(context).pop(false),
            ),
          ],
        ),
      ),
    );
  }
}
