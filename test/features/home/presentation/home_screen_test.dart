import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/home/presentation/home_screen.dart';
import 'package:cauce_mobile/features/onboarding/application/onboarding_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
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

/// Monta la home con la sesion autenticada y el onboarding ya resuelto.
Future<ProviderContainer> _pump(
  WidgetTester tester, {
  required FakePatientsRepository repository,
}) async {
  final container = ProviderContainer(
    overrides: <Override>[
      patientsRepositoryProvider.overrideWithValue(repository),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
    ],
  );
  addTearDown(container.dispose);

  await container.read(sessionNotifierProvider.notifier).loginSucceeded(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: demoUser,
      );
  await container.read(onboardingNotifierProvider.future);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
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
        home: const HomeScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}

void main() {
  group('HomeScreen · recordatorio del onboarding aplazado (CA05)', () {
    testWidgets('sin aplazar no hay banner', (tester) async {
      // Con el onboarding pendiente el guard lleva al wizard, asi que la home
      // solo se ve cuando el paciente aplazo o ya completo.
      final container = await _pump(
        tester,
        repository: FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      );

      expect(
        container.read(resolvedOnboardingProvider),
        const OnboardingState.completed(),
      );
      expect(find.byKey(const Key('home_onboarding_reminder')), findsNothing);
    });

    testWidgets('aplazado en el paso 1 muestra el banner del perfil',
        (tester) async {
      final container = await _pump(
        tester,
        repository: FakePatientsRepository(),
      );

      container.read(onboardingNotifierProvider.notifier).defer();
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('home_onboarding_reminder')), findsOneWidget);
      expect(find.text(l10n.onboardingReminderTitle), findsOneWidget);
      expect(find.text(l10n.onboardingReminderBodyProfile), findsOneWidget);
    });

    testWidgets('aplazado en el paso 2 muestra el banner del cuestionario',
        (tester) async {
      final container = await _pump(
        tester,
        repository: FakePatientsRepository(profile: demoProfile),
      );

      container.read(onboardingNotifierProvider.notifier).defer();
      await tester.pumpAndSettle();

      expect(find.text(l10n.onboardingReminderBodyBaseline), findsOneWidget);
      expect(find.text(l10n.onboardingReminderBodyProfile), findsNothing);
    });

    testWidgets('reanudar publica el paso pendiente', (tester) async {
      // El banner no navega: publica el estado y el guard hace el resto.
      final container = await _pump(
        tester,
        repository: FakePatientsRepository(),
      );
      container.read(onboardingNotifierProvider.notifier).defer();
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('home_onboarding_resume')));
      await tester.pumpAndSettle();

      expect(
        container.read(resolvedOnboardingProvider),
        const OnboardingState.pending(OnboardingStep.clinicalProfile),
      );
    });

    testWidgets('el banner no usa registro de advertencia', (tester) async {
      // El paciente eligio posponer: un aviso de alarma seria desproporcionado.
      expect(l10n.onboardingReminderTitle, isNot(contains('!')));
      expect(l10n.onboardingReminderBodyProfile, isNot(contains('!')));
      expect(l10n.onboardingReminderBodyBaseline, isNot(contains('!')));
    });
  });

  group('HomeScreen · lo que ya hacia (US08 CA01)', () {
    testWidgets('saluda al paciente y ofrece cerrar sesion', (tester) async {
      await _pump(
        tester,
        repository: FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      );

      expect(find.text(l10n.homeGreeting('Paciente Demo')), findsOneWidget);
      expect(find.byKey(const Key('home_logout')), findsOneWidget);
    });
  });
}
