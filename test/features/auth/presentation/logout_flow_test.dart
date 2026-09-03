import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/auth/presentation/auth_screens.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:flutter/material.dart';
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

Future<({FakeAuthRepository repository, FakeTokenStorage storage})> _pumpApp(
  WidgetTester tester, {
  required AuthenticatedUserSnapshot user,
  CauceApiError? logoutError,
}) async {
  final repository = FakeAuthRepository(error: logoutError);
  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: user,
  );
  final container = ProviderContainer(
    overrides: <Override>[
      authRepositoryProvider.overrideWithValue(repository),
      tokenStorageProvider.overrideWithValue(storage),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return (repository: repository, storage: storage);
}

void main() {
  group('US08 CA01 · cierre de sesion desde la home', () {
    testWidgets('avisa al backend con el refresh token vigente', (
      tester,
    ) async {
      final h = await _pumpApp(tester, user: _verified);
      expect(find.byType(HomeScreen), findsOneWidget);

      await tester.tap(find.byKey(const Key('home_logout')));
      await tester.pumpAndSettle();

      expect(h.repository.logoutCalls, 1);
      expect(h.repository.lastRefreshToken, 'refresh-1');
    });

    testWidgets('limpia el almacenamiento y vuelve al login', (tester) async {
      final h = await _pumpApp(tester, user: _verified);

      await tester.tap(find.byKey(const Key('home_logout')));
      await tester.pumpAndSettle();

      expect(h.storage.clearSessionCalls, 1);
      expect(h.storage.refreshToken, isNull);
      expect(h.storage.userSnapshot, isNull);
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('si el backend falla, la sesion local se cierra igual', (
      tester,
    ) async {
      // Dejar al paciente dentro de la app porque el servidor no contesto
      // seria peor que un refresh token que caduca solo a los 30 dias.
      final h = await _pumpApp(
        tester,
        user: _verified,
        logoutError: const CauceApiError.network(),
      );

      await tester.tap(find.byKey(const Key('home_logout')));
      await tester.pumpAndSettle();

      expect(h.repository.logoutCalls, 1);
      expect(h.storage.clearSessionCalls, 1);
      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('un 500 del backend tampoco bloquea la salida', (tester) async {
      final h = await _pumpApp(
        tester,
        user: _verified,
        logoutError: const CauceApiError.unknown(statusCode: 500),
      );

      await tester.tap(find.byKey(const Key('home_logout')));
      await tester.pumpAndSettle();

      expect(h.storage.clearSessionCalls, 1);
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });

  group('VerifyEmailPendingScreen', () {
    final unverified = _verified.copyWith(emailVerified: false);

    testWidgets('muestra el correo al que se envio la verificacion', (
      tester,
    ) async {
      await _pumpApp(tester, user: unverified);

      expect(find.byType(VerifyEmailPendingScreen), findsOneWidget);
      expect(
        find.textContaining('paciente.demo@cauce.local'),
        findsOneWidget,
      );
    });

    testWidgets('deriva a soporte en vez de ofrecer reenvio', (tester) async {
      // El backend no expone endpoint de reenvio y el contrato lo declara
      // inexistente. Un boton que no hace nada seria peor que no tenerlo.
      await _pumpApp(tester, user: unverified);

      expect(
        find.textContaining('comunicate con soporte'),
        findsOneWidget,
      );
    });

    testWidgets('permite cerrar sesion y volver al login', (tester) async {
      final h = await _pumpApp(tester, user: unverified);

      await tester.tap(find.byKey(const Key('verify_email_logout')));
      await tester.pumpAndSettle();

      expect(h.storage.clearSessionCalls, 1);
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
