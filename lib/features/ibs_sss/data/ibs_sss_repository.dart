import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/ibs_sss_assessment.dart';

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
  /// Atajo de [submit] para la linea base, que conserva la firma con la que lo
  /// llama el wizard de onboarding.
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
  Future<IbsSssResult> submitBaseline(IbsSssAnswers answers) =>
      submit(answers, assessmentType: IbsSssAssessmentType.baseline);

  /// US04 y US12. `POST /api/v1/ibs-sss`.
  ///
  /// El mismo endpoint atiende la linea base y las evaluaciones periodicas: lo
  /// unico que cambia es [assessmentType]. El `cycleNumber` **no** viaja: el
  /// backend lo fija en cero para la linea base y lo resuelve con
  /// `GetNextCycleNumberAsync` para las periodicas.
  ///
  /// El cliente envia **solo** las cinco dimensiones. El puntaje total y la
  /// categoria de severidad los calcula el servidor. Esa es, ademas, la razon
  /// estructural por la que US12 CA04 no necesita logica nueva: el puntaje no
  /// existe del lado del cliente hasta que el servidor lo devuelve, asi que no
  /// hay forma de exponerlo antes del envio.
  Future<IbsSssResult> submit(
    IbsSssAnswers answers, {
    required IbsSssAssessmentType assessmentType,
  }) async {
    if (!answers.isComplete) {
      throw StateError(
        'La evaluacion exige las cinco dimensiones. Faltan: '
        '${answers.missing.map((d) => d.name).join(", ")}.',
      );
    }

    return _guard(() async {
      final response = await _api.apiV1IbsSssPost(
        createIbsSssAssessmentRequest: CreateIbsSssAssessmentRequest(
          (b) => b
            ..assessmentType = assessmentType.toApi()
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

      return IbsSssResult(
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

  /// US12. `GET /api/v1/ibs-sss/latest`.
  ///
  /// Devuelve la evaluacion mas reciente, o `null` si el paciente todavia no
  /// tiene ninguna. Alimenta el aviso de la home: su `nextAssessmentDate` dice
  /// cuando vence el ciclo de catorce dias.
  Future<IbsSssAssessmentSummaryData?> latestAssessment() {
    return _guard(() async {
      final response = await _api.apiV1IbsSssLatestGet();
      final result = response.data;

      final assessmentId = result?.assessmentId;
      final totalScore = result?.totalScore;
      if (result == null || assessmentId == null || totalScore == null) {
        // El contrato declara el 200 como nullable: sin evaluaciones el cuerpo
        // viene vacio, que no es una respuesta malformada.
        return null;
      }

      return IbsSssAssessmentSummaryData(
        assessmentId: assessmentId,
        totalScore: totalScore,
        assessmentType: IbsSssAssessmentType.fromApi(result.assessmentType) ??
            IbsSssAssessmentType.periodic,
        cycleNumber: result.cycleNumber ?? 0,
        severity: IbsSssSeverity.fromApi(result.severityCategory),
        completedAt: result.completedAt,
        nextAssessmentDate: result.nextAssessmentDate?.toDateTime(),
      );
    });
  }

  /// US12 CA03. `GET /api/v1/ibs-sss/evolution`.
  ///
  /// Serie completa de evaluaciones con su diferencia respecto de la linea
  /// base. Una entrada sin puntaje se descarta en vez de tumbar el grafico.
  Future<List<IbsSssEvolutionPoint>> evolution() {
    return _guard(() async {
      final response = await _api.apiV1IbsSssEvolutionGet();

      return response.data
              ?.map((entry) {
                final assessment = entry.assessment;
                final assessmentId = assessment?.assessmentId;
                final totalScore = assessment?.totalScore;
                if (assessment == null ||
                    assessmentId == null ||
                    totalScore == null) {
                  return null;
                }

                return IbsSssEvolutionPoint(
                  assessmentId: assessmentId,
                  totalScore: totalScore,
                  assessmentType:
                      IbsSssAssessmentType.fromApi(assessment.assessmentType) ??
                          IbsSssAssessmentType.periodic,
                  cycleNumber: assessment.cycleNumber ?? 0,
                  severity: IbsSssSeverity.fromApi(assessment.severityCategory),
                  completedAt: assessment.completedAt,
                  deltaFromBaseline: entry.deltaFromBaseline,
                  // Mismo patron que `latestAssessment()`: el contrato lo
                  // declara como `Date` y el dominio trabaja con `DateTime`.
                  nextAssessmentDate:
                      assessment.nextAssessmentDate?.toDateTime(),
                );
              })
              .nonNulls
              .toList() ??
          const <IbsSssEvolutionPoint>[];
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
