import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/theme/design_tokens.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/onboarding/presentation/widgets/onboarding_labels.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/domain/patient_profile.dart';
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

  group('ProfileScreen · acceso a privacidad', () {
    testWidgets('el engranaje abre Privacidad', (tester) async {
      await _pump(tester);

      await tester.tap(find.byKey(const Key('profile_privacy_entry')));
      await tester.pumpAndSettle();

      expect(find.byType(PrivacyScreen), findsOneWidget);
    });

    testWidgets('sigue disponible aunque el resumen falle', (tester) async {
      // Es la practica que la pantalla anterior ya tenia y que no debe
      // romperse: dejar al paciente sin acceso a sus derechos porque el
      // servidor no contesto seria el peor momento para encerrarlo.
      final repository = FakePatientsRepository()
        ..fetchSummaryError = const CauceApiError.network();
      await _pump(tester, repository: repository);

      expect(find.byKey(const Key('profile_privacy_entry')), findsOneWidget);
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
