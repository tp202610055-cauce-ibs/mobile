import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/glossary/data/glossary_repository.dart';
import 'package:cauce_mobile/features/glossary/domain/glossary_catalog.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';

/// Arma el repositorio sobre el cliente OpenAPI real, con la red sustituida.
({GlossaryRepository repository, CannedHttpAdapter adapter}) _harness(
  CannedResponse response,
) {
  final adapter = CannedHttpAdapter(response);
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(dio: dio, interceptors: const <Interceptor>[]);
  return (
    repository: GlossaryRepository(client.getGlossaryApi()),
    adapter: adapter,
  );
}

Map<String, dynamic> _term(String term, String definition, String category) =>
    <String, dynamic>{
      'term': term,
      'definition': definition,
      'category': category,
    };

void main() {
  group('GlossaryRepository · GET /glossary (HU0027)', () {
    test('pide el listado completo, sin parametros', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'terms': <Map<String, dynamic>>[],
          'contentStatus': 'draft-pending-clinical-review',
        }),
      );

      await h.repository.fetchCatalog();

      final request = h.adapter.lastRequest;
      expect(request.method, 'GET');
      expect(request.path, endsWith('/api/v1/glossary'));
      expect(request.queryParameters, isEmpty);
    });

    test('traduce los terminos y sus tres categorias', () async {
      final h = _harness(
        CannedResponse.ok(<String, dynamic>{
          'terms': <Map<String, dynamic>>[
            _term('FODMAP', 'Azucares fermentables.', 'Nutritional'),
            _term('SII', 'Sindrome de Intestino Irritable.', 'ClinicalIbs'),
            _term('HITL', 'Un nutricionista revisa.', 'System'),
          ],
          'contentStatus': 'draft-pending-clinical-review',
        }),
      );

      final catalog = await h.repository.fetchCatalog();

      expect(
        catalog.terms.map((e) => e.term),
        <String>['FODMAP', 'SII', 'HITL'],
      );
      expect(
        catalog.terms.map((e) => e.category),
        <GlossaryCategoryOption>[
          GlossaryCategoryOption.nutritional,
          GlossaryCategoryOption.clinicalIbs,
          GlossaryCategoryOption.system,
        ],
      );
    });

    test('el borrador del backend se lee como tal', () async {
      // Es el unico valor que manda hoy: una constante del backend.
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'terms': <Map<String, dynamic>>[],
          'contentStatus': 'draft-pending-clinical-review',
        }),
      );

      final catalog = await h.repository.fetchCatalog();

      expect(catalog.isDraft, isTrue);
    });

    test('otro estado no se toma por borrador', () async {
      // Si el backend llegara a declarar el contenido validado, la nota
      // informativa tiene que dejar de mostrarse sola.
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'terms': <Map<String, dynamic>>[],
          'contentStatus': 'clinically-validated',
        }),
      );

      final catalog = await h.repository.fetchCatalog();

      expect(catalog.isDraft, isFalse);
    });

    test('un termino sin nombre o sin definicion se descarta', () async {
      final h = _harness(
        CannedResponse.ok(<String, dynamic>{
          'terms': <Map<String, dynamic>>[
            _term('FODMAP', 'Azucares fermentables.', 'Nutritional'),
            <String, dynamic>{
              'definition': 'Sin nombre.',
              'category': 'System',
            },
            _term('Vacio', '   ', 'System'),
          ],
          'contentStatus': 'draft-pending-clinical-review',
        }),
      );

      final catalog = await h.repository.fetchCatalog();

      expect(catalog.terms.map((e) => e.term), <String>['FODMAP']);
    });

    test('un fallo del servidor llega tipado', () async {
      final h = _harness(CannedResponse.problem(statusCode: 500));

      await expectLater(
        h.repository.fetchCatalog(),
        throwsA(isA<CauceApiError>()),
      );
    });
  });
}
