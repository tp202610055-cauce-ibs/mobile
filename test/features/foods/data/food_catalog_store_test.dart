import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/features/foods/data/food_catalog_store.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:flutter_test/flutter_test.dart';

/// Entrada de catalogo como la que devuelve `GET /foods`: resumen, sin
/// composicion nutricional.
FoodItem _summary(
  String id,
  String name, {
  String category = 'cereales',
  FodmapLoad fodmap = FodmapLoad.low,
  bool isPeruvian = false,
}) {
  return FoodItem(
    foodId: id,
    name: name,
    category: category,
    isPeruvian: isPeruvian,
    fodmapLevel: fodmap,
  );
}

const FoodNutrition _nutrition = FoodNutrition(
  caloriesPer100g: 89,
  proteinGPer100g: 1.1,
  carbsGPer100g: 22.8,
  fatGPer100g: 0.3,
  fiberGPer100g: 2.6,
  fodmapTags: 'fructans,polyols',
);

void main() {
  late AppDatabase database;
  late FoodCatalogStore store;

  setUp(() {
    database = AppDatabase.memory();
    store = FoodCatalogStore(database);
  });
  tearDown(() => database.close());

  group('FoodCatalogStore · busqueda local', () {
    setUp(() async {
      await store.replaceAll(<FoodItem>[
        _summary(
          'f1',
          'Plátano de la isla maduro',
          category: 'frutas',
          isPeruvian: true,
        ),
        _summary('f2', 'Pan de trigo blanco', fodmap: FodmapLoad.high),
        _summary('f3', 'Arroz blanco cocido'),
        _summary('f4', 'Aji de gallina', category: 'preparaciones'),
        _summary('f5', 'Camote sancochado', category: 'verduras'),
      ]);
    });

    test('"platano" sin tilde encuentra "Plátano de la isla maduro"', () async {
      // El caso que justifica que la busqueda no vaya contra
      // `GET /foods/search`: el backend usa `ILike` sin `unaccent`, asi que ni
      // con conexion daria este resultado. En un teclado movil en español es
      // frecuente escribir sin tildes.
      final results = await store.search('platano');

      expect(results, hasLength(1));
      expect(results.single.name, 'Plátano de la isla maduro');
    });

    test('"plátano" con tilde encuentra lo mismo', () async {
      final results = await store.search('plátano');

      expect(results.single.foodId, 'f1');
    });

    test('es insensible a mayusculas', () async {
      expect((await store.search('ARROZ')).single.foodId, 'f3');
      expect((await store.search('arroz')).single.foodId, 'f3');
    });

    test('coincide por fragmento en el medio del nombre', () async {
      final results = await store.search('trigo');

      expect(results.single.foodId, 'f2');
    });

    test('ordena por nombre', () async {
      final results = await store.search('a');

      expect(
        results.map((item) => item.name).toList(),
        equals(<String>[...results.map((item) => item.name)]..sort()),
      );
    });

    test('una consulta vacia no devuelve el catalogo entero', () async {
      // Sin texto no hay busqueda: ese momento lo cubren las sugerencias del
      // servidor (HU0009 CA03), no un volcado de 928 filas.
      expect(await store.search(''), isEmpty);
      expect(await store.search('   '), isEmpty);
    });

    test('sin coincidencias devuelve vacio', () async {
      expect(await store.search('quinua'), isEmpty);
    });

    test('respeta el tope de resultados', () async {
      await store.replaceAll(<FoodItem>[
        for (var i = 0; i < 40; i++) _summary('id$i', 'Arroz variedad $i'),
      ]);

      expect(
        await store.search('arroz'),
        hasLength(FoodCatalogStore.searchLimit),
      );
      expect(await store.search('arroz', limit: 3), hasLength(3));
    });
  });

  group('FoodCatalogStore · refresco del catalogo', () {
    test('inserta, actualiza y borra para espejar al servidor', () async {
      await store.replaceAll(<FoodItem>[
        _summary('f1', 'Arroz blanco cocido'),
        _summary('f2', 'Pan de trigo blanco'),
      ]);

      await store.replaceAll(<FoodItem>[
        _summary('f1', 'Arroz blanco cocido sin sal'),
        _summary('f3', 'Quinua blanca cocida'),
      ]);

      expect(await store.count(), 2);
      expect((await store.findById('f1'))?.name, 'Arroz blanco cocido sin sal');
      expect(await store.findById('f2'), isNull);
      expect((await store.findById('f3'))?.name, 'Quinua blanca cocida');
    });

    test('actualiza tambien la columna normalizada', () async {
      await store.replaceAll(<FoodItem>[_summary('f1', 'Arroz blanco')]);
      await store.replaceAll(<FoodItem>[_summary('f1', 'Plátano maduro')]);

      expect(await store.search('arroz'), isEmpty);
      expect((await store.search('platano')).single.foodId, 'f1');
    });

    test('conserva la composicion nutricional ya leida', () async {
      // Las entradas del listado llegan sin nutricion. Pisarla con null
      // obligaria a volver a pedir el detalle de cada alimento en cada
      // arranque, y HU0010 la necesita para estimar el perfil del plato.
      await store.replaceAll(<FoodItem>[_summary('f1', 'Plátano maduro')]);
      await store.upsertDetail(
        _summary('f1', 'Plátano maduro').copyWith(nutrition: _nutrition),
      );

      await store.replaceAll(<FoodItem>[_summary('f1', 'Plátano maduro')]);

      final stored = await store.findById('f1');
      expect(stored?.hasNutrition, isTrue);
      expect(stored?.nutrition?.caloriesPer100g, 89);
      expect(stored?.nutrition?.fodmapTagList, <String>['fructans', 'polyols']);
    });

    test('un catalogo vacio deja la caja vacia', () async {
      await store.replaceAll(<FoodItem>[_summary('f1', 'Arroz')]);
      await store.replaceAll(<FoodItem>[]);

      expect(await store.count(), 0);
    });
  });

  group('FoodCatalogStore · detalle', () {
    test('upsertDetail crea la fila si el alimento no estaba', () async {
      await store.upsertDetail(
        _summary('f9', 'Ceviche de pescado').copyWith(nutrition: _nutrition),
      );

      final stored = await store.findById('f9');
      expect(stored?.name, 'Ceviche de pescado');
      expect(stored?.nutrition?.proteinGPer100g, 1.1);
    });

    test('una composicion incompleta no se expone a medias', () async {
      // Las cinco columnas se escriben juntas. Exponer una composicion parcial
      // haria que HU0010 calculara un perfil silenciosamente incompleto.
      await store.replaceAll(<FoodItem>[_summary('f1', 'Arroz')]);

      expect((await store.findById('f1'))?.hasNutrition, isFalse);
      expect((await store.findById('f1'))?.nutrition, isNull);
    });

    test('findByIds resuelve varios de una', () async {
      await store.replaceAll(<FoodItem>[
        _summary('f1', 'Arroz'),
        _summary('f2', 'Pan'),
        _summary('f3', 'Quinua'),
      ]);

      final found = await store.findByIds(<String>['f1', 'f3', 'inexistente']);

      expect(found.map((item) => item.foodId).toSet(), <String>{'f1', 'f3'});
    });

    test('findByIds sin ids no consulta', () async {
      expect(await store.findByIds(const <String>[]), isEmpty);
    });
  });

  group('FoodCatalogStore · nivel FODMAP', () {
    test('sobrevive el viaje de ida y vuelta', () async {
      await store.replaceAll(<FoodItem>[
        _summary('f1', 'Arroz', fodmap: FodmapLoad.low),
        _summary('f2', 'Camote', fodmap: FodmapLoad.moderate),
        _summary('f3', 'Cebolla', fodmap: FodmapLoad.high),
      ]);

      expect((await store.findById('f1'))?.fodmapLevel, FodmapLoad.low);
      expect((await store.findById('f2'))?.fodmapLevel, FodmapLoad.moderate);
      expect((await store.findById('f3'))?.fodmapLevel, FodmapLoad.high);
    });

    test('un nivel ausente queda en null y no rompe la fila', () async {
      await store.replaceAll(<FoodItem>[
        const FoodItem(
          foodId: 'f1',
          name: 'Alimento sin clasificar',
          category: 'otros',
          isPeruvian: false,
        ),
      ]);

      final stored = await store.findById('f1');
      expect(stored, isNotNull);
      expect(stored?.fodmapLevel, isNull);
    });
  });
}
