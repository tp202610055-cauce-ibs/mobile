import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth/authenticated_user_snapshot.dart';
import '../../../core/auth/token_storage.dart';
import '../../../core/auth/token_storage_provider.dart';
import '../../../core/errors/cauce_api_error.dart';
import '../data/auth_repository.dart';
import '../domain/session_state.dart';

part 'session_notifier.g.dart';

/// Gobierna la sesion del paciente y alimenta el guard del router.
///
/// `keepAlive` porque la sesion sobrevive a cualquier pantalla. Es el unico
/// punto que escribe [SessionState]; las pantallas leen y disparan acciones.
@Riverpod(keepAlive: true)
class SessionNotifier extends _$SessionNotifier {
  @override
  SessionState build() => const SessionState.unknown();

  TokenStorage get _storage => ref.read(tokenStorageProvider);

  /// Resuelve el estado inicial leyendo el almacenamiento seguro.
  ///
  /// Lo invoca el `SplashScreen` al montarse. La renovacion silenciosa del
  /// access token vencido no se hace aca: la resuelve el `RefreshInterceptor`
  /// en la primera peticion protegida, que es donde se detecta el vencimiento
  /// de verdad. Duplicar esa logica aca significaria decidir por el `exp` del
  /// JWT, y el reloj del telefono no es una fuente confiable.
  Future<void> bootstrap() async {
    final accessToken = await _storage.readAccessToken();
    final refreshToken = await _storage.readRefreshToken();
    final user = await _storage.readUserSnapshot();

    // Falta cualquiera de las tres piezas: no hay sesion utilizable. El
    // refresh token es el que manda, porque el access vence a los 15 minutos
    // y su ausencia no significa que la sesion termino.
    if (refreshToken == null || refreshToken.isEmpty || user == null) {
      // Barre lo que haya quedado suelto, para no reevaluar basura en el
      // proximo arranque.
      if (accessToken != null || refreshToken != null || user != null) {
        await _storage.clearSession();
      }
      state = const SessionState.unauthenticated();
      return;
    }

    state = user.canAccessApp
        ? SessionState.authenticated(user)
        : SessionState.pendingEmailVerification(email: user.email, user: user);
  }

  /// Persiste la sesion recien emitida y publica el estado correspondiente.
  Future<void> loginSucceeded({
    required String accessToken,
    required String refreshToken,
    required AuthenticatedUserSnapshot user,
  }) async {
    await _storage.saveSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: user,
    );
    state = user.canAccessApp
        ? SessionState.authenticated(user)
        : SessionState.pendingEmailVerification(email: user.email, user: user);
  }

  /// Publica el estado posterior a un registro exitoso.
  ///
  /// El registro no emite tokens: el backend responde 201 con el `userId` y
  /// exige verificar el correo antes del primer login. No se persiste nada, y
  /// el estado va sin snapshot porque ese 201 no trae `keycloakId` ni el resto
  /// de los campos: construir uno obligaria a inventarlos.
  void registrationSucceeded({required String email}) {
    state = SessionState.pendingEmailVerification(email: email);
  }

  /// Cierra la sesion (US08 CA01).
  ///
  /// Avisa primero al backend para que revoque el refresh token del lado
  /// servidor, y despues limpia el almacenamiento local. La limpieza local es
  /// incondicional: si el aviso falla por red o por un 500, igual se cierra.
  /// Dejar al paciente dentro de la app porque el servidor no contesto seria
  /// peor que un refresh token que caduca solo a los 30 dias.
  ///
  /// El unico costo de que el aviso falle es que ese refresh sigue vivo en
  /// Keycloak hasta vencer, y ya no esta en ningun dispositivo.
  Future<void> logout() async {
    final refreshToken = await _storage.readRefreshToken();

    if (refreshToken != null && refreshToken.isNotEmpty) {
      try {
        await ref
            .read(authRepositoryProvider)
            .logout(refreshToken: refreshToken);
      } on CauceApiError {
        // Se ignora a proposito. Ver el parrafo de arriba.
      }
    }

    await _storage.clearSession();
    state = const SessionState.unauthenticated();
  }

  /// Marca la sesion como expirada sin tocar el almacenamiento.
  ///
  /// Lo invoca quien atrapa un `SessionExpiredException`. El
  /// `RefreshInterceptor` ya limpio las tres keys antes de lanzarlo, de modo
  /// que volver a borrar seria trabajo redundante sobre el Keystore.
  void expire() {
    state = const SessionState.unauthenticated();
  }
}
