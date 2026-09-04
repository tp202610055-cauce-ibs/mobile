import 'package:cauce_mobile/core/network/auth_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/fake_token_storage.dart';

/// Ejecuta `onRequest` y devuelve las cabeceras resultantes.
Future<Map<String, dynamic>> _headersFor(
  AuthInterceptor interceptor,
  String path,
) async {
  final options = RequestOptions(path: path);
  final handler = RequestInterceptorHandler();
  await interceptor.onRequest(options, handler);
  return options.headers;
}

void main() {
  group('AuthInterceptor', () {
    test('no adjunta Bearer a ninguna ruta anonima del contrato', () async {
      final storage = FakeTokenStorage(accessToken: 'access-token');
      final interceptor = AuthInterceptor(storage);

      for (final path in AuthInterceptor.anonymousPaths) {
        final headers = await _headersFor(interceptor, path);
        expect(
          headers.containsKey('Authorization'),
          isFalse,
          reason: 'no deberia llevar Bearer: $path',
        );
      }
    });

    test('adjunta Bearer a una ruta protegida', () async {
      final storage = FakeTokenStorage(accessToken: 'access-token');
      final interceptor = AuthInterceptor(storage);

      final headers = await _headersFor(interceptor, '/api/v1/patients/me');

      expect(headers['Authorization'], 'Bearer access-token');
    });

    test('logout lleva Bearer: el contrato lo declara autenticado', () async {
      final storage = FakeTokenStorage(accessToken: 'access-token');
      final interceptor = AuthInterceptor(storage);

      final headers = await _headersFor(interceptor, '/api/v1/auth/logout');

      expect(headers['Authorization'], 'Bearer access-token');
    });

    test('sin token no inventa la cabecera', () async {
      final interceptor = AuthInterceptor(FakeTokenStorage());

      final headers = await _headersFor(interceptor, '/api/v1/patients/me');

      expect(headers.containsKey('Authorization'), isFalse);
    });

    test('reconoce la ruta aunque venga como URL absoluta', () async {
      final storage = FakeTokenStorage(accessToken: 'access-token');
      final interceptor = AuthInterceptor(storage);

      final headers = await _headersFor(
        interceptor,
        'http://10.0.2.2:5074/api/v1/auth/login',
      );

      expect(headers.containsKey('Authorization'), isFalse);
    });
  });
}
