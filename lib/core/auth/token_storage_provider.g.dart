// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tokenStorageHash() => r'5ca88e5887315ffd57da573d48b16fca530e7df0';

/// Almacenamiento seguro de la sesion.
///
/// La implementacion concreta `SecureTokenStorage` llega en la Fase 4, junto
/// con `flutter_secure_storage` y las tres keys del acta M11. Hasta entonces
/// el provider falla de forma explicita en vez de devolver un doble vacio, que
/// simularia una sesion inexistente y haria pasar tests que no deberian pasar.
///
/// Los tests sobrescriben este provider con un `TokenStorage` de prueba.
///
/// Copied from [tokenStorage].
@ProviderFor(tokenStorage)
final tokenStorageProvider = Provider<TokenStorage>.internal(
  tokenStorage,
  name: r'tokenStorageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tokenStorageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef TokenStorageRef = ProviderRef<TokenStorage>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
