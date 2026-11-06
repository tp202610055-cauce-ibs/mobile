import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/onboarding/onboarding_draft_store.dart';
import 'package:cauce_mobile/features/history/presentation/history_screen.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/evolution_screen.dart';
import 'package:cauce_mobile/features/onboarding/presentation/widgets/onboarding_labels.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/domain/patient_profile.dart';
import 'package:cauce_mobile/features/patients/presentation/profile_screen.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/fake_auth_repository.dart';
import '../helpers/fake_ibs_sss_repository.dart';
import '../helpers/fake_onboarding_draft_store.dart';
import '../helpers/fake_patients_repository.dart';
import '../helpers/fake_recommendations_repository.dart';
import '../helpers/fake_token_storage.dart';

/// Casos de QA que se recorren desde la raíz con el router real (R10).
final AppLocalizations l10n = AppLocalizationsEs();

Future<FakePatientsRepository> _pumpApp(
  WidgetTester tester, {
  required FakePatientsRepository patients,
}) async {
  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: demoUser,
  );
  final borders = appBorders(storage: storage);
  final ibsSss = FakeIbsSssRepository()
    ..evolutionPoints = <IbsSssEvolutionPoint>[
      IbsSssEvolutionPoint(
        assessmentId: 'a-220',
        totalScore: 220,
        assessmentType: IbsSssAssessmentType.baseline,
        completedAt: DateTime.utc(2026, 10, 1),
        nextAssessmentDate: DateTime.utc(2026, 10, 15),
      ),
    ];

  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(storage),
      onboardingDraftStoreProvider
          .overrideWithValue(FakeOnboardingDraftStore()),
      patientsRepositoryProvider.overrideWithValue(patients),
      ibsSssRepositoryProvider.overrideWithValue(ibsSss),
      recommendationsRepositoryProvider.overrideWithValue(
        FakeRecommendationsRepository()
          ..generationError = const CauceApiError.insufficientClinicalHistory(),
      ),
      recommendationRequestStoreProvider.overrideWithValue(
        InMemoryRecommendationRequestStore(),
      ),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return patients;
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Finder _field(String key) => find.descendant(
      of: find.byKey(Key(key)),
      matching: find.byType(EditableText),
    );

void main() {
  group('CP078 · editar sin guardar', () {
    testWidgets(
        'tras las tres variantes, salir deja 62 kg, 165 cm y SII-D en el perfil',
        (tester) async {
      final patients = await _pumpApp(
        tester,
        patients: FakePatientsRepository(
          profile: demoProfile.copyWith(
            weightKg: 62,
            heightCm: 165,
            onboardingCompleted: true,
          ),
        ),
      );
      await _tap(tester, find.byKey(const Key('nav_profile')));
      await _tap(tester, find.byKey(const Key('profile_edit')));
      expect(find.byKey(const Key('profile_edit_screen')), findsOneWidget);

      for (final (weight, height, message) in <(String, String, String)>[
        ('-68', '166', l10n.validationWeightNegative),
        ('64', 'ciento setenta', l10n.validationHeightNotNumber),
        ('', '166', l10n.validationWeightRequired),
      ]) {
        await tester.enterText(_field('profile_edit_weight'), weight);
        await tester.enterText(_field('profile_edit_height'), height);
        await _tap(tester, find.byKey(const Key('profile_edit_save')));
        expect(find.text(message), findsOneWidget);
        expect(find.byKey(const Key('profile_edit_screen')), findsOneWidget);
      }
      // Sale con el retroceso del sistema, como en el teléfono.
      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('profile_edit_screen')), findsNothing);
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(patients.updatedProfiles, isEmpty);
      expect(find.text('62 kg'), findsOneWidget);
      expect(find.text('165 cm'), findsOneWidget);
      expect(
        find.text(OnboardingLabels.ibsSubtype(l10n, IbsSubtypeOption.ibsD)),
        findsOneWidget,
      );
    });
  });

  group('CP085 · sin nutricionista', () {
    Future<void> pumpUnassigned(WidgetTester tester) => _pumpApp(
          tester,
          patients: FakePatientsRepository(
            profile: demoProfile.copyWith(onboardingCompleted: true),
          )..summaryValue = demoSummary.copyWith(nutritionistName: null),
        );

    testWidgets('Inicio no anuncia una recomendación en revisión',
        (tester) async {
      await pumpUnassigned(tester);

      expect(find.byType(HomeScreen), findsOneWidget);
      expect(
        find.byKey(const Key('home_recommendation_pending')),
        findsNothing,
      );
      expect(find.text(l10n.homeRecommendationPendingTitle), findsNothing);
    });

    testWidgets('Consejos explica cómo vincularse y no muestra recomendaciones',
        (tester) async {
      await pumpUnassigned(tester);
      await _tap(tester, find.byKey(const Key('nav_advice')));

      expect(
        find.byKey(const Key('recommendations_no_nutritionist')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('recommendations_pending')), findsNothing);
    });

    testWidgets('el Diario y Evolución abren sin bloqueo', (tester) async {
      await pumpUnassigned(tester);

      await _tap(tester, find.byKey(const Key('nav_journal')));
      expect(find.byType(HistoryScreen), findsOneWidget);
      expect(find.byKey(const Key('history_locked')), findsNothing);

      await _tap(tester, find.byKey(const Key('nav_evolution')));
      expect(find.byType(EvolutionScreen), findsOneWidget);
      expect(find.byKey(const Key('evolution_locked')), findsNothing);
      expect(find.byKey(const Key('evolution_baseline_only')), findsOneWidget);
    });
  });
}
