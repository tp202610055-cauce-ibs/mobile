/// Excepción base para todos los errores de red y API.
sealed class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => 'ApiException: $message';
}

/// 400: Datos de entrada inválidos (validación de DataAnnotations).
class ValidationException extends ApiException {
  final Map<String, List<String>>? fieldErrors;
  const ValidationException(super.message, {this.fieldErrors});
}

/// 401: Credenciales incorrectas.
class InvalidCredentialsException extends ApiException {
  const InvalidCredentialsException()
      : super('Correo o contraseña incorrectos.');
}

/// 409: Email duplicado en registro.
class DuplicateEmailException extends ApiException {
  const DuplicateEmailException()
      : super('Ya existe una cuenta registrada con este correo.');
}

/// 423: Cuenta bloqueada tras 5 intentos fallidos (alineado a US05).
class AccountLockedException extends ApiException {
  const AccountLockedException()
      : super('Cuenta bloqueada temporalmente. Intenta nuevamente en unos minutos.');
}

/// Token ausente, expirado o inválido en endpoints protegidos.
class UnauthorizedException extends ApiException {
  const UnauthorizedException()
      : super('Sesión expirada. Inicia sesión nuevamente.');
}

/// Sin conexión a internet o backend no alcanzable.
class NetworkException extends ApiException {
  const NetworkException()
      : super('No se pudo conectar al servidor. Verifica tu conexión.');
}

/// Error 500 o cualquier respuesta no manejada.
class ServerException extends ApiException {
  const ServerException([String? msg])
      : super(msg ?? 'Error en el servidor. Intenta nuevamente más tarde.');
}