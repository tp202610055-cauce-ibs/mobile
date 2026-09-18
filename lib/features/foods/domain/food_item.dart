import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'food_item.freezed.dart';

/// Carga FODMAP del alimento, segun el catalogo del backend.
///
/// FODMAP son los oligosacaridos, disacaridos, monosacaridos y polioles
/// fermentables: los carbohidratos de cadena corta que el intestino delgado
/// absorbe mal y que en el SII disparan sintomas. El catalogo clasifica cada
/// alimento en tres niveles, y el detalle agrega las etiquetas de que familia
/// aporta cada uno.
enum FodmapLoad {
  low,
  moderate,
  high;

  static FodmapLoad? fromApi(api.FodmapLevel? value) {
    return switch (value) {
      api.FodmapLevel.low => FodmapLoad.low,
      api.FodmapLevel.moderate => FodmapLoad.moderate,
      api.FodmapLevel.high => FodmapLoad.high,
      _ => null,
    };
  }

  /// Valor tal como lo serializa el contrato, que es la forma en que se guarda
  /// en la caja local.
  String get wireValue => switch (this) {
        FodmapLoad.low => 'Low',
        FodmapLoad.moderate => 'Moderate',
        FodmapLoad.high => 'High',
      };

  static FodmapLoad? fromWire(String? value) {
    return switch (value) {
      'Low' => FodmapLoad.low,
      'Moderate' => FodmapLoad.moderate,
      'High' => FodmapLoad.high,
      _ => null,
    };
  }
}

/// Composicion nutricional por 100 gramos.
///
/// Solo la trae `GET /foods/{foodId}` (`FoodItemDetail`). El listado, la
/// busqueda y las sugerencias devuelven `FoodItemSummary`, que no la incluye,
/// asi que se completa de forma oportunista cuando el paciente abre el detalle
/// de un alimento. HU0010 la necesita para estimar el perfil del plato.
@freezed
abstract class FoodNutrition with _$FoodNutrition {
  const factory FoodNutrition({
    required double caloriesPer100g,
    required double proteinGPer100g,
    required double carbsGPer100g,
    required double fatGPer100g,
    required double fiberGPer100g,

    /// Familias FODMAP separadas por coma: `fructans`, `lactose,polyols`.
    String? fodmapTags,
  }) = _FoodNutrition;

  const FoodNutrition._();

  /// Las etiquetas como lista, o vacia si no hay ninguna.
  List<String> get fodmapTagList {
    final raw = fodmapTags;
    if (raw == null || raw.isEmpty) {
      return const <String>[];
    }
    return raw
        .split(',')
        .map((tag) => tag.trim())
        .where((tag) => tag.isNotEmpty)
        .toList();
  }
}

/// Alimento del catalogo, tal como lo ve el paciente al armar una comida.
///
/// [nutrition] es `null` mientras solo se conozca el resumen. No significa que
/// el alimento no tenga composicion: significa que todavia no se pidio el
/// detalle.
@freezed
abstract class FoodItem with _$FoodItem {
  const factory FoodItem({
    required String foodId,
    required String name,
    required String category,
    required bool isPeruvian,
    FodmapLoad? fodmapLevel,
    FoodNutrition? nutrition,
  }) = _FoodItem;

  const FoodItem._();

  /// `true` si ya se conoce la composicion, o sea si se leyo el detalle.
  bool get hasNutrition => nutrition != null;
}

/// Las tres secciones que devuelve `GET /foods/suggestions` (HU0009 CA03).
///
/// El servidor las arma: frecuentes de los ultimos 30 dias, registrados en las
/// ultimas 24 horas y una seleccion rotativa del catalogo. Es lo que se muestra
/// **antes** de que el paciente escriba; al escribir toma el relevo la busqueda
/// local sobre la caja completa.
@freezed
abstract class FoodSuggestions with _$FoodSuggestions {
  const factory FoodSuggestions({
    @Default(<FoodItem>[]) List<FoodItem> frequentLast30Days,
    @Default(<FoodItem>[]) List<FoodItem> recentLast24Hours,
    @Default(<FoodItem>[]) List<FoodItem> catalogSuggestions,
  }) = _FoodSuggestions;

  const FoodSuggestions._();

  /// `true` si el servidor no devolvio nada en ninguna seccion.
  bool get isEmpty =>
      frequentLast30Days.isEmpty &&
      recentLast24Hours.isEmpty &&
      catalogSuggestions.isEmpty;
}
