import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
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
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

final AppLocalizations l10n = AppLocalizationsEs();

/// Monta el paso 1 con los repositorios sustituidos.
///
/// Sin router: la pantalla no navega por su cuenta, el guard lo hace, de modo
/// que montarla suelta prueba exactamente lo que le corresponde.
Future<FakePatientsRepository> _pump(
  WidgetTester tester, {
  FakePatientsRepository? repository,
}) async {
  final patients = repository ?? FakePatientsRepository();
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        patientsRepositoryProvider.overrideWithValue(patients),
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
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
  return patients;
}

/// Toca un widget asegurandose de que este a la vista.
///
/// El paso 1 es mas alto que el viewport de 800x600 de los widget tests, de
/// modo que el boton de envio y las ultimas opciones nacen fuera de pantalla.
Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Escribe en un campo asegurandose de que este a la vista.
///
/// `enterText` enfoca el campo tocandolo, asi que sobre un campo desplazado
/// fuera de pantalla el toque no aterriza y el texto nunca entra.
Future<void> _type(WidgetTester tester, Finder finder, String text) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.enterText(finder, text);
  await tester.pumpAndSettle();
}

/// Completa los cinco campos obligatorios.
Future<void> _fillRequired(WidgetTester tester) async {
  await _type(tester, find.byKey(const Key('profile_weight')), '62.5');
  await _type(tester, find.byKey(const Key('profile_height')), '162');
  await _tap(tester, find.text(l10n.biologicalSexFemale));
  await _tap(tester, find.text(l10n.ibsSubtypeD));
}

/// Elige una fecha de nacimiento valida desde el calendario.
Future<void> _pickDateOfBirth(WidgetTester tester) async {
  await _tap(tester, find.byKey(const Key('profile_date_of_birth')));
  // El calendario abre en el ano actual menos 30, que cae dentro del rango
  // admitido. Se acepta el dia que ofrece por defecto. El rotulo del boton lo
  // pone GlobalMaterialLocalizations en espanol, asi que se busca por tipo.
  await tester.tap(find.byType(TextButton).last);
  await tester.pumpAndSettle();
}

void main() {
  group('ClinicalProfileScreen · composicion', () {
    testWidgets('muestra el indicador de paso 1 de 2', (tester) async {
      await _pump(tester);

      expect(
        tester
            .widget<Text>(find.byKey(const Key('onboarding_step_label')))
            .data,
        l10n.onboardingStepLabel(1, 2),
      );
    });

    testWidgets('ofrece las tres opciones de sexo y las cuatro de subtipo',
        (tester) async {
      await _pump(tester);

      expect(find.text(l10n.biologicalSexFemale), findsOneWidget);
      expect(find.text(l10n.biologicalSexMale), findsOneWidget);
      expect(find.text(l10n.biologicalSexOther), findsOneWidget);
      for (final option in IbsSubtypeOption.values) {
        expect(find.text(_subtypeLabel(option)), findsOneWidget);
      }
    });

    testWidgets('pinta el catalogo de alergias', (tester) async {
      await _pump(tester);

      expect(find.text('Gluten'), findsOneWidget);
      expect(find.text('Mariscos'), findsOneWidget);
      expect(find.text('Sulfitos'), findsOneWidget);
    });

    testWidgets('un fallo del catalogo no bloquea el paso', (tester) async {
      // Declarar alergias es opcional: el perfil debe poder enviarse igual.
      final repository = FakePatientsRepository()
        ..catalogError = const CauceApiError.network();
      await _pump(tester, repository: repository);

      expect(find.byKey(const Key('allergies_retry')), findsOneWidget);
      expect(find.byKey(const Key('profile_submit')), findsOneWidget);
    });
  });

  group('ClinicalProfileScreen · IMC en vivo (CA04)', () {
    testWidgets('sin peso ni estatura no muestra numero', (tester) async {
      await _pump(tester);

      expect(find.byKey(const Key('bmi_pending')), findsOneWidget);
      expect(find.byKey(const Key('bmi_value')), findsNothing);
    });

    testWidgets('con peso y estatura lo calcula y lo clasifica',
        (tester) async {
      await _pump(tester);

      await _type(tester, find.byKey(const Key('profile_weight')), '62.5');
      await _type(tester, find.byKey(const Key('profile_height')), '162');

      expect(
        tester.widget<Text>(find.byKey(const Key('bmi_value'))).data,
        l10n.bmiValue('23.81'),
      );
      expect(
        tester.widget<Text>(find.byKey(const Key('bmi_category'))).data,
        l10n.bmiCategoryNormal,
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

      // Es un dato informativo, no un veredicto.
      expect(find.text(l10n.bmiNote), findsOneWidget);
      expect(l10n.bmiNote.toLowerCase(), contains('nutricionista'));
      expect(l10n.bmiNote, isNot(contains('!')));
    });
  });

  group('ClinicalProfileScreen · validacion local (CA02)', () {
    testWidgets('un envio vacio marca todos los campos a la vez',
        (tester) async {
      // CA02 pide senalar cada campo especifico, no uno por vez.
      final repository = await _pump(tester);

      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(find.text(l10n.validationRequired), findsWidgets);
      expect(repository.createdProfiles, isEmpty);
    });

    testWidgets('un peso fuera de rango se rechaza sin ir al servidor',
        (tester) async {
      final repository = await _pump(tester);

      await _pickDateOfBirth(tester);
      await _fillRequired(tester);
      await _type(tester, find.byKey(const Key('profile_weight')), '500');
      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(find.text(l10n.validationWeightOutOfRange), findsOneWidget);
      expect(repository.createdProfiles, isEmpty);
    });

    testWidgets('una estatura fuera de rango se rechaza', (tester) async {
      final repository = await _pump(tester);

      await _pickDateOfBirth(tester);
      await _fillRequired(tester);
      await _type(tester, find.byKey(const Key('profile_height')), '250');
      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(find.text(l10n.validationHeightOutOfRange), findsOneWidget);
      expect(repository.createdProfiles, isEmpty);
    });

    testWidgets('corregir un campo no borra lo que ya era valido',
        (tester) async {
      // CA02 al pie de la letra.
      await _pump(tester);

      await _fillRequired(tester);
      await _tap(tester, find.byKey(const Key('profile_submit')));

      // Falta la fecha, pero peso, estatura y las dos selecciones siguen ahi.
      expect(
        tester
            .widget<TextField>(
              find.descendant(
                of: find.byKey(const Key('profile_weight')),
                matching: find.byType(TextField),
              ),
            )
            .controller
            ?.text,
        '62.5',
      );
    });
  });

  group('ClinicalProfileScreen · envio', () {
    testWidgets('un formulario completo llega al repositorio', (tester) async {
      final repository = await _pump(tester);

      await _pickDateOfBirth(tester);
      await _fillRequired(tester);
      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(repository.createdProfiles, hasLength(1));
      final draft = repository.createdProfiles.single;
      expect(draft.weightKg, 62.5);
      expect(draft.heightCm, 162);
      expect(draft.biologicalSex, BiologicalSexOption.female);
      expect(draft.ibsSubtype, IbsSubtypeOption.ibsD);
    });

    testWidgets('las alergias marcadas viajan con severidad por defecto',
        (tester) async {
      final repository = await _pump(tester);

      await _pickDateOfBirth(tester);
      await _fillRequired(tester);
      await _tap(tester, find.text('Gluten'));
      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(repository.declaredAllergies, hasLength(1));
      // Moderada es el punto medio: arrancar en un extremo sesgaria el dato.
      expect(
        repository.declaredAllergies.single.severity,
        AllergySeverityLevel.moderate,
      );
    });

    testWidgets('sin alergias marcadas no se declara ninguna', (tester) async {
      final repository = await _pump(tester);

      await _pickDateOfBirth(tester);
      await _fillRequired(tester);
      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(repository.declaredAllergies, isEmpty);
    });

    testWidgets('un error del backend se muestra en el banner', (tester) async {
      final repository = FakePatientsRepository()
        ..createProfileError = const CauceApiError.invalidBiometricValue();
      await _pump(tester, repository: repository);

      await _pickDateOfBirth(tester);
      await _fillRequired(tester);
      await _tap(tester, find.byKey(const Key('profile_submit')));

      expect(find.text(l10n.errorInvalidBiometricValue), findsOneWidget);
    });
  });

  group('ClinicalProfileScreen · aplazar (CA05)', () {
    testWidgets('ofrece el boton de completar mas tarde', (tester) async {
      await _pump(tester);

      expect(find.byKey(const Key('onboarding_defer')), findsOneWidget);
      expect(find.text(l10n.onboardingDefer), findsOneWidget);
    });
  });
}

String _subtypeLabel(IbsSubtypeOption option) => switch (option) {
      IbsSubtypeOption.ibsD => l10n.ibsSubtypeD,
      IbsSubtypeOption.ibsC => l10n.ibsSubtypeC,
      IbsSubtypeOption.ibsM => l10n.ibsSubtypeM,
      IbsSubtypeOption.ibsU => l10n.ibsSubtypeU,
    };
