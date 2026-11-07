import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/custom_foods/data/custom_foods_repository.dart';
import 'package:cauce_mobile/features/custom_foods/domain/custom_food.dart';
import 'package:cauce_mobile/features/custom_foods/presentation/custom_food_form_screen.dart';
import 'package:cauce_mobile/features/foods/data/food_catalog_store.dart';
import 'package:cauce_mobile/features/foods/data/foods_repository.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/sync_fixtures.dart';

/// CP025, CP026 y CP027 en el formulario del plato personalizado.
final AppLocalizations l10n = AppLocalizationsEs();

const FoodItem _carne = FoodItem(
  foodId: 'f-carne',
  name: 'Carne de res magra',
  category: 'carnes',
  isPeruvian: false,
);
const FoodItem _cebolla = FoodItem(
  foodId: 'f-cebolla',
  name: 'Cebolla cocida',
  category: 'verduras',
  isPeruvian: false,
);
const FoodItem _zanahoria = FoodItem(
  foodId: 'f-zanahoria',
  name: 'Zanahoria cocida',
  category: 'verduras',
  isPeruvian: false,
);
const FoodItem _arroz = FoodItem(
  foodId: 'f-arroz',
  name: 'Arroz blanco cocido',
  category: 'cereales',
  isPeruvian: false,
);
const FoodItem _queso = FoodItem(
  foodId: 'f-queso',
  name: 'Queso fresco',
  category: 'lacteos',
  isPeruvian: false,
);

/// Platos del paciente y servidor que pide confirmar el alérgeno declarado.
class _Dishes implements CustomFoodsRepository {
  _Dishes({this.existing = const <CustomFoodRecord>[]});

  final List<CustomFoodRecord> existing;
  final List<({CustomFoodDraft draft, bool confirmed})> created =
      <({CustomFoodDraft draft, bool confirmed})>[];

  @override
  Future<List<CustomFoodRecord>> list() async => existing;

  @override
  Future<List<String>> allergenConflicts(String foodId) async =>
      foodId == _queso.foodId ? const <String>['Lactosa'] : const <String>[];

  @override
  Future<String> create(
    CustomFoodDraft draft, {
    bool confirmedAllergens = false,
  }) async {
    final hasCheese =
        draft.ingredients.any((item) => item.foodId == _queso.foodId);
    if (hasCheese && !confirmedAllergens) {
      throw const CauceApiError.unconfirmedAllergens(
        allergens: <DetectedAllergen>[
          DetectedAllergen(
            ingredientName: 'Queso fresco',
            allergenName: 'Lactosa',
          ),
        ],
      );
    }
    created.add((draft: draft, confirmed: confirmedAllergens));
    return 'dish-${created.length}';
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Sin sugerencias; el detalle trae la composición, como el servidor.
class _CatalogFoods implements FoodsRepository {
  static const FoodNutrition _nutrition = FoodNutrition(
    caloriesPer100g: 120,
    proteinGPer100g: 10,
    carbsGPer100g: 8,
    fatGPer100g: 4,
    fiberGPer100g: 2,
  );

  @override
  Future<FoodItem> fetchDetail(String foodId) async {
    final food = <FoodItem>[_carne, _cebolla, _zanahoria, _arroz, _queso]
        .firstWhere((item) => item.foodId == foodId);
    return food.copyWith(nutrition: _nutrition);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => throw StateError('sin red');
}

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.memory();
    await FoodCatalogStore(database)
        .replaceAll(<FoodItem>[_carne, _cebolla, _zanahoria, _arroz, _queso]);
  });
  tearDown(() => database.close());

  Future<void> pumpForm(WidgetTester tester, _Dishes dishes) async {
    final container = ProviderContainer(
      overrides: <Override>[
        appDatabaseProvider.overrideWithValue(database),
        foodCatalogStoreProvider.overrideWithValue(FoodCatalogStore(database)),
        foodsRepositoryProvider.overrideWithValue(_CatalogFoods()),
        customFoodsRepositoryProvider.overrideWithValue(dishes),
        connectivityMonitorProvider
            .overrideWithValue(FakeConnectivityMonitor(online: false)),
      ],
    );
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: const <LocalizationsDelegate<Object>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('es'),
          home: const CustomFoodFormScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  Future<void> tap(WidgetTester tester, Finder finder) async {
    await tester.ensureVisible(finder);
    await tester.pumpAndSettle();
    await tester.tap(finder);
    await tester.pumpAndSettle();
  }

  Future<void> setName(WidgetTester tester, String name) async {
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('custom_food_name')),
        matching: find.byType(EditableText),
      ),
      name,
    );
    await tester.pumpAndSettle();
  }

  /// Busca el ingrediente en el catálogo y le fija su proporción.
  Future<void> addIngredient(
    WidgetTester tester,
    FoodItem food,
    String percent,
  ) async {
    await tap(tester, find.byKey(const Key('custom_food_add_ingredient')));
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('food_picker_query')),
        matching: find.byType(EditableText),
      ),
      food.name,
    );
    await tester.pumpAndSettle();
    await tap(tester, find.byKey(Key('food_option_${food.foodId}')));
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('custom_food_proportion_field')),
        matching: find.byType(EditableText),
      ),
      percent,
    );
    await tester.pumpAndSettle();
    await tap(tester, find.byKey(const Key('custom_food_proportion_confirm')));
  }

  bool canSave(WidgetTester tester) =>
      tester
          .widget<CauceButton>(find.byKey(const Key('custom_food_submit')))
          .onPressed !=
      null;

  String nameText(WidgetTester tester) => tester
      .widget<EditableText>(
        find.descendant(
          of: find.byKey(const Key('custom_food_name')),
          matching: find.byType(EditableText),
        ),
      )
      .controller
      .text;

  group('CP025 · plato con ingredientes del catálogo', () {
    testWidgets(
        'Lomo saltado casero con 40, 30 y 30 % suma 100, estima y se guarda',
        (tester) async {
      final dishes = _Dishes();
      await pumpForm(tester, dishes);

      await setName(tester, 'Lomo saltado casero');
      await addIngredient(tester, _carne, '40');
      await addIngredient(tester, _cebolla, '30');
      await addIngredient(tester, _zanahoria, '30');

      for (final (index, food, percent) in <(int, FoodItem, String)>[
        (0, _carne, '40'),
        (1, _cebolla, '30'),
        (2, _zanahoria, '30'),
      ]) {
        final row = find.byKey(Key('custom_food_ingredient_$index'));
        expect(
          find.descendant(of: row, matching: find.text(food.name)),
          findsOneWidget,
        );
        expect(
          find.descendant(
            of: row,
            matching: find.text(l10n.customFoodProportionPercent(percent)),
          ),
          findsOneWidget,
        );
      }
      expect(
        tester
            .widget<Text>(find.byKey(const Key('custom_food_proportion_total')))
            .data,
        l10n.customFoodProportionTotal('100'),
      );
      expect(find.byKey(const Key('custom_food_estimate')), findsOneWidget);

      await tap(tester, find.byKey(const Key('custom_food_submit')));

      expect(find.byKey(const Key('custom_food_created')), findsOneWidget);
      final saved = dishes.created.single.draft;
      expect(saved.name, 'Lomo saltado casero');
      expect(saved.ingredients.map((item) => item.foodId), <String>[
        _carne.foodId,
        _cebolla.foodId,
        _zanahoria.foodId,
      ]);
    });
  });

  group('CP026 · nombre repetido, sin ingredientes y sin nombre', () {
    testWidgets('ninguna variante guarda y cada una conserva lo escrito',
        (tester) async {
      final dishes = _Dishes(
        existing: <CustomFoodRecord>[
          CustomFoodRecord(
            customFoodId: 'c-arroz',
            name: 'Mi arroz con pollo',
            portionSizeGrams: 100,
            createdAt: DateTime.utc(2026, 10, 1),
          ),
        ],
      );
      await pumpForm(tester, dishes);

      // A: nombre repetido, con un ingrediente.
      await setName(tester, 'Mi arroz con pollo');
      await addIngredient(tester, _arroz, '100');
      expect(
        find.byKey(const Key('custom_food_issue_duplicateName')),
        findsOneWidget,
      );
      expect(canSave(tester), isFalse);
      expect(find.byKey(const Key('custom_food_ingredient_0')), findsOneWidget);

      // B: sin ingredientes, con otro nombre.
      await setName(tester, 'Mi mezcla especial');
      await tap(
        tester,
        find.descendant(
          of: find.byKey(const Key('custom_food_ingredient_0')),
          matching: find.text(l10n.mealsRemoveItem),
        ),
      );
      expect(
        find.byKey(const Key('custom_food_issue_noIngredients')),
        findsOneWidget,
      );
      expect(canSave(tester), isFalse);
      expect(nameText(tester), 'Mi mezcla especial');

      // C: sin nombre, con un ingrediente.
      await setName(tester, '');
      await addIngredient(tester, _arroz, '100');
      expect(
        find.byKey(const Key('custom_food_issue_invalidName')),
        findsOneWidget,
      );
      expect(canSave(tester), isFalse);
      expect(find.byKey(const Key('custom_food_ingredient_0')), findsOneWidget);

      expect(dishes.created, isEmpty);
    });
  });

  group('CP027 · alérgeno declarado en un ingrediente', () {
    testWidgets(
        'avisa la lactosa, deja guardar, pide confirmar, cancelar no crea y '
        'confirmar sí', (tester) async {
      final dishes = _Dishes();
      await pumpForm(tester, dishes);

      await setName(tester, 'Salsa de queso casera');
      await addIngredient(tester, _queso, '100');

      final warning = find.byKey(const Key('custom_food_allergen_warning'));
      expect(warning, findsOneWidget);
      expect(
        find.descendant(of: warning, matching: find.textContaining('Lactosa')),
        findsOneWidget,
      );
      expect(canSave(tester), isTrue);

      await tap(tester, find.byKey(const Key('custom_food_submit')));
      expect(
        find.byKey(const Key('custom_food_allergen_title')),
        findsOneWidget,
      );

      await tap(tester, find.byKey(const Key('custom_food_allergen_cancel')));
      expect(dishes.created, isEmpty);
      expect(nameText(tester), 'Salsa de queso casera');

      await tap(tester, find.byKey(const Key('custom_food_submit')));
      await tap(tester, find.byKey(const Key('custom_food_allergen_confirm')));

      expect(find.byKey(const Key('custom_food_created')), findsOneWidget);
      expect(dishes.created.single.draft.name, 'Salsa de queso casera');
      expect(dishes.created.single.confirmed, isTrue);
    });
  });
}
