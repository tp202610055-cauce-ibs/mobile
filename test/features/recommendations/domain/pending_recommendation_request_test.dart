import 'package:cauce_mobile/features/recommendations/domain/pending_recommendation_request.dart';
import 'package:flutter_test/flutter_test.dart';

const String _owner = 'patient-1';
final DateTime _now = DateTime.utc(2026, 9, 24, 12);

PendingRecommendationRequest _marker({
  String owner = _owner,
  String? id = 'rec-pending',
  DateTime? requestedAt,
  DateTime? expiresAt,
}) {
  return PendingRecommendationRequest(
    ownerUserId: owner,
    idempotencyKey: 'key-1',
    requestedAt: requestedAt ?? _now.subtract(const Duration(hours: 1)),
    recommendationId: id,
    expiresAt: expiresAt,
  );
}

void main() {
  group('PendingRecommendationRequest', () {
    test('sin vencimiento informado, vence a las 72 h del pedido', () {
      final marker = _marker(requestedAt: _now);

      expect(marker.effectiveExpiry, _now.add(const Duration(hours: 72)));
    });

    test('en revision solo con resultado y antes de vencer', () {
      final later = _now.add(const Duration(hours: 10));

      expect(_marker(expiresAt: later).isAwaitingReview(_now), isTrue);
      expect(_marker(expiresAt: _now).isAwaitingReview(_now), isFalse);
      expect(_marker(id: null).isAwaitingReview(_now), isFalse);
    });
  });

  group('RecommendationRequestPolicy.reconcile', () {
    PendingRecommendationRequest? reconcile(
      PendingRecommendationRequest? marker, {
      List<String> visible = const <String>[],
    }) {
      return RecommendationRequestPolicy.reconcile(
        marker: marker,
        currentUserId: _owner,
        visibleIds: visible,
        now: _now,
      );
    }

    test('descarta el marcador de otra cuenta del dispositivo', () {
      expect(reconcile(_marker(owner: 'otro-paciente')), isNull);
    });

    test('descarta el marcador cuando la recomendacion ya es visible', () {
      // Fue aprobada: ya no esta en revision.
      expect(reconcile(_marker(), visible: <String>['rec-pending']), isNull);
    });

    test('descarta el marcador vencido o rechazado', () {
      final expired =
          _marker(expiresAt: _now.subtract(const Duration(minutes: 1)));

      expect(reconcile(expired), isNull);
    });

    test('conserva un pedido en curso sin resultado, para reusar su clave', () {
      final inFlight = _marker(id: null);

      expect(reconcile(inFlight), inFlight);
    });

    test('conserva el que sigue en revision', () {
      final pending = _marker(expiresAt: _now.add(const Duration(hours: 5)));

      expect(reconcile(pending), pending);
    });
  });

  group('RecommendationRequestPolicy.decide · decision 2', () {
    test('con recomendaciones visibles no se pide nada', () {
      expect(
        RecommendationRequestPolicy.decide(
          listIsEmpty: false,
          marker: null,
          now: _now,
        ),
        GenerationDecision.none,
      );
    });

    test('lista vacia y una en revision: no se pide otra', () {
      expect(
        RecommendationRequestPolicy.decide(
          listIsEmpty: true,
          marker: _marker(expiresAt: _now.add(const Duration(hours: 5))),
          now: _now,
        ),
        GenerationDecision.awaitReview,
      );
    });

    test('lista vacia sin nada en revision: se pide', () {
      expect(
        RecommendationRequestPolicy.decide(
          listIsEmpty: true,
          marker: null,
          now: _now,
        ),
        GenerationDecision.request,
      );
      // Un pedido anterior sin respuesta tambien se repite.
      expect(
        RecommendationRequestPolicy.decide(
          listIsEmpty: true,
          marker: _marker(id: null),
          now: _now,
        ),
        GenerationDecision.request,
      );
    });
  });
}
