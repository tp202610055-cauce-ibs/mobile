import 'package:flutter/widgets.dart';

/// Desplaza una vez hasta [child] al abrir la pantalla, si [enabled].
///
/// No mueve nada si [child] ya se ve entero.
class RevealOnOpen extends StatefulWidget {
  const RevealOnOpen({required this.enabled, required this.child, super.key});

  final bool enabled;
  final Widget child;

  @override
  State<RevealOnOpen> createState() => _RevealOnOpenState();
}

class _RevealOnOpenState extends State<RevealOnOpen> {
  @override
  void initState() {
    super.initState();
    if (widget.enabled) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _reveal());
    }
  }

  void _reveal() {
    if (!mounted) {
      return;
    }
    final box = context.findRenderObject();
    final viewport = Scrollable.maybeOf(context)?.context.findRenderObject();
    if (box is! RenderBox || viewport is! RenderBox || !box.hasSize) {
      return;
    }
    final top = box.localToGlobal(Offset.zero, ancestor: viewport).dy;
    final bottom = top + box.size.height;
    if (top >= 0 && bottom <= viewport.size.height) {
      return;
    }
    Scrollable.ensureVisible(
      context,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
