import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';

/// Un destino de [CauceBottomNav].
@immutable
class CauceBottomNavItem {
  const CauceBottomNavItem({
    required this.label,
    required this.icon,
    this.itemKey,
  });

  /// Etiqueta visible. Siempre visible: el design system dibuja icono y
  /// etiqueta juntos, nunca el icono solo.
  final String label;

  final IconData icon;

  /// Clave del boton, para ubicarlo en tests.
  final Key? itemKey;
}

/// Barra de navegacion inferior del design system (seccion H).
///
/// Cinco columnas con la del medio vacia: ahi se recorta el FAB elevado, que
/// no es un destino sino una accion y por eso no vive en esta barra. Quien la
/// monta pasa **cuatro** destinos.
///
/// Solo el destino activo lleva color de marca. El resto va en
/// [CauceColors.textTertiary]: una barra donde todo compite por atencion no
/// orienta a nadie.
///
/// Se implementa a mano y no con `NavigationBar` de Material 3, que impone su
/// propia altura, su indicador de pildora y su animacion de etiquetas. Pelearle
/// esos tres defaults con overrides saldria mas caro y mas fragil que dibujar
/// una fila de botones.
class CauceBottomNav extends StatelessWidget {
  const CauceBottomNav({
    required this.items,
    required this.currentIndex,
    required this.onSelected,
    super.key,
  }) : assert(items.length == 4, 'La barra lleva cuatro destinos');

  final List<CauceBottomNavItem> items;

  final int currentIndex;

  final ValueChanged<int> onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CauceColors.bgCard,
        border: Border(
          top: BorderSide(
            color: CauceColors.bgDivider,
            width: CauceBorders.subtle,
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            CauceSpacing.space2,
            CauceSpacing.space3,
            CauceSpacing.space2,
            CauceSpacing.space4,
          ),
          child: Row(
            children: <Widget>[
              _slot(0),
              _slot(1),
              // Hueco del FAB. Ocupa una columna completa para que los cuatro
              // destinos queden repartidos como en el design system y no
              // apretados contra el centro.
              const Expanded(child: SizedBox.shrink()),
              _slot(2),
              _slot(3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _slot(int index) {
    final item = items[index];
    final selected = index == currentIndex;
    final color =
        selected ? CauceColors.brandBase : CauceColors.textTertiary;

    return Expanded(
      child: Semantics(
        selected: selected,
        button: true,
        child: InkWell(
          key: item.itemKey,
          onTap: () => onSelected(index),
          borderRadius: CauceRadii.borderMd,
          child: Padding(
            padding: const EdgeInsets.all(CauceSpacing.space1),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(item.icon, size: 22, color: color),
                const SizedBox(height: CauceSpacing.space1),
                Text(
                  item.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: CauceTypography.labelSmall.copyWith(
                    fontSize: 11,
                    letterSpacing: 0,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
