import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/features/symptoms/data/symptoms_local_store.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import '../../../helpers/sync_fixtures.dart';

final SymptomDraft _draft = SymptomDraft(
  symptomType: SymptomTypeOption.abdominalPain,
  intensity: 60,
  occurredAt: DateTime.utc(2026, 9, 18, 15),
);

void main() {
  late AppDatabase database;
  late SymptomsLocalStore store;

  setUp(() {
    database = AppDatabase.memory();
    store = SymptomsLocalStore(database, const Uuid());
  });
  tearDown(() => database.close());

  Future<SymptomLocal> fila(String clientGuid) {
    return (database.select(database.symptomsLocal)
          ..where((r) => r.clientGuid.equals(clientGuid)))
        .getSingle();
  }

  group('SymptomsLocalStore · registro en el dispositivo', () {
    test('guarda el sintoma pendiente con sus valores de contrato', () async {
      final clientGuid = await store.enqueue(_draft);

      final row = await fila(clientGuid);
      expect(row.syncStatus, LocalSyncStatus.pending);
      expect(row.symptomType, 'AbdominalPain');
      expect(row.intensity, 60);
      expect(row.serverId, isNull);
      expect(row.hasMealAssociation, isNull);
    });

    test('sin tipo o sin intensidad no escribe nada', () async {
      await expectLater(
        store.enqueue(const SymptomDraft(intensity: 60)),
        throwsA(isA<StateError>()),
      );
      await expectLater(
        store.enqueue(
          const SymptomDraft(symptomType: SymptomTypeOption.bloating),
        ),
        throwsA(isA<StateError>()),
      );
      expect(await database.select(database.symptomsLocal).get(), isEmpty);
    });

    test('sin fecha usa el momento del registro', () async {
      final now = DateTime.utc(2026, 9, 18, 21, 10);
      final clientGuid = await store.enqueue(
        const SymptomDraft(
          symptomType: SymptomTypeOption.nausea,
          intensity: 30,
        ),
        now: now,
      );

      final row = await fila(clientGuid);
      expect(row.occurredAt.toUtc(), now);
      expect(row.clientCreatedAt.toUtc(), now);
    });

    test('con la misma clave reemplaza la fila pendiente', () async {
      final clientGuid = await store.enqueue(_draft);
      await store.enqueue(
        _draft.copyWith(intensity: 80),
        clientGuid: clientGuid,
      );

      final rows = await database.select(database.symptomsLocal).get();
      expect(rows, hasLength(1));
      expect(rows.single.intensity, 80);
    });

    test('una fila ya sincronizada no se reemplaza', () async {
      final clientGuid = await store.enqueue(_draft);
      await store.markSynced(
        clientGuid,
        serverId: 'server-1',
        hasMealAssociation: false,
      );

      await store.enqueue(
        _draft.copyWith(intensity: 80),
        clientGuid: clientGuid,
      );

      final row = await fila(clientGuid);
      expect(row.intensity, 60);
      expect(row.syncStatus, LocalSyncStatus.completed);
    });

    test('markSynced guarda el id y la asociacion que resolvio el servidor',
        () async {
      final clientGuid = await store.enqueue(_draft);

      await store.markSynced(
        clientGuid,
        serverId: 'server-1',
        associatedMealId: 'meal-1',
        hasMealAssociation: true,
      );

      final row = await fila(clientGuid);
      expect(row.syncStatus, LocalSyncStatus.completed);
      expect(row.serverId, 'server-1');
      expect(row.associatedMealId, 'meal-1');
      expect(row.hasMealAssociation, isTrue);
    });
  });

  group('SymptomsLocalStore · historial local', () {
    final desde = DateTime.utc(2026, 7, 13, 20);

    test(
        'forHistory entrega la ventana y toda fila pendiente o fallida '
        'aunque sea vieja', () async {
      await insertPendingSymptom(
        database,
        'en-ventana',
        clientCreatedAt: desde.add(const Duration(days: 1)),
        status: LocalSyncStatus.completed,
      );
      await insertPendingSymptom(
        database,
        'sincronizado-viejo',
        clientCreatedAt: desde.subtract(const Duration(days: 10)),
        status: LocalSyncStatus.completed,
      );
      await insertPendingSymptom(
        database,
        'pendiente-viejo',
        clientCreatedAt: desde.subtract(const Duration(days: 100)),
      );
      await insertPendingSymptom(
        database,
        'fallido-viejo',
        clientCreatedAt: desde.subtract(const Duration(days: 200)),
        status: LocalSyncStatus.failed,
      );

      final rows = await store.forHistory(from: desde);

      expect(
        rows.map((row) => row.clientGuid),
        <String>['en-ventana', 'pendiente-viejo', 'fallido-viejo'],
      );
    });

    test('el borde de la ventana es inclusivo', () async {
      await insertPendingSymptom(
        database,
        'en-el-borde',
        clientCreatedAt: desde,
        status: LocalSyncStatus.completed,
      );
      await insertPendingSymptom(
        database,
        'un-segundo-antes',
        clientCreatedAt: desde.subtract(const Duration(seconds: 1)),
        status: LocalSyncStatus.completed,
      );

      final rows = await store.forHistory(from: desde);

      expect(rows.map((row) => row.clientGuid), <String>['en-el-borde']);
    });
  });
}
