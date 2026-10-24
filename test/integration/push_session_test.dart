import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/push/push_messaging.dart';
import 'package:cauce_mobile/core/push/push_permission.dart';
import 'package:cauce_mobile/core/push/push_token_registrar.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/fake_push_messaging.dart';
import '../helpers/fake_token_storage.dart';

/// El registro del token de push sobre la composicion real de la app (R12).
///
/// Solo se sustituyen los bordes: transporte, conectividad, Keystore, base y
/// Firebase. Si nadie enciende el registrador con la sesion, esto se pone rojo.

const AuthenticatedUserSnapshot _verified = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

const String _tokenPath = '/api/v1/users/me/fcm-token';

typedef _Harness = ({
  ProviderContainer container,
  AppBorders borders,
  FakePushMessaging push,
  MemoryPushPermissionStore permission,
});

Future<_Harness> _pumpApp(WidgetTester tester, {required bool session}) async {
  final storage = session
      ? FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: _verified,
        )
      : FakeTokenStorage();
  final borders = appBorders(storage: storage);
  final push = FakePushMessaging();
  final permission = MemoryPushPermissionStore();
  addTearDown(push.dispose);

  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(storage),
      pushMessagingProvider.overrideWithValue(push),
      pushPermissionStoreProvider.overrideWithValue(permission),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();

  return (
    container: container,
    borders: borders,
    push: push,
    permission: permission,
  );
}

void main() {
  group('R12 · el token de push se liga con la sesion', () {
    testWidgets('una sesion restaurada registra el token y pide el permiso',
        (tester) async {
      final h = await _pumpApp(tester, session: true);

      final puts = h.borders.adapter.requestsFor('PUT', _tokenPath);
      expect(puts, hasLength(1));
      expect(puts.single.body['fcmToken'], 'token-del-telefono');
      expect(h.push.calls, contains('requestPermission'));
      expect(h.permission.asked, isTrue);
      expect(h.container.read(pushTokenRegistrarProvider).isRunning, isTrue);
    });

    testWidgets('un refresco del token se registra otra vez', (tester) async {
      final h = await _pumpApp(tester, session: true);

      h.push.refreshes.add('token-nuevo');
      await tester.pumpAndSettle();

      final puts = h.borders.adapter.requestsFor('PUT', _tokenPath);
      expect(puts.last.body['fcmToken'], 'token-nuevo');
    });

    testWidgets('sin sesion no se registra nada ni se pide permiso',
        (tester) async {
      final h = await _pumpApp(tester, session: false);

      expect(h.borders.adapter.requestsFor('PUT', _tokenPath), isEmpty);
      expect(h.push.calls, isEmpty);
    });

    testWidgets('el cierre de sesion desliga el token y apaga el registro',
        (tester) async {
      final h = await _pumpApp(tester, session: true);

      // Con reloj real: el cierre espera la red y el de la prueba es falso.
      await tester.runAsync(
        () => h.container.read(sessionNotifierProvider.notifier).logout(),
      );
      await tester.pumpAndSettle();

      final puts = h.borders.adapter.requestsFor('PUT', _tokenPath);
      expect(puts.last.body['fcmToken'], isNull);
      expect(h.push.calls.last, 'deleteToken');
      expect(h.container.read(pushTokenRegistrarProvider).isRunning, isFalse);
    });
  });
}
