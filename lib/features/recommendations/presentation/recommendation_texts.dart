import 'package:flutter/widgets.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../domain/confidence_level.dart';
import '../domain/recommendation.dart';
import '../domain/recommendation_headline.dart';
import '../domain/recommendation_origin.dart';

/// Textos e iconos compuestos de una recomendacion.
///
/// El dominio da los conteos y los nombres ([RecommendationHeadline]); aca se
/// pasan por la localizacion (R8). Vive en `presentation/` porque arma texto
/// visible, y en un solo lugar porque lo usan la tarjeta y el detalle.
abstract final class RecommendationTexts {
  /// Alimentos que se nombran en la descripcion antes de resumir el resto.
  static const int namedFoods = 3;

  /// Titulo compuesto (decision 3): "Evitar 2 alimentos, sustituir 1
  /// alimento". Sin items, el de una indicacion manual o uno generico.
  static String title(
    AppLocalizations l10n,
    RecommendationHeadline headline, {
    required RecommendationOrigin origin,
  }) {
    if (headline.hasItems) {
      final parts = <String>[
        for (final (action, count) in headline.tally)
          _actionPhrase(l10n, action, count),
      ];
      return _capitalize(parts.join(', '));
    }
    return origin == RecommendationOrigin.manual
        ? l10n.recommendationManualTitle
        : l10n.recommendationFallbackTitle;
  }

  /// Descripcion compuesta: los alimentos nombrados, o la nota del
  /// nutricionista en una indicacion manual sin items (decision 3). La
  /// pantalla la recorta a dos lineas.
  static String? description(
    AppLocalizations l10n,
    RecommendationHeadline headline,
  ) {
    if (!headline.hasItems) {
      return headline.note;
    }
    final names = headline.foodNames;
    final shown = names.take(namedFoods).join(', ');
    final rest = names.length - namedFoods;
    return rest > 0 ? '$shown ${l10n.recommendationFoodsMore(rest)}' : shown;
  }

  /// Icono de la tarjeta (decision 5): el de la accion que domina, o un
  /// estetoscopio para una indicacion sin items.
  static IconData icon(RecommendationHeadline headline) {
    final lead = headline.leadAction;
    return lead == null ? TablerIcons.stethoscope : actionIcon(lead);
  }

  /// Un icono fijo por accion, del set que ya usa el proyecto.
  static IconData actionIcon(RecommendationAction action) => switch (action) {
        RecommendationAction.suggest => TablerIcons.circle_plus,
        RecommendationAction.reduce => TablerIcons.circle_minus,
        RecommendationAction.avoid => TablerIcons.ban,
        RecommendationAction.substitute => TablerIcons.arrows_exchange,
      };

  /// Encabezado de cada grupo de items en el detalle.
  static String actionGroup(
    AppLocalizations l10n,
    RecommendationAction action,
  ) =>
      switch (action) {
        RecommendationAction.suggest => l10n.recommendationItemsSuggest,
        RecommendationAction.reduce => l10n.recommendationItemsReduce,
        RecommendationAction.avoid => l10n.recommendationItemsAvoid,
        RecommendationAction.substitute => l10n.recommendationItemsSubstitute,
      };

  /// Etiqueta de la pildora de origen (decision 10).
  ///
  /// Lleva el nombre real del revisor cuando llega, tambien en la lista:
  /// como cada tarjeta ya pide su detalle, el nombre esta disponible sin una
  /// peticion extra. "tu nutricionista" queda solo como respaldo.
  static String originLabel(
    AppLocalizations l10n,
    RecommendationOrigin origin,
    String? reviewerName,
  ) {
    final name = reviewerName ?? l10n.recommendationYourNutritionist;
    return switch (origin) {
      RecommendationOrigin.system => l10n.recommendationOriginSystem,
      RecommendationOrigin.modified => l10n.recommendationOriginModified(name),
      RecommendationOrigin.manual => l10n.recommendationOriginManual(name),
    };
  }

  static IconData originIcon(RecommendationOrigin origin) => switch (origin) {
        RecommendationOrigin.system => TablerIcons.sparkles,
        RecommendationOrigin.modified => TablerIcons.edit,
        RecommendationOrigin.manual => TablerIcons.stethoscope,
      };

  static String confidenceLabel(
    AppLocalizations l10n,
    ConfidenceLevel level,
  ) =>
      switch (level) {
        ConfidenceLevel.high => l10n.recommendationConfidenceHigh,
        ConfidenceLevel.medium => l10n.recommendationConfidenceMedium,
        ConfidenceLevel.low => l10n.recommendationConfidenceLow,
      };

  /// Que significa el nivel en terminos practicos (HU0015 CA1, CP040).
  static String confidenceBody(
    AppLocalizations l10n,
    ConfidenceLevel level,
  ) =>
      switch (level) {
        ConfidenceLevel.high => l10n.recommendationConfidenceHighBody,
        ConfidenceLevel.medium => l10n.recommendationConfidenceMediumBody,
        ConfidenceLevel.low => l10n.recommendationConfidenceLowBody,
      };

  /// Fecha relativa del mockup 10: "Hoy", "Ayer", "Hace 3 dias". Pasada una
  /// semana, la fecha corta.
  static String relativeDate(
    AppLocalizations l10n,
    DateTime date,
    DateTime now, {
    required String locale,
  }) {
    final local = date.toLocal();
    final today = DateTime(now.year, now.month, now.day);
    final day = DateTime(local.year, local.month, local.day);
    final days = today.difference(day).inDays;
    return switch (days) {
      <= 0 => l10n.recommendationDateToday,
      1 => l10n.recommendationDateYesterday,
      < 7 => l10n.recommendationDateDaysAgo(days),
      _ => DateFormat.yMMMd(locale).format(local),
    };
  }

  static String _actionPhrase(
    AppLocalizations l10n,
    RecommendationAction action,
    int count,
  ) =>
      switch (action) {
        RecommendationAction.avoid => l10n.recommendationActionAvoid(count),
        RecommendationAction.substitute =>
          l10n.recommendationActionSubstitute(count),
        RecommendationAction.reduce => l10n.recommendationActionReduce(count),
        RecommendationAction.suggest => l10n.recommendationActionSuggest(count),
      };

  static String _capitalize(String text) =>
      text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
}
