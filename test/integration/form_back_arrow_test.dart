import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/onboarding/onboarding_draft_store.dart';
import 'package:cauce_mobile/core/router/app_router.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/clinical_notes/presentation/clinical_note_form_screen.dart';
import 'package:cauce_mobile/features/custom_foods/presentation/custom_food_form_screen.dart';
import 'package:cauce_mobile/features/history/domain/history_entry.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/periodic_assessment_screen.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:cauce_mobile/features/meals/presentation/meal_form_screen.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/presentation/profile_edit_screen.dart';
import 'package:cauce_mobile/features/patients/presentation/profile_screen.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/symptoms/presentation/symptom_form_screen.dart';
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

/// La flecha de la barra superior de los formularios apilados, desde la raíz.

const Key _back = Key('cauce_app_bar_back');

Future<ProviderContainer> _pumpApp(WidgetTester tester) async {
  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: demoUser,
  );
  final borders = appBorders(storage: storage);
  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(storage),
      onboardingDraftStoreProvider
          .overrideWithValue(FakeOnboardingDraftStore()),
      patientsRepositoryProvider.overrideWithValue(
        FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      ),
      ibsSssRepositoryProvider.overrideWithValue(FakeIbsSssRepository()),
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
  return container;
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _push(
  WidgetTester tester,
  ProviderContainer container,
  String location, {
  Object? extra,
}) async {
  container.read(appRouterProvider).push<void>(location, extra: extra);
  await tester.pumpAndSettle();
}

/// La flecha está y, al tocarla, el formulario se cierra y vuelve [previous].
Future<void> _expectBackTo(
  WidgetTester tester, {
  required Type form,
  required Type previous,
}) async {
  expect(find.byType(form), findsOneWidget);
  expect(find.byKey(_back), findsOneWidget);

  await tester.tap(find.byKey(_back));
  await tester.pumpAndSettle();

  expect(find.byType(form), findsNothing);
  expect(find.byType(previous), findsOneWidget);
}

void main() {
  group('Formularios apilados · la flecha vuelve a la pantalla anterior', () {
    testWidgets('edición del perfil vuelve a Perfil', (tester) async {
      await _pumpApp(tester);
      await _tap(tester, find.byKey(const Key('nav_profile')));
      await _tap(tester, find.byKey(const Key('profile_edit')));

      await _expectBackTo(
        tester,
        form: ProfileEditScreen,
        previous: ProfileScreen,
      );
    });

    testWidgets('registrar comida vuelve a Inicio', (tester) async {
      await _pumpApp(tester);
      await _tap(tester, find.byKey(cauceFabKey));
      await _tap(tester, find.byKey(const Key('fab_meal')));
      // Cierra el buscador, que el formulario abre al entrar.
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      await _expectBackTo(tester, form: MealFormScreen, previous: HomeScreen);
    });

    testWidgets('registrar síntoma vuelve a Inicio', (tester) async {
      await _pumpApp(tester);
      await _tap(tester, find.byKey(cauceFabKey));
      await _tap(tester, find.byKey(const Key('fab_symptom')));

      await _expectBackTo(
        tester,
        form: SymptomFormScreen,
        previous: HomeScreen,
      );
    });

    testWidgets('cuestionario periódico vuelve a Inicio', (tester) async {
      final container = await _pumpApp(tester);
      await _push(tester, container, AppRoutes.ibsSssPeriodic);

      await _expectBackTo(
        tester,
        form: PeriodicAssessmentScreen,
        previous: HomeScreen,
      );
    });

    testWidgets('plato personalizado vuelve a Inicio', (tester) async {
      final container = await _pumpApp(tester);
      await _push(tester, container, AppRoutes.customFoodNew);

      await _expectBackTo(
        tester,
        form: CustomFoodFormScreen,
        previous: HomeScreen,
      );
    });

    testWidgets('nota clínica vuelve a Inicio', (tester) async {
      final container = await _pumpApp(tester);
      await _push(
        tester,
        container,
        AppRoutes.clinicalNoteNew,
        extra: HistoryEntry(
          kind: HistoryEntryKind.meal,
          occurredAt: DateTime.utc(2026, 10, 26, 13),
          syncState: HistoryEntrySyncState.synced,
          serverId: 'meal-1',
          mealTime: MealTimeOption.lunch,
        ),
      );

      await _expectBackTo(
        tester,
        form: ClinicalNoteFormScreen,
        previous: HomeScreen,
      );
    });
  });

  group('CP078 · salir con la flecha da lo mismo que con el gesto', () {
    for (final arrow in <bool>[true, false]) {
      testWidgets(
          '${arrow ? 'con la flecha' : 'con el gesto'} el perfil sigue en '
          '62 kg y 165 cm', (tester) async {
        final storage = FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: demoUser,
        );
        final patients = FakePatientsRepository(
          profile: demoProfile.copyWith(
            weightKg: 62,
            heightCm: 165,
            onboardingCompleted: true,
          ),
        );
        final container = ProviderContainer(
          overrides: <Override>[
            ...appBorders(storage: storage).overrides,
            tokenStorageProvider.overrideWithValue(storage),
            onboardingDraftStoreProvider
                .overrideWithValue(FakeOnboardingDraftStore()),
            patientsRepositoryProvider.overrideWithValue(patients),
            ibsSssRepositoryProvider.overrideWithValue(FakeIbsSssRepository()),
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
        await _tap(tester, find.byKey(const Key('nav_profile')));
        await _tap(tester, find.byKey(const Key('profile_edit')));
        await tester.enterText(
          find.descendant(
            of: find.byKey(const Key('profile_edit_weight')),
            matching: find.byType(EditableText),
          ),
          '-68',
        );
        await _tap(tester, find.byKey(const Key('profile_edit_save')));

        if (arrow) {
          await tester.tap(find.byKey(_back));
        } else {
          await tester.binding.handlePopRoute();
        }
        await tester.pumpAndSettle();

        expect(find.byType(ProfileEditScreen), findsNothing);
        expect(find.byType(ProfileScreen), findsOneWidget);
        expect(patients.updatedProfiles, isEmpty);
        expect(find.text('62 kg'), findsOneWidget);
        expect(find.text('165 cm'), findsOneWidget);
      });
    }
  });
}
