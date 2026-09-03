import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_database.dart';

part 'app_database_provider.g.dart';

/// Instancia unica de la base local.
///
/// `keepAlive` porque una conexion sqlite es un recurso caro de abrir y no
/// debe seguir el ciclo de vida de una pantalla. `onDispose` la cierra cuando
/// el contenedor entero se destruye, que en produccion es el fin de la app y
/// en tests es el fin del caso.
@Riverpod(keepAlive: true)
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase.file();
  ref.onDispose(database.close);
  return database;
}
