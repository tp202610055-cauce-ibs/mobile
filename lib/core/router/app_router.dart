import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/session_notifier.dart';
import '../../features/auth/presentation/auth_screens.dart';
import '../../features/clinical_notes/presentation/clinical_note_form_screen.dart';
import '../../features/custom_foods/presentation/custom_food_form_screen.dart';
import '../../features/history/domain/history_entry.dart';
import '../../features/history/presentation/history_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/ibs_sss/presentation/periodic_assessment_screen.dart';
import '../../features/meals/presentation/meal_form_screen.dart';
import '../../features/onboarding/application/onboarding_notifier.dart';
import '../../features/onboarding/presentation/clinical_profile_screen.dart';
import '../../features/onboarding/presentation/ibs_sss_baseline_screen.dart';
import '../../features/patients/presentation/privacy_screen.dart';
import '../../features/patients/presentation/profile_screen.dart';
import '../../features/recommendations/presentation/recommendations_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../../features/symptoms/presentation/symptom_form_screen.dart';
import 'app_routes.dart';
import 'app_shell.dart';
import 'session_guard.dart';

part 'app_router.g.dart';

/// Navigator raiz. Los formularios se apilan aca, por encima del shell.
final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

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
    navigatorKey: rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    // `matchedLocation` y no `uri.path`: es la ruta que el router resolvio,
    // ya normalizada. La query del deep link se lee aparte, en el builder.
    redirect: (context, state) => resolveRedirect(
      session: session,
      location: state.matchedLocation,
      onboarding: onboarding,
    ),
    routes: <RouteBase>[
      // Las cuatro pestanas (seccion H del design system).
      //
      // `indexedStack` y no `StatefulShellRoute` a secas: cada rama conserva
      // su estado y su pila al cambiar de pestana, que es lo que evita que el
      // Diario se recargue entero cada vez que el paciente pasa por Perfil.
      StatefulShellRoute.indexedStack(
        builder: (
          BuildContext context,
          GoRouterState state,
          StatefulNavigationShell navigationShell,
        ) =>
            AppShell(navigationShell: navigationShell),
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.home,
                builder: (_, __) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.history,
                builder: (_, __) => const HistoryScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.recommendations,
                builder: (_, __) => const RecommendationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: AppRoutes.profile,
                builder: (_, __) => const ProfileScreen(),
                routes: <RouteBase>[
                  // Privacidad se queda dentro de la rama y no sube al
                  // navigator raiz: es una subpantalla de ajustes, no un
                  // formulario de registro, y conservar la barra deja al
                  // paciente saltar a otra pestana y volver donde estaba.
                  GoRoute(
                    path: 'privacy',
                    builder: (_, __) => const PrivacyScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),

      // Formularios, a pantalla completa sobre el navigator raiz.
      //
      // Sin barra inferior a proposito: el app bar del design system los
      // dibuja con flecha de retroceso y titulo ("<- Registrar comida"), y
      // dejar las pestanas a la vista invitaria a cambiar de seccion a mitad
      // de un registro sin enviar.
      GoRoute(
        path: AppRoutes.mealNew,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const MealFormScreen(),
      ),
      GoRoute(
        path: AppRoutes.customFoodNew,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const CustomFoodFormScreen(),
      ),
      GoRoute(
        path: AppRoutes.symptomNew,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const SymptomFormScreen(),
      ),
      GoRoute(
        path: AppRoutes.clinicalNoteNew,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, GoRouterState state) => ClinicalNoteFormScreen(
          entry: state.extra! as HistoryEntry,
        ),
      ),
      GoRoute(
        path: AppRoutes.ibsSssPeriodic,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const PeriodicAssessmentScreen(),
      ),

      GoRoute(
        path: AppRoutes.splash,
        parentNavigatorKey: rootNavigatorKey,
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboardingBranch,
        parentNavigatorKey: rootNavigatorKey,
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
        parentNavigatorKey: rootNavigatorKey,
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
