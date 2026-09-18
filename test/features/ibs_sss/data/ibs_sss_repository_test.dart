import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';

/// Arma el repositorio sobre el cliente OpenAPI real, con la red sustituida.
({IbsSssRepository repository, CannedHttpAdapter adapter}) _harness([
  CannedResponse? response,
]) {
  final adapter = CannedHttpAdapter(
    response ?? const CannedResponse.noContent(),
  );
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(dio: dio, interceptors: const <Interceptor>[]);
  return (
    repository: IbsSssRepository(client.getIbsSssApi()),
    adapter: adapter
  );
}

/// Cinco respuestas con valores distintos, para verificar que cada dimension
/// viaja en su propio campo y no se cruzan entre si.
IbsSssAnswers _answers() {
  return const IbsSssAnswers()
      .withAnswer(IbsSssDimension.painSeverity, 60)
      .withAnswer(IbsSssDimension.painFrequency, 40)
      .withAnswer(IbsSssDimension.bloatingSeverity, 55)
      .withAnswer(IbsSssDimension.bowelHabitsDissatisfaction, 35)
      .withAnswer(IbsSssDimension.lifeInterference, 30);
}

const Map<String, dynamic> _resultJson = <String, dynamic>{
  'assessmentId': 'dddddddd-0000-4000-8000-000000000001',
  'totalScore': 220,
  'severityCategory': 'Moderate',
  'nextAssessmentDate': '2026-09-29',
  'triggeredOnboardingCompletion': true,
};

void main() {
  group('IbsSssRepository · linea base (US04 CA01)', () {
    test('envia las cinco dimensiones en la ruta del contrato', () async {
      final h = _harness(const CannedResponse.created(_resultJson));

      await h.repository.submitBaseline(_answers());

      final request = h.adapter.lastRequest;
      expect(request.method, 'POST');
      expect(request.path, endsWith('/api/v1/ibs-sss'));
      expect(request.body['painSeverity'], 60);
      expect(request.body['painFrequency'], 40);
      expect(request.body['bloatingSeverity'], 55);
      expect(request.body['bowelHabitsDissatisfaction'], 35);
      expect(request.body['lifeInterference'], 30);
    });

    test('marca el tipo Baseline en PascalCase', () async {
      final h = _harness(const CannedResponse.created(_resultJson));

      await h.repository.submitBaseline(_answers());

      expect(h.adapter.lastRequest.body['assessmentType'], 'Baseline');
    });

    test('no envia el puntaje ni el cycleNumber: los calcula el servidor',
        () async {
      // CA01. Ademas, el backend rechaza una linea base con cycleNumber
      // distinto de cero, asi que mandarlo solo abriria la posibilidad de
      // mandarlo mal.
      final h = _harness(const CannedResponse.created(_resultJson));

      await h.repository.submitBaseline(_answers());

      final body = h.adapter.lastRequest.body;
      expect(body.containsKey('totalScore'), isFalse);
      expect(body.containsKey('cycleNumber'), isFalse);
      expect(body.containsKey('severityCategory'), isFalse);
    });

    test('traduce el 201 al resultado del dominio', () async {
      final h = _harness(const CannedResponse.created(_resultJson));

      final result = await h.repository.submitBaseline(_answers());

      expect(result.assessmentId, 'dddddddd-0000-4000-8000-000000000001');
      expect(result.totalScore, 220);
      expect(result.severity, IbsSssSeverity.moderate);
      expect(result.nextAssessmentDate, DateTime(2026, 9, 29));
      expect(result.triggeredOnboardingCompletion, isTrue);
    });

    test('un resultado sin el flag asume que no cerro el onboarding', () async {
      // Suponer que si cerro dejaria al paciente sin el paso que le falta y
      // sin forma de volver a el.
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{
          'assessmentId': 'dddddddd-0000-4000-8000-000000000001',
          'totalScore': 220,
        }),
      );

      final result = await h.repository.submitBaseline(_answers());

      expect(result.triggeredOnboardingCompletion, isFalse);
      expect(result.severity, isNull);
    });

    test('un 201 sin assessmentId no pasa por valido', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{'totalScore': 220}),
      );

      await expectLater(
        h.repository.submitBaseline(_answers()),
        throwsA(isA<UnknownError>()),
      );
    });
  });

  group('IbsSssRepository · guarda de completitud (CA02)', () {
    test('no envia nada si falta una dimension', () async {
      final h = _harness(const CannedResponse.created(_resultJson));
      final incomplete =
          const IbsSssAnswers().withAnswer(IbsSssDimension.painSeverity, 60);

      await expectLater(
        h.repository.submitBaseline(incomplete),
        throwsA(isA<StateError>()),
      );
      // Lo importante no es la excepcion sino que la peticion nunca salio: la
      // linea base es irrepetible por paciente.
      expect(h.adapter.requests, isEmpty);
    });

    test('con las respuestas vacias tampoco sale', () async {
      final h = _harness(const CannedResponse.created(_resultJson));

      await expectLater(
        h.repository.submitBaseline(const IbsSssAnswers()),
        throwsA(isA<StateError>()),
      );
      expect(h.adapter.requests, isEmpty);
    });
  });

  group('IbsSssRepository · errores del contrato', () {
    test('un 409 se tipa como linea base duplicada', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 409,
          errorCode: 'duplicate_baseline_assessment',
        ),
      );

      await expectLater(
        h.repository.submitBaseline(_answers()),
        throwsA(isA<DuplicateBaselineAssessmentError>()),
      );
    });

    test('un 400 de dimension fuera de rango se tipa', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 400,
          errorCode: 'invalid_ibs_sss_dimension',
        ),
      );

      await expectLater(
        h.repository.submitBaseline(_answers()),
        throwsA(isA<InvalidIbsSssDimensionError>()),
      );
    });

    test('el 404 sin perfil se tipa, aunque el backend ya guardo', () async {
      // El backend persiste la evaluacion y recien despues intenta cerrar el
      // onboarding, de modo que este 404 llega con la linea base ya guardada.
      // Distinguirlo permite releer el estado en vez de invitar a reintentar.
      final h = _harness(
        CannedResponse.problem(
          statusCode: 404,
          errorCode: 'patient_profile_not_found',
        ),
      );

      await expectLater(
        h.repository.submitBaseline(_answers()),
        throwsA(isA<PatientProfileNotFoundError>()),
      );
    });

    test('un 429 se propaga con su espera', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 429,
          extra: const <String, dynamic>{'retryAfterSeconds': 45},
        ),
      );

      try {
        await h.repository.submitBaseline(_answers());
        fail('Se esperaba un RateLimitedError.');
      } on CauceApiError catch (error) {
        expect(error, isA<RateLimitedError>());
        expect((error as RateLimitedError).retryAfterSeconds, 45);
      }
    });
  });
}
