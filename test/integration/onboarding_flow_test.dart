import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/config/env.dart';
import 'package:cauce_mobile/core/network/dio_provider.dart';
import 'package:cauce_mobile/core/router/app_router.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/onboarding/presentation/clinical_profile_screen.dart';
import 'package:cauce_mobile/features/onboarding/presentation/ibs_sss_baseline_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/canned_http_adapter.dart';
import '../helpers/fake_token_storage.dart';

/// Onboarding clinico de punta a punta (US03 y US04).
///
/// Monta la app completa sobre la pila real: router con su guard, notifiers,
/// repositorios, cliente OpenAPI generado, interceptors y `ErrorMapper`. Lo
/// unico sustituido es el transporte HTTP y el Keystore.
///
/// Es la unica capa donde se verifica que el guard, el estado del onboarding y
/// los dos pasos encajan entre si.
final AppLocalizations l10n = AppLocalizationsEs();

const AuthenticatedUserSnapshot _demoSnapshot = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

/// Perfil con el onboarding todavia abierto.
const Map<String, dynamic> _profileIncomplete = <String, dynamic>{
  'profileId': 'a1b2c3d4-0000-4000-8000-000000000001',
  'dateOfBirth': '1990-05-15',
  'biologicalSex': 'Female',
  'weightKg': 62.5,
  'heightCm': 162.0,
  'bmi': 23.81,
  'bmiCategory': 'normal',
  'age': 36,
  'ibsSubtype': 'IbsD',
  'onboardingCompleted': false,
};

/// El mismo perfil, con el onboarding ya cerrado.
///
/// Se escribe entero en vez de con spread para que sea `const` y las
/// respuestas que lo envuelven tambien puedan serlo.
const Map<String, dynamic> _profileComplete = <String, dynamic>{
  'profileId': 'a1b2c3d4-0000-4000-8000-000000000001',
  'dateOfBirth': '1990-05-15',
  'biologicalSex': 'Female',
  'weightKg': 62.5,
  'heightCm': 162.0,
  'bmi': 23.81,
  'bmiCategory': 'normal',
  'age': 36,
  'ibsSubtype': 'IbsD',
  'onboardingCompleted': true,
};

const Map<String, dynamic> _createdProfile = <String, dynamic>{
  'profileId': 'a1b2c3d4-0000-4000-8000-000000000001',
  'bmi': 23.81,
  'bmiCategory': 'normal',
  'age': 36,
  'nutritionistAssigned': false,
};

const Map<String, dynamic> _baselineResult = <String, dynamic>{
  'assessmentId': 'dddddddd-0000-4000-8000-000000000001',
  'totalScore': 220,
  'severityCategory': 'Moderate',
  'nextAssessmentDate': '2026-09-29',
  'triggeredOnboardingCompletion': true,
};

const CannedListResponse _catalog = CannedListResponse(<Map<String, dynamic>>[
  <String, dynamic>{
    'allergyId': 'aaaaaaaa-0000-4000-8000-000000000001',
    'name': 'Gluten',
    'allergyType': 'Intolerance',
  },
]);

/// Monta la app con una sesion ya persistida en el Keystore.
///
/// Se arranca con sesion para no repetir el login, que ya cubren los flujos de
/// identidad. Lo que importa aca es lo que pasa despues.
Future<({ProviderContainer container, CannedHttpAdapter adapter})> _pumpApp(
  WidgetTester tester,
  Map<String, Object> routes,
) async {
  final adapter = CannedHttpAdapter.routed(routes);
  final storage = FakeTokenStorage();
  await storage.saveSession(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    user: _demoSnapshot,
  );

  final container = ProviderContainer(
    overrides: <Override>[
      tokenStorageProvider.overrideWithValue(storage),
      // Solo el transporte se sustituye: interceptors, cliente generado y
      // mapeo de errores son los de produccion.
      dioProvider.overrideWith((ref) {
        final dio = buildDio(
          tokenStorage: storage,
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

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _type(WidgetTester tester, Finder finder, String text) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.enterText(finder, text);
  await tester.pumpAndSettle();
}

/// Completa el paso 1 y lo envia.
Future<void> _completeProfileStep(WidgetTester tester) async {
  await _tap(tester, find.byKey(const Key('profile_date_of_birth')));
  await _tap(tester, find.byType(TextButton).last);
  await _type(tester, find.byKey(const Key('profile_weight')), '62.5');
  await _type(tester, find.byKey(const Key('profile_height')), '162');
  await _tap(tester, find.text(l10n.biologicalSexFemale));
  await _tap(tester, find.text(l10n.ibsSubtypeD));
  await _tap(tester, find.byKey(const Key('profile_submit')));
}

/// Responde las cinco dimensiones y envia.
Future<void> _completeBaselineStep(WidgetTester tester) async {
  for (final key in <String>[
    'ibs_sss_painSeverity',
    'ibs_sss_painFrequency',
    'ibs_sss_bloatingSeverity',
    'ibs_sss_bowelHabitsDissatisfaction',
    'ibs_sss_lifeInterference',
  ]) {
    final finder = find.byKey(Key(key));
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.drag(
      find.descendant(of: finder, matching: find.byType(Slider)),
      const Offset(20, 0),
    );
    await tester.pumpAndSettle();
  }
  await _tap(tester, find.byKey(const Key('ibs_sss_submit')));
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

  group('US03 y US04 · onboarding completo', () {
    testWidgets('sin perfil, el paciente recorre los dos pasos y llega a home',
        (tester) async {
      final h = await _pumpApp(tester, <String, Object>{
        // El GET devuelve 404 primero (sin perfil) y el perfil creado despues.
        // Es la secuencia real que ve el dispositivo a lo largo del wizard.
        'GET /api/v1/patients/profile': <CannedResponse>[
          CannedResponse.problem(
            statusCode: 404,
            errorCode: 'patient_profile_not_found',
          ),
          const CannedResponse.ok(_profileComplete),
        ],
        'POST /api/v1/patients/profile':
            const CannedResponse.created(_createdProfile),
        'GET /api/v1/allergies': _catalog,
        'POST /api/v1/patients/allergies': const CannedResponse.created(
          <String, dynamic>{
            'patientAllergyId': 'bbbbbbbb-0000-4000-8000-000000000001',
          },
        ),
        'POST /api/v1/ibs-sss': const CannedResponse.created(_baselineResult),
      });

      // El guard desvia del splash al paso 1 sin pasar por la home.
      expect(find.byType(ClinicalProfileScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);

      await _completeProfileStep(tester);

      // El paso 1 quedo guardado y el guard avanza al paso 2.
      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);
      expect(
        h.adapter.requestsFor('POST', '/api/v1/patients/profile'),
        hasLength(1),
      );

      await _completeBaselineStep(tester);

      // El resultado se muestra antes de cerrar: el paciente ve su puntaje.
      expect(find.byKey(const Key('ibs_sss_result_title')), findsOneWidget);
      expect(find.text(l10n.ibsSssResultScore(220)), findsOneWidget);

      await _tap(tester, find.byKey(const Key('ibs_sss_result_continue')));

      // Recien al confirmar el resultado el guard lleva a la home.
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byKey(const Key('home_onboarding_reminder')), findsNothing);
    });

    testWidgets('las cinco dimensiones viajan en una sola peticion',
        (tester) async {
      final h = await _pumpApp(tester, <String, Object>{
        'GET /api/v1/patients/profile': const CannedResponse.ok(
          _profileIncomplete,
        ),
        'POST /api/v1/ibs-sss': const CannedResponse.created(_baselineResult),
      });

      await _completeBaselineStep(tester);

      final requests = h.adapter.requestsFor('POST', '/api/v1/ibs-sss');
      expect(requests, hasLength(1));
      final body = requests.single.body;
      expect(body['assessmentType'], 'Baseline');
      for (final field in <String>[
        'painSeverity',
        'painFrequency',
        'bloatingSeverity',
        'bowelHabitsDissatisfaction',
        'lifeInterference',
      ]) {
        expect(body[field], isA<int>(), reason: field);
      }
    });
  });

  group('US03 CA05 y US04 CA05 · aplazar', () {
    testWidgets('aplazar el paso 1 lleva a la home con el recordatorio',
        (tester) async {
      await _pumpApp(tester, <String, Object>{
        'GET /api/v1/patients/profile': CannedResponse.problem(
          statusCode: 404,
          errorCode: 'patient_profile_not_found',
        ),
        'GET /api/v1/allergies': _catalog,
      });

      expect(find.byType(ClinicalProfileScreen), findsOneWidget);

      await _tap(tester, find.byKey(const Key('onboarding_defer')));

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byKey(const Key('home_onboarding_reminder')), findsOneWidget);
      expect(find.text(l10n.onboardingReminderBodyProfile), findsOneWidget);
    });

    testWidgets('aplazar el paso 2 deja el recordatorio del cuestionario',
        (tester) async {
      await _pumpApp(tester, <String, Object>{
        'GET /api/v1/patients/profile': const CannedResponse.ok(
          _profileIncomplete,
        ),
      });

      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);

      await _tap(tester, find.byKey(const Key('onboarding_defer')));

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.text(l10n.onboardingReminderBodyBaseline), findsOneWidget);
    });

    testWidgets('reanudar desde el recordatorio vuelve al paso pendiente',
        (tester) async {
      await _pumpApp(tester, <String, Object>{
        'GET /api/v1/patients/profile': const CannedResponse.ok(
          _profileIncomplete,
        ),
        'POST /api/v1/ibs-sss': const CannedResponse.created(_baselineResult),
      });

      await _tap(tester, find.byKey(const Key('onboarding_defer')));
      expect(find.byType(HomeScreen), findsOneWidget);

      await _tap(tester, find.byKey(const Key('home_onboarding_resume')));

      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);
    });
  });

  group('Onboarding ya completo', () {
    testWidgets('el paciente entra directo a la home, sin wizard',
        (tester) async {
      await _pumpApp(tester, <String, Object>{
        'GET /api/v1/patients/profile':
            const CannedResponse.ok(_profileComplete),
      });

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(ClinicalProfileScreen), findsNothing);
      expect(find.byType(IbsSssBaselineScreen), findsNothing);
      expect(find.byKey(const Key('home_onboarding_reminder')), findsNothing);
    });

    testWidgets('sin red el paciente queda en la home y no en un wizard',
        (tester) async {
      // Diseno offline-first: sin poder consultar el perfil, el guard no
      // redirige. Encerrarlo en un wizard que tampoco podria enviar seria lo
      // peor de los dos mundos.
      await _pumpApp(tester, <String, Object>{
        'GET /api/v1/patients/profile': CannedResponse.problem(
          statusCode: 500,
          errorCode: 'internal_server_error',
        ),
      });

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(ClinicalProfileScreen), findsNothing);
    });
  });

  group('Reconciliacion con el servidor', () {
    testWidgets('un 409 de perfil duplicado relee y avanza al paso 2',
        (tester) async {
      // El envio anterior si entro y el dispositivo no vio la respuesta.
      // Insistir con el paso 1 dejaria al paciente sin salida.
      await _pumpApp(tester, <String, Object>{
        'GET /api/v1/patients/profile': <CannedResponse>[
          CannedResponse.problem(
            statusCode: 404,
            errorCode: 'patient_profile_not_found',
          ),
          const CannedResponse.ok(_profileIncomplete),
        ],
        'POST /api/v1/patients/profile': CannedResponse.problem(
          statusCode: 409,
          errorCode: 'duplicate_patient_profile',
        ),
        'GET /api/v1/allergies': _catalog,
      });

      expect(find.byType(ClinicalProfileScreen), findsOneWidget);

      await _completeProfileStep(tester);

      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);
    });

    testWidgets('un 409 de linea base duplicada cierra el onboarding',
        (tester) async {
      await _pumpApp(tester, <String, Object>{
        'GET /api/v1/patients/profile': <CannedResponse>[
          const CannedResponse.ok(_profileIncomplete),
          const CannedResponse.ok(_profileComplete),
        ],
        'POST /api/v1/ibs-sss': CannedResponse.problem(
          statusCode: 409,
          errorCode: 'duplicate_baseline_assessment',
        ),
      });

      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);

      await _completeBaselineStep(tester);

      // La relectura descubre que el servidor ya lo tenia registrado.
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });

  group('El onboarding no atropella a la identidad', () {
    testWidgets('sin sesion el guard manda al login, no al wizard',
        (tester) async {
      final adapter = CannedHttpAdapter.routed(<String, Object>{
        'GET /api/v1/patients/profile': CannedResponse.problem(
          statusCode: 404,
          errorCode: 'patient_profile_not_found',
        ),
      });
      final storage = FakeTokenStorage();
      final container = ProviderContainer(
        overrides: <Override>[
          tokenStorageProvider.overrideWithValue(storage),
          dioProvider.overrideWith((ref) {
            final dio = buildDio(
              tokenStorage: storage,
              baseUrl: 'http://localhost:5074',
            );
            dio.httpClientAdapter = adapter;
            return dio;
          }),
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

      expect(find.text(l10n.loginTitle), findsOneWidget);
      expect(find.byType(ClinicalProfileScreen), findsNothing);
      // Sin Bearer no se consulta un endpoint protegido.
      expect(adapter.requests, isEmpty);
    });

    testWidgets('las rutas del wizard no son navegables sin paso pendiente',
        (tester) async {
      final h = await _pumpApp(tester, <String, Object>{
        'GET /api/v1/patients/profile':
            const CannedResponse.ok(_profileComplete),
      });

      h.container.read(appRouterProvider).go(AppRoutes.onboardingProfile);
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byType(ClinicalProfileScreen), findsNothing);
    });
  });
}
