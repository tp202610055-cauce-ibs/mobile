import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/auth/inactivity_monitor.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/auth/presentation/login_screen.dart';
import 'package:cauce_mobile/features/history/presentation/history_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/presentation/profile_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/app_borders.dart';
import '../helpers/fake_auth_repository.dart';
import '../helpers/fake_ibs_sss_repository.dart';
import '../helpers/fake_patients_repository.dart';
import '../helpers/fake_token_storage.dart';
import '../helpers/sync_fixtures.dart';

/// Cierre por inactividad desde la raiz (CP021), con el reloj del monitor
/// falseado y la app real encima.
final AppLocalizations l10n = AppLocalizationsEs();

typedef _Harness = ({
  ProviderContainer container,
  FakeTokenStorage storage,
  FakeAuthRepository auth,
  AppDatabase database,
  void Function(Duration) advance,
});

Future<_Harness> _pumpApp(WidgetTester tester) async {
  var now = DateTime.utc(2026, 10, 27, 9);
  final storage = FakeTokenStorage(
    accessToken: 'access-1',
    refreshToken: 'refresh-1',
    userSnapshot: demoUser,
  );
  final borders = appBorders(storage: storage);
  final auth = FakeAuthRepository();
  // Una comida en la cola local, sin conexion: no debe perderse (paso 7).
  await insertPendingMeal(borders.database, 'meal-queued');

  final container = ProviderContainer(
    overrides: <Override>[
      ...borders.overrides,
      tokenStorageProvider.overrideWithValue(storage),
      authRepositoryProvider.overrideWithValue(auth),
      patientsRepositoryProvider.overrideWithValue(
        FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      ),
      ibsSssRepositoryProvider.overrideWithValue(FakeIbsSssRepository()),
      inactivityClockProvider.overrideWithValue(() => now),
    ],
  );
  addTearDown(container.dispose);

  await tester.pumpWidget(
    UncontrolledProviderScope(container: container, child: const CauceApp()),
  );
  await tester.pumpAndSettle();
  return (
    container: container,
    storage: storage,
    auth: auth,
    database: borders.database,
    advance: (Duration by) => now = now.add(by),
  );
}

/// Toca una pestana sin esperar a que el Diario termine de cargar.
Future<void> _tapTab(WidgetTester tester, String key) async {
  await tester.tap(find.byKey(Key(key)));
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 400));
}

void main() {
  group('Cierre por inactividad (CP021)', () {
    testWidgets('a los 9 minutos abrir el Diario no cierra la sesion',
        (tester) async {
      final h = await _pumpApp(tester);

      h.advance(const Duration(minutes: 9));
      await _tapTab(tester, 'nav_journal');

      expect(find.byType(HistoryScreen), findsOneWidget);
      expect(find.byType(LoginScreen), findsNothing);

      // El toque reinicio el conteo: otros 9 minutos tampoco cierran.
      h.advance(const Duration(minutes: 9));
      await _tapTab(tester, 'nav_profile');
      expect(find.byType(ProfileScreen), findsOneWidget);
    });

    testWidgets(
        'pasados 10 minutos, tocar Perfil cierra con aviso y lleva al login',
        (tester) async {
      final h = await _pumpApp(tester);

      h.advance(const Duration(minutes: 10));
      await _tapTab(tester, 'nav_profile');
      await tester.pumpAndSettle();

      expect(find.byType(LoginScreen), findsOneWidget);
      expect(find.byType(ProfileScreen), findsNothing);
      expect(find.text(l10n.sessionInactivityTitle), findsOneWidget);
      expect(find.text(l10n.sessionInactivityBody), findsOneWidget);
      // Se revoca la sesion en el servidor y se borran las llaves.
      expect(h.auth.logoutCalls, 1);
      expect(h.storage.refreshToken, isNull);
    });

    testWidgets('al volver a entrar no se pierde lo encolado (paso 7)',
        (tester) async {
      final h = await _pumpApp(tester);
      h.advance(const Duration(minutes: 11));
      await _tapTab(tester, 'nav_profile');
      await tester.pumpAndSettle();
      expect(find.byType(LoginScreen), findsOneWidget);

      await h.container.read(sessionNotifierProvider.notifier).loginSucceeded(
            accessToken: 'access-2',
            refreshToken: 'refresh-2',
            user: demoUser,
          );
      await tester.pumpAndSettle();

      final rows = await h.database.select(h.database.mealsLocal).get();
      expect(rows.map((row) => row.clientGuid), <String>['meal-queued']);
      expect(rows.single.syncStatus, LocalSyncStatus.pending);
      expect(find.byType(LoginScreen), findsNothing);
      // El aviso es de esa salida: no queda pegado al volver a entrar.
      expect(find.text(l10n.sessionInactivityTitle), findsNothing);

      // Y el conteo arranca de nuevo con la sesion nueva.
      h.advance(const Duration(minutes: 9));
      await _tapTab(tester, 'nav_journal');
      expect(find.byType(HistoryScreen), findsOneWidget);
    });
  });
}
