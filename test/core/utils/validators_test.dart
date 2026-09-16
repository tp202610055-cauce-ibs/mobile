import 'package:cauce_mobile/core/utils/validators.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter_test/flutter_test.dart';

/// Cubre los validadores del perfil clinico (US03 CA02).
///
/// Los rangos replican las invariantes de la entidad `PatientProfile` del
/// backend, y los bordes son **exclusivos** de los dos lados. Cada caso limite
/// esta aca a proposito: el backend reporta estas fallas con
/// `invalid_biometric_value`, que no trae detalle por campo, de modo que si un
/// valor invalido se escapa al servidor el paciente recibe un mensaje que no
/// le dice cual de los cuatro campos corregir.
void main() {
  final AppLocalizations l10n = AppLocalizationsEs();

  /// Fecha fija de referencia, para que los tests no dependan del reloj.
  final today = DateTime(2026, 9, 15);

  group('Validators.dateOfBirth', () {
    test('una fecha ausente es obligatoria', () {
      expect(
        Validators.dateOfBirth(null, l10n, today: today),
        l10n.validationRequired,
      );
    });

    test('una fecha futura se rechaza', () {
      final tomorrow = DateTime(2026, 9, 16);

      expect(
        Validators.dateOfBirth(tomorrow, l10n, today: today),
        l10n.validationDateOfBirthFuture,
      );
    });

    test('exactamente 18 anios cumplidos hoy se acepta', () {
      // Borde inferior inclusive: el backend valida `age is < 18 or > 120`.
      expect(
        Validators.dateOfBirth(DateTime(2008, 9, 15), l10n, today: today),
        isNull,
      );
    });

    test('un dia antes de cumplir 18 se rechaza', () {
      // Cumple el 16, asi que el 15 todavia tiene 17.
      expect(
        Validators.dateOfBirth(DateTime(2008, 9, 16), l10n, today: today),
        l10n.validationAgeOutOfRange(18, 120),
      );
    });

    test('120 anios cumplidos se acepta y 121 se rechaza', () {
      expect(
        Validators.dateOfBirth(DateTime(1906, 9, 15), l10n, today: today),
        isNull,
      );
      expect(
        Validators.dateOfBirth(DateTime(1905, 9, 14), l10n, today: today),
        l10n.validationAgeOutOfRange(18, 120),
      );
    });

    test('la hora del dia no altera el calculo', () {
      // Un DateTime que viene del picker puede traer hora. Solo la fecha
      // deberia contar, o alguien nacido hoy hace 18 anios a las 23:00
      // quedaria rechazado por unas horas.
      expect(
        Validators.dateOfBirth(
          DateTime(2008, 9, 15, 23, 59),
          l10n,
          today: DateTime(2026, 9, 15, 0, 1),
        ),
        isNull,
      );
    });
  });

  group('Validators.diagnosisDate', () {
    test('es opcional: null es valido', () {
      expect(Validators.diagnosisDate(null, l10n, today: today), isNull);
    });

    test('hoy se acepta', () {
      expect(Validators.diagnosisDate(today, l10n, today: today), isNull);
    });

    test('una fecha futura se rechaza', () {
      expect(
        Validators.diagnosisDate(DateTime(2026, 9, 16), l10n, today: today),
        l10n.validationDiagnosisDateFuture,
      );
    });
  });

  group('Validators.weightKg', () {
    test('un peso normal se acepta', () {
      expect(Validators.weightKg('70.5', l10n), isNull);
    });

    test('acepta coma decimal, que es lo que ofrece el teclado en es_PE', () {
      expect(Validators.weightKg('70,5', l10n), isNull);
    });

    test('vacio es obligatorio', () {
      expect(Validators.weightKg('', l10n), l10n.validationRequired);
      expect(Validators.weightKg(null, l10n), l10n.validationRequired);
    });

    test('texto no numerico se rechaza', () {
      expect(
        Validators.weightKg('setenta', l10n),
        l10n.validationNumberInvalid,
      );
    });

    test('0 se rechaza: el borde es exclusivo', () {
      expect(Validators.weightKg('0', l10n), l10n.validationWeightOutOfRange);
    });

    test('500 se rechaza: el borde superior tambien es exclusivo', () {
      expect(Validators.weightKg('500', l10n), l10n.validationWeightOutOfRange);
    });

    test('justo dentro de los bordes se acepta', () {
      expect(Validators.weightKg('0.1', l10n), isNull);
      expect(Validators.weightKg('499.9', l10n), isNull);
    });

    test('un negativo se rechaza', () {
      expect(Validators.weightKg('-5', l10n), l10n.validationWeightOutOfRange);
    });
  });

  group('Validators.heightCm', () {
    test('una estatura normal se acepta', () {
      expect(Validators.heightCm('170', l10n), isNull);
    });

    test('0 y 250 se rechazan: bordes exclusivos', () {
      expect(Validators.heightCm('0', l10n), l10n.validationHeightOutOfRange);
      expect(Validators.heightCm('250', l10n), l10n.validationHeightOutOfRange);
    });

    test('justo dentro de los bordes se acepta', () {
      expect(Validators.heightCm('0.1', l10n), isNull);
      expect(Validators.heightCm('249.9', l10n), isNull);
    });

    test('vacio es obligatorio', () {
      expect(Validators.heightCm('   ', l10n), l10n.validationRequired);
    });
  });

  group('Validators.medications', () {
    test('es opcional', () {
      expect(Validators.medications(null, l10n), isNull);
      expect(Validators.medications('', l10n), isNull);
      expect(Validators.medications('   ', l10n), isNull);
    });

    test('1000 caracteres se acepta y 1001 se rechaza', () {
      expect(Validators.medications('a' * 1000, l10n), isNull);
      expect(
        Validators.medications('a' * 1001, l10n),
        l10n.validationTextTooLong(1000),
      );
    });
  });

  group('Validators.allergyNotes', () {
    test('es opcional', () {
      expect(Validators.allergyNotes(null, l10n), isNull);
    });

    test('500 caracteres se acepta y 501 se rechaza', () {
      expect(Validators.allergyNotes('a' * 500, l10n), isNull);
      expect(
        Validators.allergyNotes('a' * 501, l10n),
        l10n.validationTextTooLong(500),
      );
    });

    test('el tope se mide sobre el texto recortado', () {
      // El repositorio envia el valor recortado, asi que validar el crudo
      // rechazaria notas que el backend si aceptaria.
      expect(Validators.allergyNotes('  ${'a' * 500}  ', l10n), isNull);
    });
  });
}
