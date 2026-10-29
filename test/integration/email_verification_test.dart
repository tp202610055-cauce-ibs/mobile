import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/network/dio_provider.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/auth/presentation/auth_screens.dart';
import 'package:cauce_mobile/features/history/presentation/history_screen.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/onboarding/presentation/clinical_profile_screen.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/domain/patient_summary.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/canned_http_adapter.dart';
import '../helpers/fake_patients_repository.dart';
import '../helpers/fake_token_storage.dart';

/// Registro sin bloqueo del correo y su recordatorio, desde la raiz de la app.
///
/// Corre contra dos servidores falsos: el estricto, cuyo login tras el
/// registro responde 401, y el nuevo, que inicia sesion sin verificar.
final AppLocalizations l10n = AppLocalizationsEs();

const String _password = 'ClaveSegura1';

const AuthenticatedUserSnapshot _unverified = AuthenticatedUserSnapshot(
  userId: 'e1f2a3b4-0000-0000-0000-000000000000',
  keycloakId: 'c2d3e4f5-0000-0000-0000-000000000000',
  email: 'nuevo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Nuevo',
  emailVerified: false,
  isInActivePilot: true,
);

const PatientSummary _summaryWithoutNutritionist = PatientSummary(
  fullName: 'Paciente Nuevo',
);

CannedResponse _loginOk({bool emailVerified = false}) =>
    CannedResponse.ok(<String, dynamic>{
      'accessToken': 'access-nuevo',
      'refreshToken': 'refresh-nuevo',
      'expiresIn': 900,
      'tokenType': 'Bearer',
      'user': <String, dynamic>{
        ..._unverified.toJson(),
        'emailVerified': emailVerified,
      },
    });

/// Renovacion que trae el usuario con el correo como lo ve el servidor.
CannedResponse _refreshOk({required bool emailVerified}) =>
    CannedResponse.ok(<String, dynamic>{
      'accessToken': 'access-renovado',
      'refreshToken': 'refresh-renovado',
      'expiresIn': 900,
      'tokenType': 'Bearer',
      'user': <String, dynamic>{
        ..._unverified.toJson(),
        'emailVerified': emailVerified,
      },
    });

final CannedResponse _strictLogin = CannedResponse.problem(
  statusCode: 401,
  errorCode: 'invalid_credentials',
);

const CannedResponse _consent = CannedResponse.ok(<String, dynamic>{
  'version': '1.2.0',
  'text': 'Consentimiento informado del piloto Kaelin.',
  'hash': 'sha256:abc123',
});

const CannedResponse _registered = CannedResponse.created(<String, dynamic>{
  'userId': 'e1f2a3b4-0000-0000-0000-000000000000',
  'email': 'nuevo@cauce.local',
  'status': 'PendingActivation',
  'emailVerificationRequired': true,
});

/// Transporte que corta la red en el login, despues de un registro aceptado.
class _OfflineLoginAdapter extends CannedHttpAdapter {
  _OfflineLoginAdapter(super.routes) : super.routed();

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    if (options.path.endsWith('/auth/login')) {
      throw DioException.connectionError(
        requestOptions: options,
        reason: 'sin red',
      );
    }
    return super.fetch(options, null, cancelFuture);
  }
}

/// Renovacion sin red mientras [offline] sea verdadero.
class _FlakyRefreshAdapter extends CannedHttpAdapter {
  _FlakyRefreshAdapter(super.routes) : super.routed();

  bool offline = true;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    if (offline) {
      throw DioException.connectionError(
        requestOptions: options,
        reason: 'sin red',
      );
    }
    return super.fetch(options, null, cancelFuture);
  }
}

typedef _Harness = ({
  ProviderContainer container,
  CannedHttpAdapter adapter,
  CannedHttpAdapter refresh,
  FakeTokenStorage storage,
});

Future<_Harness> _pumpApp(
  WidgetTester tester, {
  CannedResponse? login,
  AuthenticatedUserSnapshot? session,
  bool offlineLogin = false,
  FakePatientsRepository? patients,
  Object? refresh,
  bool offlineRefresh = false,
}) async {
  final routes = <String, Object>{
    'GET /api/v1/consent/current': _consent,
    'POST /api/v1/auth/register': _registered,
    if (login != null) 'POST /api/v1/auth/login': login,
    'POST /api/v1/auth/verification-email/resend':
        const CannedResponse.noContent(),
  };
  final adapter = offlineLogin
      ? _OfflineLoginAdapter(routes)
      : CannedHttpAdapter.routed(routes);
  final storage = session == null
      ? FakeTokenStorage()
      : FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: session,
        );
  final refreshRoutes = <String, Object>{
    'POST /api/v1/auth/refresh': refresh ?? _refreshOk(emailVerified: false),
  };
  final refreshAdapter = offlineRefresh
      ? _FlakyRefreshAdapter(refreshRoutes)
      : CannedHttpAdapter.routed(refreshRoutes);
  final borders = appBorders(
    storage: storage,
    adapter: adapter,
    refreshClient: Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
      ..httpClientAdapter = refreshAdapter,
  );
  final repository = patients ?? FakePatientsRepository();
  repository.summaryValue = _summaryWithoutNutritionist;

  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(storage),
      patientsRepositoryProvider.overrideWithValue(repository),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return (
    container: container,
    adapter: adapter,
    refresh: refreshAdapter,
    storage: storage,
  );
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// CP001 pasos 2 a 9 desde el login.
Future<void> _register(WidgetTester tester, {String? invitationCode}) async {
  await _tap(tester, find.byKey(const Key('login_create_account')));
  await tester.enterText(
    find.byKey(const Key('register_full_name')),
    'Paciente Nuevo',
  );
  await tester.enterText(
    find.byKey(const Key('register_email')),
    'nuevo@cauce.local',
  );
  await tester.enterText(find.byKey(const Key('register_password')), _password);
  await tester.enterText(
    find.byKey(const Key('register_password_confirmation')),
    _password,
  );
  if (invitationCode != null) {
    await tester.enterText(
      find.byKey(const Key('register_invitation_code')),
      invitationCode,
    );
  }
  await tester.pumpAndSettle();
  await _tap(tester, find.byKey(const Key('register_consent_checkbox')));
  await _tap(tester, find.byKey(const Key('register_submit')));
}

Future<void> _login(WidgetTester tester) async {
  await tester.enterText(
    find.byKey(const Key('login_email')),
    'nuevo@cauce.local',
  );
  await tester.enterText(find.byKey(const Key('login_password')), _password);
  await _tap(tester, find.byKey(const Key('login_submit')));
}

final Finder _reminder = find.byKey(const Key('home_email_reminder'));
final Finder _notice = find.byKey(const Key('profile_no_invitation_notice'));

void main() {
  group('CP001 y CP054 · servidor que inicia sesion sin verificar', () {
    testWidgets('el registro lleva al perfil clinico sin pasar por el aviso', (
      tester,
    ) async {
      final h = await _pumpApp(tester, login: _loginOk());

      await _register(tester);

      expect(find.byType(VerifyEmailPendingScreen), findsNothing);
      expect(find.byType(ClinicalProfileScreen), findsOneWidget);
      expect(h.storage.refreshToken, 'refresh-nuevo');
      expect(h.storage.userSnapshot?.emailVerified, isFalse);
      // La contrasena viaja en el login y no queda en el Keystore.
      final login = h.adapter.requestsFor('POST', '/auth/login').single;
      expect(login.body['password'], _password);
      expect(login.body['email'], 'nuevo@cauce.local');
      for (final value in <String?>[
        h.storage.accessToken,
        h.storage.refreshToken,
        h.storage.userSnapshot?.toJson().toString(),
      ]) {
        expect(value, isNot(contains(_password)));
      }
    });

    testWidgets('CP055 paso 5 · sin codigo, el paso 1 muestra el aviso fijo', (
      tester,
    ) async {
      await _pumpApp(tester, login: _loginOk());

      await _register(tester);

      expect(_notice, findsOneWidget);
      expect(find.text(l10n.clinicalProfileNoInvitationNotice), findsOneWidget);
      // No se descarta solo.
      await tester.pump(const Duration(seconds: 30));
      expect(_notice, findsOneWidget);
    });

    testWidgets('CP054 · con codigo no aparece el aviso', (tester) async {
      await _pumpApp(tester, login: _loginOk());

      await _register(tester, invitationCode: 'KAELIN2026');

      expect(find.byType(ClinicalProfileScreen), findsOneWidget);
      expect(_notice, findsNothing);
    });

    testWidgets(
        'CP055 pasos 6 y 7 · Despues, Perfil sin nutricionista y Diario',
        (tester) async {
      await _pumpApp(tester, login: _loginOk());
      await _register(tester);

      await _tap(tester, find.byKey(const Key('onboarding_defer')));
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byKey(const Key('home_onboarding_reminder')), findsOneWidget);
      expect(_reminder, findsOneWidget);

      await _tap(tester, find.byKey(const Key('nav_profile')));
      expect(
        find.descendant(
          of: find.byKey(const Key('profile_nutritionist')),
          matching: find.text(l10n.profileTrackingNutritionistPending),
        ),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('profile_invitation_code_open')),
        findsOneWidget,
      );

      await _tap(tester, find.byKey(const Key('nav_journal')));
      expect(find.byType(HistoryScreen), findsOneWidget);
    });

    testWidgets('un login posterior sin verificar entra a Inicio', (
      tester,
    ) async {
      await _pumpApp(
        tester,
        login: _loginOk(),
        patients: FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      );

      await _login(tester);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(_reminder, findsOneWidget);
    });
  });

  group('Servidor estricto · el login tras el registro falla', () {
    testWidgets('un 401 deja el aviso de verificacion de hoy', (tester) async {
      final h = await _pumpApp(tester, login: _strictLogin);

      await _register(tester);

      expect(find.byType(VerifyEmailPendingScreen), findsOneWidget);
      expect(find.textContaining('nuevo@cauce.local'), findsOneWidget);
      expect(h.storage.refreshToken, isNull);
      expect(h.storage.saveSessionCalls, 0);
    });

    testWidgets('un fallo de red tambien deja el aviso, no el registro', (
      tester,
    ) async {
      await _pumpApp(tester, offlineLogin: true);

      await _register(tester);

      expect(find.byType(VerifyEmailPendingScreen), findsOneWidget);
      expect(find.byType(RegisterScreen), findsNothing);
    });

    testWidgets('el aviso sale al login con cerrar sesion', (tester) async {
      await _pumpApp(tester, login: _strictLogin);
      await _register(tester);

      await _tap(tester, find.byKey(const Key('verify_email_logout')));

      expect(find.byType(LoginScreen), findsOneWidget);
    });

    testWidgets('un login posterior sin verificar sigue en el login', (
      tester,
    ) async {
      await _pumpApp(tester, login: _strictLogin);

      await _login(tester);

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.text(l10n.errorInvalidCredentials), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
    });
  });

  group('Recordatorio de verificacion en Inicio', () {
    Future<_Harness> pumpUnverified(WidgetTester tester) => _pumpApp(
          tester,
          session: _unverified,
          patients: FakePatientsRepository(
            profile: demoProfile.copyWith(onboardingCompleted: true),
          ),
        );

    testWidgets('aparece con el correo sin verificar y no bloquea', (
      tester,
    ) async {
      await pumpUnverified(tester);

      expect(_reminder, findsOneWidget);
      expect(
        find.text(l10n.emailReminderBody('nuevo@cauce.local')),
        findsOneWidget,
      );

      await _tap(tester, find.byKey(const Key('nav_journal')));
      expect(find.byType(HistoryScreen), findsOneWidget);
    });

    testWidgets('no aparece con el correo verificado', (tester) async {
      await _pumpApp(
        tester,
        session: _unverified.copyWith(emailVerified: true),
        patients: FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      );

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(_reminder, findsNothing);
    });

    testWidgets('reenviar pide el correo y lo confirma', (tester) async {
      final h = await pumpUnverified(tester);

      await _tap(tester, find.byKey(const Key('home_email_reminder_resend')));

      final resend =
          h.adapter.requestsFor('POST', '/auth/verification-email/resend');
      expect(resend.single.body['email'], 'nuevo@cauce.local');
      expect(
        find.byKey(const Key('home_email_reminder_resent')),
        findsOneWidget,
      );
    });

    testWidgets('con el limite agotado muestra la espera', (tester) async {
      final h = await pumpUnverified(tester);
      h.adapter.stub(
        'POST',
        '/api/v1/auth/verification-email/resend',
        const CannedResponse(
          statusCode: 429,
          headers: <String, List<String>>{
            'retry-after': <String>['1200'],
          },
        ),
      );

      await _tap(tester, find.byKey(const Key('home_email_reminder_resend')));

      expect(
        find.descendant(of: _reminder, matching: find.byType(CauceErrorBanner)),
        findsOneWidget,
      );
      expect(find.byKey(const Key('home_email_reminder_resent')), findsNothing);
    });

    Future<_Harness> pumpWithRefresh(WidgetTester tester, Object refresh) =>
        _pumpApp(
          tester,
          session: _unverified,
          refresh: refresh,
          patients: FakePatientsRepository(
            profile: demoProfile.copyWith(onboardingCompleted: true),
          ),
        );

    testWidgets('«Ya lo verifiqué» renueva y, sin verificar, lo dice', (
      tester,
    ) async {
      final h = await pumpUnverified(tester);

      await _tap(tester, find.byKey(const Key('home_email_reminder_confirm')));

      final refresh = h.refresh.requestsFor('POST', '/auth/refresh').single;
      expect(refresh.body['refreshToken'], 'refresh-1');
      expect(refresh.body.containsKey('password'), isFalse);
      expect(h.storage.refreshToken, 'refresh-renovado');
      expect(_reminder, findsOneWidget);
      expect(find.text(l10n.emailReminderStillPending), findsOneWidget);
    });

    testWidgets(
        'CP001 · «Ya lo verifiqué» con el servidor verificado la retira',
        (tester) async {
      final h = await pumpWithRefresh(
        tester,
        _refreshOk(emailVerified: true),
      );

      await _tap(tester, find.byKey(const Key('home_email_reminder_confirm')));

      expect(h.storage.userSnapshot?.emailVerified, isTrue);
      expect(_reminder, findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });

    testWidgets('un fallo de red muestra el error y deja reintentar', (
      tester,
    ) async {
      final h = await _pumpApp(
        tester,
        session: _unverified,
        refresh: _refreshOk(emailVerified: true),
        offlineRefresh: true,
        patients: FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      );

      await _tap(tester, find.byKey(const Key('home_email_reminder_confirm')));

      expect(
        find.byKey(const Key('home_email_reminder_error')),
        findsOneWidget,
      );
      expect(find.text(l10n.emailReminderStillPending), findsNothing);
      expect(find.text(l10n.errorNetwork), findsOneWidget);
      expect(h.storage.refreshToken, 'refresh-1');
      expect(find.byType(HomeScreen), findsOneWidget);

      (h.refresh as _FlakyRefreshAdapter).offline = false;
      await _tap(tester, find.byKey(const Key('home_email_reminder_confirm')));

      expect(_reminder, findsNothing);
    });

    testWidgets('una renovacion automatica que verifica la retira sola', (
      tester,
    ) async {
      final h = await pumpWithRefresh(
        tester,
        _refreshOk(emailVerified: true),
      );
      h.adapter.stub('GET', '/api/v1/probe', <CannedResponse>[
        CannedResponse.problem(statusCode: 401, errorCode: 'invalid_token'),
        const CannedResponse.ok(<String, dynamic>{}),
      ]);
      expect(_reminder, findsOneWidget);

      final probe = h.container.read(dioProvider).get<dynamic>('/api/v1/probe');
      await tester.pumpAndSettle();
      await probe;
      await tester.pumpAndSettle();

      expect(h.refresh.requestsFor('POST', '/auth/refresh'), hasLength(1));
      expect(_reminder, findsNothing);
    });

    testWidgets('al volver a primer plano se comprueba en silencio', (
      tester,
    ) async {
      final h = await pumpUnverified(tester);

      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(_reminder, findsOneWidget);
      expect(find.text(l10n.emailReminderStillPending), findsNothing);

      h.storage.userSnapshot = _unverified.copyWith(emailVerified: true);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pumpAndSettle();
      expect(_reminder, findsNothing);
    });
  });
}
