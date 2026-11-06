import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/onboarding/onboarding_draft_store.dart';
import 'package:cauce_mobile/core/router/app_router.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/onboarding/application/onboarding_notifier.dart';
import 'package:cauce_mobile/features/onboarding/presentation/ibs_sss_baseline_screen.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/presentation/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/fake_ibs_sss_repository.dart';
import '../helpers/fake_onboarding_draft_store.dart';
import '../helpers/fake_patients_repository.dart';
import '../helpers/fake_token_storage.dart';

/// El botón de Perfil abre el cuestionario inicial cuando el servidor ya dio
/// el onboarding por cerrado sin línea base, desde la raíz de la app (R10).

const AuthenticatedUserSnapshot _patient = AuthenticatedUserSnapshot(
  userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  email: 'paciente.demo@cauce.local',
  role: 'patient',
  fullName: 'Paciente Demo',
  emailVerified: true,
  isInActivePilot: true,
);

typedef _Harness = ({ProviderContainer container, FakeIbsSssRepository ibsSss});

Future<_Harness> _pumpApp(WidgetTester tester) async {
  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: _patient,
  );
  final borders = appBorders(storage: storage);
  final ibsSss = FakeIbsSssRepository();
  final patients = FakePatientsRepository(
    profile: demoProfile.copyWith(onboardingCompleted: true),
  )..summaryValue = demoSummary.copyWith(
      ibsSssBaseline: null,
      ibsSssLatest: null,
      cumulativeChange: null,
      significantClinicalResponse: false,
    );

  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(storage),
      onboardingDraftStoreProvider
          .overrideWithValue(FakeOnboardingDraftStore()),
      patientsRepositoryProvider.overrideWithValue(patients),
      ibsSssRepositoryProvider.overrideWithValue(ibsSss),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return (container: container, ibsSss: ibsSss);
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

String _location(ProviderContainer container) => container
    .read(appRouterProvider)
    .routerDelegate
    .currentConfiguration
    .uri
    .path;

Future<void> _answerAll(WidgetTester tester) async {
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
}

void main() {
  group('Perfil sin línea base con el onboarding ya cerrado', () {
    testWidgets('el botón del cuestionario lleva a /onboarding/ibs-sss',
        (tester) async {
      final h = await _pumpApp(tester);
      expect(find.byType(HomeScreen), findsOneWidget);

      await _tap(tester, find.byKey(const Key('nav_profile')));
      expect(find.byType(ProfileScreen), findsOneWidget);
      await _tap(tester, find.byKey(const Key('profile_evolution_cta')));

      expect(find.byType(IbsSssBaselineScreen), findsOneWidget);
      expect(_location(h.container), AppRoutes.onboardingBaseline);
    });

    testWidgets(
        'al responder la línea base el onboarding queda completo y '
        'vuelve a Inicio', (tester) async {
      final h = await _pumpApp(tester);
      await _tap(tester, find.byKey(const Key('nav_profile')));
      await _tap(tester, find.byKey(const Key('profile_evolution_cta')));

      await _answerAll(tester);
      await _tap(tester, find.byKey(const Key('ibs_sss_submit')));
      expect(find.byKey(const Key('ibs_sss_result_title')), findsOneWidget);
      await _tap(tester, find.byKey(const Key('ibs_sss_result_continue')));

      expect(h.ibsSss.submitted, hasLength(1));
      expect(
        h.container.read(resolvedOnboardingProvider),
        const OnboardingState.completed(),
      );
      expect(find.byType(HomeScreen), findsOneWidget);
      expect(_location(h.container), AppRoutes.home);
    });
  });
}
