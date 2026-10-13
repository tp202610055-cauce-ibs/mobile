import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/sync/sync_queue_store.dart';
import '../../../core/utils/single_flight.dart';
import '../../meals/data/meals_repository.dart';
import '../domain/history_entry.dart';
import 'history_composer.dart';

part 'history_notifier.freezed.dart';
part 'history_notifier.g.dart';

/// Estado del historial del paciente.
@freezed
abstract class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default(<HistoryEntry>[]) List<HistoryEntry> entries,
    @Default(false) bool loading,

    /// Error de la lectura remota. **No vacia la lista**: lo local sigue ahi.
    CauceApiError? error,
  }) = _HistoryState;

  const HistoryState._();

  /// Entradas que todavia no llegaron al servidor.
  List<HistoryEntry> get unsynced => entries
      .where((entry) => entry.syncState != HistoryEntrySyncState.synced)
      .toList();
}

/// Historial del Diario: los 90 dias completos, mas lo que no llego al
/// servidor. Se compone desde `/meals` y `/symptoms`, no desde `/history`.
@riverpod
class HistoryNotifier extends _$HistoryNotifier {
  final SingleFlight _flight = SingleFlight();
  bool _open = false;
  bool _disposed = false;
  DateTime? _loadedAt;

  @override
  HistoryState build() {
    ref.onDispose(() => _disposed = true);
    return const HistoryState();
  }

  /// Relee la ventana completa. Una carga pedida durante otra se hace una sola
  /// vez al terminar.
  Future<void> load() {
    _open = true;
    return _flight.run(_loadOnce);
  }

  /// Recarga solo si el Diario ya cargo; con [onlyIfStale], ademas, si no hay
  /// una carga en curso y paso [historyFreshness] desde la ultima sin error.
  Future<void> reloadIfOpen({bool onlyIfStale = false}) async {
    if (!_open || (onlyIfStale && !_isStale)) {
      return;
    }
    await load();
  }

  /// Descarta una fila local que quedo trabada y el paciente reconocio.
  Future<void> discard(String clientGuid) async {
    await ref.read(syncQueueStoreProvider).discard(clientGuid);
    await load();
  }

  bool get _isStale {
    if (_flight.isRunning) {
      return false;
    }
    final loadedAt = _loadedAt;
    return loadedAt == null ||
        ref.read(historyClockProvider)().difference(loadedAt) >=
            historyFreshness;
  }

  Future<void> _loadOnce() async {
    if (_disposed) {
      return;
    }
    final composer = ref.read(historyComposerProvider);
    final clock = ref.read(historyClockProvider);
    final now = clock().toUtc();
    final window = (
      from: now.subtract(MealsRepository.defaultWindow),
      to: now.add(MealsRepository.forwardMargin),
    );

    state = state.copyWith(loading: true, error: null);
    try {
      final composed = await composer.compose(window);
      if (_disposed) {
        return;
      }
      state = state.copyWith(
        loading: false,
        entries: composed.entries,
        error: composed.error,
      );
      // Una carga con error remoto no cuenta como fresca.
      if (composed.error == null) {
        _loadedAt = clock();
      }
    } finally {
      // Una lectura local fallida no deja la pantalla cargando para siempre.
      if (!_disposed && state.loading) {
        state = state.copyWith(loading: false);
      }
    }
  }
}
