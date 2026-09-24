import 'package:cauce_mobile/features/glossary/domain/glossary_catalog.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_glossary_repository.dart';

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
}
