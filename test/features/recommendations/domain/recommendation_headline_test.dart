import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation_headline.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_recommendations_repository.dart';

RecommendationItem _item(String name, RecommendationAction action) =>
    RecommendationItem(id: name, foodName: name, action: action);

RecommendationHeadline _headline(List<RecommendationItem> items) =>
    RecommendationHeadline.of(approvedDetail.copyWith(items: items));

void main() {
  group('RecommendationHeadline · decisiones 3 y 5', () {
    test('cuenta por accion en el orden del backend', () {
      // Evitar, sustituir, reducir, incorporar: el mismo orden que
      // FallbackExplanationProvider.
      final headline = RecommendationHeadline.of(approvedDetail);

      expect(headline.tally, <(RecommendationAction, int)>[
        (RecommendationAction.avoid, 2),
        (RecommendationAction.substitute, 1),
        (RecommendationAction.suggest, 1),
      ]);
    });

    test('el icono lo manda la accion con mas items', () {
      final headline = _headline(<RecommendationItem>[
        _item('Zanahoria', RecommendationAction.suggest),
        _item('Calabaza', RecommendationAction.suggest),
        _item('Cebolla', RecommendationAction.avoid),
      ]);

      expect(headline.leadAction, RecommendationAction.suggest);
    });

    test('un empate lo gana la que va primero en el orden', () {
      // El orden de los items es el del motor, no el de relevancia: en un
      // empate no gana el primer item, gana evitar.
      final headline = _headline(<RecommendationItem>[
        _item('Zanahoria', RecommendationAction.suggest),
        _item('Cebolla', RecommendationAction.avoid),
      ]);

      expect(headline.leadAction, RecommendationAction.avoid);
    });

    test('nombra los alimentos sin repetir, en el orden en que llegan', () {
      final headline = _headline(<RecommendationItem>[
        _item('Cebolla', RecommendationAction.avoid),
        _item('Ajo', RecommendationAction.avoid),
        _item('Cebolla', RecommendationAction.reduce),
      ]);

      expect(headline.foodNames, <String>['Cebolla', 'Ajo']);
    });

    test('una indicacion manual sin items se describe con la nota', () {
      final headline = RecommendationHeadline.of(manualDetail);

      expect(headline.hasItems, isFalse);
      expect(headline.leadAction, isNull);
      expect(headline.note, manualDetail.note);
    });
  });
}
