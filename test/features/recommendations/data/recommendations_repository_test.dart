import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/recommendations/data/recommendations_repository.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation_feedback_draft.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';

/// Arma el repositorio sobre el cliente OpenAPI real, con la red sustituida.
({RecommendationsRepository repository, CannedHttpAdapter adapter}) _harness(
  Map<String, Object> routes,
) {
  final adapter = CannedHttpAdapter.routed(routes);
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(dio: dio, interceptors: const <Interceptor>[]);
  return (
    repository: RecommendationsRepository(
      patientApi: client.getPatientRecommendationsApi(),
      recommendationsApi: client.getRecommendationsApi(),
    ),
    adapter: adapter,
  );
}

const String _id = '3f1a9c2e-7b4d-4a6f-8e0c-1b2a3d4e5f60';

Map<String, dynamic> _summary(String id, String status) => <String, dynamic>{
      'recommendationId': id,
      'status': status,
      'confidenceScore': 0.62,
      'itemsCount': 3,
      'generatedAt': '2026-09-20T15:00:00Z',
      'expiresAt': '2026-09-23T15:00:00Z',
    };

Map<String, dynamic> _detail({
  String status = 'ModifiedApproved',
  String source = 'LlmGenerated',
}) =>
    <String, dynamic>{
      'recommendationId': _id,
      'patientId': '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
      'modelVersionName': 'rule-v1.0.0',
      'status': status,
      'confidenceScore': 0.72,
      'autoApproved': false,
      'reviewedByNutritionistId': 'a1b2c3d4-0000-4000-8000-000000000001',
      'nutritionistNote': 'Ajusté la porción de cebolla.',
      'aiExplanation': 'Tus episodios ocurrieron tras comidas con cebolla.',
      'explanationSource': source,
      'generatedAt': '2026-09-20T15:00:00Z',
      'reviewedAt': '2026-09-20T17:00:00Z',
      'deliveredAt': null,
      'expiresAt': '2026-09-23T15:00:00Z',
      'items': <Map<String, dynamic>>[
        <String, dynamic>{
          'recommendationItemId': 'item-1',
          'foodId': 'food-1',
          'foodName': 'Cebolla',
          'category': 'Verduras',
          'actionType': 'Avoid',
          'substituteFoodId': null,
          'substituteFoodName': null,
          'reasoning': 'Carga FODMAP estimada alta (probabilidad 0.78).',
        },
        <String, dynamic>{
          'recommendationItemId': 'item-2',
          'foodId': 'food-2',
          'foodName': 'Leche entera',
          'category': 'Lácteos',
          'actionType': 'Substitute',
          'substituteFoodId': 'food-3',
          'substituteFoodName': 'Bebida de almendras',
          'reasoning': 'Justificación por contenido de FODMAP.',
        },
        // El backend manda el nombre vacio cuando el alimento ya no esta en
        // el catalogo.
        <String, dynamic>{
          'recommendationItemId': 'item-3',
          'foodId': 'food-9',
          'foodName': '',
          'actionType': 'Reduce',
        },
      ],
      'feedback': null,
      'reviewedByNutritionistName': 'Ana Gómez',
      'steps': <String>['Usa cebolla solo como saborizante.', '  '],
      'supportingData': <String, dynamic>{
        'symptomCountsLast14d': 4,
        'mealCountsLast14d': 9,
        'topFodmapHighFoodsLast14d': <String>['Cebolla', 'Ajo'],
        'correlationWindowHours': 4,
        'analysisWindowFrom': '2026-09-10T00:00:00Z',
        'analysisWindowTo': '2026-09-24T00:00:00Z',
      },
    };

void main() {
  group('RecommendationsRepository · GET /recommendations/me', () {
    test('pide una sola pagina, sin filtro de estado', () async {
      final h = _harness(<String, Object>{
        'GET /api/v1/recommendations/me': const CannedResponse.ok(
          <String, dynamic>{
            'items': <Map<String, dynamic>>[],
            'page': 1,
            'pageSize': 50,
            'totalCount': 0,
          },
        ),
      });

      await h.repository.listMine();

      final request = h.adapter.lastRequest;
      expect(request.method, 'GET');
      expect(request.path, endsWith('/api/v1/recommendations/me'));
      expect(request.queryParameters['page'], 1);
      expect(request.queryParameters['pageSize'], 50);
      expect(request.queryParameters.containsKey('status'), isFalse);
    });

    test('descarta la vencida en el borde y los elementos incompletos', () {
      // El listado filtra primero y vence despues: en la lectura que la vence
      // una recomendacion vuelve con Expired.
      final h = _harness(<String, Object>{
        'GET /api/v1/recommendations/me': CannedResponse.ok(<String, dynamic>{
          'items': <Map<String, dynamic>>[
            _summary('rec-1', 'Approved'),
            _summary('rec-2', 'Expired'),
            _summary('rec-3', 'FeedbackReceived'),
            <String, dynamic>{'recommendationId': 'rec-4'},
          ],
          'page': 1,
          'pageSize': 50,
          'totalCount': 4,
        }),
      });

      expect(
        h.repository.listMine(),
        completion(
          isA<List<RecommendationSummary>>().having(
            (list) => list.map((s) => s.id),
            'ids',
            <String>['rec-1', 'rec-3'],
          ),
        ),
      );
    });

    test('traduce los campos del resumen', () async {
      final h = _harness(<String, Object>{
        'GET /api/v1/recommendations/me': CannedResponse.ok(<String, dynamic>{
          'items': <Map<String, dynamic>>[_summary('rec-1', 'ManualApproved')],
        }),
      });

      final summary = (await h.repository.listMine()).single;

      expect(summary.status, RecommendationStatusOption.manualApproved);
      expect(summary.confidenceScore, 0.62);
      expect(summary.itemsCount, 3);
      expect(summary.generatedAt, DateTime.utc(2026, 9, 20, 15));
    });
  });

  group('RecommendationsRepository · GET /recommendations/{id}', () {
    test('usa RecommendationsApi y traduce el detalle completo', () async {
      final h = _harness(<String, Object>{
        'GET /api/v1/recommendations/$_id': CannedResponse.ok(_detail()),
      });

      final detail = await h.repository.fetchDetail(_id);

      expect(h.adapter.lastRequest.path, endsWith('/recommendations/$_id'));
      expect(detail.status, RecommendationStatusOption.modifiedApproved);
      expect(detail.reviewerName, 'Ana Gómez');
      expect(detail.explanationSource, ExplanationOrigin.llmGenerated);
      expect(detail.items.map((i) => i.foodName), <String>[
        'Cebolla',
        'Leche entera',
      ]);
      final substitute = detail.items[1];
      expect(substitute.action, RecommendationAction.substitute);
      expect(substitute.substituteFoodName, 'Bebida de almendras');
      expect(detail.steps, <String>['Usa cebolla solo como saborizante.']);
      final data = detail.supportingData!;
      expect(data.symptomCount, 4);
      expect(data.mealCount, 9);
      expect(data.correlationWindowHours, 4);
      expect(data.topHighFodmapFoods, <String>['Cebolla', 'Ajo']);
      expect(detail.feedback, isNull);
    });

    test('una no visible responde 404 recommendation_not_found (CP038)', () {
      final h = _harness(<String, Object>{
        'GET /api/v1/recommendations/$_id': CannedResponse.problem(
          statusCode: 404,
          errorCode: 'recommendation_not_found',
        ),
      });

      expect(
        h.repository.fetchDetail(_id),
        throwsA(isA<RecommendationNotFoundError>()),
      );
    });

    test('un cuerpo sin estado es una respuesta inservible', () {
      final h = _harness(<String, Object>{
        'GET /api/v1/recommendations/$_id': const CannedResponse.ok(
          <String, dynamic>{'recommendationId': _id},
        ),
      });

      expect(
        h.repository.fetchDetail(_id),
        throwsA(
          isA<UnknownError>().having((e) => e.statusCode, 'status', 200),
        ),
      );
    });
  });

  group('RecommendationsRepository · POST /recommendations', () {
    test('manda la clave recibida en el header y lee el resultado', () async {
      final h = _harness(<String, Object>{
        'POST /api/v1/recommendations': const CannedResponse.created(
          <String, dynamic>{
            'recommendationId': _id,
            'status': 'PendingReview',
            'requiresReview': true,
            'generatedAt': '2026-09-24T12:00:00Z',
            'expiresAt': '2026-09-27T12:00:00Z',
          },
        ),
      });

      final result = await h.repository.requestGeneration(
        idempotencyKey: '11111111-2222-4333-8444-555555555555',
      );

      expect(
        h.adapter.lastRequest.headers['Idempotency-Key'],
        '11111111-2222-4333-8444-555555555555',
      );
      expect(result.id, _id);
      expect(result.status, RecommendationStatusOption.pendingReview);
      expect(result.isAlreadyVisible, isFalse);
      expect(result.expiresAt, DateTime.utc(2026, 9, 27, 12));
    });

    test('los 422 de negocio llegan tipados', () async {
      for (final (code, matcher) in <(String, Matcher)>[
        (
          'insufficient_clinical_history',
          isA<InsufficientClinicalHistoryError>()
        ),
        (
          'all_candidates_filtered_by_allergies',
          isA<AllCandidatesFilteredByAllergiesError>()
        ),
        ('no_active_model_version', isA<NoActiveModelVersionError>()),
      ]) {
        final h = _harness(<String, Object>{
          'POST /api/v1/recommendations':
              CannedResponse.problem(statusCode: 422, errorCode: code),
        });

        await expectLater(
          h.repository.requestGeneration(idempotencyKey: 'k'),
          throwsA(matcher),
          reason: code,
        );
      }
    });
  });

  group('RecommendationsRepository · POST /recommendations/{id}/deliver', () {
    test('la clave es estable, derivada del identificador (decision 7)',
        () async {
      final h = _harness(<String, Object>{
        'POST /api/v1/recommendations/$_id/deliver':
            const CannedResponse.noContent(),
      });

      await h.repository.deliver(_id);
      await h.repository.deliver(_id);

      final keys = h.adapter.requests
          .map((request) => request.headers['Idempotency-Key'])
          .toList();
      expect(keys, hasLength(2));
      expect(keys.first, keys.last);
      expect(keys.first, RecommendationsRepository.deliveryKeyFor(_id));
      // El servidor la enlaza como Guid.
      expect(
        keys.first,
        matches(RegExp(r'^[0-9a-f]{8}-[0-9a-f]{4}-5[0-9a-f]{3}-')),
      );
      expect(
        RecommendationsRepository.deliveryKeyFor('otra'),
        isNot(keys.first),
      );
    });

    test('409 conflict_state es un exito silencioso', () async {
      final h = _harness(<String, Object>{
        'POST /api/v1/recommendations/$_id/deliver': CannedResponse.problem(
          statusCode: 409,
          errorCode: 'conflict_state',
        ),
      });

      expect(
        await h.repository.deliver(_id),
        DeliveryOutcome.alreadySettled,
      );
    });

    test('409 recommendation_expired si se propaga', () {
      final h = _harness(<String, Object>{
        'POST /api/v1/recommendations/$_id/deliver': CannedResponse.problem(
          statusCode: 409,
          errorCode: 'recommendation_expired',
        ),
      });

      expect(
        h.repository.deliver(_id),
        throwsA(isA<RecommendationExpiredError>()),
      );
    });
  });

  group('RecommendationsRepository · POST /recommendations/{id}/feedback', () {
    test('serializa la respuesta con su clave y el comentario recortado',
        () async {
      final h = _harness(<String, Object>{
        'POST /api/v1/recommendations/$_id/feedback':
            const CannedResponse.noContent(),
      });

      await h.repository.submitFeedback(
        _id,
        draft: const RecommendationFeedbackDraft(
          wasApplied: true,
          outcome: FeedbackOutcomeOption.improvement,
          comment: '  Menos hinchazón en las noches ',
        ),
        idempotencyKey: 'feedback-key',
      );

      final request = h.adapter.lastRequest;
      expect(request.headers['Idempotency-Key'], 'feedback-key');
      expect(request.body, <String, dynamic>{
        'wasApplied': true,
        'outcome': 'Improvement',
        'comment': 'Menos hinchazón en las noches',
      });
    });

    test('sin comentario, el campo no viaja con texto', () async {
      final h = _harness(<String, Object>{
        'POST /api/v1/recommendations/$_id/feedback':
            const CannedResponse.noContent(),
      });

      await h.repository.submitFeedback(
        _id,
        draft: const RecommendationFeedbackDraft(
          wasApplied: false,
          outcome: FeedbackOutcomeOption.worsening,
          comment: '   ',
        ),
        idempotencyKey: 'k',
      );

      final body = h.adapter.lastRequest.body;
      expect(body['outcome'], 'Worsening');
      expect(body['comment'], isNull);
    });
  });
}
