import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/ibs_sss_baseline.dart';

part 'ibs_sss_repository.g.dart';

/// Acceso a las evaluaciones IBS-SSS del paciente autenticado.
///
/// Feature propia y separada de `patients` porque el endpoint pertenece al
/// modulo ClinicalRegistry del backend y no al de Patients, con el mismo
/// criterio de espejado que fijo el acta M29. Ademas es donde aterriza US12,
/// el cuestionario periodico, que no tiene nada que ver con el perfil.
///
/// Misma frontera que los otros repositorios: hacia adentro habla
/// `built_value` y `DioException`; hacia afuera solo tipos del dominio y
/// [CauceApiError].
class IbsSssRepository {
  const IbsSssRepository(this._api);

  final IbsSssApi _api;

  /// US04 CA01. `POST /api/v1/ibs-sss` con `assessmentType: Baseline`.
  ///
  /// El cliente envia **solo** las cinco dimensiones. El puntaje total y la
  /// categoria de severidad los calcula el servidor, que es lo que pide el CA
  /// y lo que evita que el instrumento clinico quede duplicado y a la deriva
  /// en dos lugares.
  ///
  /// El `cycleNumber` tampoco viaja: el backend lo fija en cero para la linea
  /// base y lo rechaza distinto.
  ///
  /// Lanza [StateError] si las respuestas estan incompletas. Es un error de
  /// programacion, no del paciente: la pantalla ya bloquea el envio hasta que
  /// las cinco esten respondidas, y dejar que un cuestionario a medias llegue
  /// al servidor consumiria la unica linea base que el paciente puede
  /// registrar.
  ///
  /// El metodo es `async` a proposito, aunque la guarda podria evaluarse antes
  /// de devolver el Future. Asi el [StateError] viaja **dentro** del Future,
  /// igual que los [CauceApiError]: un metodo que a veces falla de forma
  /// sincronica y a veces asincronica obliga a quien llama a envolverlo en un
  /// try y ademas encadenar un catchError.
  Future<IbsSssBaselineResult> submitBaseline(
    IbsSssBaselineAnswers answers,
  ) async {
    if (!answers.isComplete) {
      throw StateError(
        'La linea base exige las cinco dimensiones. Faltan: '
        '${answers.missing.map((d) => d.name).join(", ")}.',
      );
    }

    return _guard(() async {
      final response = await _api.apiV1IbsSssPost(
        createIbsSssAssessmentRequest: CreateIbsSssAssessmentRequest(
          (b) => b
            ..assessmentType = AssessmentType.baseline
            ..painSeverity = answers.valueFor(IbsSssDimension.painSeverity)
            ..painFrequency = answers.valueFor(IbsSssDimension.painFrequency)
            ..bloatingSeverity =
                answers.valueFor(IbsSssDimension.bloatingSeverity)
            ..bowelHabitsDissatisfaction =
                answers.valueFor(IbsSssDimension.bowelHabitsDissatisfaction)
            ..lifeInterference =
                answers.valueFor(IbsSssDimension.lifeInterference),
        ),
      );

      final result = response.data;
      final assessmentId = result?.assessmentId;
      final totalScore = result?.totalScore;

      if (assessmentId == null || totalScore == null) {
        throw const FormatException(
          'La evaluacion respondio sin assessmentId o sin totalScore.',
        );
      }

      return IbsSssBaselineResult(
        assessmentId: assessmentId,
        totalScore: totalScore,
        severity: IbsSssSeverity.fromApi(result?.severityCategory),
        nextAssessmentDate: result?.nextAssessmentDate?.toDateTime(),
        // Si el campo faltara, se asume que no cerro el onboarding: el estado
        // real se relee del perfil de todos modos, y suponer que si cerro
        // dejaria al paciente sin el paso que le falta.
        triggeredOnboardingCompletion:
            result?.triggeredOnboardingCompletion ?? false,
      );
    });
  }

  /// Ejecuta la llamada traduciendo cualquier falla al dominio.
  ///
  /// Delega en [guardApiCall]. Ser el tercer repositorio es justamente lo que
  /// disparo la promocion del helper a `core/` que pedia el acta M29.
  Future<T> _guard<T>(Future<T> Function() call) =>
      guardApiCall(call, malformedResponseStatus: 201);
}

@Riverpod(keepAlive: true)
IbsSssRepository ibsSssRepository(Ref ref) {
  return IbsSssRepository(ref.watch(ibsSssApiProvider));
}
