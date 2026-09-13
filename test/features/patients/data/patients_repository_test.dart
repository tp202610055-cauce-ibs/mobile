import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
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
    repository: PatientsRepository(client.getPatientsApi()),
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
}
