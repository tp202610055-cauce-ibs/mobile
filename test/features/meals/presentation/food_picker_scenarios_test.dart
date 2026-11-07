import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/custom_foods/data/custom_foods_repository.dart';
import 'package:cauce_mobile/features/custom_foods/domain/custom_food.dart';
import 'package:cauce_mobile/features/foods/data/food_catalog_store.dart';
import 'package:cauce_mobile/features/foods/data/foods_repository.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:cauce_mobile/features/meals/presentation/widgets/food_picker_sheet.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/sync_fixtures.dart';

/// CP024: las tres sugerencias del buscador con los datos del caso.
final AppLocalizations l10n = AppLocalizationsEs();

const FoodItem _causa = FoodItem(
  foodId: 'f-causa',
  name: 'Causa rellena',
  category: 'platos',
  isPeruvian: true,
);
const FoodItem _papa = FoodItem(
  foodId: 'f-papa',
  name: 'Papa amarilla cocida',
  category: 'tuberculos',
  isPeruvian: true,
);
const FoodItem _lomo = FoodItem(
  foodId: 'f-lomo',
  name: 'Lomo saltado',
  category: 'platos',
  isPeruvian: true,
);
const FoodItem _aji = FoodItem(
  foodId: 'f-aji',
  name: 'Ají de gallina',
  category: 'platos',
  isPeruvian: true,
);
const FoodItem _quinua = FoodItem(
  foodId: 'f-quinua',
  name: 'Quinua blanca cocida',
  category: 'cereales',
  isPeruvian: true,
);

/// El servidor arma los grupos: «Lomo saltado», de hace 30 horas, no entra en
/// los recientes.
class _SuggestingFoods implements FoodsRepository {
  @override
  Future<FoodSuggestions> fetchSuggestions() async => const FoodSuggestions(
        recentLast24Hours: <FoodItem>[_papa],
        frequentLast30Days: <FoodItem>[_causa],
        catalogSuggestions: <FoodItem>[_aji],
      );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _NoDishes implements CustomFoodsRepository {
  @override
  Future<List<CustomFoodRecord>> list() async => const <CustomFoodRecord>[];

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.memory();
    await FoodCatalogStore(database)
        .replaceAll(<FoodItem>[_causa, _papa, _lomo, _aji, _quinua]);
  });
  tearDown(() => database.close());

  Future<void> pumpPicker(WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: <Override>[
        foodCatalogStoreProvider.overrideWithValue(FoodCatalogStore(database)),
        customFoodsRepositoryProvider.overrideWithValue(_NoDishes()),
        connectivityMonitorProvider
            .overrideWithValue(FakeConnectivityMonitor()),
        foodsRepositoryProvider.overrideWithValue(_SuggestingFoods()),
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
          home: Builder(
            builder: (context) => Scaffold(
              body: Center(
                child: TextButton(
                  onPressed: () => showFoodPickerSheet(context),
                  child: const Text('abrir'),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('abrir'));
    await tester.pumpAndSettle();
  }

  double top(WidgetTester tester, Finder finder) =>
      tester.getTopLeft(finder).dy;

  Finder option(FoodItem item) => find.byKey(Key('food_option_${item.foodId}'));

  group('CP024 · sugerencias por tres dimensiones', () {
    testWidgets(
        'sin escribir, cada alimento va bajo su grupo y «Lomo saltado» no '
        'aparece entre los recientes', (tester) async {
      await pumpPicker(tester);

      final recent = top(tester, find.text(l10n.mealsSuggestionsRecent));
      final frequent = top(tester, find.text(l10n.mealsSuggestionsFrequent));
      final catalog = top(tester, find.text(l10n.mealsSuggestionsCatalog));
      final papa = top(tester, option(_papa));
      final causa = top(tester, option(_causa));
      final aji = top(tester, option(_aji));

      expect(recent < papa && papa < frequent, isTrue);
      expect(frequent < causa && causa < catalog, isTrue);
      expect(catalog < aji, isTrue);
      expect(option(_lomo), findsNothing);
    });

    testWidgets('al escribir «quin» desaparecen los grupos y sale la quinua',
        (tester) async {
      await pumpPicker(tester);

      await tester.enterText(
        find.byKey(const Key('food_picker_query')),
        'quin',
      );
      await tester.pumpAndSettle();

      expect(find.text(l10n.mealsSuggestionsRecent), findsNothing);
      expect(find.text(l10n.mealsSuggestionsFrequent), findsNothing);
      expect(find.text(l10n.mealsSuggestionsCatalog), findsNothing);
      expect(option(_quinua), findsOneWidget);
      expect(option(_causa), findsNothing);
    });
  });
}
