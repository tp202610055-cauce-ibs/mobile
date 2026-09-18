import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/session_notifier.dart';
import '../../features/auth/presentation/auth_screens.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/onboarding/application/onboarding_notifier.dart';
import '../../features/onboarding/presentation/clinical_profile_screen.dart';
import '../../features/onboarding/presentation/ibs_sss_baseline_screen.dart';
import '../../features/patients/presentation/privacy_screen.dart';
import '../../features/patients/presentation/profile_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import 'app_routes.dart';
import 'session_guard.dart';

part 'app_router.g.dart';

/// Router de la aplicacion, con el guard de sesion montado.
///
/// `watch` y no `read` sobre los dos providers: cada transicion de sesion o de
/// onboarding tiene que reconstruir el router para que `GoRouter` reevalue el
/// redirect. Con `read`, cerrar sesion dejaria al paciente mirando la home, y
/// completar el perfil lo dejaria mirando el paso 1.
@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) {
  final session = ref.watch(sessionNotifierProvider);
  final onboarding = ref.watch(resolvedOnboardingProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    // `matchedLocation` y no `uri.path`: es la ruta que el router resolvio,
    // ya normalizada. La query del deep link se lee aparte, en el builder.
    redirect: (context, state) => resolveRedirect(
      session: session,
      location: state.matchedLocation,
      onboarding: onboarding,
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
        path: AppRoutes.profile,
        builder: (_, __) => const ProfileScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: 'privacy',
            builder: (_, __) => const PrivacyScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.onboardingBranch,
        // `/onboarding` a secas no es una pantalla. El guard ya resuelve el
        // paso que corresponde, asi que aca alcanza con no dejar la rama
        // colgando sin builder.
        redirect: (BuildContext context, GoRouterState state) =>
            state.uri.path == AppRoutes.onboardingBranch
                ? AppRoutes.onboardingProfile
                : null,
        routes: <RouteBase>[
          GoRoute(
            path: 'clinical-profile',
            builder: (_, __) => const ClinicalProfileScreen(),
          ),
          GoRoute(
            path: 'ibs-sss',
            builder: (_, __) => const IbsSssBaselineScreen(),
          ),
        ],
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
