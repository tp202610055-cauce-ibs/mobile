import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/sync/connectivity_monitor.dart';
import '../data/custom_foods_repository.dart';
import '../domain/custom_food.dart';

part 'custom_foods_cache.freezed.dart';
part 'custom_foods_cache.g.dart';

/// Ultima lista conocida de platos personalizados del paciente.
@freezed
abstract class CustomFoodsCacheState with _$CustomFoodsCacheState {
  const factory CustomFoodsCacheState({
    @Default(<CustomFoodRecord>[]) List<CustomFoodRecord> items,

    /// `true` cuando el ultimo intento de traerlos no prospero.
    @Default(false) bool stale,
  }) = _CustomFoodsCacheState;

  const CustomFoodsCacheState._();

  /// `true` si no hay nada que mostrar y el ultimo intento fallo.
  ///
  /// Es el caso en que corresponde avisar que los platos propios necesitan
  /// conexion, en vez de dejar la seccion en blanco como si no existieran.
  bool get unavailable => items.isEmpty && stale;
}

/// Platos personalizados del paciente, sostenidos durante la sesion.
///
/// `keepAlive` a proposito. `GET /custom-foods` es online only, y el buscador
/// de alimentos se abre y se cierra en cada ingrediente: sin esto, entrar al
/// tunel a mitad de un registro haria desaparecer los platos propios que el
/// paciente acababa de ver.
///
/// **No es persistencia.** Vive en memoria y se pierde al cerrar la app. Una
/// tabla local para platos personalizados queda anotada como deuda; con el
/// esquema v2 recien estrenado no corresponde sumar una migracion por esto.
@Riverpod(keepAlive: true)
class CustomFoodsCache extends _$CustomFoodsCache {
  @override
  CustomFoodsCacheState build() => const CustomFoodsCacheState();

  /// Vuelve a pedir la lista. Un fallo conserva lo que ya se tenia.
  Future<void> refresh() async {
    if (!await ref.read(connectivityMonitorProvider).isOnline()) {
      state = state.copyWith(stale: true);
      return;
    }

    try {
      final items = await ref.read(customFoodsRepositoryProvider).list();
      state = CustomFoodsCacheState(items: items);
    } on Object {
      // Igual que las sugerencias del buscador: un fallo no es un error del
      // paciente, y la accion util es seguir con lo que haya.
      state = state.copyWith(stale: true);
    }
  }

  /// Suma un plato recien creado, sin esperar a un refresco.
  ///
  /// Es lo que hace que CP025 paso 10 funcione al instante: el paciente crea
  /// el plato y lo encuentra en la busqueda sin volver a salir a la red.
  void remember(CustomFoodRecord record) {
    if (state.items.any((item) => item.customFoodId == record.customFoodId)) {
      return;
    }
    state = state.copyWith(
      items: <CustomFoodRecord>[record, ...state.items],
      stale: false,
    );
  }
}
