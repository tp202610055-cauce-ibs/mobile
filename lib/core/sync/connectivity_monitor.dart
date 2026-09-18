import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'connectivity_monitor.g.dart';

/// Fuente de conectividad del dispositivo.
///
/// Se declara como interfaz para que el worker de sincronizacion se pueda
/// probar sin el plugin real ni un canal de plataforma: los tests inyectan una
/// implementacion que emite cuando quieren.
abstract interface class ConnectivityMonitor {
  /// `true` si el dispositivo declara alguna interfaz con salida.
  Future<bool> isOnline();

  /// Emite cada vez que el dispositivo **recupera** conexion.
  ///
  /// Solo las transiciones de sin red a con red. Las de con red a sin red no
  /// interesan: no hay nada que sincronizar cuando se corta.
  Stream<void> onReconnected();
}

/// Implementacion sobre `connectivity_plus`.
///
/// El major 6 del paquete cambio la forma: `checkConnectivity()` y
/// `onConnectivityChanged` devuelven **listas** de `ConnectivityResult`, porque
/// un dispositivo puede tener varias interfaces activas a la vez. Estar en
/// linea es que al menos una no sea `none`.
class PluginConnectivityMonitor implements ConnectivityMonitor {
  PluginConnectivityMonitor(this._connectivity);

  final Connectivity _connectivity;

  @override
  Future<bool> isOnline() async {
    try {
      return _hasConnection(await _connectivity.checkConnectivity());
    } on Object {
      // Si el canal de plataforma falla, se asume que hay red y que el intento
      // de sincronizar dira la verdad. Asumir lo contrario dejaria la cola
      // parada por un fallo del plugin.
      return true;
    }
  }

  @override
  Stream<void> onReconnected() {
    var wasOnline = true;

    return _connectivity.onConnectivityChanged
        .map(_hasConnection)
        .where((isOnline) {
      final recovered = isOnline && !wasOnline;
      wasOnline = isOnline;
      return recovered;
    });
  }

  /// **Advertencia del plugin, no del cliente.** `ConnectivityResult` describe
  /// la interfaz, no si hay salida real a internet: un wifi de hotel sin
  /// autenticar informa `wifi`. Alcanza igual, porque el disparo solo decide
  /// cuando *intentar* el lote, y el intento fallido deja las filas pendientes.
  static bool _hasConnection(List<ConnectivityResult> results) {
    return results.any((result) => result != ConnectivityResult.none);
  }
}

@Riverpod(keepAlive: true)
ConnectivityMonitor connectivityMonitor(Ref ref) {
  return PluginConnectivityMonitor(Connectivity());
}
