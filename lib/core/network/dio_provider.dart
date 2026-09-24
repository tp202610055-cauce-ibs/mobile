import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../auth/token_storage.dart';
import '../auth/token_storage_provider.dart';
import '../config/env.dart';
import 'auth_interceptor.dart';
import 'refresh_interceptor.dart';

part 'dio_provider.g.dart';

/// Cliente HTTP compartido, con la cadena de interceptors montada.
///
/// El orden importa. `AuthInterceptor` corre en `onRequest` y agrega el
/// Bearer. `RefreshInterceptor` corre en `onError` y renueva. `LogInterceptor`
/// va ultimo y solo en dev, porque vuelca cuerpos completos y en el piloto eso
/// serian datos clinicos del paciente en el log.
@Riverpod(keepAlive: true)
Dio dio(Ref ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return buildDio(tokenStorage: tokenStorage, baseUrl: Env.apiBaseUrl);
}

/// Construye el [Dio] de la aplicacion.
///
/// Se expone aparte del provider para que los tests puedan armarlo con un
/// [TokenStorage] falso y un adapter de prueba, sin levantar un
/// `ProviderContainer` ni depender de `Env`.
Dio buildDio({
  required TokenStorage tokenStorage,
  required String baseUrl,
  bool enableLogging = false,
  Dio? refreshClient,
}) {
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      contentType: Headers.jsonContentType,
      // El backend responde application/problem+json en los errores. Sin esto
      // dio entrega el cuerpo como String y el ErrorMapper no encuentra nada.
      responseType: ResponseType.json,
    ),
  );

  dio.interceptors.addAll(<Interceptor>[
    AuthInterceptor(tokenStorage),
    RefreshInterceptor(
      tokenStorage: tokenStorage,
      retryClient: dio,
      baseUrl: baseUrl,
      refreshClient: refreshClient,
    ),
    if (enableLogging)
      LogInterceptor(requestBody: true, responseBody: true, error: true),
  ]);

  return dio;
}

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
@Riverpod(keepAlive: true)
CauceApiClient apiClient(Ref ref) {
  return CauceApiClient(
    dio: ref.watch(dioProvider),
    interceptors: const <Interceptor>[],
  );
}

/// Endpoints de identidad: login, register, refresh, logout y recuperacion.
@Riverpod(keepAlive: true)
AuthApi authApi(Ref ref) => ref.watch(apiClientProvider).getAuthApi();

/// Endpoint del consentimiento informado vigente.
@Riverpod(keepAlive: true)
ConsentApi consentApi(Ref ref) => ref.watch(apiClientProvider).getConsentApi();

/// Endpoints del paciente autenticado. Todos exigen la politica `Patient`.
@Riverpod(keepAlive: true)
PatientsApi patientsApi(Ref ref) =>
    ref.watch(apiClientProvider).getPatientsApi();

/// Catalogo cerrado de alergias e intolerancias.
///
/// Vive en su propio tag del contrato (`GET /api/v1/allergies`) y no bajo
/// `/patients`, porque el backend lo expone a cualquier autenticado y no solo
/// a la politica `Patient`: el nutricionista tambien lo consulta.
@Riverpod(keepAlive: true)
AllergiesApi allergiesApi(Ref ref) =>
    ref.watch(apiClientProvider).getAllergiesApi();

/// Evaluaciones IBS-SSS. Politica `Patient` y rate limit `default-auth`.
@Riverpod(keepAlive: true)
IbsSssApi ibsSssApi(Ref ref) => ref.watch(apiClientProvider).getIbsSssApi();

// ---------------------------------------------------------------------------
// Modulo ClinicalRegistry (EP0002). Agregados en Mobile-3.
//
// `HistoryApi` sigue sin provider. Antes del contrato v1.3.0 `GET /history`
// era inutilizable porque aplanaba su jerarquia polimorfica a `{occurredAt}`;
// desde la regeneracion de Mobile-4 Bloque 1 declara `oneOf` con los tres
// eventos concretos, asi que ese motivo ya no aplica. El historial se sigue
// componiendo desde `/meals`, `/symptoms` y `/clinical-notes` hasta que un
// bloque propio decida migrarlo (acta M36).
// ---------------------------------------------------------------------------

/// Glosario clinico-nutricional (HU0027). Mobile-4 Bloque 5.
///
/// Accesible para cualquier autenticado; la definicion que devuelve depende
/// del rol del JWT, de modo que el paciente recibe la redactada para el.
/// Solo se usa `GET /glossary`: la busqueda se resuelve en el cliente.
@Riverpod(keepAlive: true)
GlossaryApi glossaryApi(Ref ref) =>
    ref.watch(apiClientProvider).getGlossaryApi();

/// Catalogo de alimentos: listado, busqueda, detalle y sugerencias.
///
/// Los tres primeros los expone el backend a cualquier autenticado; solo
/// `GET /foods/suggestions` exige la politica `Patient`.
@Riverpod(keepAlive: true)
FoodsApi foodsApi(Ref ref) => ref.watch(apiClientProvider).getFoodsApi();

/// Platos personalizados del paciente (US10). CRUD completo.
@Riverpod(keepAlive: true)
CustomFoodsApi customFoodsApi(Ref ref) =>
    ref.watch(apiClientProvider).getCustomFoodsApi();

/// Registro e historial de comidas (US09).
@Riverpod(keepAlive: true)
MealsApi mealsApi(Ref ref) => ref.watch(apiClientProvider).getMealsApi();

/// Registro e historial de sintomas (US11).
@Riverpod(keepAlive: true)
SymptomsApi symptomsApi(Ref ref) =>
    ref.watch(apiClientProvider).getSymptomsApi();

/// Notas de contexto sobre una comida o un sintoma (US13).
@Riverpod(keepAlive: true)
ClinicalNotesApi clinicalNotesApi(Ref ref) =>
    ref.watch(apiClientProvider).getClinicalNotesApi();

/// Sincronizacion por lote de lo registrado sin conexion (TS06).
///
/// Unico endpoint del cliente con rate limit `sync` (120/min por usuario) en
/// vez de `default-auth`.
@Riverpod(keepAlive: true)
SyncApi syncApi(Ref ref) => ref.watch(apiClientProvider).getSyncApi();
