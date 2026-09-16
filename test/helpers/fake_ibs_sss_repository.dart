import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_baseline.dart';

/// Resultado de referencia: 220 puntos, moderado.
///
/// Coincide con la linea base que siembra el `DemoPatientSeeder` del backend.
const IbsSssBaselineResult demoBaselineResult = IbsSssBaselineResult(
  assessmentId: 'dddddddd-0000-4000-8000-000000000001',
  totalScore: 220,
  severity: IbsSssSeverity.moderate,
  triggeredOnboardingCompletion: true,
);

/// Cinco respuestas completas, con valores distintos entre si.
IbsSssBaselineAnswers completeAnswers() {
  return const IbsSssBaselineAnswers()
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

  IbsSssBaselineResult result;
  CauceApiError? error;
  Duration delay;

  /// Respuestas recibidas, para verificar que no salga nada incompleto.
  final List<IbsSssBaselineAnswers> submitted = <IbsSssBaselineAnswers>[];

  @override
  Future<IbsSssBaselineResult> submitBaseline(
    IbsSssBaselineAnswers answers,
  ) async {
    if (delay != Duration.zero) {
      await Future<void>.delayed(delay);
    }
    final pending = error;
    if (pending != null) {
      throw pending;
    }
    submitted.add(answers);
    return result;
  }
}
