import 'package:cauce_mobile/core/utils/text_normalizer.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TextNormalizer', () {
    test('pliega las cinco vocales acentuadas', () {
      expect(TextNormalizer.normalize('áéíóú'), 'aeiou');
      expect(TextNormalizer.normalize('ÁÉÍÓÚ'), 'aeiou');
    });

    test('pliega dieresis, eñe y cedilla', () {
      expect(TextNormalizer.normalize('pingüino'), 'pinguino');
      expect(TextNormalizer.normalize('castaña'), 'castana');
      expect(TextNormalizer.normalize('CASTAÑA'), 'castana');
    });

    test('baja a minusculas', () {
      expect(TextNormalizer.normalize('Lomo Saltado'), 'lomo saltado');
    });

    test('colapsa espacios y recorta los extremos', () {
      expect(TextNormalizer.normalize('  pan   de   trigo  '), 'pan de trigo');
    });

    test('deja intacto lo que ya esta normalizado', () {
      expect(
        TextNormalizer.normalize('arroz blanco cocido'),
        'arroz blanco cocido',
      );
    });

    test('es idempotente', () {
      const original = 'Plátano   de la Isla MADURO';
      final once = TextNormalizer.normalize(original);

      expect(TextNormalizer.normalize(once), once);
    });

    test('la cadena vacia queda vacia', () {
      expect(TextNormalizer.normalize(''), '');
      expect(TextNormalizer.normalize('   '), '');
    });

    test('el caso que motiva todo esto', () {
      // El backend busca con `ILike` sin `unaccent`, asi que ni con conexion
      // "platano" encontraria "Platano de la isla maduro". Al normalizar los
      // dos lados, la busqueda local si lo encuentra.
      expect(
        TextNormalizer.normalize('Plátano de la isla maduro'),
        contains(TextNormalizer.normalize('platano')),
      );
    });
  });
}
