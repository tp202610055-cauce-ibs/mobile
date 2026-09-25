import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

import 'confidence_level.dart';
import 'recommendation_origin.dart';

part 'recommendation.freezed.dart';

/// Estado de una recomendacion en la maquina HITL del backend.
///
/// Enum propio y no `api.RecommendationStatus` por el mismo criterio que el
/// resto del dominio: el generado es `built_value` y esta atado al ciclo de
/// regeneracion del cliente OpenAPI. Se conservan los nueve valores aunque el
/// paciente solo vea cinco, para que el mapeo no pierda informacion.
enum RecommendationStatusOption {
  generated,
  pendingReview,
  approved,
  modifiedApproved,
  manualApproved,
  rejected,
  delivered,
  feedbackReceived,
  expired;

  static RecommendationStatusOption? fromApi(api.RecommendationStatus? value) {
    return switch (value) {
      api.RecommendationStatus.generated => generated,
      api.RecommendationStatus.pendingReview => pendingReview,
      api.RecommendationStatus.approved => approved,
      api.RecommendationStatus.modifiedApproved => modifiedApproved,
      api.RecommendationStatus.manualApproved => manualApproved,
      api.RecommendationStatus.rejected => rejected,
      api.RecommendationStatus.delivered => delivered,
      api.RecommendationStatus.feedbackReceived => feedbackReceived,
      api.RecommendationStatus.expired => expired,
      _ => null,
    };
  }

  /// Estados que el paciente puede ver (acta A24 del backend).
  ///
  /// El servidor ya filtra por esto. Se repite aca por el caso borde del
  /// listado: filtra primero y vence despues, de modo que una recomendacion
  /// puede volver con `Expired` en la misma respuesta que la vencio.
  bool get isVisibleToPatient => switch (this) {
        approved ||
        modifiedApproved ||
        manualApproved ||
        delivered ||
        feedbackReceived =>
          true,
        generated || pendingReview || rejected || expired => false,
      };

  /// Aprobada y todavia sin abrir: se puede entregar, y es "nueva" para el
  /// paciente (HU0014 CA1).
  bool get isDeliverable => switch (this) {
        approved || modifiedApproved || manualApproved => true,
        _ => false,
      };

  /// El backend solo acepta feedback desde `Delivered`.
  bool get acceptsFeedback => this == delivered;
}

/// Que propone hacer un item con un alimento.
enum RecommendationAction {
  suggest,
  reduce,
  avoid,
  substitute;

  static RecommendationAction? fromApi(api.ActionType? value) {
    return switch (value) {
      api.ActionType.suggest => suggest,
      api.ActionType.reduce => reduce,
      api.ActionType.avoid => avoid,
      api.ActionType.substitute => substitute,
      _ => null,
    };
  }

  /// Orden en que se enumeran y con el que se desempata.
  ///
  /// Es el mismo que usa `FallbackExplanationProvider` del backend (evitar,
  /// sustituir, reducir, incorporar), de modo que el titulo compuesto y la
  /// explicacion de respaldo nombran las acciones en el mismo orden.
  static const List<RecommendationAction> displayOrder = <RecommendationAction>[
    avoid,
    substitute,
    reduce,
    suggest,
  ];
}

/// Origen del texto de la explicacion.
enum ExplanationOrigin {
  llmGenerated,
  fallback,
  manual;

  static ExplanationOrigin? fromApi(api.ExplanationSource? value) {
    return switch (value) {
      api.ExplanationSource.llmGenerated => llmGenerated,
      api.ExplanationSource.fallback => fallback,
      api.ExplanationSource.manual => manual,
      _ => null,
    };
  }
}

/// Resultado que el paciente percibio tras aplicar la recomendacion.
enum FeedbackOutcomeOption {
  improvement,
  noChange,
  worsening;

  static FeedbackOutcomeOption? fromApi(api.FeedbackOutcome? value) {
    return switch (value) {
      api.FeedbackOutcome.improvement => improvement,
      api.FeedbackOutcome.noChange => noChange,
      api.FeedbackOutcome.worsening => worsening,
      _ => null,
    };
  }

  api.FeedbackOutcome toApi() => switch (this) {
        improvement => api.FeedbackOutcome.improvement,
        noChange => api.FeedbackOutcome.noChange,
        worsening => api.FeedbackOutcome.worsening,
      };
}

/// Una recomendacion tal como llega en el listado (`GET /recommendations/me`).
///
/// **No trae items, revisor ni nota.** Por eso cada tarjeta pide ademas su
/// detalle (decision tomada con Trigo en el arranque del bloque, acta M47).
@freezed
abstract class RecommendationSummary with _$RecommendationSummary {
  const factory RecommendationSummary({
    required String id,
    required RecommendationStatusOption status,
    required double confidenceScore,
    required int itemsCount,
    required DateTime generatedAt,
    DateTime? expiresAt,
  }) = _RecommendationSummary;
}

/// Respuesta de `POST /recommendations`.
@freezed
abstract class GeneratedRecommendation with _$GeneratedRecommendation {
  const factory GeneratedRecommendation({
    required String id,
    required RecommendationStatusOption status,
    DateTime? generatedAt,
    DateTime? expiresAt,
  }) = _GeneratedRecommendation;

  const GeneratedRecommendation._();

  /// El paciente ya la puede ver: se auto-aprobo. Con la auto-aprobacion
  /// apagada en el piloto no deberia pasar, pero el contrato lo permite.
  bool get isAlreadyVisible => status.isVisibleToPatient;
}

/// Un alimento dentro de la recomendacion.
@freezed
abstract class RecommendationItem with _$RecommendationItem {
  const factory RecommendationItem({
    required String id,
    required String foodName,
    required RecommendationAction action,
    String? category,
    String? substituteFoodName,

    /// Justificacion breve del motor. Llega tal cual del servidor.
    String? reasoning,
  }) = _RecommendationItem;
}

/// Cifras de respaldo del bloque 4 (HU0015 CA3).
///
/// El backend las calcula en cada lectura sobre los ultimos 14 dias, no al
/// generar la recomendacion.
@freezed
abstract class RecommendationSupportingData
    with _$RecommendationSupportingData {
  const factory RecommendationSupportingData({
    required int symptomCount,
    required int mealCount,
    required int correlationWindowHours,
    required DateTime windowFrom,
    required DateTime windowTo,
    @Default(<String>[]) List<String> topHighFodmapFoods,
  }) = _RecommendationSupportingData;

  const RecommendationSupportingData._();

  /// Dias de la ventana de analisis, para la etiqueta de cada cifra.
  int get windowDays => windowTo.difference(windowFrom).inDays;
}

/// Retroalimentacion ya enviada por el paciente (HU0016).
@freezed
abstract class RecommendationFeedback with _$RecommendationFeedback {
  const factory RecommendationFeedback({
    required bool wasApplied,
    required FeedbackOutcomeOption outcome,
    required DateTime submittedAt,
    String? comment,
  }) = _RecommendationFeedback;
}

/// Detalle completo de una recomendacion (`GET /recommendations/{id}`).
@freezed
abstract class RecommendationDetail with _$RecommendationDetail {
  const factory RecommendationDetail({
    required String id,
    required RecommendationStatusOption status,
    required double confidenceScore,
    required DateTime generatedAt,
    @Default(false) bool autoApproved,
    String? reviewerId,
    String? reviewerName,
    String? nutritionistNote,
    String? explanation,
    ExplanationOrigin? explanationSource,
    DateTime? reviewedAt,
    DateTime? deliveredAt,
    DateTime? expiresAt,
    @Default(<RecommendationItem>[]) List<RecommendationItem> items,
    @Default(<String>[]) List<String> steps,
    RecommendationSupportingData? supportingData,
    RecommendationFeedback? feedback,

    /// Origen que este dispositivo vio antes de la entrega, cuando lo sabe.
    ///
    /// El contrato lo pierde al entregar (ver [RecommendationOrigin.resolve]);
    /// lo completa la capa de aplicacion con lo que observo antes.
    RecommendationOrigin? knownOrigin,
  }) = _RecommendationDetail;

  const RecommendationDetail._();

  /// Creada a mano por el nutricionista (HU0029), sin motor de por medio.
  bool get isManual => explanationSource == ExplanationOrigin.manual;

  /// Pildora de origen (decision 10): la observada antes de la entrega si se
  /// conoce, o la inferida del contrato. Ver [RecommendationOrigin.resolve].
  RecommendationOrigin get origin =>
      knownOrigin ??
      RecommendationOrigin.resolve(
        status: status,
        explanationSource: explanationSource,
        itemsCount: items.length,
      );

  /// Nivel de confianza, o `null` si no corresponde mostrarlo.
  ///
  /// Una indicacion manual llega con `confidenceScore` fijo en 1.0: decir
  /// "confianza alta" ahi seria enganoso, porque no hubo modelo (acta M47).
  ConfidenceLevel? get confidenceLevel =>
      isManual ? null : ConfidenceLevel.fromScore(confidenceScore);

  /// Atribucion FODMAP al pie de la explicacion (decision 6).
  bool get showsAttribution => !isManual;

  /// Explicacion del sistema, sin espacios sobrantes, o `null` si no hay.
  ///
  /// Si el LLM fallo llega la plantilla de respaldo del backend
  /// (`explanationSource: Fallback`) y se muestra igual: no es un error
  /// (HU0015 CA4, CP077).
  String? get explanationText {
    final text = explanation?.trim();
    return text == null || text.isEmpty ? null : text;
  }

  /// Nota del nutricionista, o `null` si no dejo ninguna.
  ///
  /// Se muestra en cualquier estado, incluido `Approved`: HU0015 CA2 y CP041
  /// la piden siempre que exista, por sobre el mockup 11 (DEC-014), que la
  /// omite en ese estado (acta M47).
  String? get note {
    final text = nutritionistNote?.trim();
    return text == null || text.isEmpty ? null : text;
  }

  /// Aprobada y todavia sin abrir (HU0014 CA1).
  bool get isNew => status.isDeliverable;

  /// La vio un nutricionista antes de llegar al paciente (HU0015 CA2).
  bool get wasReviewed => reviewerId != null && !autoApproved;
}
