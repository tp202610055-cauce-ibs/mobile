import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/router/app_router.dart';
import 'package:cauce_mobile/core/router/pending_password_reset_link.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/auth/presentation/auth_screens.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/splash/presentation/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/app_borders.dart';
import '../../helpers/fake_auth_repository.dart';
import '../../helpers/fake_token_storage.dart';

const String _link = 'cauce://auth/password-reset?token=tok-del-correo';

const CauceApiError _rejectedToken = CauceApiError.passwordResetToken(
  reason: PasswordResetTokenReason.expired,
);

/// Monta la app real con la URI con la que la plataforma la abre.
Future<ProviderContainer> _openApp(
  WidgetTester tester, {
  String? launchUri,
  FakeTokenStorage? storage,
  FakeAuthRepository? repository,
}) async {
  if (launchUri != null) {
    tester.binding.platformDispatcher.defaultRouteNameTestValue = launchUri;
    addTearDown(
      tester.binding.platformDispatcher.clearDefaultRouteNameTestValue,
    );
  }
  final tokenStorage = storage ?? FakeTokenStorage();
  final borders = appBorders(storage: tokenStorage);
  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(tokenStorage),
      authRepositoryProvider.overrideWithValue(
        repository ?? FakeAuthRepository(),
      ),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return container;
}

/// Entrega la URI por el canal real de la plataforma, con la app abierta.
Future<void> _pushLink(WidgetTester tester, String uri) async {
  await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
    SystemChannels.navigation.name,
    SystemChannels.navigation.codec.encodeMethodCall(
      MethodCall('pushRouteInformation', <String, dynamic>{'location': uri}),
    ),
    (_) {},
  );
  await tester.pumpAndSettle();
}

Future<void> _rebuildRouter(
  WidgetTester tester,
  ProviderContainer container,
) async {
  container.invalidate(appRouterProvider);
  await tester.pumpAndSettle();
}

Future<void> _submitNewPassword(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const Key('reset_password')),
    'NuevaClave1',
  );
  await tester.enterText(
    find.byKey(const Key('reset_password_confirmation')),
    'NuevaClave1',
  );
  await tester.tap(find.byKey(const Key('reset_submit')));
  await tester.pumpAndSettle();
}

String _screenToken(WidgetTester tester) =>
    tester.widget<PasswordResetScreen>(find.byType(PasswordResetScreen)).token;

void main() {
  group('Traduccion del enlace de restablecimiento', () {
    test('conserva el token, tambien con caracteres codificados', () {
      expect(passwordResetTokenFromUri(Uri.parse(_link)), 'tok-del-correo');
      expect(
        passwordResetTokenFromUri(
          Uri.parse('cauce://auth/password-reset?token=a%2Bb%2Fc%3D'),
        ),
        'a+b/c=',
      );
    });

    test('un enlace sin token se traduce a cadena vacia', () {
      expect(
        passwordResetTokenFromUri(Uri.parse('cauce://auth/password-reset')),
        '',
      );
    });

    test('ignora cualquier otra URI', () {
      const others = <String>[
        '/',
        '/password-reset?token=x',
        '/auth/password-reset?token=x',
        'cauce://auth/otra?token=x',
        'cauce://login-callback?token=x',
        'https://auth/password-reset?token=x',
      ];
      for (final uri in others) {
        expect(passwordResetTokenFromUri(Uri.parse(uri)), isNull, reason: uri);
      }
    });
  });

  group('Enlace de restablecimiento', () {
    testWidgets(
      'C1 · en frio y sin sesion llega al formulario y se queda ahi',
      (tester) async {
        final container = await _openApp(
          tester,
          launchUri: _link,
          storage: FakeTokenStorage(
            readDelay: const Duration(milliseconds: 50),
          ),
        );

        expect(find.byType(SplashScreen), findsNothing);
        expect(find.byType(LoginScreen), findsNothing);
        expect(find.byType(PasswordResetScreen), findsOneWidget);
        expect(_screenToken(tester), 'tok-del-correo');

        await _rebuildRouter(tester, container);

        expect(find.byType(PasswordResetScreen), findsOneWidget);
        expect(_screenToken(tester), 'tok-del-correo');
      },
    );

    testWidgets('C2 · con la app abierta y sin sesion llega al formulario', (
      tester,
    ) async {
      final container = await _openApp(tester);
      expect(find.byType(LoginScreen), findsOneWidget);

      await _pushLink(tester, _link);

      expect(find.byType(PasswordResetScreen), findsOneWidget);
      expect(_screenToken(tester), 'tok-del-correo');

      await _rebuildRouter(tester, container);

      expect(find.byType(PasswordResetScreen), findsOneWidget);
    });

    testWidgets('C3 · con sesion activa el guard deja ver el formulario', (
      tester,
    ) async {
      await _openApp(
        tester,
        launchUri: _link,
        storage: FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: demoUser,
        ),
      );

      expect(find.byType(PasswordResetScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });

    testWidgets('C4 · tras restablecer va al login y no repite el enlace', (
      tester,
    ) async {
      final repository = FakeAuthRepository();
      final container = await _openApp(
        tester,
        launchUri: _link,
        repository: repository,
      );

      await _submitNewPassword(tester);
      expect(repository.lastToken, 'tok-del-correo');
      await tester.tap(find.byKey(const Key('reset_success_ok')));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(container.read(pendingPasswordResetLinkProvider), isNull);

      await _rebuildRouter(tester, container);

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(PasswordResetScreen), findsNothing);

      await container.read(sessionNotifierProvider.notifier).loginSucceeded(
            accessToken: 'access-1',
            refreshToken: 'refresh-1',
            user: demoUser,
          );
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(PasswordResetScreen), findsNothing);
    });

    testWidgets(
      'C5 · un enlace vencido muestra el aviso y lleva a la recuperacion',
      (tester) async {
        final container = await _openApp(
          tester,
          launchUri: _link,
          repository: FakeAuthRepository()..validateError = _rejectedToken,
        );

        expect(find.byKey(const Key('reset_link_invalid')), findsOneWidget);

        await tester.tap(find.byKey(const Key('reset_request_new_link')));
        await tester.pumpAndSettle();

        expect(find.byType(PasswordRecoveryScreen), findsOneWidget);
        expect(find.byType(LoginScreen), findsNothing);
        expect(container.read(pendingPasswordResetLinkProvider), isNull);
      },
    );

    testWidgets(
      'C5 · un token rechazado al enviar tambien lleva a la recuperacion',
      (tester) async {
        final container = await _openApp(
          tester,
          launchUri: _link,
          repository: FakeAuthRepository()..error = _rejectedToken,
        );

        await _submitNewPassword(tester);
        await tester.ensureVisible(
          find.byKey(const Key('reset_request_new_link')),
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('reset_request_new_link')));
        await tester.pumpAndSettle();

        expect(find.byType(PasswordRecoveryScreen), findsOneWidget);
        expect(container.read(pendingPasswordResetLinkProvider), isNull);
      },
    );

    testWidgets('C6 · sin URI de arranque termina en el login', (tester) async {
      final container = await _openApp(tester);

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(container.read(pendingPasswordResetLinkProvider), isNull);
    });

    testWidgets('C6 · otra URI de arranque termina en el login', (
      tester,
    ) async {
      final container = await _openApp(
        tester,
        launchUri: 'cauce://auth/otra?token=x',
      );

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(PasswordResetScreen), findsNothing);
      expect(container.read(pendingPasswordResetLinkProvider), isNull);
    });
  });
}
