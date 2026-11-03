import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'inactivity_monitor.dart';

/// Pasa al [InactivityMonitor] cada toque y cada vuelta de segundo plano.
///
/// Envuelve la app entera, de modo que ningun toque se le escapa. No consume
/// el toque: el gesto sigue su curso, y si cerro la sesion el router lo
/// lleva al login.
class InactivityListener extends ConsumerStatefulWidget {
  const InactivityListener({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<InactivityListener> createState() => _InactivityListenerState();
}

class _InactivityListenerState extends ConsumerState<InactivityListener> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () =>
          ref.read(sessionInactivityMonitorProvider).checkOnResume(),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final monitor = ref.watch(sessionInactivityMonitorProvider);
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => monitor.registerActivity(),
      child: widget.child,
    );
  }
}
