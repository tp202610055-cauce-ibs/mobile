import 'dart:async';

import 'package:cauce_mobile/core/utils/single_flight.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SingleFlight · una corrida a la vez', () {
    test('sin corrida en curso, corre de inmediato', () async {
      final flight = SingleFlight();
      var runs = 0;

      await flight.run(() async => runs++);

      expect(runs, 1);
      expect(flight.isRunning, isFalse);
    });

    test('los pedidos durante una corrida se hacen una sola vez al terminar',
        () async {
      final flight = SingleFlight();
      final gate = Completer<void>();
      var runs = 0;
      Future<void> task() async {
        runs++;
        if (runs == 1) {
          await gate.future;
        }
      }

      final first = flight.run(task);
      final second = flight.run(task);
      final third = flight.run(task);
      expect(runs, 1);

      gate.complete();
      await Future.wait(<Future<void>>[first, second, third]);

      expect(runs, 2);
      expect(flight.isRunning, isFalse);
    });

    test('un error no deja trabada la siguiente corrida', () async {
      final flight = SingleFlight();

      await expectLater(
        flight.run(() async => throw StateError('falla')),
        throwsStateError,
      );
      var runs = 0;
      await flight.run(() async => runs++);

      expect(runs, 1);
    });
  });
}
