import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/network/error_mapper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

/// Arma un [DioException] con un envelope RFC 7807 como el que emite el
/// `ExceptionHandlingMiddleware` del backend.
DioException _problem({
  required int status,
  String? errorCode,
  Map<String, dynamic> extra = const <String, dynamic>{},
  Map<String, List<String>>? headers,
}) {
  final options = RequestOptions(path: '/api/v1/auth/login');
  return DioException(
    requestOptions: options,
    type: DioExceptionType.badResponse,
    response: Response<Map<String, dynamic>>(
      requestOptions: options,
      statusCode: status,
      headers: Headers.fromMap(headers ?? const <String, List<String>>{}),
      data: <String, dynamic>{
        'type': null,
        'title': 'Titulo en espanol',
        'status': status,
        'detail': 'Detalle de la excepcion',
        'instance': null,
        'traceId': '00-3f1a9c2e7b4d5a6f8e0c1b2a3d4e5f60-1a2b3c4d5e6f7a8b-00',
        if (errorCode != null) 'errorCode': errorCode,
        ...extra,
      },
    ),
  );
}

void main() {
  group('ErrorMapper · codigos del contrato', () {
    test('valida validation_error y expone los campos en camelCase', () {
      final error = ErrorMapper.map(
        _problem(
          status: 400,
          errorCode: 'validation_error',
          extra: <String, dynamic>{
            'errors': <String, dynamic>{
              'email': <String>["'Email' no es una direccion valida."],
              'password': <String>[
                'La contrasena debe contener al menos un digito.',
              ],
            },
          },
        ),
      );

      expect(error, isA<ValidationError>());
      final validation = error as ValidationError;
      expect(validation.errorCode, 'validation_error');
      expect(validation.fieldErrors.keys, containsAll(['email', 'password']));
      expect(validation.fieldErrors['password'], hasLength(1));
    });

    test('mapea los tres motivos de codigo de invitacion', () {
      final cases = <String, InvitationCodeReason>{
        'invalid_invitation_code': InvitationCodeReason.invalid,
        'expired_invitation_code': InvitationCodeReason.expired,
        'invitation_code_already_used': InvitationCodeReason.alreadyUsed,
      };

      for (final entry in cases.entries) {
        final error = ErrorMapper.map(
          _problem(status: 400, errorCode: entry.key),
        );
        expect(
          error,
          isA<InvitationCodeError>().having(
            (e) => e.reason,
            entry.key,
            entry.value,
          ),
        );
      }
    });

    test('mapea los dos motivos de token de recuperacion', () {
      expect(
        ErrorMapper.map(
          _problem(status: 400, errorCode: 'invalid_password_reset_token'),
        ),
        isA<PasswordResetTokenError>().having(
          (e) => e.reason,
          'reason',
          PasswordResetTokenReason.invalid,
        ),
      );
      expect(
        ErrorMapper.map(
          _problem(status: 400, errorCode: 'expired_password_reset_token'),
        ),
        isA<PasswordResetTokenError>().having(
          (e) => e.reason,
          'reason',
          PasswordResetTokenReason.expired,
        ),
      );
    });

    test('mapea el resto de errorCode a su tipo del dominio', () {
      final expectations = <String, Matcher>{
        'consent_text_mismatch': isA<ConsentMismatchError>(),
        'duplicate_email': isA<DuplicateEmailError>(),
        'keycloak_integration_error': isA<KeycloakIntegrationError>(),
        'invalid_credentials': isA<InvalidCredentialsError>(),
        'invalid_refresh_token': isA<InvalidRefreshTokenError>(),
        'user_local_missing': isA<UserLocalMissingError>(),
        'consent_record_not_found': isA<ConsentRecordNotFoundError>(),
        'forbidden': isA<ForbiddenError>(),
      };

      for (final entry in expectations.entries) {
        expect(
          ErrorMapper.map(_problem(status: 400, errorCode: entry.key)),
          entry.value,
          reason: entry.key,
        );
      }
    });
  });

  group('ErrorMapper · casos especiales del envelope', () {
    test('429 se detecta por status y lee retryAfterSeconds', () {
      // El objeto que arma RateLimitingPolicies no incluye errorCode.
      final error = ErrorMapper.map(
        _problem(
          status: 429,
          extra: const <String, dynamic>{'retryAfterSeconds': 45},
        ),
      );

      expect(
        error,
        isA<RateLimitedError>().having(
          (e) => e.retryAfterSeconds,
          'retryAfterSeconds',
          45,
        ),
      );
    });

    test('429 cae al header Retry-After si falta la extension', () {
      final error = ErrorMapper.map(
        _problem(
          status: 429,
          headers: <String, List<String>>{
            'retry-after': <String>['90'],
          },
        ),
      );

      expect(
        error,
        isA<RateLimitedError>().having(
          (e) => e.retryAfterSeconds,
          'retryAfterSeconds',
          90,
        ),
      );
    });

    test('423 parsea lockedUntil como UTC', () {
      final error = ErrorMapper.map(
        _problem(
          status: 423,
          errorCode: 'account_locked',
          extra: const <String, dynamic>{
            'lockedUntil': '2026-08-31T15:30:00Z',
          },
        ),
      );

      final locked = error as AccountLockedError;
      expect(locked.lockedUntil.isUtc, isTrue);
      expect(locked.lockedUntil, DateTime.utc(2026, 8, 31, 15, 30));
    });

    test('423 sin lockedUntil se degrada a la ventana de 15 minutos', () {
      final error = ErrorMapper.map(
        _problem(status: 423, errorCode: 'account_locked'),
      );

      expect(error, isA<AccountLockedError>());
      final locked = error as AccountLockedError;
      expect(locked.lockedUntil.isAfter(DateTime.now().toUtc()), isTrue);
    });

    test('400 de binding, sin errorCode, sigue siendo ValidationError', () {
      // Camino de [ApiController]: trae errors pero no errorCode.
      final error = ErrorMapper.map(
        _problem(
          status: 400,
          extra: const <String, dynamic>{
            'errors': <String, dynamic>{
              'password': <String>['The password field is required.'],
            },
          },
        ),
      );

      expect(error, isA<ValidationError>());
      final validation = error as ValidationError;
      expect(validation.errorCode, isNull);
      expect(validation.fieldErrors['password'], isNotEmpty);
    });

    test('errors con string suelto en vez de lista no rompe el parseo', () {
      final error = ErrorMapper.map(
        _problem(
          status: 400,
          extra: const <String, dynamic>{
            'errors': <String, dynamic>{'email': 'Formato invalido'},
          },
        ),
      );

      final validation = error as ValidationError;
      expect(validation.fieldErrors['email'], <String>['Formato invalido']);
    });
  });

  group('ErrorMapper · fallos de transporte', () {
    test('los timeouts y la caida de conexion son NetworkError', () {
      const transportTypes = <DioExceptionType>[
        DioExceptionType.connectionTimeout,
        DioExceptionType.sendTimeout,
        DioExceptionType.receiveTimeout,
        DioExceptionType.connectionError,
      ];

      for (final type in transportTypes) {
        final error = ErrorMapper.map(
          DioException(
            requestOptions: RequestOptions(path: '/api/v1/auth/login'),
            type: type,
          ),
        );
        expect(error, isA<NetworkError>(), reason: type.name);
      }
    });

    test('una respuesta ausente es NetworkError', () {
      final error = ErrorMapper.map(
        DioException(
          requestOptions: RequestOptions(path: '/api/v1/auth/login'),
          type: DioExceptionType.unknown,
        ),
      );

      expect(error, isA<NetworkError>());
    });

    test('un status no contemplado cae en UnknownError con el detalle', () {
      final error = ErrorMapper.map(
        _problem(status: 418, errorCode: 'im_a_teapot'),
      );

      expect(
        error,
        isA<UnknownError>()
            .having((e) => e.statusCode, 'statusCode', 418)
            .having((e) => e.errorCode, 'errorCode', 'im_a_teapot')
            .having((e) => e.detail, 'detail', 'Detalle de la excepcion'),
      );
    });
  });
}
