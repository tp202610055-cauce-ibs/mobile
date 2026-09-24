import 'package:cauce_api_client/cauce_api_client.dart' as api;

import '../../../core/utils/text_normalizer.dart';

/// Categoria de un termino del glosario (HU0027 CA1, CP068 paso 6).
///
/// Enum propio y no `api.GlossaryCategory` por el mismo criterio que el resto
/// del dominio: el generado es `built_value` y esta atado al ciclo de
/// regeneracion del cliente OpenAPI.
enum GlossaryCategoryOption {
  nutritional,
  clinicalIbs,
  system;

  static GlossaryCategoryOption? fromApi(api.GlossaryCategory? value) {
    return switch (value) {
      api.GlossaryCategory.nutritional => GlossaryCategoryOption.nutritional,
      api.GlossaryCategory.clinicalIbs => GlossaryCategoryOption.clinicalIbs,
      api.GlossaryCategory.system => GlossaryCategoryOption.system,
      _ => null,
    };
  }
}

/// Un termino del glosario, con la definicion que corresponde al paciente.
///
/// El backend elige la definicion segun el rol del JWT, asi que aca llega una
/// sola: la redactada para el paciente. No hay otra que considerar.
///
/// **Las formas normalizadas se calculan una vez**, al construir el termino, y
/// no en cada tecla. Es lo que pide el propio `TextNormalizer`: normalizar el
/// catalogo entero por pulsacion es trabajo que se repite sin necesidad.
class GlossaryEntry {
  GlossaryEntry({
    required this.term,
    required this.definition,
    this.category,
  })  : normalizedTerm = TextNormalizer.normalize(term),
        normalizedDefinition = TextNormalizer.normalize(definition);

  final String term;
  final String definition;

  /// `null` si el servidor la mandara vacia. El termino se muestra igual,
  /// solo que sin etiqueta: perder la definicion por una etiqueta seria peor.
  final GlossaryCategoryOption? category;

  final String normalizedTerm;
  final String normalizedDefinition;
}

/// Glosario completo, con su busqueda local (HU0027).
///
/// **La busqueda es 100 % del cliente**, sobre los 30 terminos ya en memoria.
/// `GET /glossary/search` no se usa: el backend busca por subcadena exacta sin
/// ninguna logica de terminos similares, y resolverlo aca deja las dos cosas,
/// la coincidencia y la sugerencia, sobre los mismos datos y sin red.
class GlossaryCatalog {
  const GlossaryCatalog({required this.terms, required this.isDraft});

  /// Valor unico que el backend manda hoy en `contentStatus`.
  ///
  /// Es una constante en `GlossaryMappings.DraftContentStatus`: todo el
  /// contenido es un borrador pendiente de validacion clinica con el
  /// nutricionista del Kaelin (acta A27 del backend). No hay otro valor.
  static const String draftContentStatus = 'draft-pending-clinical-review';

  /// Largo minimo del prefijo compartido para sugerir un termino (CA2).
  static const int suggestionPrefixLength = 5;

  /// Tope de sugerencias que se ofrecen.
  static const int maxSuggestions = 3;

  /// Terminos en el orden en que llegan: el backend ya los ordena
  /// alfabeticamente.
  final List<GlossaryEntry> terms;

  /// `true` mientras el servidor declare el contenido como borrador.
  ///
  /// Gobierna la nota informativa de la pantalla. Atarla al dato y no dejarla
  /// fija hace que se retire sola el dia que el backend declare el contenido
  /// validado, en vez de seguir afirmando algo que dejo de ser cierto.
  final bool isDraft;

  /// Terminos cuyo nombre o definicion contienen [query].
  ///
  /// Insensible a tildes y a mayusculas por `TextNormalizer`. Con la consulta
  /// vacia devuelve el glosario entero.
  List<GlossaryEntry> search(String query) {
    final needle = TextNormalizer.normalize(query);
    if (needle.isEmpty) {
      return terms;
    }
    return terms
        .where(
          (entry) =>
              entry.normalizedTerm.contains(needle) ||
              entry.normalizedDefinition.contains(needle),
        )
        .toList();
  }

  /// Hasta [maxSuggestions] terminos parecidos a [query], para cuando la
  /// busqueda no encuentra nada (HU0027 CA2, CP069 paso 4).
  ///
  /// Un termino se sugiere si su **nombre** normalizado comparte con la
  /// consulta normalizada un prefijo de al menos [suggestionPrefixLength]
  /// caracteres. Es aritmetica de cadenas sobre lo que ya esta en memoria, sin
  /// libreria de distancia de edicion.
  ///
  /// El caso que lo justifica es el dato de CP069: "disacaridasas" no aparece
  /// en ningun termino ni definicion, pero comparte "disacarid" con
  /// "Disacaridos", que es la sugerencia obvia.
  List<GlossaryEntry> suggestionsFor(String query) {
    final needle = TextNormalizer.normalize(query);
    if (needle.length < suggestionPrefixLength) {
      return const <GlossaryEntry>[];
    }

    final matches = terms
        .where(
          (entry) =>
              _commonPrefixLength(entry.normalizedTerm, needle) >=
              suggestionPrefixLength,
        )
        .toList()
      ..sort((a, b) => a.normalizedTerm.compareTo(b.normalizedTerm));

    return matches.take(maxSuggestions).toList();
  }

  static int _commonPrefixLength(String a, String b) {
    final limit = a.length < b.length ? a.length : b.length;
    var index = 0;
    while (index < limit && a.codeUnitAt(index) == b.codeUnitAt(index)) {
      index++;
    }
    return index;
  }
}
