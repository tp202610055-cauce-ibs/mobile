import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/errors/error_messages.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_en.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter_test/flutter_test.dart';

/// Cubre el cableado de los errores del contrato v1.3 a su mensaje.
///
/// El resto de las variantes se ejercita indirectamente desde los tests de
/// pantalla. Estas dos no tienen pantalla todavia: el canje se expone en un
/// bloque posterior, y sin este test el `switch` de [CauceApiErrorMessage]
/// quedaria sin verificar para los codigos que este bloque agrega.
void main() {
  final AppLocalizations es = AppLocalizationsEs();
  final AppLocalizations en = AppLocalizationsEn();

  group('CauceApiErrorMessage · nutritionist_not_available', () {
    test('pending_activation invita a reintentar mas tarde', () {
      const error = CauceApiError.nutritionistNotAvailable(
        reason: NutritionistNotAvailableReason.pendingActivation,
      );

      final message = error.localizedMessage(es);

      expect(message, es.errorNutritionistPendingActivation);
      expect(message, contains('todavia no activo su cuenta'));
      // Reintentar sirve: el codigo no se consume cuando el canje falla.
      expect(message, contains('Intenta de nuevo mas tarde'));
    });

    test('inactive y suspended comparten mensaje a proposito', () {
      // Para el paciente la accion util es la misma en los dos estados: pedir
      // un codigo nuevo. Distinguirlos solo expondria el estado interno de la
      // cuenta de un tercero.
      const inactive = CauceApiError.nutritionistNotAvailable(
        reason: NutritionistNotAvailableReason.inactive,
      );
      const suspended = CauceApiError.nutritionistNotAvailable(
        reason: NutritionistNotAvailableReason.suspended,
      );

      expect(
        inactive.localizedMessage(es),
        suspended.localizedMessage(es),
      );
      expect(inactive.localizedMessage(es), es.errorNutritionistUnavailable);
      expect(
        inactive.localizedMessage(es),
        contains('Comunicate con tu nutricionista'),
      );
    });

    test('los tres reason tienen mensaje en ambos locales', () {
      for (final reason in NutritionistNotAvailableReason.values) {
        final error = CauceApiError.nutritionistNotAvailable(reason: reason);
        expect(error.localizedMessage(es), isNotEmpty, reason: reason.name);
        expect(error.localizedMessage(en), isNotEmpty, reason: reason.name);
      }
    });
  });

  group('CauceApiErrorMessage · patient_already_assigned', () {
    test('avisa que ya hay un nutricionista vinculado', () {
      const error = CauceApiError.patientAlreadyAssigned();

      expect(error.localizedMessage(es), es.errorPatientAlreadyAssigned);
      expect(error.localizedMessage(es), 'Ya tienes un nutricionista asignado');
      expect(error.localizedMessage(en), isNotEmpty);
    });

    test('no expone campos por formulario ni datos del 423 y el 429', () {
      const error = CauceApiError.patientAlreadyAssigned();

      expect(error.fieldErrors, isEmpty);
      expect(error.lockedUntil, isNull);
      expect(error.retryAfterSeconds, isNull);
    });
  });

  group('CauceApiErrorMessage · perfil clinico y evaluaciones (Mobile-2)', () {
    // El switch de la extension es exhaustivo sobre el sealed, de modo que una
    // variante sin mensaje falla en compilacion. Lo que estos tests agregan es
    // que el mensaje sea el correcto y este traducido en los dos idiomas.
    final cases = <String, (CauceApiError, String)>{
      'patient_profile_not_found': (
        const CauceApiError.patientProfileNotFound(),
        es.errorPatientProfileNotFound,
      ),
      'duplicate_patient_profile': (
        const CauceApiError.duplicateProfile(),
        es.errorDuplicateProfile,
      ),
      'invalid_biometric_value': (
        const CauceApiError.invalidBiometricValue(),
        es.errorInvalidBiometricValue,
      ),
      'allergy_not_found': (
        const CauceApiError.allergyNotFound(),
        es.errorAllergyNotFound,
      ),
      'duplicate_patient_allergy': (
        const CauceApiError.duplicateAllergy(),
        es.errorDuplicateAllergy,
      ),
      'invalid_ibs_sss_dimension': (
        const CauceApiError.invalidIbsSssDimension(),
        es.errorInvalidIbsSssDimension,
      ),
      'duplicate_baseline_assessment': (
        const CauceApiError.duplicateBaselineAssessment(),
        es.errorDuplicateBaselineAssessment,
      ),
    };

    for (final entry in cases.entries) {
      test('${entry.key} tiene mensaje propio en es y en en', () {
        final (error, expected) = entry.value;

        expect(error.localizedMessage(es), expected);
        expect(error.localizedMessage(es), isNotEmpty);
        expect(error.localizedMessage(en), isNotEmpty);
        // Ninguno cae al fallback generico.
        expect(error.localizedMessage(es), isNot(es.errorUnknown));
      });
    }

    test('los siete mensajes son distintos entre si', () {
      // Comparten modulo y varios comparten status. Si dos colapsaran en el
      // mismo texto, el paciente no podria saber cual de los dos ocurrio.
      final messages =
          cases.values.map((value) => value.$1.localizedMessage(es)).toSet();

      expect(messages, hasLength(cases.length));
    });

    test('ninguno usa registro alarmista', () {
      // Son datos clinicos informativos, no un veredicto.
      for (final value in cases.values) {
        final message = value.$1.localizedMessage(es);
        expect(message, isNot(contains('!')));
        expect(message.toLowerCase(), isNot(contains('riesgo')));
        expect(message.toLowerCase(), isNot(contains('grave')));
      }
    });
  });
}
