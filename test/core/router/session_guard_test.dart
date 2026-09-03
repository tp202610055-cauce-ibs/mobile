import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/router/session_guard.dart';
import 'package:cauce_mobile/features/auth/domain/session_state.dart';
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
    final session = SessionState.authenticated(_verified);

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
    final session = SessionState.pendingEmailVerification(_unverified);

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
        'authenticated': SessionState.authenticated(_verified),
        'pendingEmailVerification': SessionState.pendingEmailVerification(
          _unverified,
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
}
