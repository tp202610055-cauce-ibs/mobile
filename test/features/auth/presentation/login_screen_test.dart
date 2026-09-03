import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/auth/presentation/login_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_token_storage.dart';

/// Monta la pantalla aislada del router, con sus dependencias sustituidas.
Future<FakeAuthRepository> _pumpLogin(
  WidgetTester tester, {
  CauceApiError? error,
  Duration delay = Duration.zero,
}) async {
  final repository = FakeAuthRepository(error: error, delay: delay);
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        authRepositoryProvider.overrideWithValue(repository),
        tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
      ],
      child: const MaterialApp(
        localizationsDelegates: <LocalizationsDelegate<Object>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale('es'),
        home: LoginScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return repository;
}

void main() {
  group('LoginScreen · validacion local', () {
    testWidgets('no llama al backend con el formulario vacio', (tester) async {
      final repository = await _pumpLogin(tester);

      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pumpAndSettle();

      // La validacion local ahorra una peticion y cupo de rate limit.
      expect(repository.loginCalls, 0);
      expect(find.text('Este campo es obligatorio'), findsWidgets);
    });

    testWidgets('rechaza un correo mal formado', (tester) async {
      final repository = await _pumpLogin(tester);

      await tester.enterText(
        find.byKey(const Key('login_email')),
        'no-es-mail',
      );
      await tester.enterText(
        find.byKey(const Key('login_password')),
        'Secreta1',
      );
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pumpAndSettle();

      expect(repository.loginCalls, 0);
      expect(
        find.text('Ingresa un correo electronico valido'),
        findsOneWidget,
      );
    });

    testWidgets('el login no exige complejidad de contrasena', (tester) async {
      // Exigirla aca diria que la contrasena "no es valida" cuando en realidad
      // se escribio mal, y filtraria el formato de las aceptadas.
      final repository = await _pumpLogin(tester);

      await tester.enterText(
        find.byKey(const Key('login_email')),
        'paciente.demo@cauce.local',
      );
      await tester.enterText(find.byKey(const Key('login_password')), 'x');
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pumpAndSettle();

      expect(repository.loginCalls, 1);
    });
  });

  group('LoginScreen · envio', () {
    testWidgets('envia las credenciales al repositorio', (tester) async {
      final repository = await _pumpLogin(tester);

      await tester.enterText(
        find.byKey(const Key('login_email')),
        'paciente.demo@cauce.local',
      );
      await tester.enterText(
        find.byKey(const Key('login_password')),
        'Paciente.Demo2026!',
      );
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pumpAndSettle();

      expect(repository.loginCalls, 1);
      expect(repository.lastEmail, 'paciente.demo@cauce.local');
      expect(repository.lastPassword, 'Paciente.Demo2026!');
    });

    testWidgets('durante el envio el boton queda deshabilitado', (
      tester,
    ) async {
      await _pumpLogin(tester, delay: const Duration(milliseconds: 60));

      await tester.enterText(
        find.byKey(const Key('login_email')),
        'a@b.co',
      );
      await tester.enterText(find.byKey(const Key('login_password')), 'x');
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pump();

      // Se asserta sobre CauceButton y no sobre el ElevatedButton interno:
      // el widget del design system es la superficie publica.
      final button = tester.widget<CauceButton>(
        find.byKey(const Key('login_submit')),
      );
      expect(button.loading, isTrue);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pumpAndSettle();
    });
  });

  group('LoginScreen · errores del backend', () {
    testWidgets('credenciales incorrectas muestran el banner', (tester) async {
      await _pumpLogin(tester, error: const CauceApiError.invalidCredentials());

      await tester.enterText(find.byKey(const Key('login_email')), 'a@b.co');
      await tester.enterText(find.byKey(const Key('login_password')), 'mala');
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pumpAndSettle();

      expect(find.byType(CauceErrorBanner), findsOneWidget);
      expect(find.text('Credenciales incorrectas'), findsOneWidget);
    });

    testWidgets('la cuenta bloqueada muestra los minutos restantes', (
      tester,
    ) async {
      await _pumpLogin(
        tester,
        error: CauceApiError.accountLocked(
          lockedUntil: DateTime.now().toUtc().add(const Duration(minutes: 15)),
        ),
      );

      await tester.enterText(find.byKey(const Key('login_email')), 'a@b.co');
      await tester.enterText(find.byKey(const Key('login_password')), 'mala');
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pump();

      expect(
        find.textContaining('Cuenta bloqueada por intentos fallidos'),
        findsOneWidget,
      );
      expect(find.textContaining('14 minutos'), findsOneWidget);

      // El banner arranca un temporizador de un segundo. Sin esta espera el
      // test terminaria con un timer pendiente.
      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('el rate limit muestra la espera', (tester) async {
      await _pumpLogin(
        tester,
        error: const CauceApiError.rateLimited(retryAfterSeconds: 45),
      );

      await tester.enterText(find.byKey(const Key('login_email')), 'a@b.co');
      await tester.enterText(find.byKey(const Key('login_password')), 'x');
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pump();

      expect(find.textContaining('45 segundos'), findsOneWidget);

      await tester.pump(const Duration(seconds: 1));
    });

    testWidgets('la falta de red se comunica al paciente', (tester) async {
      await _pumpLogin(tester, error: const CauceApiError.network());

      await tester.enterText(find.byKey(const Key('login_email')), 'a@b.co');
      await tester.enterText(find.byKey(const Key('login_password')), 'x');
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pumpAndSettle();

      expect(find.textContaining('Sin conexion'), findsOneWidget);
    });

    testWidgets('los errores por campo se pintan bajo su input', (
      tester,
    ) async {
      await _pumpLogin(
        tester,
        error: const CauceApiError.validation(
          fieldErrors: <String, List<String>>{
            'email': <String>["'Email' no es una direccion valida."],
          },
          errorCode: 'validation_error',
        ),
      );

      await tester.enterText(find.byKey(const Key('login_email')), 'a@b.co');
      await tester.enterText(find.byKey(const Key('login_password')), 'x');
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pumpAndSettle();

      expect(
        find.text("'Email' no es una direccion valida."),
        findsOneWidget,
      );
    });

    testWidgets('editar un campo descarta el error anterior', (tester) async {
      await _pumpLogin(tester, error: const CauceApiError.invalidCredentials());

      await tester.enterText(find.byKey(const Key('login_email')), 'a@b.co');
      await tester.enterText(find.byKey(const Key('login_password')), 'mala');
      await tester.tap(find.byKey(const Key('login_submit')));
      await tester.pumpAndSettle();
      expect(find.byType(CauceErrorBanner), findsOneWidget);

      await tester.enterText(
        find.byKey(const Key('login_password')),
        'otra-clave',
      );
      await tester.pumpAndSettle();

      expect(find.byType(CauceErrorBanner), findsNothing);
    });
  });

  group('LoginScreen · contrasena oculta', () {
    testWidgets('arranca oculta y el ojo la revela', (tester) async {
      await _pumpLogin(tester);

      TextField field() =>
          tester.widget<TextField>(find.byType(TextField).last);

      expect(field().obscureText, isTrue);
      // El ojo abierto significa "mostrar": la contrasena esta oculta.
      expect(find.byIcon(TablerIcons.eye), findsOneWidget);

      await tester.tap(find.byIcon(TablerIcons.eye));
      await tester.pumpAndSettle();

      expect(field().obscureText, isFalse);
      expect(find.byIcon(TablerIcons.eye_off), findsOneWidget);
    });
  });
}
