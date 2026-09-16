import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ibs_sss_baseline.freezed.dart';

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
abstract class IbsSssBaselineAnswers with _$IbsSssBaselineAnswers {
  const factory IbsSssBaselineAnswers({
    @Default(<IbsSssDimension, int>{}) Map<IbsSssDimension, int> values,
  }) = _IbsSssBaselineAnswers;

  const IbsSssBaselineAnswers._();

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
  IbsSssBaselineAnswers withAnswer(IbsSssDimension dimension, int value) {
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
abstract class IbsSssBaselineResult with _$IbsSssBaselineResult {
  const factory IbsSssBaselineResult({
    required String assessmentId,

    /// Suma de las cinco dimensiones, de 0 a 500. La calcula el servidor.
    required int totalScore,

    /// `true` si esta evaluacion cerro el onboarding del paciente.
    required bool triggeredOnboardingCompletion,
    IbsSssSeverity? severity,

    /// Fecha de la proxima evaluacion periodica, a catorce dias. La agenda el
    /// backend y la consume US12, fuera del alcance de este bloque.
    DateTime? nextAssessmentDate,
  }) = _IbsSssBaselineResult;

  const IbsSssBaselineResult._();
}
