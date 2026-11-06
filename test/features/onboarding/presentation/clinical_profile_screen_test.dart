import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/onboarding/onboarding_draft_store.dart';
import 'package:cauce_mobile/core/sync/local_record_owner.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/onboarding/presentation/clinical_profile_screen.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/domain/allergy.dart';
import 'package:cauce_mobile/features/patients/domain/patient_profile.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_onboarding_draft_store.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

final AppLocalizations l10n = AppLocalizationsEs();

/// Monta el asistente con los repositorios sustituidos.
///
/// Sin router: la pantalla no navega por su cuenta, el guard lo hace.
Future<({FakePatientsRepository patients, FakeOnboardingDraftStore drafts})>
    _pump(
  WidgetTester tester, {
  FakePatientsRepository? repository,
  FakeOnboardingDraftStore? drafts,
}) async {
  final patients = repository ?? FakePatientsRepository();
  final store = drafts ?? FakeOnboardingDraftStore();
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        patientsRepositoryProvider.overrideWithValue(patients),
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
        onboardingDraftStoreProvider.overrideWithValue(store),
        localRecordOwnerProvider.overrideWithValue(() => 'patient-1'),
      ],
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: const <LocalizationsDelegate<Object>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        home: const ClinicalProfileScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return (patients: patients, drafts: store);
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

String? _text(WidgetTester tester, String key) => tester
    .widget<TextField>(
      find.descendant(
        of: find.byKey(Key(key)),
        matching: find.byType(TextField),
      ),
    )
    .controller
    ?.text;

String _stepLabel(WidgetTester tester) =>
    tester.widget<Text>(find.byKey(const Key('onboarding_step_label'))).data!;

/// CP007 pasos 2 a 5.
Future<void> _fillPhysical(
  WidgetTester tester, {
  String dateOfBirth = '14/03/1991',
  String weight = '62',
  String height = '165',
}) async {
  await _type(
    tester,
    find.byKey(const Key('profile_date_of_birth')),
    dateOfBirth,
  );
  await _tap(tester, find.text(l10n.biologicalSexFemale));
  await _type(tester, find.byKey(const Key('profile_weight')), weight);
  await _type(tester, find.byKey(const Key('profile_height')), height);
}

Future<void> _continue(WidgetTester tester) =>
    _tap(tester, find.byKey(const Key('profile_continue')));

/// CP007 pasos 7 y 8.
Future<void> _fillHistory(WidgetTester tester) async {
  await _tap(tester, find.text(l10n.ibsSubtypeD));
  await _tap(tester, find.byKey(const Key('allergies_none_known')));
}

void main() {
  group('ClinicalProfileScreen · paso 1, datos fisicos', () {
    testWidgets('es el paso 1 de 3 y no muestra los antecedentes',
        (tester) async {
      await _pump(tester);

      expect(_stepLabel(tester), l10n.onboardingStepLabel(1, 3));
      expect(find.byKey(const Key('profile_weight')), findsOneWidget);
      expect(find.byKey(const Key('profile_ibs_subtype')), findsNothing);
      expect(find.byKey(const Key('profile_continue')), findsOneWidget);
    });

    testWidgets('ofrece las tres opciones de sexo', (tester) async {
      await _pump(tester);

      expect(find.text(l10n.biologicalSexFemale), findsOneWidget);
      expect(find.text(l10n.biologicalSexMale), findsOneWidget);
      expect(find.text(l10n.biologicalSexOther), findsOneWidget);
    });

    testWidgets('la fecha se escribe como dd/mm/aaaa (CP007 paso 2)',
        (tester) async {
      await _pump(tester);

      await _type(
        tester,
        find.byKey(const Key('profile_date_of_birth')),
        '14/03/1991',
      );

      expect(_text(tester, 'profile_date_of_birth'), '14/03/1991');
      expect(find.text(l10n.validationDateFormat), findsNothing);
    });

    testWidgets('el teclado del peso permite el signo menos y decimales',
        (tester) async {
      await _pump(tester);

      final field = tester.widget<EditableText>(
        find.descendant(
          of: find.byKey(const Key('profile_weight')),
          matching: find.byType(EditableText),
        ),
      );
      expect(
        field.keyboardType,
        const TextInputType.numberWithOptions(signed: true, decimal: true),
      );
    });

    testWidgets('con datos validos avanza al paso de antecedentes (CP007)',
        (tester) async {
      await _pump(tester);

      await _fillPhysical(tester);
      expect(
        tester.widget<Text>(find.byKey(const Key('bmi_category'))).data,
        'Normal',
      );
      await _continue(tester);

      expect(_stepLabel(tester), l10n.onboardingStepLabel(2, 3));
      expect(find.byKey(const Key('profile_ibs_subtype')), findsOneWidget);
      for (final option in IbsSubtypeOption.values) {
        expect(find.text(_subtypeLabel(option)), findsOneWidget);
      }
      expect(find.text('Gluten'), findsOneWidget);
    });

    testWidgets('volver al paso 1 conserva lo escrito', (tester) async {
      await _pump(tester);
      await _fillPhysical(tester);
      await _continue(tester);

      await _tap(tester, find.byKey(const Key('profile_back')));

      expect(_stepLabel(tester), l10n.onboardingStepLabel(1, 3));
      expect(_text(tester, 'profile_weight'), '62');
      expect(_text(tester, 'profile_date_of_birth'), '14/03/1991');
    });
  });

  group('ClinicalProfileScreen · IMC en vivo (CA04, CP010)', () {
    testWidgets('sin peso ni estatura no muestra numero', (tester) async {
      await _pump(tester);

      expect(find.byKey(const Key('bmi_pending')), findsOneWidget);
      expect(find.byKey(const Key('bmi_value')), findsNothing);
    });

    for (final value in <String>['NaN', 'Infinity', '-Infinity', '1e999']) {
      testWidgets('un peso «$value» no produce un IMC', (tester) async {
        await _pump(tester);

        await _type(tester, find.byKey(const Key('profile_weight')), value);
        await _type(tester, find.byKey(const Key('profile_height')), '165');

        expect(find.byKey(const Key('bmi_pending')), findsOneWidget);
        expect(find.byKey(const Key('bmi_value')), findsNothing);
      });
    }

    testWidgets('con peso y estatura lo calcula y lo clasifica',
        (tester) async {
      await _pump(tester);

      await _type(tester, find.byKey(const Key('profile_weight')), '62.5');
      await _type(tester, find.byKey(const Key('profile_height')), '162');

      expect(
        tester.widget<Text>(find.byKey(const Key('bmi_value'))).data,
        l10n.bmiValue('23.81'),
      );
    });

    testWidgets('se recalcula al cambiar el peso', (tester) async {
      await _pump(tester);

      await _type(tester, find.byKey(const Key('profile_weight')), '62.5');
      await _type(tester, find.byKey(const Key('profile_height')), '162');
      await _type(tester, find.byKey(const Key('profile_weight')), '95');

      expect(
        tester.widget<Text>(find.byKey(const Key('bmi_category'))).data,
        l10n.bmiCategoryObese,
      );
    });

    testWidgets('el encuadre del IMC es neutro, sin alarma', (tester) async {
      await _pump(tester);

      await _type(tester, find.byKey(const Key('profile_weight')), '95');
      await _type(tester, find.byKey(const Key('profile_height')), '162');

      expect(find.text(l10n.bmiNote), findsOneWidget);
      expect(l10n.bmiNote, isNot(contains('!')));
    });
  });

  group('ClinicalProfileScreen · CP008, el asistente no avanza', () {
    testWidgets('A: sin peso señala que es obligatorio y conserva lo demas',
        (tester) async {
      final h = await _pump(tester);

      await _fillPhysical(tester, weight: '');
      await _continue(tester);

      expect(_stepLabel(tester), l10n.onboardingStepLabel(1, 3));
      expect(find.text(l10n.validationRequired), findsOneWidget);
      expect(_text(tester, 'profile_height'), '165');
      expect(_text(tester, 'profile_date_of_birth'), '14/03/1991');
      expect(h.drafts.writes, 0);
    });

    testWidgets('B: un peso negativo no es valido', (tester) async {
      await _pump(tester);

      await _fillPhysical(tester, weight: '-68');
      await _continue(tester);

      expect(_stepLabel(tester), l10n.onboardingStepLabel(1, 3));
      expect(find.text(l10n.validationWeightInvalid), findsOneWidget);
      expect(_text(tester, 'profile_weight'), '-68');
    });

    testWidgets('C: 400 kg esta fuera del rango permitido', (tester) async {
      await _pump(tester);

      await _fillPhysical(tester, weight: '400');
      await _continue(tester);

      expect(_stepLabel(tester), l10n.onboardingStepLabel(1, 3));
      expect(find.text(l10n.validationWeightOutOfRange), findsOneWidget);
    });

    testWidgets('D: una fecha futura escrita no es valida', (tester) async {
      await _pump(tester);

      await _fillPhysical(tester, dateOfBirth: '01/01/2030');
      await _continue(tester);

      expect(_stepLabel(tester), l10n.onboardingStepLabel(1, 3));
      expect(find.text(l10n.validationDateOfBirthFuture), findsOneWidget);
      expect(_text(tester, 'profile_weight'), '62');
    });

    testWidgets('una fecha que no existe se señala', (tester) async {
      await _pump(tester);

      await _fillPhysical(tester, dateOfBirth: '31/02/1991');
      await _continue(tester);

      expect(find.text(l10n.validationDateFormat), findsOneWidget);
    });

    testWidgets('E: sin alergias ni «Ninguna conocida» no guarda',
        (tester) async {
      final h = await _pump(tester);

      await _fillPhysical(tester);
      await _continue(tester);
      await _tap(tester, find.text(l10n.ibsSubtypeD));
      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(h.patients.createdProfiles, isEmpty);
      expect(find.text(l10n.validationAllergiesRequired), findsOneWidget);
      expect(h.drafts.writes, 0);
    });

    for (final (variant, weight, message) in <(String, String, String)>[
      ('B', '-68', l10n.validationWeightInvalid),
      ('C', '400', l10n.validationWeightOutOfRange),
    ]) {
      testWidgets('$variant: conserva la fecha y la estatura y no guarda nada',
          (tester) async {
        final h = await _pump(tester);

        await _fillPhysical(tester, weight: weight);
        await _continue(tester);

        expect(_stepLabel(tester), l10n.onboardingStepLabel(1, 3));
        expect(find.text(message), findsOneWidget);
        expect(_text(tester, 'profile_date_of_birth'), '14/03/1991');
        expect(_text(tester, 'profile_height'), '165');
        expect(_text(tester, 'profile_weight'), weight);
        expect(h.patients.createdProfiles, isEmpty);
        expect(h.drafts.writes, 0);
      });
    }

    testWidgets('D: conserva la estatura y no guarda nada', (tester) async {
      final h = await _pump(tester);

      await _fillPhysical(tester, dateOfBirth: '01/01/2030');
      await _continue(tester);

      expect(_text(tester, 'profile_height'), '165');
      expect(_text(tester, 'profile_date_of_birth'), '01/01/2030');
      expect(h.drafts.writes, 0);
    });

    testWidgets('final: tras A a E el asistente vuelve a abrir vacío',
        (tester) async {
      final h = await _pump(tester);
      for (final (date, weight) in <(String, String)>[
        ('14/03/1991', ''),
        ('14/03/1991', '-68'),
        ('14/03/1991', '400'),
        ('01/01/2030', '62'),
      ]) {
        await _fillPhysical(tester, dateOfBirth: date, weight: weight);
        await _continue(tester);
        expect(_stepLabel(tester), l10n.onboardingStepLabel(1, 3));
      }
      await _fillPhysical(tester);
      await _continue(tester);
      await _tap(tester, find.text(l10n.ibsSubtypeD));
      await _tap(tester, find.byKey(const Key('profile_submit')));
      expect(find.text(l10n.validationAllergiesRequired), findsOneWidget);

      await tester.pumpWidget(const SizedBox.shrink());
      await _pump(tester, drafts: h.drafts);

      expect(h.patients.createdProfiles, isEmpty);
      expect(h.drafts.writes, 0);
      expect(_stepLabel(tester), l10n.onboardingStepLabel(1, 3));
      expect(_text(tester, 'profile_date_of_birth'), '');
      expect(_text(tester, 'profile_weight'), '');
      expect(_text(tester, 'profile_height'), '');
    });
  });

  group('ClinicalProfileScreen · guardar (CP007)', () {
    testWidgets('un perfil completo llega al repositorio', (tester) async {
      final h = await _pump(tester);

      await _fillPhysical(tester);
      await _continue(tester);
      await _fillHistory(tester);
      await _tap(tester, find.byKey(const Key('profile_submit')));

      final draft = h.patients.createdProfiles.single;
      expect(draft.dateOfBirth, DateTime(1991, 3, 14));
      expect(draft.weightKg, 62);
      expect(draft.heightCm, 165);
      expect(draft.biologicalSex, BiologicalSexOption.female);
      expect(draft.ibsSubtype, IbsSubtypeOption.ibsD);
      expect(h.patients.declaredAllergies, isEmpty);
    });

    testWidgets('las alergias marcadas viajan con severidad por defecto',
        (tester) async {
      final h = await _pump(tester);

      await _fillPhysical(tester);
      await _continue(tester);
      await _tap(tester, find.text(l10n.ibsSubtypeD));
      await _tap(tester, find.text('Gluten'));
      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(
        h.patients.declaredAllergies.single.severity,
        AllergySeverityLevel.moderate,
      );
    });

    testWidgets('guardar borra el borrador aplazado', (tester) async {
      final h = await _pump(
        tester,
        drafts: FakeOnboardingDraftStore(
          const OnboardingDraft(ownerUserId: 'patient-1', page: 0),
        ),
      );

      await _fillPhysical(tester);
      await _continue(tester);
      await _fillHistory(tester);
      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(h.drafts.draft, isNull);
    });

    testWidgets('un error del backend se muestra en el banner', (tester) async {
      final repository = FakePatientsRepository()
        ..createProfileError = const CauceApiError.invalidBiometricValue();
      await _pump(tester, repository: repository);

      await _fillPhysical(tester);
      await _continue(tester);
      await _fillHistory(tester);
      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(find.text(l10n.errorInvalidBiometricValue), findsOneWidget);
    });
  });

  group('ClinicalProfileScreen · «Después» (CA05, CP011)', () {
    testWidgets('el boton dice «Después»', (tester) async {
      await _pump(tester);

      expect(find.byKey(const Key('onboarding_defer')), findsOneWidget);
      expect(l10n.onboardingDefer, 'Después');
    });

    testWidgets('desde el paso 2 guarda el avance con el paso y los datos',
        (tester) async {
      final h = await _pump(tester);

      await _fillPhysical(tester);
      await _continue(tester);
      await _tap(tester, find.text(l10n.ibsSubtypeD));
      await _tap(tester, find.byKey(const Key('onboarding_defer')));

      final draft = h.drafts.draft!;
      expect(draft.ownerUserId, 'patient-1');
      expect(draft.page, 1);
      expect(draft.fields['weightKg'], '62');
      expect(draft.fields['dateOfBirth'], '14/03/1991');
      expect(draft.fields['ibsSubtype'], IbsSubtypeOption.ibsD.name);
    });

    testWidgets('desde el paso 1 tambien funciona', (tester) async {
      final h = await _pump(tester);

      await _type(tester, find.byKey(const Key('profile_weight')), '62');
      await _tap(tester, find.byKey(const Key('onboarding_defer')));

      expect(h.drafts.draft!.page, 0);
      expect(h.drafts.draft!.fields['weightKg'], '62');
    });

    testWidgets('al reanudar abre en el paso guardado con sus datos',
        (tester) async {
      await _pump(
        tester,
        drafts: FakeOnboardingDraftStore(
          OnboardingDraft(
            ownerUserId: 'patient-1',
            page: 1,
            fields: <String, Object?>{
              'dateOfBirth': '14/03/1991',
              'biologicalSex': BiologicalSexOption.female.name,
              'weightKg': '62',
              'heightCm': '165',
              'ibsSubtype': IbsSubtypeOption.ibsD.name,
            },
          ),
        ),
      );

      expect(_stepLabel(tester), l10n.onboardingStepLabel(2, 3));
      await _tap(tester, find.byKey(const Key('profile_back')));
      expect(_text(tester, 'profile_weight'), '62');
      expect(_text(tester, 'profile_height'), '165');
    });

    testWidgets('el borrador de otra cuenta no se carga', (tester) async {
      await _pump(
        tester,
        drafts: FakeOnboardingDraftStore(
          const OnboardingDraft(
            ownerUserId: 'otra-cuenta',
            page: 1,
            fields: <String, Object?>{'weightKg': '80'},
          ),
        ),
      );

      expect(_stepLabel(tester), l10n.onboardingStepLabel(1, 3));
      expect(_text(tester, 'profile_weight'), '');
    });
  });
}

String _subtypeLabel(IbsSubtypeOption option) => switch (option) {
      IbsSubtypeOption.ibsD => l10n.ibsSubtypeD,
      IbsSubtypeOption.ibsC => l10n.ibsSubtypeC,
      IbsSubtypeOption.ibsM => l10n.ibsSubtypeM,
      IbsSubtypeOption.ibsU => l10n.ibsSubtypeU,
    };
