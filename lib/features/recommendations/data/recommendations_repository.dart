import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/recommendation.dart';
import '../domain/recommendation_feedback_draft.dart';

part 'recommendations_repository.g.dart';

/// Resultado de marcar una recomendacion como entregada.
enum DeliveryOutcome {
  /// El servidor la paso a `Delivered`.
  delivered,

  /// Ya no estaba en un estado entregable: la habia entregado antes este u
  /// otro dispositivo. Para el paciente es lo mismo (decision 7).
  alreadySettled,
}

/// Acceso a las recomendaciones del paciente (EP0003).
///
/// Misma frontera que el resto de los repositorios: hacia adentro habla
/// `built_value` y `DioException`; hacia afuera solo tipos del dominio y
/// `CauceApiError`.
///
/// Usa dos APIs generadas porque el detalle no esta en
/// `PatientRecommendationsApi` sino en `RecommendationsApi`.
class RecommendationsRepository {
  const RecommendationsRepository({
    required api.PatientRecommendationsApi patientApi,
    required api.RecommendationsApi recommendationsApi,
  })  : _patientApi = patientApi,
        _recommendationsApi = recommendationsApi;

  final api.PatientRecommendationsApi _patientApi;
  final api.RecommendationsApi _recommendationsApi;

  /// Una sola pagina, sin paginar. Con la regla de generacion vigente un
  /// paciente tiene pocas recomendaciones visibles, muy por debajo de este
  /// tope (el maximo del backend es 100).
  static const int pageSize = 50;

  /// `GET /api/v1/recommendations/me`, sin filtro de estado.
  ///
  /// Descarta dos cosas en vez de tumbar la lista entera: los elementos a los
  /// que les falta un campo esencial, y los que llegan en un estado que el
  /// paciente no ve. Lo segundo no es paranoia: el listado filtra primero y
  /// vence despues, y en la lectura que la vence una recomendacion vuelve con
  /// `Expired`.
  Future<List<RecommendationSummary>> listMine() {
    return guardApiCall(() async {
      final response = await _patientApi.apiV1RecommendationsMeGet(
        page: 1,
        pageSize: pageSize,
      );
      final items = response.data?.items;
      if (items == null) {
        return const <RecommendationSummary>[];
      }
      return items
          .map(_summaryFrom)
          .nonNulls
          .where((summary) => summary.status.isVisibleToPatient)
          .toList();
    });
  }

  /// `GET /api/v1/recommendations/{id}`.
  ///
  /// Para el paciente, una recomendacion que existe pero no es visible
  /// responde 404 `recommendation_not_found`, igual que una inexistente.
  Future<RecommendationDetail> fetchDetail(String id) {
    return guardApiCall(() async {
      final response =
          await _recommendationsApi.apiV1RecommendationsIdGet(id: id);
      final dto = response.data;
      final detailId = dto?.recommendationId;
      final status = RecommendationStatusOption.fromApi(dto?.status);
      final generatedAt = dto?.generatedAt;
      if (dto == null ||
          detailId == null ||
          status == null ||
          generatedAt == null) {
        throw const FormatException(
          'GET /recommendations/{id} respondio sin identificador, estado o '
          'fecha de generacion.',
        );
      }

      return RecommendationDetail(
        id: detailId,
        status: status,
        confidenceScore: dto.confidenceScore ?? 0,
        generatedAt: generatedAt,
        autoApproved: dto.autoApproved ?? false,
        reviewerId: dto.reviewedByNutritionistId,
        reviewerName: _nonBlank(dto.reviewedByNutritionistName),
        nutritionistNote: dto.nutritionistNote,
        explanation: dto.aiExplanation,
        explanationSource: ExplanationOrigin.fromApi(dto.explanationSource),
        reviewedAt: dto.reviewedAt,
        deliveredAt: dto.deliveredAt,
        expiresAt: dto.expiresAt,
        items: dto.items?.map(_itemFrom).nonNulls.toList() ??
            const <RecommendationItem>[],
        steps: dto.steps
                ?.map((step) => step.trim())
                .where((step) => step.isNotEmpty)
                .toList() ??
            const <String>[],
        supportingData: _supportingDataFrom(dto.supportingData),
        feedback: _feedbackFrom(dto.feedback),
      );
    });
  }

  /// `POST /api/v1/recommendations`.
  ///
  /// [idempotencyKey] la genera quien llama y la guarda **antes** de llamar,
  /// para poder repetirla si la respuesta se pierde (decision 2).
  Future<GeneratedRecommendation> requestGeneration({
    required String idempotencyKey,
  }) {
    return guardApiCall(
      () async {
        final response = await _patientApi.apiV1RecommendationsPost(
          idempotencyKey: idempotencyKey,
        );
        final result = response.data;
        final id = result?.recommendationId;
        final status = RecommendationStatusOption.fromApi(result?.status);
        if (result == null || id == null || status == null) {
          throw const FormatException(
            'POST /recommendations respondio sin identificador o estado.',
          );
        }
        return GeneratedRecommendation(
          id: id,
          status: status,
          generatedAt: result.generatedAt,
          expiresAt: result.expiresAt,
        );
      },
      malformedResponseStatus: 201,
    );
  }

  /// `POST /api/v1/recommendations/{id}/deliver`.
  ///
  /// La clave es **estable y derivada del identificador** (decision 7): abrir
  /// el mismo detalle dos veces repite la misma clave, y dentro de los 7 dias
  /// del servidor eso es un replay que devuelve 204 y no un segundo intento.
  ///
  /// Un 409 `conflict_state` significa que ya no estaba en un estado
  /// entregable, tipicamente porque ya estaba entregada. No es un error para
  /// el paciente y no sale de aca como tal.
  Future<DeliveryOutcome> deliver(String id) async {
    try {
      await guardApiCall(
        () => _patientApi.apiV1RecommendationsIdDeliverPost(
          id: id,
          idempotencyKey: deliveryKeyFor(id),
        ),
      );
      return DeliveryOutcome.delivered;
    } on ConflictStateError {
      return DeliveryOutcome.alreadySettled;
    }
  }

  /// `POST /api/v1/recommendations/{id}/feedback`.
  ///
  /// [idempotencyKey] se repite intacta en el reintento de una misma
  /// respuesta: si el primer envio llego y se perdio la confirmacion, el
  /// servidor devuelve la respuesta guardada en vez de un 409.
  Future<void> submitFeedback(
    String id, {
    required RecommendationFeedbackDraft draft,
    required String idempotencyKey,
  }) {
    final wasApplied = draft.wasApplied;
    final outcome = draft.outcome;
    if (wasApplied == null || outcome == null) {
      throw ArgumentError(
        'La retroalimentacion exige si se aplico y el resultado percibido.',
      );
    }
    return guardApiCall(
      () => _patientApi.apiV1RecommendationsIdFeedbackPost(
        id: id,
        idempotencyKey: idempotencyKey,
        submitFeedbackRequest: api.SubmitFeedbackRequest(
          (b) => b
            ..wasApplied = wasApplied
            ..outcome = outcome.toApi()
            ..comment = draft.commentToSend,
        ),
      ),
    );
  }

  /// Clave de entrega de una recomendacion: UUID v5 sobre su identificador.
  ///
  /// El servidor la recibe como `Guid`, asi que tiene que ser un UUID valido;
  /// v5 da siempre el mismo para el mismo identificador.
  static String deliveryKeyFor(String id) => const Uuid().v5(
        Namespace.url.value,
        'https://cauce.app/recommendations/$id/deliver',
      );

  static RecommendationSummary? _summaryFrom(api.RecommendationSummaryDto dto) {
    final id = dto.recommendationId;
    final status = RecommendationStatusOption.fromApi(dto.status);
    final generatedAt = dto.generatedAt;
    if (id == null || status == null || generatedAt == null) {
      return null;
    }
    return RecommendationSummary(
      id: id,
      status: status,
      confidenceScore: dto.confidenceScore ?? 0,
      itemsCount: dto.itemsCount ?? 0,
      generatedAt: generatedAt,
      expiresAt: dto.expiresAt,
    );
  }

  /// Un item sin accion o sin nombre de alimento no se puede mostrar.
  ///
  /// El backend manda el nombre vacio cuando el alimento ya no esta en el
  /// catalogo; se descarta en vez de pintar una fila en blanco.
  static RecommendationItem? _itemFrom(api.RecommendationItemDto dto) {
    final action = RecommendationAction.fromApi(dto.actionType);
    final name = _nonBlank(dto.foodName);
    if (action == null || name == null) {
      return null;
    }
    return RecommendationItem(
      id: dto.recommendationItemId ?? name,
      foodName: name,
      action: action,
      category: _nonBlank(dto.category),
      substituteFoodName: _nonBlank(dto.substituteFoodName),
      reasoning: _nonBlank(dto.reasoning),
    );
  }

  static RecommendationSupportingData? _supportingDataFrom(
    api.RecommendationSupportingDataDto? dto,
  ) {
    final from = dto?.analysisWindowFrom;
    final to = dto?.analysisWindowTo;
    if (dto == null || from == null || to == null) {
      return null;
    }
    return RecommendationSupportingData(
      symptomCount: dto.symptomCountsLast14d ?? 0,
      mealCount: dto.mealCountsLast14d ?? 0,
      correlationWindowHours: dto.correlationWindowHours ?? 4,
      windowFrom: from,
      windowTo: to,
      topHighFodmapFoods: dto.topFodmapHighFoodsLast14d
              ?.map((name) => name.trim())
              .where((name) => name.isNotEmpty)
              .toList() ??
          const <String>[],
    );
  }

  static RecommendationFeedback? _feedbackFrom(
    api.RecommendationFeedbackDto? dto,
  ) {
    final wasApplied = dto?.wasApplied;
    final outcome = FeedbackOutcomeOption.fromApi(dto?.outcome);
    final submittedAt = dto?.submittedAt;
    if (dto == null ||
        wasApplied == null ||
        outcome == null ||
        submittedAt == null) {
      return null;
    }
    return RecommendationFeedback(
      wasApplied: wasApplied,
      outcome: outcome,
      submittedAt: submittedAt,
      comment: _nonBlank(dto.comment),
    );
  }

  static String? _nonBlank(String? value) {
    final text = value?.trim();
    return text == null || text.isEmpty ? null : text;
  }
}

@Riverpod(keepAlive: true)
RecommendationsRepository recommendationsRepository(Ref ref) =>
    RecommendationsRepository(
      patientApi: ref.watch(patientRecommendationsApiProvider),
      recommendationsApi: ref.watch(recommendationsApiProvider),
    );
