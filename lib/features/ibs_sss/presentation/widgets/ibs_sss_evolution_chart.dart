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

/// Grafico grande de la evolucion IBS-SSS (HU0023, CP060).
///
/// **Con `fl_chart` y no con `CustomPainter`** (acta M43): esta pantalla
/// necesita ejes, escala, grilla y toque sobre un punto, que es exactamente lo
/// que `CauceSparkline` decidio no tener. El sparkline se queda como esta.
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

    if (points.isEmpty) {
      return SizedBox(height: height);
    }

    // Una etiqueta por punto satura el eje en cuanto hay mas de media docena.
    // Se muestran como maximo cinco, repartidas.
    final labelEvery = (points.length / 5).ceil().clamp(1, points.length);

    return Semantics(
      label: l10n.evolutionChartSemantics(
        points.length,
        points.first.totalScore,
        points.last.totalScore,
      ),
      child: SizedBox(
        height: height,
        child: LineChart(
          key: evolutionChartKey,
          LineChartData(
            minY: _minScore,
            maxY: _maxScore,
            minX: 0,
            maxX: (points.length - 1).toDouble(),
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
                  reservedSize: 36,
                  getTitlesWidget: (value, _) => Text(
                    value.toInt().toString(),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 28,
                  getTitlesWidget: (value, _) {
                    final index = value.round();
                    if (index < 0 ||
                        index >= points.length ||
                        index % labelEvery != 0) {
                      return const SizedBox.shrink();
                    }
                    final completedAt = points[index].completedAt;
                    if (completedAt == null) {
                      return const SizedBox.shrink();
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: CauceSpacing.space1),
                      child: Text(
                        _shortDate(completedAt.toLocal()),
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    );
                  },
                ),
              ),
            ),
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipColor: (_) => CauceColors.textPrimary,
                getTooltipItems: (spots) => spots.map((spot) {
                  final point = points[spot.x.round()];
                  final completedAt = point.completedAt;
                  return LineTooltipItem(
                    completedAt == null
                        ? l10n.evolutionScore(point.totalScore)
                        : l10n.evolutionPointTooltip(
                            point.totalScore,
                            _shortDate(completedAt.toLocal()),
                          ),
                    const TextStyle(color: CauceColors.textOnBrand),
                  );
                }).toList(),
              ),
            ),
            lineBarsData: <LineChartBarData>[
              LineChartBarData(
                spots: <FlSpot>[
                  for (var i = 0; i < points.length; i++)
                    FlSpot(i.toDouble(), points[i].totalScore.toDouble()),
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
          ),
        ),
      ),
    );
  }

  /// `dd/MM`, que es lo que entra en una etiqueta de eje.
  ///
  /// El año va en el globo del toque y en el resto de la pantalla, donde hay
  /// lugar. `OnboardingLabels.date` da la forma larga.
  static String _shortDate(DateTime value) {
    final d = value.day.toString().padLeft(2, '0');
    final m = value.month.toString().padLeft(2, '0');
    return '$d/$m';
  }
}
