import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/widgets/cauce_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: Scaffold(body: SizedBox(width: 300, child: child)),
    ),
  );
}

List<CauceSparklinePoint> _series(List<double> values) {
  return <CauceSparklinePoint>[
    for (final value in values) CauceSparklinePoint(value: value),
  ];
}

void main() {
  group('CauceSparkline · serie insuficiente', () {
    testWidgets('sin puntos no dibuja pero reserva el alto', (tester) async {
      // Reservar el alto evita que el layout salte cuando llegue la segunda
      // evaluacion.
      await _pump(
        tester,
        const CauceSparkline(points: <CauceSparklinePoint>[], height: 64),
      );

      expect(find.byKey(sparklineCanvasKey), findsNothing);
      final box = tester.renderObject<RenderBox>(
        find.byType(SizedBox).first,
      );
      expect(box.size.height, greaterThanOrEqualTo(64));
    });

    testWidgets('con un solo punto tampoco hay linea', (tester) async {
      await _pump(tester, CauceSparkline(points: _series(<double>[220])));

      expect(find.byKey(sparklineCanvasKey), findsNothing);
    });
  });

  group('CauceSparkline · serie dibujable', () {
    testWidgets('con dos puntos dibuja', (tester) async {
      await _pump(tester, CauceSparkline(points: _series(<double>[220, 160])));

      expect(find.byKey(sparklineCanvasKey), findsOneWidget);
    });

    testWidgets('una serie plana no rompe', (tester) async {
      // El span seria cero y dividiria: se dibuja centrada, que es exactamente
      // lo que significa la serie.
      await _pump(
        tester,
        CauceSparkline(points: _series(<double>[200, 200, 200])),
      );

      expect(tester.takeException(), isNull);
      expect(find.byKey(sparklineCanvasKey), findsOneWidget);
    });

    testWidgets('acepta extremos fijos fuera del rango de la serie',
        (tester) async {
      // Es lo que hace la tarjeta de evolucion: encuadra en la escala completa
      // del instrumento (0 a 500) para no exagerar una diferencia chica.
      await _pump(
        tester,
        CauceSparkline(
          points: _series(<double>[220, 210]),
          minValue: 0,
          maxValue: 500,
        ),
      );

      expect(tester.takeException(), isNull);
    });

    testWidgets('un valor fuera de los extremos fijos no se sale del area',
        (tester) async {
      await _pump(
        tester,
        CauceSparkline(
          points: _series(<double>[-40, 800]),
          minValue: 0,
          maxValue: 500,
        ),
      );

      expect(tester.takeException(), isNull);
    });
  });

  group('CauceSparkline · accesibilidad', () {
    testWidgets('expone la serie como etiqueta', (tester) async {
      // El grafico en si es mudo: el dato viaja por esta etiqueta y por el
      // texto de al lado.
      final handle = tester.ensureSemantics();
      await _pump(
        tester,
        CauceSparkline(
          points: _series(<double>[220, 160]),
          semanticLabel: 'De 220 a 160 puntos',
        ),
      );

      expect(find.bySemanticsLabel('De 220 a 160 puntos'), findsOneWidget);
      handle.dispose();
    });
  });

  group('CauceSparklinePoint · igualdad de valor', () {
    test('dos puntos iguales son iguales', () {
      expect(
        const CauceSparklinePoint(value: 220, label: '220'),
        const CauceSparklinePoint(value: 220, label: '220'),
      );
    });

    test('el destacado los distingue', () {
      expect(
        const CauceSparklinePoint(value: 220),
        isNot(const CauceSparklinePoint(value: 220, highlighted: true)),
      );
    });
  });
}
