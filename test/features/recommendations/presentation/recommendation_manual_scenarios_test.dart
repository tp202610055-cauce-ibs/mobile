import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_recommendations_repository.dart';
import 'recommendations_harness.dart';

/// Recomendaciones manuales del nutricionista vistas por el paciente.

/// CP072: la recomendación manual con sus tres pasos.
final RecommendationDetail _cp072 = writtenManualDetail.copyWith(
  id: 'rec-cp072',
  title: 'Reducción gradual de lácteos',
  description: 'Disminuir poco a poco los lácteos de la dieta durante tres '
      'semanas y observar los síntomas',
  nutritionistNote: 'Reducir lácteos por intolerancia a la lactosa',
  steps: const <String>[
    'Semana 1: cambiar la leche entera por leche sin lactosa',
    'Semana 2: reducir el yogur a una porción diaria',
    'Semana 3: anotar en el diario los síntomas después de cada comida con '
        'lácteos',
  ],
);

/// CP090: la misma forma, sin pasos de aplicación.
final RecommendationDetail _cp090 = writtenManualDetail.copyWith(
  id: 'rec-cp090',
  title: 'Hidratación entre comidas',
  description: 'Tomar agua entre comidas y no durante ellas para facilitar la '
      'digestión',
  nutritionistNote: 'Mejorar la hidratación y la digestión entre comidas',
  steps: const <String>[],
);

/// Abre Consejos, toca la recomendación por su título y espera el detalle.
Future<void> _openFromAdvice(
  WidgetTester tester,
  RecommendationDetail detail,
) async {
  await pumpRecommendations(
    tester,
    repository: FakeRecommendationsRepository(details: [detail]),
  );
  final title = find.text(detail.title!);
  expect(title, findsOneWidget);
  await tester.ensureVisible(title);
  await tester.pumpAndSettle();
  await tester.tap(title);
  await tester.pumpAndSettle();
}

Finder _inDetail(String text) => find.descendant(
      of: find.byType(Scrollable).first,
      matching: find.textContaining(text),
    );

Future<void> _scrollTo(WidgetTester tester, Finder finder) async {
  await tester.scrollUntilVisible(
    finder,
    200,
    scrollable: find.byType(Scrollable).first,
  );
  await tester.pumpAndSettle();
}

void main() {
  group('CP090 · recomendación manual sin pasos', () {
    testWidgets(
        'Consejos la lista y el detalle muestra título, descripción y nota '
        'sin la lista de pasos', (tester) async {
      await _openFromAdvice(tester, _cp090);

      expect(
        tester.widget<Text>(find.byKey(const Key('recommendation_title'))).data,
        'Hidratación entre comidas',
      );
      await _scrollTo(tester, find.byKey(const Key('recommendation_note')));
      expect(_inDetail(_cp090.descriptionText!), findsOneWidget);
      expect(
        _inDetail('Mejorar la hidratación y la digestión entre comidas'),
        findsOneWidget,
      );
      expect(find.byKey(const Key('recommendation_steps')), findsNothing);
    });
  });

  group('CP072 · recomendación manual con pasos', () {
    testWidgets(
        'Consejos la lista y el detalle muestra título, descripción, los tres '
        'pasos en orden y la nota', (tester) async {
      await _openFromAdvice(tester, _cp072);

      expect(
        tester.widget<Text>(find.byKey(const Key('recommendation_title'))).data,
        'Reducción gradual de lácteos',
      );
      expect(_inDetail(_cp072.descriptionText!), findsOneWidget);
      final steps = find.byKey(const Key('recommendation_steps'));
      await _scrollTo(tester, steps);
      final tops = <double>[
        for (final step in _cp072.steps)
          tester
              .getTopLeft(find.descendant(of: steps, matching: find.text(step)))
              .dy,
      ];
      expect(tops, orderedEquals(<double>[...tops]..sort()));
      await _scrollTo(tester, find.byKey(const Key('recommendation_note')));
      expect(
        _inDetail('Reducir lácteos por intolerancia a la lactosa'),
        findsOneWidget,
      );
    });
  });
}
