import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/domain/allergy.dart';
import 'package:cauce_mobile/features/patients/domain/patient_profile.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';

/// Arma el repositorio sobre el cliente OpenAPI real, con la red sustituida.
///
/// Igual que el harness de `AuthRepository`: ejercita el camino completo,
/// serializacion `built_value`, ruta generada, deserializacion y traduccion de
/// errores, que es donde se detecta que el contrato y el cliente dejaron de
/// coincidir.
({PatientsRepository repository, CannedHttpAdapter adapter}) _harness([
  CannedResponse? response,
]) {
  final adapter = CannedHttpAdapter(
    response ?? const CannedResponse.noContent(),
  );
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(dio: dio, interceptors: const <Interceptor>[]);
  return (
    repository: PatientsRepository(
      client.getPatientsApi(),
      client.getAllergiesApi(),
    ),
    adapter: adapter,
  );
}

const Map<String, dynamic> _assignmentJson = <String, dynamic>{
  'nutritionistId': 'c1d2e3f4-5a6b-7c8d-9e0f-1a2b3c4d5e6f',
  'nutritionistFullName': 'Ana Quispe',
  'assignedAt': '2026-09-12T14:05:00Z',
};

/// Canjea y devuelve el error tipado, para los casos que deben fallar.
Future<CauceApiError> _failWith(CannedResponse response) async {
  final h = _harness(response);
  try {
    await h.repository.assignNutritionist(invitationCode: 'ABCD1234');
    fail('Se esperaba un CauceApiError y el canje prospero.');
  } on CauceApiError catch (error) {
    return error;
  }
}

void main() {
  group('PatientsRepository · canje de codigo (US20 CA02)', () {
    test('traduce el 201 a NutritionistAssignment', () async {
      final h = _harness(const CannedResponse.created(_assignmentJson));

      final assignment = await h.repository.assignNutritionist(
        invitationCode: 'ABCD1234',
      );

      expect(
        assignment.nutritionistId,
        'c1d2e3f4-5a6b-7c8d-9e0f-1a2b3c4d5e6f',
      );
      expect(assignment.nutritionistFullName, 'Ana Quispe');
      expect(assignment.assignedAt, DateTime.utc(2026, 9, 12, 14, 5));
      expect(assignment.assignedAt.isUtc, isTrue);
    });

    test('pega en la ruta del contrato y manda el codigo tal cual', () async {
      // La normalizacion a mayusculas la hace el backend. Duplicarla aca
      // esconderia una desalineacion si esa regla cambiara.
      final h = _harness(const CannedResponse.created(_assignmentJson));

      await h.repository.assignNutritionist(invitationCode: ' abcd1234 ');

      expect(
        h.adapter.lastRequest.path,
        '/api/v1/patients/me/nutritionist-assignment',
      );
      expect(h.adapter.lastRequest.method, 'POST');
      expect(h.adapter.lastRequest.body['invitationCode'], ' abcd1234 ');
    });

    test('un 201 sin nutritionistId no pasa por valido', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{
          'nutritionistFullName': 'Ana Quispe',
        }),
      );

      await expectLater(
        h.repository.assignNutritionist(invitationCode: 'ABCD1234'),
        throwsA(isA<UnknownError>()),
      );
    });

    test('un 201 sin el nombre igual vincula, con el nombre vacio', () async {
      // La vinculacion ya ocurrio: invalidarla por un campo que solo alimenta
      // el mensaje de confirmacion dejaria al paciente creyendo que fallo.
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{
          'nutritionistId': 'c1d2e3f4-5a6b-7c8d-9e0f-1a2b3c4d5e6f',
          'assignedAt': '2026-09-12T14:05:00Z',
        }),
      );

      final assignment = await h.repository.assignNutritionist(
        invitationCode: 'ABCD1234',
      );

      expect(assignment.nutritionistFullName, isEmpty);
    });
  });

  group('PatientsRepository · codigo que no cumple el formato', () {
    test('un codigo vacio cae en el 400 del backend', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 400,
          errorCode: 'validation_error',
          extra: const <String, dynamic>{
            'errors': <String, dynamic>{
              'invitationCode': <String>[
                "'Invitation Code' no puede estar vacio.",
              ],
            },
          },
        ),
      );

      try {
        await h.repository.assignNutritionist(invitationCode: '');
        fail('Se esperaba un ValidationError.');
      } on CauceApiError catch (error) {
        expect(error, isA<ValidationError>());
        expect(
          (error as ValidationError).fieldErrors['invitationCode'],
          hasLength(1),
        );
      }
      expect(h.adapter.lastRequest.body['invitationCode'], '');
    });

    test('un codigo de solo espacios tambien viaja al backend', () async {
      // El repositorio no filtra: la regla de longitud y formato vive en un
      // solo lugar, el validador del servidor.
      final h = _harness(
        CannedResponse.problem(
          statusCode: 400,
          errorCode: 'validation_error',
          extra: const <String, dynamic>{
            'errors': <String, dynamic>{
              'invitationCode': <String>['Longitud invalida.'],
            },
          },
        ),
      );

      await expectLater(
        h.repository.assignNutritionist(invitationCode: '   '),
        throwsA(isA<ValidationError>()),
      );
      expect(h.adapter.lastRequest.body['invitationCode'], '   ');
    });

    test('los tres rechazos del codigo llegan tipados', () async {
      const cases = <String, InvitationCodeReason>{
        'invalid_invitation_code': InvitationCodeReason.invalid,
        'expired_invitation_code': InvitationCodeReason.expired,
        'invitation_code_already_used': InvitationCodeReason.alreadyUsed,
      };

      for (final entry in cases.entries) {
        final error = await _failWith(
          CannedResponse.problem(statusCode: 400, errorCode: entry.key),
        );
        expect(error, isA<InvitationCodeError>(), reason: entry.key);
        expect(
          (error as InvitationCodeError).reason,
          entry.value,
          reason: entry.key,
        );
      }
    });
  });

  group('PatientsRepository · conflictos 409', () {
    test('nutritionist_not_available trae los tres reason', () async {
      const cases = <String, NutritionistNotAvailableReason>{
        'pending_activation': NutritionistNotAvailableReason.pendingActivation,
        'inactive': NutritionistNotAvailableReason.inactive,
        'suspended': NutritionistNotAvailableReason.suspended,
      };

      for (final entry in cases.entries) {
        final error = await _failWith(
          CannedResponse.problem(
            statusCode: 409,
            errorCode: 'nutritionist_not_available',
            extra: <String, dynamic>{'reason': entry.key},
          ),
        );
        expect(
          error,
          isA<NutritionistNotAvailableError>(),
          reason: entry.key,
        );
        expect(
          (error as NutritionistNotAvailableError).reason,
          entry.value,
          reason: entry.key,
        );
      }
    });

    test('nutritionist_not_available sin reason degrada a inactive', () async {
      final error = await _failWith(
        CannedResponse.problem(
          statusCode: 409,
          errorCode: 'nutritionist_not_available',
        ),
      );

      expect(
        (error as NutritionistNotAvailableError).reason,
        NutritionistNotAvailableReason.inactive,
      );
    });

    test('patient_already_assigned llega tipado', () async {
      // El backend no sobrescribe la asignacion vigente: cambiar de
      // nutricionista es una decision clinica.
      final error = await _failWith(
        CannedResponse.problem(
          statusCode: 409,
          errorCode: 'patient_already_assigned',
        ),
      );

      expect(error, isA<PatientAlreadyAssignedError>());
    });
  });

  group('PatientsRepository · autorizacion y limites', () {
    test('un 401 sin errorCode no se confunde con un error de dominio',
        () async {
      final error = await _failWith(
        const CannedResponse(statusCode: 401),
      );

      expect(error, isA<UnknownError>());
      expect((error as UnknownError).statusCode, 401);
    });

    test('un 403 forbidden llega tipado', () async {
      // Token valido que no es de un paciente.
      final error = await _failWith(
        CannedResponse.problem(statusCode: 403, errorCode: 'forbidden'),
      );

      expect(error, isA<ForbiddenError>());
    });

    test('un 429 se detecta por status y expone la espera', () async {
      final error = await _failWith(
        CannedResponse.problem(
          statusCode: 429,
          extra: const <String, dynamic>{'retryAfterSeconds': 30},
        ),
      );

      expect(error, isA<RateLimitedError>());
      expect((error as RateLimitedError).retryAfterSeconds, 30);
    });
  });

  group('PatientsRepository · perfil clinico (US03)', () {
    test('un 404 patient_profile_not_found devuelve null, no un error',
        () async {
      // En el onboarding el 404 no es una falla: es el estado "todavia no lo
      // creo". Propagarlo obligaria a cada consumidor a desempaquetar un
      // CauceApiError para distinguir "no existe" de "no se pudo consultar".
      final h = _harness(
        CannedResponse.problem(
          statusCode: 404,
          errorCode: 'patient_profile_not_found',
        ),
      );

      expect(await h.repository.fetchProfile(), isNull);
    });

    test('un 500 al leer el perfil si se propaga', () async {
      // Distinguirlo del 404 importa: sin perfil el wizard arranca, pero ante
      // un 500 no se sabe nada y forzar el paso 1 podria duplicar el perfil.
      final h = _harness(
        CannedResponse.problem(statusCode: 500, errorCode: 'internal_error'),
      );

      await expectLater(
        h.repository.fetchProfile(),
        throwsA(isA<CauceApiError>()),
      );
    });

    test('traduce el perfil completo del backend', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'profileId': 'a1b2c3d4-0000-4000-8000-000000000001',
          'userId': '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
          'dateOfBirth': '1990-05-15',
          'biologicalSex': 'Female',
          'weightKg': 62.5,
          'heightCm': 162.0,
          'bmi': 23.81,
          'bmiCategory': 'normal',
          'age': 36,
          'ibsSubtype': 'IbsD',
          'diagnosisDate': '2024-09-15',
          'medications': null,
          'onboardingCompleted': true,
          'allergies': <Map<String, dynamic>>[],
        }),
      );

      final profile = await h.repository.fetchProfile();

      expect(profile, isNotNull);
      expect(profile!.onboardingCompleted, isTrue);
      expect(profile.biologicalSex, BiologicalSexOption.female);
      expect(profile.ibsSubtype, IbsSubtypeOption.ibsD);
      expect(profile.bmiCategory, BmiCategory.normal);
      expect(profile.dateOfBirth, DateTime(1990, 5, 15));
      expect(profile.diagnosisDate, DateTime(2024, 9, 15));
      expect(profile.age, 36);
    });

    test('onboardingCompleted en false es el disparador del paso 2', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'profileId': 'a1b2c3d4-0000-4000-8000-000000000001',
          'dateOfBirth': '1990-05-15',
          'weightKg': 62.5,
          'heightCm': 162.0,
          'bmi': 23.81,
          'age': 36,
          'onboardingCompleted': false,
        }),
      );

      final profile = await h.repository.fetchProfile();

      expect(profile!.onboardingCompleted, isFalse);
    });

    test('un perfil sin campos obligatorios no se acepta a medias', () async {
      // Un perfil incompleto alimentaria el guard con datos inventados.
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'profileId': 'a1b2c3d4-0000-4000-8000-000000000001',
        }),
      );

      await expectLater(
        h.repository.fetchProfile(),
        throwsA(isA<UnknownError>()),
      );
    });

    test('crea el perfil en la ruta del contrato y con los enums PascalCase',
        () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{
          'profileId': 'a1b2c3d4-0000-4000-8000-000000000001',
          'bmi': 23.81,
          'bmiCategory': 'normal',
          'age': 36,
          'nutritionistAssigned': true,
        }),
      );

      final result = await h.repository.createProfile(
        PatientProfileDraft(
          dateOfBirth: DateTime(1990, 5, 15),
          biologicalSex: BiologicalSexOption.female,
          weightKg: 62.5,
          heightCm: 162,
          ibsSubtype: IbsSubtypeOption.ibsD,
          diagnosisDate: DateTime(2024, 9, 15),
          medications: '  Trimebutina  ',
        ),
      );

      expect(result.profileId, 'a1b2c3d4-0000-4000-8000-000000000001');
      expect(result.bmi, 23.81);
      expect(result.bmiCategory, BmiCategory.normal);
      expect(result.nutritionistAssigned, isTrue);

      final request = h.adapter.lastRequest;
      expect(request.method, 'POST');
      expect(request.path, endsWith('/api/v1/patients/profile'));
      // Enums en PascalCase, nunca snake_case.
      expect(request.body['biologicalSex'], 'Female');
      expect(request.body['ibsSubtype'], 'IbsD');
      // Fechas sin hora: el contrato las declara `format: date`.
      expect(request.body['dateOfBirth'], '1990-05-15');
      expect(request.body['diagnosisDate'], '2024-09-15');
      // El texto opcional viaja recortado.
      expect(request.body['medications'], 'Trimebutina');
    });

    test('los opcionales vacios viajan como null, no como cadena vacia',
        () async {
      // Persistir una cadena vacia dejaria el campo presente y en blanco, que
      // en una historia clinica no es lo mismo que ausente.
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{
          'profileId': 'a1b2c3d4-0000-4000-8000-000000000001',
          'bmi': 23.81,
          'age': 36,
        }),
      );

      await h.repository.createProfile(
        PatientProfileDraft(
          dateOfBirth: DateTime(1990, 5, 15),
          biologicalSex: BiologicalSexOption.male,
          weightKg: 70,
          heightCm: 175,
          ibsSubtype: IbsSubtypeOption.ibsM,
          medications: '   ',
        ),
      );

      expect(h.adapter.lastRequest.body['medications'], isNull);
      expect(h.adapter.lastRequest.body['diagnosisDate'], isNull);
    });

    test('un 409 al crear el perfil se tipa como duplicado', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 409,
          errorCode: 'duplicate_patient_profile',
        ),
      );

      await expectLater(
        h.repository.createProfile(
          PatientProfileDraft(
            dateOfBirth: DateTime(1990, 5, 15),
            biologicalSex: BiologicalSexOption.female,
            weightKg: 62.5,
            heightCm: 162,
            ibsSubtype: IbsSubtypeOption.ibsD,
          ),
        ),
        throwsA(isA<DuplicateProfileError>()),
      );
    });
  });

  group('PatientsRepository · alergias (US03)', () {
    test('lee el catalogo desde la ruta transversal /allergies', () async {
      final h = _harness(
        const CannedListResponse(<Map<String, dynamic>>[
          <String, dynamic>{
            'allergyId': 'aaaaaaaa-0000-4000-8000-000000000001',
            'name': 'Gluten',
            'allergyType': 'Intolerance',
            'description': 'Intolerancia a la proteina del trigo.',
          },
          <String, dynamic>{
            'allergyId': 'aaaaaaaa-0000-4000-8000-000000000002',
            'name': 'Mariscos',
            'allergyType': 'Allergy',
            'description': null,
          },
        ]),
      );

      final catalog = await h.repository.allergyCatalog();

      expect(catalog, hasLength(2));
      expect(catalog.first.name, 'Gluten');
      expect(catalog.first.type, AllergyTypeOption.intolerance);
      expect(catalog.last.type, AllergyTypeOption.allergy);
      // No cuelga de /patients: el backend lo expone a cualquier autenticado.
      expect(h.adapter.lastRequest.path, endsWith('/api/v1/allergies'));
    });

    test('una entrada corrupta se descarta sin tumbar el catalogo', () async {
      // Un formulario que no abre es peor que un catalogo con una opcion
      // menos.
      final h = _harness(
        const CannedListResponse(<Map<String, dynamic>>[
          <String, dynamic>{'allergyId': null, 'name': 'Sin id'},
          <String, dynamic>{
            'allergyId': 'aaaaaaaa-0000-4000-8000-000000000003',
            'name': '',
          },
          <String, dynamic>{
            'allergyId': 'aaaaaaaa-0000-4000-8000-000000000004',
            'name': 'Lactosa',
            'allergyType': 'Intolerance',
          },
        ]),
      );

      final catalog = await h.repository.allergyCatalog();

      expect(catalog, hasLength(1));
      expect(catalog.single.name, 'Lactosa');
    });

    test('declara una alergia con severidad en PascalCase', () async {
      final h = _harness(
        const CannedResponse.created(<String, dynamic>{
          'patientAllergyId': 'bbbbbbbb-0000-4000-8000-000000000001',
        }),
      );

      final id = await h.repository.declareAllergy(
        const AllergyDeclarationDraft(
          allergyId: 'aaaaaaaa-0000-4000-8000-000000000001',
          severity: AllergySeverityLevel.moderate,
          notes: '  Malestar tras el pan  ',
        ),
      );

      expect(id, 'bbbbbbbb-0000-4000-8000-000000000001');

      final request = h.adapter.lastRequest;
      expect(request.method, 'POST');
      expect(request.path, endsWith('/api/v1/patients/allergies'));
      expect(request.body['severity'], 'Moderate');
      expect(request.body['notes'], 'Malestar tras el pan');
    });

    test('un 409 al declarar se tipa como alergia duplicada', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 409,
          errorCode: 'duplicate_patient_allergy',
        ),
      );

      await expectLater(
        h.repository.declareAllergy(
          const AllergyDeclarationDraft(
            allergyId: 'aaaaaaaa-0000-4000-8000-000000000001',
            severity: AllergySeverityLevel.mild,
          ),
        ),
        throwsA(isA<DuplicateAllergyError>()),
      );
    });

    test('un 404 al declarar se tipa como alergia inexistente', () async {
      final h = _harness(
        CannedResponse.problem(statusCode: 404, errorCode: 'allergy_not_found'),
      );

      await expectLater(
        h.repository.declareAllergy(
          const AllergyDeclarationDraft(
            allergyId: 'aaaaaaaa-0000-4000-8000-000000000009',
            severity: AllergySeverityLevel.severe,
          ),
        ),
        throwsA(isA<AllergyNotFoundError>()),
      );
    });
  });

  group('PatientsRepository · comprobante del consentimiento (CP004)', () {
    test('traduce el PDF y lee el nombre de Content-Disposition', () async {
      final h = _harness(
        const CannedResponse(
          statusCode: 200,
          body: <String, dynamic>{},
          headers: <String, List<String>>{
            'content-disposition': <String>[
              'attachment; filename="consentimiento-1.0.pdf"',
            ],
          },
        ),
      );

      final pdf = await h.repository.consentPdf();

      // El nombre lleva la version aceptada, que es lo que permite al paciente
      // distinguir cual documento firmo si alguna vez hay mas de uno.
      expect(pdf.fileName, 'consentimiento-1.0.pdf');
      expect(h.adapter.lastRequest.method, 'GET');
      expect(
        h.adapter.lastRequest.path,
        endsWith('/api/v1/patients/me/consent/pdf'),
      );
    });

    test('sin Content-Disposition cae a un nombre generico', () async {
      // El PDF ya esta descargado: negarselo al paciente por un header
      // ausente seria peor que darle un nombre menos preciso.
      final h = _harness(
        const CannedResponse(statusCode: 200, body: <String, dynamic>{}),
      );

      final pdf = await h.repository.consentPdf();

      expect(pdf.fileName, 'consentimiento.pdf');
    });

    test('un 404 se tipa como consentimiento no encontrado', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 404,
          errorCode: 'consent_record_not_found',
        ),
      );

      await expectLater(
        h.repository.consentPdf(),
        throwsA(isA<ConsentRecordNotFoundError>()),
      );
    });

    test('un 401 se propaga sin confundirse con el 404', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 401,
          errorCode: 'invalid_credentials',
        ),
      );

      await expectLater(
        h.repository.consentPdf(),
        throwsA(isA<InvalidCredentialsError>()),
      );
    });
  });
}
