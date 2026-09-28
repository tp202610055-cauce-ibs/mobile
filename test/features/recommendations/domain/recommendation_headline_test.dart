import 'package:cauce_mobile/features/recommendations/domain/recommendation.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation_headline.dart';
import 'package:cauce_mobile/features/recommendations/domain/recommendation_origin.dart';
import 'package:cauce_mobile/features/recommendations/presentation/recommendation_texts.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
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

  group('RecommendationTexts · texto del servidor primero (acta M49)', () {
    final l10n = AppLocalizationsEs();

    String titleOf(RecommendationDetail detail) => RecommendationTexts.title(
          l10n,
          RecommendationHeadline.of(detail),
          origin: detail.origin,
        );

    String? descriptionOf(RecommendationDetail detail) =>
        RecommendationTexts.description(
          l10n,
          RecommendationHeadline.of(detail),
        );

    test('una manual muestra su titulo y su descripcion', () {
      expect(titleOf(writtenManualDetail), 'Hidratación en ayunas');
      expect(
        descriptionOf(writtenManualDetail),
        writtenManualDetail.descriptionText,
      );
    });

    test('una modificada con textos propios los usa en vez de componer', () {
      expect(
        titleOf(rewrittenModifiedDetail),
        'Reduce la cebolla en los almuerzos',
      );
      expect(
        descriptionOf(rewrittenModifiedDetail),
        startsWith('Mantén el ajo fuera'),
      );
      // Los items siguen ahi: el icono sale de ellos, no del titulo.
      expect(
        RecommendationTexts.icon(
          RecommendationHeadline.of(rewrittenModifiedDetail),
        ),
        RecommendationTexts.actionIcon(RecommendationAction.avoid),
      );
    });

    test('una del motor sin titulo sigue componiendo el suyo', () {
      expect(approvedDetail.title, isNull);
      expect(
        titleOf(approvedDetail),
        'Evitar 2 alimentos, sustituir 1 alimento, incorporar 1 alimento',
      );
      expect(
        descriptionOf(approvedDetail),
        'Cebolla, Ajo, Leche entera y 1 más',
      );
    });

    test('una manual sin descripcion cae a la nota, como en M47', () {
      expect(manualDetail.origin, RecommendationOrigin.manual);
      expect(titleOf(manualDetail), l10n.recommendationManualTitle);
      expect(descriptionOf(manualDetail), manualDetail.note);
    });
  });
}
