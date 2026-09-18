import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/app_database_provider.dart';
import '../../../core/utils/text_normalizer.dart';
import '../domain/food_item.dart';

part 'food_catalog_store.g.dart';

/// Acceso a la copia local del catalogo de alimentos.
///
/// La busqueda del paciente pasa **siempre** por aca y nunca por
/// `GET /foods/search`. No es una preferencia de rendimiento: CP023 registra
/// una comida en modo avion, asi que el catalogo tiene que ser buscable sin
/// red. La consecuencia util es que tampoco depende de que el servidor sea
/// insensible a tildes, que no lo es.
class FoodCatalogStore {
  const FoodCatalogStore(this._db);

  final AppDatabase _db;

  /// Resultados que devuelve una busqueda.
  ///
  /// Mismo tope que `SearchFoodItemsQueryHandler` del backend, para que la
  /// lista no cambie de largo segun haya o no conexion.
  static const int searchLimit = 20;

  /// Sincroniza la caja con el catalogo que devolvio el servidor.
  ///
  /// Reemplaza el contenido: inserta lo nuevo, actualiza lo que cambio y borra
  /// lo que el servidor ya no lista. Todo en una transaccion, de modo que un
  /// corte a mitad de camino deja la caja anterior intacta en vez de media.
  ///
  /// **Conserva la composicion nutricional que ya se habia leido.** Las
  /// entradas llegan como `FoodItemSummary`, sin nutricion, y pisar las
  /// columnas con `null` obligaria a volver a pedir el detalle de cada
  /// alimento en cada arranque.
  Future<void> replaceAll(List<FoodItem> items) {
    return _db.transaction(() async {
      final incomingIds = items.map((item) => item.foodId).toSet();

      await (_db.delete(_db.foodCatalogCache)
            ..where((row) => row.foodId.isNotIn(incomingIds)))
          .go();

      for (final item in items) {
        await _db
            .into(_db.foodCatalogCache)
            .insertOnConflictUpdate(_toCompanion(item, keepNutrition: true));
      }
    });
  }

  /// Guarda la composicion nutricional que devolvio `GET /foods/{foodId}`.
  ///
  /// Se llama de forma oportunista cuando el paciente abre el detalle de un
  /// alimento, que es lo que HU0010 necesita para estimar el perfil del plato
  /// sin llamadas extra al armarlo.
  Future<void> upsertDetail(FoodItem item) {
    return _db
        .into(_db.foodCatalogCache)
        .insertOnConflictUpdate(_toCompanion(item, keepNutrition: false));
  }

  /// Busca por coincidencia parcial de nombre, insensible a mayusculas y a
  /// tildes.
  ///
  /// La comparacion se hace contra `nameNormalized`, precomputada al escribir,
  /// normalizando tambien lo que escribio el paciente. Una consulta vacia
  /// devuelve la lista vacia y no el catalogo entero: sin texto no hay
  /// busqueda, y HU0009 CA03 cubre ese momento con las sugerencias.
  Future<List<FoodItem>> search(String query, {int limit = searchLimit}) async {
    final normalized = TextNormalizer.normalize(query);
    if (normalized.isEmpty) {
      return const <FoodItem>[];
    }

    final rows = await (_db.select(_db.foodCatalogCache)
          ..where((row) => row.nameNormalized.like('%$normalized%'))
          ..orderBy(<OrderClauseGenerator<$FoodCatalogCacheTable>>[
            (row) => OrderingTerm.asc(row.name),
          ])
          ..limit(limit))
        .get();

    return rows.map(_toDomain).toList();
  }

  /// Devuelve un alimento por su identificador, o `null` si no esta en la caja.
  Future<FoodItem?> findById(String foodId) async {
    final row = await (_db.select(_db.foodCatalogCache)
          ..where((r) => r.foodId.equals(foodId)))
        .getSingleOrNull();

    return row == null ? null : _toDomain(row);
  }

  /// Varios alimentos por identificador, para resolver los items de una comida
  /// ya registrada sin una consulta por fila.
  Future<List<FoodItem>> findByIds(Iterable<String> foodIds) async {
    final ids = foodIds.toSet();
    if (ids.isEmpty) {
      return const <FoodItem>[];
    }

    final rows = await (_db.select(_db.foodCatalogCache)
          ..where((row) => row.foodId.isIn(ids)))
        .get();

    return rows.map(_toDomain).toList();
  }

  /// Cantidad de alimentos en la caja. Cero significa que nunca se refresco.
  Future<int> count() async {
    final expression = _db.foodCatalogCache.foodId.count();
    final row = await (_db.selectOnly(_db.foodCatalogCache)
          ..addColumns(<Expression<Object>>[expression]))
        .getSingle();

    return row.read(expression) ?? 0;
  }

  FoodCatalogCacheCompanion _toCompanion(
    FoodItem item, {
    required bool keepNutrition,
  }) {
    final nutrition = item.nutrition;
    // Con `keepNutrition` las columnas van `absent`, que en un
    // `insertOnConflictUpdate` deja el valor que ya tenia la fila.
    final skip = keepNutrition && nutrition == null;

    return FoodCatalogCacheCompanion(
      foodId: Value<String>(item.foodId),
      name: Value<String>(item.name),
      nameNormalized: Value<String>(TextNormalizer.normalize(item.name)),
      category: Value<String>(item.category),
      fodmapLevel: Value<String>(item.fodmapLevel?.wireValue ?? ''),
      isPeruvian: Value<bool>(item.isPeruvian),
      caloriesPer100g: skip
          ? const Value<double?>.absent()
          : Value<double?>(nutrition?.caloriesPer100g),
      proteinGPer100g: skip
          ? const Value<double?>.absent()
          : Value<double?>(nutrition?.proteinGPer100g),
      carbsGPer100g: skip
          ? const Value<double?>.absent()
          : Value<double?>(nutrition?.carbsGPer100g),
      fatGPer100g: skip
          ? const Value<double?>.absent()
          : Value<double?>(nutrition?.fatGPer100g),
      fiberGPer100g: skip
          ? const Value<double?>.absent()
          : Value<double?>(nutrition?.fiberGPer100g),
      fodmapTags: skip
          ? const Value<String?>.absent()
          : Value<String?>(nutrition?.fodmapTags),
    );
  }

  FoodItem _toDomain(FoodCatalogEntry row) {
    final calories = row.caloriesPer100g;
    final protein = row.proteinGPer100g;
    final carbs = row.carbsGPer100g;
    final fat = row.fatGPer100g;
    final fiber = row.fiberGPer100g;

    // Las cinco se escriben juntas o no se escribe ninguna. Exigirlas todas
    // evita exponer una composicion a medias, con la que HU0010 calcularia un
    // perfil nutricional silenciosamente incompleto.
    final hasNutrition = calories != null &&
        protein != null &&
        carbs != null &&
        fat != null &&
        fiber != null;

    return FoodItem(
      foodId: row.foodId,
      name: row.name,
      category: row.category,
      isPeruvian: row.isPeruvian,
      fodmapLevel: FodmapLoad.fromWire(row.fodmapLevel),
      nutrition: hasNutrition
          ? FoodNutrition(
              caloriesPer100g: calories,
              proteinGPer100g: protein,
              carbsGPer100g: carbs,
              fatGPer100g: fat,
              fiberGPer100g: fiber,
              fodmapTags: row.fodmapTags,
            )
          : null,
    );
  }
}

@Riverpod(keepAlive: true)
FoodCatalogStore foodCatalogStore(Ref ref) {
  return FoodCatalogStore(ref.watch(appDatabaseProvider));
}
