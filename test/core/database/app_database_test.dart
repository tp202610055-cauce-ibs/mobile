import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

/// Abre una base cuyo `user_version` es 1, o sea el esquema vacio que dejo
/// Mobile-1b (acta M27), para que drift corra la migracion real a v2.
AppDatabase _atSchemaV1() {
  return AppDatabase(
    NativeDatabase.memory(
      setup: (raw) => raw.execute('PRAGMA user_version = 1;'),
    ),
  );
}

void main() {
  group('AppDatabase · esquema', () {
    late AppDatabase database;

    setUp(() => database = AppDatabase.memory());
    tearDown(() => database.close());

    test('declara el esquema v2', () {
      expect(database.schemaVersion, 2);
    });

    test('abre conexion y responde una consulta', () async {
      // Criterio de TS05, heredado de Mobile-1b: la infraestructura de
      // persistencia existe y la conexion se abre de verdad.
      final result =
          await database.customSelect('SELECT 1 AS value').getSingle();

      expect(result.data['value'], 1);
    });

    test('declara las cuatro tablas del registro clinico diario', () {
      // Reemplaza al test de Mobile-1b que exigia `allTables` vacio. Aquel era
      // la tripwire que detenia a quien agregara una tabla sin escribir la
      // migracion; este bloque escribio la migracion, asi que ahora se verifica
      // lo contrario.
      expect(
        database.allTables.map((table) => table.actualTableName).toSet(),
        <String>{
          'meals_local',
          'meal_items_local',
          'symptoms_local',
          'food_catalog_cache',
        },
      );
    });
  });

  group('AppDatabase · migracion de v1 a v2', () {
    test('crea las cuatro tablas desde el esquema vacio', () async {
      // v1 no tenia tablas, asi que el salto solo crea y no hay dato que
      // preservar ni columna que reescribir.
      final database = _atSchemaV1();
      addTearDown(database.close);

      final tables = await database
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'table' "
            "AND name NOT LIKE 'sqlite_%'",
          )
          .get();

      expect(
        tables.map((row) => row.data['name'] as String).toSet(),
        containsAll(<String>[
          'meals_local',
          'meal_items_local',
          'symptoms_local',
          'food_catalog_cache',
        ]),
      );
    });

    test('deja el user_version en 2', () async {
      final database = _atSchemaV1();
      addTearDown(database.close);

      final row =
          await database.customSelect('PRAGMA user_version').getSingle();

      expect(row.data.values.first, 2);
    });

    test('crea los indices de busqueda y de sincronizacion', () async {
      final database = _atSchemaV1();
      addTearDown(database.close);

      final indexes = await database
          .customSelect(
            "SELECT name FROM sqlite_master WHERE type = 'index' "
            "AND name LIKE 'idx_%'",
          )
          .get();

      expect(
        indexes.map((row) => row.data['name'] as String).toSet(),
        <String>{
          'idx_food_catalog_name_normalized',
          'idx_meals_local_sync_status',
          'idx_symptoms_local_sync_status',
          'idx_meal_items_local_meal',
        },
      );
    });

    test('la migracion produce el mismo esquema que una instalacion nueva',
        () async {
      // Si `onCreate` y `onUpgrade` divergieran, una instalacion del piloto que
      // ya existe terminaria con un esquema distinto del de una nueva, y el
      // bug solo aparecerian en los dispositivos viejos.
      Future<Set<String>> schemaOf(AppDatabase db) async {
        final rows = await db
            .customSelect(
              'SELECT name, sql FROM sqlite_master '
              "WHERE name NOT LIKE 'sqlite_%' ORDER BY name",
            )
            .get();
        return rows
            .map((row) => '${row.data['name']}|${row.data['sql']}')
            .toSet();
      }

      // Las dos bases son independientes y viven en memoria, sin compartir
      // executor: el aviso de drift sobre instancias multiples no aplica y solo
      // ensucia la salida del test.
      driftRuntimeOptions.dontWarnAboutMultipleDatabases = true;
      addTearDown(
        () => driftRuntimeOptions.dontWarnAboutMultipleDatabases = false,
      );

      final migrated = _atSchemaV1();
      addTearDown(migrated.close);
      final fresh = AppDatabase.memory();
      addTearDown(fresh.close);

      expect(await schemaOf(migrated), await schemaOf(fresh));
    });
  });

  group('AppDatabase · integridad referencial', () {
    late AppDatabase database;

    setUp(() => database = AppDatabase.memory());
    tearDown(() => database.close());

    Future<void> insertMeal(String clientGuid) {
      return database.into(database.mealsLocal).insert(
            MealsLocalCompanion.insert(
              clientGuid: clientGuid,
              mealTime: 'Lunch',
              consumedAt: DateTime.utc(2026, 9, 18, 13, 30),
              clientCreatedAt: DateTime.utc(2026, 9, 18, 13, 35),
              syncStatus: LocalSyncStatus.pending,
            ),
          );
    }

    test('borrar una comida arrastra sus items', () async {
      // Drift no activa las claves foraneas por defecto. Sin el PRAGMA del
      // `beforeOpen`, los items quedarian huerfanos y el proximo lote los
      // ignoraria en silencio.
      await insertMeal('11111111-1111-4111-8111-111111111111');
      await database.into(database.mealItemsLocal).insert(
            MealItemsLocalCompanion.insert(
              mealClientGuid: '11111111-1111-4111-8111-111111111111',
              quantity: 150,
              unit: 'Grams',
              foodId: const Value<String?>('aaaa'),
            ),
          );

      await (database.delete(database.mealsLocal)
            ..where(
              (row) =>
                  row.clientGuid.equals('11111111-1111-4111-8111-111111111111'),
            ))
          .go();

      expect(await database.select(database.mealItemsLocal).get(), isEmpty);
    });

    test('rechaza un item cuya comida no existe', () async {
      await expectLater(
        database.into(database.mealItemsLocal).insert(
              MealItemsLocalCompanion.insert(
                mealClientGuid: '99999999-9999-4999-8999-999999999999',
                quantity: 1,
                unit: 'Units',
                foodId: const Value<String?>('aaaa'),
              ),
            ),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('AppDatabase · marcas de tiempo', () {
    late AppDatabase database;

    setUp(() => database = AppDatabase.memory());
    tearDown(() => database.close());

    test('conserva el UTC de ida y vuelta', () async {
      // Con el default de drift las fechas se guardan como segundos desde epoch
      // y vuelven en hora local: la marca de zona se pierde. `consumedAt` y
      // `clientCreatedAt` viajan a un backend que valida contra su reloj UTC, y
      // la ventana de 4 horas se calcula sobre esos mismos valores, asi que un
      // desfase ahi es un dato clinico equivocado. De ahi
      // `store_date_time_values_as_text` en build.yaml.
      final consumedAt = DateTime.utc(2026, 9, 18, 3, 15, 42);

      await database.into(database.mealsLocal).insert(
            MealsLocalCompanion.insert(
              clientGuid: '22222222-2222-4222-8222-222222222222',
              mealTime: 'Breakfast',
              consumedAt: consumedAt,
              clientCreatedAt: consumedAt,
              syncStatus: LocalSyncStatus.pending,
            ),
          );

      final stored = await database.select(database.mealsLocal).getSingle();

      expect(stored.consumedAt.toUtc(), consumedAt);
      expect(
        stored.consumedAt.toUtc().toIso8601String(),
        consumedAt.toIso8601String(),
      );
    });
  });

  group('AppDatabase · LocalSyncStatus', () {
    late AppDatabase database;

    setUp(() => database = AppDatabase.memory());
    tearDown(() => database.close());

    test('persiste los tres estados, incluido el que no existe en el contrato',
        () async {
      // `failed` es contabilidad interna del cliente: el `SyncStatus` del
      // contrato sigue teniendo dos valores y este nunca viaja al servidor.
      for (final (index, status) in LocalSyncStatus.values.indexed) {
        await database.into(database.symptomsLocal).insert(
              SymptomsLocalCompanion.insert(
                clientGuid: '3333333$index-3333-4333-8333-333333333333',
                symptomType: 'Bloating',
                intensity: 40,
                occurredAt: DateTime.utc(2026, 9, 18, 10),
                clientCreatedAt: DateTime.utc(2026, 9, 18, 10, 5),
                syncStatus: status,
              ),
            );
      }

      final rows = await database.select(database.symptomsLocal).get();

      expect(
        rows.map((row) => row.syncStatus).toSet(),
        LocalSyncStatus.values.toSet(),
      );
    });
  });
}
