import 'package:cauce_mobile/features/custom_foods/domain/custom_food.dart';
import 'package:cauce_mobile/features/custom_foods/domain/nutrition_estimator.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:flutter_test/flutter_test.dart';

FoodItem _food(
  String id,
  String name, {
  FoodNutrition? nutrition,
  FodmapLoad? fodmap,
}) {
  return FoodItem(
    foodId: id,
    name: name,
    category: 'cereales',
    isPeruvian: true,
    fodmapLevel: fodmap,
    nutrition: nutrition,
  );
}

const FoodNutrition _arrozNutrition = FoodNutrition(
  caloriesPer100g: 130,
  proteinGPer100g: 2.7,
  carbsGPer100g: 28.2,
  fatGPer100g: 0.3,
  fiberGPer100g: 0.4,
);

const FoodNutrition _polloNutrition = FoodNutrition(
  caloriesPer100g: 165,
  proteinGPer100g: 31,
  carbsGPer100g: 0,
  fatGPer100g: 3.6,
  fiberGPer100g: 0,
);

CustomFoodIngredientDraft _ingredient(FoodItem food, double grams) {
  return CustomFoodIngredientDraft(food: food, proportionGrams: grams);
}

void main() {
  group('NutritionEstimator · promedio ponderado (CA01, CP025)', () {
    test('un solo ingrediente devuelve su propia composicion', () {
      // Cualquiera sea la cantidad, el perfil por 100 g del plato es el del
      // unico ingrediente.
      final estimate = NutritionEstimator.estimate(<CustomFoodIngredientDraft>[
        _ingredient(_food('f1', 'Arroz', nutrition: _arrozNutrition), 250),
      ]);

      expect(estimate!.caloriesPer100g, closeTo(130, 0.001));
      expect(estimate.proteinGPer100g, closeTo(2.7, 0.001));
      expect(estimate.isPartial, isFalse);
    });

    test('dos ingredientes iguales en peso promedian a la mitad', () {
      final estimate = NutritionEstimator.estimate(<CustomFoodIngredientDraft>[
        _ingredient(_food('f1', 'Arroz', nutrition: _arrozNutrition), 100),
        _ingredient(_food('f2', 'Pollo', nutrition: _polloNutrition), 100),
      ]);

      expect(estimate!.caloriesPer100g, closeTo((130 + 165) / 2, 0.001));
      expect(estimate.proteinGPer100g, closeTo((2.7 + 31) / 2, 0.001));
    });

    test('pondera por gramos, no por cantidad de ingredientes', () {
      // 300 g de arroz y 100 g de pollo: el arroz pesa tres cuartos.
      final estimate = NutritionEstimator.estimate(<CustomFoodIngredientDraft>[
        _ingredient(_food('f1', 'Arroz', nutrition: _arrozNutrition), 300),
        _ingredient(_food('f2', 'Pollo', nutrition: _polloNutrition), 100),
      ]);

      expect(
        estimate!.caloriesPer100g,
        closeTo((130 * 300 + 165 * 100) / 400, 0.001),
      );
      expect(
        estimate.proteinGPer100g,
        closeTo((2.7 * 300 + 31 * 100) / 400, 0.001),
      );
    });

    test('sin ingredientes no hay estimacion', () {
      expect(
        NutritionEstimator.estimate(const <CustomFoodIngredientDraft>[]),
        isNull,
      );
    });
  });

  group('NutritionEstimator · composicion incompleta', () {
    test('un ingrediente sin nutricion se excluye y marca parcial', () {
      // Contarlo como cero abarataria el plato entero: un plato con arroz sin
      // detalle y aceite con detalle daria menos calorias que el aceite solo.
      final estimate = NutritionEstimator.estimate(<CustomFoodIngredientDraft>[
        _ingredient(_food('f1', 'Arroz', nutrition: _arrozNutrition), 100),
        _ingredient(_food('f2', 'Sin detalle'), 100),
      ]);

      expect(estimate!.isPartial, isTrue);
      // El promedio sale solo del que si tiene composicion.
      expect(estimate.caloriesPer100g, closeTo(130, 0.001));
    });

    test('si ninguno tiene composicion no devuelve un perfil en ceros', () {
      // Un perfil de puros ceros no es una estimacion, es un dato falso.
      final estimate = NutritionEstimator.estimate(<CustomFoodIngredientDraft>[
        _ingredient(_food('f1', 'Sin detalle'), 100),
        _ingredient(_food('f2', 'Tampoco'), 50),
      ]);

      expect(estimate, isNull);
    });

    test('una proporcion en cero no aporta y marca parcial', () {
      final estimate = NutritionEstimator.estimate(<CustomFoodIngredientDraft>[
        _ingredient(_food('f1', 'Arroz', nutrition: _arrozNutrition), 100),
        _ingredient(_food('f2', 'Pollo', nutrition: _polloNutrition), 0),
      ]);

      expect(estimate!.isPartial, isTrue);
      expect(estimate.caloriesPer100g, closeTo(130, 0.001));
    });
  });

  group('NutritionEstimator · carga FODMAP agregada', () {
    test('toma el maximo, igual que FodmapAggregator del backend', () {
      final level =
          NutritionEstimator.aggregateFodmap(<CustomFoodIngredientDraft>[
        _ingredient(_food('f1', 'Arroz', fodmap: FodmapLoad.low), 100),
        _ingredient(_food('f2', 'Camote', fodmap: FodmapLoad.moderate), 50),
        _ingredient(_food('f3', 'Cebolla', fodmap: FodmapLoad.high), 10),
      ]);

      expect(level, FodmapLoad.high);
    });

    test('ignora los ingredientes sin peso', () {
      final level =
          NutritionEstimator.aggregateFodmap(<CustomFoodIngredientDraft>[
        _ingredient(_food('f1', 'Arroz', fodmap: FodmapLoad.low), 100),
        _ingredient(_food('f2', 'Cebolla', fodmap: FodmapLoad.high), 0),
      ]);

      expect(level, FodmapLoad.low);
    });

    test('un ingrediente sin clasificar no cuenta', () {
      final level =
          NutritionEstimator.aggregateFodmap(<CustomFoodIngredientDraft>[
        _ingredient(_food('f1', 'Arroz', fodmap: FodmapLoad.moderate), 100),
        _ingredient(_food('f2', 'Sin clasificar'), 100),
      ]);

      expect(level, FodmapLoad.moderate);
    });

    test('sin ninguno clasificado devuelve null', () {
      final level =
          NutritionEstimator.aggregateFodmap(<CustomFoodIngredientDraft>[
        _ingredient(_food('f1', 'Sin clasificar'), 100),
      ]);

      expect(level, isNull);
    });

    test('la estimacion incluye la carga agregada', () {
      final estimate = NutritionEstimator.estimate(<CustomFoodIngredientDraft>[
        _ingredient(
          _food(
            'f1',
            'Arroz',
            nutrition: _arrozNutrition,
            fodmap: FodmapLoad.low,
          ),
          100,
        ),
        _ingredient(
          _food(
            'f2',
            'Pan',
            nutrition: _polloNutrition,
            fodmap: FodmapLoad.high,
          ),
          100,
        ),
      ]);

      expect(estimate!.fodmapLevel, FodmapLoad.high);
    });
  });
}
