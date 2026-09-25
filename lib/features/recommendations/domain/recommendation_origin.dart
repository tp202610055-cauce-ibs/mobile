import 'recommendation.dart';

/// Origen que se le muestra al paciente en la pildora (decision 10).
///
/// Es el vocabulario del mockup 11 y no el nombre crudo del estado: el
/// paciente nunca lee "Entregada" ni "Con feedback", que describen el ciclo
/// interno y no de donde salio la recomendacion.
enum RecommendationOrigin {
  /// "Sugerencia del sistema".
  system,

  /// "Modificada por {nombre}".
  modified,

  /// "Indicacion de {nombre}".
  manual;

  /// Resuelve el origen a partir de lo que trae el detalle.
  ///
  /// Los tres estados aprobados lo dicen directo. `Delivered` y
  /// `FeedbackReceived` ya lo perdieron, y hay que inferirlo:
  ///
  /// - **Manual** si `explanationSource` es `Manual`. Es la senal fiable: el
  ///   backend la fija en `CreateManual` y ningun otro camino la escribe. Sin
  ///   ese dato, cero items tambien indica manual, porque el motor nunca
  ///   genera una recomendacion vacia (`EmptyRecommendationException`).
  /// - **Sistema** en cualquier otro caso.
  ///
  /// **Por que no se usan `autoApproved`, `reviewedByNutritionistId` ni
  /// `nutritionistNote`**, que eran los campos que sugeria la decision: no
  /// distinguen nada. `Approve` y `ModifyByNutritionist` del backend escriben
  /// los mismos tres (revisor, nota, `AutoApproved = false`), y con la
  /// auto-aprobacion apagada en el piloto toda aprobada los tiene. Una vez
  /// entregada, una aprobada y una modificada son indistinguibles en el
  /// contrato. Se elige "sistema" porque es verdad para las dos (ambas
  /// salieron del motor), mientras que "modificada" seria falso para una
  /// aprobada sin cambios. El nombre y la nota del nutricionista siguen a la
  /// vista en el detalle (acta M47).
  static RecommendationOrigin resolve({
    required RecommendationStatusOption status,
    required ExplanationOrigin? explanationSource,
    required int itemsCount,
  }) {
    return switch (status) {
      RecommendationStatusOption.approved => system,
      RecommendationStatusOption.modifiedApproved => modified,
      RecommendationStatusOption.manualApproved => manual,
      _ when explanationSource == ExplanationOrigin.manual => manual,
      _ when explanationSource == null && itemsCount == 0 => manual,
      _ => system,
    };
  }

  /// Lleva el nombre del nutricionista en la pildora.
  bool get namesNutritionist => this != system;
}
