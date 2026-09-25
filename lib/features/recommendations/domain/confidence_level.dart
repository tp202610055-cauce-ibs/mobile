/// Nivel de confianza del modelo en tres escalones (HU0015 CA1).
///
/// El contrato solo trae el `confidenceScore` crudo, entre 0 y 1. Los cortes
/// **no son del contrato**: se toman prestados de los umbrales que el propio
/// motor de reglas usa para decidir entre evitar y reducir un alimento
/// (`AvoidThreshold` y `ReduceThreshold` en `RecommendationsOptions` del
/// backend, 0.70 y 0.45 en `appsettings.json`, sin override en Development).
/// Son un valor por defecto reversible, registrado en el acta M47: el dia que
/// el backend exponga el nivel, esta clase se borra.
enum ConfidenceLevel {
  high,
  medium,
  low;

  /// Desde este puntaje, inclusive, la confianza es alta.
  static const double highThreshold = 0.70;

  /// Desde este puntaje, inclusive, la confianza es media.
  static const double mediumThreshold = 0.45;

  static ConfidenceLevel fromScore(double score) {
    if (score >= highThreshold) {
      return high;
    }
    if (score >= mediumThreshold) {
      return medium;
    }
    return low;
  }

  /// Barras llenas del indicador de la seccion F del design system.
  int get filledBars => switch (this) {
        high => 3,
        medium => 2,
        low => 1,
      };
}
