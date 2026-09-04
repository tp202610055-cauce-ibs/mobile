import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AppDatabase', () {
    late AppDatabase database;

    setUp(() => database = AppDatabase.memory());
    tearDown(() => database.close());

    test('arranca en el esquema v1', () {
      expect(database.schemaVersion, 1);
    });

    test('abre conexion y responde una consulta', () async {
      // Verifica el criterio de TS05: la infraestructura de persistencia
      // existe y la conexion se abre de verdad.
      final result =
          await database.customSelect('SELECT 1 AS value').getSingle();

      expect(result.data['value'], 1);
    });

    test('no declara tablas de dominio todavia', () {
      // Las tablas llegan en Mobile-3. Si alguien agrega una sin escribir la
      // migracion de v1 a v2, este test lo detiene.
      expect(database.allTables, isEmpty);
    });
  });
}
