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
