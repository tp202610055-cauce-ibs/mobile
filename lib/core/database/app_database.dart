import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

/// Base de datos local de la aplicacion.
///
/// Esquema v1, deliberadamente sin tablas. Mobile-1b solo necesita que la
/// infraestructura de persistencia exista y abra conexion (TS05); las tablas
/// de dominio (`meals_local`, `symptoms_local`, `sync_operations`) llegan en
/// Mobile-3 junto con el registro de comidas y el sync offline.
///
/// Arrancar en v1 vacio y no diferir la creacion entera tiene un motivo: fija
/// el punto de partida del versionado de esquema. Mobile-3 escribe la primera
/// migracion real de v1 a v2 en vez de inventar un v1 con tablas y dejar sin
/// ruta de migracion a las instalaciones del piloto que ya existan.
///
/// La sesion del paciente NO vive aca. Tokens y snapshot de usuario van a
/// `flutter_secure_storage` (acta M11), porque son datos personales bajo la
/// Ley N° 29733 y este archivo sqlite no esta cifrado.
@DriftDatabase(tables: <Type>[])
class AppDatabase extends _$AppDatabase {
  AppDatabase(super.e);

  /// Abre la base sobre el archivo de la aplicacion.
  AppDatabase.file() : super(_openConnection());

  /// Base en memoria, para tests.
  AppDatabase.memory() : super(NativeDatabase.memory());

  @override
  int get schemaVersion => 1;
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
