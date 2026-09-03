// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token_storage_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tokenStorageHash() => r'5dd28fa41aa81d4f4f8bfa5784f96a852ab66074';

/// Almacenamiento seguro de la sesion.
///
/// `keepAlive` porque la sesion es estado de aplicacion, no de pantalla:
/// descartarla al desmontarse el ultimo consumidor obligaria a releer del
/// Keystore en cada navegacion.
///
/// Los tests lo sobrescriben con un `TokenStorage` en memoria; el plugin real
/// habla por canal de plataforma y no existe en la VM del host.
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
