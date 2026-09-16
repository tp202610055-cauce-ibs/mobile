// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientsRepositoryHash() =>
    r'9adf4d68ae14f6aa7764d323780b5d7b226151e0';

/// See also [patientsRepository].
@ProviderFor(patientsRepository)
final patientsRepositoryProvider = Provider<PatientsRepository>.internal(
  patientsRepository,
  name: r'patientsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PatientsRepositoryRef = ProviderRef<PatientsRepository>;
String _$allergyCatalogHash() => r'ca47c3e005d1140e2367509ffb3ad13957ea3b58';

/// Catalogo de alergias, cacheado mientras el formulario de perfil viva.
///
/// Provider aparte y no una lectura dentro del notifier, igual que
/// `currentConsentProvider`: asi la pantalla resuelve carga, error y reintento
/// con `AsyncValue` sin mezclar ese ciclo con el del envio del formulario.
///
/// Sin `keepAlive`: el catalogo se consulta una vez en todo el onboarding y
/// mantenerlo vivo despues solo retendria memoria.
///
/// Copied from [allergyCatalog].
@ProviderFor(allergyCatalog)
final allergyCatalogProvider =
    AutoDisposeFutureProvider<List<AllergyCatalogEntry>>.internal(
  allergyCatalog,
  name: r'allergyCatalogProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allergyCatalogHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllergyCatalogRef
    = AutoDisposeFutureProviderRef<List<AllergyCatalogEntry>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
