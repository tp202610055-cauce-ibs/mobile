import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/session_notifier.dart';
import '../../features/auth/presentation/auth_screens.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import 'app_routes.dart';
import 'session_guard.dart';

part 'app_router.g.dart';

/// Router de la aplicacion, con el guard de sesion montado.
///
/// `watch` sobre [sessionNotifierProvider] y no `read`: cada transicion de
/// sesion tiene que reconstruir el router para que `GoRouter` reevalue el
/// redirect. Con `read`, cerrar sesion dejaria al paciente mirando la home.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final session = ref.watch(sessionNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    // `matchedLocation` y no `uri.path`: es la ruta que el router resolvio,
    // ya normalizada. La query del deep link se lee aparte, en el builder.
    redirect: (context, state) => resolveRedirect(
      session: session,
      location: state.matchedLocation,
    ),
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.splash,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (_, __) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.authBranch,
        // `/auth` a secas no es una pantalla. Cae al login.
        //
        // Se compara contra `uri.path` y NO contra `matchedLocation`.
        //
        // go_router evalua el redirect del padre tambien para cada ruta hija,
        // y en esa evaluacion `matchedLocation` vale `/auth`, que es lo que
        // matcheo este GoRoute, no la ruta pedida. Compararlo asi daria
        // verdadero siempre y mandaria al login el registro, la recuperacion y
        // el deep link de restablecimiento. `uri.path` si trae la ruta real.
        redirect: (BuildContext context, GoRouterState state) =>
            state.uri.path == AppRoutes.authBranch ? AppRoutes.login : null,
        routes: <RouteBase>[
          GoRoute(
            path: 'login',
            builder: (_, __) => const LoginScreen(),
          ),
          GoRoute(
            path: 'register',
            builder: (_, __) => const RegisterScreen(),
          ),
          GoRoute(
            path: 'password-recovery',
            builder: (_, __) => const PasswordRecoveryScreen(),
            routes: <RouteBase>[
              GoRoute(
                path: 'sent',
                builder: (_, __) => const PasswordRecoverySentScreen(),
              ),
            ],
          ),
          GoRoute(
            path: 'password-reset',
            builder: (BuildContext context, GoRouterState state) {
              // Llega de `cauce://auth/password-reset?token=xxx`. Un token
              // ausente se pasa como cadena vacia y la pantalla muestra el
              // error de enlace invalido, que es mas util que un crash.
              final token =
                  state.uri.queryParameters[AppRoutes.tokenQueryParam] ?? '';
              return PasswordResetScreen(token: token);
            },
          ),
          GoRoute(
            path: 'verify-email-pending',
            builder: (_, __) => const VerifyEmailPendingScreen(),
          ),
        ],
      ),
    ],
  );
}
