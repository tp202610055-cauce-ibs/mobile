import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/custom_foods/application/custom_food_form_notifier.dart';
import 'package:cauce_mobile/features/custom_foods/data/custom_foods_repository.dart';
import 'package:cauce_mobile/features/custom_foods/domain/custom_food.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockCustomFoodsRepository extends Mock
    implements CustomFoodsRepository {}

class _FakeDraft extends Fake implements CustomFoodDraft {}

const FoodNutrition _nutrition = FoodNutrition(
  caloriesPer100g: 130,
  proteinGPer100g: 2.7,
  carbsGPer100g: 28.2,
  fatGPer100g: 0.3,
  fiberGPer100g: 0.4,
);

const FoodItem _arroz = FoodItem(
  foodId: 'f1',
  name: 'Arroz blanco cocido',
  category: 'cereales',
  isPeruvian: true,
  fodmapLevel: FodmapLoad.low,
  nutrition: _nutrition,
);

const FoodItem _leche = FoodItem(
  foodId: 'f2',
  name: 'Leche entera de vaca',
  category: 'lacteos',
  isPeruvian: false,
  fodmapLevel: FodmapLoad.high,
  nutrition: _nutrition,
);

void main() {
  setUpAll(() => registerFallbackValue(_FakeDraft()));

  late _MockCustomFoodsRepository repository;
  late ProviderContainer container;

  setUp(() {
    repository = _MockCustomFoodsRepository();
    container = ProviderContainer(
      overrides: <Override>[
        customFoodsRepositoryProvider.overrideWithValue(repository),
      ],
    );
    when(repository.list).thenAnswer((_) async => const <CustomFoodRecord>[]);
  });

  tearDown(() => container.dispose());

  CustomFoodFormNotifier notifier() =>
      container.read(customFoodFormNotifierProvider.notifier);
  CustomFoodFormState state() => container.read(customFoodFormNotifierProvider);

  void fillValidDraft() {
    notifier()
      ..setName('Mi lomo saltado')
      ..setPortion(300)
      ..addIngredient(
        const CustomFoodIngredientDraft(food: _arroz, proportionGrams: 200),
      );
  }

  void stubCreate(String id) {
    when(
      () => repository.create(
        any(),
        confirmedAllergens: any(named: 'confirmedAllergens'),
      ),
    ).thenAnswer((_) async => id);
  }

  group('CustomFoodFormNotifier · validacion previa', () {
    test('arranca sin poder enviar', () {
      expect(state().canSubmit, isFalse);
      expect(state().issues, contains(CustomFoodIssue.invalidName));
      expect(state().issues, contains(CustomFoodIssue.invalidPortion));
      expect(state().issues, contains(CustomFoodIssue.noIngredients));
    });

    test('un nombre de mas de 150 caracteres lo bloquea', () {
      notifier()
        ..setName('a' * 151)
        ..setPortion(300)
        ..addIngredient(
          const CustomFoodIngredientDraft(food: _arroz, proportionGrams: 200),
        );

      expect(state().issues, contains(CustomFoodIssue.invalidName));
    });

    test('con nombre, porcion e ingrediente se puede enviar', () {
      fillValidDraft();

      expect(state().canSubmit, isTrue);
      expect(state().issues, isEmpty);
    });
  });

  group('CustomFoodFormNotifier · nombre duplicado (CA02, CP026)', () {
    test('rechaza al instante contra la lista ya cargada', () async {
      when(repository.list).thenAnswer(
        (_) async => const <CustomFoodRecord>[
          CustomFoodRecord(
            customFoodId: 'c1',
            name: 'Mi lomo saltado',
            portionSizeGrams: 300,
          ),
        ],
      );
      await notifier().loadExisting();

      fillValidDraft();

      expect(state().issues, contains(CustomFoodIssue.duplicateName));
      expect(state().canSubmit, isFalse);
    });

    test('la comparacion no distingue mayusculas ni espacios', () async {
      when(repository.list).thenAnswer(
        (_) async => const <CustomFoodRecord>[
          CustomFoodRecord(
            customFoodId: 'c1',
            name: 'Mi Lomo Saltado',
            portionSizeGrams: 300,
          ),
        ],
      );
      await notifier().loadExisting();

      notifier()
        ..setName('  mi lomo saltado  ')
        ..setPortion(300)
        ..addIngredient(
          const CustomFoodIngredientDraft(food: _arroz, proportionGrams: 200),
        );

      expect(state().issues, contains(CustomFoodIssue.duplicateName));
    });

    test('un fallo al cargar la lista no bloquea el formulario', () async {
      // Se pierde el rechazo instantaneo, pero el 409 del servidor sigue siendo
      // la autoridad final.
      when(repository.list).thenThrow(const CauceApiError.network());

      await notifier().loadExisting();
      fillValidDraft();

      expect(state().canSubmit, isTrue);
    });

    test('el servidor sigue siendo la autoridad', () async {
      when(
        () => repository.create(
          any(),
          confirmedAllergens: any(named: 'confirmedAllergens'),
        ),
      ).thenThrow(const CauceApiError.duplicateCustomFood());
      fillValidDraft();

      expect(await notifier().submit(), isFalse);
      expect(state().error, isA<DuplicateCustomFoodError>());
    });
  });

  group('CustomFoodFormNotifier · alergenos (CA03, CP027)', () {
    const List<DetectedAllergen> detected = <DetectedAllergen>[
      DetectedAllergen(
        ingredientName: 'Leche entera de vaca',
        allergenName: 'Lactosa',
        severity: DetectedAllergenSeverity.severe,
      ),
    ];

    test('el primer envio va con confirmedAllergens en false', () async {
      stubCreate('c1');
      fillValidDraft();

      await notifier().submit();

      verify(
        () => repository.create(any(), confirmedAllergens: false),
      ).called(1);
    });

    test('un 409 deja las coincidencias esperando confirmacion', () async {
      when(
        () => repository.create(any(), confirmedAllergens: false),
      ).thenThrow(
        const CauceApiError.unconfirmedAllergens(allergens: detected),
      );
      fillValidDraft();

      expect(await notifier().submit(), isFalse);

      expect(state().awaitingAllergenConfirmation, isTrue);
      expect(state().pendingAllergens, detected);
      // No es un error terminal: es el paso intermedio del flujo.
      expect(state().error, isNull);
      expect(state().createdId, isNull);
    });

    test('confirmar reenvia con confirmedAllergens en true', () async {
      when(
        () => repository.create(any(), confirmedAllergens: false),
      ).thenThrow(
        const CauceApiError.unconfirmedAllergens(allergens: detected),
      );
      when(
        () => repository.create(any(), confirmedAllergens: true),
      ).thenAnswer((_) async => 'c1');
      fillValidDraft();
      await notifier().submit();

      expect(await notifier().confirmAllergensAndSubmit(), isTrue);

      expect(state().createdId, 'c1');
      expect(state().awaitingAllergenConfirmation, isFalse);
      verify(() => repository.create(any(), confirmedAllergens: true))
          .called(1);
    });

    test('sin advertencia pendiente, confirmar no hace nada', () async {
      stubCreate('c1');
      fillValidDraft();

      expect(await notifier().confirmAllergensAndSubmit(), isFalse);
      verifyNever(
        () => repository.create(any(), confirmedAllergens: true),
      );
    });

    test('cancelar vuelve al formulario con todo cargado', () async {
      // Sacar el ingrediente es la salida sin riesgo: perder el plato entero
      // castigaria al paciente por haber prestado atencion a la advertencia.
      when(
        () => repository.create(any(), confirmedAllergens: false),
      ).thenThrow(
        const CauceApiError.unconfirmedAllergens(allergens: detected),
      );
      fillValidDraft();
      await notifier().submit();

      notifier().cancelAllergenConfirmation();

      expect(state().awaitingAllergenConfirmation, isFalse);
      expect(state().draft.name, 'Mi lomo saltado');
      expect(state().draft.ingredients, hasLength(1));
    });

    test('cambiar los ingredientes invalida la advertencia anterior', () async {
      // El cruce hay que rehacerlo contra la composicion nueva: mantener la
      // advertencia vieja permitiria confirmar alergenos de un plato que ya no
      // existe.
      when(
        () => repository.create(any(), confirmedAllergens: false),
      ).thenThrow(
        const CauceApiError.unconfirmedAllergens(allergens: detected),
      );
      fillValidDraft();
      await notifier().submit();

      notifier().addIngredient(
        const CustomFoodIngredientDraft(food: _leche, proportionGrams: 50),
      );

      expect(state().awaitingAllergenConfirmation, isFalse);
    });
  });

  group('CustomFoodFormNotifier · perfil estimado (CA01, CP025)', () {
    test('se calcula sin llamadas nuevas al servidor', () async {
      // La composicion ya vino con el detalle que se resolvio al elegir cada
      // ingrediente, asi que armar el plato no pide nada mas.
      fillValidDraft();

      expect(state().estimate, isNotNull);
      expect(state().estimate!.caloriesPer100g, closeTo(130, 0.001));
      verifyNever(() => repository.create(any()));
    });

    test('sin ingredientes no hay estimacion', () {
      notifier().setName('Mi plato');

      expect(state().estimate, isNull);
    });

    test('la carga FODMAP del plato es el maximo de sus ingredientes', () {
      fillValidDraft();
      notifier().addIngredient(
        const CustomFoodIngredientDraft(food: _leche, proportionGrams: 100),
      );

      expect(state().estimate!.fodmapLevel, FodmapLoad.high);
    });
  });

  group('CustomFoodFormNotifier · ingredientes', () {
    test('agregar el mismo alimento suma la proporcion', () {
      // `CustomFood.AddIngredient` rechaza el duplicado con 409; para el
      // paciente, agregarlo dos veces significa que quiere mas cantidad.
      fillValidDraft();
      notifier().addIngredient(
        const CustomFoodIngredientDraft(food: _arroz, proportionGrams: 100),
      );

      expect(state().draft.ingredients, hasLength(1));
      expect(state().draft.ingredients.single.proportionGrams, 300);
      expect(
        state().issues,
        isNot(contains(CustomFoodIssue.duplicateIngredient)),
      );
    });

    test('quitar uno conserva el nombre y la porcion', () {
      fillValidDraft();

      notifier().removeIngredientAt(0);

      expect(state().draft.name, 'Mi lomo saltado');
      expect(state().draft.portionSizeGrams, 300);
      expect(state().issues, contains(CustomFoodIssue.noIngredients));
    });

    test('la diferencia de peso se informa pero no bloquea', () {
      fillValidDraft();

      // 200 g de ingredientes contra 300 g de porcion declarada.
      expect(state().draft.weightDelta, -100);
      expect(state().canSubmit, isTrue);
    });
  });
}
