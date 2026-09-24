import 'ibs_sss_assessment.dart';

/// Rango temporal del filtro de la pantalla de Evolucion (CP060).
///
/// **El filtro se resuelve en el cliente.** Ninguno de los tres endpoints del
/// modulo recibe parametros: `GET /ibs-sss/evolution` devuelve siempre la serie
/// completa. Para una serie que crece un punto cada catorce dias eso no es un
/// problema de volumen, y ademas deja el filtro funcionando sin red.
enum IbsSssEvolutionRange {
  /// Ultimo mes.
  lastMonth(Duration(days: 30)),

  /// Ultimos tres meses.
  lastQuarter(Duration(days: 90)),

  /// Toda la serie. Es el valor por defecto al abrir la pantalla.
  all(null);

  const IbsSssEvolutionRange(this.window);

  /// Ventana hacia atras, o `null` para no recortar.
  final Duration? window;
}

/// Serie de evolucion del IBS-SSS, ya ordenada cronologicamente.
///
/// Existe porque el orden y el porcentaje son reglas que conviene probar sin
/// montar una pantalla. **No la construyas con el constructor**: usa
/// [IbsSssEvolutionSeries.from], que es quien garantiza el orden.
///
/// El backend ordena por `CycleNumber` y no por fecha
/// (`IbsSssAssessmentRepository.ListByPatientAsync`). En la practica coinciden,
/// pero el eje de esta pantalla es temporal y confiar en que el ciclo sea un
/// buen proxy de la fecha seria una suposicion sin respaldo.
class IbsSssEvolutionSeries {
  const IbsSssEvolutionSeries._(this.points);

  /// Ordena por `completedAt` y devuelve la serie lista para graficar.
  ///
  /// Los puntos sin fecha van al final, desempatados por numero de ciclo: sin
  /// fecha no se los puede ubicar en el eje, y descartarlos perderia un puntaje
  /// que el paciente si respondio.
  factory IbsSssEvolutionSeries.from(List<IbsSssEvolutionPoint> raw) {
    final sorted = List<IbsSssEvolutionPoint>.of(raw)
      ..sort((a, b) {
        final left = a.completedAt;
        final right = b.completedAt;
        if (left != null && right != null) {
          final byDate = left.compareTo(right);
          return byDate != 0 ? byDate : a.cycleNumber.compareTo(b.cycleNumber);
        }
        if (left == null && right == null) {
          return a.cycleNumber.compareTo(b.cycleNumber);
        }
        return left == null ? 1 : -1;
      });

    return IbsSssEvolutionSeries._(
      List<IbsSssEvolutionPoint>.unmodifiable(sorted),
    );
  }

  /// Serie completa, de la mas antigua a la mas reciente.
  final List<IbsSssEvolutionPoint> points;

  bool get isEmpty => points.isEmpty;

  /// La linea base, si el paciente la respondio.
  IbsSssEvolutionPoint? get baseline {
    for (final point in points) {
      if (point.assessmentType == IbsSssAssessmentType.baseline) {
        return point;
      }
    }
    return null;
  }

  /// La evaluacion mas reciente de la serie.
  IbsSssEvolutionPoint? get latest => points.isEmpty ? null : points.last;

  /// `true` si hay al menos dos puntos, que es lo que CP060 exige para dibujar
  /// la linea de tiempo. Con uno solo corresponde el estado de CP061.
  bool get hasTimeline => points.length >= 2;

  /// Fecha estimada de la proxima evaluacion (CP061).
  ///
  /// Sale de la evaluacion mas reciente, que es la que agendo el ciclo vigente.
  DateTime? get nextAssessmentDate => latest?.nextAssessmentDate;

  /// Cambio porcentual del ultimo puntaje respecto de la linea base (CP060).
  ///
  /// **Siempre contra la linea base real**, nunca contra el primer punto del
  /// rango filtrado: cambiar el filtro cambia que puntos se ven, no este
  /// numero. Es la decision 3.1 del bloque.
  ///
  /// Conserva el signo de `deltaFromBaseline`, de modo que **negativo es
  /// mejoria**, igual que el `cumulativeChange` que usa Perfil. Este es su
  /// normalizacion: los mismos 90 puntos pesan distinto sobre una base de 220
  /// que sobre una de 450.
  ///
  /// Devuelve `null` cuando no hay con que compararlo: sin linea base, sin
  /// delta, o con una linea base en cero, que dividiria por cero.
  double? get percentChangeFromBaseline {
    final base = baseline?.totalScore;
    final delta = latest?.deltaFromBaseline;

    if (base == null || base == 0 || delta == null) {
      return null;
    }

    return delta / base * 100;
  }

  /// Los puntos que caen dentro de [range], contados desde [now].
  ///
  /// El recorte es solo de presentacion: no toca la linea base que alimenta
  /// [percentChangeFromBaseline], aunque quede fuera de la ventana.
  List<IbsSssEvolutionPoint> within(
    IbsSssEvolutionRange range, {
    DateTime? now,
  }) {
    final window = range.window;
    if (window == null) {
      return points;
    }

    final from = (now ?? DateTime.now()).subtract(window);
    return points.where((point) {
      final completedAt = point.completedAt;
      // Un punto sin fecha no se puede ubicar en la ventana. Se conserva solo
      // en el rango completo, donde no hay corte que aplicar.
      return completedAt != null && !completedAt.isBefore(from);
    }).toList();
  }
}
