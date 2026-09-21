import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/session_notifier.dart';
import '../../features/auth/domain/session_state.dart';
import '../../features/foods/application/food_catalog_refresher.dart';
import '../../features/history/application/history_notifier.dart';
import '../sync/connectivity_monitor.dart';
import '../sync/sync_worker.dart';

part 'background_services.g.dart';

/// Los servicios que corren sin una pantalla delante.
///
/// **Existe porque no existía.** Hasta Mobile-3.2, `SyncWorker` y
/// `FoodCatalogRefresher` estaban construidos, testeados y sin un solo lector:
/// el objeto nunca llegaba a crearse, de modo que nadie escuchaba las
/// reconexiones y la cola no subía nunca. La verificación en dispositivo lo
/// encontró en un minuto y los 814 tests en verde no, porque cada test
/// instancia el worker a mano y le dispara la reconexión él mismo. Ninguno
/// preguntaba quién lo enciende en la aplicación de verdad (acta M39, R12).
///
/// Se enciende con la sesión y se apaga con ella. Fuera de una sesión válida
/// no hay nada que sincronizar ni ningún catálogo que traer, y un worker
/// escuchando con el paciente deslogueado solo puede hacer daño.
class BackgroundServices {
  BackgroundServices({
    required SyncWorker syncWorker,
    required FoodCatalogRefresher catalogRefresher,
    required ConnectivityMonitor connectivity,
    this.onSyncSettled,
  })  : _syncWorker = syncWorker,
        _catalogRefresher = catalogRefresher,
        _connectivity = connectivity;

  /// Se llama cuando una corrida dejo filas resueltas.
  ///
  /// Lo usa el Diario: una fila que sube sola al reconectar tiene que dejar
  /// de decir "pendiente" sin que el paciente tire de la lista.
  final VoidCallback? onSyncSettled;

  final SyncWorker _syncWorker;
  final FoodCatalogRefresher _catalogRefresher;
  final ConnectivityMonitor _connectivity;

  StreamSubscription<void>? _reconnections;
  StreamSubscription<SyncRunReport>? _syncRuns;
  bool _running = false;

  /// `true` mientras los servicios están encendidos. Para los tests.
  bool get isRunning => _running;

  /// Enciende todo. Idempotente: llamarlo dos veces no duplica nada.
  void start() {
    if (_running) {
      return;
    }
    _running = true;

    // El worker se suscribe a las reconexiones por su cuenta.
    _syncWorker.start();

    // Y cuando una corrida deja filas resueltas, el Diario se entera.
    _syncRuns = _syncWorker.completions.listen((SyncRunReport report) {
      if (report.settled > 0 || report.discarded > 0) {
        onSyncSettled?.call();
      }
    });

    // Y además se corre una vez ahora. La app pudo haberse cerrado con filas
    // pendientes: sin este disparo quedarían esperando una reconexión que tal
    // vez no llegue, porque el paciente ya arrancó con señal.
    unawaited(_syncWorker.run());

    // El catálogo al abrir sesión, que es lo que pide el acta M35, y otra vez
    // en cada reconexión: si la primera vez no había red, la caché quedó
    // vacía y la búsqueda local no tiene contra qué buscar.
    unawaited(_refreshCatalog());
    _reconnections = _connectivity.onReconnected().listen((_) {
      unawaited(_refreshCatalog());
    });
  }

  /// Apaga todo. Idempotente.
  Future<void> stop() async {
    _running = false;
    await _reconnections?.cancel();
    _reconnections = null;
    await _syncRuns?.cancel();
    _syncRuns = null;
    await _syncWorker.stop();
  }

  /// Refresca el catálogo sin propagar fallos.
  ///
  /// Un catálogo que no se pudo traer no es un error del paciente: la caché
  /// anterior sigue sirviendo, y si está vacía la pantalla del buscador ya
  /// trata ese caso.
  Future<void> _refreshCatalog() async {
    try {
      await _catalogRefresher.refresh();
    } on Object {
      // Silencio deliberado, con el mismo criterio que las sugerencias del
      // buscador: la acción útil es seguir con lo que haya.
    }
  }
}

@Riverpod(keepAlive: true)
BackgroundServices backgroundServices(Ref ref) {
  final services = BackgroundServices(
    syncWorker: ref.watch(syncWorkerProvider),
    catalogRefresher: ref.watch(foodCatalogRefresherProvider),
    connectivity: ref.watch(connectivityMonitorProvider),
    // `read` y no `watch`: el Diario no es una dependencia del servicio, es
    // alguien a quien avisarle. Observarlo recrearia los servicios en cada
    // recarga del historial.
    onSyncSettled: () => ref.read(historyNotifierProvider.notifier).load(),
  );
  ref.onDispose(services.stop);
  return services;
}

/// Ata el ciclo de vida de los servicios al de la sesión.
///
/// **Alguien tiene que leer esto o no pasa nada**, que es exactamente el error
/// que corrige el bloque. Lo lee `CauceApp`, de modo que vive tanto como la
/// aplicación y reacciona a cada transición de sesión.
@Riverpod(keepAlive: true)
BackgroundServices sessionBackgroundServices(Ref ref) {
  final session = ref.watch(sessionNotifierProvider);
  final services = ref.watch(backgroundServicesProvider);

  // `SessionUnknown` no apaga: es el estado del arranque, mientras se lee el
  // Keystore, y apagar ahí cortaría los servicios de una sesión que sí
  // existe cada vez que la app vuelve del segundo plano.
  switch (session) {
    case SessionAuthenticated():
      services.start();
    case SessionUnauthenticated() || SessionPendingEmailVerification():
      unawaited(services.stop());
    case SessionUnknown():
      break;
  }

  return services;
}
