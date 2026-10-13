import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/utils/single_flight.dart';
import '../../meals/data/meals_repository.dart';
import '../../symptoms/domain/symptom_draft.dart';
import '../domain/history_entry.dart';
import 'history_composer.dart';

part 'today_journal_notifier.freezed.dart';
part 'today_journal_notifier.g.dart';

/// Cuanto registro el paciente hoy, en su dia local.
@freezed
abstract class TodayJournalState with _$TodayJournalState {
  const factory TodayJournalState({
    @Default(0) int meals,
    @Default(0) int symptoms,
  }) = _TodayJournalState;

  const TodayJournalState._();

  bool get isEmpty => meals == 0 && symptoms == 0;
}

/// Lo de hoy para la tarjeta de Inicio, con estado propio y sin cargar el
/// Diario: una pagina por tipo desde el inicio del dia local.
@riverpod
class TodayJournalNotifier extends _$TodayJournalNotifier {
  final SingleFlight _flight = SingleFlight();
  bool _disposed = false;
  DateTime? _loadedAt;

  @override
  TodayJournalState build() {
    ref.onDispose(() => _disposed = true);
    return const TodayJournalState();
  }

  /// Relee lo de hoy; con [onlyIfStale], solo si no hay una carga en curso y
  /// paso [historyFreshness] desde la ultima sin error.
  Future<void> load({bool onlyIfStale = false}) async {
    if (onlyIfStale && !_isStale) {
      return;
    }
    await _flight.run(_loadOnce);
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
    final now = clock();
    // Lo de hoy se registro desde hoy: la hora del registro no adelanta a la
    // del consumo mas que la tolerancia de reloj.
    final startOfDay = DateTime(now.year, now.month, now.day);
    final window = (
      from: startOfDay.subtract(SymptomDraft.clockSkewTolerance).toUtc(),
      to: now.toUtc().add(MealsRepository.forwardMargin),
    );

    final composed = await composer.compose(window);
    if (_disposed) {
      return;
    }

    final today = composed.entries.where((entry) {
      final when = entry.occurredAt.toLocal();
      return when.year == now.year &&
          when.month == now.month &&
          when.day == now.day;
    });
    state = TodayJournalState(
      meals: today.where((e) => e.kind == HistoryEntryKind.meal).length,
      symptoms: today.where((e) => e.kind == HistoryEntryKind.symptom).length,
    );
    // Una carga con error remoto no cuenta como fresca.
    if (composed.error == null) {
      _loadedAt = clock();
    }
  }
}
