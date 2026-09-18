import 'package:freezed_annotation/freezed_annotation.dart';

import '../../foods/domain/food_item.dart';

part 'custom_food.freezed.dart';

/// Un ingrediente del plato, con la proporcion que aporta.
@freezed
abstract class CustomFoodIngredientDraft with _$CustomFoodIngredientDraft {
  const factory CustomFoodIngredientDraft({
    required FoodItem food,

    /// Gramos que aporta este ingrediente al plato.
    required double proportionGrams,
  }) = _CustomFoodIngredientDraft;

  const CustomFoodIngredientDraft._();

  String get foodId => food.foodId;
}

/// Motivo por el que el plato todavia no se puede guardar.
///
/// Espeja `CreateCustomFoodCommandValidator` y las invariantes de `CustomFood`,
/// para que el paciente vea el problema al instante en vez de esperar un 400.
enum CustomFoodIssue {
  /// Falta el nombre, o supera los 150 caracteres.
  invalidName,

  /// Ya existe un plato del paciente con ese nombre (CA02).
  duplicateName,

  /// La porcion declarada es cero o negativa.
  invalidPortion,

  /// El plato no tiene ingredientes.
  noIngredients,

  /// Algun ingrediente tiene proporcion cero o negativa.
  invalidProportion,

  /// El mismo alimento aparece dos veces.
  duplicateIngredient,
}

/// Perfil nutricional estimado de un plato compuesto (CA01, CP025).
///
/// **Es una estimacion del cliente y no se persiste.** El contrato no guarda la
/// composicion de un plato personalizado: `CreateCustomFoodRequest` solo lleva
/// nombre, porcion e ingredientes, y ni el backend ni ningun endpoint calculan
/// esto. Se muestra como vista previa mientras el paciente arma el plato.
@freezed
abstract class NutritionEstimate with _$NutritionEstimate {
  const factory NutritionEstimate({
    required double caloriesPer100g,
    required double proteinGPer100g,
    required double carbsGPer100g,
    required double fatGPer100g,
    required double fiberGPer100g,

    /// Carga FODMAP del plato: el maximo de sus ingredientes.
    FodmapLoad? fodmapLevel,

    /// `true` si algun ingrediente no tenia composicion conocida.
    ///
    /// Pasa cuando el detalle no se pudo traer, tipicamente sin conexion. La
    /// estimacion sale igual con lo que hay, y decirlo evita presentar como
    /// completo un calculo que le falta la mitad.
    @Default(false) bool isPartial,
  }) = _NutritionEstimate;

  const NutritionEstimate._();
}

/// Plato personalizado en construccion.
@freezed
abstract class CustomFoodDraft with _$CustomFoodDraft {
  const factory CustomFoodDraft({
    @Default('') String name,
    @Default(0) double portionSizeGrams,
    @Default(<CustomFoodIngredientDraft>[])
    List<CustomFoodIngredientDraft> ingredients,
  }) = _CustomFoodDraft;

  const CustomFoodDraft._();

  /// Tope de nombre que exige `CustomFood.EnsureValidName`.
  static const int maxNameLength = 150;

  /// Suma de las proporciones declaradas.
  double get ingredientsWeight =>
      ingredients.fold(0, (sum, item) => sum + item.proportionGrams);

  /// Diferencia entre lo que suman los ingredientes y la porcion declarada.
  ///
  /// El dominio del backend la expone como `GetIngredientsWeightDelta`, pero
  /// ningun caso de uso la valida: se muestra como informacion, no bloquea.
  double get weightDelta => ingredientsWeight - portionSizeGrams;

  /// Todo lo que impide guardar el plato.
  ///
  /// [existingNames] son los nombres de los platos que el paciente ya tiene, en
  /// minusculas. Sirve para el rechazo instantaneo de CA02; el servidor sigue
  /// siendo la autoridad con su 409 `duplicate_custom_food`.
  List<CustomFoodIssue> issues({Set<String> existingNames = const <String>{}}) {
    final problems = <CustomFoodIssue>[];
    final trimmed = name.trim();

    if (trimmed.isEmpty || trimmed.length > maxNameLength) {
      problems.add(CustomFoodIssue.invalidName);
    } else if (existingNames.contains(trimmed.toLowerCase())) {
      problems.add(CustomFoodIssue.duplicateName);
    }

    if (portionSizeGrams <= 0) {
      problems.add(CustomFoodIssue.invalidPortion);
    }
    if (ingredients.isEmpty) {
      problems.add(CustomFoodIssue.noIngredients);
    }
    if (ingredients.any((item) => item.proportionGrams <= 0)) {
      problems.add(CustomFoodIssue.invalidProportion);
    }

    final ids = ingredients.map((item) => item.foodId).toList();
    if (ids.length != ids.toSet().length) {
      problems.add(CustomFoodIssue.duplicateIngredient);
    }

    return problems;
  }

  bool canSubmit({Set<String> existingNames = const <String>{}}) =>
      issues(existingNames: existingNames).isEmpty;

  /// Copia con un ingrediente mas.
  ///
  /// Si el alimento ya estaba, **suma** la proporcion en vez de repetir la
  /// fila. `CustomFood.AddIngredient` del backend rechaza el duplicado con 409
  /// `duplicate_ingredient`, y para el paciente agregar dos veces el mismo
  /// alimento significa que quiere mas cantidad, no un error.
  CustomFoodDraft withIngredient(CustomFoodIngredientDraft ingredient) {
    final index =
        ingredients.indexWhere((item) => item.foodId == ingredient.foodId);
    if (index < 0) {
      return copyWith(
        ingredients: <CustomFoodIngredientDraft>[...ingredients, ingredient],
      );
    }

    final merged = <CustomFoodIngredientDraft>[...ingredients];
    merged[index] = merged[index].copyWith(
      proportionGrams:
          merged[index].proportionGrams + ingredient.proportionGrams,
    );
    return copyWith(ingredients: merged);
  }

  CustomFoodDraft withoutIngredientAt(int index) {
    if (index < 0 || index >= ingredients.length) {
      return this;
    }
    return copyWith(
      ingredients: <CustomFoodIngredientDraft>[...ingredients]..removeAt(index),
    );
  }
}

/// Un plato personalizado ya guardado en el servidor.
@freezed
abstract class CustomFoodRecord with _$CustomFoodRecord {
  const factory CustomFoodRecord({
    required String customFoodId,
    required String name,
    required double portionSizeGrams,
    DateTime? createdAt,
    @Default(<CustomFoodIngredientRef>[])
    List<CustomFoodIngredientRef> ingredients,
  }) = _CustomFoodRecord;

  const CustomFoodRecord._();
}

/// Ingrediente de un plato guardado, tal como lo devuelve el servidor.
///
/// Trae el `foodId` y la proporcion, sin el nombre: para mostrarlo hay que
/// resolverlo contra el catalogo local.
@freezed
abstract class CustomFoodIngredientRef with _$CustomFoodIngredientRef {
  const factory CustomFoodIngredientRef({
    required String foodId,
    required double proportionGrams,
  }) = _CustomFoodIngredientRef;

  const CustomFoodIngredientRef._();
}
