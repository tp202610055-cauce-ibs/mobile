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

  /// El correo sigue sin verificar y el paciente no puede operar.
  ///
  /// Se alcanza por dos caminos que aportan informacion distinta:
  ///
  /// - Tras un **login**: el backend devolvio el objeto `user` completo, de
  ///   modo que [user] viene lleno.
  /// - Tras un **registro**: el backend responde 201 con `userId` y poco mas,
  ///   sin tokens ni `keycloakId`. No hay snapshot que construir sin inventar
  ///   campos, asi que [user] queda nulo.
  ///
  /// [email] esta siempre presente, porque es lo unico que la pantalla de
  /// aviso necesita mostrar.
  const factory SessionState.pendingEmailVerification({
    required String email,
    AuthenticatedUserSnapshot? user,
  }) = SessionPendingEmailVerification;

  const SessionState._();

  /// Usuario asociado, si el estado lo tiene.
  AuthenticatedUserSnapshot? get user => switch (this) {
        SessionAuthenticated(:final user) => user,
        SessionPendingEmailVerification(:final user) => user,
        SessionUnknown() || SessionUnauthenticated() => null,
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
