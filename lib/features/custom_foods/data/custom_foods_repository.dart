import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/custom_food.dart';

part 'custom_foods_repository.g.dart';

/// Platos personalizados del paciente (US10).
///
/// Son **online-only** en este bloque: `SyncBatchRequest` solo acepta comidas y
/// sintomas, asi que crear un plato exige conexion. Una comida registrada sin
/// red si puede referenciar un plato ya creado.
class CustomFoodsRepository {
  const CustomFoodsRepository(this._api);

  final CustomFoodsApi _api;

  /// `POST /api/v1/custom-foods`.
  ///
  /// [confirmedAllergens] arranca en `false` (CA03): si el servidor detecta
  /// coincidencias contra las alergias declaradas responde 409
  /// `unconfirmed_allergens` con el detalle, y recien tras la confirmacion
  /// explicita del paciente se reenvia en `true`.
  Future<String> create(
    CustomFoodDraft draft, {
    bool confirmedAllergens = false,
  }) {
    return guardApiCall(
      () async {
        final response = await _api.apiV1CustomFoodsPost(
          createCustomFoodRequest: CreateCustomFoodRequest(
            (b) => b
              ..name = draft.name.trim()
              ..portionSizeGrams = draft.portionSizeGrams
              ..confirmedAllergens = confirmedAllergens
              ..ingredients.addAll(
                draft.ingredients.map(
                  (item) => CustomFoodIngredientRequest(
                    (i) => i
                      ..foodId = item.foodId
                      ..proportionGrams = item.proportionGrams,
                  ),
                ),
              ),
          ),
        );

        final customFoodId = response.data?.customFoodId;
        if (customFoodId == null) {
          throw const FormatException(
            'La creacion respondio sin customFoodId.',
          );
        }
        return customFoodId;
      },
      malformedResponseStatus: 201,
    );
  }

  /// `GET /api/v1/custom-foods`. Los platos que el paciente ya tiene.
  ///
  /// Alimenta la validacion instantanea de nombre duplicado (CA02) ademas de la
  /// lista.
  Future<List<CustomFoodRecord>> list() {
    return guardApiCall(() async {
      final response = await _api.apiV1CustomFoodsGet();

      return response.data?.map(_toRecord).nonNulls.toList() ??
          const <CustomFoodRecord>[];
    });
  }

  /// `PUT /api/v1/custom-foods/{customFoodId}`.
  ///
  /// **Sin revalidacion de alergenos.** `UpdateCustomFoodCommandHandler` del
  /// backend valida nombre duplicado y existencia de cada alimento, y nunca
  /// llama a `ICustomFoodAllergenChecker`; `UpdateCustomFoodRequest` tampoco
  /// tiene `confirmedAllergens`. Editar un plato agregandole un ingrediente
  /// alergenico pasa sin advertencia. Es un gap del backend, reportado y fuera
  /// del alcance de este bloque.
  Future<String> update(String customFoodId, CustomFoodDraft draft) {
    return guardApiCall(() async {
      final response = await _api.apiV1CustomFoodsCustomFoodIdPut(
        customFoodId: customFoodId,
        updateCustomFoodRequest: UpdateCustomFoodRequest(
          (b) => b
            ..name = draft.name.trim()
            ..portionSizeGrams = draft.portionSizeGrams
            ..ingredients.addAll(
              draft.ingredients.map(
                (item) => CustomFoodIngredientRequest(
                  (i) => i
                    ..foodId = item.foodId
                    ..proportionGrams = item.proportionGrams,
                ),
              ),
            ),
        ),
      );

      final id = response.data?.customFoodId;
      if (id == null) {
        throw const FormatException(
          'La actualizacion respondio sin customFoodId.',
        );
      }
      return id;
    });
  }

  /// `DELETE /api/v1/custom-foods/{customFoodId}`.
  ///
  /// Falla con 409 `custom_food_in_use` si alguna comida ya lo referencia.
  Future<void> delete(String customFoodId) {
    return guardApiCall(
      () => _api.apiV1CustomFoodsCustomFoodIdDelete(
        customFoodId: customFoodId,
      ),
    );
  }

  CustomFoodRecord? _toRecord(CustomFoodSummary summary) {
    final id = summary.customFoodId;
    final name = summary.name;
    if (id == null || name == null) {
      return null;
    }

    return CustomFoodRecord(
      customFoodId: id,
      name: name,
      portionSizeGrams: summary.portionSizeGrams ?? 0,
      createdAt: summary.createdAt,
      ingredients: summary.ingredients
              ?.map(
                (item) => item.foodId == null
                    ? null
                    : CustomFoodIngredientRef(
                        foodId: item.foodId!,
                        proportionGrams: item.proportionGrams ?? 0,
                      ),
              )
              .nonNulls
              .toList() ??
          const <CustomFoodIngredientRef>[],
    );
  }
}

@Riverpod(keepAlive: true)
CustomFoodsRepository customFoodsRepository(Ref ref) {
  return CustomFoodsRepository(ref.watch(customFoodsApiProvider));
}
