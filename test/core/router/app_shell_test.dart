import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/config/env.dart';
import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/network/dio_provider.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/history/presentation/history_screen.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/periodic_assessment_screen.dart';
import 'package:cauce_mobile/features/meals/presentation/meal_form_screen.dart';
import 'package:cauce_mobile/features/onboarding/presentation/ibs_sss_baseline_screen.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/presentation/profile_screen.dart';
import 'package:cauce_mobile/features/recommendations/presentation/recommendations_screen.dart';
import 'package:cauce_mobile/features/symptoms/presentation/symptom_form_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/canned_http_adapter.dart';
import '../../helpers/fake_auth_repository.dart';
import '../../helpers/fake_ibs_sss_repository.dart';
import '../../helpers/fake_patients_repository.dart';
import '../../helpers/fake_token_storage.dart';
import '../../helpers/sync_fixtures.dart';

/// Monta la aplicacion entera con sesion valida y el shell a la vista.
///
/// Todo lo que toca la red va con dobles: lo que se ejercita aca es la
/// **navegacion**, y una peticion real la volveria lenta y no determinista.
Future<ProviderContainer> _pumpShell(
  WidgetTester tester, {
  bool onboardingCompleted = true,
  IbsSssAssessmentSummaryData? latestAssessment,
}) async {
  // Desde Mobile-3.2 montar `CauceApp` enciende los servicios de fondo, que
  // necesitan base local, conectividad y transporte. Se falsean los tres: lo
  // que este archivo ejercita es la navegacion, y quien prueba los servicios
  // es `test/integration/background_services_test.dart`.
  Env.loadForTesting(const <String, String>{
    'API_BASE_URL': 'http://localhost:5074',
    'ENV_NAME': 'dev',
    'CLIENT_ID': 'cauce-mobile',
    'DEEP_LINK_SCHEME': 'cauce',
  });
  addTearDown(Env.reset);

  final database = AppDatabase.memory();
  final connectivity = FakeConnectivityMonitor(online: false);
  addTearDown(database.close);
  addTearDown(connectivity.dispose);

  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: demoUser,
  );

  final container = ProviderContainer(
    overrides: <Override>[
      appDatabaseProvider.overrideWithValue(database),
      connectivityMonitorProvider.overrideWithValue(connectivity),
      dioProvider.overrideWith((ref) {
        final dio = buildDio(
          tokenStorage: storage,
          baseUrl: 'http://localhost:5074',
        );
        dio.httpClientAdapter = CannedHttpAdapter(
          const CannedResponse.ok(<String, dynamic>{}),
        );
        return dio;
      }),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(storage),
      patientsRepositoryProvider.overrideWithValue(
        FakePatientsRepository(
          profile: demoProfile.copyWith(
            onboardingCompleted: onboardingCompleted,
          ),
        ),
      ),
      ibsSssRepositoryProvider.overrideWithValue(
        FakeIbsSssRepository()..latest = latestAssessment,
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

/// Toca una pestana y deja asentar la transicion.
///
/// `pump` con una duracion y no `pumpAndSettle`: el Diario arranca cargando y
/// su indicador gira de forma indefinida, de modo que `pumpAndSettle` no
/// devolveria nunca. Lo que se comprueba aca es a donde llego la navegacion,
/// no que la consulta termine.
Future<void> _tapTab(WidgetTester tester, String key) async {
  await tester.tap(find.byKey(Key(key)));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

/// Abre el menu del FAB y devuelve cuando ya esta desplegado.
Future<void> _openFab(WidgetTester tester) async {
  await tester.tap(find.byKey(cauceFabKey));
  await tester.pumpAndSettle();
}

void main() {
  group('AppShell · las cuatro pestanas se alcanzan desde la raiz', () {
    testWidgets('arranca en Inicio', (tester) async {
      await _pumpShell(tester);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(find.byKey(const Key('nav_home')), findsOneWidget);
      expect(find.byKey(const Key('nav_journal')), findsOneWidget);
      expect(find.byKey(const Key('nav_advice')), findsOneWidget);
      expect(find.byKey(const Key('nav_profile')), findsOneWidget);
    });

    testWidgets('Diario', (tester) async {
      await _pumpShell(tester);

      await _tapTab(tester, 'nav_journal');

      expect(find.byType(HistoryScreen), findsOneWidget);
    });

    testWidgets('Consejos', (tester) async {
      await _pumpShell(tester);

      await _tapTab(tester, 'nav_advice');

      expect(find.byType(RecommendationsScreen), findsOneWidget);
    });

    testWidgets('Perfil', (tester) async {
      await _pumpShell(tester);

      await _tapTab(tester, 'nav_profile');

      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets('cambiar de pestana y volver conserva la rama', (tester) async {
      await _pumpShell(tester);

      await _tapTab(tester, 'nav_journal');
      await _tapTab(tester, 'nav_profile');
      await _tapTab(tester, 'nav_journal');

      expect(find.byType(HistoryScreen), findsOneWidget);
    });
  });

  group('AppShell · las tres acciones rapidas llegan a su pantalla', () {
    testWidgets('registrar comida', (tester) async {
      await _pumpShell(tester);
      await _openFab(tester);

      await tester.tap(find.byKey(const Key('fab_meal')));
      await tester.pumpAndSettle();

      expect(find.byType(MealFormScreen), findsOneWidget);
    });

    testWidgets('registrar sintoma', (tester) async {
      await _pumpShell(tester);
      await _openFab(tester);

      await tester.tap(find.byKey(const Key('fab_symptom')));
      await tester.pumpAndSettle();

      expect(find.byType(SymptomFormScreen), findsOneWidget);
    });

    testWidgets('los formularios se abren sin la barra inferior',
        (tester) async {
      // El app bar del design system los dibuja a pantalla completa. Dejar las
      // pestanas a la vista invitaria a cambiar de seccion a mitad de un
      // registro sin enviar.
      await _pumpShell(tester);
      await _openFab(tester);
      await tester.tap(find.byKey(const Key('fab_meal')));
      await tester.pumpAndSettle();

      expect(find.byType(CauceBottomNav), findsNothing);
      expect(find.byKey(cauceFabKey), findsNothing);
    });

    testWidgets('el velo cierra el menu sin ejecutar nada', (tester) async {
      await _pumpShell(tester);
      await _openFab(tester);
      expect(find.byKey(const Key('fab_meal')), findsOneWidget);

      await tester.tapAt(const Offset(20, 20));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('fab_meal')), findsNothing);
      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });

  group('AppShell · los tres estados del cuestionario', () {
    testWidgets('vencido abre el cuestionario periodico', (tester) async {
      await _pumpShell(
        tester,
        latestAssessment: IbsSssAssessmentSummaryData(
          assessmentId: 'd1',
          totalScore: 220,
          assessmentType: IbsSssAssessmentType.baseline,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 9, 1),
          nextAssessmentDate: DateTime.utc(2026, 9, 15),
        ),
      );
      await _openFab(tester);

      await tester.tap(find.byKey(const Key('fab_ibs_sss')));
      await tester.pumpAndSettle();

      expect(find.byType(PeriodicAssessmentScreen), findsOneWidget);
    });

    testWidgets('sin vencer queda a la vista, apagado y con la fecha',
        (tester) async {
      final due = DateTime.now().toUtc().add(const Duration(days: 9));
      await _pumpShell(
        tester,
        latestAssessment: IbsSssAssessmentSummaryData(
          assessmentId: 'd2',
          totalScore: 180,
          assessmentType: IbsSssAssessmentType.periodic,
          cycleNumber: 1,
          completedAt: DateTime.now().toUtc(),
          nextAssessmentDate: due,
        ),
      );
      await _openFab(tester);

      // Sigue visible: una accion que desaparece deja al paciente sin saber
      // que existe.
      expect(find.byKey(const Key('fab_ibs_sss')), findsOneWidget);

      await tester.tap(find.byKey(const Key('fab_ibs_sss')));
      await tester.pumpAndSettle();

      expect(find.byType(PeriodicAssessmentScreen), findsNothing);
    });

    testWidgets('con el onboarding pendiente lleva a completarlo',
        (tester) async {
      await _pumpShell(tester, onboardingCompleted: false);

      // El guard manda al wizard, asi que el shell no esta a la vista: esa es
      // la evidencia de que el onboarding se antepone a todo. Con el perfil
      // ya creado el paso pendiente es el segundo, el cuestionario de linea
      // base, y no el primero.
      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);
      expect(find.byType(CauceBottomNav), findsNothing);
      expect(find.byKey(cauceFabKey), findsNothing);
    });
  });

  group('AppShell · retroceso de Android', () {
    testWidgets('desde otra pestana vuelve a Inicio', (tester) async {
      await _pumpShell(tester);
      await _tapTab(tester, 'nav_profile');
      expect(find.byType(ProfileScreen), findsOneWidget);

      // Se empuja el mensaje que manda Android al tocar atras, que es lo que
      // dispara el `PopScope` del shell.
      await tester.binding.defaultBinaryMessenger.handlePlatformMessage(
        'flutter/navigation',
        const JSONMethodCodec().encodeMethodCall(
          const MethodCall('popRoute'),
        ),
        (_) {},
      );
      await tester.pumpAndSettle();

      expect(find.byType(HomeScreen), findsOneWidget);
    });
  });
}
