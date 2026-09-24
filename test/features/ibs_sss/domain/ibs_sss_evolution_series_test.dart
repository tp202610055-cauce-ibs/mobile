import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_evolution_series.dart';
import 'package:flutter_test/flutter_test.dart';

/// Un punto de la serie, con lo minimo para las reglas que se prueban aca.
IbsSssEvolutionPoint _point({
  required int totalScore,
  required int cycleNumber,
  DateTime? completedAt,
  int? deltaFromBaseline,
  IbsSssAssessmentType type = IbsSssAssessmentType.periodic,
  DateTime? nextAssessmentDate,
}) {
  return IbsSssEvolutionPoint(
    assessmentId: 'assessment-$cycleNumber',
    totalScore: totalScore,
    assessmentType: type,
    cycleNumber: cycleNumber,
    completedAt: completedAt,
    deltaFromBaseline: deltaFromBaseline,
    nextAssessmentDate: nextAssessmentDate,
  );
}

void main() {
  group('IbsSssEvolutionSeries · orden cronologico', () {
    test('ordena por completedAt y no por el orden en que llego', () {
      // El backend ordena por CycleNumber. Si alguna vez las fechas y los
      // ciclos dejan de coincidir, el eje temporal tiene que seguir la fecha.
      final series = IbsSssEvolutionSeries.from(<IbsSssEvolutionPoint>[
        _point(
          totalScore: 130,
          cycleNumber: 2,
          completedAt: DateTime.utc(2026, 9, 20),
        ),
        _point(
          totalScore: 220,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
        ),
        _point(
          totalScore: 180,
          cycleNumber: 1,
          completedAt: DateTime.utc(2026, 9, 5),
        ),
      ]);

      expect(
        series.points.map((p) => p.totalScore).toList(),
        <int>[220, 180, 130],
      );
    });

    test('un punto sin fecha va al final en vez de descartarse', () {
      final series = IbsSssEvolutionSeries.from(<IbsSssEvolutionPoint>[
        _point(totalScore: 200, cycleNumber: 1),
        _point(
          totalScore: 220,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
        ),
      ]);

      expect(series.points.length, 2);
      expect(series.points.last.completedAt, isNull);
    });
  });

  group('IbsSssEvolutionSeries · cambio porcentual', () {
    test('una mejoria conserva el signo negativo', () {
      // 220 de linea base y 130 de ultimo puntaje: -90 puntos, -40,9 %.
      // Si alguien invirtiera el signo para que "mejorar sea positivo", este
      // test lo ve, igual que el de cumulativeChange en Perfil.
      final series = IbsSssEvolutionSeries.from(<IbsSssEvolutionPoint>[
        _point(
          totalScore: 220,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
        ),
        _point(
          totalScore: 130,
          cycleNumber: 1,
          completedAt: DateTime.utc(2026, 9, 20),
          deltaFromBaseline: -90,
        ),
      ]);

      expect(series.percentChangeFromBaseline, closeTo(-40.909, 0.001));
    });

    test('un empeoramiento da positivo', () {
      final series = IbsSssEvolutionSeries.from(<IbsSssEvolutionPoint>[
        _point(
          totalScore: 200,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
        ),
        _point(
          totalScore: 250,
          cycleNumber: 1,
          completedAt: DateTime.utc(2026, 9, 20),
          deltaFromBaseline: 50,
        ),
      ]);

      expect(series.percentChangeFromBaseline, closeTo(25, 0.001));
    });

    test('no cambia al filtrar el rango', () {
      // Decision 3.1: el porcentaje va siempre contra la linea base real,
      // aunque la linea base quede fuera de la ventana que se muestra.
      final now = DateTime.utc(2026, 9, 25);
      final series = IbsSssEvolutionSeries.from(<IbsSssEvolutionPoint>[
        _point(
          totalScore: 220,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 5, 10),
          type: IbsSssAssessmentType.baseline,
        ),
        _point(
          totalScore: 130,
          cycleNumber: 1,
          completedAt: DateTime.utc(2026, 9, 20),
          deltaFromBaseline: -90,
        ),
      ]);

      final visible = series.within(IbsSssEvolutionRange.lastMonth, now: now);

      expect(visible.length, 1, reason: 'la linea base quedo fuera');
      expect(series.percentChangeFromBaseline, closeTo(-40.909, 0.001));
    });

    test('sin linea base no inventa un porcentaje', () {
      final series = IbsSssEvolutionSeries.from(<IbsSssEvolutionPoint>[
        _point(
          totalScore: 180,
          cycleNumber: 1,
          completedAt: DateTime.utc(2026, 9, 5),
        ),
      ]);

      expect(series.percentChangeFromBaseline, isNull);
    });

    test('una linea base en cero no divide por cero', () {
      final series = IbsSssEvolutionSeries.from(<IbsSssEvolutionPoint>[
        _point(
          totalScore: 0,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
        ),
        _point(
          totalScore: 40,
          cycleNumber: 1,
          completedAt: DateTime.utc(2026, 9, 20),
          deltaFromBaseline: 40,
        ),
      ]);

      expect(series.percentChangeFromBaseline, isNull);
    });
  });

  group('IbsSssEvolutionSeries · filtro de rango', () {
    final now = DateTime.utc(2026, 9, 25);
    final series = IbsSssEvolutionSeries.from(<IbsSssEvolutionPoint>[
      _point(
        totalScore: 220,
        cycleNumber: 0,
        completedAt: DateTime.utc(2026, 3, 1),
        type: IbsSssAssessmentType.baseline,
      ),
      _point(
        totalScore: 200,
        cycleNumber: 1,
        completedAt: DateTime.utc(2026, 7, 20),
      ),
      _point(
        totalScore: 130,
        cycleNumber: 2,
        completedAt: DateTime.utc(2026, 9, 20),
      ),
    ]);

    test('"Todo" devuelve la serie entera', () {
      expect(series.within(IbsSssEvolutionRange.all, now: now).length, 3);
    });

    test('"Ultimos 3 meses" recorta lo anterior', () {
      final visible = series.within(IbsSssEvolutionRange.lastQuarter, now: now);

      expect(visible.map((p) => p.totalScore).toList(), <int>[200, 130]);
    });

    test('"Ultimo mes" deja solo lo reciente', () {
      final visible = series.within(IbsSssEvolutionRange.lastMonth, now: now);

      expect(visible.map((p) => p.totalScore).toList(), <int>[130]);
    });
  });

  group('IbsSssEvolutionSeries · proxima evaluacion', () {
    test('sale de la evaluacion mas reciente', () {
      final series = IbsSssEvolutionSeries.from(<IbsSssEvolutionPoint>[
        _point(
          totalScore: 220,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
          nextAssessmentDate: DateTime.utc(2026, 8, 24),
        ),
        _point(
          totalScore: 130,
          cycleNumber: 1,
          completedAt: DateTime.utc(2026, 9, 20),
          deltaFromBaseline: -90,
          nextAssessmentDate: DateTime.utc(2026, 10, 4),
        ),
      ]);

      expect(series.nextAssessmentDate, DateTime.utc(2026, 10, 4));
    });

    test('con solo la linea base tambien hay fecha', () {
      // Es el caso de CP061: el backend agenda a catorce dias tambien al
      // responder la linea base.
      final series = IbsSssEvolutionSeries.from(<IbsSssEvolutionPoint>[
        _point(
          totalScore: 220,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
          nextAssessmentDate: DateTime.utc(2026, 8, 24),
        ),
      ]);

      expect(series.hasTimeline, isFalse);
      expect(series.nextAssessmentDate, DateTime.utc(2026, 8, 24));
    });
  });
}
