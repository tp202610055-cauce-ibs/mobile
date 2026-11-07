import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/onboarding/onboarding_draft_store.dart';
import 'package:cauce_mobile/core/router/app_router.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/auth/presentation/auth_screens.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/onboarding/presentation/widgets/onboarding_labels.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/domain/patient_profile.dart';
import 'package:cauce_mobile/features/patients/domain/patient_summary.dart';
import 'package:cauce_mobile/features/patients/presentation/profile_screen.dart';
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
import '../helpers/fake_token_storage.dart';

/// Casos del registro, el asistente y el perfil, desde la raíz (R10).
final AppLocalizations l10n = AppLocalizationsEs();

typedef _Harness = ({ProviderContainer container, FakeAuthRepository auth});

Future<_Harness> _pumpApp(
  WidgetTester tester, {
  FakePatientsRepository? patients,
  bool session = true,
}) async {
  final storage = session
      ? FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: demoUser,
        )
      : FakeTokenStorage();
  final auth = FakeAuthRepository();
  final container = ProviderContainer(
    overrides: <Override>[
      ...appBorders(storage: storage).overrides,
      tokenStorageProvider.overrideWithValue(storage),
      authRepositoryProvider.overrideWithValue(auth),
      onboardingDraftStoreProvider
          .overrideWithValue(FakeOnboardingDraftStore()),
      patientsRepositoryProvider.overrideWithValue(
        patients ??
            FakePatientsRepository(
              profile: demoProfile.copyWith(onboardingCompleted: true),
            ),
      ),
      ibsSssRepositoryProvider.overrideWithValue(FakeIbsSssRepository()),
    ],
  );
  addTearDown(container.dispose);
  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return (container: container, auth: auth);
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

Finder _field(String key) => find.descendant(
      of: find.byKey(Key(key)),
      matching: find.byType(EditableText),
    );

String _text(WidgetTester tester, String key) =>
    tester.widget<EditableText>(_field(key)).controller.text;

Finder _inProfile(String text) => find.descendant(
      of: find.byType(ProfileScreen),
      matching: find.text(text),
    );

void main() {
  group('CP070 · perfil completo con su evolución', () {
    final assignedAt = DateTime.now().toUtc().subtract(
          const Duration(days: 20),
        );

    for (final (variant, latest, change, significant)
        in <(String, int, int, bool)>[
      ('A', 250, -70, true),
      ('B', 290, -30, false),
      ('C', 270, -50, true),
    ]) {
      testWidgets(
          '$variant: 320 a $latest muestra ${-change} puntos menos '
          '${significant ? 'con' : 'sin'} la respuesta clínica',
          (tester) async {
        await _pumpApp(
          tester,
          patients: FakePatientsRepository(
            profile: demoProfile.copyWith(
              weightKg: 62,
              heightCm: 165,
              onboardingCompleted: true,
            ),
          )..summaryValue = PatientSummary(
              fullName: 'María Fernanda López Quispe',
              ibsSubtype: IbsSubtypeOption.ibsD,
              nutritionistName: 'Ana Gómez',
              nutritionistAssignedAt: assignedAt,
              ibsSssBaseline: 320,
              ibsSssLatest: latest,
              cumulativeChange: change,
              significantClinicalResponse: significant,
            ),
        );
        await _tap(tester, find.byKey(const Key('nav_profile')));

        expect(_inProfile('María Fernanda López Quispe'), findsOneWidget);
        expect(_inProfile('62 kg'), findsOneWidget);
        expect(_inProfile('165 cm'), findsOneWidget);
        expect(
          _inProfile(OnboardingLabels.ibsSubtype(l10n, IbsSubtypeOption.ibsD)),
          findsOneWidget,
        );
        expect(_inProfile('Ana Gómez'), findsOneWidget);
        expect(
          _inProfile(OnboardingLabels.date(assignedAt.toLocal())),
          findsOneWidget,
        );
        await tester.ensureVisible(
          find.byKey(const Key('profile_evolution_card')),
        );
        expect(_inProfile(l10n.profileEvolutionScore(320)), findsOneWidget);
        expect(_inProfile(l10n.profileEvolutionScore(latest)), findsOneWidget);
        expect(
          _inProfile(l10n.profileEvolutionChangeDown(-change)),
          findsOneWidget,
        );
        expect(
          find.byKey(const Key('profile_evolution_achievement')),
          significant ? findsOneWidget : findsNothing,
        );
      });
    }
  });

  group('CP010 · IMC en vivo', () {
    testWidgets('la secuencia del CP da sus valores y clasificaciones',
        (tester) async {
      await _pumpApp(tester, patients: FakePatientsRepository());
      final weight = find.byKey(const Key('profile_weight'));
      final height = find.byKey(const Key('profile_height'));
      String bmi() =>
          tester.widget<Text>(find.byKey(const Key('bmi_value'))).data!;
      String category() =>
          tester.widget<Text>(find.byKey(const Key('bmi_category'))).data!;

      expect(find.byKey(const Key('bmi_pending')), findsOneWidget);
      await _type(tester, weight, '62');
      expect(find.byKey(const Key('bmi_value')), findsNothing);

      for (final (field, value, expectedBmi, expectedCategory)
          in <(Finder, String, String, String)>[
        (height, '165', '22.77', l10n.bmiCategoryNormal),
        (weight, '90', '33.06', l10n.bmiCategoryObese),
        (height, '180', '27.78', l10n.bmiCategoryOverweight),
        (weight, '50', '15.43', l10n.bmiCategoryUnderweight),
      ]) {
        await _type(tester, field, value);
        expect(bmi(), l10n.bmiValue(expectedBmi), reason: value);
        expect(category(), expectedCategory, reason: value);
      }

      await _type(tester, weight, '');
      expect(find.byKey(const Key('bmi_value')), findsNothing);
      expect(find.byKey(const Key('bmi_category')), findsNothing);

      await _type(tester, weight, '62');
      expect(bmi(), l10n.bmiValue('19.14'));
      expect(category(), l10n.bmiCategoryNormal);
    });
  });

  group('CP002 · variante B2', () {
    testWidgets(
        '«Segura1» de 7 caracteres no crea la cuenta, avisa y conserva el '
        'nombre y el correo', (tester) async {
      final h = await _pumpApp(tester, session: false);
      h.container.read(appRouterProvider).push(AppRoutes.register);
      await tester.pumpAndSettle();

      await _type(
        tester,
        find.byKey(const Key('register_full_name')),
        'María Fernanda López Quispe',
      );
      await _type(
        tester,
        find.byKey(const Key('register_email')),
        'registro.cp002@ejemplo.com',
      );
      await _type(
        tester,
        find.byKey(const Key('register_password')),
        'Segura1',
      );
      await _type(
        tester,
        find.byKey(const Key('register_password_confirmation')),
        'Segura1',
      );
      final consent = find.byKey(const Key('register_consent_checkbox'));
      await _tap(tester, consent);
      await _tap(tester, find.byKey(const Key('register_submit')));

      expect(h.auth.registerCalls, 0);
      expect(find.text(l10n.validationPasswordTooShort), findsWidgets);
      expect(
        _text(tester, 'register_full_name'),
        'María Fernanda López Quispe',
      );
      expect(_text(tester, 'register_email'), 'registro.cp002@ejemplo.com');
    });
  });

  group('CP020 · paso 6', () {
    testWidgets(
        'tras cerrar sesión, el atrás del sistema deja en el login sin datos de '
        'la cuenta', (tester) async {
      await _pumpApp(tester);
      await _tap(tester, find.byKey(const Key('nav_journal')));
      await _tap(tester, find.byKey(const Key('nav_profile')));
      await _tap(tester, find.byKey(const Key('profile_logout')));
      await _tap(tester, find.byKey(cauceConfirmAcceptKey));
      expect(find.byType(LoginScreen), findsOneWidget);

      await tester.binding.handlePopRoute();
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(HomeScreen), findsNothing);
      expect(find.byType(ProfileScreen), findsNothing);
    });
  });

  group('CP009 · edición posterior del perfil', () {
    testWidgets(
        '64 kg y SII-C se ven de inmediato y siguen tras volver a entrar',
        (tester) async {
      final patients = FakePatientsRepository(
        profile: demoProfile.copyWith(
          weightKg: 62,
          heightCm: 165,
          onboardingCompleted: true,
        ),
      );
      final h = await _pumpApp(tester, patients: patients);
      await _tap(tester, find.byKey(const Key('nav_profile')));
      await _tap(tester, find.byKey(const Key('profile_edit')));

      await tester.enterText(_field('profile_edit_weight'), '64');
      await _tap(tester, find.text(l10n.ibsSubtypeC));
      await _tap(tester, find.byKey(const Key('profile_edit_save')));

      final subtypeC = OnboardingLabels.ibsSubtype(l10n, IbsSubtypeOption.ibsC);
      expect(find.byType(ProfileScreen), findsOneWidget);
      expect(_inProfile('64 kg'), findsOneWidget);
      expect(_inProfile(subtypeC), findsOneWidget);

      await tester.runAsync(
        () => h.container.read(sessionNotifierProvider.notifier).logout(),
      );
      await tester.pumpAndSettle();
      await h.container.read(sessionNotifierProvider.notifier).loginSucceeded(
            accessToken: 'access-2',
            refreshToken: 'refresh-2',
            user: demoUser,
          );
      await tester.pumpAndSettle();
      await _tap(tester, find.byKey(const Key('nav_profile')));

      expect(_inProfile('64 kg'), findsOneWidget);
      expect(_inProfile(subtypeC), findsOneWidget);
    });
  });
}
