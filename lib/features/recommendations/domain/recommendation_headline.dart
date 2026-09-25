import 'recommendation.dart';

/// Material con el que se arman el titulo, la descripcion y el icono de una
/// recomendacion (decisiones 3 y 5).
///
/// **El contrato no trae titulo ni descripcion**, ni siquiera en el detalle:
/// el backend no implementa las plantillas clinicas que describe el mockup 11.
/// Se componen aca a partir de los items, con el mismo criterio agregador que
/// usa `FallbackExplanationProvider` del backend: contar por accion.
///
/// Esta clase no arma texto. Devuelve los conteos y los nombres, y la pantalla
/// los pasa por el sistema de localizacion (R8).
class RecommendationHeadline {
  const RecommendationHeadline._({
    required this.tally,
    required this.leadAction,
    required this.foodNames,
    required this.note,
  });

  factory RecommendationHeadline.of(RecommendationDetail detail) {
    final counts = <RecommendationAction, int>{};
    final names = <String>[];
    for (final item in detail.items) {
      counts[item.action] = (counts[item.action] ?? 0) + 1;
      if (!names.contains(item.foodName)) {
        names.add(item.foodName);
      }
    }

    final tally = <(RecommendationAction, int)>[
      for (final action in RecommendationAction.displayOrder)
        if ((counts[action] ?? 0) > 0) (action, counts[action]!),
    ];

    return RecommendationHeadline._(
      tally: tally,
      leadAction: _dominant(tally),
      foodNames: names,
      note: detail.note,
    );
  }

  /// Cantidad de items por accion, en [RecommendationAction.displayOrder] y
  /// sin las acciones que no aparecen.
  final List<(RecommendationAction, int)> tally;

  /// La accion que manda el icono de la tarjeta (decision 5), o `null` sin
  /// items.
  final RecommendationAction? leadAction;

  /// Nombres de los alimentos, sin repetir, en el orden en que llegan.
  final List<String> foodNames;

  /// Nota del nutricionista. Es la descripcion de una indicacion manual sin
  /// items (decision 3).
  final String? note;

  bool get hasItems => tally.isNotEmpty;

  /// La accion con mas items. Un empate lo gana la que va primero en
  /// [RecommendationAction.displayOrder]: evitar antes que sustituir, reducir
  /// o incorporar, que es tambien la de mayor peso para el paciente.
  ///
  /// Se eligio la que domina y no la del primer item porque el orden de los
  /// items es el del motor, que ordena por puntaje y no por relevancia para
  /// quien lee (acta M47).
  static RecommendationAction? _dominant(
    List<(RecommendationAction, int)> tally,
  ) {
    RecommendationAction? lead;
    var best = 0;
    // `tally` ya viene en el orden de desempate, asi que el primero con el
    // maximo es el que gana.
    for (final (action, count) in tally) {
      if (count > best) {
        best = count;
        lead = action;
      }
    }
    return lead;
  }
}
