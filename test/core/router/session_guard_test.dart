import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/router/session_guard.dart';
import 'package:cauce_mobile/features/auth/domain/session_state.dart';
import 'package:cauce_mobile/features/onboarding/application/onboarding_notifier.dart';
import 'package:flutter_test/flutter_test.dart';

const AuthenticatedUserSnapshot _verified = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

const AuthenticatedUserSnapshot _unverified = AuthenticatedUserSnapshot(
  userId: 'e1f2a3b4-0000-0000-0000-000000000000',
  keycloakId: 'c2d3e4f5-0000-0000-0000-000000000000',
  email: 'nuevo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Nuevo',
  emailVerified: false,
  isInActivePilot: true,
);

void main() {
  group('resolveRedirect · sesion sin resolver', () {
    const session = SessionState.unknown();

    test('deja pasar el splash', () {
      expect(
        resolveRedirect(session: session, location: AppRoutes.splash),
        isNull,
      );
    });

    test('manda todo lo demas al splash', () {
      // Redirigir al login en este punto haria parpadear el arranque de un
      // paciente que si tiene sesion guardada.
      for (final location in <String>[
        AppRoutes.home,
        AppRoutes.login,
        AppRoutes.register,
      ]) {
        expect(
          resolveRedirect(session: session, location: location),
          AppRoutes.splash,
          reason: location,
        );
      }
    });
  });

  group('resolveRedirect · sesion valida', () {
    const session = SessionState.authenticated(_verified);

    test('deja pasar la home', () {
      expect(
        resolveRedirect(session: session, location: AppRoutes.home),
        isNull,
      );
    });

    test('expulsa del arbol de identidad y del splash', () {
      for (final location in <String>[
        AppRoutes.splash,
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.passwordRecovery,
      ]) {
        expect(
          resolveRedirect(session: session, location: location),
          AppRoutes.home,
          reason: location,
        );
      }
    });
  });

  group('resolveRedirect · sin sesion', () {
    const session = SessionState.unauthenticated();

    test('deja pasar todo el flujo publico', () {
      for (final location in <String>[
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.passwordRecovery,
        AppRoutes.passwordRecoverySent,
      ]) {
        expect(
          resolveRedirect(session: session, location: location),
          isNull,
          reason: location,
        );
      }
    });

    test('manda al login cualquier ruta protegida', () {
      expect(
        resolveRedirect(session: session, location: AppRoutes.home),
        AppRoutes.login,
      );
    });

    test('el splash tambien va al login: su trabajo ya termino', () {
      expect(
        resolveRedirect(session: session, location: AppRoutes.splash),
        AppRoutes.login,
      );
    });
  });

  group('resolveRedirect · correo sin verificar', () {
    const session = SessionState.pendingEmailVerification(
      email: 'nuevo@cauce.local',
      user: _unverified,
    );

    test('deja pasar solo la pantalla de aviso', () {
      expect(
        resolveRedirect(
          session: session,
          location: AppRoutes.verifyEmailPending,
        ),
        isNull,
      );
    });

    test('encierra al paciente en el aviso', () {
      // La salida es el boton de cerrar sesion, no la navegacion.
      for (final location in <String>[
        AppRoutes.home,
        AppRoutes.login,
        AppRoutes.register,
        AppRoutes.splash,
      ]) {
        expect(
          resolveRedirect(session: session, location: location),
          AppRoutes.verifyEmailPending,
          reason: location,
        );
      }
    });
  });

  group('resolveRedirect · deep link de recuperacion', () {
    const deepLink = '/auth/password-reset?token=abc123';

    test('atraviesa el guard en los cuatro estados de sesion', () {
      // Sin esta excepcion, un arranque en frio desde el correo encuentra la
      // sesion en unknown, redirige al splash y pierde el token del enlace.
      final sessions = <String, SessionState>{
        'unknown': const SessionState.unknown(),
        'unauthenticated': const SessionState.unauthenticated(),
        'authenticated': const SessionState.authenticated(_verified),
        'pendingEmailVerification': const SessionState.pendingEmailVerification(
          email: 'nuevo@cauce.local',
          user: _unverified,
        ),
      };

      for (final entry in sessions.entries) {
        expect(
          resolveRedirect(session: entry.value, location: deepLink),
          isNull,
          reason: entry.key,
        );
      }
    });

    test('tambien pasa sin query, para mostrar el error de enlace', () {
      expect(
        resolveRedirect(
          session: const SessionState.unknown(),
          location: AppRoutes.passwordReset,
        ),
        isNull,
      );
    });

    test('la excepcion no alcanza a otras rutas de identidad', () {
      expect(isSessionIndependent(AppRoutes.passwordReset), isTrue);
      expect(isSessionIndependent(AppRoutes.passwordRecovery), isFalse);
      expect(isSessionIndependent(AppRoutes.login), isFalse);
    });
  });

  group('resolveRedirect · onboarding pendiente (US03 y US04)', () {
    const session = SessionState.authenticated(_verified);

    String? redirect(OnboardingState onboarding, String location) =>
        resolveRedirect(
          session: session,
          location: location,
          onboarding: onboarding,
        );

    test('sin perfil, cualquier ubicacion lleva al paso 1', () {
      const pending = OnboardingState.pending(OnboardingStep.clinicalProfile);

      expect(redirect(pending, AppRoutes.home), AppRoutes.onboardingProfile);
      expect(redirect(pending, AppRoutes.splash), AppRoutes.onboardingProfile);
      expect(redirect(pending, AppRoutes.login), AppRoutes.onboardingProfile);
    });

    test('el paso pendiente se deja pasar', () {
      const pending = OnboardingState.pending(OnboardingStep.clinicalProfile);

      expect(redirect(pending, AppRoutes.onboardingProfile), isNull);
    });

    test('con el perfil creado, el paso pendiente es el cuestionario', () {
      const pending = OnboardingState.pending(OnboardingStep.ibsSssBaseline);

      expect(redirect(pending, AppRoutes.onboardingBaseline), isNull);
      // El orden es obligatorio: el backend exige perfil antes de la linea
      // base, y volver al paso 1 con el perfil ya creado daria 409.
      expect(
        redirect(pending, AppRoutes.onboardingProfile),
        AppRoutes.onboardingBaseline,
      );
    });

    test('no se puede saltar del paso 1 al 2', () {
      const pending = OnboardingState.pending(OnboardingStep.clinicalProfile);

      expect(
        redirect(pending, AppRoutes.onboardingBaseline),
        AppRoutes.onboardingProfile,
      );
    });
  });

  group('resolveRedirect · onboarding sin paso pendiente', () {
    const session = SessionState.authenticated(_verified);

    String? redirect(OnboardingState onboarding, String location) =>
        resolveRedirect(
          session: session,
          location: location,
          onboarding: onboarding,
        );

    test('aplazado deja usar la app y no devuelve al wizard (CA05)', () {
      const deferred = OnboardingState.deferred(OnboardingStep.clinicalProfile);

      expect(redirect(deferred, AppRoutes.home), isNull);
      // Devolverlo al wizard que acaba de aplazar haria inutil el aplazamiento.
      expect(
        redirect(deferred, AppRoutes.onboardingProfile),
        AppRoutes.home,
      );
    });

    test('completado cierra el wizard', () {
      const completed = OnboardingState.completed();

      expect(redirect(completed, AppRoutes.home), isNull);
      expect(redirect(completed, AppRoutes.onboardingProfile), AppRoutes.home);
      expect(redirect(completed, AppRoutes.onboardingBaseline), AppRoutes.home);
    });

    test('sin resolver no redirige: la app sigue usable sin red', () {
      // Es el estado mientras la consulta esta en vuelo y tambien cuando
      // fallo. Redirigir sobre un dato que no se tiene dejaria al paciente
      // atrapado en un wizard que tampoco podria enviar.
      const unavailable = OnboardingState.unavailable();

      expect(redirect(unavailable, AppRoutes.home), isNull);
    });

    test('el valor por defecto del parametro no altera el guard previo', () {
      // Los tests de identidad llaman a resolveRedirect sin onboarding. El
      // default tiene que dejar el comportamiento de Mobile-1b intacto.
      expect(
        resolveRedirect(session: session, location: AppRoutes.home),
        isNull,
      );
      expect(
        resolveRedirect(session: session, location: AppRoutes.login),
        AppRoutes.home,
      );
    });
  });

  group('resolveRedirect · el onboarding no pisa a la sesion', () {
    const pending = OnboardingState.pending(OnboardingStep.clinicalProfile);

    test('sin sesion manda al login, no al wizard', () {
      expect(
        resolveRedirect(
          session: const SessionState.unauthenticated(),
          location: AppRoutes.onboardingProfile,
          onboarding: pending,
        ),
        AppRoutes.login,
      );
    });

    test('con el correo sin verificar manda al aviso', () {
      expect(
        resolveRedirect(
          session: const SessionState.pendingEmailVerification(
            email: 'paciente.demo@cauce.local',
          ),
          location: AppRoutes.onboardingProfile,
          onboarding: pending,
        ),
        AppRoutes.verifyEmailPending,
      );
    });

    test('durante el bootstrap manda al splash', () {
      expect(
        resolveRedirect(
          session: const SessionState.unknown(),
          location: AppRoutes.onboardingProfile,
          onboarding: pending,
        ),
        AppRoutes.splash,
      );
    });

    test('el deep link de restablecimiento sigue atravesando todo', () {
      expect(
        resolveRedirect(
          session: const SessionState.unknown(),
          location: '${AppRoutes.passwordReset}?token=abc',
          onboarding: pending,
        ),
        isNull,
      );
    });
  });

  group('routeForStep', () {
    test('mapea cada paso a su ruta', () {
      expect(
        routeForStep(OnboardingStep.clinicalProfile),
        AppRoutes.onboardingProfile,
      );
      expect(
        routeForStep(OnboardingStep.ibsSssBaseline),
        AppRoutes.onboardingBaseline,
      );
    });
  });
}
