import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/app_database_provider.dart';
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

const FoodItem _arroz = FoodItem(
  foodId: 'f-arroz',
  name: 'Arroz blanco',
  category: 'cereales',
  isPeruvian: false,
);

void main() {
  late AppDatabase database;

  setUp(() async {
    database = AppDatabase.memory();
    await FoodCatalogStore(database).replaceAll(<FoodItem>[_arroz]);
  });
  tearDown(() => database.close());

  Future<void> pumpForm(WidgetTester tester) async {
    final container = ProviderContainer(
      overrides: <Override>[
        appDatabaseProvider.overrideWithValue(database),
        foodCatalogStoreProvider.overrideWithValue(FoodCatalogStore(database)),
        foodsRepositoryProvider.overrideWithValue(_FakeFoodsRepository()),
        customFoodsRepositoryProvider
            .overrideWithValue(_FakeCustomFoodsRepository()),
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

  /// Agrega el arroz y deja abierta la hoja de la proporción.
  Future<void> openProportion(WidgetTester tester) async {
    await tester.ensureVisible(
      find.byKey(const Key('custom_food_add_ingredient')),
    );
    await tester.tap(find.byKey(const Key('custom_food_add_ingredient')));
    await tester.pumpAndSettle();
    await tester.enterText(
      find.descendant(
        of: find.byKey(const Key('food_picker_query')),
        matching: find.byType(EditableText),
      ),
      'arroz',
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byKey(const Key('food_option_f-arroz')));
    await tester.pumpAndSettle();
  }

  Finder proportionField() => find.descendant(
        of: find.byKey(const Key('custom_food_proportion_field')),
        matching: find.byType(EditableText),
      );

  bool canConfirm(WidgetTester tester) =>
      tester
          .widget<CauceButton>(
            find.byKey(const Key('custom_food_proportion_confirm')),
          )
          .onPressed !=
      null;

  group('CustomFoodFormScreen · cada proporción no válida', () {
    for (final value in <String>[
      'NaN',
      'Infinity',
      '-Infinity',
      '1e999',
      '',
      '   ',
      'cien',
      '-50',
      '0',
    ]) {
      testWidgets('«$value» se señala y no se puede confirmar', (tester) async {
        await pumpForm(tester);
        await openProportion(tester);

        await tester.enterText(proportionField(), value);
        await tester.pumpAndSettle();

        expect(find.text(l10n.customFoodIssueInvalidProportion), findsWidgets);
        expect(canConfirm(tester), isFalse);
        expect(
          tester.widget<EditableText>(proportionField()).controller.text,
          value,
        );
      });
    }

    testWidgets('una proporción válida se puede confirmar', (tester) async {
      await pumpForm(tester);
      await openProportion(tester);

      await tester.enterText(proportionField(), '40');
      await tester.pumpAndSettle();

      expect(find.text(l10n.customFoodIssueInvalidProportion), findsNothing);
      expect(canConfirm(tester), isTrue);
    });
  });
}
