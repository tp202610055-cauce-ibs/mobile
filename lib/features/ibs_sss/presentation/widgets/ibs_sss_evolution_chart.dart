import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/ibs_sss_assessment.dart';

/// Clave del lienzo, para encontrarlo en los tests sin depender del tipo
/// concreto que exponga la libreria.
const Key evolutionChartKey = Key('evolution_chart');

/// Escala completa del instrumento. El eje no se encuadra a la serie.
const double _minScore = 0;
const double _maxScore = 500;

/// Ancho reservado a los puntajes del eje vertical.
const double _leftTitlesSize = 36;

/// Separacion minima entre dos fechas del eje, en pixeles.
///
/// "18/09" en `labelSmall` mide unos 36; con este margen dos etiquetas nunca
/// se tocan.
const double _minLabelGap = 48;

/// Eje de tiempo real del grafico de Evolucion (HU0023, acta M49).
///
/// **La distancia entre dos puntos es el tiempo que paso entre las dos
/// evaluaciones.** Hasta este bloque los puntos se repartian por orden, y dos
/// evaluaciones respondidas con 18 minutos de diferencia ocupaban media
/// grafica como una meseta: parecia que el puntaje se habia sostenido semanas.
/// Lo encontro el recorrido en el celular.
///
/// La unidad es el **dia calendario local**: el ciclo del cuestionario es de
/// catorce dias, y la hora dentro del dia no agrega lectura. Dos evaluaciones
/// del mismo dia caen en la misma vertical, que es lo que son.
///
/// No dibuja nada: calcula posiciones y decide que fechas se etiquetan, para
/// que esas reglas se prueben sin montar el grafico.
class IbsSssTimeAxis {
  IbsSssTimeAxis._(this.points, this._days, this._anchor);

  /// Arma el eje con los puntos que tienen fecha.
  ///
  /// [points] llega ya en orden cronologico (`IbsSssEvolutionSeries.from`).
  /// **Un punto sin `completedAt` queda afuera**: en un eje de tiempo no hay
  /// donde ubicarlo, e inventarle una posicion seria dibujar un dato que no
  /// existe. El backend siempre la informa; es una defensa, no un caso real.
  factory IbsSssTimeAxis.of(List<IbsSssEvolutionPoint> points) {
    final dated = <IbsSssEvolutionPoint>[
      for (final point in points)
        if (point.completedAt != null) point,
    ];
    if (dated.isEmpty) {
      return IbsSssTimeAxis._(
        const <IbsSssEvolutionPoint>[],
        const <int>[],
        DateTime.utc(1970),
      );
    }

    final anchor = _calendarDay(dated.first.completedAt!);
    final days = <int>[
      for (final point in dated)
        _calendarDay(point.completedAt!).difference(anchor).inDays,
    ];
    return IbsSssTimeAxis._(
      List<IbsSssEvolutionPoint>.unmodifiable(dated),
      List<int>.unmodifiable(days),
      anchor,
    );
  }

  /// Los puntos que se dibujan, en el mismo orden que [dayOf].
  final List<IbsSssEvolutionPoint> points;

  final List<int> _days;

  /// Dia calendario local de la primera evaluacion, como fecha UTC: sus
  /// componentes son los del dia local y las restas no sufren cambios de
  /// horario.
  final DateTime _anchor;

  bool get isEmpty => points.isEmpty;

  /// Dias desde la primera evaluacion hasta el punto [index].
  int dayOf(int index) => _days[index];

  int get _span => _days.isEmpty ? 0 : _days.last;

  /// Margen a cada lado, en dias, para que el primer y el ultimo punto no
  /// queden pegados al borde. Al menos un dia: con una sola evaluacion, o con
  /// todas el mismo dia, el eje igual necesita un ancho que dibujar.
  int get _padding {
    final proportional = (_span * 0.05).ceil();
    return proportional < 1 ? 1 : proportional;
  }

  double get minX => -_padding.toDouble();

  double get maxX => (_span + _padding).toDouble();

  /// Fecha del dia [day] del eje, contado desde la primera evaluacion.
  DateTime dateAt(int day) => _anchor.add(Duration(days: day));

  /// Dias que llevan fecha debajo, para un area de dibujo de [plotWidth].
  ///
  /// Solo los dias en que hubo evaluacion: es la fecha que el paciente
  /// reconoce, la del dia en que respondio. **La mas reciente siempre va**, y
  /// hacia atras se descarta la que quedaria a menos de [minGap] pixeles de la
  /// ultima que se conservo. Dos evaluaciones del mismo dia llevan una sola.
  Set<int> labeledDays({
    required double plotWidth,
    double minGap = _minLabelGap,
  }) {
    if (_days.isEmpty || plotWidth <= 0) {
      return const <int>{};
    }
    final pixelsPerDay = plotWidth / (maxX - minX);
    final kept = <int>{};
    int? lastKept;
    for (final day in _days.toSet().toList().reversed) {
      if (lastKept == null || (lastKept - day) * pixelsPerDay >= minGap) {
        kept.add(day);
        lastKept = day;
      }
    }
    return kept;
  }

  static DateTime _calendarDay(DateTime instant) {
    final local = instant.toLocal();
    return DateTime.utc(local.year, local.month, local.day);
  }
}

/// Grafico grande de la evolucion IBS-SSS (HU0023, CP060).
///
/// **Con `fl_chart` y no con `CustomPainter`** (acta M43): esta pantalla
/// necesita ejes, escala, grilla y toque sobre un punto, que es exactamente lo
/// que `CauceSparkline` decidio no tener. El sparkline se queda como esta.
///
/// **El eje horizontal es de tiempo real** ([IbsSssTimeAxis], acta M49).
///
/// **El estilo por defecto de la libreria esta domado a proposito.** Sin
/// gradiente, sin area sombreada bajo la linea y sin la paleta de alarma que
/// `fl_chart` trae de fabrica. Es el mismo criterio que ya documenta
/// `CauceSparkline`: esto muestra una medicion clinica y no debe sugerir un
/// juicio que el paciente no esta en condiciones de hacer solo. La linea
/// tampoco se curva: interpolar entre dos evaluaciones dibujaria puntajes que
/// nadie midio.
///
/// **El eje vertical va fijo de 0 a 500**, la escala del instrumento, igual que
/// en `CauceSparkline`. Encuadrar a los extremos de la serie exagera una
/// diferencia clinicamente irrelevante hasta que parece un derrumbe.
class IbsSssEvolutionChart extends StatelessWidget {
  const IbsSssEvolutionChart({
    required this.points,
    this.height = 260,
    super.key,
  });

  /// Puntos ya ordenados cronologicamente y ya filtrados por rango.
  final List<IbsSssEvolutionPoint> points;

  final double height;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final axis = IbsSssTimeAxis.of(points);

    if (axis.isEmpty) {
      return SizedBox(height: height);
    }

    return Semantics(
      label: l10n.evolutionChartSemantics(
        axis.points.length,
        axis.points.first.totalScore,
        axis.points.last.totalScore,
      ),
      child: SizedBox(
        height: height,
        child: LayoutBuilder(
          builder: (context, constraints) {
            final labeled = axis.labeledDays(
              plotWidth: constraints.maxWidth - _leftTitlesSize,
            );
            return LineChart(
              key: evolutionChartKey,
              _data(context, l10n, axis, labeled),
            );
          },
        ),
      ),
    );
  }

  LineChartData _data(
    BuildContext context,
    AppLocalizations l10n,
    IbsSssTimeAxis axis,
    Set<int> labeled,
  ) {
    final labelStyle = Theme.of(context).textTheme.labelSmall;

    return LineChartData(
      minY: _minScore,
      maxY: _maxScore,
      minX: axis.minX,
      maxX: axis.maxX,
      // Solo lineas horizontales, en el gris de los divisores. Una grilla
      // completa compite con la serie sin agregar lectura.
      gridData: FlGridData(
        drawVerticalLine: false,
        horizontalInterval: 100,
        getDrawingHorizontalLine: (_) => const FlLine(
          color: CauceColors.bgDivider,
          strokeWidth: 1,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: CauceColors.bgDivider),
          left: BorderSide(color: CauceColors.bgDivider),
        ),
      ),
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(),
        rightTitles: const AxisTitles(),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 100,
            reservedSize: _leftTitlesSize,
            getTitlesWidget: (value, _) => Text(
              value.toInt().toString(),
              style: labelStyle,
            ),
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            // Una marca por dia: el eje arranca y termina en dias enteros, y
            // solo los dias de [labeled] llevan texto.
            interval: 1,
            reservedSize: 28,
            getTitlesWidget: (value, meta) {
              final day = value.round();
              if (day != value || !labeled.contains(day)) {
                return const SizedBox.shrink();
              }
              // `fitInside`: una fecha pegada al borde del area de dibujo se
              // corre hacia adentro lo justo para entrar entera.
              return SideTitleWidget(
                meta: meta,
                space: CauceSpacing.space1,
                fitInside: SideTitleFitInsideData.fromTitleMeta(meta),
                child: Text(_shortDate(axis.dateAt(day)), style: labelStyle),
              );
            },
          ),
        ),
      ),
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (_) => CauceColors.textPrimary,
          // El globo se centra sobre el punto, y el primero y el ultimo estan
          // cerca del borde: sin esto se salia de la pantalla y perdia texto.
          // Arriba pasa lo mismo con un puntaje cercano a 500.
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          // Por indice del punto y no por su posicion: con el eje de tiempo
          // dos evaluaciones del mismo dia comparten la `x`.
          getTooltipItems: (spots) => spots.map((spot) {
            final point = axis.points[spot.spotIndex];
            return LineTooltipItem(
              l10n.evolutionPointTooltip(
                point.totalScore,
                _shortDate(point.completedAt!.toLocal()),
              ),
              const TextStyle(color: CauceColors.textOnBrand),
            );
          }).toList(),
        ),
      ),
      lineBarsData: <LineChartBarData>[
        LineChartBarData(
          spots: <FlSpot>[
            for (var i = 0; i < axis.points.length; i++)
              FlSpot(
                axis.dayOf(i).toDouble(),
                axis.points[i].totalScore.toDouble(),
              ),
          ],
          color: CauceColors.brandBase,
          barWidth: 2,
          // Recta, no curva: entre dos evaluaciones no hay dato.
          isCurved: false,
          dotData: const FlDotData(),
          // Sin relleno bajo la linea. El area sombreada sugiere
          // "acumulado", y aca el valor es una medicion puntual.
          belowBarData: BarAreaData(),
        ),
      ],
    );
  }

  /// `dd/MM`, que es lo que entra en una etiqueta de eje y en el globo.
  ///
  /// El año se lee en el resto de la pantalla, donde hay lugar.
  /// `OnboardingLabels.date` da la forma larga.
  static String _shortDate(DateTime value) {
    final d = value.day.toString().padLeft(2, '0');
    final m = value.month.toString().padLeft(2, '0');
    return '$d/$m';
  }
}
