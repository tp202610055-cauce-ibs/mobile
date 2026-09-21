import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../theme/design_tokens.dart';

/// Una accion del menu de [CauceExpandableFab].
@immutable
class CauceFabAction {
  const CauceFabAction({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.hint,
    this.actionKey,
  });

  final String label;

  final IconData icon;

  /// `null` deja la accion a la vista pero sin efecto.
  ///
  /// Una accion que desaparece cuando no toca deja al paciente preguntandose
  /// si existe. Una que sigue ahi, apagada y con su [hint], le dice que existe
  /// y por que todavia no.
  final VoidCallback? onPressed;

  /// Por que esta apagada. Obligatorio en la practica cuando [onPressed] es
  /// `null`: la regla del proyecto es que nada se deshabilita sin explicar.
  final String? hint;

  /// Clave de la pildora, para ubicarla en tests.
  final Key? actionKey;

  bool get enabled => onPressed != null;
}

/// Clave del boton flotante, para ubicarlo en tests.
const Key cauceFabKey = Key('cauce_fab');

/// Clave del velo que cubre la pantalla con el menu abierto.
const Key cauceFabScrimKey = Key('cauce_fab_scrim');

/// FAB central con menu expandible (seccion H del design system).
///
/// Cumple la **regla de 2 toques**: desde cualquier pestana, registrar algo
/// cuesta abrir el menu y elegir la accion.
///
/// Cerrado es un circulo de 56 en coral con un mas. Abierto, el mismo circulo
/// pasa a [CauceColors.brandStrong] con una equis y las acciones aparecen
/// apiladas encima, sobre un velo que atenua el resto de la pantalla.
///
/// El menu se dibuja en un `OverlayPortal` y no dentro del arbol del Scaffold
/// porque tiene que tapar la barra inferior y el contenido de la pestana, que
/// estan por encima del FAB en el orden de pintado. Anclarlo al boton con un
/// `LayerLink` mantiene las pildoras centradas sobre el circulo aunque el
/// teclado o una barra del sistema muevan el FAB.
class CauceExpandableFab extends StatefulWidget {
  const CauceExpandableFab({
    required this.actions,
    required this.openLabel,
    required this.closeLabel,
    super.key,
  });

  final List<CauceFabAction> actions;

  /// Etiqueta accesible con el menu cerrado.
  final String openLabel;

  /// Etiqueta accesible con el menu abierto.
  final String closeLabel;

  @override
  State<CauceExpandableFab> createState() => _CauceExpandableFabState();
}

class _CauceExpandableFabState extends State<CauceExpandableFab> {
  final OverlayPortalController _controller = OverlayPortalController();
  final LayerLink _link = LayerLink();
  bool _open = false;

  void _toggle() {
    setState(() {
      _open = !_open;
      if (_open) {
        _controller.show();
      } else {
        _controller.hide();
      }
    });
  }

  void _close() {
    if (!_open) {
      return;
    }
    setState(() {
      _open = false;
      _controller.hide();
    });
  }

  /// Cierra el menu y recien despues ejecuta la accion.
  ///
  /// Al reves, la navegacion se dispara con el overlay todavia montado y el
  /// velo queda un instante sobre la pantalla nueva.
  void _run(CauceFabAction action) {
    _close();
    action.onPressed?.call();
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _controller,
      overlayChildBuilder: _buildMenu,
      child: CompositedTransformTarget(
        link: _link,
        child: Semantics(
          button: true,
          label: _open ? widget.closeLabel : widget.openLabel,
          child: SizedBox(
            width: 56,
            height: 56,
            child: Material(
              key: cauceFabKey,
              color: _open ? CauceColors.brandStrong : CauceColors.brandBase,
              shape: const CircleBorder(
                // El borde en el color del fondo de pagina recorta el circulo
                // contra la barra, que es lo que le da el aire de elevado.
                side: BorderSide(color: CauceColors.bgPage, width: 4),
              ),
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: _toggle,
                child: Icon(
                  _open ? TablerIcons.x : TablerIcons.plus,
                  color: CauceColors.textOnBrand,
                  size: 26,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMenu(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(
          child: GestureDetector(
            key: cauceFabScrimKey,
            onTap: _close,
            behavior: HitTestBehavior.opaque,
            child: ColoredBox(
              color: CauceColors.textPrimary.withValues(alpha: 0.35),
            ),
          ),
        ),
        CompositedTransformFollower(
          link: _link,
          targetAnchor: Alignment.topCenter,
          followerAnchor: Alignment.bottomCenter,
          offset: const Offset(0, -CauceSpacing.space3),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              for (final action in widget.actions) ...<Widget>[
                _ActionPill(action: action, onTap: () => _run(action)),
                const SizedBox(height: 14),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({required this.action, required this.onTap});

  final CauceFabAction action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final hint = action.hint;
    final enabled = action.enabled;
    final foreground =
        enabled ? CauceColors.textPrimary : CauceColors.textTertiary;

    return Material(
      color: CauceColors.bgCard,
      borderRadius: CauceRadii.borderXl,
      elevation: 2,
      shadowColor: CauceColors.textPrimary.withValues(alpha: 0.06),
      child: InkWell(
        key: action.actionKey,
        borderRadius: CauceRadii.borderXl,
        onTap: enabled ? onTap : null,
        child: Container(
          constraints: const BoxConstraints(
            minHeight: CauceSizes.touchTargetMin,
          ),
          // 20 horizontal es literal y no un token: la escala del design
          // system salta de 16 a 24, y la pildora de la seccion H se dibuja
          // con 20. Mismo criterio que el 14 vertical del toast.
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: CauceSpacing.space3,
          ),
          decoration: BoxDecoration(
            borderRadius: CauceRadii.borderXl,
            border: Border.all(
              color: CauceColors.bgDivider,
              width: CauceBorders.subtle,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                action.icon,
                size: 20,
                color:
                    enabled ? CauceColors.brandBase : CauceColors.textTertiary,
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    action.label,
                    style: CauceTypography.labelLarge.copyWith(
                      fontSize: 15,
                      color: foreground,
                    ),
                  ),
                  if (hint != null)
                    Text(
                      hint,
                      style: CauceTypography.labelSmall.copyWith(
                        letterSpacing: 0,
                        color: CauceColors.textTertiary,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
