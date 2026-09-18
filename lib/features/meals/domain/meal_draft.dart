import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../foods/domain/food_item.dart';

part 'meal_draft.freezed.dart';

/// Momento del dia en que el paciente comio.
enum MealTimeOption {
  breakfast,
  lunch,
  dinner,
  snack;

  /// Valor tal como lo serializa el contrato, que es la forma en que se guarda
  /// en `meals_local` y la que viaja en el lote.
  String get wireValue => switch (this) {
        MealTimeOption.breakfast => 'Breakfast',
        MealTimeOption.lunch => 'Lunch',
        MealTimeOption.dinner => 'Dinner',
        MealTimeOption.snack => 'Snack',
      };

  api.MealTime toApi() => switch (this) {
        MealTimeOption.breakfast => api.MealTime.breakfast,
        MealTimeOption.lunch => api.MealTime.lunch,
        MealTimeOption.dinner => api.MealTime.dinner,
        MealTimeOption.snack => api.MealTime.snack,
      };

  static MealTimeOption? fromWire(String? value) {
    return switch (value) {
      'Breakfast' => MealTimeOption.breakfast,
      'Lunch' => MealTimeOption.lunch,
      'Dinner' => MealTimeOption.dinner,
      'Snack' => MealTimeOption.snack,
      _ => null,
    };
  }

  static MealTimeOption? fromApi(api.MealTime? value) {
    return switch (value) {
      api.MealTime.breakfast => MealTimeOption.breakfast,
      api.MealTime.lunch => MealTimeOption.lunch,
      api.MealTime.dinner => MealTimeOption.dinner,
      api.MealTime.snack => MealTimeOption.snack,
      _ => null,
    };
  }
}

/// Unidad en que el paciente declara la cantidad.
enum MeasurementUnitOption {
  grams,
  cups,
  units,
  ounces,
  tablespoons;

  String get wireValue => switch (this) {
        MeasurementUnitOption.grams => 'Grams',
        MeasurementUnitOption.cups => 'Cups',
        MeasurementUnitOption.units => 'Units',
        MeasurementUnitOption.ounces => 'Ounces',
        MeasurementUnitOption.tablespoons => 'Tablespoons',
      };

  api.MeasurementUnit toApi() => switch (this) {
        MeasurementUnitOption.grams => api.MeasurementUnit.grams,
        MeasurementUnitOption.cups => api.MeasurementUnit.cups,
        MeasurementUnitOption.units => api.MeasurementUnit.units,
        MeasurementUnitOption.ounces => api.MeasurementUnit.ounces,
        MeasurementUnitOption.tablespoons => api.MeasurementUnit.tablespoons,
      };

  static MeasurementUnitOption? fromWire(String? value) {
    return switch (value) {
      'Grams' => MeasurementUnitOption.grams,
      'Cups' => MeasurementUnitOption.cups,
      'Units' => MeasurementUnitOption.units,
      'Ounces' => MeasurementUnitOption.ounces,
      'Tablespoons' => MeasurementUnitOption.tablespoons,
      _ => null,
    };
  }

  static MeasurementUnitOption? fromApi(api.MeasurementUnit? value) {
    return switch (value) {
      api.MeasurementUnit.grams => MeasurementUnitOption.grams,
      api.MeasurementUnit.cups => MeasurementUnitOption.cups,
      api.MeasurementUnit.units => MeasurementUnitOption.units,
      api.MeasurementUnit.ounces => MeasurementUnitOption.ounces,
      api.MeasurementUnit.tablespoons => MeasurementUnitOption.tablespoons,
      _ => null,
    };
  }
}

/// Un ingrediente de la comida que el paciente esta armando.
///
/// Referencia **exactamente uno** de [food] o [customFoodId]. La invariante es
/// del backend (`Meal.Register` la exige como XOR) y se replica aca para que el
/// formulario no pueda construir algo que el servidor va a rechazar.
@freezed
abstract class MealItemDraft with _$MealItemDraft {
  const factory MealItemDraft({
    required double quantity,
    required MeasurementUnitOption unit,

    /// Alimento del catalogo, con lo que se sepa de el.
    FoodItem? food,

    /// Plato personalizado ya creado en el servidor.
    String? customFoodId,

    /// Nombre del plato personalizado, solo para mostrarlo.
    String? customFoodName,
  }) = _MealItemDraft;

  const MealItemDraft._();

  /// Identificador del alimento del catalogo, si el item referencia uno.
  String? get foodId => food?.foodId;

  /// Nombre que se muestra en la lista del formulario.
  String get displayName => food?.name ?? customFoodName ?? '';

  /// `true` si referencia exactamente una de las dos cosas.
  bool get referencesExactlyOne => (foodId != null) != (customFoodId != null);
}

/// Motivo por el que una comida todavia no se puede registrar.
///
/// Espeja `CreateMealCommandValidator` y las invariantes de `Meal.Register`,
/// para que el paciente vea el problema al instante en vez de esperar un 400.
enum MealDraftIssue {
  /// No se eligio el momento del dia (CA04).
  missingMealTime,

  /// No hay ningun alimento en la comida.
  noItems,

  /// Mas de 50 items, que es el tope del backend.
  tooManyItems,

  /// Algun item tiene cantidad menor o igual a cero (CA04).
  invalidQuantity,

  /// Algun item no referencia exactamente un alimento.
  invalidReference,

  /// La fecha de consumo esta en el futuro.
  futureConsumedAt,
}

/// Comida en construccion, antes de salir del dispositivo.
@freezed
abstract class MealDraft with _$MealDraft {
  const factory MealDraft({
    MealTimeOption? mealTime,
    DateTime? consumedAt,
    @Default(<MealItemDraft>[]) List<MealItemDraft> items,
  }) = _MealDraft;

  const MealDraft._();

  /// Minimo y maximo de items que acepta `Meal.Register`.
  static const int minItems = 1;
  static const int maxItems = 50;

  /// Tolerancia de reloj que aplica el backend a las fechas.
  ///
  /// Se replica para no bloquear al paciente por un desfase que el servidor si
  /// va a aceptar.
  static const Duration clockSkewTolerance = Duration(minutes: 5);

  /// Todo lo que impide registrar la comida, en orden de presentacion.
  ///
  /// Se devuelven **todos** los motivos y no el primero: corregir de a uno
  /// obligaria al paciente a reintentar el envio una vez por problema.
  List<MealDraftIssue> issues({DateTime? now}) {
    final problems = <MealDraftIssue>[];

    if (mealTime == null) {
      problems.add(MealDraftIssue.missingMealTime);
    }
    if (items.length < minItems) {
      problems.add(MealDraftIssue.noItems);
    }
    if (items.length > maxItems) {
      problems.add(MealDraftIssue.tooManyItems);
    }
    if (items.any((item) => item.quantity <= 0)) {
      problems.add(MealDraftIssue.invalidQuantity);
    }
    if (items.any((item) => !item.referencesExactlyOne)) {
      problems.add(MealDraftIssue.invalidReference);
    }

    final consumed = consumedAt;
    if (consumed != null) {
      final limit = (now ?? DateTime.now()).toUtc().add(clockSkewTolerance);
      if (consumed.toUtc().isAfter(limit)) {
        problems.add(MealDraftIssue.futureConsumedAt);
      }
    }

    return problems;
  }

  /// `true` cuando la comida se puede registrar (CA04).
  bool canSubmit({DateTime? now}) => issues(now: now).isEmpty;

  /// Copia con un item mas.
  MealDraft withItem(MealItemDraft item) =>
      copyWith(items: <MealItemDraft>[...items, item]);

  /// Copia sin el item de esa posicion.
  ///
  /// Una posicion fuera de rango devuelve la misma comida en vez de lanzar: el
  /// unico origen posible es un toque duplicado sobre una fila que ya se
  /// quito, y castigar eso con una excepcion no le sirve al paciente.
  MealDraft withoutItemAt(int index) {
    if (index < 0 || index >= items.length) {
      return this;
    }
    return copyWith(
      items: <MealItemDraft>[...items]..removeAt(index),
    );
  }
}
