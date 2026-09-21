// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'background_services.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$backgroundServicesHash() =>
    r'3cf6728fd4529313bf0594d2821c15d3b6d76012';

/// See also [backgroundServices].
@ProviderFor(backgroundServices)
final backgroundServicesProvider = Provider<BackgroundServices>.internal(
  backgroundServices,
  name: r'backgroundServicesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$backgroundServicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef BackgroundServicesRef = ProviderRef<BackgroundServices>;
String _$sessionBackgroundServicesHash() =>
    r'23ba1727d63e4d446e587a62c0d14f89e1508d12';

/// Ata el ciclo de vida de los servicios al de la sesión.
///
/// **Alguien tiene que leer esto o no pasa nada**, que es exactamente el error
/// que corrige el bloque. Lo lee `CauceApp`, de modo que vive tanto como la
/// aplicación y reacciona a cada transición de sesión.
///
/// Copied from [sessionBackgroundServices].
@ProviderFor(sessionBackgroundServices)
final sessionBackgroundServicesProvider = Provider<BackgroundServices>.internal(
  sessionBackgroundServices,
  name: r'sessionBackgroundServicesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionBackgroundServicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SessionBackgroundServicesRef = ProviderRef<BackgroundServices>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
