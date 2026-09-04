import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/domain/session_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_token_storage.dart';

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
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: false,
  isInActivePilot: true,
);

/// Contenedor con el almacenamiento y el repositorio sustituidos.
({
  ProviderContainer container,
  FakeTokenStorage storage,
  FakeAuthRepository repository,
}) _harness({
  String? accessToken,
  String? refreshToken,
  AuthenticatedUserSnapshot? user,
  CauceApiError? logoutError,
}) {
  final storage = FakeTokenStorage(
    accessToken: accessToken,
    refreshToken: refreshToken,
    userSnapshot: user,
  );
  final repository = FakeAuthRepository(error: logoutError);
  final container = ProviderContainer(
    overrides: <Override>[
      tokenStorageProvider.overrideWithValue(storage),
      authRepositoryProvider.overrideWithValue(repository),
    ],
  );
  addTearDown(container.dispose);
  return (container: container, storage: storage, repository: repository);
}

void main() {
  group('SessionNotifier · estado inicial', () {
    test('arranca sin resolver', () {
      final h = _harness();

      expect(h.container.read(sessionNotifierProvider), isA<SessionUnknown>());
      expect(h.container.read(sessionNotifierProvider).isResolving, isTrue);
    });
  });

  group('SessionNotifier · bootstrap', () {
    test('sin nada guardado queda sin sesion', () async {
      final h = _harness();

      await h.container.read(sessionNotifierProvider.notifier).bootstrap();

      expect(
        h.container.read(sessionNotifierProvider),
        isA<SessionUnauthenticated>(),
      );
      // No habia nada que limpiar, asi que no se toca el Keystore.
      expect(h.storage.clearSessionCalls, 0);
    });

    test('con sesion completa y correo verificado autentica', () async {
      final h = _harness(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: _verified,
      );

      await h.container.read(sessionNotifierProvider.notifier).bootstrap();

      expect(
        h.container.read(sessionNotifierProvider),
        const SessionState.authenticated(_verified),
      );
    });

    test('con correo sin verificar va al aviso', () async {
      final h = _harness(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: _unverified,
      );

      await h.container.read(sessionNotifierProvider.notifier).bootstrap();

      expect(
        h.container.read(sessionNotifierProvider),
        const SessionState.pendingEmailVerification(
          email: 'paciente.demo@cauce.local',
          user: _unverified,
        ),
      );
    });

    test('sin access token pero con refresh, sigue habiendo sesion', () async {
      // El access vence a los 15 minutos. Su ausencia no significa que la
      // sesion termino: el RefreshInterceptor la renueva en la primera
      // peticion protegida.
      final h = _harness(refreshToken: 'refresh-1', user: _verified);

      await h.container.read(sessionNotifierProvider.notifier).bootstrap();

      expect(
        h.container.read(sessionNotifierProvider),
        const SessionState.authenticated(_verified),
      );
    });

    test('sin refresh token descarta los restos', () async {
      final h = _harness(accessToken: 'access-huerfano', user: _verified);

      await h.container.read(sessionNotifierProvider.notifier).bootstrap();

      expect(
        h.container.read(sessionNotifierProvider),
        isA<SessionUnauthenticated>(),
      );
      // Barre lo suelto para no reevaluar basura en el proximo arranque.
      expect(h.storage.clearSessionCalls, 1);
      expect(h.storage.accessToken, isNull);
    });

    test('sin snapshot de usuario tampoco hay sesion', () async {
      final h = _harness(accessToken: 'access-1', refreshToken: 'refresh-1');

      await h.container.read(sessionNotifierProvider.notifier).bootstrap();

      expect(
        h.container.read(sessionNotifierProvider),
        isA<SessionUnauthenticated>(),
      );
      expect(h.storage.clearSessionCalls, 1);
    });
  });

  group('SessionNotifier · login', () {
    test('persiste las tres piezas y autentica', () async {
      final h = _harness();

      await h.container.read(sessionNotifierProvider.notifier).loginSucceeded(
            accessToken: 'access-1',
            refreshToken: 'refresh-1',
            user: _verified,
          );

      expect(h.storage.saveSessionCalls, 1);
      expect(h.storage.accessToken, 'access-1');
      expect(h.storage.refreshToken, 'refresh-1');
      expect(h.storage.userSnapshot, _verified);
      expect(
        h.container.read(sessionNotifierProvider),
        const SessionState.authenticated(_verified),
      );
    });

    test('un login con correo sin verificar no llega a la home', () async {
      final h = _harness();

      await h.container.read(sessionNotifierProvider.notifier).loginSucceeded(
            accessToken: 'access-1',
            refreshToken: 'refresh-1',
            user: _unverified,
          );

      expect(
        h.container.read(sessionNotifierProvider),
        const SessionState.pendingEmailVerification(
          email: 'paciente.demo@cauce.local',
          user: _unverified,
        ),
      );
    });
  });

  group('SessionNotifier · registro', () {
    test('deja al paciente esperando la verificacion, sin persistir', () {
      // El registro responde 201 sin tokens: no hay sesion que guardar.
      final h = _harness();

      h.container
          .read(sessionNotifierProvider.notifier)
          .registrationSucceeded(email: 'nuevo@cauce.local');

      expect(
        h.container.read(sessionNotifierProvider),
        const SessionState.pendingEmailVerification(
          email: 'nuevo@cauce.local',
        ),
      );
      expect(h.storage.saveSessionCalls, 0);
    });

    test('el estado del registro no lleva snapshot', () {
      // El 201 no trae keycloakId ni isInActivePilot: construir un snapshot
      // obligaria a inventarlos.
      final h = _harness();

      h.container
          .read(sessionNotifierProvider.notifier)
          .registrationSucceeded(email: 'nuevo@cauce.local');

      final state = h.container.read(sessionNotifierProvider);
      expect(state.user, isNull);
      expect(state.email, 'nuevo@cauce.local');
    });
  });

  group('SessionNotifier · cierre', () {
    test('logout limpia el almacenamiento y desautentica', () async {
      final h = _harness(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: _verified,
      );
      await h.container.read(sessionNotifierProvider.notifier).bootstrap();

      await h.container.read(sessionNotifierProvider.notifier).logout();

      expect(h.storage.clearSessionCalls, 1);
      expect(h.storage.refreshToken, isNull);
      expect(
        h.container.read(sessionNotifierProvider),
        isA<SessionUnauthenticated>(),
      );
    });

    test('expire no vuelve a tocar el Keystore', () async {
      // El RefreshInterceptor ya limpio las tres keys antes de lanzar
      // SessionExpiredException; repetirlo seria trabajo redundante.
      final h = _harness(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: _verified,
      );
      await h.container.read(sessionNotifierProvider.notifier).bootstrap();

      h.container.read(sessionNotifierProvider.notifier).expire();

      expect(
        h.container.read(sessionNotifierProvider),
        isA<SessionUnauthenticated>(),
      );
      expect(h.storage.clearSessionCalls, 0);
    });
  });

  group('SessionState · correo del paciente', () {
    test('cada estado expone el correo que conoce', () {
      // Autenticado lo saca del snapshot; pendiente lo lleva propio, porque
      // tras un registro no hay snapshot del que sacarlo.
      expect(
        const SessionState.authenticated(_verified).email,
        'paciente.demo@cauce.local',
      );
      expect(
        const SessionState.pendingEmailVerification(
          email: 'nuevo@cauce.local',
        ).email,
        'nuevo@cauce.local',
      );
      expect(const SessionState.unknown().email, isNull);
      expect(const SessionState.unauthenticated().email, isNull);
    });

    test('isResolving solo es cierto antes del bootstrap', () {
      expect(const SessionState.unknown().isResolving, isTrue);
      expect(const SessionState.unauthenticated().isResolving, isFalse);
      expect(const SessionState.authenticated(_verified).isResolving, isFalse);
    });
  });

  group('SessionState · acceso al usuario', () {
    test('solo los estados con sesion exponen usuario', () {
      expect(const SessionState.authenticated(_verified).user, _verified);
      expect(
        const SessionState.pendingEmailVerification(
          email: 'paciente.demo@cauce.local',
          user: _unverified,
        ).user,
        _unverified,
      );
      expect(const SessionState.unknown().user, isNull);
      expect(const SessionState.unauthenticated().user, isNull);
    });
  });
}
