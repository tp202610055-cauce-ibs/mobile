import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/sync/sync_queue_store.dart';
import 'package:cauce_mobile/core/sync/sync_worker.dart';
import 'package:cauce_mobile/features/sync/data/sync_repository.dart';
import 'package:cauce_mobile/features/sync/domain/sync_batch_report.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/sync_fixtures.dart';

class _MockSyncRepository extends Mock implements SyncRepository {}

const String _mealGuid = '11111111-1111-4111-8111-111111111111';
const String _symptomGuid = '22222222-2222-4222-8222-222222222222';

void main() {
  late AppDatabase database;
  late SyncQueueStore queue;
  late _MockSyncRepository repository;
  late FakeConnectivityMonitor connectivity;
  late SyncWorker worker;

  setUp(() {
    database = AppDatabase.memory();
    queue = SyncQueueStore(database);
    repository = _MockSyncRepository();
    connectivity = FakeConnectivityMonitor();
    worker = SyncWorker(
      queue: queue,
      repository: repository,
      connectivity: connectivity,
    );
  });

  tearDown(() async {
    await worker.stop();
    await connectivity.dispose();
    await database.close();
  });

  void stubPush(SyncBatchReport report) {
    when(
      () => repository.push(
        meals: any(named: 'meals'),
        symptoms: any(named: 'symptoms'),
      ),
    ).thenAnswer((_) async => report);
  }

  Future<LocalSyncStatus?> mealStatus(String guid) async {
    final row = await (database.select(database.mealsLocal)
          ..where((r) => r.clientGuid.equals(guid)))
        .getSingleOrNull();
    return row?.syncStatus;
  }

  group('SyncWorker · cola vacia y sin conexion', () {
    test('sin nada pendiente no llama al servidor', () async {
      final report = await worker.run();

      expect(report.outcome, SyncRunOutcome.idle);
      verifyNever(
        () => repository.push(
          meals: any(named: 'meals'),
          symptoms: any(named: 'symptoms'),
        ),
      );
    });

    test('sin conexion deja todo pendiente', () async {
      await insertPendingMeal(database, _mealGuid);
      connectivity.online = false;

      final report = await worker.run();

      expect(report.outcome, SyncRunOutcome.offline);
      expect(await mealStatus(_mealGuid), LocalSyncStatus.pending);
      verifyNever(
        () => repository.push(
          meals: any(named: 'meals'),
          symptoms: any(named: 'symptoms'),
        ),
      );
    });
  });

  group('SyncWorker · reconciliacion del lote', () {
    test('accepted cierra la fila y guarda el serverId', () async {
      await insertPendingMeal(database, _mealGuid);
      stubPush(
        const SyncBatchReport(
          accepted: <SyncAccepted>[
            SyncAccepted(
              clientGuid: _mealGuid,
              serverId: 'server-1',
              entityType: 'meal',
            ),
          ],
        ),
      );

      final report = await worker.run();

      expect(report.outcome, SyncRunOutcome.synced);
      expect(report.settled, 1);

      final row = await (database.select(database.mealsLocal)
            ..where((r) => r.clientGuid.equals(_mealGuid)))
          .getSingle();
      expect(row.syncStatus, LocalSyncStatus.completed);
      expect(row.serverId, 'server-1');
    });

    test('duplicates recibe el mismo trato que accepted', () async {
      // Significa que un envio anterior si entro aunque el dispositivo no haya
      // visto la respuesta: el dato clinico ya esta a salvo del lado servidor.
      await insertPendingMeal(database, _mealGuid);
      stubPush(
        const SyncBatchReport(
          duplicates: <SyncDuplicate>[
            SyncDuplicate(
              clientGuid: _mealGuid,
              existingServerId: 'server-previo',
            ),
          ],
        ),
      );

      final report = await worker.run();

      expect(report.outcome, SyncRunOutcome.synced);
      expect(report.settled, 1);

      final row = await (database.select(database.mealsLocal)
            ..where((r) => r.clientGuid.equals(_mealGuid)))
          .getSingle();
      expect(row.syncStatus, LocalSyncStatus.completed);
      expect(row.serverId, 'server-previo');
    });

    test('un error permanente deja la fila en estado terminal', () async {
      await insertPendingMeal(database, _mealGuid);
      stubPush(
        const SyncBatchReport(
          errors: <SyncRejected>[
            SyncRejected(
              clientGuid: _mealGuid,
              errorCode: 'food_item_not_found',
              message: 'El alimento no existe.',
            ),
          ],
        ),
      );

      final report = await worker.run();

      expect(report.outcome, SyncRunOutcome.partial);
      expect(report.discarded, 1);
      expect(report.retrying, 0);

      final row = await (database.select(database.mealsLocal)
            ..where((r) => r.clientGuid.equals(_mealGuid)))
          .getSingle();
      expect(row.syncStatus, LocalSyncStatus.failed);
      expect(row.lastErrorCode, 'food_item_not_found');
    });

    test('un error pasajero deja la fila pendiente con su codigo', () async {
      // Sin guardar el codigo, el paciente no tendria como saber por que su
      // registro no sube.
      await insertPendingMeal(database, _mealGuid);
      stubPush(
        const SyncBatchReport(
          errors: <SyncRejected>[
            SyncRejected(
              clientGuid: _mealGuid,
              errorCode: 'internal_server_error',
            ),
          ],
        ),
      );

      final report = await worker.run();

      expect(report.outcome, SyncRunOutcome.partial);
      expect(report.retrying, 1);
      expect(report.discarded, 0);

      final row = await (database.select(database.mealsLocal)
            ..where((r) => r.clientGuid.equals(_mealGuid)))
          .getSingle();
      expect(row.syncStatus, LocalSyncStatus.pending);
      expect(row.lastErrorCode, 'internal_server_error');
    });

    test('un lote mixto reparte cada fila a su estado', () async {
      await insertPendingMeal(database, _mealGuid);
      await insertPendingSymptom(database, _symptomGuid);
      stubPush(
        const SyncBatchReport(
          accepted: <SyncAccepted>[
            SyncAccepted(clientGuid: _mealGuid, serverId: 'server-1'),
          ],
          errors: <SyncRejected>[
            SyncRejected(
              clientGuid: _symptomGuid,
              errorCode: 'validation_error',
            ),
          ],
        ),
      );

      final report = await worker.run();

      expect(report.outcome, SyncRunOutcome.partial);
      expect(report.settled, 1);
      expect(report.discarded, 1);
      expect(await mealStatus(_mealGuid), LocalSyncStatus.completed);

      final symptom = await (database.select(database.symptomsLocal)
            ..where((r) => r.clientGuid.equals(_symptomGuid)))
          .getSingle();
      expect(symptom.syncStatus, LocalSyncStatus.failed);
    });
  });

  group('SyncWorker · fallos de la peticion', () {
    test('un fallo de red no cambia el estado de ninguna fila', () async {
      await insertPendingMeal(database, _mealGuid);
      when(
        () => repository.push(
          meals: any(named: 'meals'),
          symptoms: any(named: 'symptoms'),
        ),
      ).thenThrow(const CauceApiError.network());

      final report = await worker.run();

      expect(report.outcome, SyncRunOutcome.failed);
      expect(await mealStatus(_mealGuid), LocalSyncStatus.pending);
    });

    test('nunca propaga la excepcion', () async {
      // El worker corre en segundo plano: una excepcion suelta no tendria a
      // quien avisarle.
      await insertPendingMeal(database, _mealGuid);
      when(
        () => repository.push(
          meals: any(named: 'meals'),
          symptoms: any(named: 'symptoms'),
        ),
      ).thenThrow(const CauceApiError.rateLimited(retryAfterSeconds: 30));

      await expectLater(worker.run(), completes);
    });
  });

  group('SyncWorker · disparo y concurrencia', () {
    test('una reconexion dispara una corrida', () async {
      await insertPendingMeal(database, _mealGuid);
      stubPush(
        const SyncBatchReport(
          accepted: <SyncAccepted>[
            SyncAccepted(clientGuid: _mealGuid, serverId: 'server-1'),
          ],
        ),
      );

      worker.start();
      connectivity.emitReconnection();
      // Deja correr la cadena asincrona que arranco el evento.
      await Future<void>.delayed(Duration.zero);
      await Future<void>.delayed(Duration.zero);

      expect(await mealStatus(_mealGuid), LocalSyncStatus.completed);
    });

    test('dos corridas simultaneas arman un solo lote', () async {
      // Sin esta guarda, dos eventos de reconexion seguidos mandarian las
      // mismas filas dos veces.
      await insertPendingMeal(database, _mealGuid);
      stubPush(const SyncBatchReport());

      await Future.wait<SyncRunReport>(<Future<SyncRunReport>>[
        worker.run(),
        worker.run(),
      ]);

      verify(
        () => repository.push(
          meals: any(named: 'meals'),
          symptoms: any(named: 'symptoms'),
        ),
      ).called(1);
    });

    test('despues de stop una reconexion ya no dispara', () async {
      await insertPendingMeal(database, _mealGuid);
      stubPush(const SyncBatchReport());

      worker.start();
      await worker.stop();
      connectivity.emitReconnection();
      await Future<void>.delayed(Duration.zero);

      verifyNever(
        () => repository.push(
          meals: any(named: 'meals'),
          symptoms: any(named: 'symptoms'),
        ),
      );
    });
  });
}
