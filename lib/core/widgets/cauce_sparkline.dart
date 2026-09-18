import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../theme/design_tokens.dart';

/// Un punto de la serie que dibuja [CauceSparkline].
///
/// Deliberadamente anonimo: el atomo no sabe de IBS-SSS ni de ninguna otra
/// medicion. EP0003 (HU0014 CA04) lo reutiliza con otra serie.
@immutable
class CauceSparklinePoint {
  const CauceSparklinePoint({
    required this.value,
    this.label,
    this.highlighted = false,
  });

  final double value;

  /// Texto para lectores de pantalla. Sin el, el grafico es mudo.
  final String? label;

  /// Marca el punto con un circulo relleno.
  final bool highlighted;

  @override
  bool operator ==(Object other) =>
      other is CauceSparklinePoint &&
      other.value == value &&
      other.label == label &&
      other.highlighted == highlighted;

  @override
  int get hashCode => Object.hash(value, label, highlighted);
}

/// Clave del lienzo del sparkline, para ubicarlo en tests.
const Key sparklineCanvasKey = Key('cauce_sparkline_canvas');

/// Grafico de linea compacto, sin ejes ni grilla.
///
/// **Derivado de los tokens, no transcrito**, con el mismo criterio que
/// `CauceSlider` y `CauceChoiceField`: el HTML del design system no define este
/// componente.
///
/// Se dibuja con `CustomPainter` y no con una libreria de graficos. Una
/// polilinea no justifica una dependencia nueva, y hacerlo a mano deja el
/// encuadre bajo control: este grafico muestra la evolucion de una medicion
/// clinica y no lleva colores de alarma ni zonas sombreadas que sugieran un
/// juicio que el paciente no esta en condiciones de hacer solo.
///
/// **No dibuja una escala.** Un sparkline muestra la forma de la serie, no sus
/// valores: los numeros van al lado, en texto, donde se pueden leer y donde un
/// lector de pantalla los alcanza.
class CauceSparkline extends StatelessWidget {
  const CauceSparkline({
    required this.points,
    this.height = 64,
    this.semanticLabel,
    this.minValue,
    this.maxValue,
    super.key,
  });

  final List<CauceSparklinePoint> points;

  final double height;

  /// Descripcion completa de la serie para lectores de pantalla.
  final String? semanticLabel;

  /// Extremos del eje vertical. Sin ellos se toman los de la propia serie.
  ///
  /// Fijarlos importa cuando la escala del instrumento es conocida: con dos
  /// puntos casi iguales, el encuadre automatico exagera una diferencia
  /// clinicamente irrelevante hasta que parece un derrumbe.
  final double? minValue;
  final double? maxValue;

  @override
  Widget build(BuildContext context) {
    // Con menos de dos puntos no hay linea que trazar. Se reserva el alto para
    // que el layout no salte cuando llegue la segunda evaluacion.
    if (points.length < 2) {
      return SizedBox(height: height);
    }

    return Semantics(
      label: semanticLabel,
      // El grafico es decorativo para quien usa lector de pantalla: el dato
      // vive en el texto de al lado y en esta etiqueta.
      excludeSemantics: true,
      child: SizedBox(
        height: height,
        width: double.infinity,
        child: CustomPaint(
          // Clave propia para poder encontrar **este** CustomPaint: el
          // Scaffold y otros widgets de Material tienen los suyos.
          key: sparklineCanvasKey,
          painter: _SparklinePainter(
            points: points,
            minValue: minValue,
            maxValue: maxValue,
          ),
        ),
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  const _SparklinePainter({
    required this.points,
    required this.minValue,
    required this.maxValue,
  });

  final List<CauceSparklinePoint> points;
  final double? minValue;
  final double? maxValue;

  @override
  void paint(Canvas canvas, Size size) {
    final values = points.map((point) => point.value).toList();
    final low = minValue ?? values.reduce((a, b) => a < b ? a : b);
    final high = maxValue ?? values.reduce((a, b) => a > b ? a : b);

    // Una serie plana dividiria por cero. Se dibuja centrada, que es
    // exactamente lo que significa: no cambio nada.
    final span = (high - low).abs() < 0.0001 ? 1.0 : high - low;

    const padding = 6.0;
    final usableHeight = size.height - padding * 2;
    final step = points.length == 1 ? 0.0 : size.width / (points.length - 1);

    Offset offsetOf(int index) {
      final normalized = (points[index].value - low) / span;
      // El eje vertical se invierte: en pantalla el cero esta abajo.
      final y = padding + usableHeight * (1 - normalized.clamp(0.0, 1.0));
      return Offset(step * index, y);
    }

    final path = Path()..moveTo(offsetOf(0).dx, offsetOf(0).dy);
    for (var i = 1; i < points.length; i++) {
      final offset = offsetOf(i);
      path.lineTo(offset.dx, offset.dy);
    }

    canvas.drawPath(
      path,
      Paint()
        ..color = CauceColors.brandBase
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round
        ..strokeJoin = StrokeJoin.round
        ..style = PaintingStyle.stroke,
    );

    final marker = Paint()
      ..color = CauceColors.brandStrong
      ..style = PaintingStyle.fill;
    for (var i = 0; i < points.length; i++) {
      if (points[i].highlighted) {
        canvas.drawCircle(offsetOf(i), 4, marker);
      }
    }
  }

  @override
  bool shouldRepaint(_SparklinePainter oldDelegate) {
    // `listEquals` y no `!=`: dos listas distintas con los mismos puntos son
    // el mismo grafico, y comparar por identidad repintaria en cada build.
    return !listEquals(oldDelegate.points, points) ||
        oldDelegate.minValue != minValue ||
        oldDelegate.maxValue != maxValue;
  }
}
