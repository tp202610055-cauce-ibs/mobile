import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/glossary/data/glossary_repository.dart';
import 'package:cauce_mobile/features/glossary/domain/glossary_catalog.dart';

/// Terminos de referencia, copiados del `GlossaryTermsSeeder` del backend con
/// su definicion para el paciente.
///
/// Son reales y no inventados a proposito: el caso de CP069 ("disacaridasas"
/// sugiere "Disacaridos") solo prueba algo si los nombres son los que el
/// servidor manda de verdad. Van en el orden alfabetico en que llegan.
final List<GlossaryEntry> demoGlossaryTerms = <GlossaryEntry>[
  GlossaryEntry(
    term: 'Disacáridos',
    definition: 'Un tipo de FODMAP; el más común es la lactosa de la leche.',
    category: GlossaryCategoryOption.nutritional,
  ),
  GlossaryEntry(
    term: 'Distensión abdominal',
    definition: 'Sensación de hinchazón o de tener la barriga llena e inflada.',
    category: GlossaryCategoryOption.clinicalIbs,
  ),
  GlossaryEntry(
    term: 'FODMAP',
    definition: 'Son ciertos azúcares y fibras de algunos alimentos que el '
        'intestino fermenta y pueden causar gases, hinchazón y molestias en '
        'personas con SII.',
    category: GlossaryCategoryOption.nutritional,
  ),
  GlossaryEntry(
    term: 'HITL',
    definition: 'Significa que un nutricionista de verdad revisa y aprueba '
        'cada recomendación antes de que la veas.',
    category: GlossaryCategoryOption.system,
  ),
  GlossaryEntry(
    term: 'Lactosa',
    definition: 'El azúcar de la leche y sus derivados. Algunas personas no '
        'la digieren bien.',
    category: GlossaryCategoryOption.nutritional,
  ),
  GlossaryEntry(
    term: 'SII',
    definition: 'Síndrome de Intestino Irritable: una condición del sistema '
        'digestivo que causa dolor de barriga, hinchazón y cambios en la '
        'forma de ir al baño, sin que haya un daño visible en el intestino.',
    category: GlossaryCategoryOption.clinicalIbs,
  ),
];

/// Glosario de referencia, en borrador como el que manda hoy el backend.
final GlossaryCatalog demoGlossary = GlossaryCatalog(
  terms: demoGlossaryTerms,
  isDraft: true,
);

/// [GlossaryRepository] controlable para los tests.
class FakeGlossaryRepository implements GlossaryRepository {
  FakeGlossaryRepository({GlossaryCatalog? catalog, this.delay = Duration.zero})
      : catalog = catalog ?? demoGlossary;

  GlossaryCatalog catalog;
  CauceApiError? error;
  Duration delay;
  int fetchCalls = 0;

  @override
  Future<GlossaryCatalog> fetchCatalog() async {
    fetchCalls++;
    if (delay != Duration.zero) {
      await Future<void>.delayed(delay);
    }
    final pending = error;
    if (pending != null) {
      throw pending;
    }
    return catalog;
  }
}
