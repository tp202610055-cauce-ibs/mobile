import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/design_tokens.dart';

/// Barra superior del design system.
///
/// Implementa [PreferredSizeWidget] para poder pasarse como `appBar`. El
/// boton de retroceso aparece solo si [showBackButton] es true y hay algo a
/// donde volver: mostrarlo sin pila deja al paciente ante un boton muerto.
class CauceAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CauceAppBar({
    this.title,
    this.showBackButton = false,
    this.onBack,
    this.actions,
    super.key,
  });

  final String? title;
  final bool showBackButton;

  /// Accion del retroceso. Por defecto, `context.pop()`.
  final VoidCallback? onBack;

  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final canPop = onBack != null || GoRouter.of(context).canPop();

    return AppBar(
      title: title == null ? null : Text(title!),
      leading: showBackButton && canPop
          ? IconButton(
              key: const Key('cauce_app_bar_back'),
              icon: const Icon(TablerIcons.arrow_left),
              tooltip: l10n.commonBack,
              onPressed: onBack ?? () => context.pop(),
            )
          : null,
      actions: actions,
    );
  }
}

/// Andamio de pantalla del design system.
///
/// Aporta el fondo crema, el area segura y el padding horizontal estandar, que
/// de otro modo cada pantalla repite. Cuando el contenido puede exceder la
/// altura disponible, [scrollable] lo envuelve en un scroll y lo centra
/// horizontalmente con un ancho maximo legible.
class CauceScaffold extends StatelessWidget {
  const CauceScaffold({
    required this.body,
    this.appBar,
    this.backgroundColor,
    this.scrollable = false,
    this.centerVertically = false,
    this.maxContentWidth = 440,
    this.padding,
    super.key,
  });

  final Widget body;
  final CauceAppBar? appBar;

  /// Por defecto, el crema de [CauceColors.bgPage] via el theme.
  final Color? backgroundColor;

  final bool scrollable;

  /// Centra verticalmente cuando el contenido es corto. Util en pantallas de
  /// confirmacion, donde un bloque pegado arriba se ve desbalanceado.
  final bool centerVertically;

  /// Ancho maximo del contenido. Evita lineas incomodas de leer en tablets.
  final double maxContentWidth;

  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final effectivePadding = padding ??
        const EdgeInsets.symmetric(
          horizontal: CauceSpacing.space4,
          vertical: CauceSpacing.space6,
        );

    Widget content = ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxContentWidth),
      child: body,
    );

    if (scrollable) {
      content = SingleChildScrollView(
        padding: effectivePadding,
        child: Center(child: content),
      );
    } else {
      content = Padding(
        padding: effectivePadding,
        child: Center(child: content),
      );
    }

    if (centerVertically && !scrollable) {
      content = Center(child: content);
    }

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: appBar,
      body: SafeArea(child: content),
    );
  }
}
