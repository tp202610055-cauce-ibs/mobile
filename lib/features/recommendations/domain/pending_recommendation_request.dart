import 'package:freezed_annotation/freezed_annotation.dart';

part 'pending_recommendation_request.freezed.dart';

/// Marcador local de la ultima generacion que pidio este dispositivo
/// (decision 2).
///
/// **Existe porque el backend no evita duplicados.** Verificado en
/// `GenerateRecommendationCommandHandler`: no busca una recomendacion
/// `Generated` o `PendingReview` abierta del mismo paciente antes de crear
/// otra. Solo deduplica el replay exacto de la misma `Idempotency-Key`. Y el
/// paciente tampoco puede verla: el listado oculta las que estan en revision.
/// Sin este marcador, cada visita a Consejos con la lista vacia pediria una
/// recomendacion nueva.
///
/// Pasa por dos momentos:
///
/// 1. **Pedido en curso** ([recommendationId] nulo). Se guarda la clave
///    *antes* de llamar. Si la respuesta se pierde por la red, el reintento
///    reusa la misma clave y el servidor devuelve la recomendacion que ya
///    habia creado en vez de crear una segunda.
/// 2. **En revision** ([recommendationId] lleno). Mientras no venza, no se
///    vuelve a pedir y se muestra el aviso de "en revision".
@freezed
abstract class PendingRecommendationRequest
    with _$PendingRecommendationRequest {
  const factory PendingRecommendationRequest({
    /// Paciente que la pidio. Un marcador de otra cuenta en el mismo
    /// dispositivo se descarta.
    required String ownerUserId,

    /// `Idempotency-Key` del `POST /recommendations`.
    required String idempotencyKey,

    /// Momento del pedido, o de la generacion si el servidor ya respondio.
    required DateTime requestedAt,
    String? recommendationId,

    /// Vencimiento que informo el servidor (72 h desde la generacion).
    DateTime? expiresAt,
  }) = _PendingRecommendationRequest;

  const PendingRecommendationRequest._();

  /// Ventana de revision del backend (`ExpirationWindowHours: 72`).
  ///
  /// Solo se usa si el servidor no informo `expiresAt`, para que un marcador
  /// sin vencimiento no bloquee la generacion para siempre.
  static const Duration reviewWindow = Duration(hours: 72);

  bool get hasResult => recommendationId != null;

  DateTime get effectiveExpiry => expiresAt ?? requestedAt.add(reviewWindow);

  /// La recomendacion pedida sigue en revision.
  ///
  /// **No distingue rechazada de pendiente**: el paciente no ve ninguna de las
  /// dos. Una rechazada se sigue mostrando "en revision" hasta que vence su
  /// ventana. Es una limitacion del contrato, no de este marcador.
  bool isAwaitingReview(DateTime now) =>
      hasResult && now.isBefore(effectiveExpiry);
}

/// Que hacer al abrir Consejos.
enum GenerationDecision {
  /// Pedir una recomendacion: la lista esta vacia y no hay ninguna en revision.
  request,

  /// Hay una en revision: mostrar el aviso, sin pedir otra.
  awaitReview,

  /// Hay recomendaciones visibles: no se pide nada.
  none,
}

/// Reglas de la guarda anti-duplicados, sin estado ni efectos.
abstract final class RecommendationRequestPolicy {
  /// Devuelve el marcador que sigue valiendo, o `null` si hay que borrarlo.
  ///
  /// Se borra cuando:
  /// - es de otra cuenta;
  /// - su recomendacion ya aparece en la lista visible (fue aprobada);
  /// - su ventana de revision ya paso (vencio o fue rechazada).
  ///
  /// Un pedido en curso sin resultado se conserva: su clave sirve para el
  /// reintento.
  static PendingRecommendationRequest? reconcile({
    required PendingRecommendationRequest? marker,
    required String currentUserId,
    required Iterable<String> visibleIds,
    required DateTime now,
  }) {
    if (marker == null || marker.ownerUserId != currentUserId) {
      return null;
    }
    if (!marker.hasResult) {
      return marker;
    }
    if (visibleIds.contains(marker.recommendationId)) {
      return null;
    }
    if (!now.isBefore(marker.effectiveExpiry)) {
      return null;
    }
    return marker;
  }

  /// Decide si pedir una recomendacion al abrir Consejos.
  ///
  /// [marker] tiene que venir ya reconciliado.
  static GenerationDecision decide({
    required bool listIsEmpty,
    required PendingRecommendationRequest? marker,
    required DateTime now,
  }) {
    if (!listIsEmpty) {
      return GenerationDecision.none;
    }
    if (marker != null && marker.isAwaitingReview(now)) {
      return GenerationDecision.awaitReview;
    }
    return GenerationDecision.request;
  }
}
