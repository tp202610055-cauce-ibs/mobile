import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/widgets/ibs_sss_evolution_chart.dart';
import 'package:flutter_test/flutter_test.dart';

IbsSssEvolutionPoint _at(DateTime? completedAt, {int score = 130}) {
  return IbsSssEvolutionPoint(
    assessmentId: 'assessment-${completedAt?.toIso8601String()}',
    totalScore: score,
    assessmentType: IbsSssAssessmentType.periodic,
    completedAt: completedAt,
  );
}

/// Eje de tiempo real del grafico de Evolucion (HU0023, acta M49).
///
/// Las fechas se arman en hora local: el eje cuenta dias calendario del
/// telefono, que es lo que ve el paciente.
void main() {
  group('IbsSssTimeAxis · posicion de cada evaluacion', () {
    test('la distancia es el tiempo transcurrido, no el orden', () {
      final axis = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 8, 31, 16, 44), score: 220),
        _at(DateTime(2026, 9, 10, 9)),
        _at(DateTime(2026, 9, 18, 13, 42)),
      ]);

      // Por orden serian 0, 1 y 2: el segundo tramo, de 8 dias, se veria
      // igual de largo que el primero, de 10.
      final days = <int>[axis.dayOf(0), axis.dayOf(1), axis.dayOf(2)];
      expect(days, <int>[0, 10, 18]);
    });

    test(
        'dos evaluaciones con 18 minutos de diferencia van en la misma '
        'vertical', () {
      // Es el caso del paciente demo que encontro el recorrido: por orden,
      // ocupaban media grafica como una meseta de semanas.
      final axis = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 8, 31, 16, 44), score: 220),
        _at(DateTime(2026, 9, 18, 13, 42)),
        _at(DateTime(2026, 9, 18, 14)),
      ]);

      expect(axis.dayOf(1), 18);
      expect(axis.dayOf(2), 18);
    });

    test('cuenta dias calendario, no bloques de 24 horas', () {
      final acrossMidnight = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 9, 17, 23, 30)),
        _at(DateTime(2026, 9, 18, 0, 30)),
      ]);
      final sameDay = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 9, 17, 0, 10)),
        _at(DateTime(2026, 9, 17, 23, 50)),
      ]);

      // Una hora de diferencia, pero en dos dias distintos.
      expect(acrossMidnight.dayOf(1), 1);
      // Casi 24 horas, pero el mismo dia.
      expect(sameDay.dayOf(1), 0);
    });

    test('un instante en UTC se ubica en su dia local', () {
      final instant = DateTime.utc(2026, 9, 18, 2, 10);
      final axis = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(instant),
        _at(instant.add(const Duration(days: 3))),
      ]);
      final local = instant.toLocal();

      expect(axis.dayOf(1), 3);
      expect(
        axis.dateAt(0),
        DateTime.utc(local.year, local.month, local.day),
      );
    });

    test('un punto sin fecha queda afuera: no hay donde ubicarlo', () {
      final axis = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 8, 31), score: 220),
        _at(null),
      ]);

      expect(axis.points, hasLength(1));
      expect(axis.points.single.totalScore, 220);
    });

    test('sin ningun punto con fecha, el eje queda vacio', () {
      expect(IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[]).isEmpty, isTrue);
      expect(
        IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[_at(null)]).isEmpty,
        isTrue,
      );
    });
  });

  group('IbsSssTimeAxis · extremos del eje', () {
    test('una sola evaluacion igual tiene un eje con ancho', () {
      final axis = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 9, 18)),
      ]);

      expect(axis.minX, lessThan(0));
      expect(axis.maxX, greaterThan(0));
    });

    test('todas el mismo dia tambien', () {
      final axis = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 9, 18, 9)),
        _at(DateTime(2026, 9, 18, 10)),
      ]);

      expect(axis.maxX - axis.minX, greaterThan(0));
    });

    test('el margen es de un dia, y crece con periodos largos', () {
      final short = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 8, 31)),
        _at(DateTime(2026, 9, 18)),
      ]);
      final long = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 1, 1)),
        _at(DateTime(2026, 4, 11)),
      ]);

      expect(<double>[short.minX, short.maxX], <double>[-1, 19]);
      // 100 dias: un 5 % a cada lado.
      expect(<double>[long.minX, long.maxX], <double>[-5, 105]);
    });

    test('dateAt devuelve el dia calendario de cada posicion', () {
      final axis = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 8, 31, 16, 44)),
        _at(DateTime(2026, 9, 18, 13, 42)),
      ]);

      expect(axis.dateAt(18), DateTime.utc(2026, 9, 18));
    });
  });

  group('IbsSssTimeAxis · fechas que llevan etiqueta', () {
    final threeDates = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
      _at(DateTime(2026, 8, 31), score: 220),
      _at(DateTime(2026, 9, 1)),
      _at(DateTime(2026, 9, 18)),
    ]);

    test('con lugar, cada dia con evaluacion lleva su fecha', () {
      expect(threeDates.labeledDays(plotWidth: 2000), <int>{0, 1, 18});
    });

    test('dos fechas demasiado juntas: se conserva la mas reciente', () {
      // 200 px sobre 20 dias son 10 px por dia: el 31/08 y el 01/09 quedan a
      // 10 px y no entran los dos.
      expect(threeDates.labeledDays(plotWidth: 200), <int>{1, 18});
    });

    test('la ultima evaluacion siempre lleva fecha', () {
      expect(threeDates.labeledDays(plotWidth: 10), contains(18));
    });

    test('dos evaluaciones del mismo dia llevan una sola fecha', () {
      final axis = IbsSssTimeAxis.of(<IbsSssEvolutionPoint>[
        _at(DateTime(2026, 8, 31), score: 220),
        _at(DateTime(2026, 9, 18, 13, 42)),
        _at(DateTime(2026, 9, 18, 14)),
      ]);

      expect(axis.labeledDays(plotWidth: 2000), <int>{0, 18});
    });

    test('sin ancho no hay etiquetas', () {
      expect(threeDates.labeledDays(plotWidth: 0), isEmpty);
    });
  });
}
