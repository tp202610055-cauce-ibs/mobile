import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:flutter_test/flutter_test.dart';

/// Cubre las respuestas del cuestionario IBS-SSS de linea base (US04).
///
/// La regla central del CA02 es que las cinco dimensiones son obligatorias.
/// El instrumento admite una sola linea base por paciente, de modo que un
/// envio incompleto no se puede deshacer: gastaria la unica que hay.
void main() {
  /// Respuestas completas, para los casos que parten de ahi.
  IbsSssAnswers complete() {
    var answers = const IbsSssAnswers();
    for (final dimension in IbsSssDimension.values) {
      answers = answers.withAnswer(dimension, 40);
    }
    return answers;
  }

  group('IbsSssAnswers · completitud (CA02)', () {
    test('nace vacio e incompleto', () {
      const answers = IbsSssAnswers();

      expect(answers.isComplete, isFalse);
      expect(answers.values, isEmpty);
      expect(answers.missing, IbsSssDimension.values);
    });

    test('con cuatro de cinco sigue incompleto', () {
      var answers = const IbsSssAnswers();
      for (final dimension in IbsSssDimension.values.take(4)) {
        answers = answers.withAnswer(dimension, 50);
      }

      expect(answers.isComplete, isFalse);
      expect(answers.missing, <IbsSssDimension>[
        IbsSssDimension.lifeInterference,
      ]);
    });

    test('con las cinco queda completo', () {
      expect(complete().isComplete, isTrue);
      expect(complete().missing, isEmpty);
    });

    test('un cero cuenta como respuesta, no como ausencia', () {
      // Cero es un valor clinico valido: el paciente no tuvo ese sintoma.
      // Tratarlo como "sin responder" bloquearia un cuestionario legitimo.
      var answers = const IbsSssAnswers();
      for (final dimension in IbsSssDimension.values) {
        answers = answers.withAnswer(dimension, 0);
      }

      expect(answers.isComplete, isTrue);
      expect(answers.valueFor(IbsSssDimension.painSeverity), 0);
    });

    test('missing respeta el orden de presentacion', () {
      final answers = const IbsSssAnswers()
          .withAnswer(IbsSssDimension.bloatingSeverity, 30);

      expect(answers.missing, <IbsSssDimension>[
        IbsSssDimension.painSeverity,
        IbsSssDimension.painFrequency,
        IbsSssDimension.bowelHabitsDissatisfaction,
        IbsSssDimension.lifeInterference,
      ]);
    });
  });

  group('IbsSssAnswers.withAnswer · rango', () {
    test('acepta los dos bordes del rango', () {
      const answers = IbsSssAnswers();

      expect(
        answers.withAnswer(IbsSssDimension.painSeverity, 0).valueFor(
              IbsSssDimension.painSeverity,
            ),
        0,
      );
      expect(
        answers.withAnswer(IbsSssDimension.painSeverity, 100).valueFor(
              IbsSssDimension.painSeverity,
            ),
        100,
      );
    });

    test('rechaza un valor por debajo de cero', () {
      expect(
        () =>
            const IbsSssAnswers().withAnswer(IbsSssDimension.painSeverity, -1),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('rechaza un valor por encima de cien', () {
      expect(
        () => const IbsSssAnswers()
            .withAnswer(IbsSssDimension.lifeInterference, 101),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('no recorta en silencio un valor fuera de rango', () {
      // Recortar guardaria un dato clinico que el paciente no eligio. Solo
      // puede venir de un error de programacion, porque el control de la UI
      // ya esta acotado, y conviene que se note.
      try {
        const IbsSssAnswers().withAnswer(IbsSssDimension.painFrequency, 150);
        fail('deberia haber lanzado');
      } on ArgumentError catch (error) {
        expect(error.invalidValue, 150);
      }
    });

    test('responder dos veces la misma dimension reemplaza el valor', () {
      final answers = const IbsSssAnswers()
          .withAnswer(IbsSssDimension.painSeverity, 20)
          .withAnswer(IbsSssDimension.painSeverity, 80);

      expect(answers.valueFor(IbsSssDimension.painSeverity), 80);
      expect(answers.values, hasLength(1));
    });

    test('no muta la instancia original', () {
      const original = IbsSssAnswers();
      final updated = original.withAnswer(IbsSssDimension.painSeverity, 60);

      expect(original.values, isEmpty);
      expect(updated.values, hasLength(1));
    });
  });

  group('IbsSssScale', () {
    test('declara los limites del instrumento', () {
      expect(IbsSssScale.dimensionMin, 0);
      expect(IbsSssScale.dimensionMax, 100);
      expect(IbsSssScale.totalMin, 0);
      // Cinco dimensiones de cien.
      expect(IbsSssScale.totalMax, 500);
      expect(IbsSssDimension.values, hasLength(5));
    });

    test('isValidDimension cubre los bordes', () {
      expect(IbsSssScale.isValidDimension(0), isTrue);
      expect(IbsSssScale.isValidDimension(100), isTrue);
      expect(IbsSssScale.isValidDimension(-1), isFalse);
      expect(IbsSssScale.isValidDimension(101), isFalse);
    });
  });

  group('IbsSssSeverity', () {
    test('son tres categorias, no cuatro: no existe remision', () {
      // El enum `SeverityCategory` del contrato tiene exactamente estos tres
      // valores. Agregar una cuarta aca inventaria una categoria que el
      // backend nunca devuelve.
      expect(IbsSssSeverity.values, hasLength(3));
    });

    test('traduce las tres del cliente generado', () {
      expect(
        IbsSssSeverity.fromApi(api.SeverityCategory.mild),
        IbsSssSeverity.mild,
      );
      expect(
        IbsSssSeverity.fromApi(api.SeverityCategory.moderate),
        IbsSssSeverity.moderate,
      );
      expect(
        IbsSssSeverity.fromApi(api.SeverityCategory.severe),
        IbsSssSeverity.severe,
      );
    });

    test('una categoria ausente devuelve null', () {
      expect(IbsSssSeverity.fromApi(null), isNull);
    });
  });
}
