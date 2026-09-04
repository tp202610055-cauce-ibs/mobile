import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:cauce_mobile/core/config/env.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/canned_http_adapter.dart';

/// Arma el repositorio sobre el cliente OpenAPI real, con la red sustituida.
///
/// A diferencia de los tests de notifier, que usan un doble del repositorio,
/// estos ejercitan el camino completo: serializacion `built_value`, rutas
/// generadas, deserializacion y traduccion de errores. Es donde se detecta que
/// el contrato y el cliente dejaron de coincidir.
({AuthRepository repository, CannedHttpAdapter adapter}) _harness([
  CannedResponse? response,
]) {
  final adapter = CannedHttpAdapter(
    response ?? const CannedResponse.noContent(),
  );
  final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
    ..httpClientAdapter = adapter;
  final client = CauceApiClient(
    dio: dio,
    interceptors: const <Interceptor>[],
  );
  return (
    repository: AuthRepository(client.getAuthApi(), client.getConsentApi()),
    adapter: adapter,
  );
}

const Map<String, dynamic> _userJson = <String, dynamic>{
  'userId': '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  'keycloakId': 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  'email': 'paciente.demo@cauce.local',
  'role': 'patient',
  'fullName': 'Paciente Demo',
  'emailVerified': true,
  'isInActivePilot': true,
};

const Map<String, dynamic> _loginJson = <String, dynamic>{
  'accessToken': 'access-1',
  'refreshToken': 'refresh-1',
  'expiresIn': 900,
  'refreshExpiresIn': 2591999,
  'tokenType': 'Bearer',
  'user': _userJson,
};

void main() {
  setUp(() {
    Env.loadForTesting(const <String, String>{
      'API_BASE_URL': 'http://localhost:5074',
      'ENV_NAME': 'dev',
      'CLIENT_ID': 'cauce-mobile',
      'DEEP_LINK_SCHEME': 'cauce',
    });
  });
  tearDown(Env.reset);

  group('AuthRepository · login', () {
    test('traduce la respuesta completa a LoginSession', () async {
      final h = _harness(const CannedResponse.ok(_loginJson));

      final session = await h.repository.login(
        email: 'paciente.demo@cauce.local',
        password: 'Paciente.Demo2026!',
      );

      expect(session.accessToken, 'access-1');
      expect(session.refreshToken, 'refresh-1');
      expect(session.user.email, 'paciente.demo@cauce.local');
      expect(session.user.keycloakId, 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd');
      expect(session.user.emailVerified, isTrue);
    });

    test('envia el clientId que exige el contrato', () async {
      final h = _harness(const CannedResponse.ok(_loginJson));

      await h.repository.login(email: 'a@b.co', password: 'x');

      expect(h.adapter.lastRequest.path, '/api/v1/auth/login');
      expect(h.adapter.lastRequest.method, 'POST');
      expect(h.adapter.lastRequest.body['clientId'], 'cauce-mobile');
      expect(h.adapter.lastRequest.body['email'], 'a@b.co');
    });

    test('un 200 sin el objeto user no pasa por valido', () async {
      // Una respuesta exitosa que no sirve. Sin este control, el fallo
      // aparecería mas tarde como una sesion corrupta en el Keystore.
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'accessToken': 'access-1',
          'refreshToken': 'refresh-1',
        }),
      );

      await expectLater(
        h.repository.login(email: 'a@b.co', password: 'x'),
        throwsA(isA<UnknownError>()),
      );
    });

    test('un 401 se traduce a credenciales invalidas', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 401,
          errorCode: 'invalid_credentials',
        ),
      );

      await expectLater(
        h.repository.login(email: 'a@b.co', password: 'mala'),
        throwsA(isA<InvalidCredentialsError>()),
      );
    });

    test('un 423 conserva lockedUntil', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 423,
          errorCode: 'account_locked',
          extra: const <String, dynamic>{
            'lockedUntil': '2026-09-03T18:30:00Z',
          },
        ),
      );

      await expectLater(
        h.repository.login(email: 'a@b.co', password: 'mala'),
        throwsA(
          isA<AccountLockedError>().having(
            (e) => e.lockedUntil,
            'lockedUntil',
            DateTime.utc(2026, 9, 3, 18, 30),
          ),
        ),
      );
    });

    test('un 429 conserva la espera', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 429,
          extra: const <String, dynamic>{'retryAfterSeconds': 45},
        ),
      );

      await expectLater(
        h.repository.login(email: 'a@b.co', password: 'x'),
        throwsA(
          isA<RateLimitedError>().having(
            (e) => e.retryAfterSeconds,
            'retryAfterSeconds',
            45,
          ),
        ),
      );
    });
  });

  group('AuthRepository · consentimiento vigente', () {
    test('traduce version, texto y hash', () async {
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'version': '1.2.0',
          'text': 'Texto del consentimiento informado.',
          'hash': 'sha256:abc123',
        }),
      );

      final consent = await h.repository.currentConsent();

      expect(consent.version, '1.2.0');
      expect(consent.text, 'Texto del consentimiento informado.');
      expect(consent.hash, 'sha256:abc123');
      expect(h.adapter.lastRequest.path, '/api/v1/consent/current');
    });

    test('un consentimiento incompleto no pasa por valido', () async {
      // Sin hash, el registro fallaria con consent_text_mismatch mas adelante.
      final h = _harness(
        const CannedResponse.ok(<String, dynamic>{
          'version': '1.2.0',
          'text': 'Texto.',
        }),
      );

      await expectLater(
        h.repository.currentConsent(),
        throwsA(isA<UnknownError>()),
      );
    });
  });

  group('AuthRepository · registro', () {
    const Map<String, dynamic> registerJson = <String, dynamic>{
      'userId': 'e1f2a3b4-0000-0000-0000-000000000000',
      'email': 'nuevo@cauce.local',
      // Valor real del enum UserStatus del contrato. Uno desconocido hace
      // fallar la deserializacion del objeto entero, no solo del campo.
      'status': 'PendingActivation',
      'emailVerificationRequired': true,
    };

    test('envia los seis campos del contrato', () async {
      final h = _harness(const CannedResponse.created(registerJson));

      await h.repository.register(
        email: 'nuevo@cauce.local',
        fullName: 'Paciente Nuevo',
        password: 'ClaveSegura1',
        consentDocumentVersion: '1.2.0',
        consentTextHash: 'sha256:abc123',
        invitationCode: 'KAELIN26',
      );

      final body = h.adapter.lastRequest.body;
      expect(h.adapter.lastRequest.path, '/api/v1/auth/register');
      expect(body['email'], 'nuevo@cauce.local');
      expect(body['fullName'], 'Paciente Nuevo');
      expect(body['consentDocumentVersion'], '1.2.0');
      expect(body['consentTextHash'], 'sha256:abc123');
      expect(body['invitationCode'], 'KAELIN26');
    });

    test('omite el codigo de invitacion cuando esta vacio', () async {
      // Mandar cadena vacia haria que el backend la valide como codigo y
      // responda 400, cuando el campo es opcional.
      final h = _harness(const CannedResponse.created(registerJson));

      await h.repository.register(
        email: 'nuevo@cauce.local',
        fullName: 'Paciente Nuevo',
        password: 'ClaveSegura1',
        consentDocumentVersion: '1.2.0',
        consentTextHash: 'sha256:abc',
        invitationCode: '',
      );

      expect(
        h.adapter.lastRequest.body.containsKey('invitationCode'),
        isFalse,
      );
    });

    test('omite el codigo tambien cuando es nulo', () async {
      final h = _harness(const CannedResponse.created(registerJson));

      await h.repository.register(
        email: 'nuevo@cauce.local',
        fullName: 'Paciente Nuevo',
        password: 'ClaveSegura1',
        consentDocumentVersion: '1.2.0',
        consentTextHash: 'sha256:abc',
      );

      expect(
        h.adapter.lastRequest.body.containsKey('invitationCode'),
        isFalse,
      );
    });

    test('traduce el 201 a RegistrationResult', () async {
      final h = _harness(const CannedResponse.created(registerJson));

      final result = await h.repository.register(
        email: 'nuevo@cauce.local',
        fullName: 'Paciente Nuevo',
        password: 'ClaveSegura1',
        consentDocumentVersion: '1.2.0',
        consentTextHash: 'sha256:abc',
      );

      expect(result.userId, 'e1f2a3b4-0000-0000-0000-000000000000');
      expect(result.email, 'nuevo@cauce.local');
      expect(result.emailVerificationRequired, isTrue);
    });

    test('un 409 se traduce a correo duplicado', () async {
      final h = _harness(
        CannedResponse.problem(statusCode: 409, errorCode: 'duplicate_email'),
      );

      await expectLater(
        h.repository.register(
          email: 'existente@cauce.local',
          fullName: 'Paciente',
          password: 'ClaveSegura1',
          consentDocumentVersion: '1.2.0',
          consentTextHash: 'sha256:abc',
        ),
        throwsA(isA<DuplicateEmailError>()),
      );
    });

    test('un 400 de validacion expone los campos en camelCase', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 400,
          errorCode: 'validation_error',
          extra: const <String, dynamic>{
            'errors': <String, dynamic>{
              'password': <String>['La contrasena debe contener un digito.'],
            },
          },
        ),
      );

      await expectLater(
        h.repository.register(
          email: 'nuevo@cauce.local',
          fullName: 'Paciente',
          password: 'debil',
          consentDocumentVersion: '1.2.0',
          consentTextHash: 'sha256:abc',
        ),
        throwsA(
          isA<ValidationError>().having(
            (e) => e.fieldErrors['password'],
            'password',
            isNotEmpty,
          ),
        ),
      );
    });

    test('un 502 se traduce a fallo de Keycloak', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 502,
          errorCode: 'keycloak_integration_error',
        ),
      );

      await expectLater(
        h.repository.register(
          email: 'nuevo@cauce.local',
          fullName: 'Paciente',
          password: 'ClaveSegura1',
          consentDocumentVersion: '1.2.0',
          consentTextHash: 'sha256:abc',
        ),
        throwsA(isA<KeycloakIntegrationError>()),
      );
    });
  });

  group('AuthRepository · recuperacion de contrasena', () {
    test('la solicitud envia correo y clientId', () async {
      final h = _harness(const CannedResponse.ok(<String, dynamic>{}));

      await h.repository.requestPasswordReset(
        email: 'paciente.demo@cauce.local',
      );

      expect(
        h.adapter.lastRequest.path,
        '/api/v1/auth/password-reset/request',
      );
      expect(h.adapter.lastRequest.body['email'], 'paciente.demo@cauce.local');
      expect(h.adapter.lastRequest.body['clientId'], 'cauce-mobile');
    });

    test('la confirmacion envia token y contrasena nueva', () async {
      final h = _harness(const CannedResponse.ok(<String, dynamic>{}));

      await h.repository.confirmPasswordReset(
        token: 'abc123',
        newPassword: 'NuevaClave1',
      );

      expect(
        h.adapter.lastRequest.path,
        '/api/v1/auth/password-reset/confirm',
      );
      expect(h.adapter.lastRequest.body['token'], 'abc123');
      expect(h.adapter.lastRequest.body['newPassword'], 'NuevaClave1');
    });

    test('un token vencido se traduce con su motivo', () async {
      final h = _harness(
        CannedResponse.problem(
          statusCode: 400,
          errorCode: 'expired_password_reset_token',
        ),
      );

      await expectLater(
        h.repository.confirmPasswordReset(
          token: 'viejo',
          newPassword: 'NuevaClave1',
        ),
        throwsA(
          isA<PasswordResetTokenError>().having(
            (e) => e.reason,
            'reason',
            PasswordResetTokenReason.expired,
          ),
        ),
      );
    });
  });

  group('AuthRepository · logout', () {
    test('envia el refresh token y el clientId', () async {
      final h = _harness(const CannedResponse.noContent());

      await h.repository.logout(refreshToken: 'refresh-1');

      expect(h.adapter.lastRequest.path, '/api/v1/auth/logout');
      expect(h.adapter.lastRequest.body['refreshToken'], 'refresh-1');
      expect(h.adapter.lastRequest.body['clientId'], 'cauce-mobile');
    });

    test('un 401 se traduce y no escapa como DioException', () async {
      final h = _harness(
        CannedResponse.problem(statusCode: 401, errorCode: 'invalid_token'),
      );

      await expectLater(
        h.repository.logout(refreshToken: 'vencido'),
        throwsA(isA<CauceApiError>()),
      );
    });
  });

  group('AuthRepository · fallos de transporte', () {
    test('sin red se traduce a NetworkError', () async {
      final adapter = CannedHttpAdapter();
      final dio = Dio(BaseOptions(baseUrl: 'http://localhost:5074'))
        ..httpClientAdapter = _FailingAdapter();
      final client = CauceApiClient(
        dio: dio,
        interceptors: const <Interceptor>[],
      );
      final repository = AuthRepository(
        client.getAuthApi(),
        client.getConsentApi(),
      );
      expect(adapter.requests, isEmpty);

      await expectLater(
        repository.login(email: 'a@b.co', password: 'x'),
        throwsA(isA<NetworkError>()),
      );
    });
  });
}

/// Adapter que simula la ausencia de red.
class _FailingAdapter implements HttpClientAdapter {
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) {
    throw DioException.connectionError(
      requestOptions: options,
      reason: 'sin red',
    );
  }

  @override
  void close({bool force = false}) {}
}
