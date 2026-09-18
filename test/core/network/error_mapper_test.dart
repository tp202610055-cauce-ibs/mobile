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
        'patient_already_assigned': isA<PatientAlreadyAssignedError>(),
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

  group('ErrorMapper · nutritionist_not_available y su extension reason', () {
    NutritionistNotAvailableReason reasonOf(String? raw) {
      final error = ErrorMapper.map(
        _problem(
          status: 409,
          errorCode: 'nutritionist_not_available',
          extra: raw == null
              ? const <String, dynamic>{}
              : <String, dynamic>{'reason': raw},
        ),
      );
      expect(error, isA<NutritionistNotAvailableError>());
      return (error as NutritionistNotAvailableError).reason;
    }

    test('mapea los tres valores que declara el contrato', () {
      expect(
        reasonOf('pending_activation'),
        NutritionistNotAvailableReason.pendingActivation,
      );
      expect(reasonOf('inactive'), NutritionistNotAvailableReason.inactive);
      expect(reasonOf('suspended'), NutritionistNotAvailableReason.suspended);
    });

    test('un reason ausente degrada a inactive', () {
      // Se elige inactive y no pendingActivation porque su mensaje pide un
      // codigo nuevo, accion util en los tres estados. El de pendingActivation
      // invitaria a reintentar un codigo que quiza nunca funcione.
      expect(reasonOf(null), NutritionistNotAvailableReason.inactive);
    });

    test('un reason desconocido degrada a inactive', () {
      // Si el backend agrega un estado nuevo, el paciente ve un mensaje util
      // en vez del error generico.
      expect(reasonOf('deceased'), NutritionistNotAvailableReason.inactive);
      expect(reasonOf(''), NutritionistNotAvailableReason.inactive);
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

  group('ErrorMapper · perfil clinico y evaluaciones (Mobile-2)', () {
    test('patient_profile_not_found se tipa y no cae en unknown', () {
      // El repositorio lo traduce a null porque en el onboarding significa
      // "todavia no creo el perfil". Para eso necesita distinguirlo, que es
      // justo lo que este mapeo habilita.
      final error = ErrorMapper.map(
        _problem(status: 404, errorCode: 'patient_profile_not_found'),
      );

      expect(error, isA<PatientProfileNotFoundError>());
    });

    test('duplicate_patient_profile se tipa', () {
      final error = ErrorMapper.map(
        _problem(status: 409, errorCode: 'duplicate_patient_profile'),
      );

      expect(error, isA<DuplicateProfileError>());
    });

    test('invalid_biometric_value se tipa aunque no traiga errors', () {
      // Lo emite la entidad de dominio del backend, no FluentValidation, asi
      // que no hay diccionario por campo: solo prosa en detail. El tipo propio
      // es lo unico que permite dar un mensaje util.
      final error = ErrorMapper.map(
        _problem(status: 400, errorCode: 'invalid_biometric_value'),
      );

      // No es un ValidationError: no hay campo al que colgar el mensaje.
      expect(error, isA<InvalidBiometricValueError>());
      expect(error, isNot(isA<ValidationError>()));
    });

    test('allergy_not_found se tipa', () {
      final error = ErrorMapper.map(
        _problem(status: 404, errorCode: 'allergy_not_found'),
      );

      expect(error, isA<AllergyNotFoundError>());
    });

    test('duplicate_patient_allergy se tipa', () {
      final error = ErrorMapper.map(
        _problem(status: 409, errorCode: 'duplicate_patient_allergy'),
      );

      expect(error, isA<DuplicateAllergyError>());
    });

    test('invalid_ibs_sss_dimension se tipa', () {
      final error = ErrorMapper.map(
        _problem(status: 400, errorCode: 'invalid_ibs_sss_dimension'),
      );

      expect(error, isA<InvalidIbsSssDimensionError>());
    });

    test('duplicate_baseline_assessment se tipa', () {
      final error = ErrorMapper.map(
        _problem(status: 409, errorCode: 'duplicate_baseline_assessment'),
      );

      expect(error, isA<DuplicateBaselineAssessmentError>());
    });

    test('los dos 404 del modulo no se confunden entre si', () {
      // Comparten status y solo los separa el errorCode. Confundirlos mandaria
      // al paciente a rehacer el perfil por una alergia desactivada.
      final profile = ErrorMapper.map(
        _problem(status: 404, errorCode: 'patient_profile_not_found'),
      );
      final allergy = ErrorMapper.map(
        _problem(status: 404, errorCode: 'allergy_not_found'),
      );

      expect(profile, isA<PatientProfileNotFoundError>());
      expect(allergy, isA<AllergyNotFoundError>());
      expect(profile, isNot(equals(allergy)));
    });
  });

  group('ErrorMapper · registro clinico diario (Mobile-3)', () {
    test('mapea los trece codigos sin extension', () {
      final cases = <String, ({int status, Matcher matcher})>{
        'food_item_not_found': (
          status: 404,
          matcher: isA<FoodItemNotFoundError>()
        ),
        'custom_food_not_found': (
          status: 404,
          matcher: isA<CustomFoodNotFoundError>()
        ),
        'duplicate_custom_food': (
          status: 409,
          matcher: isA<DuplicateCustomFoodError>()
        ),
        'custom_food_in_use': (
          status: 409,
          matcher: isA<CustomFoodInUseError>()
        ),
        'duplicate_ingredient': (
          status: 409,
          matcher: isA<DuplicateIngredientError>()
        ),
        'ingredient_not_found': (
          status: 404,
          matcher: isA<IngredientNotFoundError>()
        ),
        'invalid_meal_registration': (
          status: 400,
          matcher: isA<InvalidMealRegistrationError>()
        ),
        'meal_not_found': (status: 404, matcher: isA<MealNotFoundError>()),
        'symptom_not_found': (
          status: 404,
          matcher: isA<SymptomNotFoundError>()
        ),
        'clinical_note_not_found': (
          status: 404,
          matcher: isA<ClinicalNoteNotFoundError>()
        ),
        'invalid_clinical_note_association': (
          status: 400,
          matcher: isA<InvalidClinicalNoteAssociationError>()
        ),
        'idempotency_mismatch': (
          status: 409,
          matcher: isA<IdempotencyMismatchError>()
        ),
        'domain_rule_violation': (
          status: 400,
          matcher: isA<DomainRuleViolationError>()
        ),
      };

      for (final entry in cases.entries) {
        final error = ErrorMapper.map(
          _problem(status: entry.value.status, errorCode: entry.key),
        );

        expect(error, entry.value.matcher, reason: entry.key);
      }
    });

    test('los cinco 404 del modulo no se confunden entre si', () {
      // Comparten status y solo los separa el errorCode. Confundir el del
      // alimento con el de la comida mandaria al paciente a rehacer un
      // registro que si existe.
      final errors = <String>[
        'food_item_not_found',
        'custom_food_not_found',
        'ingredient_not_found',
        'meal_not_found',
        'symptom_not_found',
      ].map((code) => ErrorMapper.map(_problem(status: 404, errorCode: code)));

      expect(errors.toSet(), hasLength(5));
    });

    test('domain_rule_violation conserva el detail del servidor', () {
      final error = ErrorMapper.map(
        _problem(status: 400, errorCode: 'domain_rule_violation'),
      );

      expect(error, isA<DomainRuleViolationError>());
      expect(
        (error as DomainRuleViolationError).detail,
        'Detalle de la excepcion',
      );
    });

    test('unconfirmed_allergens parsea la extension allergens', () {
      final error = ErrorMapper.map(
        _problem(
          status: 409,
          errorCode: 'unconfirmed_allergens',
          extra: <String, dynamic>{
            'detected': true,
            'allergens': <dynamic>[
              <String, dynamic>{
                'ingredientName': 'Leche entera de vaca',
                'allergenName': 'Lactosa',
                'severity': 'Severe',
              },
              <String, dynamic>{
                'ingredientName': 'Pan de trigo blanco',
                'allergenName': 'Gluten',
                'severity': 'Moderate',
              },
              <String, dynamic>{
                'ingredientName': 'Queso fresco',
                'allergenName': 'Lactosa',
                'severity': 'Mild',
              },
            ],
          },
        ),
      );

      expect(error, isA<UnconfirmedAllergensError>());
      final allergens = (error as UnconfirmedAllergensError).allergens;
      expect(allergens, hasLength(3));
      expect(allergens.first.ingredientName, 'Leche entera de vaca');
      expect(allergens.first.allergenName, 'Lactosa');
      expect(allergens.first.severity, DetectedAllergenSeverity.severe);
      expect(allergens[1].severity, DetectedAllergenSeverity.moderate);
      expect(allergens[2].severity, DetectedAllergenSeverity.mild);
    });

    test('una severidad desconocida deja null y conserva la entrada', () {
      // El paciente tiene que enterarse de la coincidencia igual. Degradarla a
      // un valor concreto le atribuiria al servidor una severidad que no dijo,
      // y descartar la entrada escondria un alergeno detectado.
      final error = ErrorMapper.map(
        _problem(
          status: 409,
          errorCode: 'unconfirmed_allergens',
          extra: <String, dynamic>{
            'allergens': <dynamic>[
              <String, dynamic>{
                'ingredientName': 'Lentejas cocidas',
                'allergenName': 'Legumbres',
                'severity': 'Critical',
              },
              <String, dynamic>{
                'ingredientName': 'Cebolla cocida',
                'allergenName': 'Fructanos',
              },
            ],
          },
        ),
      );

      final allergens = (error as UnconfirmedAllergensError).allergens;
      expect(allergens, hasLength(2));
      expect(allergens.every((a) => a.severity == null), isTrue);
      expect(allergens.first.allergenName, 'Legumbres');
    });

    test('descarta las entradas sin ingrediente o sin alergeno', () {
      // Sin los dos nombres no hay advertencia que mostrar.
      final error = ErrorMapper.map(
        _problem(
          status: 409,
          errorCode: 'unconfirmed_allergens',
          extra: <String, dynamic>{
            'allergens': <dynamic>[
              <String, dynamic>{'allergenName': 'Lactosa', 'severity': 'Mild'},
              <String, dynamic>{'ingredientName': 'Queso fresco'},
              'no soy un objeto',
              <String, dynamic>{
                'ingredientName': 'Leche entera de vaca',
                'allergenName': 'Lactosa',
                'severity': 'Severe',
              },
            ],
          },
        ),
      );

      final allergens = (error as UnconfirmedAllergensError).allergens;
      expect(allergens, hasLength(1));
      expect(allergens.single.ingredientName, 'Leche entera de vaca');
    });

    test('sin la extension allergens el error se tipa igual, con lista vacia',
        () {
      // El 409 ya dice por si solo que hay coincidencias: degradarlo a
      // UnknownError dejaria al paciente sin el flujo de confirmacion.
      final ausente = ErrorMapper.map(
        _problem(status: 409, errorCode: 'unconfirmed_allergens'),
      );
      final malformada = ErrorMapper.map(
        _problem(
          status: 409,
          errorCode: 'unconfirmed_allergens',
          extra: <String, dynamic>{'allergens': 'no soy una lista'},
        ),
      );

      expect(ausente, isA<UnconfirmedAllergensError>());
      expect((ausente as UnconfirmedAllergensError).allergens, isEmpty);
      expect(malformada, isA<UnconfirmedAllergensError>());
      expect((malformada as UnconfirmedAllergensError).allergens, isEmpty);
    });
  });
}
