import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ibs_sss_assessment.freezed.dart';

/// Las cinco dimensiones del cuestionario IBS-SSS.
///
/// El orden de declaracion es el orden en que se presentan al paciente, y
/// coincide con el del instrumento original (Francis, Morris y Whorwell, 1997).
/// Las cinco se responden sobre los ultimos diez dias.
enum IbsSssDimension {
  painSeverity,
  painFrequency,
  bloatingSeverity,
  bowelHabitsDissatisfaction,
  lifeInterference,
}

/// Categoria de severidad que devuelve el backend.
///
/// Son **tres**, no cuatro: el enum `SeverityCategory` del contrato no incluye
/// una categoria de remision. El corte entre moderado y severo esta en 300
/// inclusive del lado moderado (`IbsSssScoring.Categorize`).
///
/// El cliente no clasifica: recibe la categoria ya resuelta junto al puntaje.
/// Duplicar los umbrales aca los dejaria desincronizados en cuanto el backend
/// los ajuste, y el instrumento es material clinico del estudio.
enum IbsSssSeverity {
  mild,
  moderate,
  severe;

  static IbsSssSeverity? fromApi(api.SeverityCategory? value) {
    return switch (value) {
      api.SeverityCategory.mild => IbsSssSeverity.mild,
      api.SeverityCategory.moderate => IbsSssSeverity.moderate,
      api.SeverityCategory.severe => IbsSssSeverity.severe,
      _ => null,
    };
  }
}

/// Limites del instrumento, transcritos de `IbsSssScoring` del backend.
abstract final class IbsSssScale {
  /// Valor minimo de cada dimension.
  static const int dimensionMin = 0;

  /// Valor maximo de cada dimension.
  static const int dimensionMax = 100;

  /// Puntaje total minimo posible: cinco dimensiones en cero.
  static const int totalMin = 0;

  /// Puntaje total maximo posible: cinco dimensiones en cien.
  static const int totalMax = 500;

  /// `true` si el valor cae dentro del rango admitido por el backend.
  static bool isValidDimension(int value) =>
      value >= dimensionMin && value <= dimensionMax;
}

/// Respuestas del cuestionario mientras el paciente lo completa.
///
/// Las cinco son obligatorias (US04 CA02) y hasta que lo esten no sale nada
/// del dispositivo: el backend no acepta evaluaciones parciales y enviar una a
/// medias consumiria la unica linea base que el paciente puede registrar.
@freezed
abstract class IbsSssAnswers with _$IbsSssAnswers {
  const factory IbsSssAnswers({
    @Default(<IbsSssDimension, int>{}) Map<IbsSssDimension, int> values,
  }) = _IbsSssAnswers;

  const IbsSssAnswers._();

  /// Respuesta de una dimension, o `null` si todavia no se respondio.
  int? valueFor(IbsSssDimension dimension) => values[dimension];

  /// `true` cuando las cinco dimensiones tienen respuesta.
  bool get isComplete => IbsSssDimension.values.every(values.containsKey);

  /// Dimensiones que siguen sin responder, en orden de presentacion.
  List<IbsSssDimension> get missing => IbsSssDimension.values
      .where((dimension) => !values.containsKey(dimension))
      .toList();

  /// Copia con una dimension respondida.
  ///
  /// Lanza [ArgumentError] si el valor cae fuera de 0 a 100. No se recorta en
  /// silencio: un valor fuera de rango solo puede venir de un error de
  /// programacion, porque el control de la UI ya esta acotado, y enmascararlo
  /// guardaria un dato clinico que el paciente no eligio.
  IbsSssAnswers withAnswer(IbsSssDimension dimension, int value) {
    if (!IbsSssScale.isValidDimension(value)) {
      throw ArgumentError.value(
        value,
        'value',
        'La dimension debe estar entre ${IbsSssScale.dimensionMin} y '
            '${IbsSssScale.dimensionMax}.',
      );
    }
    return copyWith(
      values: <IbsSssDimension, int>{...values, dimension: value},
    );
  }
}

/// Resultado que devuelve el backend al registrar la linea base.
@freezed
abstract class IbsSssResult with _$IbsSssResult {
  const factory IbsSssResult({
    required String assessmentId,

    /// Suma de las cinco dimensiones, de 0 a 500. La calcula el servidor.
    required int totalScore,

    /// `true` si esta evaluacion cerro el onboarding del paciente.
    required bool triggeredOnboardingCompletion,
    IbsSssSeverity? severity,

    /// Fecha de la proxima evaluacion periodica, a catorce dias. La agenda el
    /// backend y la consume US12, fuera del alcance de este bloque.
    DateTime? nextAssessmentDate,
  }) = _IbsSssResult;

  const IbsSssResult._();
}

/// Tipo de evaluacion, tal como lo declara el contrato.
///
/// El mismo endpoint atiende las dos: la linea base del onboarding (US04) y las
/// periodicas de cada catorce dias (US12).
enum IbsSssAssessmentType {
  baseline,
  periodic;

  api.AssessmentType toApi() => switch (this) {
        IbsSssAssessmentType.baseline => api.AssessmentType.baseline,
        IbsSssAssessmentType.periodic => api.AssessmentType.periodic,
      };

  static IbsSssAssessmentType? fromApi(api.AssessmentType? value) {
    return switch (value) {
      api.AssessmentType.baseline => IbsSssAssessmentType.baseline,
      api.AssessmentType.periodic => IbsSssAssessmentType.periodic,
      _ => null,
    };
  }
}

/// Una evaluacion ya registrada, tal como la devuelve el servidor.
@freezed
abstract class IbsSssAssessmentSummaryData with _$IbsSssAssessmentSummaryData {
  const factory IbsSssAssessmentSummaryData({
    required String assessmentId,
    required int totalScore,
    required IbsSssAssessmentType assessmentType,
    @Default(0) int cycleNumber,
    IbsSssSeverity? severity,
    DateTime? completedAt,

    /// Vencimiento del proximo ciclo, a catorce dias. Lo agenda el backend.
    DateTime? nextAssessmentDate,
  }) = _IbsSssAssessmentSummaryData;

  const IbsSssAssessmentSummaryData._();

  /// `true` si el ciclo ya vencio y corresponde responder de nuevo (CA01).
  ///
  /// Sin `nextAssessmentDate` no se puede afirmar que venza nada: el aviso no
  /// aparece en vez de aparecer por las dudas.
  bool isDue({DateTime? now}) {
    final due = nextAssessmentDate;
    if (due == null) {
      return false;
    }
    return !(now ?? DateTime.now()).toUtc().isBefore(due.toUtc());
  }
}

/// Un punto de la serie de evolucion (CA03).
@freezed
abstract class IbsSssEvolutionPoint with _$IbsSssEvolutionPoint {
  const factory IbsSssEvolutionPoint({
    required String assessmentId,
    required int totalScore,
    required IbsSssAssessmentType assessmentType,
    @Default(0) int cycleNumber,
    IbsSssSeverity? severity,
    DateTime? completedAt,

    /// Diferencia contra la linea base.
    ///
    /// **Negativo significa mejoria**: el backend lo calcula como
    /// `TotalScore - baseline.TotalScore` (`IbsSssAssessment.CompareTotalScoreTo`,
    /// con su test `CompareTotalScoreTo_Improvement_ReturnsNegative` asertando
    /// `-50`). Llega `null` para la propia linea base y cuando no hay ninguna.
    int? deltaFromBaseline,
  }) = _IbsSssEvolutionPoint;

  const IbsSssEvolutionPoint._();

  /// Reduccion minima clinicamente significativa del IBS-SSS: 50 puntos.
  ///
  /// El backend tiene la regla en `IsClinicallySignificantImprovement`, pero el
  /// contrato **no la expone**, asi que el umbral queda escrito tambien aca. Es
  /// clinicamente estable, de modo que el riesgo es bajo; el dia que se exponga
  /// corresponde borrar esta constante y usar la del servidor.
  static const int minimalClinicallyImportantDifference = 50;

  /// `true` si esta evaluacion mejora la linea base de forma significativa.
  ///
  /// Como el delta es negativo cuando baja el puntaje, la comparacion va con
  /// `<= -50` y no con `>= 50`.
  bool get isClinicallySignificantImprovement {
    final delta = deltaFromBaseline;
    return delta != null && delta <= -minimalClinicallyImportantDifference;
  }
}
