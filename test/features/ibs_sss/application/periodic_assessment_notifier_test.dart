import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/ibs_sss/application/periodic_assessment_notifier.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_ibs_sss_repository.dart';

IbsSssEvolutionPoint _point(
  int score, {
  IbsSssAssessmentType type = IbsSssAssessmentType.periodic,
  int? delta,
  int cycle = 1,
}) {
  return IbsSssEvolutionPoint(
    assessmentId: 'a-$score-$cycle',
    totalScore: score,
    assessmentType: type,
    cycleNumber: cycle,
    deltaFromBaseline: delta,
  );
}

void main() {
  late FakeIbsSssRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = FakeIbsSssRepository();
    container = ProviderContainer(
      overrides: <Override>[
        ibsSssRepositoryProvider.overrideWithValue(repository),
      ],
    );
  });

  tearDown(() => container.dispose());

  PeriodicAssessmentNotifier notifier() =>
      container.read(periodicAssessmentNotifierProvider.notifier);
  PeriodicAssessmentState state() =>
      container.read(periodicAssessmentNotifierProvider);

  void answerAll() {
    for (final dimension in IbsSssDimension.values) {
      notifier().answer(dimension, 40);
    }
  }

  group('PeriodicAssessmentNotifier · envio (CP030)', () {
    test('manda assessmentType Periodic, no Baseline', () async {
      // Es lo unico que distingue US12 de US04: el mismo endpoint, el mismo
      // instrumento, otro tipo.
      answerAll();

      expect(await notifier().submit(), isTrue);

      expect(repository.submittedTypes, <IbsSssAssessmentType>[
        IbsSssAssessmentType.periodic,
      ]);
    });

    test('no envia nada parcial', () async {
      notifier().answer(IbsSssDimension.painSeverity, 60);

      expect(await notifier().submit(), isFalse);
      expect(repository.submitted, isEmpty);
    });

    test('exige las cinco dimensiones', () {
      for (final dimension in IbsSssDimension.values.take(4)) {
        notifier().answer(dimension, 40);
      }

      expect(state().canSubmit, isFalse);
      expect(state().missing, hasLength(1));
    });

    test('un error del servidor conserva las respuestas', () async {
      answerAll();
      repository.error = const CauceApiError.rateLimited(retryAfterSeconds: 30);

      expect(await notifier().submit(), isFalse);

      expect(state().error, isA<RateLimitedError>());
      expect(state().answers.isComplete, isTrue);
      expect(state().result, isNull);
    });

    test('responder de nuevo limpia el error', () async {
      answerAll();
      repository.error = const CauceApiError.forbidden();
      await notifier().submit();

      notifier().answer(IbsSssDimension.painSeverity, 70);

      expect(state().error, isNull);
    });
  });

  group('PeriodicAssessmentNotifier · CA04, el puntaje no existe antes (CP033)',
      () {
    test('sin enviar no hay resultado ni puntaje', () {
      answerAll();

      // No es una regla de pantalla que haya que respetar: el numero no existe
      // de este lado hasta que el servidor lo devuelve.
      expect(state().result, isNull);
      expect(state().canSubmit, isTrue);
    });

    test('el puntaje aparece recien con la respuesta del servidor', () async {
      answerAll();

      await notifier().submit();

      expect(state().result, isNotNull);
      expect(state().result!.totalScore, 220);
      expect(state().result!.severity, IbsSssSeverity.moderate);
    });

    test('el cliente no calcula el total con lo respondido', () async {
      // Las cinco respuestas suman 200, y el servidor devuelve 220: el valor
      // que se muestra es el del servidor, no una suma local.
      answerAll();

      await notifier().submit();

      expect(state().result!.totalScore, isNot(200));
      expect(state().result!.totalScore, 220);
    });
  });

  group('PeriodicAssessmentNotifier · evolucion (CA03, CP032)', () {
    test('trae la serie del servidor', () async {
      repository.evolutionPoints = <IbsSssEvolutionPoint>[
        _point(220, type: IbsSssAssessmentType.baseline, cycle: 0),
        _point(160, delta: -60),
      ];

      await notifier().loadEvolution();

      expect(state().evolution, hasLength(2));
      expect(state().latestPoint?.totalScore, 160);
    });

    test('un delta negativo de 50 o mas es mejoria significativa', () async {
      // El backend calcula `TotalScore - baseline.TotalScore`, con su test
      // `CompareTotalScoreTo_Improvement_ReturnsNegative`: negativo es mejoria.
      repository.evolutionPoints = <IbsSssEvolutionPoint>[
        _point(220, type: IbsSssAssessmentType.baseline, cycle: 0),
        _point(170, delta: -50),
      ];

      await notifier().loadEvolution();

      expect(state().showsSignificantImprovement, isTrue);
    });

    test('49 puntos de reduccion todavia no alcanzan el MCID', () async {
      repository.evolutionPoints = <IbsSssEvolutionPoint>[
        _point(220, type: IbsSssAssessmentType.baseline, cycle: 0),
        _point(171, delta: -49),
      ];

      await notifier().loadEvolution();

      expect(state().showsSignificantImprovement, isFalse);
    });

    test('un empeoramiento de 50 puntos no es mejoria', () async {
      // El signo importa: `>= 50` habria dado true aca, que es exactamente el
      // error que la Fase 0 fue a descartar contra el backend.
      repository.evolutionPoints = <IbsSssEvolutionPoint>[
        _point(220, type: IbsSssAssessmentType.baseline, cycle: 0),
        _point(270, delta: 50),
      ];

      await notifier().loadEvolution();

      expect(state().showsSignificantImprovement, isFalse);
    });

    test('la linea base no tiene delta y no cuenta como mejoria', () async {
      repository.evolutionPoints = <IbsSssEvolutionPoint>[
        _point(220, type: IbsSssAssessmentType.baseline, cycle: 0),
      ];

      await notifier().loadEvolution();

      expect(state().latestPoint?.deltaFromBaseline, isNull);
      expect(state().showsSignificantImprovement, isFalse);
    });

    test('un fallo deja el grafico vacio sin bloquear el cuestionario',
        () async {
      repository.error = const CauceApiError.network();

      await notifier().loadEvolution();

      expect(state().evolution, isEmpty);
      expect(state().error, isNull);
    });

    test('tras enviar, la serie se relee para incluir lo recien respondido',
        () async {
      answerAll();
      repository.evolutionPoints = <IbsSssEvolutionPoint>[
        _point(220, type: IbsSssAssessmentType.baseline, cycle: 0),
        _point(160, delta: -60),
      ];

      await notifier().submit();

      expect(state().evolution, hasLength(2));
    });
  });

  group('IbsSssAssessmentSummaryData · vencimiento del ciclo (CA01)', () {
    const summary = IbsSssAssessmentSummaryData(
      assessmentId: 'a1',
      totalScore: 220,
      assessmentType: IbsSssAssessmentType.baseline,
    );

    test('con la fecha vencida corresponde responder', () {
      final vencida = summary.copyWith(
        nextAssessmentDate: DateTime.utc(2026, 9, 18),
      );

      expect(vencida.isDue(now: DateTime.utc(2026, 9, 19)), isTrue);
    });

    test('el mismo dia del vencimiento ya cuenta', () {
      final hoy = summary.copyWith(
        nextAssessmentDate: DateTime.utc(2026, 9, 18),
      );

      expect(hoy.isDue(now: DateTime.utc(2026, 9, 18)), isTrue);
    });

    test('antes del vencimiento no', () {
      final futura = summary.copyWith(
        nextAssessmentDate: DateTime.utc(2026, 10, 2),
      );

      expect(futura.isDue(now: DateTime.utc(2026, 9, 19)), isFalse);
    });

    test('sin fecha no se afirma que venza nada', () {
      // Un aviso que aparece por las dudas mandaria al paciente a responder un
      // cuestionario que quiza no le toca, y el ciclo es irrepetible.
      expect(summary.isDue(now: DateTime.utc(2026, 9, 19)), isFalse);
    });
  });
}
