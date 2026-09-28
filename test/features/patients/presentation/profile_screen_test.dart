import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/theme/design_tokens.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/onboarding/presentation/widgets/onboarding_labels.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/domain/allergy.dart';
import 'package:cauce_mobile/features/patients/domain/patient_profile.dart';
import 'package:cauce_mobile/features/patients/presentation/account_settings_screen.dart';
import 'package:cauce_mobile/features/patients/presentation/privacy_screen.dart';
import 'package:cauce_mobile/features/patients/presentation/profile_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

final AppLocalizations l10n = AppLocalizationsEs();

Future<void> _pump(
  WidgetTester tester, {
  FakePatientsRepository? repository,
}) async {
  await _pumpWithoutSettle(tester, repository: repository);
  await tester.pumpAndSettle();
}

/// Igual que [_pump] pero sin asentar los frames, para mirar el estado de
/// carga mientras el resumen todavia no resolvio.
Future<void> _pumpWithoutSettle(
  WidgetTester tester, {
  FakePatientsRepository? repository,
}) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        patientsRepositoryProvider
            .overrideWithValue(repository ?? FakePatientsRepository()),
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
      ],
      // Con router minimo y con la ruta de privacidad declarada: el engranaje
      // de la barra la empuja, y sin ella el test no podria comprobar que el
      // destino existe de verdad.
      child: MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: const <LocalizationsDelegate<Object>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        routerConfig: GoRouter(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (_, __) => const ProfileScreen(),
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoutes.profilePrivacy.substring(1),
                  builder: (_, __) => const PrivacyScreen(),
                ),
                GoRoute(
                  path: AppRoutes.profileSettings.substring(1),
                  builder: (_, __) => const AccountSettingsScreen(),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  group('ProfileScreen · tarjeta clinica', () {
    testWidgets('muestra el subtipo que resolvio el resumen', (tester) async {
      await _pump(tester);

      expect(find.byKey(const Key('profile_clinical_card')), findsOneWidget);
      expect(
        find.text(OnboardingLabels.ibsSubtype(l10n, IbsSubtypeOption.ibsD)),
        findsOneWidget,
      );
    });

    testWidgets('sin subtipo no inventa uno', (tester) async {
      final repository = FakePatientsRepository()
        ..summaryValue = demoSummary.copyWith(ibsSubtype: null);
      await _pump(tester, repository: repository);

      expect(find.byKey(const Key('profile_clinical_card')), findsOneWidget);
      expect(
        find.text(OnboardingLabels.ibsSubtype(l10n, IbsSubtypeOption.ibsD)),
        findsNothing,
      );
    });
  });

  group('ProfileScreen · acceso a la configuracion', () {
    testWidgets('el engranaje abre Configuracion de cuenta', (tester) async {
      // Hasta Mobile-4 llevaba directo a Privacidad, que era la unica de sus
      // secciones construida. Ahora Privacidad se alcanza desde adentro.
      await _pump(tester);

      await tester.tap(find.byKey(const Key('profile_settings_entry')));
      await tester.pumpAndSettle();

      expect(find.byType(AccountSettingsScreen), findsOneWidget);
    });

    testWidgets('sigue disponible aunque el resumen falle', (tester) async {
      // Es la practica que la pantalla anterior ya tenia y que no debe
      // romperse: dejar al paciente sin acceso a sus derechos porque el
      // servidor no contesto seria el peor momento para encerrarlo.
      final repository = FakePatientsRepository()
        ..fetchSummaryError = const CauceApiError.network();
      await _pump(tester, repository: repository);

      expect(find.byKey(const Key('profile_settings_entry')), findsOneWidget);
      expect(find.byKey(const Key('profile_logout')), findsOneWidget);
    });
  });

  group('ProfileScreen · carga, fallo y reintento', () {
    testWidgets('mientras resuelve avisa que esta cargando', (tester) async {
      final repository = FakePatientsRepository()
        ..delay = const Duration(milliseconds: 50);
      await _pumpWithoutSettle(tester, repository: repository);

      expect(find.text(l10n.commonLoading), findsOneWidget);
      expect(find.byKey(const Key('profile_hero')), findsNothing);

      await tester.pumpAndSettle();
    });

    testWidgets('un fallo de red ofrece reintentar', (tester) async {
      final repository = FakePatientsRepository()
        ..fetchSummaryError = const CauceApiError.network();
      await _pump(tester, repository: repository);

      expect(find.text(l10n.errorNetwork), findsOneWidget);
      expect(find.byKey(const Key('profile_retry')), findsOneWidget);
    });

    testWidgets('el reintento vuelve a consultar y dibuja el perfil',
        (tester) async {
      final repository = FakePatientsRepository()
        ..fetchSummaryError = const CauceApiError.network();
      await _pump(tester, repository: repository);

      expect(repository.fetchSummaryCalls, 1);

      repository.fetchSummaryError = null;
      await tester.tap(find.byKey(const Key('profile_retry')));
      await tester.pumpAndSettle();

      expect(repository.fetchSummaryCalls, 2);
      expect(find.byKey(const Key('profile_clinical_card')), findsOneWidget);
      expect(find.byKey(const Key('profile_retry')), findsNothing);
    });
  });

  group('ProfileScreen · identidad', () {
    testWidgets('el avatar usa las iniciales del nombre', (tester) async {
      await _pump(tester);

      expect(find.byKey(const Key('profile_avatar')), findsOneWidget);
      expect(find.text('PD'), findsOneWidget);
      expect(find.text('Paciente Demo Kaelin'), findsOneWidget);
    });

    testWidgets('CP070: el codigo de paciente va bajo el nombre',
        (tester) async {
      final repository = FakePatientsRepository()
        ..summaryValue = demoSummary.copyWith(patientCode: 'P-2026-0042');
      await _pump(tester, repository: repository);

      final code = find.byKey(const Key('profile_patient_code'));
      expect(code, findsOneWidget);
      expect(tester.widget<Text>(code).data, 'P-2026-0042');
      expect(
        tester.widget<Text>(code).style?.fontFamily,
        CauceTypography.fontFamilyMono,
      );
      // Dentro del hero, no suelto en la pantalla.
      expect(
        find.descendant(
          of: find.byKey(const Key('profile_hero')),
          matching: code,
        ),
        findsOneWidget,
      );
    });

    testWidgets('sin codigo no dibuja la linea ni un placeholder',
        (tester) async {
      // `demoSummary` no trae codigo: es una cuenta fuera del piloto.
      await _pump(tester);

      expect(find.byKey(const Key('profile_patient_code')), findsNothing);
      expect(find.byKey(const Key('profile_full_name')), findsOneWidget);
    });
  });

  group('ProfileScreen · alergias declaradas (CP070)', () {
    const lactose = AllergyDeclaration(
      patientAllergyId: 'pa-1',
      allergyId: 'a-1',
      allergyName: 'Lactosa',
      type: AllergyTypeOption.intolerance,
      severity: AllergySeverityLevel.mild,
    );
    const peanut = AllergyDeclaration(
      patientAllergyId: 'pa-2',
      allergyId: 'a-2',
      allergyName: 'Maní',
      type: AllergyTypeOption.allergy,
      severity: AllergySeverityLevel.severe,
    );
    const gluten = AllergyDeclaration(
      patientAllergyId: 'pa-3',
      allergyId: 'a-3',
      allergyName: 'Gluten',
      type: AllergyTypeOption.sensitivity,
      severity: AllergySeverityLevel.moderate,
    );

    Finder allergiesRow() => find.byKey(const Key('profile_allergies'));

    testWidgets('sin alergias dice "Ninguna" dentro de la tarjeta clinica',
        (tester) async {
      await _pump(tester);

      expect(
        find.descendant(
          of: find.byKey(const Key('profile_clinical_card')),
          matching: allergiesRow(),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(of: allergiesRow(), matching: find.text('Ninguna')),
        findsOneWidget,
      );
      expect(
        find.descendant(of: allergiesRow(), matching: find.byType(CauceBadge)),
        findsNothing,
      );
    });

    testWidgets('una sola va en texto plano con tipo y severidad',
        (tester) async {
      final repository = FakePatientsRepository()
        ..summaryValue = demoSummary.copyWith(
          allergies: const <AllergyDeclaration>[lactose],
        );
      await _pump(tester, repository: repository);

      expect(
        find.descendant(
          of: allergiesRow(),
          matching: find.text('Lactosa (intolerancia leve)'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(of: allergiesRow(), matching: find.byType(CauceBadge)),
        findsNothing,
      );
    });

    testWidgets('dos o mas pasan a un chip por alergia', (tester) async {
      final repository = FakePatientsRepository()
        ..summaryValue = demoSummary.copyWith(
          allergies: const <AllergyDeclaration>[lactose, peanut, gluten],
        );
      await _pump(tester, repository: repository);

      expect(
        find.descendant(of: allergiesRow(), matching: find.byType(CauceBadge)),
        findsNWidgets(3),
      );
      expect(find.byKey(const Key('profile_allergy_pa-1')), findsOneWidget);
      expect(find.text('Lactosa (intolerancia leve)'), findsOneWidget);
      expect(find.text('Maní (alergia severa)'), findsOneWidget);
      expect(find.text('Gluten (sensibilidad moderada)'), findsOneWidget);
      expect(find.text('Ninguna'), findsNothing);
    });
  });

  group('allergyLabel · datos faltantes', () {
    AllergyDeclaration declaration({
      String name = 'Lactosa',
      AllergyTypeOption? type,
      AllergySeverityLevel? severity,
    }) =>
        AllergyDeclaration(
          patientAllergyId: 'pa-1',
          allergyId: 'a-1',
          allergyName: name,
          type: type,
          severity: severity,
        );

    test('con todo: nombre, tipo y severidad', () {
      expect(
        allergyLabel(
          l10n,
          declaration(
            type: AllergyTypeOption.intolerance,
            severity: AllergySeverityLevel.mild,
          ),
        ),
        'Lactosa (intolerancia leve)',
      );
    });

    test('sin tipo queda solo la severidad', () {
      expect(
        allergyLabel(
          l10n,
          declaration(severity: AllergySeverityLevel.moderate),
        ),
        'Lactosa (moderada)',
      );
    });

    test('sin severidad queda solo el tipo', () {
      expect(
        allergyLabel(l10n, declaration(type: AllergyTypeOption.allergy)),
        'Lactosa (alergia)',
      );
    });

    test('sin tipo ni severidad, el nombre sin parentesis vacios', () {
      expect(allergyLabel(l10n, declaration()), 'Lactosa');
    });

    test('sin nombre, el tipo toma su lugar', () {
      // Descartarla podria dejar "Ninguna" en pantalla, que seria falso.
      expect(
        allergyLabel(
          l10n,
          declaration(
            name: '',
            type: AllergyTypeOption.intolerance,
            severity: AllergySeverityLevel.severe,
          ),
        ),
        'Intolerancia (severa)',
      );
    });

    test('un nombre de solo espacios cuenta como ausente', () {
      expect(
        allergyLabel(
          l10n,
          declaration(name: '   ', type: AllergyTypeOption.sensitivity),
        ),
        'Sensibilidad',
      );
    });

    test('sin nombre ni tipo, cae a "Alergia"', () {
      expect(
        allergyLabel(
          l10n,
          declaration(name: '', severity: AllergySeverityLevel.mild),
        ),
        'Alergia (leve)',
      );
      expect(allergyLabel(l10n, declaration(name: '')), 'Alergia');
    });
  });

  group('ProfileScreen · seguimiento', () {
    testWidgets('sin nutricionista lo dice en vez de dejar el hueco',
        (tester) async {
      final repository = FakePatientsRepository()
        ..summaryValue = demoSummary.copyWith(nutritionistName: null);
      await _pump(tester, repository: repository);

      expect(
        find.text(l10n.profileTrackingNutritionistPending),
        findsOneWidget,
      );
    });

    testWidgets('con nutricionista muestra su nombre', (tester) async {
      await _pump(tester);

      expect(find.text('Ana Quispe'), findsOneWidget);
      expect(find.text(l10n.profileTrackingNutritionistPending), findsNothing);
    });
  });

  group('ProfileScreen · evolucion IBS-SSS', () {
    testWidgets('una mejoria se lee como puntos menos', (tester) async {
      // El backend entrega `latest - baseline`, asi que -90 es mejoria. Si
      // alguien invirtiera el signo, este test lo ve.
      await _pump(tester);

      expect(find.text(l10n.profileEvolutionChangeDown(90)), findsOneWidget);
      expect(find.text(l10n.profileEvolutionScore(220)), findsOneWidget);
      expect(find.text(l10n.profileEvolutionScore(130)), findsOneWidget);
    });

    testWidgets('la pildora sale del dato del servidor, no de un calculo',
        (tester) async {
      // Cambio de 90 puntos, que supera el MCID, pero el servidor dice que no
      // hay respuesta significativa. Manda el servidor.
      final repository = FakePatientsRepository()
        ..summaryValue =
            demoSummary.copyWith(significantClinicalResponse: false);
      await _pump(tester, repository: repository);

      expect(
        find.byKey(const Key('profile_evolution_achievement')),
        findsNothing,
      );
      expect(
        find.byKey(const Key('profile_evolution_ongoing')),
        findsOneWidget,
      );
    });

    testWidgets('con respuesta significativa muestra la pildora',
        (tester) async {
      await _pump(tester);

      expect(
        find.byKey(const Key('profile_evolution_achievement')),
        findsOneWidget,
      );
    });

    testWidgets('un empeoramiento no se pinta de rojo', (tester) async {
      final repository = FakePatientsRepository()
        ..summaryValue = demoSummary.copyWith(
          ibsSssLatest: 260,
          cumulativeChange: 40,
          significantClinicalResponse: false,
        );
      await _pump(tester, repository: repository);

      expect(find.text(l10n.profileEvolutionChangeUp(40)), findsOneWidget);

      final value = tester.widget<Text>(
        find.descendant(
          of: find.byKey(const Key('profile_evolution_change')),
          matching: find.text(l10n.profileEvolutionChangeUp(40)),
        ),
      );
      expect(value.style?.color, isNot(CauceColors.dangerText));
      expect(value.style?.color, isNot(CauceColors.fodmapHighText));
    });

    testWidgets('sin linea base ofrece completar la evaluacion',
        (tester) async {
      final repository = FakePatientsRepository()
        ..summaryValue = demoSummary.copyWith(
          ibsSssBaseline: null,
          ibsSssLatest: null,
          cumulativeChange: null,
          significantClinicalResponse: false,
        );
      await _pump(tester, repository: repository);

      expect(find.byKey(const Key('profile_evolution_empty')), findsOneWidget);
      expect(find.byKey(const Key('profile_evolution_cta')), findsOneWidget);
    });
  });

  group('ProfileScreen · edicion', () {
    testWidgets('el boton queda deshabilitado y explicado', (tester) async {
      await _pump(tester);

      expect(
        find.byKey(const Key('profile_edit_unavailable')),
        findsOneWidget,
      );
      final button = tester.widget<OutlinedButton>(
        find.descendant(
          of: find.byKey(const Key('profile_edit')),
          matching: find.byType(OutlinedButton),
        ),
      );
      expect(button.onPressed, isNull);
    });
  });
}
