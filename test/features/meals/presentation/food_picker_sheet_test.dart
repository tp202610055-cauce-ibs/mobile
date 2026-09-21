import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/custom_foods/data/custom_foods_repository.dart';
import 'package:cauce_mobile/features/custom_foods/domain/custom_food.dart';
import 'package:cauce_mobile/features/foods/data/food_catalog_store.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:cauce_mobile/features/meals/presentation/widgets/food_picker_sheet.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/sync_fixtures.dart';

/// [CustomFoodsRepository] controlable, con solo lo que usa el buscador.
class _FakeCustomFoodsRepository implements CustomFoodsRepository {
  _FakeCustomFoodsRepository(this.dishes);

  List<CustomFoodRecord> dishes;
  int listCalls = 0;

  @override
  Future<List<CustomFoodRecord>> list() async {
    listCalls++;
    return dishes;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

final CustomFoodRecord _ajiDeGallina = CustomFoodRecord(
  customFoodId: 'c1',
  name: 'Ají de gallina de mi mamá',
  portionSizeGrams: 320,
  createdAt: DateTime.utc(2026, 9, 18),
);

void main() {
  late AppDatabase database;
  late FoodCatalogStore store;
  late _FakeCustomFoodsRepository customFoods;
  late FakeConnectivityMonitor connectivity;

  setUp(() async {
    database = AppDatabase.memory();
    store = FoodCatalogStore(database);
    customFoods = _FakeCustomFoodsRepository(<CustomFoodRecord>[_ajiDeGallina]);
    connectivity = FakeConnectivityMonitor();

    await store.replaceAll(<FoodItem>[
      const FoodItem(
        foodId: 'f1',
        name: 'Arroz blanco cocido',
        category: 'cereales',
        isPeruvian: true,
        fodmapLevel: FodmapLoad.low,
      ),
    ]);
  });
  tearDown(() => database.close());

  /// Monta un boton que abre la hoja y guarda lo que devuelve.
  Future<ValueNotifier<FoodPickerSelection?>> pumpPicker(
    WidgetTester tester, {
    bool allowCustomDishes = true,
  }) async {
    final selected = ValueNotifier<FoodPickerSelection?>(null);
    final container = ProviderContainer(
      overrides: <Override>[
        foodCatalogStoreProvider.overrideWithValue(store),
        customFoodsRepositoryProvider.overrideWithValue(customFoods),
        connectivityMonitorProvider.overrideWithValue(connectivity),
      ],
    );
    addTearDown(container.dispose);
    addTearDown(selected.dispose);

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
                      onPressed: () async {
                        selected.value = await showFoodPickerSheet(
                          context,
                          allowCustomDishes: allowCustomDishes,
                        );
                      },
                      child: const Text('abrir'),
                    ),
                  ),
                ),
              ),
              // Doble del constructor de platos: devuelve uno recien creado,
              // que es el contrato que la hoja espera de esa ruta.
              GoRoute(
                path: AppRoutes.customFoodNew,
                builder: (BuildContext context, _) => Scaffold(
                  body: Center(
                    child: TextButton(
                      key: const Key('stub_create_dish'),
                      onPressed: () => Navigator.of(context).pop(
                        CustomFoodRecord(
                          customFoodId: 'c2',
                          name: 'Causa limeña de casa',
                          portionSizeGrams: 250,
                          createdAt: DateTime.utc(2026, 9, 19),
                        ),
                      ),
                      child: const Text('crear'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('abrir'));
    await tester.pumpAndSettle();
    return selected;
  }

  group('CP025 paso 10 · el plato propio aparece al buscar', () {
    testWidgets('se encuentra escribiendo su nombre', (tester) async {
      final selected = await pumpPicker(tester);

      await tester.enterText(
        find.byKey(const Key('food_picker_query')),
        'gallina',
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('custom_food_option_c1')), findsOneWidget);
      expect(selected.value, isNull);
    });

    testWidgets('se encuentra sin tildes, igual que el catalogo',
        (tester) async {
      // Misma normalizacion que el acta M35 fijo para el catalogo: el
      // servidor no es insensible a tildes y el cliente si.
      await pumpPicker(tester);

      await tester.enterText(
        find.byKey(const Key('food_picker_query')),
        'aji',
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('custom_food_option_c1')), findsOneWidget);
    });

    testWidgets('CP025 paso 9 · se muestra diferenciado del catalogo',
        (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('es'));
      await pumpPicker(tester);

      await tester.enterText(
        find.byKey(const Key('food_picker_query')),
        'gallina',
      );
      await tester.pumpAndSettle();

      expect(find.text(l10n.mealsOwnDishBadge), findsOneWidget);
    });

    testWidgets('elegirlo devuelve la referencia de plato, no de catalogo',
        (tester) async {
      final selected = await pumpPicker(tester);

      await tester.enterText(
        find.byKey(const Key('food_picker_query')),
        'gallina',
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('custom_food_option_c1')));
      await tester.pumpAndSettle();

      final value = selected.value;
      expect(value, isA<CustomDishSelection>());
      expect((value! as CustomDishSelection).record.customFoodId, 'c1');
    });

    testWidgets('el buscador de ingredientes no los ofrece', (tester) async {
      // Un ingrediente viaja como `foodId` y el contrato no admite anidar un
      // plato dentro de otro.
      await pumpPicker(tester, allowCustomDishes: false);

      await tester.enterText(
        find.byKey(const Key('food_picker_query')),
        'gallina',
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('custom_food_option_c1')), findsNothing);
    });
  });

  group('CP025 paso 3 · sin resultados, crear un plato', () {
    testWidgets('ofrece la salida cuando no hay coincidencias', (tester) async {
      await pumpPicker(tester);

      await tester.enterText(
        find.byKey(const Key('food_picker_query')),
        'quinua con kiwicha',
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('food_picker_no_results')), findsOneWidget);
    });

    testWidgets('crear desde ahi vuelve con el plato ya elegido',
        (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('es'));
      final selected = await pumpPicker(tester);

      await tester.enterText(
        find.byKey(const Key('food_picker_query')),
        'quinua con kiwicha',
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(l10n.mealsCreateCustomFood));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('stub_create_dish')));
      await tester.pumpAndSettle();

      // La hoja se cerro y devolvio el plato nuevo, sin una segunda busqueda.
      final value = selected.value;
      expect(value, isA<CustomDishSelection>());
      expect(
        (value! as CustomDishSelection).record.name,
        'Causa limeña de casa',
      );
      expect(find.byKey(const Key('food_picker_query')), findsNothing);
    });
  });

  group('sin conexion, los platos propios avisan en vez de desaparecer', () {
    testWidgets('muestra el aviso y deja buscar en el catalogo',
        (tester) async {
      connectivity.online = false;
      await pumpPicker(tester);

      expect(
        find.byKey(const Key('food_picker_dishes_offline')),
        findsOneWidget,
      );
      expect(customFoods.listCalls, 0);

      await tester.enterText(
        find.byKey(const Key('food_picker_query')),
        'arroz',
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('food_option_f1')), findsOneWidget);
    });
  });
}
