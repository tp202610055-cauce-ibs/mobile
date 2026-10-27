import 'package:cauce_mobile/core/glossary/glossary_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_glossary_repository.dart';

List<String> _names(List<GlossaryEntry> entries) =>
    entries.map((entry) => entry.term).toList();

void main() {
  group('GlossaryCatalog · busqueda local', () {
    test('sin consulta devuelve el glosario entero', () {
      expect(demoGlossary.search('').length, demoGlossaryTerms.length);
      expect(demoGlossary.search('   ').length, demoGlossaryTerms.length);
    });

    test('encuentra por nombre, sin importar las mayusculas', () {
      // CP068 paso 3.
      expect(_names(demoGlossary.search('fodmap')), contains('FODMAP'));
    });

    test('ignora las tildes de los dos lados', () {
      // "distension" sin tilde encuentra "Distension abdominal", que es el
      // mismo caso con el que el backend verifico su `unaccent`.
      expect(
        _names(demoGlossary.search('distension')),
        <String>['Distensión abdominal'],
      );
      expect(
        _names(demoGlossary.search('DISTENSIÓN')),
        <String>['Distensión abdominal'],
      );
    });

    test('tambien busca dentro de la definicion', () {
      // "lactosa" aparece como termino y dentro de la definicion de
      // "Disacaridos".
      expect(
        _names(demoGlossary.search('lactosa')),
        containsAll(<String>['Disacáridos', 'Lactosa']),
      );
    });

    test('un termino inexistente no devuelve nada', () {
      expect(demoGlossary.search('disacaridasas'), isEmpty);
    });
  });

  group('GlossaryCatalog · terminos parecidos (HU0027 CA2)', () {
    test('CP069: "disacaridasas" sugiere "Disacaridos"', () {
      // El dato literal del caso de prueba. No aparece como subcadena en
      // ningun termino ni definicion, pero comparte "disacarid" con el nombre.
      expect(
        _names(demoGlossary.suggestionsFor('disacaridasas')),
        <String>['Disacáridos'],
      );
    });

    test('las tildes de la consulta no cambian la sugerencia', () {
      expect(
        _names(demoGlossary.suggestionsFor('Disacáridasas')),
        <String>['Disacáridos'],
      );
    });

    test('con menos de cinco caracteres no sugiere nada', () {
      // La consulta misma tiene que llegar a cinco caracteres: con cuatro no
      // hay prefijo de cinco que compartir con nadie.
      expect(demoGlossary.suggestionsFor('disx'), isEmpty);
    });

    test('compara contra el nombre, no contra la definicion', () {
      // "intestinal" aparece en definiciones, pero ningun nombre empieza
      // parecido.
      expect(demoGlossary.suggestionsFor('intestinalx'), isEmpty);
    });

    test('devuelve como maximo tres, en orden alfabetico', () {
      final crowded = GlossaryCatalog(
        isDraft: true,
        terms: <GlossaryEntry>[
          GlossaryEntry(term: 'Fase de reintroducción', definition: 'b'),
          GlossaryEntry(term: 'Fase de eliminación', definition: 'a'),
          GlossaryEntry(term: 'Fase de consolidación', definition: 'c'),
          GlossaryEntry(term: 'Fase de mantenimiento', definition: 'd'),
        ],
      );

      expect(
        _names(crowded.suggestionsFor('fase de x')),
        <String>[
          'Fase de consolidación',
          'Fase de eliminación',
          'Fase de mantenimiento',
        ],
      );
    });
  });

  group('GlossaryCatalog · terminos dentro de un texto (CP068 paso 7)', () {
    const text = 'Algunos alimentos tienen un contenido alto de FODMAP y '
        'podrian relacionarse con tus sintomas. Las clasificaciones FODMAP '
        'de esos alimentos y la lactosa importan.';

    test('marca la primera aparicion de cada termino, en orden', () {
      final matches = demoGlossary.termsIn(text);

      expect(matches.map((m) => m.entry.term), <String>['FODMAP', 'Lactosa']);
      final first = matches.first;
      expect(text.substring(first.start, first.end), 'FODMAP');
      expect(first.start, text.indexOf('FODMAP'));
      expect(text.substring(matches.last.start, matches.last.end), 'lactosa');
    });

    test('solo palabras completas: SII no se marca dentro de otra', () {
      expect(demoGlossary.termsIn('ASIIGNADO y SIIX'), isEmpty);
      expect(
        demoGlossary.termsIn('Tienes SII.').single.entry.term,
        'SII',
      );
    });

    test('prefiere el termino mas largo cuando se superponen', () {
      final catalog = GlossaryCatalog(
        isDraft: false,
        terms: <GlossaryEntry>[
          GlossaryEntry(term: 'Distensión', definition: 'a'),
          GlossaryEntry(term: 'Distensión abdominal', definition: 'b'),
        ],
      );

      final matches = catalog.termsIn('Hubo distensión abdominal hoy.');

      expect(matches.single.entry.term, 'Distensión abdominal');
    });

    test('sin terminos en el texto no marca nada', () {
      expect(demoGlossary.termsIn('Toma agua tibia.'), isEmpty);
      expect(demoGlossary.termsIn(''), isEmpty);
    });
  });
}
