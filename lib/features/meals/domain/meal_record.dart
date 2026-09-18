import 'package:freezed_annotation/freezed_annotation.dart';

import '../../foods/domain/food_item.dart';
import 'meal_draft.dart';

part 'meal_record.freezed.dart';

/// Resultado de registrar una comida contra el servidor.
@freezed
abstract class CreatedMeal with _$CreatedMeal {
  const factory CreatedMeal({
    required String mealId,

    /// Carga FODMAP agregada de la comida, que calcula el servidor.
    ///
    /// La regla de hoy es el maximo nivel entre los ingredientes con peso; el
    /// backend deja anotado que se refinara con umbrales de carga acumulada de
    /// Monash cuando esten los datos. El cliente no la recalcula.
    FodmapLoad? aggregatedFodmap,

    /// `true` si el servidor reconocio un `client_guid` ya registrado y
    /// respondio 200 en vez de 201.
    @Default(false) bool wasReplay,
  }) = _CreatedMeal;

  const CreatedMeal._();
}

/// Un item de una comida ya registrada.
@freezed
abstract class MealRecordItem with _$MealRecordItem {
  const factory MealRecordItem({
    required double quantity,
    String? foodId,
    String? customFoodId,
    MeasurementUnitOption? unit,
  }) = _MealRecordItem;

  const MealRecordItem._();
}

/// Una comida del historial del paciente.
@freezed
abstract class MealRecord with _$MealRecord {
  const factory MealRecord({
    required String mealId,
    required DateTime consumedAt,
    String? clientGuid,
    MealTimeOption? mealTime,
    FodmapLoad? aggregatedFodmap,
    @Default(<MealRecordItem>[]) List<MealRecordItem> items,
  }) = _MealRecord;

  const MealRecord._();
}

/// Una pagina del historial de comidas.
@freezed
abstract class MealHistoryPage with _$MealHistoryPage {
  const factory MealHistoryPage({
    @Default(<MealRecord>[]) List<MealRecord> items,
    @Default(1) int page,
    @Default(50) int pageSize,
    @Default(0) int totalCount,
  }) = _MealHistoryPage;

  const MealHistoryPage._();

  /// `true` si quedan mas paginas por pedir.
  bool get hasMore => page * pageSize < totalCount;
}
