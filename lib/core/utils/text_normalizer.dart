/// Normalizacion de texto para las busquedas locales.
///
/// El catalogo de alimentos se busca **siempre** contra la copia en
/// `food_catalog_cache` y nunca contra `GET /foods/search`, porque CP023 exige
/// registrar una comida en modo avion. Eso deja la comparacion del lado del
/// cliente, y con ella el problema de las tildes.
///
/// El backend tampoco lo resuelve: `SearchByNameAsync` usa `ILike` sin
/// `unaccent`, aunque la extension esta instalada y el glosario si la usa. O
/// sea que ni siquiera con conexion escribir "platano" encontraria "Platano de
/// la isla maduro". En un teclado movil en español ese caso es frecuente.
///
/// Dart no trae plegado de diacriticos: `String.toLowerCase()` respeta las
/// tildes. De ahi la tabla de reemplazo.
abstract final class TextNormalizer {
  /// Diacriticos del español, mas la dieresis y la eñe.
  ///
  /// La eñe se pliega a `n` a proposito. Es discutible desde la ortografia,
  /// donde es una letra propia, pero aca el objetivo es que el paciente
  /// encuentre lo que busca: quien escribe "castana" espera dar con "castaña".
  static const Map<String, String> _folding = <String, String>{
    'á': 'a',
    'à': 'a',
    'ä': 'a',
    'â': 'a',
    'ã': 'a',
    'é': 'e',
    'è': 'e',
    'ë': 'e',
    'ê': 'e',
    'í': 'i',
    'ì': 'i',
    'ï': 'i',
    'î': 'i',
    'ó': 'o',
    'ò': 'o',
    'ö': 'o',
    'ô': 'o',
    'õ': 'o',
    'ú': 'u',
    'ù': 'u',
    'ü': 'u',
    'û': 'u',
    'ñ': 'n',
    'ç': 'c',
  };

  /// Devuelve [value] en minusculas, sin diacriticos y con los espacios
  /// colapsados.
  ///
  /// Se aplica a los **dos** lados de la comparacion: a lo que el paciente
  /// escribe y, al momento de escribir cada fila, a la columna
  /// `nameNormalized` de la caja. Normalizar el catalogo entero en cada tecla
  /// seria recorrer 928 filas por pulsacion cuando llegue TPCA-CENAN.
  static String normalize(String value) {
    final lowered = value.toLowerCase();
    final buffer = StringBuffer();
    for (final rune in lowered.runes) {
      final character = String.fromCharCode(rune);
      buffer.write(_folding[character] ?? character);
    }
    return buffer.toString().trim().replaceAll(RegExp(r'\s+'), ' ');
  }
}
