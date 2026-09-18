import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// `local_sync_status.dart` se importa aunque este archivo no lo nombre: el
// codigo generado en `app_database.g.dart` es un `part` de este archivo y
// resuelve `LocalSyncStatus` en **su** scope, no en el de la definicion de las
// tablas. Sin esta linea el analyzer no se queja y la compilacion si falla.
import 'local_sync_status.dart';
import 'tables/clinical_registry_tables.dart';

part 'app_database.g.dart';

/// Base de datos local de la aplicacion.
///
/// **Esquema v2.** Mobile-1b la dejo en v1 deliberadamente vacia (acta M27),
/// para fijar el punto de partida del versionado en vez de inventar un v1 con
/// tablas y dejar sin ruta de migracion a las instalaciones del piloto que ya
/// existieran. Mobile-3 escribe esa primera migracion real: v1 no tenia nada,
/// asi que el salto a v2 solo crea.
///
/// Las cuatro tablas sostienen el registro clinico diario (EP0002): las
/// comidas y los sintomas que el paciente registra sin conexion, mas la copia
/// del catalogo de alimentos que hace la busqueda posible en modo avion.
///
/// La sesion del paciente NO vive aca. Tokens y snapshot de usuario van a
/// `flutter_secure_storage` (acta M11), porque son datos personales bajo la
/// Ley N° 29733 y este archivo sqlite no esta cifrado.
///
/// **Ese "no esta cifrado" ahora pesa mas que antes.** Explicaba por que el
/// token de sesion se guarda en otro lado, y nunca fue una decision tomada a
/// proposito sobre el dato clinico, que hasta este bloque no existia en disco.
/// A partir de v2 si existe: comidas, sintomas e intensidades son datos de
/// salud bajo la Ley N.° 29733, protegidos solo por el sandboxing del sistema
/// operativo. Queda pendiente resolverlo con nombre y apellido antes de que el
/// piloto real en el Complejo Hospitalario Guillermo Kaelin de la Fuente corra
/// con pacientes reales y no solo con datos de prueba.
@DriftDatabase(
  tables: <Type>[
    MealsLocal,
    MealItemsLocal,
    SymptomsLocal,
    FoodCatalogCache,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Abre la base sobre el archivo de la aplicacion.
  AppDatabase.file() : super(_openConnection());

  /// Base en memoria, para tests.
  AppDatabase.memory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        await _createIndexes(m);
      },
      onUpgrade: (Migrator m, int from, int to) async {
        // v1 era un esquema vacio: no hay dato que preservar ni columna que
        // reescribir, solo tablas que crear.
        if (from < 2) {
          await m.createTable(mealsLocal);
          await m.createTable(mealItemsLocal);
          await m.createTable(symptomsLocal);
          await m.createTable(foodCatalogCache);
          await _createIndexes(m);
        }
      },
      beforeOpen: (OpeningDetails details) async {
        // Drift no las activa por defecto, y sin esto el `onDelete: cascade`
        // de `meal_items_local` no se aplica: borrar una comida dejaria sus
        // items huerfanos y el proximo lote los ignoraria en silencio.
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  /// Indices que el esquema no declara por si solo.
  Future<void> _createIndexes(Migrator m) async {
    // La busqueda del catalogo corre sobre la columna normalizada en cada
    // pulsacion. Con las ~928 filas de TPCA-CENAN (TS12) el barrido completo se
    // notaria en un dispositivo de gama baja.
    await m.createIndex(
      Index(
        'idx_food_catalog_name_normalized',
        'CREATE INDEX IF NOT EXISTS idx_food_catalog_name_normalized '
            'ON food_catalog_cache (name_normalized)',
      ),
    );
    // El worker de sincronizacion filtra las dos tablas por estado en cada
    // reconexion.
    await m.createIndex(
      Index(
        'idx_meals_local_sync_status',
        'CREATE INDEX IF NOT EXISTS idx_meals_local_sync_status '
            'ON meals_local (sync_status)',
      ),
    );
    await m.createIndex(
      Index(
        'idx_symptoms_local_sync_status',
        'CREATE INDEX IF NOT EXISTS idx_symptoms_local_sync_status '
            'ON symptoms_local (sync_status)',
      ),
    );
    // Los items se leen siempre por su comida, para armar el lote.
    await m.createIndex(
      Index(
        'idx_meal_items_local_meal',
        'CREATE INDEX IF NOT EXISTS idx_meal_items_local_meal '
            'ON meal_items_local (meal_client_guid)',
      ),
    );
  }
}

/// Conexion diferida al archivo `cauce.db` del directorio de documentos.
///
/// `LazyDatabase` retrasa la apertura hasta la primera consulta, de modo que
/// construir el provider no toca disco ni bloquea el arranque.
LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'cauce.db'));
    // `createInBackground` abre sqlite en un isolate aparte: las consultas no
    // compiten con el hilo de UI, que importa cuando Mobile-3 sincronice lotes.
    return NativeDatabase.createInBackground(file);
  });
}
