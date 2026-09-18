import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/sync/data/sync_repository.dart';
import '../../features/sync/domain/sync_batch_report.dart';
import '../errors/cauce_api_error.dart';
import 'connectivity_monitor.dart';
import 'sync_failure_policy.dart';
import 'sync_queue_store.dart';

part 'sync_worker.g.dart';

/// Resultado de una corrida del worker.
enum SyncRunOutcome {
  /// No habia nada pendiente.
  idle,

  /// El servidor resolvio todo el lote sin rechazos.
  synced,

  /// El lote subio, pero el servidor rechazo al menos una fila.
  partial,

  /// No habia conexion. Las filas quedan pendientes.
  offline,

  /// La peticion fallo entera. Las filas quedan pendientes.
  failed,
}

/// Informe de una corrida, para que la UI pueda decir que paso.
class SyncRunReport {
  const SyncRunReport({
    required this.outcome,
    this.settled = 0,
    this.retrying = 0,
    this.discarded = 0,
  });

  final SyncRunOutcome outcome;

  /// Filas que el servidor acepto o ya tenia.
  final int settled;

  /// Filas rechazadas por algo pasajero, que vuelven en el proximo intento.
  final int retrying;

  /// Filas rechazadas por algo permanente, que quedaron en estado terminal
  /// esperando que el paciente las descarte.
  final int discarded;
}

/// Sube lo que el paciente registro sin conexion (TS06, HU0009 CA02).
///
/// Se dispara al recuperar conexion. No es periodico a proposito: un
/// temporizador gastaria bateria consultando una cola casi siempre vacia, y el
/// unico momento en que tiene sentido reintentar es cuando vuelve la red.
///
/// Corre de a uno: [run] ignora una segunda llamada mientras hay una en curso.
/// Sin eso, dos eventos de reconexion seguidos armarian dos lotes con las
/// mismas filas.
class SyncWorker {
  SyncWorker({
    required SyncQueueStore queue,
    required SyncRepository repository,
    required ConnectivityMonitor connectivity,
  })  : _queue = queue,
        _repository = repository,
        _connectivity = connectivity;

  final SyncQueueStore _queue;
  final SyncRepository _repository;
  final ConnectivityMonitor _connectivity;

  Future<SyncRunReport>? _inFlight;
  StreamSubscription<void>? _subscription;

  /// Empieza a escuchar las reconexiones.
  void start() {
    _subscription ??= _connectivity.onReconnected().listen((_) {
      unawaited(run());
    });
  }

  /// Deja de escuchar. La cola queda como esta.
  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
  }

  /// Arma un lote con lo pendiente y reconcilia lo que responda el servidor.
  ///
  /// Nunca lanza: el worker corre en segundo plano y una excepcion suelta no
  /// tendria a quien avisarle. Todo fallo se refleja en el [SyncRunOutcome].
  Future<SyncRunReport> run() {
    return _inFlight ??= _run().whenComplete(() => _inFlight = null);
  }

  Future<SyncRunReport> _run() async {
    final meals = await _queue.pendingMeals();
    final symptoms = await _queue.pendingSymptoms();

    if (meals.isEmpty && symptoms.isEmpty) {
      return const SyncRunReport(outcome: SyncRunOutcome.idle);
    }

    if (!await _connectivity.isOnline()) {
      return const SyncRunReport(outcome: SyncRunOutcome.offline);
    }

    final SyncBatchReport report;
    try {
      report = await _repository.push(meals: meals, symptoms: symptoms);
    } on CauceApiError {
      // El lote entero no llego. Nada cambia de estado: todo sigue pendiente y
      // vuelve en la proxima reconexion.
      return const SyncRunReport(outcome: SyncRunOutcome.failed);
    }

    return _reconcile(report);
  }

  /// Traslada la clasificacion del servidor al estado local de cada fila.
  Future<SyncRunReport> _reconcile(SyncBatchReport report) async {
    for (final entry in report.accepted) {
      await _queue.markCompleted(entry.clientGuid, entry.serverId);
    }

    // Un duplicado recibe el mismo trato que una aceptada: significa que un
    // envio anterior si entro aunque el dispositivo no haya visto la respuesta,
    // de modo que el dato clinico ya esta a salvo.
    for (final entry in report.duplicates) {
      await _queue.markCompleted(entry.clientGuid, entry.existingServerId);
    }

    var retrying = 0;
    var discarded = 0;
    for (final entry in report.errors) {
      final permanent = SyncFailurePolicy.isPermanent(entry.errorCode);
      await _queue.markFailure(
        entry.clientGuid,
        entry.errorCode,
        permanent: permanent,
      );
      permanent ? discarded++ : retrying++;
    }

    return SyncRunReport(
      outcome: report.isClean ? SyncRunOutcome.synced : SyncRunOutcome.partial,
      settled: report.settledCount,
      retrying: retrying,
      discarded: discarded,
    );
  }
}

@Riverpod(keepAlive: true)
SyncWorker syncWorker(Ref ref) {
  final worker = SyncWorker(
    queue: ref.watch(syncQueueStoreProvider),
    repository: ref.watch(syncRepositoryProvider),
    connectivity: ref.watch(connectivityMonitorProvider),
  );
  ref.onDispose(worker.stop);
  return worker;
}
