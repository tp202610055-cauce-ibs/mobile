import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/foods/application/food_catalog_refresher.dart';
import 'package:cauce_mobile/features/foods/data/food_catalog_store.dart';
import 'package:cauce_mobile/features/foods/data/foods_repository.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockFoodsRepository extends Mock implements FoodsRepository {}

FoodItem _item(String id, String name) {
  return FoodItem(
    foodId: id,
    name: name,
    category: 'cereales',
    isPeruvian: true,
    fodmapLevel: FodmapLoad.low,
  );
}

void main() {
  late AppDatabase database;
  late FoodCatalogStore store;
  late _MockFoodsRepository repository;
  late FoodCatalogRefresher refresher;

  setUp(() {
    database = AppDatabase.memory();
    store = FoodCatalogStore(database);
    repository = _MockFoodsRepository();
    refresher = FoodCatalogRefresher(repository, store);
  });
  tearDown(() => database.close());

  group('FoodCatalogRefresher · refresco', () {
    test('trae el catalogo y lo deja en la caja', () async {
      when(repository.fetchCatalog).thenAnswer(
        (_) async => <FoodItem>[
          _item('f1', 'Arroz blanco cocido'),
          _item('f2', 'Quinua blanca cocida'),
        ],
      );

      final outcome = await refresher.refresh();

      expect(outcome, FoodCatalogRefreshOutcome.updated);
      expect(await store.count(), 2);
    });

    test('un fallo del servidor deja la caja anterior intacta', () async {
      // Refrescar es una mejora, no un requisito: buscar sobre un catalogo
      // viejo sirve mucho mas que sobre uno vacio, y CP023 exige que la
      // busqueda funcione sin red.
      await store.replaceAll(<FoodItem>[_item('f1', 'Arroz blanco cocido')]);
      when(repository.fetchCatalog).thenThrow(const CauceApiError.network());

      final outcome = await refresher.refresh();

      expect(outcome, FoodCatalogRefreshOutcome.failed);
      expect(await store.count(), 1);
      expect((await store.search('arroz')).single.foodId, 'f1');
    });

    test('nunca propaga el error', () async {
      // Hacer que el arranque de sesion dependa de esto dejaria al paciente sin
      // app por un catalogo.
      when(repository.fetchCatalog).thenThrow(const CauceApiError.forbidden());

      await expectLater(refresher.refresh(), completes);
    });

    test('un catalogo vacio no vacia la caja', () async {
      // Solo puede venir de una base recien creada o de una respuesta anomala.
      // En los dos casos conservar lo que hay es mejor que dejar al paciente
      // sin poder registrar nada sin conexion.
      await store.replaceAll(<FoodItem>[_item('f1', 'Arroz blanco cocido')]);
      when(repository.fetchCatalog).thenAnswer((_) async => <FoodItem>[]);

      final outcome = await refresher.refresh();

      expect(outcome, FoodCatalogRefreshOutcome.rejectedEmpty);
      expect(await store.count(), 1);
    });
  });

  group('FoodCatalogRefresher · refresco condicional', () {
    test('con la caja vacia refresca', () async {
      when(repository.fetchCatalog)
          .thenAnswer((_) async => <FoodItem>[_item('f1', 'Arroz')]);

      final outcome = await refresher.refreshIfEmpty();

      expect(outcome, FoodCatalogRefreshOutcome.updated);
      verify(repository.fetchCatalog).called(1);
    });

    test('con la caja poblada no llama al servidor', () async {
      await store.replaceAll(<FoodItem>[_item('f1', 'Arroz')]);

      final outcome = await refresher.refreshIfEmpty();

      expect(outcome, isNull);
      verifyNever(repository.fetchCatalog);
    });
  });
}
