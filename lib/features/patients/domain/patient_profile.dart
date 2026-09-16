import 'dart:math' as math;

import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

import 'allergy.dart';

part 'patient_profile.freezed.dart';

/// Sexo biologico declarado en el perfil clinico (US03).
///
/// Enum propio y no `api.BiologicalSex` por la misma razon que
/// `AuthenticatedUserSnapshot` no reutiliza `api.AuthenticatedUser`: el modelo
/// generado es `built_value` y esta atado al ciclo de regeneracion del cliente
/// OpenAPI. El dominio no deberia moverse cuando se regenera el cliente.
enum BiologicalSexOption {
  male,
  female,
  other;

  api.BiologicalSex toApi() => switch (this) {
        BiologicalSexOption.male => api.BiologicalSex.male,
        BiologicalSexOption.female => api.BiologicalSex.female,
        BiologicalSexOption.other => api.BiologicalSex.other,
      };

  /// Traduce desde el modelo generado.
  ///
  /// Devuelve `null` solo si el backend agregara un valor que este cliente no
  /// conoce, escenario que en la practica nunca llega hasta aca: `built_value`
  /// falla antes, al deserializar el objeto entero.
  static BiologicalSexOption? fromApi(api.BiologicalSex? value) {
    return switch (value) {
      api.BiologicalSex.male => BiologicalSexOption.male,
      api.BiologicalSex.female => BiologicalSexOption.female,
      api.BiologicalSex.other => BiologicalSexOption.other,
      _ => null,
    };
  }
}

/// Subtipo clinico de SII segun los criterios de Roma IV.
enum IbsSubtypeOption {
  /// Con predominio de diarrea.
  ibsD,

  /// Con predominio de estrenimiento.
  ibsC,

  /// Mixto.
  ibsM,

  /// No clasificado.
  ibsU;

  api.IbsSubtype toApi() => switch (this) {
        IbsSubtypeOption.ibsD => api.IbsSubtype.ibsD,
        IbsSubtypeOption.ibsC => api.IbsSubtype.ibsC,
        IbsSubtypeOption.ibsM => api.IbsSubtype.ibsM,
        IbsSubtypeOption.ibsU => api.IbsSubtype.ibsU,
      };

  static IbsSubtypeOption? fromApi(api.IbsSubtype? value) {
    return switch (value) {
      api.IbsSubtype.ibsD => IbsSubtypeOption.ibsD,
      api.IbsSubtype.ibsC => IbsSubtypeOption.ibsC,
      api.IbsSubtype.ibsM => IbsSubtypeOption.ibsM,
      api.IbsSubtype.ibsU => IbsSubtypeOption.ibsU,
      _ => null,
    };
  }
}

/// Categoria de indice de masa corporal, segun los umbrales de la OMS.
enum BmiCategory {
  underweight,
  normal,
  overweight,
  obese;

  /// Traduce la cadena que emite el backend en `bmiCategory`.
  ///
  /// El contrato la declara como `string` libre y no como enum, asi que un
  /// valor inesperado no rompe la deserializacion del perfil: se degrada a
  /// `null` y la pantalla cae a la categoria calculada en el dispositivo.
  static BmiCategory? fromWire(String? value) {
    return switch (value) {
      'underweight' => BmiCategory.underweight,
      'normal' => BmiCategory.normal,
      'overweight' => BmiCategory.overweight,
      'obese' => BmiCategory.obese,
      _ => null,
    };
  }
}

/// Calculo del indice de masa corporal (US03 CA04).
///
/// Se calcula en el dispositivo para la vista previa en vivo del formulario,
/// antes de que exista perfil que consultar. El backend lo recalcula y su
/// resultado es el autoritativo; este solo adelanta el dato mientras el
/// paciente escribe.
abstract final class BmiCalculator {
  /// Umbrales de la OMS, transcritos de `PatientProfile.GetBmiCategory()`.
  static const double _underweightUpperBound = 18.5;
  static const double _normalUpperBound = 25;
  static const double _overweightUpperBound = 30;

  /// IMC en kg/m2, redondeado a dos decimales.
  ///
  /// Devuelve `null` si algun valor no permite el calculo, que incluye la
  /// estatura en cero: dividir por cero daria infinito y lo unico sensato es
  /// no mostrar nada todavia.
  static double? calculate({
    required double? weightKg,
    required double? heightCm,
  }) {
    if (weightKg == null ||
        heightCm == null ||
        heightCm <= 0 ||
        weightKg <= 0) {
      return null;
    }
    final heightM = heightCm / 100;
    return _roundHalfToEven(weightKg / (heightM * heightM), 2);
  }

  /// Clasifica un IMC **ya redondeado**.
  ///
  /// El orden importa y replica al backend, que categoriza sobre el resultado
  /// de `CalculateBmi()`, no sobre el valor crudo. Un IMC de 18.499 redondea a
  /// 18.5 y cae en `normal` en los dos lados.
  static BmiCategory? categorize(double? bmi) {
    if (bmi == null) {
      return null;
    }
    if (bmi < _underweightUpperBound) {
      return BmiCategory.underweight;
    }
    if (bmi < _normalUpperBound) {
      return BmiCategory.normal;
    }
    if (bmi < _overweightUpperBound) {
      return BmiCategory.overweight;
    }
    return BmiCategory.obese;
  }

  /// Redondeo al par mas cercano en el punto medio.
  ///
  /// El backend usa `Math.Round(..., 2, MidpointRounding.ToEven)` sobre
  /// `decimal`, mientras que `toStringAsFixed` de Dart redondea el punto medio
  /// alejandose del cero. Replicarlo evita que la vista previa muestre un
  /// numero distinto del que devuelve el servidor al guardar.
  ///
  /// La coincidencia no es exacta en todos los casos: el backend opera en
  /// base 10 y esto en binario, de modo que un punto medio que en `decimal` es
  /// exacto puede no serlo en `double`. La divergencia posible es de 0.01 y
  /// solo en ese borde.
  static double _roundHalfToEven(double value, int decimals) {
    final factor = math.pow(10, decimals).toDouble();
    final scaled = value * factor;
    final lower = scaled.floorToDouble();
    final fraction = scaled - lower;

    final double rounded;
    if (fraction > 0.5) {
      rounded = lower + 1;
    } else if (fraction < 0.5) {
      rounded = lower;
    } else {
      rounded = lower % 2 == 0 ? lower : lower + 1;
    }
    return rounded / factor;
  }
}

/// Datos del formulario de perfil clinico, tal como el paciente los completa.
///
/// Es lo que viaja hacia `POST /api/v1/patients/profile`. Se separa de
/// [PatientProfile] porque el perfil leido trae campos que el servidor deriva
/// (IMC, edad, categoria) y que el formulario no envia.
@freezed
abstract class PatientProfileDraft with _$PatientProfileDraft {
  const factory PatientProfileDraft({
    /// Fecha de nacimiento. Solo la parte de fecha es significativa; la hora
    /// se descarta al serializar.
    required DateTime dateOfBirth,
    required BiologicalSexOption biologicalSex,
    required double weightKg,
    required double heightCm,
    required IbsSubtypeOption ibsSubtype,
    DateTime? diagnosisDate,
    String? medications,
  }) = _PatientProfileDraft;

  const PatientProfileDraft._();

  /// IMC derivado de peso y estatura, para la vista previa del formulario.
  double? get bmi =>
      BmiCalculator.calculate(weightKg: weightKg, heightCm: heightCm);

  /// Categoria del IMC derivado.
  BmiCategory? get bmiCategory => BmiCalculator.categorize(bmi);
}

/// Perfil clinico del paciente tal como lo devuelve el backend.
@freezed
abstract class PatientProfile with _$PatientProfile {
  const factory PatientProfile({
    required String profileId,
    required DateTime dateOfBirth,
    required double weightKg,
    required double heightCm,
    required double bmi,
    required int age,

    /// `true` cuando el paciente ya registro su linea base IBS-SSS. Es el
    /// dato que decide si el wizard de onboarding tiene que mostrarse.
    required bool onboardingCompleted,
    BiologicalSexOption? biologicalSex,
    IbsSubtypeOption? ibsSubtype,
    BmiCategory? bmiCategory,
    DateTime? diagnosisDate,
    String? medications,
    @Default(<AllergyDeclaration>[]) List<AllergyDeclaration> allergies,
  }) = _PatientProfile;

  const PatientProfile._();
}
