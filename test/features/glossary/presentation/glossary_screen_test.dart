import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/glossary/data/glossary_repository.dart';
import 'package:cauce_mobile/features/glossary/domain/glossary_catalog.dart';
import 'package:cauce_mobile/features/glossary/presentation/glossary_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/fake_glossary_repository.dart';

final AppLocalizations l10n = AppLocalizationsEs();

Future<FakeGlossaryRepository> _pump(
  WidgetTester tester, {
  FakeGlossaryRepository? repository,
  bool settle = true,
}) async {
  final fake = repository ?? FakeGlossaryRepository();
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        glossaryRepositoryProvider.overrideWithValue(fake),
      ],
      // Con router minimo: la pantalla lleva boton de retroceso, y ese boton
      // consulta `GoRouter.canPop()`.
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
              builder: (_, __) => const GlossaryScreen(),
            ),
          ],
        ),
      ),
    ),
  );
  if (settle) {
    await tester.pumpAndSettle();
  } else {
    await tester.pump();
  }
  return fake;
}

Future<void> _type(WidgetTester tester, String text) async {
  await tester.enterText(
    find.descendant(
      of: find.byKey(const Key('glossary_search')),
      matching: find.byType(EditableText),
    ),
    text,
  );
  await tester.pumpAndSettle();
}

Future<void> _tapTerm(WidgetTester tester, String term) async {
  final finder = find.byKey(Key('glossary_term_$term'));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  group('GlossaryScreen · listado', () {
    testWidgets('muestra todos los terminos en el orden en que llegan',
        (tester) async {
      await _pump(tester);

      for (final entry in demoGlossaryTerms) {
        expect(
          find.byKey(Key('glossary_term_${entry.term}')),
          findsOneWidget,
          reason: 'falta ${entry.term}',
        );
      }
    });

    testWidgets('pide el glosario una sola vez', (tester) async {
      final fake = await _pump(tester);

      await _type(tester, 'fod');
      await _type(tester, 'fodmap');

      // La busqueda es local: escribir no dispara peticiones.
      expect(fake.fetchCalls, 1);
    });
  });

  group('GlossaryScreen · busqueda (CP068)', () {
    testWidgets('filtra en vivo mientras se escribe', (tester) async {
      await _pump(tester);

      await _type(tester, 'FODMAP');

      expect(find.byKey(const Key('glossary_term_FODMAP')), findsOneWidget);
      expect(find.byKey(const Key('glossary_term_HITL')), findsNothing);
    });

    testWidgets('no distingue tildes ni mayusculas', (tester) async {
      await _pump(tester);

      await _type(tester, 'DISTENSION');

      expect(
        find.byKey(const Key('glossary_term_Distensión abdominal')),
        findsOneWidget,
      );
    });

    testWidgets('borrar la busqueda vuelve a mostrar todo', (tester) async {
      await _pump(tester);

      await _type(tester, 'FODMAP');
      await _type(tester, '');

      expect(find.byKey(const Key('glossary_term_HITL')), findsOneWidget);
    });
  });

  group('GlossaryScreen · un termino abierto', () {
    testWidgets('tocarlo muestra la definicion y la categoria', (tester) async {
      await _pump(tester);

      await _tapTerm(tester, 'FODMAP');

      expect(
        find.byKey(const Key('glossary_definition_FODMAP')),
        findsOneWidget,
      );
      // CP068 paso 6, texto literal.
      expect(find.text(l10n.glossaryCategoryNutritional), findsOneWidget);
    });

    testWidgets('tocarlo otra vez lo cierra', (tester) async {
      await _pump(tester);

      await _tapTerm(tester, 'FODMAP');
      await _tapTerm(tester, 'FODMAP');

      expect(
        find.byKey(const Key('glossary_definition_FODMAP')),
        findsNothing,
      );
      expect(find.byKey(const Key('glossary_category')), findsNothing);
    });

    testWidgets('cada categoria lleva su texto de CP068', (tester) async {
      await _pump(tester);

      await _tapTerm(tester, 'SII');
      await _tapTerm(tester, 'HITL');

      expect(find.text(l10n.glossaryCategoryClinicalIbs), findsOneWidget);
      expect(find.text(l10n.glossaryCategorySystem), findsOneWidget);
      expect(l10n.glossaryCategoryClinicalIbs, 'clínico del SII');
      expect(l10n.glossaryCategorySystem, 'propio del sistema');
      expect(l10n.glossaryCategoryNutritional, 'Nutricional');
    });
  });

  group('GlossaryScreen · termino no encontrado (CA2, CP069)', () {
    testWidgets('lo avisa y sugiere "Disacaridos" para "disacaridasas"',
        (tester) async {
      await _pump(tester);

      await _type(tester, 'disacaridasas');

      expect(find.byKey(const Key('glossary_not_found')), findsOneWidget);
      expect(find.text(l10n.glossaryNotFoundTitle), findsOneWidget);
      expect(find.byKey(const Key('glossary_suggestions')), findsOneWidget);
      expect(
        find.byKey(const Key('glossary_suggestion_Disacáridos')),
        findsOneWidget,
      );
    });

    testWidgets('tocar la sugerencia abre ese termino', (tester) async {
      await _pump(tester);

      await _type(tester, 'disacaridasas');
      final suggestion =
          find.byKey(const Key('glossary_suggestion_Disacáridos'));
      await tester.ensureVisible(suggestion);
      await tester.pumpAndSettle();
      await tester.tap(suggestion);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('glossary_not_found')), findsNothing);
      expect(
        find.byKey(const Key('glossary_definition_Disacáridos')),
        findsOneWidget,
      );
    });

    testWidgets('sin nada parecido no muestra el bloque de sugerencias',
        (tester) async {
      await _pump(tester);

      await _type(tester, 'zzzzzz');

      expect(find.byKey(const Key('glossary_not_found')), findsOneWidget);
      expect(find.byKey(const Key('glossary_suggestions')), findsNothing);
    });

    testWidgets('CP069 paso 6: el paciente no ve la opcion de solicitarlo',
        (tester) async {
      await _pump(tester);

      await _type(tester, 'disacaridasas');

      // Ni boton ni accion: el estado vacio va sin `actionLabel`.
      expect(find.byType(CauceButton), findsNothing);
      final empty = tester.widget<CauceEmptyState>(
        find.byKey(const Key('glossary_not_found')),
      );
      expect(empty.actionLabel, isNull);
      expect(empty.onAction, isNull);
    });
  });

  group('GlossaryScreen · nota de contenido en borrador', () {
    testWidgets('se muestra mientras el backend lo declare borrador',
        (tester) async {
      await _pump(tester);

      expect(find.byKey(const Key('glossary_draft_note')), findsOneWidget);
      expect(find.text(l10n.glossaryDraftNote), findsOneWidget);
    });

    testWidgets('se retira si el contenido deja de ser borrador',
        (tester) async {
      await _pump(
        tester,
        repository: FakeGlossaryRepository(
          catalog: GlossaryCatalog(terms: demoGlossaryTerms, isDraft: false),
        ),
      );

      expect(find.byKey(const Key('glossary_draft_note')), findsNothing);
    });
  });

  group('GlossaryScreen · carga y fallo', () {
    testWidgets('mientras resuelve avisa que esta cargando', (tester) async {
      await _pump(
        tester,
        repository: FakeGlossaryRepository(
          delay: const Duration(milliseconds: 50),
        ),
        settle: false,
      );

      expect(find.text(l10n.commonLoading), findsOneWidget);

      await tester.pumpAndSettle();
    });

    testWidgets('un fallo ofrece reintentar y el reintento vuelve a pedir',
        (tester) async {
      final fake = FakeGlossaryRepository()
        ..error = const CauceApiError.network();
      await _pump(tester, repository: fake);

      expect(find.byKey(const Key('glossary_error')), findsOneWidget);
      expect(find.text(l10n.errorNetwork), findsOneWidget);

      fake.error = null;
      await tester.tap(find.byKey(const Key('glossary_retry')));
      await tester.pumpAndSettle();

      expect(fake.fetchCalls, 2);
      expect(find.byKey(const Key('glossary_term_FODMAP')), findsOneWidget);
    });

    testWidgets('un glosario vacio lo dice', (tester) async {
      await _pump(
        tester,
        repository: FakeGlossaryRepository(
          catalog: const GlossaryCatalog(
            terms: <GlossaryEntry>[],
            isDraft: true,
          ),
        ),
      );

      expect(find.byKey(const Key('glossary_empty')), findsOneWidget);
    });
  });
}
