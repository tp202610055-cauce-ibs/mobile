/// Corre una tarea asincrona a la vez.
///
/// Un pedido que llega durante una corrida no se pierde: se hace una sola vez
/// mas al terminar, y quien lo pidio espera esa misma corrida.
class SingleFlight {
  Future<void>? _running;
  bool _again = false;

  /// `true` mientras hay una corrida en curso.
  bool get isRunning => _running != null;

  /// Corre [task], o la deja pendiente si ya hay una corrida en curso.
  Future<void> run(Future<void> Function() task) {
    final running = _running;
    if (running != null) {
      _again = true;
      return running;
    }
    return _running = _loop(task);
  }

  Future<void> _loop(Future<void> Function() task) async {
    try {
      do {
        _again = false;
        await task();
      } while (_again);
    } finally {
      _again = false;
      _running = null;
    }
  }
}
