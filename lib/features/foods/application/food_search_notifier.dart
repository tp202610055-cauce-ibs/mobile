import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/sync/connectivity_monitor.dart';
import '../data/food_catalog_store.dart';
import '../data/foods_repository.dart';
import '../domain/food_item.dart';

part 'food_search_notifier.freezed.dart';
part 'food_search_notifier.g.dart';

/// Estado del buscador de alimentos (HU0009 CA03).
@freezed
abstract class FoodSearchState with _$FoodSearchState {
  const factory FoodSearchState({
    @Default('') String query,
    @Default(<FoodItem>[]) List<FoodItem> results,

    /// Sugerencias del servidor, o `null` si no se pudieron traer.
    FoodSuggestions? suggestions,
    @Default(false) bool loadingSuggestions,
  }) = _FoodSearchState;

  const FoodSearchState._();

  /// `true` mientras el paciente no escribio nada.
  ///
  /// Es el momento de las sugerencias; al escribir toma el relevo la busqueda
  /// local sobre el catalogo completo.
  bool get isBrowsing => query.trim().isEmpty;

  /// `true` si se busco y no hubo coincidencias.
  bool get hasNoResults => !isBrowsing && results.isEmpty;

  /// `true` si hay sugerencias que valga la pena mostrar.
  bool get hasSuggestions => suggestions != null && !suggestions!.isEmpty;
}

/// Gobierna la busqueda de alimentos del modal de registro.
///
/// **La busqueda por texto es siempre local**, contra `food_catalog_cache`, y
/// nunca contra `GET /foods/search`. CP023 registra una comida en modo avion,
/// asi que el catalogo tiene que ser buscable sin red. De paso queda inmune a
/// que el servidor no sea insensible a tildes, que no lo es.
///
/// Las sugerencias si son del servidor y solo estan con conexion: sin red la
/// seccion se oculta, sin error, y la busqueda por texto sigue disponible.
@riverpod
class FoodSearchNotifier extends _$FoodSearchNotifier {
  @override
  FoodSearchState build() => const FoodSearchState();

  /// Trae las sugerencias del servidor, si hay conexion.
  ///
  /// Un fallo no es un error de usuario: deja el estado sin sugerencias y la
  /// pantalla oculta la seccion.
  Future<void> loadSuggestions() async {
    if (state.loadingSuggestions) {
      return;
    }
    state = state.copyWith(loadingSuggestions: true);

    if (!await ref.read(connectivityMonitorProvider).isOnline()) {
      state = state.copyWith(loadingSuggestions: false, suggestions: null);
      return;
    }

    try {
      final suggestions =
          await ref.read(foodsRepositoryProvider).fetchSuggestions();
      state = state.copyWith(
        loadingSuggestions: false,
        suggestions: suggestions,
      );
    } on Object {
      // Incluye CauceApiError y cualquier otra falla: en todos los casos la
      // accion util es la misma, seguir sin la seccion.
      state = state.copyWith(loadingSuggestions: false, suggestions: null);
    }
  }

  /// Busca en la caja local con lo que el paciente escribio.
  Future<void> search(String query) async {
    state = state.copyWith(query: query);

    if (query.trim().isEmpty) {
      state = state.copyWith(results: const <FoodItem>[]);
      return;
    }

    final results = await ref.read(foodCatalogStoreProvider).search(query);

    // La consulta pudo cambiar mientras la base respondia. Publicar un
    // resultado viejo mostraria coincidencias de un texto que ya no esta.
    if (state.query != query) {
      return;
    }
    state = state.copyWith(results: results);
  }

  /// Completa la composicion nutricional de un alimento elegido.
  ///
  /// Se pide una vez, cuando el paciente lo selecciona, y queda guardada en la
  /// caja: asi HU0010 estima el perfil del plato con lo que ya tiene. Sin
  /// conexion devuelve lo que haya en la caja, que puede no tener nutricion.
  Future<FoodItem> resolveDetail(FoodItem item) async {
    if (item.hasNutrition) {
      return item;
    }

    final store = ref.read(foodCatalogStoreProvider);
    final cached = await store.findById(item.foodId);
    if (cached != null && cached.hasNutrition) {
      return cached;
    }

    try {
      final detail =
          await ref.read(foodsRepositoryProvider).fetchDetail(item.foodId);
      await store.upsertDetail(detail);
      return detail;
    } on Object {
      // Sin detalle el alimento se registra igual: la composicion es para la
      // vista previa de HU0010, no un requisito para anotar una comida.
      return item;
    }
  }
}
