import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';

/// Resultado de referencia: 220 puntos, moderado.
///
/// Coincide con la linea base que siembra el `DemoPatientSeeder` del backend.
const IbsSssResult demoBaselineResult = IbsSssResult(
  assessmentId: 'dddddddd-0000-4000-8000-000000000001',
  totalScore: 220,
  severity: IbsSssSeverity.moderate,
  triggeredOnboardingCompletion: true,
);

/// Cinco respuestas completas, con valores distintos entre si.
IbsSssAnswers completeAnswers() {
  return const IbsSssAnswers()
      .withAnswer(IbsSssDimension.painSeverity, 60)
      .withAnswer(IbsSssDimension.painFrequency, 40)
      .withAnswer(IbsSssDimension.bloatingSeverity, 55)
      .withAnswer(IbsSssDimension.bowelHabitsDissatisfaction, 35)
      .withAnswer(IbsSssDimension.lifeInterference, 30);
}

/// [IbsSssRepository] controlable para tests de los notifiers.
class FakeIbsSssRepository implements IbsSssRepository {
  FakeIbsSssRepository({
    this.result = demoBaselineResult,
    this.error,
    this.delay = Duration.zero,
  });

  IbsSssResult result;
  CauceApiError? error;
  Duration delay;

  /// Evaluacion mas reciente que devuelve [latestAssessment].
  IbsSssAssessmentSummaryData? latest;

  /// Serie que devuelve [evolution].
  List<IbsSssEvolutionPoint> evolutionPoints = <IbsSssEvolutionPoint>[];

  /// Respuestas recibidas, para verificar que no salga nada incompleto.
  final List<IbsSssAnswers> submitted = <IbsSssAnswers>[];

  /// Tipos con los que se llamo a [submit], para distinguir US04 de US12.
  final List<IbsSssAssessmentType> submittedTypes = <IbsSssAssessmentType>[];

  @override
  Future<IbsSssResult> submitBaseline(IbsSssAnswers answers) =>
      submit(answers, assessmentType: IbsSssAssessmentType.baseline);

  @override
  Future<IbsSssResult> submit(
    IbsSssAnswers answers, {
    required IbsSssAssessmentType assessmentType,
  }) async {
    if (delay != Duration.zero) {
      await Future<void>.delayed(delay);
    }
    final pending = error;
    if (pending != null) {
      throw pending;
    }
    submitted.add(answers);
    submittedTypes.add(assessmentType);
    return result;
  }

  @override
  Future<IbsSssAssessmentSummaryData?> latestAssessment() async {
    final pending = error;
    if (pending != null) {
      throw pending;
    }
    return latest;
  }

  @override
  Future<List<IbsSssEvolutionPoint>> evolution() async {
    final pending = error;
    if (pending != null) {
      throw pending;
    }
    return evolutionPoints;
  }
}
