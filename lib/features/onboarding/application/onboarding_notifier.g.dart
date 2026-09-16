// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'onboarding_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$resolvedOnboardingHash() =>
    r'90c08c4a70d21efc651087f8d204c1de11fc1386';

/// Estado del onboarding ya resuelto, listo para el guard del router.
///
/// El guard necesita un valor sincronico y no un `AsyncValue`: se evalua en
/// cada navegacion y no puede esperar. Mientras la consulta esta en vuelo, o
/// si fallo, devuelve [OnboardingUnavailable], que se traduce en "no
/// redirigir".
///
/// Copied from [resolvedOnboarding].
@ProviderFor(resolvedOnboarding)
final resolvedOnboardingProvider = Provider<OnboardingState>.internal(
  resolvedOnboarding,
  name: r'resolvedOnboardingProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$resolvedOnboardingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ResolvedOnboardingRef = ProviderRef<OnboardingState>;
String _$onboardingNotifierHash() =>
    r'0150a8c275c97f157a45369a91f2f400d2cb17ec';

/// Resuelve y gobierna el estado del onboarding clinico.
///
/// `keepAlive` porque el guard del router lo consulta en cada navegacion y
/// recalcularlo por pantalla dispararia una peticion de mas cada vez.
///
/// Observa la sesion en vez de exponer un bootstrap que alguien deba invocar:
/// cuando el paciente entra, el estado se resuelve solo, y cuando cierra
/// sesion se descarta. Un login nuevo vuelve a preguntarle al servidor, que es
/// lo que hace que aplazar no sobreviva al cambio de cuenta.
///
/// Copied from [OnboardingNotifier].
@ProviderFor(OnboardingNotifier)
final onboardingNotifierProvider =
    AsyncNotifierProvider<OnboardingNotifier, OnboardingState>.internal(
  OnboardingNotifier.new,
  name: r'onboardingNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$onboardingNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OnboardingNotifier = AsyncNotifier<OnboardingState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
