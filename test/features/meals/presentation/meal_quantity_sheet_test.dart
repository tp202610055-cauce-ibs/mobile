import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/foods/domain/food_item.dart';
import 'package:cauce_mobile/features/meals/presentation/meal_form_screen.dart';
import 'package:cauce_mobile/features/meals/presentation/widgets/food_picker_sheet.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

final AppLocalizations l10n = AppLocalizationsEs();

const FoodItem _causa = FoodItem(
  foodId: 'f-causa',
  name: 'Causa rellena',
  category: 'platos',
  isPeruvian: true,
);

Future<void> _pump(WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('es'),
      home: const Scaffold(
        body: SingleChildScrollView(
          child: MealQuantitySheet(selection: CatalogSelection(_causa)),
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

bool _canConfirm(WidgetTester tester) =>
    tester
        .widget<CauceButton>(find.byKey(const Key('meal_quantity_confirm')))
        .onPressed !=
    null;

void main() {
  group('MealQuantitySheet · unidad (CP076 variante D)', () {
    testWidgets('arranca en gramos y permite confirmar', (tester) async {
      await _pump(tester);

      expect(_canConfirm(tester), isTrue);
      expect(find.text(l10n.mealsIssueMissingUnit), findsNothing);
    });

    testWidgets('tocar la unidad elegida la quita y señala que falta',
        (tester) async {
      await _pump(tester);
      await tester.enterText(
        find.descendant(
          of: find.byKey(const Key('meal_quantity_field')),
          matching: find.byType(EditableText),
        ),
        '150',
      );

      await tester.tap(find.text(l10n.measurementUnitGrams));
      await tester.pumpAndSettle();

      expect(_canConfirm(tester), isFalse);
      expect(find.text(l10n.mealsIssueMissingUnit), findsOneWidget);
      expect(find.text('150'), findsOneWidget);
    });

    testWidgets('elegir otra unidad vuelve a permitir confirmar',
        (tester) async {
      await _pump(tester);
      await tester.tap(find.text(l10n.measurementUnitGrams));
      await tester.pumpAndSettle();

      await tester.tap(find.text(l10n.measurementUnitGrams));
      await tester.pumpAndSettle();

      expect(_canConfirm(tester), isTrue);
    });
  });
}
