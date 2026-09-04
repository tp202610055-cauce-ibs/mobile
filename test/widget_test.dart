import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/core/router/app_router.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/theme/design_tokens.dart';
import 'package:cauce_mobile/features/auth/presentation/auth_screens.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/splash/presentation/splash_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helpers/fake_auth_repository.dart';
import 'helpers/fake_token_storage.dart';

const AuthenticatedUserSnapshot _verified = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

/// Monta la app con el almacenamiento sustituido y espera a que el bootstrap
/// del splash resuelva.
Future<ProviderContainer> _pumpApp(
  WidgetTester tester, {
  FakeTokenStorage? storage,
}) async {
  final container = ProviderContainer(
    overrides: <Override>[
      tokenStorageProvider.overrideWithValue(storage ?? FakeTokenStorage()),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
      child: const CauceApp(),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

void main() {
  group('CauceApp · fundamentos', () {
    testWidgets('resuelve la localizacion en espanol', (tester) async {
      await _pumpApp(tester);

      final context = tester.element(find.byType(Scaffold).first);
      // La app pide es_PE, pero las traducciones viven en app_es.arb, asi que
      // Flutter resuelve a `es`. Es el fallback que describe el acta M8.
      expect(Localizations.localeOf(context).languageCode, 'es');
      expect(AppLocalizations.of(context).appTitle, 'Cauce');
    });

    testWidgets('aplica el theme del design system', (tester) async {
      await _pumpApp(tester);

      final theme = Theme.of(tester.element(find.byType(Scaffold).first));
      expect(theme.scaffoldBackgroundColor, CauceColors.bgPage);
      expect(theme.colorScheme.primary, CauceColors.brandBase);
      expect(theme.textTheme.bodyLarge?.fontFamily, 'Inter');
    });
  });

  group('Router · arranque', () {
    testWidgets('el splash se muestra mientras la sesion no resuelve', (
      tester,
    ) async {
      // La demora simula lo que tarda el Keystore. Sin ella la lectura
      // resuelve en el mismo microtask y la ventana es inobservable.
      final container = ProviderContainer(
        overrides: <Override>[
          tokenStorageProvider.overrideWithValue(
            FakeTokenStorage(readDelay: const Duration(milliseconds: 50)),
          ),
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const CauceApp(),
        ),
      );
      await tester.pump();

      expect(find.byType(SplashScreen), findsOneWidget);

      await tester.pumpAndSettle();

      // Y una vez resuelta, cede el paso.
      expect(find.byType(SplashScreen), findsNothing);
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('sin sesion guardada termina en el login', (tester) async {
      await _pumpApp(tester);

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(SplashScreen), findsNothing);
    });

    testWidgets('con sesion valida entra a la home', (tester) async {
      await _pumpApp(
        tester,
        storage: FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: _verified,
        ),
      );

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Hola, Paciente Demo'), findsOneWidget);
    });

    testWidgets('con correo sin verificar queda en el aviso', (tester) async {
      await _pumpApp(
        tester,
        storage: FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: _verified.copyWith(emailVerified: false),
        ),
      );

      expect(find.byType(VerifyEmailPendingScreen), findsOneWidget);
    });
  });

  group('Router · navegacion', () {
    testWidgets('cerrar sesion devuelve al login', (tester) async {
      await _pumpApp(
        tester,
        storage: FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: _verified,
        ),
      );
      expect(find.byType(HomeScreen), findsOneWidget);

      await tester.tap(find.byType(OutlinedButton));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('/auth a secas cae en el login', (tester) async {
      final container = await _pumpApp(tester);

      container.read(appRouterProvider).go(AppRoutes.authBranch);
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('sin sesion, una ruta protegida rebota al login', (
      tester,
    ) async {
      final container = await _pumpApp(tester);

      container.read(appRouterProvider).go(AppRoutes.home);
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });
  });

  group('Router · deep link de recuperacion', () {
    testWidgets('transporta el token del enlace hasta la pantalla', (
      tester,
    ) async {
      final container = await _pumpApp(tester);

      // Equivale a abrir cauce://auth/password-reset?token=abc123
      container.read(appRouterProvider).go('/auth/password-reset?token=abc123');
      await tester.pumpAndSettle();

      expect(find.byType(PasswordResetScreen), findsOneWidget);
      expect(
        tester
            .widget<PasswordResetScreen>(find.byType(PasswordResetScreen))
            .token,
        'abc123',
      );
    });

    testWidgets('llega incluso con la sesion sin resolver', (tester) async {
      // Es el caso real: el paciente toca el enlace del correo con la app
      // cerrada. Sin la excepcion del guard, el token se perderia camino al
      // splash.
      final container = ProviderContainer(
        overrides: <Override>[
          tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        ],
      );
      addTearDown(container.dispose);

      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: const CauceApp(),
        ),
      );
      container.read(appRouterProvider).go('/auth/password-reset?token=xyz789');
      await tester.pump();

      expect(find.byType(PasswordResetScreen), findsOneWidget);
      expect(
        tester
            .widget<PasswordResetScreen>(find.byType(PasswordResetScreen))
            .token,
        'xyz789',
      );
    });

    testWidgets('sin token no revienta, entra con cadena vacia', (
      tester,
    ) async {
      final container = await _pumpApp(tester);

      container.read(appRouterProvider).go(AppRoutes.passwordReset);
      await tester.pumpAndSettle();

      expect(find.byType(PasswordResetScreen), findsOneWidget);
    });
  });
}
