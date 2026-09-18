import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:flutter_test/flutter_test.dart';

const FoodItem _arroz = FoodItem(
  foodId: 'f1',
  name: 'Arroz blanco cocido',
  category: 'cereales',
  isPeruvian: true,
);

MealItemDraft _item({
  double quantity = 150,
  FoodItem? food = _arroz,
  String? customFoodId,
}) {
  return MealItemDraft(
    quantity: quantity,
    unit: MeasurementUnitOption.grams,
    food: food,
    customFoodId: customFoodId,
  );
}

void main() {
  group('MealItemDraft · invariante XOR', () {
    test('un alimento del catalogo es valido', () {
      expect(_item().referencesExactlyOne, isTrue);
    });

    test('un plato personalizado es valido', () {
      expect(
        _item(food: null, customFoodId: 'c1').referencesExactlyOne,
        isTrue,
      );
    });

    test('los dos a la vez no', () {
      // `Meal.Register` lo exige como XOR: cada item referencia exactamente uno.
      expect(_item(customFoodId: 'c1').referencesExactlyOne, isFalse);
    });

    test('ninguno de los dos tampoco', () {
      expect(_item(food: null).referencesExactlyOne, isFalse);
    });
  });

  group('MealDraft · CA04, bloqueo del envio (CP076)', () {
    test('sin momento del dia no se puede enviar', () {
      final draft = MealDraft(items: <MealItemDraft>[_item()]);

      expect(draft.canSubmit(), isFalse);
      expect(draft.issues(), contains(MealDraftIssue.missingMealTime));
    });

    test('sin alimentos no se puede enviar', () {
      const draft = MealDraft(mealTime: MealTimeOption.lunch);

      expect(draft.canSubmit(), isFalse);
      expect(draft.issues(), contains(MealDraftIssue.noItems));
    });

    test('una cantidad en cero bloquea el envio', () {
      final draft = MealDraft(
        mealTime: MealTimeOption.lunch,
        items: <MealItemDraft>[_item(quantity: 0)],
      );

      expect(draft.canSubmit(), isFalse);
      expect(draft.issues(), contains(MealDraftIssue.invalidQuantity));
    });

    test('una cantidad negativa tambien', () {
      final draft = MealDraft(
        mealTime: MealTimeOption.lunch,
        items: <MealItemDraft>[_item(quantity: -5)],
      );

      expect(draft.issues(), contains(MealDraftIssue.invalidQuantity));
    });

    test('mas de 50 alimentos excede el tope del backend', () {
      final draft = MealDraft(
        mealTime: MealTimeOption.lunch,
        items: <MealItemDraft>[for (var i = 0; i < 51; i++) _item()],
      );

      expect(draft.issues(), contains(MealDraftIssue.tooManyItems));
    });

    test('exactamente 50 alimentos si entra', () {
      final draft = MealDraft(
        mealTime: MealTimeOption.lunch,
        items: <MealItemDraft>[for (var i = 0; i < 50; i++) _item()],
      );

      expect(draft.canSubmit(), isTrue);
    });

    test('devuelve todos los motivos, no solo el primero', () {
      // Corregir de a uno obligaria al paciente a reintentar el envio una vez
      // por problema.
      final draft = MealDraft(items: <MealItemDraft>[_item(quantity: 0)]);

      expect(
        draft.issues(),
        containsAll(<MealDraftIssue>[
          MealDraftIssue.missingMealTime,
          MealDraftIssue.invalidQuantity,
        ]),
      );
    });

    test('con momento del dia y un alimento valido se puede enviar', () {
      final draft = MealDraft(
        mealTime: MealTimeOption.lunch,
        items: <MealItemDraft>[_item()],
      );

      expect(draft.canSubmit(), isTrue);
      expect(draft.issues(), isEmpty);
    });
  });

  group('MealDraft · fecha de consumo', () {
    final now = DateTime.utc(2026, 9, 18, 13);

    test('una fecha pasada es valida', () {
      final draft = MealDraft(
        mealTime: MealTimeOption.lunch,
        consumedAt: now.subtract(const Duration(hours: 2)),
        items: <MealItemDraft>[_item()],
      );

      expect(draft.canSubmit(now: now), isTrue);
    });

    test('una fecha futura la bloquea', () {
      final draft = MealDraft(
        mealTime: MealTimeOption.lunch,
        consumedAt: now.add(const Duration(hours: 2)),
        items: <MealItemDraft>[_item()],
      );

      expect(draft.issues(now: now), contains(MealDraftIssue.futureConsumedAt));
    });

    test('tolera los 5 minutos de desfase que acepta el backend', () {
      // `Meal.Register` usa `ClockSkewToleranceMinutes = 5`. Sin replicarlo, un
      // dispositivo levemente adelantado quedaria bloqueado por algo que el
      // servidor si acepta.
      final draft = MealDraft(
        mealTime: MealTimeOption.lunch,
        consumedAt: now.add(const Duration(minutes: 4)),
        items: <MealItemDraft>[_item()],
      );

      expect(draft.canSubmit(now: now), isTrue);
    });

    test('pasados los 5 minutos ya no', () {
      final draft = MealDraft(
        mealTime: MealTimeOption.lunch,
        consumedAt: now.add(const Duration(minutes: 6)),
        items: <MealItemDraft>[_item()],
      );

      expect(draft.issues(now: now), contains(MealDraftIssue.futureConsumedAt));
    });
  });

  group('MealDraft · manipulacion de items', () {
    test('agregar conserva los anteriores', () {
      final draft = const MealDraft().withItem(_item()).withItem(_item());

      expect(draft.items, hasLength(2));
    });

    test('quitar uno deja el resto del formulario intacto (CA04)', () {
      final draft = MealDraft(
        mealTime: MealTimeOption.dinner,
        items: <MealItemDraft>[_item(), _item(quantity: 200)],
      ).withoutItemAt(0);

      expect(draft.items, hasLength(1));
      expect(draft.items.single.quantity, 200);
      // El momento del dia sigue elegido: quitar un alimento no vacia el
      // formulario entero.
      expect(draft.mealTime, MealTimeOption.dinner);
    });

    test('quitar una posicion inexistente no rompe', () {
      final draft = MealDraft(items: <MealItemDraft>[_item()]);

      expect(draft.withoutItemAt(7).items, hasLength(1));
      expect(draft.withoutItemAt(-1).items, hasLength(1));
    });
  });

  group('Enums del registro · valores de contrato', () {
    test('MealTime va y vuelve por su valor de contrato', () {
      for (final option in MealTimeOption.values) {
        expect(MealTimeOption.fromWire(option.wireValue), option);
      }
    });

    test('MeasurementUnit va y vuelve por su valor de contrato', () {
      for (final option in MeasurementUnitOption.values) {
        expect(MeasurementUnitOption.fromWire(option.wireValue), option);
      }
    });

    test('los valores de contrato son PascalCase', () {
      // Es la forma que el backend serializa y la que se guarda en drift. Un
      // desliz a camelCase rompería la deserializacion del objeto entero.
      expect(MealTimeOption.breakfast.wireValue, 'Breakfast');
      expect(MeasurementUnitOption.tablespoons.wireValue, 'Tablespoons');
    });

    test('un valor desconocido devuelve null y no revienta', () {
      expect(MealTimeOption.fromWire('Brunch'), isNull);
      expect(MeasurementUnitOption.fromWire(null), isNull);
    });
  });
}
