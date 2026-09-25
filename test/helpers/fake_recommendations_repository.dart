import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendation_request_store.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/recommendations/domain/pending_recommendation_request.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation_feedback_draft.dart';

/// Nutricionista de los casos de prueba (CP041).
const String demoNutritionistName = 'Ana Gómez';

final DateTime demoGeneratedAt = DateTime.utc(2026, 9, 20, 15);

/// Recomendacion del motor aprobada por la nutricionista, con los cuatro
/// bloques completos (CP036, CP040, CP041, CP042).
///
/// Confianza 0.55: media, como pide CP040.
final RecommendationDetail approvedDetail = RecommendationDetail(
  id: 'rec-approved',
  status: RecommendationStatusOption.approved,
  confidenceScore: 0.55,
  generatedAt: demoGeneratedAt,
  reviewerId: 'nutri-1',
  reviewerName: demoNutritionistName,
  nutritionistNote:
      'Reducir el consumo de lácteos por intolerancia detectada en tus '
      'registros.',
  explanation: 'El sistema identificó que tus episodios de dolor abdominal '
      'ocurrieron dentro de las 4 horas posteriores a comidas con cebolla, '
      'un alimento alto en fructanos.',
  explanationSource: ExplanationOrigin.llmGenerated,
  reviewedAt: demoGeneratedAt.add(const Duration(hours: 2)),
  expiresAt: demoGeneratedAt.add(const Duration(hours: 72)),
  items: const <RecommendationItem>[
    RecommendationItem(
      id: 'item-1',
      foodName: 'Cebolla',
      action: RecommendationAction.avoid,
      reasoning: 'Carga FODMAP estimada alta (probabilidad 0.78).',
    ),
    RecommendationItem(
      id: 'item-2',
      foodName: 'Ajo',
      action: RecommendationAction.avoid,
      reasoning: 'Carga FODMAP estimada alta (probabilidad 0.74).',
    ),
    RecommendationItem(
      id: 'item-3',
      foodName: 'Leche entera',
      action: RecommendationAction.substitute,
      substituteFoodName: 'Bebida de almendras',
      reasoning: 'Justificación por contenido de FODMAP.',
    ),
    RecommendationItem(
      id: 'item-4',
      foodName: 'Zanahoria cocida',
      action: RecommendationAction.suggest,
    ),
  ],
  steps: const <String>[
    'Usa cebolla solo como saborizante.',
    'Sustituye la leche entera en el desayuno.',
    'Registra cómo te sientes durante dos semanas.',
  ],
  supportingData: RecommendationSupportingData(
    symptomCount: 4,
    mealCount: 9,
    correlationWindowHours: 4,
    windowFrom: demoGeneratedAt.subtract(const Duration(days: 14)),
    windowTo: demoGeneratedAt,
    topHighFodmapFoods: const <String>['Cebolla', 'Ajo'],
  ),
);

/// Indicacion manual de la nutricionista (HU0029): sin motor, sin items.
final RecommendationDetail manualDetail = RecommendationDetail(
  id: 'rec-manual',
  status: RecommendationStatusOption.manualApproved,
  confidenceScore: 1,
  generatedAt: demoGeneratedAt,
  reviewerId: 'nutri-1',
  reviewerName: demoNutritionistName,
  nutritionistNote: 'Toma agua tibia en ayunas durante la próxima semana.',
  explanationSource: ExplanationOrigin.manual,
  reviewedAt: demoGeneratedAt,
  steps: const <String>['Un vaso al despertar.'],
  supportingData: approvedDetail.supportingData,
);

/// El resumen que el listado devolveria para [detail].
RecommendationSummary summaryOf(RecommendationDetail detail) {
  return RecommendationSummary(
    id: detail.id,
    status: detail.status,
    confidenceScore: detail.confidenceScore,
    itemsCount: detail.items.length,
    generatedAt: detail.generatedAt,
    expiresAt: detail.expiresAt,
  );
}

/// [RecommendationsRepository] controlable para los tests.
///
/// Imita las transiciones del servidor que importan al cliente: entregar
/// pasa la recomendacion a `Delivered`, y responder la pasa a
/// `FeedbackReceived` con su respuesta.
class FakeRecommendationsRepository implements RecommendationsRepository {
  FakeRecommendationsRepository({
    List<RecommendationDetail> details = const <RecommendationDetail>[],
    this.generationResult,
  }) : _details = <String, RecommendationDetail>{
          for (final detail in details) detail.id: detail,
        };

  final Map<String, RecommendationDetail> _details;

  GeneratedRecommendation? generationResult;
  DeliveryOutcome deliveryOutcome = DeliveryOutcome.delivered;

  CauceApiError? listError;
  CauceApiError? detailError;
  CauceApiError? generationError;
  CauceApiError? deliveryError;
  CauceApiError? feedbackError;

  /// Retardo del pedido de generacion, para probar pedidos simultaneos.
  Duration generationDelay = Duration.zero;

  int listCalls = 0;
  int detailCalls = 0;
  final List<String> generationKeys = <String>[];
  final List<String> deliveredIds = <String>[];
  final List<String> feedbackKeys = <String>[];
  final List<RecommendationFeedbackDraft> feedbackDrafts =
      <RecommendationFeedbackDraft>[];

  RecommendationDetail? detailOf(String id) => _details[id];

  void put(RecommendationDetail detail) => _details[detail.id] = detail;

  @override
  Future<List<RecommendationSummary>> listMine() async {
    listCalls++;
    final error = listError;
    if (error != null) {
      throw error;
    }
    return _details.values
        .where((detail) => detail.status.isVisibleToPatient)
        .map(summaryOf)
        .toList();
  }

  @override
  Future<RecommendationDetail> fetchDetail(String id) async {
    detailCalls++;
    final error = detailError;
    if (error != null) {
      throw error;
    }
    final detail = _details[id];
    if (detail == null || !detail.status.isVisibleToPatient) {
      throw const CauceApiError.recommendationNotFound();
    }
    return detail;
  }

  @override
  Future<GeneratedRecommendation> requestGeneration({
    required String idempotencyKey,
  }) async {
    generationKeys.add(idempotencyKey);
    if (generationDelay != Duration.zero) {
      await Future<void>.delayed(generationDelay);
    }
    final error = generationError;
    if (error != null) {
      throw error;
    }
    return generationResult!;
  }

  @override
  Future<DeliveryOutcome> deliver(String id) async {
    deliveredIds.add(id);
    final error = deliveryError;
    if (error != null) {
      throw error;
    }
    final detail = _details[id];
    if (detail != null && detail.status.isDeliverable) {
      _details[id] = detail.copyWith(
        status: RecommendationStatusOption.delivered,
        deliveredAt: DateTime.utc(2026, 9, 21),
      );
    }
    return deliveryOutcome;
  }

  @override
  Future<void> submitFeedback(
    String id, {
    required RecommendationFeedbackDraft draft,
    required String idempotencyKey,
  }) async {
    feedbackKeys.add(idempotencyKey);
    feedbackDrafts.add(draft);
    final error = feedbackError;
    if (error != null) {
      throw error;
    }
    final detail = _details[id];
    if (detail != null) {
      _details[id] = detail.copyWith(
        status: RecommendationStatusOption.feedbackReceived,
        feedback: RecommendationFeedback(
          wasApplied: draft.wasApplied!,
          outcome: draft.outcome!,
          submittedAt: DateTime.utc(2026, 9, 22),
          comment: draft.commentToSend,
        ),
      );
    }
  }
}

/// Marcador en memoria, en lugar del almacenamiento seguro.
class InMemoryRecommendationRequestStore implements RecommendationRequestStore {
  InMemoryRecommendationRequestStore([this.value]);

  PendingRecommendationRequest? value;
  int writes = 0;
  int clears = 0;

  @override
  Future<PendingRecommendationRequest?> read() async => value;

  @override
  Future<void> write(PendingRecommendationRequest request) async {
    writes++;
    value = request;
  }

  @override
  Future<void> clear() async {
    clears++;
    value = null;
  }
}
