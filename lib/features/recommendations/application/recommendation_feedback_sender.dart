import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/sync/connectivity_monitor.dart';
import '../../auth/application/session_notifier.dart';
import '../data/recommendation_feedback_outbox_store.dart';
import '../data/recommendations_repository.dart';
import '../domain/pending_recommendation_feedback.dart';
import 'recommendation_detail_providers.dart';
import 'recommendations_feed_notifier.dart';

part 'recommendation_feedback_sender.g.dart';

/// Resultado de una corrida del envio de respuestas guardadas.
enum FeedbackSendOutcome {
  /// No habia nada de la cuenta actual por enviar.
  idle,

  /// El dispositivo dice que no hay red. Nada cambio.
  offline,

  /// Se recorrieron todas las filas pendientes.
  completed,

  /// Se corto antes de terminar, por red o por sesion. Las filas siguen.
  interrupted,
}

/// Envia las respuestas que el paciente dejo sin conexion (HU0016 CA2).
///
/// Corre de a una corrida y solo con filas de la cuenta de la sesion. Lo
/// enciende y lo apaga `BackgroundServices`; no tiene temporizador propio.
class RecommendationFeedbackSender {
  RecommendationFeedbackSender({
    required RecommendationFeedbackOutboxStore outbox,
    required RecommendationsRepository repository,
    required ConnectivityMonitor connectivity,
    required String? Function() currentUserId,
    void Function(String recommendationId)? onSettled,
    Future<void> Function(Duration delay)? wait,
    this.retryDelays = const <Duration>[
      Duration(seconds: 5),
      Duration(seconds: 15),
    ],
  })  : _outbox = outbox,
        _repository = repository,
        _connectivity = connectivity,
        _currentUserId = currentUserId,
        _onSettled = onSettled,
        _wait = wait ?? Future<void>.delayed;

  final RecommendationFeedbackOutboxStore _outbox;
  final RecommendationsRepository _repository;
  final ConnectivityMonitor _connectivity;
  final String? Function() _currentUserId;
  final void Function(String recommendationId)? _onSettled;
  final Future<void> Function(Duration delay) _wait;

  /// Esperas de los reintentos tras un fallo de red con el dispositivo en
  /// linea: la reconexion suele avisar antes de que la red responda.
  final List<Duration> retryDelays;

  Future<FeedbackSendOutcome>? _inFlight;
  StreamSubscription<void>? _reconnections;
  bool _running = false;
  bool _retryScheduled = false;
  int _generation = 0;

  bool get isRunning => _running;

  /// Escucha las reconexiones. Idempotente.
  void start() {
    if (_running) {
      return;
    }
    _running = true;
    _generation++;
    _reconnections = _connectivity.onReconnected().listen((_) {
      unawaited(run());
    });
  }

  /// Deja de escuchar y anula los reintentos pendientes. Las filas quedan.
  Future<void> stop() async {
    _running = false;
    _generation++;
    _retryScheduled = false;
    await _reconnections?.cancel();
    _reconnections = null;
  }

  /// Envia lo pendiente. Nunca lanza; una segunda llamada se suma a la que
  /// esta en curso.
  Future<FeedbackSendOutcome> run() => _runAttempt(0);

  Future<FeedbackSendOutcome> _runAttempt(int attempt) {
    return _inFlight ??= _run(attempt).whenComplete(() => _inFlight = null);
  }

  Future<FeedbackSendOutcome> _run(int attempt) async {
    final userId = _currentUserId();
    if (userId == null) {
      return FeedbackSendOutcome.idle;
    }
    final rows = await _outbox.pending(userId: userId);
    if (rows.isEmpty) {
      return FeedbackSendOutcome.idle;
    }
    if (!await _connectivity.isOnline()) {
      return FeedbackSendOutcome.offline;
    }

    for (final row in rows) {
      if (_currentUserId() != userId) {
        return FeedbackSendOutcome.interrupted;
      }
      final step = await _send(row, userId);
      if (step == _Step.networkFailed) {
        if (await _connectivity.isOnline()) {
          _scheduleRetry(attempt + 1);
        }
        return FeedbackSendOutcome.interrupted;
      }
      if (step == _Step.sessionLost) {
        return FeedbackSendOutcome.interrupted;
      }
    }
    return FeedbackSendOutcome.completed;
  }

  Future<_Step> _send(PendingRecommendationFeedback row, String userId) async {
    final id = row.recommendationId;
    try {
      await _repository.submitFeedback(
        id,
        draft: row.toDraft(),
        idempotencyKey: row.idempotencyKey,
      );
    } on NetworkError {
      return _Step.networkFailed;
    } on CauceApiError catch (error) {
      if (FeedbackSendPolicy.endsSession(error)) {
        return _Step.sessionLost;
      }
      if (FeedbackSendPolicy.settles(error)) {
        await _settle(id, userId);
        return _Step.done;
      }
      final code = FeedbackSendPolicy.rejectionCode(error);
      if (code != null) {
        await _outbox.markRejected(id, userId: userId, errorCode: code);
        _onSettled?.call(id);
      }
      return _Step.done;
    }
    await _settle(id, userId);
    return _Step.done;
  }

  Future<void> _settle(String id, String userId) async {
    await _outbox.remove(id, userId: userId);
    _onSettled?.call(id);
  }

  void _scheduleRetry(int attempt) {
    if (!_running || _retryScheduled || attempt > retryDelays.length) {
      return;
    }
    _retryScheduled = true;
    final generation = _generation;
    unawaited(
      _wait(retryDelays[attempt - 1]).then((_) async {
        if (generation != _generation) {
          return;
        }
        _retryScheduled = false;
        if (_running) {
          await _runAttempt(attempt);
        }
      }),
    );
  }
}

enum _Step { done, networkFailed, sessionLost }

/// Clasifica la respuesta del servidor a una respuesta guardada.
abstract final class FeedbackSendPolicy {
  /// Cuenta como enviada: el servidor ya la tenia, o la recomendacion ya no
  /// existe para el paciente y no hay a que responder.
  static bool settles(CauceApiError error) =>
      error is ConflictStateError ||
      error is RecommendationNotFoundError ||
      error is RecommendationExpiredError;

  /// La sesion termino: la fila espera a que la misma cuenta vuelva a entrar.
  static bool endsSession(CauceApiError error) =>
      error is InvalidRefreshTokenError ||
      (error is UnknownError && error.statusCode == 401);

  /// Codigo de un rechazo que no mejora reintentando, o `null` si es pasajero.
  static String? rejectionCode(CauceApiError error) {
    return switch (error) {
      ValidationError(:final errorCode) => errorCode ?? 'validation_error',
      DomainRuleViolationError() => 'domain_rule_violation',
      ForbiddenError() => 'forbidden',
      RecommendationAccessDeniedError() => 'recommendation_access_denied',
      IdempotencyMismatchError() => 'idempotency_mismatch',
      UnknownError(:final statusCode, :final errorCode)
          when statusCode >= 400 &&
              statusCode < 500 &&
              statusCode != 401 &&
              statusCode != 408 &&
              statusCode != 429 =>
        errorCode ?? 'http_$statusCode',
      _ => null,
    };
  }
}

@Riverpod(keepAlive: true)
RecommendationFeedbackSender recommendationFeedbackSender(Ref ref) {
  final sender = RecommendationFeedbackSender(
    outbox: ref.watch(recommendationFeedbackOutboxStoreProvider),
    repository: ref.watch(recommendationsRepositoryProvider),
    connectivity: ref.watch(connectivityMonitorProvider),
    currentUserId: () => ref.read(sessionNotifierProvider).user?.userId,
    // Refresca para que el detalle y la tarjeta muestren lo que el servidor
    // tiene ahora.
    onSettled: (id) {
      ref
        ..invalidate(recommendationDetailProvider(id))
        ..invalidate(recommendationsFeedNotifierProvider);
    },
  );
  ref.onDispose(sender.stop);
  return sender;
}
