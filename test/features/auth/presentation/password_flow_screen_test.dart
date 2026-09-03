import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/router/app_router.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/widgets/cauce_error_banner.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/auth/presentation/login_screen.dart';
import 'package:cauce_mobile/features/auth/presentation/password_recovery_screen.dart';
import 'package:cauce_mobile/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_token_storage.dart';

/// Monta la app completa: estas pruebas verifican el flujo con navegacion
/// real, que es donde vive la mitad del comportamiento de US07.
Future<({ProviderContainer container, FakeAuthRepository repository})> _pumpApp(
  WidgetTester tester, {
  CauceApiError? error,
}) async {
  final repository = FakeAuthRepository(error: error);
  final container = ProviderContainer(
    overrides: <Override>[
      authRepositoryProvider.overrideWithValue(repository),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return (container: container, repository: repository);
}

void main() {
  group('US07 CA01 · solicitud del enlace', () {
    testWidgets('desde el login se llega a la recuperacion', (tester) async {
      await _pumpApp(tester);

      await tester.tap(find.byKey(const Key('login_forgot_password')));
      await tester.pumpAndSettle();

      expect(find.byType(PasswordRecoveryScreen), findsOneWidget);
    });

    testWidgets('un envio aceptado avanza a la confirmacion', (tester) async {
      final h = await _pumpApp(tester);
      h.container.read(appRouterProvider).push(AppRoutes.passwordRecovery);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('recovery_email')),
        'paciente.demo@cauce.local',
      );
      await tester.tap(find.byKey(const Key('recovery_submit')));
      await tester.pumpAndSettle();

      expect(h.repository.requestPasswordResetCalls, 1);
      expect(find.byType(PasswordRecoverySentScreen), findsOneWidget);
      // El texto es deliberadamente condicional: el backend responde 200
      // exista o no la cuenta, y afirmar el envio filtraria esa informacion.
      expect(find.textContaining('Si el correo existe'), findsOneWidget);
    });

    testWidgets('un correo invalido no llega al backend', (tester) async {
      final h = await _pumpApp(tester);
      h.container.read(appRouterProvider).push(AppRoutes.passwordRecovery);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('recovery_email')),
        'no-es-mail',
      );
      await tester.tap(find.byKey(const Key('recovery_submit')));
      await tester.pumpAndSettle();

      expect(h.repository.requestPasswordResetCalls, 0);
      expect(find.byType(PasswordRecoverySentScreen), findsNothing);
    });

    testWidgets('un rate limit se muestra y no avanza', (tester) async {
      final h = await _pumpApp(
        tester,
        error: const CauceApiError.rateLimited(retryAfterSeconds: 900),
      );
      h.container.read(appRouterProvider).push(AppRoutes.passwordRecovery);
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('recovery_email')),
        'a@b.co',
      );
      await tester.tap(find.byKey(const Key('recovery_submit')));
      await tester.pump();

      expect(find.byType(CauceErrorBanner), findsOneWidget);
      expect(find.byType(PasswordRecoverySentScreen), findsNothing);

      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('desde la confirmacion se vuelve al login', (tester) async {
      final h = await _pumpApp(tester);
      h.container.read(appRouterProvider).push(AppRoutes.passwordRecoverySent);
      await tester.pumpAndSettle();

      await tester.tap(
        find.byKey(const Key('recovery_sent_back_to_login')),
      );
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });

  group('US07 CA02 · restablecimiento por deep link', () {
    Future<({ProviderContainer container, FakeAuthRepository repository})>
        openResetLink(WidgetTester tester, {CauceApiError? error}) async {
      final h = await _pumpApp(tester, error: error);
      h.container
          .read(appRouterProvider)
          .go('${AppRoutes.passwordReset}?token=abc123');
      await tester.pumpAndSettle();
      return h;
    }

    testWidgets('confirma la contrasena con el token del enlace', (
      tester,
    ) async {
      final h = await openResetLink(tester);

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

      expect(h.repository.confirmPasswordResetCalls, 1);
      expect(h.repository.lastToken, 'abc123');
      expect(h.repository.lastNewPassword, 'NuevaClave1');
      expect(find.text('Contrasena actualizada'), findsOneWidget);
    });

    testWidgets('tras aceptar el dialogo vuelve al login', (tester) async {
      await openResetLink(tester);

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

      await tester.tap(find.byKey(const Key('reset_success_ok')));
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('rechaza una contrasena que no cumple las reglas', (
      tester,
    ) async {
      final h = await openResetLink(tester);

      await tester.enterText(
        find.byKey(const Key('reset_password')),
        'minusculas',
      );
      await tester.enterText(
        find.byKey(const Key('reset_password_confirmation')),
        'minusculas',
      );
      await tester.tap(find.byKey(const Key('reset_submit')));
      await tester.pumpAndSettle();

      expect(h.repository.confirmPasswordResetCalls, 0);
      expect(
        find.text('Debe incluir una mayuscula, una minuscula y un digito'),
        findsOneWidget,
      );
    });

    testWidgets('rechaza confirmaciones que no coinciden', (tester) async {
      final h = await openResetLink(tester);

      await tester.enterText(
        find.byKey(const Key('reset_password')),
        'NuevaClave1',
      );
      await tester.enterText(
        find.byKey(const Key('reset_password_confirmation')),
        'OtraClave1',
      );
      await tester.tap(find.byKey(const Key('reset_submit')));
      await tester.pumpAndSettle();

      expect(h.repository.confirmPasswordResetCalls, 0);
      expect(find.text('Las contrasenas no coinciden'), findsOneWidget);
    });

    testWidgets('un enlace vencido ofrece pedir uno nuevo', (tester) async {
      await openResetLink(
        tester,
        error: const CauceApiError.passwordResetToken(
          reason: PasswordResetTokenReason.expired,
        ),
      );

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

      expect(
        find.text('El enlace de recuperacion vencio o ya fue usado'),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('reset_request_new_link')),
        findsOneWidget,
      );
    });

    testWidgets('el atajo lleva de vuelta a la solicitud', (tester) async {
      await openResetLink(
        tester,
        error: const CauceApiError.passwordResetToken(
          reason: PasswordResetTokenReason.invalid,
        ),
      );

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

      await tester.tap(find.byKey(const Key('reset_request_new_link')));
      await tester.pumpAndSettle();

      expect(find.byType(PasswordRecoveryScreen), findsOneWidget);
    });

    testWidgets('una contrasena debil no ofrece enlace nuevo', (tester) async {
      // El token sigue sirviendo: mandar al paciente a rehacer el tramite
      // seria un rodeo innecesario.
      await openResetLink(
        tester,
        error: const CauceApiError.validation(
          fieldErrors: <String, List<String>>{
            'newPassword': <String>['Debe contener al menos un digito.'],
          },
          errorCode: 'validation_error',
        ),
      );

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

      expect(find.byKey(const Key('reset_request_new_link')), findsNothing);
      expect(
        find.text('Debe contener al menos un digito.'),
        findsOneWidget,
      );
    });
  });
}
