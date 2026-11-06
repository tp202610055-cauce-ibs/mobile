import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:cauce_mobile/core/sync/local_record_owner.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/custom_foods/data/custom_foods_repository.dart';
import 'package:cauce_mobile/features/custom_foods/domain/custom_food.dart';
import 'package:cauce_mobile/features/foods/data/food_catalog_store.dart';
import 'package:cauce_mobile/features/foods/data/foods_repository.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:cauce_mobile/features/meals/data/meals_repository.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:cauce_mobile/features/meals/domain/meal_record.dart';
import 'package:cauce_mobile/features/meals/presentation/meal_form_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/sync_fixtures.dart';

final AppLocalizations l10n = AppLocalizationsEs();

class _FakeCustomFoodsRepository implements CustomFoodsRepository {
  @override
  Future<List<CustomFoodRecord>> list() async => const <CustomFoodRecord>[];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Sin sugerencias ni detalle: el buscador sigue con el catalogo local.
class _FakeFoodsRepository implements FoodsRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => throw StateError('sin red');
}

/// Registra lo que se envia y responde como el servidor.
class _FakeMealsRepository implements MealsRepository {
  final List<MealDraft> created = <MealDraft>[];

  @override
  Future<CreatedMeal> create(
    MealDraft draft, {
    required String clientGuid,
    required DateTime clientCreatedAt,
  }) async {
    created.add(draft);
    return CreatedMeal(mealId: 'server-$clientGuid');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const FoodItem _causa = FoodItem(
  foodId: 'f-causa',
  name: 'Causa rellena',
  category: 'platos',
  isPeruvian: true,
);

void main() {
  late AppDatabase database;
  late FakeConnectivityMonitor connectivity;
  late _FakeMealsRepository meals;

  setUp(() async {
    database = AppDatabase.memory();
    connectivity = FakeConnectivityMonitor();
    meals = _FakeMealsRepository();
    await FoodCatalogStore(database).replaceAll(<FoodItem>[_causa]);
  });
  tearDown(() => database.close());

  /// Monta una raiz con un boton que abre el formulario, como el FAB.
  Future<void> pumpForm(WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: <Override>[
        appDatabaseProvider.overrideWithValue(database),
        localRecordOwnerProvider.overrideWithValue(() => 'patient-1'),
        foodCatalogStoreProvider.overrideWithValue(FoodCatalogStore(database)),
        foodsRepositoryProvider.overrideWithValue(_FakeFoodsRepository()),
        customFoodsRepositoryProvider
            .overrideWithValue(_FakeCustomFoodsRepository()),
        connectivityMonitorProvider.overrideWithValue(connectivity),
        mealsRepositoryProvider.overrideWithValue(meals),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp.router(
          theme: AppTheme.light(),
          localizationsDelegates: const <LocalizationsDelegate<Object>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('es'),
          routerConfig: GoRouter(
            routes: <RouteBase>[
              GoRoute(
                path: '/',
                builder: (BuildContext context, _) => Scaffold(
                  body: Center(
                    child: TextButton(
                      onPressed: () => context.push('/meals/new'),
                      child: const Text('abrir'),
                    ),
                  ),
                ),
              ),
              GoRoute(
                path: '/meals/new',
                builder: (_, __) => const MealFormScreen(),
              ),
            ],
          ),
        ),
      ),
    );
    await tester.tap(find.text('abrir'));
    await tester.pumpAndSettle();
  }

  Finder quantityField() => find.descendant(
        of: find.byKey(const Key('meal_quantity_field')),
        matching: find.byType(EditableText),
      );

  Future<void> chooseCausa(WidgetTester tester) async {
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('food_picker_query')),
        matching: find.byType(EditableText),
      ),
      'causa rellena',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('food_option_f-causa')));
    await tester.pumpAndSettle();
  }

  Future<void> tapChoice(WidgetTester tester, String label) async {
    await tester.ensureVisible(find.text(label));
    await tester.tap(find.text(label));
    await tester.pumpAndSettle();
  }

  Future<void> save(WidgetTester tester) async {
    await tester.ensureVisible(find.byKey(const Key('meal_submit')));
    await tester.tap(find.byKey(const Key('meal_submit')));
    await tester.pumpAndSettle();
  }

  Future<int> savedMeals() async =>
      (await database.select(database.mealsLocal).get()).length;

  /// CP076 pasos 1 y 2: alimento elegido, cantidad y unidad sin marcar.
  Future<void> openWithCausa(WidgetTester tester) async {
    await pumpForm(tester);
    await chooseCausa(tester);
  }

  group('MealFormScreen · el FAB abre el buscador (CP022 paso 3, CP076)', () {
    testWidgets('al entrar se abre el buscador de alimentos', (tester) async {
      await pumpForm(tester);

      expect(find.byKey(const Key('food_picker_query')), findsOneWidget);
    });

    testWidgets(
        'al elegir el alimento se ve con cantidad, unidad y momento, sin '
        'unidad marcada ni cantidad', (tester) async {
      await openWithCausa(tester);

      expect(find.byKey(const Key('food_picker_query')), findsNothing);
      expect(find.text('Causa rellena'), findsOneWidget);
      expect(find.byKey(const Key('meal_quantity_field')), findsOneWidget);
      expect(find.byKey(const Key('meal_unit_field')), findsOneWidget);
      expect(find.byKey(const Key('meal_time_field')), findsOneWidget);
      expect(tester.widget<EditableText>(quantityField()).controller.text, '');
      expect(find.text(l10n.mealsIssueMissingUnit), findsNothing);
      expect(find.text(l10n.mealsIssueQuantityNotANumber), findsNothing);
    });
  });

  group('MealFormScreen · la unidad no pisa la cantidad (CP022 paso 7)', () {
    testWidgets('elegir gramos despues de escribir 150 conserva 150',
        (tester) async {
      await openWithCausa(tester);
      await tester.enterText(quantityField(), '150');
      await tester.pumpAndSettle();

      await tapChoice(tester, l10n.measurementUnitGrams);

      expect(find.text('150'), findsOneWidget);
    });

    testWidgets('cambiar de unidad tampoco toca la cantidad', (tester) async {
      await openWithCausa(tester);
      await tester.enterText(quantityField(), '2');
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.measurementUnitCups);

      expect(find.text('2'), findsOneWidget);
    });
  });

  group('MealFormScreen · CP076 variantes A a F', () {
    testWidgets('A: cantidad cero no se guarda y conserva lo elegido',
        (tester) async {
      await openWithCausa(tester);
      await tester.enterText(quantityField(), '0');
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.mealTimeLunch);

      await save(tester);

      expect(await savedMeals(), 0);
      expect(find.text(l10n.mealsIssueInvalidQuantity), findsOneWidget);
      expect(
        find.text(l10n.mealsIssueQuantityOutOfRange('gramos', '3000')),
        findsNothing,
      );
      expect(find.text('Causa rellena'), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('A: el aviso de cantidad cero aparece apenas se escribe',
        (tester) async {
      await openWithCausa(tester);
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tester.enterText(quantityField(), '0');
      await tester.pumpAndSettle();

      expect(find.text(l10n.mealsIssueInvalidQuantity), findsOneWidget);
      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('B: cantidad negativa no se guarda', (tester) async {
      await openWithCausa(tester);
      await tester.enterText(quantityField(), '-50');
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.mealTimeLunch);

      await save(tester);

      expect(await savedMeals(), 0);
      expect(find.text(l10n.mealsIssueInvalidQuantity), findsOneWidget);
      expect(
        find.text(l10n.mealsIssueQuantityOutOfRange('gramos', '3000')),
        findsNothing,
      );
      expect(find.text('-50'), findsOneWidget);
      expect(find.text('Causa rellena'), findsOneWidget);
    });

    testWidgets('el máximo exacto de la unidad se guarda', (tester) async {
      await openWithCausa(tester);
      await tester.enterText(quantityField(), '3000');
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.mealTimeLunch);

      expect(find.text(l10n.mealsIssueInvalidQuantity), findsNothing);
      expect(
        find.text(l10n.mealsIssueQuantityOutOfRange('gramos', '3000')),
        findsNothing,
      );

      await save(tester);

      expect(find.byKey(const Key('meal_registered')), findsOneWidget);
      expect(meals.created.single.items.single.quantity, 3000);
    });

    testWidgets(
        'el máximo más uno muestra el rango apenas se escribe, no se guarda '
        'y conserva lo elegido', (tester) async {
      await openWithCausa(tester);
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.mealTimeLunch);
      await tester.enterText(quantityField(), '3001');
      await tester.pumpAndSettle();

      expect(
        find.text('Indica una cantidad mayor que 0 y hasta 3000 gramos'),
        findsOneWidget,
      );

      await save(tester);

      expect(await savedMeals(), 0);
      expect(
        find.text(l10n.mealsIssueQuantityOutOfRange('gramos', '3000')),
        findsOneWidget,
      );
      expect(find.text(l10n.mealsIssueInvalidQuantity), findsNothing);
      expect(find.text('3001'), findsOneWidget);
      expect(find.text('Causa rellena'), findsOneWidget);
    });

    testWidgets('C: cantidad con letras no se guarda', (tester) async {
      await openWithCausa(tester);
      await tester.enterText(quantityField(), 'cien');
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.mealTimeLunch);

      await save(tester);

      expect(await savedMeals(), 0);
      expect(find.text(l10n.mealsIssueQuantityNotANumber), findsOneWidget);
      expect(find.text('cien'), findsOneWidget);
    });

    testWidgets('D: quitar la unidad la señala y conserva la cantidad',
        (tester) async {
      await openWithCausa(tester);
      await tester.enterText(quantityField(), '150');
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.mealTimeLunch);
      await tapChoice(tester, l10n.measurementUnitGrams);

      await save(tester);

      expect(await savedMeals(), 0);
      expect(find.text(l10n.mealsIssueMissingUnit), findsOneWidget);
      expect(find.text('150'), findsOneWidget);
      expect(find.text('Causa rellena'), findsOneWidget);
    });

    testWidgets('D: volver a elegir la unidad conserva la cantidad',
        (tester) async {
      await openWithCausa(tester);
      await tester.enterText(quantityField(), '150');
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.measurementUnitGrams);

      expect(find.text('150'), findsOneWidget);
      expect(find.text('100'), findsNothing);
    });

    testWidgets('E: sin momento no se guarda y conserva los demas datos',
        (tester) async {
      await openWithCausa(tester);
      await tester.enterText(quantityField(), '150');
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.mealTimeLunch);
      await tapChoice(tester, l10n.mealTimeLunch);

      await save(tester);

      expect(await savedMeals(), 0);
      expect(find.text(l10n.mealsIssueMissingMealTime), findsOneWidget);
      expect(find.text('150'), findsOneWidget);
      expect(find.text('Causa rellena'), findsOneWidget);
    });

    testWidgets('F: sin alimento no se guarda y lo indica', (tester) async {
      await pumpForm(tester);
      // Cierra el buscador sin elegir nada.
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();
      await tapChoice(tester, l10n.mealTimeLunch);

      await save(tester);

      expect(await savedMeals(), 0);
      expect(find.text(l10n.mealsIssueNoItems), findsOneWidget);
    });
  });

  group('MealFormScreen · cada cantidad no válida', () {
    for (final (value, expected) in <(String, String)>[
      ('NaN', l10n.mealsIssueQuantityNotANumber),
      ('Infinity', l10n.mealsIssueQuantityNotANumber),
      ('-Infinity', l10n.mealsIssueQuantityNotANumber),
      ('1e999', l10n.mealsIssueQuantityNotANumber),
      ('', l10n.mealsIssueQuantityNotANumber),
      ('   ', l10n.mealsIssueQuantityNotANumber),
      ('cien', l10n.mealsIssueQuantityNotANumber),
      ('-50', l10n.mealsIssueInvalidQuantity),
      ('0', l10n.mealsIssueInvalidQuantity),
    ]) {
      testWidgets('«$value» no se guarda, avisa y conserva lo escrito',
          (tester) async {
        await openWithCausa(tester);
        await tester.enterText(quantityField(), value);
        await tapChoice(tester, l10n.measurementUnitGrams);
        await tapChoice(tester, l10n.mealTimeLunch);

        await save(tester);

        expect(await savedMeals(), 0);
        expect(meals.created, isEmpty);
        expect(find.text(expected), findsOneWidget);
        expect(
          tester.widget<EditableText>(quantityField()).controller.text,
          value,
        );
      });
    }
  });

  group('MealFormScreen · recorridos completos', () {
    testWidgets('CP022: Causa rellena, 150 g, almuerzo, con conexion',
        (tester) async {
      await openWithCausa(tester);
      await tester.enterText(quantityField(), '150');
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.mealTimeLunch);

      await save(tester);

      expect(find.byKey(const Key('meal_registered')), findsOneWidget);
      final draft = meals.created.single;
      expect(draft.mealTime, MealTimeOption.lunch);
      expect(draft.items.single.quantity, 150);
      expect(draft.items.single.unit, MeasurementUnitOption.grams);
      expect(draft.items.single.foodId, 'f-causa');
      final row = await database.select(database.mealsLocal).getSingle();
      expect(row.syncStatus, LocalSyncStatus.completed);
    });

    testWidgets('CP023: 250 g en modo avion queda pendiente en el telefono',
        (tester) async {
      connectivity.online = false;
      await openWithCausa(tester);
      await tester.enterText(quantityField(), '250');
      await tapChoice(tester, l10n.measurementUnitGrams);
      await tapChoice(tester, l10n.mealTimeLunch);

      await save(tester);

      expect(find.byKey(const Key('meal_queued_offline')), findsOneWidget);
      expect(meals.created, isEmpty);
      final row = await database.select(database.mealsLocal).getSingle();
      expect(row.syncStatus, LocalSyncStatus.pending);
      expect(row.mealTime, 'Lunch');
      final item = await database.select(database.mealItemsLocal).getSingle();
      expect(item.quantity, 250);
      expect(item.unit, 'Grams');
    });
  });
}
