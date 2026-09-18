import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../../foods/domain/food_item.dart';
import '../domain/meal_draft.dart';
import '../domain/meal_record.dart';

part 'meals_repository.g.dart';

/// Registro e historial de comidas (US09).
///
/// El `clientGuid` viaja en el **cuerpo**, no en el header. La §6.3 del
/// CLAUDE.md describia un `Idempotency-Key` universal que el contrato no
/// declara: para `/meals` y `/symptoms` el OpenAPI solo expone `clientGuid`
/// dentro del request, y el header existe apenas como respaldo no declarado
/// que el controlador lee. La via tipada es el cuerpo.
class MealsRepository {
  const MealsRepository(this._api);

  final MealsApi _api;

  /// `POST /api/v1/meals`. Devuelve el identificador del servidor.
  ///
  /// El endpoint es idempotente respecto de [clientGuid]: un reintento con la
  /// misma carga devuelve 200 en vez de 201 y **no** duplica el registro. Por
  /// eso el mismo UUID se repite en cada reintento.
  Future<CreatedMeal> create(MealDraft draft, {required String clientGuid}) {
    final mealTime = draft.mealTime;
    if (mealTime == null || draft.items.isEmpty) {
      throw StateError(
        'La comida exige momento del dia y al menos un alimento.',
      );
    }

    return guardApiCall(
      () async {
        final response = await _api.apiV1MealsPost(
          createMealRequest: CreateMealRequest(
            (b) => b
              ..clientGuid = clientGuid
              ..mealTime = mealTime.toApi()
              ..consumedAt = (draft.consumedAt ?? DateTime.now()).toUtc()
              ..clientCreatedAt = DateTime.now().toUtc()
              ..items.addAll(
                draft.items.map(
                  (item) => MealItemRequest(
                    (i) => i
                      ..foodId = item.foodId
                      ..customFoodId = item.customFoodId
                      ..quantity = item.quantity
                      ..unit = item.unit.toApi(),
                  ),
                ),
              ),
          ),
        );

        final mealId = response.data?.mealId;
        if (mealId == null) {
          throw const FormatException('El registro respondio sin mealId.');
        }

        return CreatedMeal(
          mealId: mealId,
          aggregatedFodmap: FodmapLoad.fromApi(response.data?.aggregatedFodmap),
          // 200 significa que el servidor reconocio el `client_guid` de un
          // envio anterior. Para el paciente el resultado es el mismo, y
          // distinguirlo evita contar dos veces el mismo registro.
          wasReplay: response.statusCode == 200,
        );
      },
      malformedResponseStatus: 201,
    );
  }

  /// Ventana por defecto del historial.
  ///
  /// **`from` y `to` no se pueden omitir.** El contrato los declara opcionales,
  /// pero el controlador los recibe como `DateTime` **no nullable**: sin ellos
  /// se enlazan a `default(DateTime)`, o sea `0001-01-01`, y la consulta filtra
  /// por el rango vacio `[0001-01-01, 0001-01-01]`. El endpoint responde 200
  /// con cero resultados, que es peor que un error porque parece un historial
  /// vacio. Verificado contra el backend el 2026-09-18: sin rango `totalCount`
  /// da 0, con rango da 8 sobre los mismos datos.
  static const Duration defaultWindow = Duration(days: 90);

  /// Margen hacia adelante del rango.
  ///
  /// El servidor filtra por `ClientCreatedAt <= to`, y acepta hasta 5 minutos
  /// de desfase de reloj del dispositivo. Un dia de margen cubre eso y la
  /// diferencia de zona horaria sin dejar afuera lo que el paciente acaba de
  /// registrar.
  static const Duration forwardMargin = Duration(days: 1);

  /// `GET /api/v1/meals`. Historial paginado del paciente.
  ///
  /// Sin [from] y [to] explicitos se usa la ventana por defecto. Ver
  /// [defaultWindow]: omitirlos del todo devuelve un historial vacio.
  Future<MealHistoryPage> history({
    DateTime? from,
    DateTime? to,
    int page = 1,
    int pageSize = 50,
    DateTime? now,
  }) {
    final reference = (now ?? DateTime.now()).toUtc();
    final start = (from ?? reference.subtract(defaultWindow)).toUtc();
    final end = (to ?? reference.add(forwardMargin)).toUtc();

    return guardApiCall(() async {
      final response = await _api.apiV1MealsGet(
        from: start,
        to: end,
        page: page,
        pageSize: pageSize,
      );

      final result = response.data;
      return MealHistoryPage(
        items: result?.items?.map(_toRecord).nonNulls.toList() ??
            const <MealRecord>[],
        page: result?.page ?? page,
        pageSize: result?.pageSize ?? pageSize,
        totalCount: result?.totalCount ?? 0,
      );
    });
  }

  /// Traduce una entrada del historial, descartandola si le falta lo esencial.
  MealRecord? _toRecord(MealHistoryItem item) {
    final mealId = item.mealId;
    final consumedAt = item.consumedAt;
    if (mealId == null || consumedAt == null) {
      return null;
    }

    return MealRecord(
      mealId: mealId,
      clientGuid: item.clientGuid,
      mealTime: MealTimeOption.fromApi(item.mealTime),
      consumedAt: consumedAt,
      aggregatedFodmap: FodmapLoad.fromApi(item.aggregatedFodmap),
      items: item.items
              ?.map(
                (entry) => MealRecordItem(
                  foodId: entry.foodId,
                  customFoodId: entry.customFoodId,
                  quantity: entry.quantity ?? 0,
                  unit: MeasurementUnitOption.fromApi(entry.unit),
                ),
              )
              .toList() ??
          const <MealRecordItem>[],
    );
  }
}

@Riverpod(keepAlive: true)
MealsRepository mealsRepository(Ref ref) {
  return MealsRepository(ref.watch(mealsApiProvider));
}
