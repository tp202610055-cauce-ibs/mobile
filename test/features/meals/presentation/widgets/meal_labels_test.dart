import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:cauce_mobile/features/meals/presentation/widgets/meal_labels.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_en.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter_test/flutter_test.dart';

/// Cantidad de un alimento en la lista del formulario (acta M49).
///
/// La lista armaba el texto a mano con la etiqueta de la opcion y la cantidad
/// redondeada: "100 Gramos", y media taza como "1 Tazas". Lo encontro el
/// recorrido en el celular.
void main() {
  final AppLocalizations es = AppLocalizationsEs();
  final AppLocalizations en = AppLocalizationsEn();

  group('MealLabels.quantity', () {
    test('sin decimales cuando no hacen falta', () {
      expect(MealLabels.quantity(100), '100');
      expect(MealLabels.quantity(1), '1');
    });

    test('conserva los decimales que el paciente escribio', () {
      // Antes `toStringAsFixed(0)` convertia 0.5 en "1".
      expect(MealLabels.quantity(0.5), '0.5');
      expect(MealLabels.quantity(1.25), '1.25');
    });
  });

  group('MealLabels.amount', () {
    test('en minuscula y con la unidad en singular o plural', () {
      expect(
        MealLabels.amount(es, 100, MeasurementUnitOption.grams),
        '100 gramos',
      );
      expect(MealLabels.amount(es, 1, MeasurementUnitOption.cups), '1 taza');
      expect(
        MealLabels.amount(es, 0.5, MeasurementUnitOption.cups),
        '0.5 tazas',
      );
      expect(MealLabels.amount(es, 1, MeasurementUnitOption.units), '1 unidad');
      expect(
        MealLabels.amount(es, 3, MeasurementUnitOption.units),
        '3 unidades',
      );
      expect(
        MealLabels.amount(es, 4, MeasurementUnitOption.ounces),
        '4 onzas',
      );
      expect(
        MealLabels.amount(es, 2, MeasurementUnitOption.tablespoons),
        '2 cucharadas',
      );
    });

    test('cada unidad tiene su frase, en los dos idiomas', () {
      for (final unit in MeasurementUnitOption.values) {
        for (final l10n in <AppLocalizations>[es, en]) {
          final text = MealLabels.amount(l10n, 2, unit);
          expect(text, startsWith('2 '), reason: '$unit');
          expect(text, text.toLowerCase(), reason: '$unit en minuscula');
        }
      }
      expect(MealLabels.amount(en, 1, MeasurementUnitOption.cups), '1 cup');
    });
  });
}
