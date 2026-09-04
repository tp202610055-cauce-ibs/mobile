import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/router/app_router.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/auth/presentation/auth_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_token_storage.dart';

/// Abre la pantalla de registro dentro de la app completa.
Future<({ProviderContainer container, FakeAuthRepository repository})>
    _openRegister(
  WidgetTester tester, {
  CauceApiError? error,
  CauceApiError? consentError,
}) async {
  final repository = FakeAuthRepository(error: error)
    ..consentError = consentError;
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
  container.read(appRouterProvider).push(AppRoutes.register);
  await tester.pumpAndSettle();
  return (container: container, repository: repository);
}

/// Completa el formulario con datos validos.
Future<void> _fillValidForm(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const Key('register_full_name')),
    'Paciente Nuevo',
  );
  await tester.enterText(
    find.byKey(const Key('register_email')),
    'nuevo@cauce.local',
  );
  await tester.enterText(
    find.byKey(const Key('register_password')),
    'ClaveSegura1',
  );
  await tester.enterText(
    find.byKey(const Key('register_password_confirmation')),
    'ClaveSegura1',
  );
  await tester.pumpAndSettle();
}

/// Marca la casilla del consentimiento.
///
/// El formulario es mas alto que la ventana de prueba, asi que hay que
/// desplazar la casilla a la vista antes de tocarla: sin eso el tap cae fuera
/// del widget y no lo alterna.
Future<void> _acceptConsent(WidgetTester tester) async {
  final checkbox = find.byKey(const Key('register_consent_checkbox'));
  await tester.ensureVisible(checkbox);
  await tester.pumpAndSettle();
  await tester.tap(checkbox);
  await tester.pumpAndSettle();
}

/// Toca el boton de envio, desplazandolo a la vista primero.
Future<void> _tapSubmit(
  WidgetTester tester, {
  bool expectEnabled = true,
}) async {
  final button = find.byKey(const Key('register_submit'));
  await tester.ensureVisible(button);
  await tester.pumpAndSettle();
  await tester.tap(button, warnIfMissed: expectEnabled);
  await tester.pumpAndSettle();
}

void main() {
  group('RegisterScreen · consentimiento (US01 CA01)', () {
    testWidgets('carga el consentimiento vigente al montar', (tester) async {
      final h = await _openRegister(tester);

      expect(h.repository.currentConsentCalls, 1);
      expect(
        find.text('Texto del consentimiento informado del piloto Kaelin.'),
        findsOneWidget,
      );
    });

    testWidgets('si el consentimiento falla ofrece reintentar', (tester) async {
      // Sin consentimiento no hay registro posible: el backend rechaza
      // cualquier intento sin version y hash vigentes.
      final h = await _openRegister(
        tester,
        consentError: const CauceApiError.network(),
      );

      expect(find.byType(CauceErrorBanner), findsOneWidget);
      expect(find.byKey(const Key('register_submit')), findsNothing);

      h.repository.consentError = null;
      await tester.tap(find.byKey(const Key('register_retry_consent')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('register_submit')), findsOneWidget);
    });
  });

  group('RegisterScreen · bloqueo sin aceptacion (US01 CA03)', () {
    testWidgets('el boton nace deshabilitado', (tester) async {
      await _openRegister(tester);

      final button = tester.widget<CauceButton>(
        find.byKey(const Key('register_submit')),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('con el formulario lleno pero sin marcar, no envia', (
      tester,
    ) async {
      final h = await _openRegister(tester);
      await _fillValidForm(tester);

      await _tapSubmit(tester, expectEnabled: false);

      expect(h.repository.registerCalls, 0);
    });

    testWidgets('marcar la casilla habilita el envio', (tester) async {
      await _openRegister(tester);
      await _fillValidForm(tester);
      await _acceptConsent(tester);

      final button = tester.widget<CauceButton>(
        find.byKey(const Key('register_submit')),
      );
      expect(button.onPressed, isNotNull);
    });
  });

  group('RegisterScreen · envio (US01 CA01)', () {
    testWidgets('manda los datos y el consentimiento del backend', (
      tester,
    ) async {
      final h = await _openRegister(tester);
      await _fillValidForm(tester);
      await _acceptConsent(tester);

      await _tapSubmit(tester);

      expect(h.repository.registerCalls, 1);
      expect(h.repository.lastEmail, 'nuevo@cauce.local');
      expect(h.repository.lastFullName, 'Paciente Nuevo');
      // Los del backend, sin recalcular.
      expect(h.repository.lastConsentVersion, h.repository.consent.version);
      expect(h.repository.lastConsentHash, h.repository.consent.hash);
    });

    testWidgets('un registro aceptado lleva al aviso de verificacion', (
      tester,
    ) async {
      await _openRegister(tester);
      await _fillValidForm(tester);
      await _acceptConsent(tester);

      await _tapSubmit(tester);

      expect(find.byType(VerifyEmailPendingScreen), findsOneWidget);
      expect(find.textContaining('nuevo@cauce.local'), findsOneWidget);
    });
  });

  group('RegisterScreen · validacion local (US01 CA02)', () {
    testWidgets('un nombre de un caracter se rechaza', (tester) async {
      final h = await _openRegister(tester);
      await _fillValidForm(tester);
      await tester.enterText(
        find.byKey(const Key('register_full_name')),
        'A',
      );
      await _acceptConsent(tester);

      await _tapSubmit(tester);

      expect(h.repository.registerCalls, 0);
      expect(
        find.text('El nombre debe tener entre 2 y 150 caracteres'),
        findsOneWidget,
      );
    });

    testWidgets('una contrasena sin digito se rechaza', (tester) async {
      final h = await _openRegister(tester);
      await _fillValidForm(tester);
      await tester.enterText(
        find.byKey(const Key('register_password')),
        'SinDigitos',
      );
      await tester.enterText(
        find.byKey(const Key('register_password_confirmation')),
        'SinDigitos',
      );
      await _acceptConsent(tester);

      await _tapSubmit(tester);

      expect(h.repository.registerCalls, 0);
      expect(
        find.text('Debe incluir una mayuscula, una minuscula y un digito'),
        findsOneWidget,
      );
    });

    testWidgets('un codigo de invitacion mal formado se rechaza', (
      tester,
    ) async {
      final h = await _openRegister(tester);
      await _fillValidForm(tester);
      await tester.enterText(
        find.byKey(const Key('register_invitation_code')),
        'corto',
      );
      await _acceptConsent(tester);

      await _tapSubmit(tester);

      expect(h.repository.registerCalls, 0);
    });

    testWidgets('el codigo vacio es valido: es opcional', (tester) async {
      final h = await _openRegister(tester);
      await _fillValidForm(tester);
      await _acceptConsent(tester);

      await _tapSubmit(tester);

      expect(h.repository.registerCalls, 1);
    });
  });

  group('RegisterScreen · errores del backend (US01 CA02)', () {
    testWidgets('correo duplicado se pinta bajo el campo', (tester) async {
      await _openRegister(
        tester,
        error: const CauceApiError.validation(
          fieldErrors: <String, List<String>>{
            'email': <String>['El correo ya esta registrado.'],
          },
          errorCode: 'validation_error',
        ),
      );
      await _fillValidForm(tester);
      await _acceptConsent(tester);

      await _tapSubmit(tester);

      expect(find.text('El correo ya esta registrado.'), findsOneWidget);
    });

    testWidgets('el 409 muestra el banner y no avanza', (tester) async {
      await _openRegister(
        tester,
        error: const CauceApiError.duplicateEmail(),
      );
      await _fillValidForm(tester);
      await _acceptConsent(tester);

      await _tapSubmit(tester);

      expect(
        find.text('Ya existe una cuenta con este correo'),
        findsOneWidget,
      );
      expect(find.byType(VerifyEmailPendingScreen), findsNothing);
    });

    testWidgets(
      'un consentimiento desactualizado recarga y desmarca la casilla',
      (tester) async {
        // Aceptar un texto y firmar otro invalidaria el consentimiento, asi
        // que el paciente tiene que volver a marcarlo.
        final h = await _openRegister(
          tester,
          error: const CauceApiError.consentMismatch(),
        );
        await _fillValidForm(tester);
        await _acceptConsent(tester);

        await _tapSubmit(tester);

        expect(h.repository.currentConsentCalls, 2);
        final checkbox = tester.widget<CheckboxListTile>(
          find.byKey(const Key('register_consent_checkbox')),
        );
        expect(checkbox.value, isFalse);

        final button = tester.widget<CauceButton>(
          find.byKey(const Key('register_submit')),
        );
        expect(button.onPressed, isNull);
      },
    );

    testWidgets('un 502 de Keycloak invita a reintentar mas tarde', (
      tester,
    ) async {
      await _openRegister(
        tester,
        error: const CauceApiError.keycloakIntegration(),
      );
      await _fillValidForm(tester);
      await _acceptConsent(tester);

      await _tapSubmit(tester);

      expect(
        find.textContaining('Intenta de nuevo en unos minutos'),
        findsOneWidget,
      );
    });
  });
}
