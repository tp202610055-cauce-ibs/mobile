// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dioHash() => r'8136d5490eac431fdde5067f4c29deb8a5b06c24';

/// Cliente HTTP compartido, con la cadena de interceptors montada.
///
/// El orden importa. `AuthInterceptor` corre en `onRequest` y agrega el
/// Bearer. `RefreshInterceptor` corre en `onError` y renueva. `LogInterceptor`
/// va ultimo y solo en dev, porque vuelca cuerpos completos y en el piloto eso
/// serian datos clinicos del paciente en el log.
///
/// Copied from [dio].
@ProviderFor(dio)
final dioProvider = Provider<Dio>.internal(
  dio,
  name: r'dioProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$dioHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DioRef = ProviderRef<Dio>;
String _$apiClientHash() => r'3238d5400d9095a866194e4d83cfc7952f5d58fb';

/// Cliente OpenAPI tipado, montado sobre el [Dio] compartido.
///
/// Se construye con `dio:` y no dejando que el package arme el suyo, para que
/// las llamadas generadas hereden interceptors, timeouts y base URL.
///
/// `interceptors: []` es deliberado y no un descuido. Si se omite, el
/// constructor generado inyecta sus cuatro interceptors de autenticacion
/// (OAuth, Basic, Bearer, ApiKey) en el Dio compartido. El Bearer lo resuelve
/// [AuthInterceptor], que ademas respeta la allowlist de rutas anonimas; el
/// del generador lo adjuntaria tambien al login. Los metodos generados marcan
/// `extra['secure']`, que sin esos interceptors simplemente se ignora.
///
/// Copied from [apiClient].
@ProviderFor(apiClient)
final apiClientProvider = Provider<CauceApiClient>.internal(
  apiClient,
  name: r'apiClientProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$apiClientHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ApiClientRef = ProviderRef<CauceApiClient>;
String _$authApiHash() => r'1b641803685319d7d51f589590640dc775007913';

/// Endpoints de identidad: login, register, refresh, logout y recuperacion.
///
/// Copied from [authApi].
@ProviderFor(authApi)
final authApiProvider = Provider<AuthApi>.internal(
  authApi,
  name: r'authApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$authApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AuthApiRef = ProviderRef<AuthApi>;
String _$consentApiHash() => r'17fb3e74a84951cdf936c7c20cc3141fa948f114';

/// Endpoint del consentimiento informado vigente.
///
/// Copied from [consentApi].
@ProviderFor(consentApi)
final consentApiProvider = Provider<ConsentApi>.internal(
  consentApi,
  name: r'consentApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$consentApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConsentApiRef = ProviderRef<ConsentApi>;
String _$patientsApiHash() => r'71e40f889276b1df18de1f63993408e2326098b5';

/// Endpoints del paciente autenticado. Todos exigen la politica `Patient`.
///
/// Copied from [patientsApi].
@ProviderFor(patientsApi)
final patientsApiProvider = Provider<PatientsApi>.internal(
  patientsApi,
  name: r'patientsApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$patientsApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PatientsApiRef = ProviderRef<PatientsApi>;
String _$allergiesApiHash() => r'e8c668b5af8f1fc73808f8bec359aab1b8c1924e';

/// Catalogo cerrado de alergias e intolerancias.
///
/// Vive en su propio tag del contrato (`GET /api/v1/allergies`) y no bajo
/// `/patients`, porque el backend lo expone a cualquier autenticado y no solo
/// a la politica `Patient`: el nutricionista tambien lo consulta.
///
/// Copied from [allergiesApi].
@ProviderFor(allergiesApi)
final allergiesApiProvider = Provider<AllergiesApi>.internal(
  allergiesApi,
  name: r'allergiesApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allergiesApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef AllergiesApiRef = ProviderRef<AllergiesApi>;
String _$ibsSssApiHash() => r'112a54c5d67678e218d84b23544a9a88fa2a6ebc';

/// Evaluaciones IBS-SSS. Politica `Patient` y rate limit `default-auth`.
///
/// Copied from [ibsSssApi].
@ProviderFor(ibsSssApi)
final ibsSssApiProvider = Provider<IbsSssApi>.internal(
  ibsSssApi,
  name: r'ibsSssApiProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$ibsSssApiHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IbsSssApiRef = ProviderRef<IbsSssApi>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
