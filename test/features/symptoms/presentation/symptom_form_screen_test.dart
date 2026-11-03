import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/symptoms/presentation/symptom_form_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

const String _rangeMessage = 'La intensidad debe estar entre 1 y 100';

Future<void> _pump(WidgetTester tester) async {
  await tester.pumpWidget(
    ProviderScope(
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
        home: const SymptomFormScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Finder get _input => find.descendant(
      of: find.byKey(const Key('symptom_intensity_input')),
      matching: find.byType(EditableText),
    );

bool _canSave(WidgetTester tester) =>
    tester
        .widget<CauceButton>(find.byKey(const Key('symptom_submit')))
        .onPressed !=
    null;

Future<void> _type(WidgetTester tester, String value) async {
  await tester.ensureVisible(_input);
  await tester.enterText(_input, value);
  await tester.pumpAndSettle();
}

Future<void> _chooseType(WidgetTester tester) async {
  await tester.tap(find.text('Dolor abdominal'));
  await tester.pumpAndSettle();
}

void main() {
  group('SymptomFormScreen · intensidad escrita (CP083)', () {
    for (final value in <String>['0', '101', '-5', '']) {
      testWidgets('con «$value» no guarda y avisa el rango', (tester) async {
        await _pump(tester);
        await _chooseType(tester);

        await _type(tester, value);

        expect(_canSave(tester), isFalse);
        expect(find.text(_rangeMessage), findsWidgets);
      });
    }

    for (final value in <String>['1', '100', '65']) {
      testWidgets('con «$value» permite guardar', (tester) async {
        await _pump(tester);
        await _chooseType(tester);

        await _type(tester, value);

        expect(_canSave(tester), isTrue);
        expect(find.text(_rangeMessage), findsNothing);
      });
    }

    testWidgets('el deslizador escribe su valor en el campo', (tester) async {
      await _pump(tester);
      final slider = find.descendant(
        of: find.byKey(const Key('symptom_intensity_field')),
        matching: find.byType(Slider),
      );
      await tester.ensureVisible(slider);

      tester.widget<Slider>(slider).onChanged!(40);
      await tester.pumpAndSettle();

      expect(tester.widget<EditableText>(_input).controller.text, '40');
    });
  });
}
