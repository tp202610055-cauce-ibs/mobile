import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../l10n/generated/app_localizations.dart';
import '../widgets/widgets.dart';
import 'push_destination.dart';
import 'push_messaging.dart';
import 'push_navigation.dart';

/// Abre el destino de un toque y avisa de los push en primer plano.
///
/// Envuelve el shell, de modo que solo actua con la sesion iniciada y el
/// onboarding resuelto. El contenido del push no se guarda ni se registra.
class PushInbox extends ConsumerStatefulWidget {
  const PushInbox({
    required this.onForegroundMessage,
    required this.child,
    super.key,
  });

  /// Refresca lo que el push pudo cambiar, como las tarjetas de Inicio.
  final VoidCallback onForegroundMessage;

  final Widget child;

  @override
  ConsumerState<PushInbox> createState() => _PushInboxState();
}

class _PushInboxState extends ConsumerState<PushInbox> {
  StreamSubscription<PushMessage>? _foreground;

  @override
  void initState() {
    super.initState();
    ref.listenManual<PushDestination?>(
      pendingPushDestinationProvider,
      (_, next) {
        if (next != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) => _openPending());
        }
      },
      fireImmediately: true,
    );
    _foreground =
        ref.read(pushMessagingProvider).onMessage.listen(_showForeground);
  }

  @override
  void dispose() {
    unawaited(_foreground?.cancel());
    super.dispose();
  }

  void _openPending() {
    if (!mounted) {
      return;
    }
    final destination =
        ref.read(pendingPushDestinationProvider.notifier).take();
    if (destination == null) {
      return;
    }
    final router = GoRouter.of(context);
    if (destination.stacked) {
      unawaited(router.push<void>(destination.location));
    } else {
      router.go(destination.location);
    }
  }

  void _showForeground(PushMessage message) {
    if (!mounted) {
      return;
    }
    widget.onForegroundMessage();
    CauceToast.info(
      context,
      title: message.title ?? AppLocalizations.of(context).appTitle,
      message: message.body,
    );
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
