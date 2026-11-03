import 'package:cauce_mobile/core/auth/inactivity_monitor.dart';
import 'package:flutter_test/flutter_test.dart';

/// Reloj que el test adelanta a mano.
class _Clock {
  DateTime now = DateTime.utc(2026, 10, 27, 9);

  void advance(Duration by) => now = now.add(by);
}

void main() {
  late _Clock clock;
  late int timeouts;
  late InactivityMonitor monitor;

  setUp(() {
    clock = _Clock();
    timeouts = 0;
    monitor = InactivityMonitor(
      clock: () => clock.now,
      onTimeout: () => timeouts++,
    );
  });

  group('InactivityMonitor (CP021)', () {
    test('a los 9 minutos un toque no cierra y reinicia el conteo', () {
      monitor.start();

      clock.advance(const Duration(minutes: 9));
      expect(monitor.registerActivity(), isFalse);

      // Otros 9 minutos desde ese toque: tampoco cierra.
      clock.advance(const Duration(minutes: 9));
      expect(monitor.registerActivity(), isFalse);
      expect(timeouts, 0);
    });

    test('pasados 10 minutos el primer toque cierra, una sola vez', () {
      monitor.start();

      clock.advance(const Duration(minutes: 10));
      expect(monitor.registerActivity(), isTrue);
      expect(timeouts, 1);
      expect(monitor.isActive, isFalse);

      clock.advance(const Duration(minutes: 1));
      expect(monitor.registerActivity(), isFalse);
      expect(timeouts, 1);
    });

    test('al volver de segundo plano compara sin contar como actividad', () {
      monitor.start();

      clock.advance(const Duration(minutes: 6));
      expect(monitor.checkOnResume(), isFalse);

      // La vuelta no reinicia: a los 10 desde el ultimo toque, cierra.
      clock.advance(const Duration(minutes: 4));
      expect(monitor.checkOnResume(), isTrue);
      expect(timeouts, 1);
    });

    test('apagado no cuenta nada', () {
      clock.advance(const Duration(hours: 1));
      expect(monitor.registerActivity(), isFalse);
      expect(monitor.checkOnResume(), isFalse);

      monitor
        ..start()
        ..stop();
      clock.advance(const Duration(hours: 1));
      expect(monitor.registerActivity(), isFalse);
      expect(timeouts, 0);
    });

    test('volver a encenderlo arranca el conteo desde ese momento', () {
      monitor.start();
      clock.advance(const Duration(minutes: 30));
      monitor
        ..stop()
        ..start();

      clock.advance(const Duration(minutes: 9));
      expect(monitor.registerActivity(), isFalse);
    });
  });
}
