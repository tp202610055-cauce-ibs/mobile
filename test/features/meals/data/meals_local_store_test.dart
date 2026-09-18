import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:cauce_mobile/features/meals/data/meals_local_store.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

const FoodItem _arroz = FoodItem(
  foodId: 'f1',
  name: 'Arroz blanco cocido',
  category: 'cereales',
  isPeruvian: true,
);

final MealDraft _draft = MealDraft(
  mealTime: MealTimeOption.lunch,
  consumedAt: DateTime.utc(2026, 9, 18, 13),
  items: <MealItemDraft>[
    const MealItemDraft(
      quantity: 150,
      unit: MeasurementUnitOption.grams,
      food: _arroz,
    ),
    const MealItemDraft(
      quantity: 1,
      unit: MeasurementUnitOption.units,
      customFoodId: 'c1',
      customFoodName: 'Mi lomo saltado',
    ),
  ],
);

void main() {
  late AppDatabase database;
  late MealsLocalStore store;

  setUp(() {
    database = AppDatabase.memory();
    store = MealsLocalStore(database, const Uuid());
  });
  tearDown(() => database.close());

  group('MealsLocalStore · registro sin conexion (CA02, CP023)', () {
    test('guarda la comida con sus items y queda pendiente', () async {
      final clientGuid = await store.enqueue(_draft);

      final meal = await (database.select(database.mealsLocal)
            ..where((r) => r.clientGuid.equals(clientGuid)))
          .getSingle();

      expect(meal.syncStatus, LocalSyncStatus.pending);
      expect(meal.mealTime, 'Lunch');
      expect(meal.serverId, isNull);
      expect(await store.itemsOf(clientGuid), hasLength(2));
    });

    test('genera un UUID v4 en el dispositivo', () async {
      // La regla del backend: el `client_guid` lo genera el cliente y es la
      // clave con la que deduplica. Nunca el servidor.
      final clientGuid = await store.enqueue(_draft);

      expect(Uuid.isValidUUID(fromString: clientGuid), isTrue);
      expect(clientGuid[14], '4');
    });

    test('dos registros no comparten identificador', () async {
      final a = await store.enqueue(_draft);
      final b = await store.enqueue(_draft);

      expect(a, isNot(b));
    });

    test('los items conservan la referencia XOR', () async {
      final clientGuid = await store.enqueue(_draft);
      final items = await store.itemsOf(clientGuid);

      final delCatalogo = items.firstWhere((i) => i.foodId != null);
      final personalizado = items.firstWhere((i) => i.customFoodId != null);

      expect(delCatalogo.customFoodId, isNull);
      expect(delCatalogo.foodId, 'f1');
      expect(personalizado.foodId, isNull);
      expect(personalizado.customFoodId, 'c1');
    });

    test('las unidades se guardan con su valor de contrato', () async {
      final clientGuid = await store.enqueue(_draft);
      final items = await store.itemsOf(clientGuid);

      expect(
        items.map((i) => i.unit).toSet(),
        <String>{'Grams', 'Units'},
      );
    });

    test('sin momento del dia no escribe nada', () async {
      // La pantalla ya lo bloquea; llegar aca seria un error de programacion, y
      // dejarlo pasar crearia una fila que el backend rechaza para siempre.
      await expectLater(
        store.enqueue(MealDraft(items: _draft.items)),
        throwsA(isA<StateError>()),
      );
      expect(await database.select(database.mealsLocal).get(), isEmpty);
    });

    test('sin alimentos tampoco', () async {
      await expectLater(
        store.enqueue(const MealDraft(mealTime: MealTimeOption.lunch)),
        throwsA(isA<StateError>()),
      );
      expect(await database.select(database.mealsLocal).get(), isEmpty);
    });

    test('sin fecha de consumo usa el momento del registro', () async {
      final now = DateTime.utc(2026, 9, 18, 20, 30);
      final clientGuid = await store.enqueue(
        MealDraft(mealTime: MealTimeOption.dinner, items: _draft.items),
        now: now,
      );

      final meal = await (database.select(database.mealsLocal)
            ..where((r) => r.clientGuid.equals(clientGuid)))
          .getSingle();

      expect(meal.consumedAt.toUtc(), now);
      expect(meal.clientCreatedAt.toUtc(), now);
    });
  });

  group('MealsLocalStore · registro con conexion', () {
    test('markSynced cierra la fila con el id del servidor', () async {
      // El camino con red escribe primero la fila local y despues envia, de modo
      // que el `client_guid` que viaja es el mismo que quedo guardado.
      final clientGuid = await store.enqueue(_draft);

      await store.markSynced(clientGuid, 'server-1');

      final meal = await (database.select(database.mealsLocal)
            ..where((r) => r.clientGuid.equals(clientGuid)))
          .getSingle();

      expect(meal.syncStatus, LocalSyncStatus.completed);
      expect(meal.serverId, 'server-1');
    });

    test('lo sincronizado tambien queda en el historial local', () async {
      // Asi el paciente ve lo mismo con red y sin red, y sus registros no
      // aparecen y desaparecen segun la cobertura.
      final clientGuid = await store.enqueue(_draft);
      await store.markSynced(clientGuid, 'server-1');

      expect(await store.recent(), hasLength(1));
    });
  });

  group('MealsLocalStore · historial local', () {
    test('ordena de la mas reciente a la mas vieja', () async {
      await store.enqueue(_draft, now: DateTime.utc(2026, 9, 18, 8));
      await store.enqueue(_draft, now: DateTime.utc(2026, 9, 18, 20));

      final recent = await store.recent();

      expect(
        recent.first.clientCreatedAt.toUtc(),
        DateTime.utc(2026, 9, 18, 20),
      );
    });

    test('respeta el limite', () async {
      for (var i = 0; i < 5; i++) {
        await store.enqueue(_draft);
      }

      expect(await store.recent(limit: 3), hasLength(3));
    });
  });
}
