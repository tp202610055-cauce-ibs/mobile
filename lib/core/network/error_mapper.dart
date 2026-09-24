import 'dart:convert';

import 'package:dio/dio.dart';

import '../errors/cauce_api_error.dart';

/// Traduce las fallas de dio al dominio [CauceApiError].
///
/// Trabaja sobre el `Map` crudo de la respuesta y no sobre el `ProblemDetails`
/// generado por openapi-generator. El esquema OpenAPI del backend declara ese
/// modelo con `additionalProperties: {}` y solo cinco campos, de modo que el
/// tipo generado no expone `errorCode`, `errors`, `lockedUntil` ni
/// `retryAfterSeconds`, que es justamente todo lo que el cliente necesita.
abstract final class ErrorMapper {
  /// Codigos de error del contrato, agrupados por como se mapean.
  static const String _validation = 'validation_error';
  static const String _consentTextMismatch = 'consent_text_mismatch';
  static const String _invalidInvitationCode = 'invalid_invitation_code';
  static const String _expiredInvitationCode = 'expired_invitation_code';
  static const String _invitationCodeAlreadyUsed =
      'invitation_code_already_used';
  static const String _duplicateEmail = 'duplicate_email';
  static const String _keycloakIntegration = 'keycloak_integration_error';
  static const String _invalidCredentials = 'invalid_credentials';
  static const String _accountLocked = 'account_locked';
  static const String _invalidRefreshToken = 'invalid_refresh_token';
  static const String _invalidPasswordResetToken =
      'invalid_password_reset_token';
  static const String _expiredPasswordResetToken =
      'expired_password_reset_token';
  static const String _userLocalMissing = 'user_local_missing';
  static const String _consentRecordNotFound = 'consent_record_not_found';
  static const String _forbidden = 'forbidden';
  static const String _nutritionistNotAvailable = 'nutritionist_not_available';
  static const String _patientAlreadyAssigned = 'patient_already_assigned';
  static const String _patientProfileNotFound = 'patient_profile_not_found';
  static const String _duplicatePatientProfile = 'duplicate_patient_profile';
  static const String _invalidBiometricValue = 'invalid_biometric_value';
  static const String _allergyNotFound = 'allergy_not_found';
  static const String _duplicatePatientAllergy = 'duplicate_patient_allergy';
  static const String _invalidIbsSssDimension = 'invalid_ibs_sss_dimension';
  static const String _duplicateBaselineAssessment =
      'duplicate_baseline_assessment';

  // Modulo ClinicalRegistry (EP0002), agregados en Mobile-3.
  static const String _foodItemNotFound = 'food_item_not_found';
  static const String _customFoodNotFound = 'custom_food_not_found';
  static const String _duplicateCustomFood = 'duplicate_custom_food';
  static const String _customFoodInUse = 'custom_food_in_use';
  static const String _duplicateIngredient = 'duplicate_ingredient';
  static const String _ingredientNotFound = 'ingredient_not_found';
  static const String _unconfirmedAllergens = 'unconfirmed_allergens';
  static const String _invalidMealRegistration = 'invalid_meal_registration';
  static const String _mealNotFound = 'meal_not_found';
  static const String _symptomNotFound = 'symptom_not_found';
  static const String _clinicalNoteNotFound = 'clinical_note_not_found';
  static const String _invalidClinicalNoteAssociation =
      'invalid_clinical_note_association';
  static const String _idempotencyMismatch = 'idempotency_mismatch';
  static const String _patientHasNoDataInPeriod =
      'patient_has_no_data_in_period';
  static const String _reportPeriodInvalid = 'report_period_invalid';
  static const String _domainRuleViolation = 'domain_rule_violation';

  /// Punto de entrada. Convierte cualquier [DioException] en un error tipado.
  static CauceApiError map(DioException exception) {
    if (_isTransportFailure(exception.type)) {
      return const CauceApiError.network();
    }

    final response = exception.response;
    if (response == null) {
      return const CauceApiError.network();
    }

    final status = response.statusCode ?? 0;
    final body = _asMap(response.data);
    final errorCode = _string(body['errorCode']);

    // 429 se detecta por status: el objeto que arma RateLimitingPolicies no
    // incluye errorCode.
    if (status == 429) {
      return CauceApiError.rateLimited(
        retryAfterSeconds: _retryAfterSeconds(body, response.headers),
      );
    }

    // 423 siempre es bloqueo de cuenta. Si la extension lockedUntil faltara o
    // viniera corrupta, se degrada a un bloqueo de 15 minutos, que es la
    // ventana que aplica el backend, en vez de perder el caso.
    if (status == 423) {
      return CauceApiError.accountLocked(
        lockedUntil: _dateTime(body['lockedUntil']) ??
            DateTime.now().toUtc().add(const Duration(minutes: 15)),
      );
    }

    return switch (errorCode) {
      _validation => _validationError(body, errorCode),
      _consentTextMismatch => const CauceApiError.consentMismatch(),
      _invalidInvitationCode => const CauceApiError.invitationCode(
          reason: InvitationCodeReason.invalid,
        ),
      _expiredInvitationCode => const CauceApiError.invitationCode(
          reason: InvitationCodeReason.expired,
        ),
      _invitationCodeAlreadyUsed => const CauceApiError.invitationCode(
          reason: InvitationCodeReason.alreadyUsed,
        ),
      _duplicateEmail => const CauceApiError.duplicateEmail(),
      _keycloakIntegration => const CauceApiError.keycloakIntegration(),
      _invalidCredentials => const CauceApiError.invalidCredentials(),
      _accountLocked => CauceApiError.accountLocked(
          lockedUntil: _dateTime(body['lockedUntil']) ??
              DateTime.now().toUtc().add(const Duration(minutes: 15)),
        ),
      _invalidRefreshToken => const CauceApiError.invalidRefreshToken(),
      _invalidPasswordResetToken => const CauceApiError.passwordResetToken(
          reason: PasswordResetTokenReason.invalid,
        ),
      _expiredPasswordResetToken => const CauceApiError.passwordResetToken(
          reason: PasswordResetTokenReason.expired,
        ),
      _userLocalMissing => const CauceApiError.userLocalMissing(),
      _consentRecordNotFound => const CauceApiError.consentRecordNotFound(),
      _forbidden => const CauceApiError.forbidden(),
      _nutritionistNotAvailable => CauceApiError.nutritionistNotAvailable(
          reason: _nutritionistReason(body['reason']),
        ),
      _patientAlreadyAssigned => const CauceApiError.patientAlreadyAssigned(),
      _patientProfileNotFound => const CauceApiError.patientProfileNotFound(),
      _duplicatePatientProfile => const CauceApiError.duplicateProfile(),
      _invalidBiometricValue => const CauceApiError.invalidBiometricValue(),
      _allergyNotFound => const CauceApiError.allergyNotFound(),
      _duplicatePatientAllergy => const CauceApiError.duplicateAllergy(),
      _invalidIbsSssDimension => const CauceApiError.invalidIbsSssDimension(),
      _duplicateBaselineAssessment =>
        const CauceApiError.duplicateBaselineAssessment(),
      _foodItemNotFound => const CauceApiError.foodItemNotFound(),
      _customFoodNotFound => const CauceApiError.customFoodNotFound(),
      _duplicateCustomFood => const CauceApiError.duplicateCustomFood(),
      _customFoodInUse => const CauceApiError.customFoodInUse(),
      _duplicateIngredient => const CauceApiError.duplicateIngredient(),
      _ingredientNotFound => const CauceApiError.ingredientNotFound(),
      _unconfirmedAllergens => CauceApiError.unconfirmedAllergens(
          allergens: _detectedAllergens(body['allergens']),
        ),
      _invalidMealRegistration => const CauceApiError.invalidMealRegistration(),
      _mealNotFound => const CauceApiError.mealNotFound(),
      _symptomNotFound => const CauceApiError.symptomNotFound(),
      _clinicalNoteNotFound => const CauceApiError.clinicalNoteNotFound(),
      _invalidClinicalNoteAssociation =>
        const CauceApiError.invalidClinicalNoteAssociation(),
      _idempotencyMismatch => const CauceApiError.idempotencyMismatch(),
      _patientHasNoDataInPeriod =>
        const CauceApiError.patientHasNoDataInPeriod(),
      _reportPeriodInvalid => const CauceApiError.reportPeriodInvalid(),
      _domainRuleViolation => CauceApiError.domainRuleViolation(
          detail: _string(body['detail']),
        ),
      // Sin errorCode reconocido. Un 400 todavia puede traer `errors`: es el
      // camino del binding automatico de [ApiController], que el contrato
      // documenta como 400 sin errorCode.
      _ => _fallback(status, body, errorCode),
    };
  }

  static CauceApiError _fallback(
    int status,
    Map<String, dynamic> body,
    String? errorCode,
  ) {
    if (status == 400 && body['errors'] != null) {
      return _validationError(body, errorCode);
    }
    return CauceApiError.unknown(
      statusCode: status,
      errorCode: errorCode,
      detail: _string(body['detail']) ?? _string(body['title']),
    );
  }

  static CauceApiError _validationError(
    Map<String, dynamic> body,
    String? errorCode,
  ) {
    return CauceApiError.validation(
      fieldErrors: _fieldErrors(body['errors']),
      errorCode: errorCode,
    );
  }

  /// Normaliza `errors` a `{campo: [mensajes]}`.
  ///
  /// El backend emite listas, pero se acepta tambien un string suelto por
  /// tolerancia: un `errors` con forma inesperada no debe tumbar la pantalla.
  static Map<String, List<String>> _fieldErrors(Object? raw) {
    if (raw is! Map) {
      return const <String, List<String>>{};
    }
    final result = <String, List<String>>{};
    for (final entry in raw.entries) {
      final key = entry.key;
      if (key is! String) {
        continue;
      }
      final value = entry.value;
      if (value is List) {
        final messages = value
            .map((message) => message?.toString())
            .whereType<String>()
            .where((message) => message.isNotEmpty)
            .toList();
        if (messages.isNotEmpty) {
          result[key] = messages;
        }
      } else if (value is String && value.isNotEmpty) {
        result[key] = <String>[value];
      }
    }
    return result;
  }

  /// Lee `retryAfterSeconds` de la extension y cae al header `Retry-After`.
  ///
  /// El backend solo emite el header cuando el valor es mayor que cero.
  static int _retryAfterSeconds(Map<String, dynamic> body, Headers headers) {
    final fromBody = _int(body['retryAfterSeconds']);
    if (fromBody != null && fromBody > 0) {
      return fromBody;
    }
    final fromHeader = _int(headers.value('retry-after'));
    if (fromHeader != null && fromHeader > 0) {
      return fromHeader;
    }
    return 60;
  }

  /// Lee la extension `reason` del 409 `nutritionist_not_available`.
  ///
  /// Un valor ausente o desconocido degrada a [
  /// NutritionistNotAvailableReason.inactive] y no a `pendingActivation`,
  /// porque el mensaje de `inactive` pide un codigo nuevo, que es util en
  /// cualquiera de los tres estados. El de `pendingActivation` invita a
  /// reintentar mas tarde, y si el motivo real fuera otro dejaria al paciente
  /// reintentando un codigo que nunca va a funcionar.
  static NutritionistNotAvailableReason _nutritionistReason(Object? value) {
    return switch (_string(value)) {
      'pending_activation' => NutritionistNotAvailableReason.pendingActivation,
      'suspended' => NutritionistNotAvailableReason.suspended,
      _ => NutritionistNotAvailableReason.inactive,
    };
  }

  /// Lee la extension `allergens` del 409 `unconfirmed_allergens` (US10 CA03).
  ///
  /// Cada entrada es `{ingredientName, allergenName, severity}`. Una entrada
  /// sin los dos nombres se descarta: no se puede mostrar una advertencia que
  /// no diga que ingrediente la disparo. Una `severity` desconocida **no**
  /// descarta la entrada, solo queda en `null`: el paciente igual tiene que
  /// enterarse de la coincidencia.
  ///
  /// Un `allergens` ausente o con forma inesperada devuelve la lista vacia. El
  /// flujo de confirmacion trata ese caso como advertencia generica, porque el
  /// 409 ya dice por si solo que hay coincidencias.
  static List<DetectedAllergen> _detectedAllergens(Object? raw) {
    if (raw is! List) {
      return const <DetectedAllergen>[];
    }
    final result = <DetectedAllergen>[];
    for (final entry in raw) {
      if (entry is! Map) {
        continue;
      }
      final ingredientName = _string(entry['ingredientName']);
      final allergenName = _string(entry['allergenName']);
      if (ingredientName == null || allergenName == null) {
        continue;
      }
      result.add(
        DetectedAllergen(
          ingredientName: ingredientName,
          allergenName: allergenName,
          severity: DetectedAllergenSeverity.fromWire(entry['severity']),
        ),
      );
    }
    return result;
  }

  /// El switch se deja exhaustivo a proposito, sin comodin: si dio agrega un
  /// tipo nuevo en un upgrade, esto falla en compilacion y obliga a decidir
  /// donde cae, en vez de degradarlo en silencio a error desconocido.
  static bool _isTransportFailure(DioExceptionType type) {
    return switch (type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout ||
      // Vencio la transformacion de la respuesta. No es una falla de red en
      // sentido estricto, pero para el paciente la accion util es la misma:
      // reintentar.
      DioExceptionType.transformTimeout ||
      DioExceptionType.connectionError =>
        true,
      DioExceptionType.badCertificate ||
      DioExceptionType.badResponse ||
      DioExceptionType.cancel ||
      DioExceptionType.unknown =>
        false,
    };
  }

  /// El cuerpo puede llegar de tres formas.
  ///
  /// Como `Map` ya deserializado, que es lo habitual. Como `String` si el
  /// `Content-Type` fue `application/problem+json` y dio no lo reconocio. Y
  /// como **bytes**, que es el caso de los endpoints que devuelven archivos.
  ///
  /// El tercero importa mas de lo que parece. Los metodos generados para
  /// descargas declaran `responseType: ResponseType.bytes`, y dio aplica ese
  /// tipo tambien a las respuestas de error: el `problem+json` del 404 llega
  /// como `Uint8List` y, sin decodificarlo, el `errorCode` se pierde y todo
  /// degrada a [UnknownError]. Le pasa a `consent/pdf`, que es hoy el unico
  /// endpoint del movil que declara ese `responseType`.
  ///
  /// **No le pasa ni a `export-data` ni al autoreporte**, aunque este
  /// comentario lo decia hasta Mobile-4: los dos terminaron devolviendo una
  /// URL prefirmada en JSON, no el binario, asi que su `problem+json` llega
  /// como `Map` y el `errorCode` se conserva.
  static Map<String, dynamic> _asMap(Object? data) {
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    if (data is String) {
      return _decode(data);
    }
    if (data is List<int>) {
      // Un cuerpo binario que no sea JSON no es un envelope de error: se
      // descarta en silencio y el error cae al fallback por status.
      return _decode(utf8.decode(data, allowMalformed: true));
    }
    return const <String, dynamic>{};
  }

  /// Parsea un cuerpo JSON, tolerando que no lo sea.
  static Map<String, dynamic> _decode(String raw) {
    if (raw.isEmpty) {
      return const <String, dynamic>{};
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      if (decoded is Map) {
        return decoded.map((key, value) => MapEntry(key.toString(), value));
      }
    } on FormatException {
      // No era JSON. Es lo esperable en un PDF truncado o en un 502 del proxy.
    }
    return const <String, dynamic>{};
  }

  static String? _string(Object? value) {
    if (value is String && value.isNotEmpty) {
      return value;
    }
    return null;
  }

  static int? _int(Object? value) {
    if (value is int) {
      return value;
    }
    if (value is num) {
      return value.toInt();
    }
    if (value is String) {
      return int.tryParse(value);
    }
    return null;
  }

  /// Parsea ISO 8601 y normaliza a UTC. El backend documenta que emite UTC,
  /// pero si el string no lleva marca de zona, `DateTime.parse` lo trata como
  /// local, asi que se fuerza la interpretacion.
  static DateTime? _dateTime(Object? value) {
    if (value is! String || value.isEmpty) {
      return null;
    }
    final parsed = DateTime.tryParse(value);
    if (parsed == null) {
      return null;
    }
    return parsed.isUtc
        ? parsed
        : DateTime.utc(
            parsed.year,
            parsed.month,
            parsed.day,
            parsed.hour,
            parsed.minute,
            parsed.second,
            parsed.millisecond,
            parsed.microsecond,
          );
  }
}
