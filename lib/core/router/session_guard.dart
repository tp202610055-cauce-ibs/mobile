import '../../features/auth/domain/session_state.dart';
import 'app_routes.dart';

/// Decide el destino de una navegacion segun el estado de sesion.
///
/// Se expone como funcion pura, separada del `GoRouter`, porque es la pieza
/// con toda la logica de decision y merece testearse sin construir un arbol
/// de widgets ni un router.
///
/// Devuelve `null` cuando la ubicacion pedida es valida para el estado actual,
/// que es lo que `GoRouter` interpreta como "dejala pasar".
String? resolveRedirect({
  required SessionState session,
  required String location,
}) {
  // El restablecimiento de contrasena atraviesa el guard en cualquier estado.
  //
  // Llega por deep link `cauce://auth/password-reset?token=xxx`, tipicamente
  // con la app cerrada. Sin esta excepcion, el arranque encuentra la sesion en
  // [SessionUnknown], redirige a /splash y el token del enlace se pierde: el
  // paciente abre el correo, toca el enlace y termina mirando el splash.
  //
  // Es seguro porque el flujo es autocontenido: solo necesita el token del
  // enlace, no la sesion. El backend valida ese token del lado servidor.
  if (isSessionIndependent(location)) {
    return null;
  }

  final isAuthBranch = location.startsWith(AppRoutes.authBranch);
  final isSplash = location == AppRoutes.splash;

  return switch (session) {
    // Mientras se lee el Keystore, lo unico legitimo es el splash. Mandar al
    // login en este punto produciria un parpadeo en cada arranque de un
    // paciente que si tiene sesion.
    SessionUnknown() => isSplash ? null : AppRoutes.splash,

    // Con sesion valida, el arbol de identidad y el splash dejan de tener
    // sentido: quien ya entro no vuelve al login por navegar hacia atras.
    SessionAuthenticated() => isAuthBranch || isSplash ? AppRoutes.home : null,

    // Sin sesion, solo el flujo publico. El splash queda excluido porque su
    // trabajo ya termino.
    SessionUnauthenticated() => isAuthBranch ? null : AppRoutes.login,

    // Con el correo sin verificar, la app se reduce a una sola pantalla. El
    // paciente sale por el boton de cerrar sesion, no navegando.
    SessionPendingEmailVerification() =>
      location == AppRoutes.verifyEmailPending
          ? null
          : AppRoutes.verifyEmailPending,
  };
}

/// Rutas que el guard deja pasar sin mirar el estado de sesion.
bool isSessionIndependent(String location) {
  // Se compara solo el path: el deep link trae `?token=...` como consulta.
  final path = Uri.parse(location).path;
  return path == AppRoutes.passwordReset;
}
