import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/food_item.dart';

part 'foods_repository.g.dart';

/// Acceso al catalogo de alimentos del backend.
///
/// Es la mitad remota de la feature: la mitad local vive en
/// `FoodCatalogStore`, y es la que atiende las busquedas del paciente. Este
/// repositorio solo trae datos frescos para alimentar esa caja.
///
/// Misma frontera que los otros repositorios: hacia adentro habla
/// `built_value` y `DioException`; hacia afuera solo tipos del dominio y
/// [CauceApiError].
class FoodsRepository {
  const FoodsRepository(this._api);

  final FoodsApi _api;

  /// Tope que acepta el backend (`ListFoodItemsCatalogQueryValidator`).
  static const int _pageSize = 100;

  /// Corte de seguridad del recorrido paginado.
  ///
  /// Con el tope de 100 por pagina cubre 5000 alimentos, muy por encima de los
  /// ~928 de TPCA-CENAN (TS12). Existe para que un `totalCount` inconsistente
  /// no deje al cliente pidiendo paginas para siempre.
  static const int _maxPages = 50;

  /// Recorre `GET /foods` pagina por pagina y devuelve el catalogo completo.
  ///
  /// Se usa para refrescar la caja local al abrir sesion y al recuperar
  /// conexion. Las entradas llegan como `FoodItemSummary`, o sea **sin**
  /// composicion nutricional: esa se completa despues, alimento por alimento,
  /// con [fetchDetail].
  ///
  /// Una entrada sin `foodId` o sin `name` se descarta en vez de tumbar el
  /// refresco entero, con el mismo criterio que `PatientsRepository` aplica al
  /// catalogo de alergias.
  Future<List<FoodItem>> fetchCatalog() {
    return _guard(() async {
      final collected = <FoodItem>[];

      for (var page = 1; page <= _maxPages; page++) {
        final response = await _api.apiV1FoodsGet(
          page: page,
          pageSize: _pageSize,
        );

        final result = response.data;
        final items = result?.items;
        if (items == null || items.isEmpty) {
          break;
        }

        collected.addAll(items.map(_summaryToDomain).nonNulls);

        final totalCount = result?.totalCount;
        if (totalCount == null || page * _pageSize >= totalCount) {
          break;
        }
      }

      return collected;
    });
  }

  /// `GET /foods/{foodId}`. Trae la composicion nutricional.
  ///
  /// Se pide cuando el paciente abre el detalle de un alimento, y el resultado
  /// se guarda en la caja local: asi HU0010 estima el perfil del plato con lo
  /// que ya tiene, sin una llamada por ingrediente al momento de armarlo.
  Future<FoodItem> fetchDetail(String foodId) {
    return _guard(() async {
      final response = await _api.apiV1FoodsFoodIdGet(foodId: foodId);
      final detail = response.data;

      final id = detail?.foodId;
      final name = detail?.name;
      if (detail == null || id == null || name == null) {
        throw const FormatException(
          'El detalle del alimento respondio sin foodId o sin name.',
        );
      }

      return FoodItem(
        foodId: id,
        name: name,
        category: detail.category ?? '',
        isPeruvian: detail.isPeruvian ?? false,
        fodmapLevel: FodmapLoad.fromApi(detail.fodmapLevel),
        nutrition: FoodNutrition(
          caloriesPer100g: detail.caloriesPer100g ?? 0,
          proteinGPer100g: detail.proteinGPer100g ?? 0,
          carbsGPer100g: detail.carbsGPer100g ?? 0,
          fatGPer100g: detail.fatGPer100g ?? 0,
          fiberGPer100g: detail.fiberGPer100g ?? 0,
          fodmapTags: detail.fodmapTags,
        ),
      );
    });
  }

  /// `GET /foods/suggestions` (HU0009 CA03).
  ///
  /// El servidor arma las tres secciones: los frecuentes de los ultimos 30
  /// dias, los registrados en las ultimas 24 horas y una seleccion rotativa del
  /// catalogo. El cliente no las calcula.
  ///
  /// **Limitacion conocida del bloque.** Las dos primeras las computa el
  /// servidor sobre lo que ya recibio, asi que no ven las comidas que el
  /// paciente registro sin conexion y todavia no sincronizo.
  Future<FoodSuggestions> fetchSuggestions() {
    return _guard(() async {
      final response = await _api.apiV1FoodsSuggestionsGet();
      final result = response.data;

      return FoodSuggestions(
        frequentLast30Days: result?.frequentLast30Days
                ?.map(_summaryToDomain)
                .nonNulls
                .toList() ??
            const <FoodItem>[],
        recentLast24Hours: result?.recentLast24Hours
                ?.map(_summaryToDomain)
                .nonNulls
                .toList() ??
            const <FoodItem>[],
        catalogSuggestions: result?.catalogSuggestions
                ?.map(_summaryToDomain)
                .nonNulls
                .toList() ??
            const <FoodItem>[],
      );
    });
  }

  FoodItem? _summaryToDomain(FoodItemSummary summary) {
    final id = summary.foodId;
    final name = summary.name;
    if (id == null || name == null || name.isEmpty) {
      return null;
    }

    return FoodItem(
      foodId: id,
      name: name,
      category: summary.category ?? '',
      isPeruvian: summary.isPeruvian ?? false,
      fodmapLevel: FodmapLoad.fromApi(summary.fodmapLevel),
    );
  }

  Future<T> _guard<T>(Future<T> Function() call) => guardApiCall(call);
}

@Riverpod(keepAlive: true)
FoodsRepository foodsRepository(Ref ref) {
  return FoodsRepository(ref.watch(foodsApiProvider));
}
