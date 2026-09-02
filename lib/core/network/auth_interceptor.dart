import 'package:dio/dio.dart';

import '../auth/token_storage.dart';

/// Adjunta el `Authorization: Bearer` a las peticiones que lo requieren.
///
/// Las rutas anonimas se resuelven por allowlist explicita y no por ausencia
/// de token: mandar un Bearer vencido a `POST /auth/login` haria que el
/// backend rechace un login que deberia funcionar.
class AuthInterceptor extends Interceptor {
  AuthInterceptor(this._tokenStorage);

  final TokenStorage _tokenStorage;

  /// Rutas que el backend expone como anonimas. Se comparan por sufijo del
  /// path, de modo que la base URL no influye.
  static const Set<String> anonymousPaths = <String>{
    '/api/v1/consent/current',
    '/api/v1/auth/register',
    '/api/v1/auth/login',
    '/api/v1/auth/refresh',
    '/api/v1/auth/password-reset/request',
    '/api/v1/auth/password-reset/confirm',
  };

  /// `true` si la ruta no lleva Bearer.
  ///
  /// `POST /auth/logout` queda deliberadamente fuera de la allowlist: el
  /// contrato lo declara como endpoint autenticado.
  static bool isAnonymous(String path) {
    final normalized = Uri.parse(path).path;
    return anonymousPaths.any(normalized.endsWith);
  }

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (isAnonymous(options.path)) {
      return handler.next(options);
    }

    final accessToken = await _tokenStorage.readAccessToken();
    if (accessToken != null && accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }
    return handler.next(options);
  }
}
