import 'dart:async';
import 'dart:typed_data';

import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/errors/session_expired_exception.dart';
import 'package:cauce_mobile/core/network/dio_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_token_storage.dart';

const String _baseUrl = 'http://localhost:5074';
const String _protectedPath = '/api/v1/patients/me';

/// Adapter que responde 401 hasta que cambia el access token, y luego 200.
///
/// Reproduce el escenario real: el backend rechaza mientras el token esta
/// vencido y acepta en cuanto llega el renovado.
class _ProtectedEndpointAdapter implements HttpClientAdapter {
  _ProtectedEndpointAdapter({required this.validAccessToken});

  final String validAccessToken;
  int requestCount = 0;
  final List<String?> seenAuthorizationHeaders = <String?>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requestCount++;
    final authorization = options.headers['Authorization'] as String?;
    seenAuthorizationHeaders.add(authorization);

    if (authorization == 'Bearer $validAccessToken') {
      return ResponseBody.fromString(
        '{"ok":true}',
        200,
        headers: <String, List<String>>{
          Headers.contentTypeHeader: <String>[Headers.jsonContentType],
        },
      );
    }
    return ResponseBody.fromString(
      '{"status":401,"errorCode":"invalid_token"}',
      401,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// Cliente de refresh controlable, que cuenta cuantas veces lo llamaron.
class _RefreshClientStub {
  _RefreshClientStub({
    required this.statusCode,
    this.delay = Duration.zero,
    this.userJson,
    this.rawBody,
  });

  /// Par rotado que devuelve el backend en una renovacion exitosa.
  static const String rotatedAccessToken = 'access-2';
  static const String rotatedRefreshToken = 'refresh-2';

  final int statusCode;
  final Duration delay;

  /// Valor crudo del campo `user` de la respuesta, ya en JSON. `null` lo
  /// omite, que es la forma que tenian las renovaciones antes de M49.
  final String? userJson;

  /// Cuerpo literal del 200, para las respuestas exitosas pero inservibles.
  final String? rawBody;
  int callCount = 0;

  Dio build() {
    final dio = Dio(BaseOptions(baseUrl: _baseUrl));
    dio.httpClientAdapter = _CallbackAdapter((options) async {
      callCount++;
      if (delay > Duration.zero) {
        await Future<void>.delayed(delay);
      }
      if (statusCode != 200) {
        return ResponseBody.fromString(
          '{"status":$statusCode,"errorCode":"invalid_refresh_token"}',
          statusCode,
          headers: <String, List<String>>{
            Headers.contentTypeHeader: <String>[Headers.jsonContentType],
          },
        );
      }
      final user = userJson == null ? '' : ',"user":$userJson';
      return ResponseBody.fromString(
        rawBody ??
            '{"accessToken":"$rotatedAccessToken",'
                '"refreshToken":"$rotatedRefreshToken"$user}',
        200,
        headers: <String, List<String>>{
          Headers.contentTypeHeader: <String>[Headers.jsonContentType],
        },
      );
    });
    return dio;
  }
}

class _CallbackAdapter implements HttpClientAdapter {
  _CallbackAdapter(this.onFetch);

  final Future<ResponseBody> Function(RequestOptions options) onFetch;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) =>
      onFetch(options);

  @override
  void close({bool force = false}) {}
}

void main() {
  group('RefreshInterceptor', () {
    test('renueva, persiste el token rotado y reintenta', () async {
      final storage = FakeTokenStorage(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
      );
      final refreshStub = _RefreshClientStub(statusCode: 200);
      final dio = buildDio(
        tokenStorage: storage,
        baseUrl: _baseUrl,
        refreshClient: refreshStub.build(),
      );
      final adapter = _ProtectedEndpointAdapter(validAccessToken: 'access-2');
      dio.httpClientAdapter = adapter;

      final response = await dio.get<dynamic>(_protectedPath);

      expect(response.statusCode, 200);
      // La rotacion es obligatoria: el realm invalida el refresh anterior.
      expect(storage.saveTokensCalls, 1);
      expect(storage.accessToken, 'access-2');
      expect(storage.refreshToken, 'refresh-2');
      // Un intento con el token vencido y otro con el renovado.
      expect(adapter.requestCount, 2);
      expect(adapter.seenAuthorizationHeaders.last, 'Bearer access-2');
    });

    test('varios 401 concurrentes disparan un solo refresh', () async {
      final storage = FakeTokenStorage(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
      );
      // La demora mantiene el refresh en vuelo mientras llegan los demas 401.
      final refreshStub = _RefreshClientStub(
        statusCode: 200,
        delay: const Duration(milliseconds: 40),
      );
      final dio = buildDio(
        tokenStorage: storage,
        baseUrl: _baseUrl,
        refreshClient: refreshStub.build(),
      );
      dio.httpClientAdapter = _ProtectedEndpointAdapter(
        validAccessToken: 'access-2',
      );

      final responses =
          await Future.wait<Response<dynamic>>(<Future<Response<dynamic>>>[
        dio.get<dynamic>(_protectedPath),
        dio.get<dynamic>(_protectedPath),
        dio.get<dynamic>(_protectedPath),
      ]);

      expect(responses.every((r) => r.statusCode == 200), isTrue);
      // Sin serializacion, el segundo refresh usaria un token ya invalidado
      // por el primero y cerraria la sesion del paciente sin motivo.
      expect(refreshStub.callCount, 1);
      expect(storage.saveTokensCalls, 1);
    });

    test('un refresh rechazado limpia la sesion y expira', () async {
      final storage = FakeTokenStorage(
        accessToken: 'access-1',
        refreshToken: 'refresh-vencido',
      );
      final refreshStub = _RefreshClientStub(statusCode: 401);
      final dio = buildDio(
        tokenStorage: storage,
        baseUrl: _baseUrl,
        refreshClient: refreshStub.build(),
      );
      dio.httpClientAdapter = _ProtectedEndpointAdapter(
        validAccessToken: 'access-2',
      );

      await expectLater(
        dio.get<dynamic>(_protectedPath),
        throwsA(
          isA<DioException>().having(
            (e) => e.error,
            'error',
            isA<SessionExpiredException>(),
          ),
        ),
      );

      expect(storage.clearSessionCalls, 1);
      expect(storage.refreshToken, isNull);
    });

    test('un 500 en el refresh no borra la sesion', () async {
      final storage = FakeTokenStorage(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
      );
      final refreshStub = _RefreshClientStub(statusCode: 500);
      final dio = buildDio(
        tokenStorage: storage,
        baseUrl: _baseUrl,
        refreshClient: refreshStub.build(),
      );
      dio.httpClientAdapter = _ProtectedEndpointAdapter(
        validAccessToken: 'access-2',
      );

      await expectLater(
        dio.get<dynamic>(_protectedPath),
        throwsA(isA<Object>()),
      );

      // Un fallo transitorio del servidor no debe dejar al paciente fuera.
      expect(storage.clearSessionCalls, 0);
      expect(storage.refreshToken, 'refresh-1');
    });

    test('sin refresh token no intenta renovar', () async {
      final storage = FakeTokenStorage(accessToken: 'access-1');
      final refreshStub = _RefreshClientStub(statusCode: 200);
      final dio = buildDio(
        tokenStorage: storage,
        baseUrl: _baseUrl,
        refreshClient: refreshStub.build(),
      );
      dio.httpClientAdapter = _ProtectedEndpointAdapter(
        validAccessToken: 'access-2',
      );

      await expectLater(
        dio.get<dynamic>(_protectedPath),
        throwsA(isA<Object>()),
      );

      expect(refreshStub.callCount, 0);
      expect(storage.clearSessionCalls, 1);
    });

    test('un 401 en ruta anonima no dispara refresh', () async {
      final storage = FakeTokenStorage(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
      );
      final refreshStub = _RefreshClientStub(statusCode: 200);
      final dio = buildDio(
        tokenStorage: storage,
        baseUrl: _baseUrl,
        refreshClient: refreshStub.build(),
      );
      dio.httpClientAdapter = _CallbackAdapter(
        (options) async => ResponseBody.fromString(
          '{"status":401,"errorCode":"invalid_credentials"}',
          401,
          headers: <String, List<String>>{
            Headers.contentTypeHeader: <String>[Headers.jsonContentType],
          },
        ),
      );

      await expectLater(
        dio.post<dynamic>('/api/v1/auth/login'),
        throwsA(isA<DioException>()),
      );

      // Credenciales incorrectas no son una sesion vencida.
      expect(refreshStub.callCount, 0);
      expect(storage.clearSessionCalls, 0);
    });
  });

  group('RefreshInterceptor · aviso de sesion vencida (acta M49)', () {
    // Hasta este bloque nadie atrapaba el `SessionExpiredException`: el
    // almacenamiento quedaba vacio pero la sesion en memoria seguia
    // autenticada, y la app no volvia al login hasta el proximo arranque.
    Future<int> expiriesFor({
      int refreshStatus = 401,
      String? refreshToken = 'refresh-1',
      String? rawBody,
      int concurrentRequests = 1,
    }) async {
      var expiries = 0;
      final storage = FakeTokenStorage(
        accessToken: 'access-1',
        refreshToken: refreshToken,
      );
      final refreshStub = _RefreshClientStub(
        statusCode: refreshStatus,
        rawBody: rawBody,
      );
      final dio = buildDio(
        tokenStorage: storage,
        baseUrl: _baseUrl,
        refreshClient: refreshStub.build(),
        onSessionExpired: () => expiries++,
      );
      dio.httpClientAdapter =
          _ProtectedEndpointAdapter(validAccessToken: 'access-2');

      await Future.wait(<Future<void>>[
        for (var i = 0; i < concurrentRequests; i++)
          dio
              .get<dynamic>(_protectedPath)
              .then<void>((_) {}, onError: (Object _) {}),
      ]);
      return expiries;
    }

    test('un refresh rechazado con 401 avisa una vez', () async {
      expect(await expiriesFor(), 1);
    });

    test('un refresh rechazado con 400 tambien avisa', () async {
      // Es lo que responde el backend a un clientId que no es cauce-mobile.
      expect(await expiriesFor(refreshStatus: 400), 1);
    });

    test('sin refresh token guardado avisa sin salir a la red', () async {
      expect(await expiriesFor(refreshToken: null), 1);
    });

    test('un 200 sin tokens avisa: la sesion no se puede renovar', () async {
      expect(await expiriesFor(refreshStatus: 200, rawBody: '{}'), 1);
    });

    test('un 500 no avisa: es transitorio y la sesion sigue', () async {
      expect(await expiriesFor(refreshStatus: 500), 0);
    });

    test('una renovacion exitosa no avisa', () async {
      expect(await expiriesFor(refreshStatus: 200), 0);
    });

    test('tres 401 simultaneos avisan una sola vez', () async {
      // Un solo refresh en vuelo: el aviso sale de ese refresh, no de cada
      // peticion que lo espero.
      expect(await expiriesFor(concurrentRequests: 3), 1);
    });
  });

  group('RefreshInterceptor · snapshot del usuario (CP067, acta M49)', () {
    // El snapshot del login: todavia fuera del piloto.
    const loginSnapshot = AuthenticatedUserSnapshot(
      userId: '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
      keycloakId: 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
      email: 'paciente.demo@cauce.local',
      role: 'patient',
      fullName: 'Paciente Demo',
      emailVerified: true,
      isInActivePilot: false,
    );

    String userJson({
      String isInActivePilot = 'true',
      String emailVerified = 'true',
      bool includePilotFlag = true,
    }) =>
        '{"userId":"${loginSnapshot.userId}",'
        '"keycloakId":"${loginSnapshot.keycloakId}",'
        '"email":"${loginSnapshot.email}",'
        '"role":"patient",'
        '"fullName":"Paciente Demo",'
        '"emailVerified":$emailVerified'
        '${includePilotFlag ? ',"isInActivePilot":$isInActivePilot' : ''}}';

    Future<FakeTokenStorage> refreshWith(String? user) async {
      final storage = FakeTokenStorage(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        userSnapshot: loginSnapshot,
      );
      final refreshStub = _RefreshClientStub(statusCode: 200, userJson: user);
      final dio = buildDio(
        tokenStorage: storage,
        baseUrl: _baseUrl,
        refreshClient: refreshStub.build(),
      );
      dio.httpClientAdapter =
          _ProtectedEndpointAdapter(validAccessToken: 'access-2');

      final response = await dio.get<dynamic>(_protectedPath);

      // En todos los casos la renovacion prospera y la peticion se reintenta:
      // el `user` nunca decide si la sesion sigue.
      expect(response.statusCode, 200);
      expect(storage.accessToken, 'access-2');
      expect(storage.refreshToken, 'refresh-2');
      expect(storage.clearSessionCalls, 0);
      return storage;
    }

    test('guarda el usuario que trae la renovacion', () async {
      final storage = await refreshWith(userJson());

      expect(storage.saveSessionCalls, 1);
      expect(storage.saveTokensCalls, 0);
      expect(storage.userSnapshot?.isInActivePilot, isTrue);
      expect(storage.userSnapshot?.userId, loginSnapshot.userId);
    });

    test('sin user conserva el snapshot anterior', () async {
      final storage = await refreshWith(null);

      expect(storage.saveTokensCalls, 1);
      expect(storage.saveSessionCalls, 0);
      expect(storage.userSnapshot, loginSnapshot);
    });

    test('user en null conserva el snapshot anterior', () async {
      final storage = await refreshWith('null');

      expect(storage.saveTokensCalls, 1);
      expect(storage.userSnapshot, loginSnapshot);
    });

    test('un user sin isInActivePilot no se guarda a medias', () async {
      final storage = await refreshWith(userJson(includePilotFlag: false));

      expect(storage.saveTokensCalls, 1);
      expect(storage.saveSessionCalls, 0);
      expect(storage.userSnapshot, loginSnapshot);
    });

    test('un user con un tipo equivocado no se guarda', () async {
      final storage = await refreshWith(userJson(emailVerified: '"si"'));

      expect(storage.saveTokensCalls, 1);
      expect(storage.userSnapshot, loginSnapshot);
    });

    test('un user que no es un objeto no se guarda', () async {
      final storage = await refreshWith('"paciente"');

      expect(storage.saveTokensCalls, 1);
      expect(storage.userSnapshot, loginSnapshot);
    });
  });
}
