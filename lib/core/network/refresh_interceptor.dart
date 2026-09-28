import 'dart:async';

import 'package:cauce_api_client/cauce_api_client.dart'
    show AuthenticatedUser, standardSerializers;
import 'package:dio/dio.dart';

import '../auth/authenticated_user_snapshot.dart';
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
///    un paciente sin motivo. La renovacion en vuelo se comparte: la primera
///    renueva y las demas esperan su resultado, que llega como valor tambien
///    cuando falla (ver `_refreshSession`).
/// 3. **Sin recursion.** El refresh usa un [Dio] propio, sin interceptors, y
///    la peticion reintentada se marca para no volver a entrar aqui.
class RefreshInterceptor extends Interceptor {
  RefreshInterceptor({
    required TokenStorage tokenStorage,
    required Dio retryClient,
    required String baseUrl,
    Dio? refreshClient,
    void Function()? onSessionExpired,
  })  : _tokenStorage = tokenStorage,
        _retryClient = retryClient,
        _refreshClient = refreshClient ?? Dio(BaseOptions(baseUrl: baseUrl)),
        _onSessionExpired = onSessionExpired,
        _clientId = const String.fromEnvironment(
          'CLIENT_ID',
          defaultValue: 'cauce-mobile',
        );

  final TokenStorage _tokenStorage;

  /// Aviso de que la sesion termino, para que la app vuelva al login (acta
  /// M49). Se invoca una vez por renovacion fallida, despues de borrar el
  /// almacenamiento.
  final void Function()? _onSessionExpired;

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

  /// Renovacion en curso, compartida por las peticiones que la esperan.
  Future<_RefreshOutcome>? _inFlight;

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
      // interceptor. La vuelta al login no depende de que alguien la atrape:
      // `_endSession` ya levanto el aviso de sesion vencida (acta M49).
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
  /// Las llamadas concurrentes comparten la misma renovacion, de modo que
  /// solo la primera golpea la red.
  ///
  /// **La renovacion compartida siempre termina con un valor, nunca con un
  /// error** ([_RefreshOutcome]). Dio corre cada interceptor en su propia
  /// zona, y en Dart un error de `Future` no cruza de una zona de errores a
  /// otra: cuando la renovacion fallaba, las peticiones que la esperaban
  /// desde otra zona nunca recibian la falla, quedaban colgadas, y el error
  /// salia como no atrapado. Lo encontro el recorrido en el celular al
  /// cerrar sesion con tres detalles de Consejos en vuelo (acta M49). Cada
  /// peticion relanza la falla en su propia zona, donde `onError` la atrapa.
  Future<String> _refreshSession() async {
    final outcome = await (_inFlight ??= _startRefresh());
    final token = outcome.token;
    if (token != null) {
      return token;
    }
    Error.throwWithStackTrace(outcome.error!, outcome.stackTrace!);
  }

  Future<_RefreshOutcome> _startRefresh() {
    return _performRefresh()
        .then<_RefreshOutcome>(
          (token) => (token: token, error: null, stackTrace: null),
          onError: (Object error, StackTrace stackTrace) =>
              (token: null, error: error, stackTrace: stackTrace),
        )
        .whenComplete(() => _inFlight = null);
  }

  Future<String> _performRefresh() async {
    final refreshToken = await _tokenStorage.readRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      return _endSession();
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
        return _endSession();
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
      return _endSession();
    }

    // CP067 (acta M49): la respuesta trae el `user` vigente, y un dato como
    // `isInActivePilot` puede haber cambiado desde el login. Se guarda en el
    // almacenamiento seguro y **no se publica en memoria**: `SessionNotifier`
    // avisa por identidad, y un estado nuevo cada 15 minutos reconstruiria el
    // router y relanzaria el onboarding. Quien necesite el dato fresco lo lee
    // del almacenamiento, como la baja de cuenta.
    final user = _userFrom(body['user']);
    if (user == null) {
      await _tokenStorage.saveTokens(
        accessToken: accessToken,
        refreshToken: rotatedRefreshToken,
      );
    } else {
      await _tokenStorage.saveSession(
        accessToken: accessToken,
        refreshToken: rotatedRefreshToken,
        user: user,
      );
    }

    return accessToken;
  }

  /// Snapshot del usuario que trae la renovacion, o `null` si falta o no se
  /// puede leer.
  ///
  /// **Nunca lanza.** Los tokens nuevos son validos aunque el `user` venga
  /// roto, y el refresh anterior ya quedo invalidado por la rotacion: cerrar
  /// la sesion por esto seria sacar al paciente sin motivo. Se conserva el
  /// snapshot que habia.
  AuthenticatedUserSnapshot? _userFrom(Object? raw) {
    if (raw is! Map<String, dynamic>) {
      return null;
    }
    try {
      final user = standardSerializers.deserializeWith(
        AuthenticatedUser.serializer,
        raw,
      );
      return user == null ? null : AuthenticatedUserSnapshot.fromApi(user);
    } on Object {
      // FormatException de `fromApi` si falta un campo, o el error de
      // built_value si un tipo no coincide. Los dos significan lo mismo aca.
      return null;
    }
  }

  /// Cierra la sesion que ya no se puede renovar.
  ///
  /// Borra las tres keys, avisa para que la app vuelva al login (acta M49) y
  /// lanza [SessionExpiredException], que `onError` convierte en la falla de
  /// la peticion original. El aviso va despues del borrado: quien lo escuche
  /// ya encuentra el almacenamiento vacio.
  Future<Never> _endSession() async {
    await _tokenStorage.clearSession();
    _onSessionExpired?.call();
    throw const SessionExpiredException();
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

/// Resultado de una renovacion: el access token nuevo, o la falla con su
/// traza. Viaja como valor entre zonas; ver [RefreshInterceptor]
/// `_refreshSession`.
typedef _RefreshOutcome = ({
  String? token,
  Object? error,
  StackTrace? stackTrace,
});
