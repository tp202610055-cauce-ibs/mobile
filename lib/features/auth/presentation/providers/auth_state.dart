import '../../data/dtos/user_profile_dto.dart';

/// Estados posibles del flujo de autenticación.
sealed class AuthState {
  const AuthState();
}

/// Estado inicial, antes de verificar si hay token guardado.
class AuthInitial extends AuthState {
  const AuthInitial();
}

/// Verificando token persistido o ejecutando login/registro.
class AuthLoading extends AuthState {
  const AuthLoading();
}

/// Usuario autenticado con perfil cargado.
class AuthAuthenticated extends AuthState {
  final UserProfileDto user;
  const AuthAuthenticated(this.user);
}

/// Sin sesión activa.
class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

/// Error en alguna operación de auth. Contiene mensaje para mostrar al usuario.
class AuthError extends AuthState {
  final String message;
  const AuthError(this.message);
}