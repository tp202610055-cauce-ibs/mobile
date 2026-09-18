import 'package:cauce_mobile/core/config/env.dart';
import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:cauce_mobile/core/sync/sync_queue_store.dart';
import 'package:cauce_mobile/core/sync/sync_worker.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/foods/data/foods_repository.dart';
import 'package:cauce_mobile/features/meals/data/meals_local_store.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:cauce_mobile/features/sync/data/sync_repository.dart';
import 'package:cauce_mobile/features/symptoms/data/symptoms_local_store.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import '../test/helpers/sync_fixtures.dart';

/// Ciclo offline a reconexion a sincronizacion, **sobre el dispositivo y contra
/// el backend real** (HU0009 CA02, CP023, TS06).
///
/// Es lo unico que los tests unitarios no pueden cubrir: drift escribiendo el
/// archivo sqlite de Android de verdad, y dio saliendo por la red del emulador
/// hacia `10.0.2.2:5074`, que es la reescritura que hace `Env.resolveBaseUrl`
/// en flavor dev.
///
/// **Escrito pero todavia no ejecutado.** Levantar el emulador consume mas RAM
/// de la que tiene disponible la maquina de desarrollo, asi que queda para
/// correrlo cuando haya margen. Lo que cubre es lo unico que los tests
/// unitarios no alcanzan; el resto del camino de sincronizacion esta verificado
/// por los 17 tests de `SyncWorker` y por la verificacion empirica del
/// 2026-09-18 contra el backend real, que ejercito `POST /sync/batch` con sus
/// tres clasificaciones.
///
/// Se corre con:
///
/// ```
/// flutter test integration_test/offline_sync_test.dart -d <device>
/// ```
///
/// Exige el backend local arriba con el paciente demo sembrado.
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late AppDatabase database;
  late FakeConnectivityMonitor connectivity;

  setUpAll(() async {
    await Env.load();
  });

  setUp(() {
    // Base en memoria y no el archivo real: el test no debe dejar registros
    // clinicos de prueba en la instalacion del dispositivo.
    database = AppDatabase.memory();
    connectivity = FakeConnectivityMonitor();
    container = ProviderContainer(
      overrides: <Override>[
        appDatabaseProvider.overrideWithValue(database),
        connectivityMonitorProvider.overrideWithValue(connectivity),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await connectivity.dispose();
    await database.close();
  });

  testWidgets('lo registrado sin conexion sube al recuperar la red',
      (tester) async {
    // --- 1. Sesion contra el backend real -------------------------------
    final session = await container.read(authRepositoryProvider).login(
          email: 'paciente.demo@cauce.local',
          password: 'Paciente.Demo2026!',
        );
    expect(session.accessToken, isNotEmpty);
    await container.read(tokenStorageProvider).saveSession(
          accessToken: session.accessToken,
          refreshToken: session.refreshToken,
          user: session.user,
        );

    // --- 2. Catalogo, para tener un foodId que exista de verdad ----------
    final catalog =
        await container.read(foodsRepositoryProvider).fetchCatalog();
    expect(
      catalog,
      isNotEmpty,
      reason: 'el backend debe tener el catalogo sembrado',
    );
    final food = catalog.first;

    // --- 3. El paciente registra sin conexion ---------------------------
    connectivity.online = false;

    final mealGuid = await container.read(mealsLocalStoreProvider).enqueue(
          MealDraft(
            mealTime: MealTimeOption.lunch,
            consumedAt: DateTime.now().toUtc().subtract(
                  const Duration(minutes: 20),
                ),
            items: <MealItemDraft>[
              MealItemDraft(
                quantity: 120,
                unit: MeasurementUnitOption.grams,
                food: food,
              ),
            ],
          ),
        );

    final symptomGuid =
        await container.read(symptomsLocalStoreProvider).enqueue(
              SymptomDraft(
                symptomType: SymptomTypeOption.bloating,
                intensity: 35,
                occurredAt: DateTime.now().toUtc(),
              ),
            );

    final queue = container.read(syncQueueStoreProvider);
    expect(await queue.pendingMeals(), hasLength(1));
    expect(await queue.pendingSymptoms(), hasLength(1));

    // Sin red el worker no llama a nadie y deja todo pendiente.
    final worker = SyncWorker(
      queue: queue,
      repository: container.read(syncRepositoryProvider),
      connectivity: connectivity,
    );
    final offlineRun = await worker.run();
    expect(offlineRun.outcome, SyncRunOutcome.offline);
    expect(await queue.pendingMeals(), hasLength(1));

    // --- 4. Vuelve la conexion ------------------------------------------
    connectivity.online = true;
    final onlineRun = await worker.run();

    expect(
      onlineRun.outcome,
      anyOf(SyncRunOutcome.synced, SyncRunOutcome.partial),
      reason: 'el lote llego al servidor',
    );
    expect(
      onlineRun.settled,
      2,
      reason: 'la comida y el sintoma se resolvieron',
    );
    expect(onlineRun.discarded, 0);

    // --- 5. Las filas locales quedaron cerradas con su id del servidor ---
    final meal = await (database.select(database.mealsLocal)
          ..where((row) => row.clientGuid.equals(mealGuid)))
        .getSingle();
    expect(meal.syncStatus, LocalSyncStatus.completed);
    expect(meal.serverId, isNotNull);

    final symptom = await (database.select(database.symptomsLocal)
          ..where((row) => row.clientGuid.equals(symptomGuid)))
        .getSingle();
    expect(symptom.syncStatus, LocalSyncStatus.completed);
    expect(symptom.serverId, isNotNull);

    // --- 6. La cola quedo vacia -----------------------------------------
    expect(await queue.pendingMeals(), isEmpty);
    expect(await queue.pendingSymptoms(), isEmpty);
    expect(await queue.failedMeals(), isEmpty);
  });

  testWidgets('reintentar el mismo lote deduplica en vez de duplicar',
      (tester) async {
    final session = await container.read(authRepositoryProvider).login(
          email: 'paciente.demo@cauce.local',
          password: 'Paciente.Demo2026!',
        );
    await container.read(tokenStorageProvider).saveSession(
          accessToken: session.accessToken,
          refreshToken: session.refreshToken,
          user: session.user,
        );

    final catalog =
        await container.read(foodsRepositoryProvider).fetchCatalog();
    final food = catalog.first;

    final queue = container.read(syncQueueStoreProvider);
    final repository = container.read(syncRepositoryProvider);

    await container.read(mealsLocalStoreProvider).enqueue(
          MealDraft(
            mealTime: MealTimeOption.dinner,
            consumedAt: DateTime.now().toUtc(),
            items: <MealItemDraft>[
              MealItemDraft(
                quantity: 90,
                unit: MeasurementUnitOption.grams,
                food: food,
              ),
            ],
          ),
        );

    final pending = await queue.pendingMeals();
    final primero = await repository.push(meals: pending, symptoms: const []);
    expect(primero.accepted, hasLength(1));

    // El worker arma el lote desde la fila de drift, asi que el reintento
    // repite la carga **identica** y el backend la reconoce como duplicada.
    final segundo = await repository.push(meals: pending, symptoms: const []);
    expect(segundo.duplicates, hasLength(1));
    expect(segundo.accepted, isEmpty);
    expect(
      segundo.duplicates.single.existingServerId,
      primero.accepted.single.serverId,
      reason: 'el duplicado apunta al registro que ya existia',
    );
  });
}
