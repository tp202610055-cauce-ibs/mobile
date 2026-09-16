import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:cauce_mobile/features/patients/domain/patient_profile.dart';
import 'package:flutter_test/flutter_test.dart';

/// Cubre el calculo de IMC en vivo (US03 CA04) y la traduccion de enums.
///
/// Los umbrales y el redondeo replican `PatientProfile` del backend. La vista
/// previa del formulario y el valor que devuelve el servidor al guardar tienen
/// que coincidir, o el paciente veria cambiar su IMC al presionar continuar.
void main() {
  group('BmiCalculator.calculate', () {
    test('calcula el caso del paciente demo del backend', () {
      // Valores exactos de `DemoPatientSeeder`: 62.5 kg y 162 cm. El seed
      // documenta 23.81, asi que este test detecta cualquier divergencia
      // entre el calculo del dispositivo y el del servidor.
      expect(
        BmiCalculator.calculate(weightKg: 62.5, heightCm: 162),
        23.81,
      );
    });

    test('redondea a dos decimales', () {
      final bmi = BmiCalculator.calculate(weightKg: 70, heightCm: 170)!;

      expect(bmi, closeTo(24.22, 0.005));
      // Dos decimales exactos, no un double largo.
      expect(bmi.toStringAsFixed(2), bmi.toString());
    });

    test('devuelve null si falta algun valor', () {
      expect(BmiCalculator.calculate(weightKg: null, heightCm: 170), isNull);
      expect(BmiCalculator.calculate(weightKg: 70, heightCm: null), isNull);
    });

    test('una estatura de cero no produce infinito', () {
      // Dividir por cero daria Infinity y la pantalla mostraria basura
      // mientras el paciente todavia esta tipeando la estatura.
      expect(BmiCalculator.calculate(weightKg: 70, heightCm: 0), isNull);
    });

    test('valores no positivos devuelven null en vez de un IMC absurdo', () {
      expect(BmiCalculator.calculate(weightKg: 0, heightCm: 170), isNull);
      expect(BmiCalculator.calculate(weightKg: -70, heightCm: 170), isNull);
      expect(BmiCalculator.calculate(weightKg: 70, heightCm: -170), isNull);
    });
  });

  group('BmiCalculator.categorize', () {
    test('clasifica segun los umbrales de la OMS', () {
      expect(BmiCalculator.categorize(17), BmiCategory.underweight);
      expect(BmiCalculator.categorize(22), BmiCategory.normal);
      expect(BmiCalculator.categorize(27), BmiCategory.overweight);
      expect(BmiCalculator.categorize(35), BmiCategory.obese);
    });

    test('los bordes caen del lado superior, igual que el backend', () {
      // `< 18.5 => underweight`, asi que 18.5 exacto ya es normal.
      expect(BmiCalculator.categorize(18.49), BmiCategory.underweight);
      expect(BmiCalculator.categorize(18.5), BmiCategory.normal);
      expect(BmiCalculator.categorize(24.99), BmiCategory.normal);
      expect(BmiCalculator.categorize(25), BmiCategory.overweight);
      expect(BmiCalculator.categorize(29.99), BmiCategory.overweight);
      expect(BmiCalculator.categorize(30), BmiCategory.obese);
    });

    test('sin IMC no hay categoria', () {
      expect(BmiCalculator.categorize(null), isNull);
    });
  });

  group('BmiCategory.fromWire', () {
    test('traduce las cuatro cadenas del backend', () {
      expect(BmiCategory.fromWire('underweight'), BmiCategory.underweight);
      expect(BmiCategory.fromWire('normal'), BmiCategory.normal);
      expect(BmiCategory.fromWire('overweight'), BmiCategory.overweight);
      expect(BmiCategory.fromWire('obese'), BmiCategory.obese);
    });

    test('un valor desconocido degrada a null y no rompe el perfil', () {
      // El contrato la declara como string libre, no como enum, asi que el
      // backend podria agregar una categoria sin romper la deserializacion.
      expect(BmiCategory.fromWire('morbidly_obese'), isNull);
      expect(BmiCategory.fromWire(null), isNull);
      expect(BmiCategory.fromWire(''), isNull);
    });
  });

  group('Traduccion de enums al cliente generado', () {
    test('BiologicalSexOption va y vuelve sin perder informacion', () {
      for (final option in BiologicalSexOption.values) {
        expect(BiologicalSexOption.fromApi(option.toApi()), option);
      }
    });

    test('IbsSubtypeOption va y vuelve sin perder informacion', () {
      for (final option in IbsSubtypeOption.values) {
        expect(IbsSubtypeOption.fromApi(option.toApi()), option);
      }
    });

    test('los cuatro subtipos de Roma IV estan cubiertos', () {
      expect(IbsSubtypeOption.values, hasLength(4));
      expect(IbsSubtypeOption.ibsD.toApi(), api.IbsSubtype.ibsD);
      expect(IbsSubtypeOption.ibsC.toApi(), api.IbsSubtype.ibsC);
      expect(IbsSubtypeOption.ibsM.toApi(), api.IbsSubtype.ibsM);
      expect(IbsSubtypeOption.ibsU.toApi(), api.IbsSubtype.ibsU);
    });

    test('un enum ausente devuelve null en vez de un valor por defecto', () {
      // Elegir un default aca inventaria un dato clinico que el paciente no
      // declaro. Es preferible mostrar el campo vacio.
      expect(BiologicalSexOption.fromApi(null), isNull);
      expect(IbsSubtypeOption.fromApi(null), isNull);
    });
  });

  group('PatientProfileDraft', () {
    final draft = PatientProfileDraft(
      dateOfBirth: DateTime(1990, 5, 20),
      biologicalSex: BiologicalSexOption.female,
      weightKg: 62.5,
      heightCm: 162,
      ibsSubtype: IbsSubtypeOption.ibsD,
    );

    test('expone el IMC derivado para la vista previa', () {
      expect(draft.bmi, 23.81);
      expect(draft.bmiCategory, BmiCategory.normal);
    });

    test('el IMC se recalcula al cambiar peso o estatura', () {
      final heavier = draft.copyWith(weightKg: 95);

      expect(heavier.bmi, greaterThan(draft.bmi!));
      expect(heavier.bmiCategory, BmiCategory.obese);
    });

    test('los campos opcionales nacen nulos', () {
      expect(draft.diagnosisDate, isNull);
      expect(draft.medications, isNull);
    });
  });
}
