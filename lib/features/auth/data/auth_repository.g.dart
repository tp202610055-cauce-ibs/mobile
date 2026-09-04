// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$authRepositoryHash() => r'95c34edb99c0fe1ddc73c5f08540a3a7c327e1bd';

/// See also [authRepository].
@ProviderFor(authRepository)
final authRepositoryProvider = Provider<AuthRepository>.internal(
  authRepository,
  name: r'authRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthRepositoryRef = ProviderRef<AuthRepository>;
String _$currentConsentHash() => r'38093429b702bd862c0b5966849a51af6809d46a';

/// Consentimiento vigente, cacheado mientras la pantalla de registro viva.
///
/// Se declara como provider aparte y no se lee dentro del notifier para que la
/// pantalla pueda mostrar carga, error y reintento con `AsyncValue`, sin
/// mezclar ese ciclo con el del envio del formulario.
///
/// Copied from [currentConsent].
@ProviderFor(currentConsent)
final currentConsentProvider =
    AutoDisposeFutureProvider<CurrentConsent>.internal(
  currentConsent,
  name: r'currentConsentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentConsentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentConsentRef = AutoDisposeFutureProviderRef<CurrentConsent>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
