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
String _$patientProfileHash() => r'0fcadbdb46634f50b40ffc5b44bbba7915765d1a';

/// Perfil clinico del paciente, para la pantalla de perfil.
///
/// Devuelve `null` si todavia no lo creo, que es como el repositorio traduce
/// el 404. La pantalla lo trata como "sin datos clinicos que mostrar" y sigue
/// ofreciendo la seccion de privacidad, que no depende del perfil.
///
/// Sin `keepAlive`: el perfil puede cambiar desde la consulta con el
/// nutricionista, y recargarlo al entrar cuesta una peticion.
///
/// Copied from [patientProfile].
@ProviderFor(patientProfile)
final patientProfileProvider =
    AutoDisposeFutureProvider<PatientProfile?>.internal(
  patientProfile,
  name: r'patientProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PatientProfileRef = AutoDisposeFutureProviderRef<PatientProfile?>;
String _$patientSummaryHash() => r'ff06819dafd1e00035b860b7f2056124c3ab9023';

/// Resumen del paciente, para la pantalla de Perfil (HU0023).
///
/// Sin `keepAlive`, por lo mismo que [patientProfile]: los puntajes cambian
/// cada vez que el paciente responde el cuestionario, y el nutricionista puede
/// asignarse desde la consulta. Recargarlo al entrar cuesta una peticion.
///
/// Copied from [patientSummary].
@ProviderFor(patientSummary)
final patientSummaryProvider =
    AutoDisposeFutureProvider<PatientSummary>.internal(
  patientSummary,
  name: r'patientSummaryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$patientSummaryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PatientSummaryRef = AutoDisposeFutureProviderRef<PatientSummary>;
String _$acceptedConsentHash() => r'7369864d07a2b8fcd6569e8abc5eabcfb3f72555';

/// Consentimiento aceptado por el paciente, para la seccion de privacidad.
///
/// Copied from [acceptedConsent].
@ProviderFor(acceptedConsent)
final acceptedConsentProvider =
    AutoDisposeFutureProvider<AcceptedConsent>.internal(
  acceptedConsent,
  name: r'acceptedConsentProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$acceptedConsentHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AcceptedConsentRef = AutoDisposeFutureProviderRef<AcceptedConsent>;
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
