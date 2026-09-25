import 'package:cauce_mobile/features/recommendations/domain/confidence_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ConfidenceLevel.fromScore · umbrales del motor (acta M47)', () {
    test('los cortes son los de AvoidThreshold y ReduceThreshold', () {
      expect(ConfidenceLevel.highThreshold, 0.70);
      expect(ConfidenceLevel.mediumThreshold, 0.45);
    });

    test('cada borde cae del lado inclusivo', () {
      final cases = <double, ConfidenceLevel>{
        1: ConfidenceLevel.high,
        0.70: ConfidenceLevel.high,
        0.6999: ConfidenceLevel.medium,
        0.55: ConfidenceLevel.medium,
        0.45: ConfidenceLevel.medium,
        0.4499: ConfidenceLevel.low,
        0.4: ConfidenceLevel.low,
        0: ConfidenceLevel.low,
      };

      for (final entry in cases.entries) {
        expect(
          ConfidenceLevel.fromScore(entry.key),
          entry.value,
          reason: '${entry.key}',
        );
      }
    });

    test('CP037: un puntaje de 0.4 es confianza baja', () {
      expect(ConfidenceLevel.fromScore(0.4), ConfidenceLevel.low);
    });

    test('las barras llenas van de 3 a 1', () {
      expect(ConfidenceLevel.high.filledBars, 3);
      expect(ConfidenceLevel.medium.filledBars, 2);
      expect(ConfidenceLevel.low.filledBars, 1);
    });
  });
}
