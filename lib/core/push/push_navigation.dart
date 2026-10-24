import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/session_notifier.dart';
import '../../features/auth/domain/session_state.dart';
import 'push_destination.dart';
import 'push_messaging.dart';

part 'push_navigation.g.dart';

/// Destino de un toque que todavia no se abrio.
///
/// Solo vive en memoria. `PushInbox` lo consume cuando el shell ya esta a la
/// vista, y se descarta si la sesion termina sin iniciarse.
@Riverpod(keepAlive: true)
class PendingPushDestination extends _$PendingPushDestination {
  @override
  PushDestination? build() => null;

  void offer(PushDestination destination) => state = destination;

  /// Devuelve el destino y lo vacia, para abrirlo una sola vez.
  PushDestination? take() {
    final destination = state;
    state = null;
    return destination;
  }

  void clear() => state = null;
}

/// Escucha los toques sobre un push: con la app cerrada y en segundo plano.
class PushTaps {
  PushTaps({
    required PushMessaging messaging,
    required void Function(PushMessage message) onTap,
  })  : _messaging = messaging,
        _onTap = onTap;

  final PushMessaging _messaging;
  final void Function(PushMessage message) _onTap;

  StreamSubscription<PushMessage>? _opened;

  void start() {
    if (!_messaging.isEnabled || _opened != null) {
      return;
    }
    _opened = _messaging.onMessageOpenedApp.listen(_onTap);
    unawaited(_readInitial());
  }

  Future<void> stop() async {
    await _opened?.cancel();
    _opened = null;
  }

  Future<void> _readInitial() async {
    try {
      final message = await _messaging.initialMessage();
      if (message != null) {
        _onTap(message);
      }
    } on Object {
      // Sin el push inicial la app abre en Inicio, como siempre.
    }
  }
}

bool _signedOut(SessionState session) =>
    session is SessionUnauthenticated ||
    session is SessionPendingEmailVerification;

/// Vive con la app: lo enciende `CauceApp` y se apaga con el contenedor.
///
/// Sin sesion iniciada el toque no se recuerda: el paciente va al login y
/// despues a Inicio.
@Riverpod(keepAlive: true)
PushTaps pushTaps(Ref ref) {
  final taps = PushTaps(
    messaging: ref.watch(pushMessagingProvider),
    onTap: (message) {
      if (_signedOut(ref.read(sessionNotifierProvider))) {
        return;
      }
      ref
          .read(pendingPushDestinationProvider.notifier)
          .offer(resolvePushDestination(message.data));
    },
  );
  ref.listen<SessionState>(sessionNotifierProvider, (_, next) {
    if (_signedOut(next)) {
      ref.read(pendingPushDestinationProvider.notifier).clear();
    }
  });
  taps.start();
  ref.onDispose(taps.stop);
  return taps;
}
