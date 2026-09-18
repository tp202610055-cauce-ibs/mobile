import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/core/sync/sync_queue_store.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/sync_fixtures.dart';

const String _guidA = 'aaaaaaaa-1111-4111-8111-111111111111';
const String _guidB = 'bbbbbbbb-2222-4222-8222-222222222222';
const String _guidC = 'cccccccc-3333-4333-8333-333333333333';

void main() {
  late AppDatabase database;
  late SyncQueueStore store;

  setUp(() {
    database = AppDatabase.memory();
    store = SyncQueueStore(database);
  });
  tearDown(() => database.close());

  group('SyncQueueStore · lectura de pendientes', () {
    test('devuelve solo las pendientes', () async {
      await insertPendingMeal(database, _guidA);
      await insertPendingMeal(
        database,
        _guidB,
        status: LocalSyncStatus.completed,
      );
      await insertPendingMeal(
        database,
        _guidC,
        status: LocalSyncStatus.failed,
      );

      final pending = await store.pendingMeals();

      expect(pending.map((p) => p.meal.clientGuid), <String>[_guidA]);
    });

    test('trae cada comida con sus items', () async {
      await insertPendingMeal(database, _guidA);

      final pending = await store.pendingMeals();

      expect(pending.single.items, hasLength(1));
      expect(pending.single.items.single.unit, 'Grams');
      expect(pending.single.items.single.quantity, 150);
    });

    test('ordena de la mas vieja a la mas nueva', () async {
      // El servidor asocia un sintoma con la comida mas reciente dentro de la
      // ventana de 4 horas: mandarlas desordenadas podria dejar esa ventana
      // resuelta contra la comida equivocada.
      await insertPendingMeal(
        database,
        _guidB,
        clientCreatedAt: DateTime.utc(2026, 9, 18, 20),
      );
      await insertPendingMeal(
        database,
        _guidA,
        clientCreatedAt: DateTime.utc(2026, 9, 18, 8),
      );

      final pending = await store.pendingMeals();

      expect(
        pending.map((p) => p.meal.clientGuid),
        <String>[_guidA, _guidB],
      );
    });

    test('sin pendientes no consulta items', () async {
      expect(await store.pendingMeals(), isEmpty);
      expect(await store.pendingSymptoms(), isEmpty);
    });
  });

  group('SyncQueueStore · transiciones de estado', () {
    test('markCompleted cierra la fila y limpia el error anterior', () async {
      await insertPendingMeal(database, _guidA);
      await store.markFailure(
        _guidA,
        'internal_server_error',
        permanent: false,
      );

      await store.markCompleted(_guidA, 'server-1');

      final row = await (database.select(database.mealsLocal)
            ..where((r) => r.clientGuid.equals(_guidA)))
          .getSingle();
      expect(row.syncStatus, LocalSyncStatus.completed);
      expect(row.serverId, 'server-1');
      expect(row.lastErrorCode, isNull);
    });

    test('markFailure permanente pasa a failed', () async {
      await insertPendingSymptom(database, _guidA);

      await store.markFailure(_guidA, 'validation_error', permanent: true);

      final row = await (database.select(database.symptomsLocal)
            ..where((r) => r.clientGuid.equals(_guidA)))
          .getSingle();
      expect(row.syncStatus, LocalSyncStatus.failed);
      expect(row.lastErrorCode, 'validation_error');
    });

    test('applyMealAssociation guarda lo que resolvio el servidor', () async {
      // El cliente no calcula la ventana de 4 horas (DEC-B3-06): la autoridad
      // es el servidor y el cliente solo refleja su respuesta.
      await insertPendingSymptom(database, _guidA);

      await store.applyMealAssociation(
        _guidA,
        associatedMealId: 'meal-server-1',
        hasMealAssociation: true,
      );

      final row = await (database.select(database.symptomsLocal)
            ..where((r) => r.clientGuid.equals(_guidA)))
          .getSingle();
      expect(row.associatedMealId, 'meal-server-1');
      expect(row.hasMealAssociation, isTrue);
    });

    test('sin asociacion el servidor responde false, no null', () async {
      // `null` significa que todavia no se pregunto; `false`, que el servidor
      // ya dijo que no hay comida en la ventana. No es lo mismo (HU0011 CA02).
      await insertPendingSymptom(database, _guidA);

      final antes = await (database.select(database.symptomsLocal)
            ..where((r) => r.clientGuid.equals(_guidA)))
          .getSingle();
      expect(antes.hasMealAssociation, isNull);

      await store.applyMealAssociation(
        _guidA,
        associatedMealId: null,
        hasMealAssociation: false,
      );

      final despues = await (database.select(database.symptomsLocal)
            ..where((r) => r.clientGuid.equals(_guidA)))
          .getSingle();
      expect(despues.hasMealAssociation, isFalse);
      expect(despues.associatedMealId, isNull);
    });
  });

  group('SyncQueueStore · filas terminales y descarte', () {
    test('lista las filas que quedaron en failed', () async {
      await insertPendingMeal(database, _guidA, status: LocalSyncStatus.failed);
      await insertPendingMeal(database, _guidB);
      await insertPendingSymptom(
        database,
        _guidC,
        status: LocalSyncStatus.failed,
      );

      expect(
        (await store.failedMeals()).map((m) => m.clientGuid),
        <String>[_guidA],
      );
      expect(
        (await store.failedSymptoms()).map((s) => s.clientGuid),
        <String>[_guidC],
      );
    });

    test('descartar borra la fila y sus items', () async {
      // Es la salida del atasco: sin ella, una fila permanentemente rechazada
      // solo se volveria visible en vez de resolverse.
      await insertPendingMeal(database, _guidA, status: LocalSyncStatus.failed);

      final borradas = await store.discard(_guidA);

      expect(borradas, 1);
      expect(await store.failedMeals(), isEmpty);
      expect(await database.select(database.mealItemsLocal).get(), isEmpty);
    });

    test('descartar tambien sirve para una fila pendiente', () async {
      await insertPendingSymptom(database, _guidA);

      expect(await store.discard(_guidA), 1);
      expect(await store.pendingSymptoms(), isEmpty);
    });

    test('no borra una fila que ya llego al servidor', () async {
      // Una fila `completed` ya es un registro clinico del paciente: se elimina
      // desde el backend, no borrando la copia local.
      await insertPendingMeal(
        database,
        _guidA,
        status: LocalSyncStatus.completed,
      );

      expect(await store.discard(_guidA), 0);
      expect(await database.select(database.mealsLocal).get(), hasLength(1));
    });

    test('descartar algo inexistente no falla', () async {
      expect(await store.discard('no-existe'), 0);
    });
  });
}
