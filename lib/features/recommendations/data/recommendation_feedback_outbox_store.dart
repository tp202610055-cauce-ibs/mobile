import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/app_database_provider.dart';
import '../../../core/database/local_sync_status.dart';
import '../domain/pending_recommendation_feedback.dart';
import '../domain/recommendation.dart';

part 'recommendation_feedback_outbox_store.g.dart';

/// Cola local de respuestas a recomendaciones, sobre
/// `recommendation_feedback_outbox`.
///
/// Toda lectura filtra por cuenta: una fila de otra cuenta no existe para
/// quien tiene la sesion.
class RecommendationFeedbackOutboxStore {
  const RecommendationFeedbackOutboxStore(this._db);

  final AppDatabase _db;

  /// Guarda la respuesta como pendiente. Una fila previa de la misma
  /// recomendacion se reemplaza.
  Future<void> save(
    PendingRecommendationFeedback feedback, {
    required String userId,
  }) {
    return _db.into(_db.recommendationFeedbackOutbox).insertOnConflictUpdate(
          RecommendationFeedbackOutboxCompanion.insert(
            recommendationId: feedback.recommendationId,
            userId: userId,
            idempotencyKey: feedback.idempotencyKey,
            wasApplied: feedback.wasApplied,
            outcome: _outcomeToWire(feedback.outcome),
            comment: Value<String?>(feedback.comment),
            createdAt: feedback.createdAt.toUtc(),
            status: LocalSyncStatus.pending,
          ),
        );
  }

  /// La respuesta local de una recomendacion, o `null` si no hay.
  Stream<PendingRecommendationFeedback?> watch(
    String recommendationId, {
    required String userId,
  }) {
    return (_db.select(_db.recommendationFeedbackOutbox)
          ..where(
            (row) =>
                row.recommendationId.equals(recommendationId) &
                row.userId.equals(userId),
          ))
        .watchSingleOrNull()
        .map((row) => row == null ? null : _fromRow(row));
  }

  /// Respuestas que esperan envio, de la mas vieja a la mas nueva.
  Future<List<PendingRecommendationFeedback>> pending({
    required String userId,
  }) async {
    final rows = await (_db.select(_db.recommendationFeedbackOutbox)
          ..where(
            (row) =>
                row.userId.equals(userId) &
                row.status.equalsValue(LocalSyncStatus.pending),
          )
          ..orderBy(
            <OrderClauseGenerator<$RecommendationFeedbackOutboxTable>>[
              (row) => OrderingTerm.asc(row.createdAt),
            ],
          ))
        .get();
    return rows.map(_fromRow).toList();
  }

  /// Deja la fila como rechazada: no se reintenta y espera al paciente.
  Future<void> markRejected(
    String recommendationId, {
    required String userId,
    required String errorCode,
  }) {
    return (_db.update(_db.recommendationFeedbackOutbox)
          ..where(
            (row) =>
                row.recommendationId.equals(recommendationId) &
                row.userId.equals(userId),
          ))
        .write(
      RecommendationFeedbackOutboxCompanion(
        status: const Value<LocalSyncStatus>(LocalSyncStatus.failed),
        lastErrorCode: Value<String?>(errorCode),
      ),
    );
  }

  Future<void> remove(String recommendationId, {required String userId}) {
    return (_db.delete(_db.recommendationFeedbackOutbox)
          ..where(
            (row) =>
                row.recommendationId.equals(recommendationId) &
                row.userId.equals(userId),
          ))
        .go();
  }

  static PendingRecommendationFeedback _fromRow(
    RecommendationFeedbackOutboxRow row,
  ) {
    return PendingRecommendationFeedback(
      recommendationId: row.recommendationId,
      idempotencyKey: row.idempotencyKey,
      wasApplied: row.wasApplied,
      outcome: _outcomeFromWire(row.outcome),
      comment: row.comment,
      createdAt: row.createdAt,
      rejected: row.status == LocalSyncStatus.failed,
      lastErrorCode: row.lastErrorCode,
    );
  }

  static String _outcomeToWire(FeedbackOutcomeOption outcome) =>
      switch (outcome) {
        FeedbackOutcomeOption.improvement => 'Improvement',
        FeedbackOutcomeOption.noChange => 'NoChange',
        FeedbackOutcomeOption.worsening => 'Worsening',
      };

  static FeedbackOutcomeOption _outcomeFromWire(String value) =>
      switch (value) {
        'Improvement' => FeedbackOutcomeOption.improvement,
        'Worsening' => FeedbackOutcomeOption.worsening,
        _ => FeedbackOutcomeOption.noChange,
      };
}

@Riverpod(keepAlive: true)
RecommendationFeedbackOutboxStore recommendationFeedbackOutboxStore(Ref ref) {
  return RecommendationFeedbackOutboxStore(ref.watch(appDatabaseProvider));
}
