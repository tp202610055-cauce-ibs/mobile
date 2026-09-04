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

  /// El cuerpo puede llegar como `Map` ya deserializado o como `String` si el
  /// `Content-Type` fue `application/problem+json` y dio no lo reconocio.
  static Map<String, dynamic> _asMap(Object? data) {
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
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
