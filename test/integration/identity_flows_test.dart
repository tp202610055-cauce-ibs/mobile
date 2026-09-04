import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/config/env.dart';
import 'package:cauce_mobile/core/network/dio_provider.dart';
import 'package:cauce_mobile/core/router/app_router.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/features/auth/presentation/auth_screens.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/canned_http_adapter.dart';
import '../helpers/fake_token_storage.dart';

/// Flujos de identidad de punta a punta.
///
/// A diferencia de los widget tests, que sustituyen el repositorio, estos
/// montan la app completa sobre la pila real: router, notifiers, repositorio,
/// cliente OpenAPI generado, interceptors y `ErrorMapper`. Lo unico sustituido
/// es el transporte HTTP y el almacenamiento seguro, que hablan con la
/// plataforma.
///
/// Es la unica capa donde se verifica que todas esas piezas encajan entre si.
class _RoutedAdapter extends CannedHttpAdapter {
  _RoutedAdapter(this.routes);

  /// Respuesta por sufijo de ruta.
  final Map<String, CannedResponse> routes;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    final match = routes.entries.firstWhere(
      (entry) => options.path.endsWith(entry.key),
      orElse: () => throw StateError('Ruta sin respuesta: ${options.path}'),
    );
    response = match.value;
    return super.fetch(options, null, cancelFuture);
  }
}

const AuthenticatedUserSnapshot _demoSnapshot = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

const Map<String, dynamic> _userJson = <String, dynamic>{
  'userId': '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  'keycloakId': 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  'email': 'paciente.demo@cauce.local',
  'role': 'patient',
  'fullName': 'Paciente Demo',
  'emailVerified': true,
  'isInActivePilot': true,
};

/// Monta la app sobre la pila real, con transporte y Keystore sustituidos.
Future<({ProviderContainer container, _RoutedAdapter adapter})> _pumpApp(
  WidgetTester tester,
  Map<String, CannedResponse> routes, {
  TokenStorage? storage,
}) async {
  final adapter = _RoutedAdapter(routes);
  final tokenStorage = storage ?? FakeTokenStorage();

  final container = ProviderContainer(
    overrides: <Override>[
      tokenStorageProvider.overrideWithValue(tokenStorage),
      // Se sustituye solo el transporte: interceptors, cliente generado y
      // mapeo de errores son los de produccion.
      dioProvider.overrideWith((ref) {
        final dio = buildDio(
          tokenStorage: tokenStorage,
          baseUrl: 'http://localhost:5074',
        );
        dio.httpClientAdapter = adapter;
        return dio;
      }),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return (container: container, adapter: adapter);
}

void main() {
  setUp(() {
    Env.loadForTesting(const <String, String>{
      'API_BASE_URL': 'http://localhost:5074',
      'ENV_NAME': 'dev',
      'CLIENT_ID': 'cauce-mobile',
      'DEEP_LINK_SCHEME': 'cauce',
    });
  });
  tearDown(Env.reset);

  group('US05 · inicio de sesion', () {
    testWidgets('credenciales validas llevan a la home y persisten', (
      tester,
    ) async {
      final storage = FakeTokenStorage();
      final h = await _pumpApp(
        tester,
        <String, CannedResponse>{
          '/auth/login': const CannedResponse.ok(<String, dynamic>{
            'accessToken': 'access-1',
            'refreshToken': 'refresh-1',
            'expiresIn': 900,
            'tokenType': 'Bearer',
            'user': _userJson,
          }),
        },
        storage: storage,
      );

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

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text('Hola, Paciente Demo'), findsOneWidget);
      // Las tres keys del acta M11.
      expect(storage.accessToken, 'access-1');
      expect(storage.refreshToken, 'refresh-1');
      expect(storage.userSnapshot?.keycloakId, isNotNull);
      // El login es ruta anonima: no lleva Bearer.
      expect(
        h.adapter.lastRequest.headers.containsKey('Authorization'),
        isFalse,
      );
    });

    testWidgets('US05 CA02 · un 423 muestra el bloqueo con su countdown', (
      tester,
    ) async {
      await _pumpApp(tester, <String, CannedResponse>{
        '/auth/login': CannedResponse.problem(
          statusCode: 423,
          errorCode: 'account_locked',
          extra: <String, dynamic>{
            'lockedUntil': DateTime.now()
                .toUtc()
                .add(const Duration(minutes: 10))
                .toIso8601String(),
          },
        ),
      });

      await tester.enterText(
        find.byKey(const Key('login_email')),
        'paciente.demo@cauce.local',
      );
      await tester.enterText(find.byKey(const Key('login_password')), 'mala');
      await tester.tap(find.byKey(const Key('login_submit')));
      // Varios frames y no pumpAndSettle: la peticion pasa por la pila real de
      // dio, y el banner del bloqueo deja un ticker vivo que impediria que
      // pumpAndSettle termine.
      for (var i = 0; i < 5; i++) {
        await tester.pump(const Duration(milliseconds: 20));
      }

      expect(
        find.textContaining('Cuenta bloqueada por intentos fallidos'),
        findsOneWidget,
      );
      expect(find.byType(HomeScreen), findsNothing);

      await tester.pump(const Duration(seconds: 1));
    });
  });

  group('US01 · registro con consentimiento', () {
    final routes = <String, CannedResponse>{
      '/consent/current': const CannedResponse.ok(<String, dynamic>{
        'version': '1.2.0',
        'text': 'Consentimiento informado del piloto Kaelin.',
        'hash': 'sha256:abc123',
      }),
      '/auth/register': const CannedResponse.created(<String, dynamic>{
        'userId': 'e1f2a3b4-0000-0000-0000-000000000000',
        'email': 'nuevo@cauce.local',
        'status': 'PendingActivation',
        'emailVerificationRequired': true,
      }),
    };

    testWidgets('CA01 · el flujo completo termina en el aviso de correo', (
      tester,
    ) async {
      final h = await _pumpApp(tester, routes);
      h.container.read(appRouterProvider).push(AppRoutes.register);
      await tester.pumpAndSettle();

      expect(
        find.text('Consentimiento informado del piloto Kaelin.'),
        findsOneWidget,
      );

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

      final checkbox = find.byKey(const Key('register_consent_checkbox'));
      await tester.ensureVisible(checkbox);
      await tester.pumpAndSettle();
      await tester.tap(checkbox);
      await tester.pumpAndSettle();

      final submit = find.byKey(const Key('register_submit'));
      await tester.ensureVisible(submit);
      await tester.pumpAndSettle();
      await tester.tap(submit);
      await tester.pumpAndSettle();

      expect(find.byType(VerifyEmailPendingScreen), findsOneWidget);
      expect(find.textContaining('nuevo@cauce.local'), findsOneWidget);

      // El hash viaja tal como lo devolvio el backend, sin recalcular.
      final body = h.adapter.lastRequest.body;
      expect(body['consentTextHash'], 'sha256:abc123');
      expect(body['consentDocumentVersion'], '1.2.0');
    });
  });

  group('US07 · recuperacion de contrasena', () {
    testWidgets('CA01 y CA02 · solicitud y restablecimiento por deep link', (
      tester,
    ) async {
      final h = await _pumpApp(tester, <String, CannedResponse>{
        '/auth/password-reset/request': const CannedResponse.ok(
          <String, dynamic>{},
        ),
        '/auth/password-reset/confirm': const CannedResponse.ok(
          <String, dynamic>{},
        ),
      });

      // CA01: pedir el enlace.
      await tester.tap(find.byKey(const Key('login_forgot_password')));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byKey(const Key('recovery_email')),
        'paciente.demo@cauce.local',
      );
      await tester.tap(find.byKey(const Key('recovery_submit')));
      await tester.pumpAndSettle();

      expect(find.byType(PasswordRecoverySentScreen), findsOneWidget);
      expect(h.adapter.lastRequest.body['clientId'], 'cauce-mobile');

      // CA02: llegar por el deep link del correo y restablecer.
      h.container
          .read(appRouterProvider)
          .go('${AppRoutes.passwordReset}?token=tok-del-correo');
      await tester.pumpAndSettle();

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

      expect(h.adapter.lastRequest.body['token'], 'tok-del-correo');
      expect(h.adapter.lastRequest.body['newPassword'], 'NuevaClave1');
      expect(find.text('Contrasena actualizada'), findsOneWidget);

      await tester.tap(find.byKey(const Key('reset_success_ok')));
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });

  group('US08 · cierre de sesion', () {
    testWidgets('CA01 · avisa al backend, limpia y vuelve al login', (
      tester,
    ) async {
      final storage = FakeTokenStorage(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        userSnapshot: _demoSnapshot,
      );

      final h = await _pumpApp(
        tester,
        <String, CannedResponse>{
          '/auth/logout': const CannedResponse.noContent(),
        },
        storage: storage,
      );
      expect(find.byType(HomeScreen), findsOneWidget);

      await tester.tap(find.byKey(const Key('home_logout')));
      await tester.pumpAndSettle();

      expect(h.adapter.lastRequest.body['refreshToken'], 'refresh-1');
      expect(h.adapter.lastRequest.body['clientId'], 'cauce-mobile');
      // El logout es ruta protegida: lleva Bearer.
      expect(
        h.adapter.lastRequest.headers['Authorization'],
        'Bearer access-1',
      );
      expect(storage.accessToken, isNull);
      expect(find.byType(LoginScreen), findsOneWidget);
    });
  });
}
