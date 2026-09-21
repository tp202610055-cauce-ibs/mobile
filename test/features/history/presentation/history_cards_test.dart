import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/history/presentation/widgets/history_cards.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/// Las reglas puras de la tarjeta del Diario.
///
/// Se prueban sueltas porque son decisiones con contenido clinico, no
/// detalles de dibujo: en que tramo entra una intensidad y cuando una
/// distancia entre comida y sintoma es creible.
void main() {
  late AppLocalizations l10n;

  setUpAll(() async {
    l10n = await AppLocalizations.delegate.load(const Locale('es'));
  });

  group('intensityTone · tercios de la escala (acta M40)', () {
    test('el tramo bajo va en gris, nunca en verde', () {
      // Verde felicitaria al paciente por un dia de poco dolor, que es un
      // juicio que la aplicacion no esta en condiciones de hacer.
      for (final valor in <int>[1, 10, 20, 33]) {
        expect(intensityTone(valor), CauceBadgeTone.neutral, reason: '$valor');
      }
    });

    test('el tramo medio va en ambar', () {
      for (final valor in <int>[34, 50, 60, 66]) {
        expect(intensityTone(valor), CauceBadgeTone.warning, reason: '$valor');
      }
    });

    test('el tramo alto va en rojo', () {
      for (final valor in <int>[67, 80, 100]) {
        expect(intensityTone(valor), CauceBadgeTone.danger, reason: '$valor');
      }
    });

    test('el 60 del design system cae en ambar', () {
      // Es el unico valor que el catalogo muestra, y fija el corte.
      expect(intensityTone(60), CauceBadgeTone.warning);
    });
  });

  group('isPlausibleDelay · que distancia se puede afirmar', () {
    test('dentro de la ventana de cuatro horas, si', () {
      expect(isPlausibleDelay(Duration.zero), isTrue);
      expect(isPlausibleDelay(const Duration(minutes: 20)), isTrue);
      expect(isPlausibleDelay(const Duration(hours: 4)), isTrue);
    });

    test('negativa, no', () {
      // El servidor ancla la ventana en `clientCreatedAt`, de modo que un
      // sintoma de ayer registrado hoy puede quedar asociado con una comida
      // posterior. Afirmar "3 h despues" seria mentir sobre un dato clinico.
      expect(isPlausibleDelay(const Duration(hours: -3)), isFalse);
      expect(isPlausibleDelay(const Duration(minutes: -1)), isFalse);
    });

    test('mas alla de la ventana, tampoco', () {
      expect(isPlausibleDelay(const Duration(hours: 4, minutes: 1)), isFalse);
      expect(isPlausibleDelay(const Duration(hours: 9)), isFalse);
    });
  });

  group('formatDelay', () {
    test('por debajo de la hora solo muestra minutos', () {
      expect(formatDelay(l10n, const Duration(minutes: 45)), '45 min');
    });

    test('por encima muestra horas y minutos', () {
      expect(
        formatDelay(l10n, const Duration(hours: 1, minutes: 30)),
        '1 h 30 min',
      );
    });

    test('una hora exacta no arrastra minutos sueltos', () {
      expect(formatDelay(l10n, const Duration(hours: 2)), '2 h 0 min');
    });
  });
}
