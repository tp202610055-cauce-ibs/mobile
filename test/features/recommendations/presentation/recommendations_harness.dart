import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/onboarding/application/onboarding_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/recommendations/application/recommendations_feed_notifier.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/recommendations/presentation/recommendation_detail_screen.dart';
import 'package:cauce_mobile/features/recommendations/presentation/recommendations_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_recommendations_repository.dart';
import '../../../helpers/fake_token_storage.dart';

final AppLocalizations l10n = AppLocalizationsEs();

/// Hora fija de los tests de Consejos.
final DateTime recommendationsNow = DateTime.utc(2026, 9, 24, 12);

/// Monta Consejos y su detalle sobre un router minimo con las dos rutas
/// reales, la sesion del paciente demo y el onboarding resuelto.
///
/// El router es propio y no el de la app porque aca se prueban las pantallas;
/// el recorrido desde la raiz lo prueba `app_shell_test.dart` (R10).
Future<ProviderContainer> pumpRecommendations(
  WidgetTester tester, {
  required FakeRecommendationsRepository repository,
  InMemoryRecommendationRequestStore? store,
  bool onboardingCompleted = true,
  String initialLocation = AppRoutes.recommendations,
}) async {
  final container = ProviderContainer(
    overrides: <Override>[
      patientsRepositoryProvider.overrideWithValue(
        FakePatientsRepository(
          profile: demoProfile.copyWith(
            onboardingCompleted: onboardingCompleted,
          ),
        ),
      ),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
      recommendationsRepositoryProvider.overrideWithValue(repository),
      recommendationRequestStoreProvider.overrideWithValue(
        store ?? InMemoryRecommendationRequestStore(),
      ),
      recommendationsClockProvider.overrideWithValue(
        () => recommendationsNow,
      ),
    ],
  );
  addTearDown(container.dispose);

  await container.read(sessionNotifierProvider.notifier).loginSucceeded(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: demoUser,
      );
  await container.read(onboardingNotifierProvider.future);

  final router = GoRouter(
    initialLocation: initialLocation,
    routes: <RouteBase>[
      GoRoute(
        path: AppRoutes.recommendations,
        builder: (_, __) => const RecommendationsScreen(),
        routes: <RouteBase>[
          GoRoute(
            path: ':id',
            builder: (_, GoRouterState state) => RecommendationDetailScreen(
              recommendationId: state.pathParameters['id']!,
            ),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.mealNew,
        builder: (_, __) => const Scaffold(
          body: Text('meal-form', key: Key('meal_form_stub')),
        ),
      ),
    ],
  );
  addTearDown(router.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
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
        routerConfig: router,
      ),
    ),
  );
  await tester.pumpAndSettle();
  return container;
}
