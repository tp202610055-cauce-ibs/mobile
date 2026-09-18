import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/food_catalog_store.dart';
import '../data/foods_repository.dart';

part 'food_catalog_refresher.g.dart';

/// Resultado de un intento de refresco del catalogo.
enum FoodCatalogRefreshOutcome {
  /// La caja quedo sincronizada con el servidor.
  updated,

  /// El servidor no respondio o fallo. **La caja anterior queda intacta**: es
  /// preferible buscar sobre un catalogo viejo que sobre uno vacio.
  failed,

  /// El servidor respondio con un catalogo vacio.
  ///
  /// No se aplica: vaciar la caja por una respuesta anomala dejaria al paciente
  /// sin poder registrar nada sin conexion, que es exactamente lo que CP023
  /// exige que funcione.
  rejectedEmpty,
}

/// Mantiene la copia local del catalogo al dia.
///
/// Se dispara al abrir sesion y al recuperar conexion. Es deliberadamente
/// tolerante a fallos: refrescar es una mejora, no un requisito, y un catalogo
/// desactualizado sirve mucho mas que ninguno.
class FoodCatalogRefresher {
  const FoodCatalogRefresher(this._repository, this._store);

  final FoodsRepository _repository;
  final FoodCatalogStore _store;

  /// Trae el catalogo del servidor y reemplaza la caja local.
  ///
  /// Nunca lanza: la unica accion util ante un fallo es seguir con lo que ya
  /// habia, y hacer que el arranque de sesion dependa de esto dejaria al
  /// paciente sin app por un catalogo.
  Future<FoodCatalogRefreshOutcome> refresh() async {
    try {
      final items = await _repository.fetchCatalog();

      if (items.isEmpty) {
        // Un catalogo vacio solo puede venir de una base recien creada o de una
        // respuesta anomala. En los dos casos conservar lo que hay es mejor.
        return FoodCatalogRefreshOutcome.rejectedEmpty;
      }

      await _store.replaceAll(items);
      return FoodCatalogRefreshOutcome.updated;
    } on CauceApiError {
      return FoodCatalogRefreshOutcome.failed;
    }
  }

  /// Refresca solo si la caja esta vacia.
  ///
  /// Es el caso de la primera sesion en el dispositivo, donde sin catalogo la
  /// busqueda no devuelve nada y el paciente no puede registrar una comida.
  Future<FoodCatalogRefreshOutcome?> refreshIfEmpty() async {
    if (await _store.count() > 0) {
      return null;
    }
    return refresh();
  }
}

@Riverpod(keepAlive: true)
FoodCatalogRefresher foodCatalogRefresher(Ref ref) {
  return FoodCatalogRefresher(
    ref.watch(foodsRepositoryProvider),
    ref.watch(foodCatalogStoreProvider),
  );
}
