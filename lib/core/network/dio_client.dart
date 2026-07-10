import 'package:dio/dio.dart';
import '../config/api_config.dart';
import '../storage/secure_storage_service.dart';
import 'auth_interceptor.dart';

/// Cliente HTTP centralizado para todas las llamadas al backend.
class DioClient {
  late final Dio _dio;

  DioClient(SecureStorageService storage) {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConfig.baseUrl,
        connectTimeout: ApiConfig.connectTimeout,
        receiveTimeout: ApiConfig.receiveTimeout,
        contentType: 'application/json',
        responseType: ResponseType.json,
        validateStatus: (status) => status != null && status < 500,
      ),
    );

    _dio.interceptors.add(AuthInterceptor(storage));

    // Logger solo en debug
    assert(() {
      _dio.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          requestHeader: false,
          responseHeader: false,
        ),
      );
      return true;
    }());
  }

  Dio get dio => _dio;
}