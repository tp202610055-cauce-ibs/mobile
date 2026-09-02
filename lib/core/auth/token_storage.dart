import 'authenticated_user_snapshot.dart';

/// Contrato de persistencia de la sesion del paciente.
///
/// El acta M11 fija tres keys separadas en `flutter_secure_storage`:
/// `auth_access_token`, `auth_refresh_token` y `auth_user_snapshot`. La
/// separacion importa porque el `RefreshInterceptor` rota los dos tokens en
/// cada renovacion sin tocar el snapshot del usuario; con un blob unico cada
/// rotacion obligaria a leer, deserializar, mutar y reescribir todo.
///
/// La implementacion concreta [SecureTokenStorage] llega en la Fase 4.
abstract interface class TokenStorage {
  /// Access token vigente, o `null` si no hay sesion. Vive 15 minutos.
  Future<String?> readAccessToken();

  /// Refresh token vigente, o `null` si no hay sesion. Vive 30 dias gracias
  /// al scope `offline_access` que el backend pide para clientes moviles.
  Future<String?> readRefreshToken();

  /// Copia local del usuario autenticado, o `null` si no hay sesion.
  Future<AuthenticatedUserSnapshot?> readUserSnapshot();

  /// Persiste la sesion completa. Se invoca tras un login exitoso.
  Future<void> saveSession({
    required String accessToken,
    required String refreshToken,
    required AuthenticatedUserSnapshot user,
  });

  /// Reemplaza solo el par de tokens y conserva el snapshot del usuario.
  ///
  /// Es la operacion del `RefreshInterceptor`. El realm de Keycloak tiene
  /// `revokeRefreshToken: true` y `refreshTokenMaxReuse: 0`, de modo que cada
  /// renovacion invalida el refresh anterior: persistir el nuevo no es una
  /// optimizacion, es obligatorio. Reintentar con el viejo devuelve 401
  /// `invalid_refresh_token`.
  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  });

  /// Borra las tres keys. Se invoca en logout y cuando expira el refresh.
  Future<void> clearSession();
}
