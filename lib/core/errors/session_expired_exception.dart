/// La sesion no se pudo renovar y el paciente debe volver a autenticarse.
///
/// La lanza el `RefreshInterceptor` cuando el refresh token expiro, fue
/// revocado o ya se consumio. Para cuando esta excepcion viaja, el
/// almacenamiento local ya quedo limpio: el guard del router solo tiene que
/// redirigir al login.
class SessionExpiredException implements Exception {
  const SessionExpiredException();

  @override
  String toString() => 'SessionExpiredException: la sesion expiro';
}
