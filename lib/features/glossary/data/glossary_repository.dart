import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/network/api_guard.dart';
import '../../../core/network/dio_provider.dart';
import '../domain/glossary_catalog.dart';

part 'glossary_repository.g.dart';

/// Acceso al glosario clinico-nutricional (HU0027).
///
/// Misma frontera que el resto de los repositorios: hacia adentro habla
/// `built_value` y `DioException`; hacia afuera solo tipos del dominio y
/// `CauceApiError`.
class GlossaryRepository {
  const GlossaryRepository(this._api);

  final GlossaryApi _api;

  /// `GET /api/v1/glossary`. Sin parametros ni paginacion: son 30 terminos.
  ///
  /// Un termino sin nombre o sin definicion se descarta en vez de tumbar el
  /// glosario entero. El contrato no marca ningun campo como `required`, asi
  /// que el generado los expone todos como nullable.
  Future<GlossaryCatalog> fetchCatalog() {
    return guardApiCall(() async {
      final response = await _api.apiV1GlossaryGet();
      final result = response.data;

      final terms = result?.terms
              ?.map((dto) {
                final term = dto.term;
                final definition = dto.definition;
                if (term == null ||
                    term.trim().isEmpty ||
                    definition == null ||
                    definition.trim().isEmpty) {
                  return null;
                }
                return GlossaryEntry(
                  term: term,
                  definition: definition,
                  category: GlossaryCategoryOption.fromApi(dto.category),
                );
              })
              .nonNulls
              .toList() ??
          const <GlossaryEntry>[];

      return GlossaryCatalog(
        terms: terms,
        isDraft: result?.contentStatus == GlossaryCatalog.draftContentStatus,
      );
    });
  }
}

@Riverpod(keepAlive: true)
GlossaryRepository glossaryRepository(Ref ref) =>
    GlossaryRepository(ref.watch(glossaryApiProvider));

/// Glosario completo, pedido una vez y cacheado en memoria.
///
/// `keepAlive` porque el contenido no cambia durante la sesion y volver a
/// pedirlo cada vez que se abre la pantalla costaria una peticion sin ganar
/// nada. El reintento, ante un fallo, pasa por `ref.invalidate`.
@Riverpod(keepAlive: true)
Future<GlossaryCatalog> glossaryCatalog(Ref ref) {
  return ref.watch(glossaryRepositoryProvider).fetchCatalog();
}
