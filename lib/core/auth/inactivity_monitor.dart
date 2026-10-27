import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/session_notifier.dart';
import '../../features/auth/domain/session_state.dart';

part 'inactivity_monitor.g.dart';

/// Cierra la sesion tras [limit] sin que el paciente toque la pantalla
/// (HU0008, CP021).
///
/// Sin temporizador: compara marcas de tiempo en cada toque y al volver de
/// segundo plano. Solo cuentan los toques; la red, incluida la renovacion del
/// token, nunca reinicia el conteo ni lo detiene.
class InactivityMonitor {
  InactivityMonitor({
    required DateTime Function() clock,
    required VoidCallback onTimeout,
    this.limit = const Duration(minutes: 10),
  })  : _clock = clock,
        _onTimeout = onTimeout;

  final DateTime Function() _clock;
  final VoidCallback _onTimeout;
  final Duration limit;

  DateTime? _lastActivity;

  bool get isActive => _lastActivity != null;

  /// Empieza a contar desde ahora.
  void start() => _lastActivity = _clock();

  void stop() => _lastActivity = null;

  /// Un toque. Si llego pasado el limite cierra y devuelve `true`; si no,
  /// reinicia el conteo.
  bool registerActivity() {
    if (_closeIfExpired()) {
      return true;
    }
    if (isActive) {
      _lastActivity = _clock();
    }
    return false;
  }

  /// Vuelta de segundo plano: compara, pero no cuenta como actividad.
  bool checkOnResume() => _closeIfExpired();

  bool _closeIfExpired() {
    final last = _lastActivity;
    if (last == null || _clock().isBefore(last.add(limit))) {
      return false;
    }
    stop();
    _onTimeout();
    return true;
  }
}

/// Reloj del monitor. Se sustituye en las pruebas.
@Riverpod(keepAlive: true)
DateTime Function() inactivityClock(Ref ref) => DateTime.now;

/// La ultima sesion termino por inactividad. Lo lee el login para avisarlo.
@Riverpod(keepAlive: true)
class InactivityNotice extends _$InactivityNotice {
  @override
  bool build() => false;

  void raise() => state = true;

  void clear() => state = false;
}

/// Se enciende con la sesion y se apaga al cerrarla. Lo lee
/// `InactivityListener`, que le pasa los toques desde la raiz.
@Riverpod(keepAlive: true)
InactivityMonitor sessionInactivityMonitor(Ref ref) {
  final monitor = InactivityMonitor(
    clock: ref.watch(inactivityClockProvider),
    onTimeout: () {
      ref.read(inactivityNoticeProvider.notifier).raise();
      unawaited(ref.read(sessionNotifierProvider.notifier).endForInactivity());
    },
  );

  ref.listen<SessionState>(
    sessionNotifierProvider,
    (_, session) {
      switch (session) {
        case SessionAuthenticated():
          if (!monitor.isActive) {
            monitor.start();
            ref.read(inactivityNoticeProvider.notifier).clear();
          }
        case SessionUnauthenticated() || SessionPendingEmailVerification():
          monitor.stop();
        case SessionUnknown():
          break;
      }
    },
    fireImmediately: true,
  );
  ref.onDispose(monitor.stop);
  return monitor;
}
