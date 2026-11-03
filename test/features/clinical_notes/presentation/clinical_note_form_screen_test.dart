import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/clinical_notes/presentation/clinical_note_form_screen.dart';
import 'package:cauce_mobile/features/history/domain/history_entry.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

final AppLocalizations l10n = AppLocalizationsEs();

Future<void> _pump(WidgetTester tester) {
  return tester.pumpWidget(
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
        home: ClinicalNoteFormScreen(
          entry: HistoryEntry(
            kind: HistoryEntryKind.meal,
            occurredAt: DateTime.utc(2026, 10, 26, 13),
            syncState: HistoryEntrySyncState.synced,
            serverId: 'meal-1',
            mealTime: MealTimeOption.lunch,
          ),
        ),
      ),
    ),
  );
}

String _counter(WidgetTester tester) =>
    tester.widget<Text>(find.byKey(const Key('clinical_note_counter'))).data!;

void main() {
  group('ClinicalNoteFormScreen · contador (CP034, CP035)', () {
    testWidgets('arranca en 0/500', (tester) async {
      await _pump(tester);

      expect(_counter(tester), '0/500');
    });

    testWidgets('cuenta lo escrito: 35/500', (tester) async {
      await _pump(tester);

      await tester.enterText(
        find.byKey(const Key('clinical_note_content')),
        'Tuve un día de mucho estrés laboral',
      );
      await tester.pump();

      expect(_counter(tester), '35/500');
    });

    testWidgets('pasado el tope muestra 501/500 y conserva el texto', (
      tester,
    ) async {
      await _pump(tester);
      final texto = '${'0123456789' * 50}a';

      await tester.enterText(
        find.byKey(const Key('clinical_note_content')),
        texto,
      );
      await tester.pump();

      expect(_counter(tester), '501/500');
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).controller.text,
        texto,
      );
    });
  });

  group('ClinicalNoteFormScreen · pulsar guardar sin poder (CP035)', () {
    Finder submit() => find.byKey(const Key('clinical_note_submit'));

    testWidgets('el boton queda habilitado aunque la nota este vacia',
        (tester) async {
      await _pump(tester);

      expect(tester.widget<CauceButton>(submit()).onPressed, isNotNull);
    });

    testWidgets('vacia: no guarda, avisa y el contador sigue en 0/500',
        (tester) async {
      await _pump(tester);

      await tester.tap(submit());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('clinical_note_saved')), findsNothing);
      expect(find.text(l10n.clinicalNoteEmpty), findsOneWidget);
      expect(_counter(tester), '0/500');
    });

    testWidgets('501 caracteres: no guarda y conserva el texto completo',
        (tester) async {
      await _pump(tester);
      final texto = '${'0123456789' * 50}a';
      await tester.enterText(
        find.byKey(const Key('clinical_note_content')),
        texto,
      );
      await tester.pump();

      await tester.tap(submit());
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('clinical_note_saved')), findsNothing);
      expect(find.text(l10n.clinicalNoteTooLong), findsOneWidget);
      expect(_counter(tester), '501/500');
      expect(
        tester.widget<EditableText>(find.byType(EditableText)).controller.text,
        texto,
      );
    });
  });
}
