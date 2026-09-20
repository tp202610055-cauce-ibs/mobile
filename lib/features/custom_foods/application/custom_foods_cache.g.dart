// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_foods_cache.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$customFoodsCacheHash() => r'b1306fd14a538a38c6b6416292cb518cccf74167';

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
///
/// Copied from [CustomFoodsCache].
@ProviderFor(CustomFoodsCache)
final customFoodsCacheProvider =
    NotifierProvider<CustomFoodsCache, CustomFoodsCacheState>.internal(
  CustomFoodsCache.new,
  name: r'customFoodsCacheProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$customFoodsCacheHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CustomFoodsCache = Notifier<CustomFoodsCacheState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
