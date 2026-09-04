import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/auth_repository.dart';
import 'session_notifier.dart';

part 'login_notifier.freezed.dart';
part 'login_notifier.g.dart';

/// Estado del formulario de inicio de sesion (US05).
@freezed
sealed class LoginState with _$LoginState {
  const factory LoginState.idle() = LoginIdle;
  const factory LoginState.submitting() = LoginSubmitting;

  /// El login fue aceptado. La navegacion la resuelve el guard del router en
  /// cuanto [SessionNotifier] publica la sesion, no esta pantalla.
  const factory LoginState.success() = LoginSuccess;

  const factory LoginState.failure(CauceApiError error) = LoginFailure;

  const LoginState._();

  bool get isSubmitting => this is LoginSubmitting;

  /// Error a mostrar, si el ultimo intento fallo.
  CauceApiError? get error => switch (this) {
        LoginFailure(:final error) => error,
        _ => null,
      };
}

/// Gobierna el envio del formulario de login.
@riverpod
class LoginNotifier extends _$LoginNotifier {
  @override
  LoginState build() => const LoginState.idle();

  /// Autentica contra el backend y publica la sesion si es aceptada.
  ///
  /// Devuelve `true` si el login prospero, para que la pantalla decida si
  /// limpiar el campo de contrasena.
  Future<bool> submit({required String email, required String password}) async {
    // Un doble toque en el boton no debe emitir dos logins: el backend limita
    // a 10 por minuto por IP y el segundo consumiria cupo sin necesidad.
    if (state.isSubmitting) {
      return false;
    }
    state = const LoginState.submitting();

    try {
      final session = await ref
          .read(authRepositoryProvider)
          .login(email: email.trim(), password: password);

      // Persistir antes de publicar el exito: si el guardado fallara, la
      // pantalla no debe anunciar una sesion que el proximo arranque no
      // encontraria.
      await ref.read(sessionNotifierProvider.notifier).loginSucceeded(
            accessToken: session.accessToken,
            refreshToken: session.refreshToken,
            user: session.user,
          );

      state = const LoginState.success();
      return true;
    } on CauceApiError catch (error) {
      state = LoginState.failure(error);
      return false;
    }
  }

  /// Descarta el error visible, al volver a editar el formulario.
  void clearError() {
    if (state is LoginFailure) {
      state = const LoginState.idle();
    }
  }
}
