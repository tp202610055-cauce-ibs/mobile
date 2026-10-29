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

  /// Hay sesion, con el correo verificado o no. Acceso completo.
  const factory SessionState.authenticated(AuthenticatedUserSnapshot user) =
      SessionAuthenticated;

  /// No hay sesion, o la que habia expiro.
  const factory SessionState.unauthenticated() = SessionUnauthenticated;

  /// Cuenta registrada cuyo primer login no prospero, sin tokens ni snapshot.
  ///
  /// Lo deja un servidor que exige verificar antes de iniciar sesion, o una
  /// falla de red justo despues del 201. [email] es lo que muestra el aviso.
  const factory SessionState.pendingEmailVerification({
    required String email,
  }) = SessionPendingEmailVerification;

  const SessionState._();

  /// Usuario asociado, si el estado lo tiene.
  AuthenticatedUserSnapshot? get user => switch (this) {
        SessionAuthenticated(:final user) => user,
        SessionUnknown() ||
        SessionUnauthenticated() ||
        SessionPendingEmailVerification() =>
          null,
      };

  /// Correo del paciente, cuando el estado lo conoce.
  String? get email => switch (this) {
        SessionAuthenticated(:final user) => user.email,
        SessionPendingEmailVerification(:final email) => email,
        SessionUnknown() || SessionUnauthenticated() => null,
      };

  /// `true` mientras el bootstrap no haya resuelto.
  bool get isResolving => this is SessionUnknown;
}
