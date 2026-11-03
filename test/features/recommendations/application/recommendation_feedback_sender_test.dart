import 'dart:async';

import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/recommendations/application/recommendation_feedback_sender.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_feedback_outbox_store.dart';
import 'package:cauce_mobile/features/recommendations/domain/pending_recommendation_feedback.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_recommendations_repository.dart';
import '../../../helpers/sync_fixtures.dart';

const String _userA = 'aaaaaaaa-0000-4000-8000-00000000000a';
const String _userB = 'bbbbbbbb-0000-4000-8000-00000000000b';

/// Reloj falso de los reintentos: cada espera queda abierta hasta que el test
/// la suelta.
class _FakeWaits {
  final List<Duration> requested = <Duration>[];
  final List<Completer<void>> _pending = <Completer<void>>[];

  Future<void> call(Duration delay) {
    requested.add(delay);
    final completer = Completer<void>();
    _pending.add(completer);
    return completer.future;
  }

  /// Suelta la espera mas vieja y deja correr lo que dispare.
  Future<void> elapse() async {
    _pending.removeAt(0).complete();
    await pumpEventQueue();
  }

  bool get hasPending => _pending.isNotEmpty;
}

/// Conectividad que responde en orden lo que se le da, y despues `false`.
class _SequenceConnectivity extends FakeConnectivityMonitor {
  _SequenceConnectivity(this.answers);

  final List<bool> answers;

  @override
  Future<bool> isOnline() async =>
      answers.isEmpty ? false : answers.removeAt(0);
}

void main() {
  late AppDatabase database;
  late RecommendationFeedbackOutboxStore outbox;
  late FakeRecommendationsRepository repository;
  late FakeConnectivityMonitor connectivity;
  late _FakeWaits waits;
  late List<String> settled;
  String? currentUser;

  RecommendationFeedbackSender sender() => RecommendationFeedbackSender(
        outbox: outbox,
        repository: repository,
        connectivity: connectivity,
        currentUserId: () => currentUser,
        onSettled: settled.add,
        wait: waits.call,
      );

  Future<void> enqueue(String id, {String userId = _userA}) {
    return outbox.save(
      PendingRecommendationFeedback(
        recommendationId: id,
        idempotencyKey: 'clave-$id',
        wasApplied: true,
        outcome: FeedbackOutcomeOption.noChange,
        comment: 'Igual que antes',
        createdAt: DateTime.utc(2026, 9, 22, 10),
      ),
      userId: userId,
    );
  }

  setUp(() {
    database = AppDatabase.memory();
    outbox = RecommendationFeedbackOutboxStore(database);
    repository = FakeRecommendationsRepository();
    connectivity = FakeConnectivityMonitor();
    waits = _FakeWaits();
    settled = <String>[];
    currentUser = _userA;
  });

  tearDown(() async {
    await connectivity.dispose();
    await database.close();
  });

  group('RecommendationFeedbackSender · envio (CP044)', () {
    test('envia la carga guardada con su misma clave y borra la fila',
        () async {
      await enqueue('rec-1');

      final outcome = await sender().run();

      expect(outcome, FeedbackSendOutcome.completed);
      expect(repository.feedbackKeys, <String>['clave-rec-1']);
      final draft = repository.feedbackDrafts.single;
      expect(draft.wasApplied, isTrue);
      expect(draft.outcome, FeedbackOutcomeOption.noChange);
      expect(draft.commentToSend, 'Igual que antes');
      expect(await outbox.pending(userId: _userA), isEmpty);
      expect(settled, <String>['rec-1']);
    });

    test('sin sesion no envia nada', () async {
      await enqueue('rec-1');
      currentUser = null;

      expect(await sender().run(), FeedbackSendOutcome.idle);
      expect(repository.feedbackKeys, isEmpty);
    });

    test('sin red no llama y la fila sigue pendiente', () async {
      await enqueue('rec-1');
      connectivity.online = false;

      expect(await sender().run(), FeedbackSendOutcome.offline);
      expect(repository.feedbackKeys, isEmpty);
      expect(await outbox.pending(userId: _userA), hasLength(1));
    });

    test('solo envia las respuestas de la cuenta de la sesion', () async {
      await enqueue('rec-a');
      await enqueue('rec-b', userId: _userB);

      await sender().run();

      expect(repository.feedbackKeys, <String>['clave-rec-a']);
      expect(await outbox.pending(userId: _userB), hasLength(1));
    });

    test('dos disparos seguidos mandan la carga una sola vez', () async {
      await enqueue('rec-1');
      final s = sender();

      await Future.wait(<Future<FeedbackSendOutcome>>[s.run(), s.run()]);

      expect(repository.feedbackKeys, hasLength(1));
    });
  });

  group('RecommendationFeedbackSender · respuestas del servidor', () {
    test('409 conflict_state cuenta como enviada', () async {
      await enqueue('rec-1');
      repository.feedbackError = const CauceApiError.conflictState();

      await sender().run();

      expect(await outbox.watch('rec-1', userId: _userA).first, isNull);
      expect(settled, <String>['rec-1']);
    });

    test('404 y recommendation_expired borran la fila sin reintentar',
        () async {
      await enqueue('rec-404');
      await enqueue('rec-expired');
      repository.feedbackErrorQueue.addAll(<CauceApiError>[
        const CauceApiError.recommendationNotFound(),
        const CauceApiError.recommendationExpired(),
      ]);

      await sender().run();

      expect(await outbox.pending(userId: _userA), isEmpty);
      expect(await outbox.watch('rec-404', userId: _userA).first, isNull);
      expect(await outbox.watch('rec-expired', userId: _userA).first, isNull);
    });

    test('400 la deja rechazada con su codigo y no la vuelve a enviar',
        () async {
      await enqueue('rec-1');
      repository.feedbackError = const CauceApiError.validation(
        fieldErrors: <String, List<String>>{},
        errorCode: 'validation_error',
      );
      final s = sender();

      await s.run();
      await s.run();

      final row = await outbox.watch('rec-1', userId: _userA).first;
      expect(row?.rejected, isTrue);
      expect(row?.lastErrorCode, 'validation_error');
      expect(repository.feedbackKeys, hasLength(1));
    });

    test('422 tambien queda rechazada', () async {
      await enqueue('rec-1');
      repository.feedbackError = const CauceApiError.unknown(statusCode: 422);

      await sender().run();

      final row = await outbox.watch('rec-1', userId: _userA).first;
      expect(row?.rejected, isTrue);
      expect(row?.lastErrorCode, 'http_422');
    });

    test('401 corta la corrida y la fila espera a la misma cuenta', () async {
      await enqueue('rec-1');
      await enqueue('rec-2');
      repository.feedbackError = const CauceApiError.unknown(statusCode: 401);

      expect(await sender().run(), FeedbackSendOutcome.interrupted);

      expect(repository.feedbackKeys, hasLength(1));
      expect(await outbox.pending(userId: _userA), hasLength(2));
      expect(waits.requested, isEmpty);
    });

    test('un 500 deja la fila pendiente y sigue con la siguiente', () async {
      await enqueue('rec-1');
      await enqueue('rec-2');
      repository.feedbackErrorQueue.add(
        const CauceApiError.unknown(statusCode: 500),
      );

      await sender().run();

      expect(repository.feedbackKeys, hasLength(2));
      final pending = await outbox.pending(userId: _userA);
      expect(pending.single.recommendationId, 'rec-1');
      expect(pending.single.rejected, isFalse);
    });
  });

  group('RecommendationFeedbackSender · reconexion (CP044 paso 8)', () {
    test('envia solo al reconectar despues de encenderse', () async {
      await enqueue('rec-1');
      final s = sender()..start();

      connectivity.emitReconnection();
      await pumpEventQueue();

      expect(repository.feedbackKeys, hasLength(1));
      await s.stop();
    });

    test('apagado no escucha las reconexiones', () async {
      await enqueue('rec-1');
      final s = sender()..start();
      await s.stop();

      connectivity.emitReconnection();
      await pumpEventQueue();

      expect(repository.feedbackKeys, isEmpty);
    });

    test('un fallo de red en linea reintenta a los 5 y a los 15 segundos',
        () async {
      await enqueue('rec-1');
      repository.feedbackError = const CauceApiError.network();
      final s = sender()..start();

      await s.run();
      expect(waits.requested, <Duration>[const Duration(seconds: 5)]);

      await waits.elapse();
      expect(repository.feedbackKeys, hasLength(2));
      expect(waits.requested.last, const Duration(seconds: 15));

      await waits.elapse();
      expect(repository.feedbackKeys, hasLength(3));
      expect(waits.hasPending, isFalse);
      expect(repository.feedbackKeys.toSet(), <String>{'clave-rec-1'});
      await s.stop();
    });

    test('el reintento se detiene al enviar bien', () async {
      await enqueue('rec-1');
      repository.feedbackErrorQueue.add(const CauceApiError.network());
      final s = sender()..start();

      await s.run();
      await waits.elapse();

      expect(repository.feedbackKeys, hasLength(2));
      expect(await outbox.pending(userId: _userA), isEmpty);
      expect(waits.hasPending, isFalse);
      await s.stop();
    });

    test('cerrar sesion anula el reintento pendiente', () async {
      await enqueue('rec-1');
      repository.feedbackError = const CauceApiError.network();
      final s = sender()..start();

      await s.run();
      await s.stop();
      await waits.elapse();

      expect(repository.feedbackKeys, hasLength(1));
    });

    test('si el dispositivo dice que perdio la red no reintenta', () async {
      await enqueue('rec-1');
      repository.feedbackError = const CauceApiError.network();
      await connectivity.dispose();
      connectivity = _SequenceConnectivity(<bool>[true, false]);
      final s = sender()..start();

      await s.run();

      expect(repository.feedbackKeys, hasLength(1));
      expect(waits.requested, isEmpty);
      await s.stop();
    });

    test('sin encender no programa reintentos', () async {
      await enqueue('rec-1');
      repository.feedbackError = const CauceApiError.network();

      await sender().run();

      expect(waits.requested, isEmpty);
    });
  });
}
