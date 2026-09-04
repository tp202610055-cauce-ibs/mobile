import 'dart:async';
import 'dart:typed_data';

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
  _RefreshClientStub({required this.statusCode, this.delay = Duration.zero});

  /// Par rotado que devuelve el backend en una renovacion exitosa.
  static const String rotatedAccessToken = 'access-2';
  static const String rotatedRefreshToken = 'refresh-2';

  final int statusCode;
  final Duration delay;
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
      return ResponseBody.fromString(
        '{"accessToken":"$rotatedAccessToken",'
        '"refreshToken":"$rotatedRefreshToken"}',
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
}
