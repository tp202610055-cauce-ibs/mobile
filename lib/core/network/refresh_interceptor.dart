import 'dart:async';

import 'package:dio/dio.dart';

import '../auth/token_storage.dart';
import '../errors/session_expired_exception.dart';
import 'auth_interceptor.dart';

/// Renueva la sesion de forma silenciosa cuando el access token vence.
///
/// Tres responsabilidades que conviene no perder de vista:
///
/// 1. **Rotacion obligatoria.** El realm tiene `revokeRefreshToken: true` y
///    `refreshTokenMaxReuse: 0`, de modo que cada renovacion invalida el
///    refresh anterior. Persistir el par nuevo no es opcional: reintentar con
///    el viejo devuelve 401 `invalid_refresh_token`.
/// 2. **Un solo refresh en vuelo.** Si tres peticiones fallan con 401 a la vez
///    y cada una dispara su propio refresh, la primera rota el token y deja a
///    las otras dos con uno ya invalidado, que es como se cierra la sesion de
///    un paciente sin motivo. El [Completer] serializa: la primera renueva y
///    las demas esperan su resultado.
/// 3. **Sin recursion.** El refresh usa un [Dio] propio, sin interceptors, y
///    la peticion reintentada se marca para no volver a entrar aqui.
class RefreshInterceptor extends Interceptor {
  RefreshInterceptor({
    required TokenStorage tokenStorage,
    required Dio retryClient,
    required String baseUrl,
    Dio? refreshClient,
  })  : _tokenStorage = tokenStorage,
        _retryClient = retryClient,
        _refreshClient = refreshClient ?? Dio(BaseOptions(baseUrl: baseUrl)),
        _clientId = const String.fromEnvironment(
          'CLIENT_ID',
          defaultValue: 'cauce-mobile',
        );

  final TokenStorage _tokenStorage;

  /// Cliente con los interceptors montados, para reemitir la peticion original.
  final Dio _retryClient;

  /// Cliente desnudo. Si el refresh pasara por los interceptors, un 401 de la
  /// propia renovacion volveria a entrar aqui en bucle.
  final Dio _refreshClient;

  final String _clientId;

  /// Marca que lleva una peticion ya reintentada, para no reintentarla dos
  /// veces si el backend responde 401 de nuevo.
  static const String _retriedFlag = 'cauce_retried_after_refresh';

  static const String refreshPath = '/api/v1/auth/refresh';

  Completer<String>? _inFlight;

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (!_shouldAttemptRefresh(err)) {
      return handler.next(err);
    }

    final String accessToken;
    try {
      accessToken = await _refreshSession();
    } on SessionExpiredException catch (error, stackTrace) {
      // Se propaga como DioException para respetar el contrato del
      // interceptor. El `error` interno conserva el tipo del dominio, que es
      // lo que el guard de sesion inspecciona.
      return handler.next(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          type: DioExceptionType.unknown,
          error: error,
          stackTrace: stackTrace,
        ),
      );
    }

    try {
      final response = await _retry(err.requestOptions, accessToken);
      return handler.resolve(response);
    } on DioException catch (retryError) {
      return handler.next(retryError);
    }
  }

  bool _shouldAttemptRefresh(DioException err) {
    if (err.response?.statusCode != 401) {
      return false;
    }
    final options = err.requestOptions;
    if (AuthInterceptor.isAnonymous(options.path)) {
      return false;
    }
    if (options.extra[_retriedFlag] == true) {
      return false;
    }
    return true;
  }

  /// Devuelve el access token vigente, renovando si hace falta.
  ///
  /// Las llamadas concurrentes comparten el mismo [Completer], de modo que
  /// solo la primera golpea la red.
  Future<String> _refreshSession() {
    final pending = _inFlight;
    if (pending != null) {
      return pending.future;
    }

    final completer = Completer<String>();
    _inFlight = completer;

    unawaited(
      _performRefresh()
          .then(completer.complete)
          .catchError((Object error, StackTrace stackTrace) {
        completer.completeError(error, stackTrace);
      }).whenComplete(() {
        _inFlight = null;
      }),
    );

    return completer.future;
  }

  Future<String> _performRefresh() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      await _tokenStorage.clearSession();
      throw const SessionExpiredException();
    }

    final Response<Map<String, dynamic>> response;
    try {
      response = await _refreshClient.post<Map<String, dynamic>>(
        refreshPath,
        data: <String, dynamic>{
          'refreshToken': refreshToken,
          'clientId': _clientId,
        },
      );
    } on DioException catch (error) {
      // 400 y 401 significan que este refresh ya no sirve. Un 429 o un 500 son
      // transitorios: se propagan sin borrar la sesion, porque cerrarla por un
      // rate limit dejaria al paciente fuera de la app sin motivo real.
      final status = error.response?.statusCode;
      if (status == 400 || status == 401) {
        await _tokenStorage.clearSession();
        throw const SessionExpiredException();
      }
      rethrow;
    }

    final body = response.data ?? const <String, dynamic>{};
    final accessToken = body['accessToken'];
    final rotatedRefreshToken = body['refreshToken'];

    if (accessToken is! String ||
        accessToken.isEmpty ||
        rotatedRefreshToken is! String ||
        rotatedRefreshToken.isEmpty) {
      await _tokenStorage.clearSession();
      throw const SessionExpiredException();
    }

    await _tokenStorage.saveTokens(
      accessToken: accessToken,
      refreshToken: rotatedRefreshToken,
    );

    return accessToken;
  }

  Future<Response<dynamic>> _retry(
    RequestOptions options,
    String accessToken,
  ) {
    return _retryClient.fetch<dynamic>(
      options.copyWith(
        headers: <String, dynamic>{
          ...options.headers,
          'Authorization': 'Bearer $accessToken',
        },
        extra: <String, dynamic>{...options.extra, _retriedFlag: true},
      ),
    );
  }
}
