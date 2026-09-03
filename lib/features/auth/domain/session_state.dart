import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/auth/authenticated_user_snapshot.dart';

part 'session_state.freezed.dart';

/// Estado de la sesion del paciente.
///
/// Es la unica fuente sobre la que decide el guard del router. Los cuatro
/// estados son excluyentes y cubren el ciclo completo de identidad.
@freezed
sealed class SessionState with _$SessionState {
  /// Todavia no se leyo el almacenamiento seguro.
  ///
  /// Es el estado inicial y solo el splash puede mostrarse mientras dure.
  /// Distinguirlo de [SessionUnauthenticated] evita el parpadeo de mandar al
  /// login a un paciente que si tiene sesion, mientras se lee del Keystore.
  const factory SessionState.unknown() = SessionUnknown;

  /// Hay sesion y el correo esta verificado. Acceso completo.
  const factory SessionState.authenticated(AuthenticatedUserSnapshot user) =
      SessionAuthenticated;

  /// No hay sesion, o la que habia expiro.
  const factory SessionState.unauthenticated() = SessionUnauthenticated;

  /// Hay sesion pero el correo sigue sin verificar.
  ///
  /// El backend registra la cuenta y emite tokens, pero el paciente no puede
  /// operar hasta seguir el enlace del correo. Se conserva el snapshot porque
  /// la pantalla de aviso muestra a que direccion se envio.
  const factory SessionState.pendingEmailVerification(
    AuthenticatedUserSnapshot user,
  ) = SessionPendingEmailVerification;

  const SessionState._();

  /// Usuario asociado, si el estado lo tiene.
  AuthenticatedUserSnapshot? get user => switch (this) {
    SessionAuthenticated(:final user) => user,
    SessionPendingEmailVerification(:final user) => user,
    SessionUnknown() || SessionUnauthenticated() => null,
  };

  /// `true` mientras el bootstrap no haya resuelto.
  bool get isResolving => this is SessionUnknown;
}
