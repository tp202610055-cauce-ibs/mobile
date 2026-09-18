// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_search_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$foodSearchNotifierHash() =>
    r'b80f065962a02d89b2203d5e63d555886c9254ad';

/// Gobierna la busqueda de alimentos del modal de registro.
///
/// **La busqueda por texto es siempre local**, contra `food_catalog_cache`, y
/// nunca contra `GET /foods/search`. CP023 registra una comida en modo avion,
/// asi que el catalogo tiene que ser buscable sin red. De paso queda inmune a
/// que el servidor no sea insensible a tildes, que no lo es.
///
/// Las sugerencias si son del servidor y solo estan con conexion: sin red la
/// seccion se oculta, sin error, y la busqueda por texto sigue disponible.
///
/// Copied from [FoodSearchNotifier].
@ProviderFor(FoodSearchNotifier)
final foodSearchNotifierProvider =
    AutoDisposeNotifierProvider<FoodSearchNotifier, FoodSearchState>.internal(
  FoodSearchNotifier.new,
  name: r'foodSearchNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$foodSearchNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FoodSearchNotifier = AutoDisposeNotifier<FoodSearchState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
