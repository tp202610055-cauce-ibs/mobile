import '../../foods/domain/food_item.dart';
import 'custom_food.dart';

/// Estima el perfil nutricional de un plato compuesto (HU0010 CA01, CP025).
///
/// **Es cómputo nuevo del cliente, sin contraparte en el servidor.** El backend
/// agrega la carga FODMAP de una **comida** con `FodmapAggregator`, pero no
/// calcula calorias ni macros de un plato personalizado, y el contrato tampoco
/// los guarda. Esta clase existe para la vista previa mientras el paciente arma
/// el plato.
///
/// El calculo es una media ponderada por gramos, normalizada a 100 g:
///
/// ```
/// valorPor100g = sum(valorIngrediente_por100g * gramos / 100) / pesoTotal * 100
/// ```
///
/// que se simplifica a `sum(valor * gramos) / pesoTotal`.
abstract final class NutritionEstimator {
  /// Estima el perfil del plato a partir de lo que se sepa de cada ingrediente.
  ///
  /// Los ingredientes **sin** composicion conocida se excluyen del promedio y
  /// marcan el resultado como parcial. Contarlos como cero abarataria el plato
  /// entero: un plato con arroz sin detalle y aceite con detalle daria menos
  /// calorias que el aceite solo.
  ///
  /// Devuelve `null` si ningun ingrediente tiene composicion, porque un perfil
  /// de puros ceros no es una estimacion sino un dato falso.
  static NutritionEstimate? estimate(List<CustomFoodIngredientDraft> items) {
    if (items.isEmpty) {
      return null;
    }

    var weight = 0.0;
    var calories = 0.0;
    var protein = 0.0;
    var carbs = 0.0;
    var fat = 0.0;
    var fiber = 0.0;
    var partial = false;

    for (final item in items) {
      final nutrition = item.food.nutrition;
      if (nutrition == null || item.proportionGrams <= 0) {
        partial = true;
        continue;
      }

      final grams = item.proportionGrams;
      weight += grams;
      calories += nutrition.caloriesPer100g * grams;
      protein += nutrition.proteinGPer100g * grams;
      carbs += nutrition.carbsGPer100g * grams;
      fat += nutrition.fatGPer100g * grams;
      fiber += nutrition.fiberGPer100g * grams;
    }

    if (weight <= 0) {
      return null;
    }

    return NutritionEstimate(
      caloriesPer100g: calories / weight,
      proteinGPer100g: protein / weight,
      carbsGPer100g: carbs / weight,
      fatGPer100g: fat / weight,
      fiberGPer100g: fiber / weight,
      fodmapLevel: aggregateFodmap(items),
      isPartial: partial,
    );
  }

  /// Carga FODMAP del plato: el maximo de sus ingredientes con peso.
  ///
  /// Misma regla que `FodmapAggregator.AggregateForMeal` del backend, que deja
  /// anotado un TODO clinico para refinarla con umbrales de carga acumulada de
  /// Monash cuando esten los datos. Replicarla aca mantiene la vista previa
  /// consistente con lo que el servidor va a decir de la comida que use el
  /// plato, y cuando el backend afine la regla hay que afinarla en los dos.
  static FodmapLoad? aggregateFodmap(List<CustomFoodIngredientDraft> items) {
    FodmapLoad? aggregated;

    for (final item in items) {
      if (item.proportionGrams <= 0) {
        continue;
      }
      final level = item.food.fodmapLevel;
      if (level == null) {
        continue;
      }
      if (aggregated == null || level.index > aggregated.index) {
        aggregated = level;
      }
    }

    return aggregated;
  }
}
