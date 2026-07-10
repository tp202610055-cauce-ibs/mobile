import 'package:dio/dio.dart';
import '../storage/secure_storage_service.dart';

/// Interceptor que añade el header Authorization a cada request
/// y maneja respuestas 401 limpiando el storage automáticamente.
class AuthInterceptor extends Interceptor {
  final SecureStorageService _storage;

  AuthInterceptor(this._storage);

  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final token = await _storage.readAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // Limpia el storage si el backend rechaza el token.
    // El AuthNotifier detectará la limpieza y redirigirá a Login.
    if (err.response?.statusCode == 401) {
      await _storage.clearAll();
    }
    handler.next(err);
  }
}