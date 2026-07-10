import 'package:dio/dio.dart';
import '../../../core/config/api_config.dart';
import '../../../core/network/api_exceptions.dart';
import 'dtos/auth_response_dto.dart';
import 'dtos/login_request_dto.dart';
import 'dtos/register_request_dto.dart';
import 'dtos/user_profile_dto.dart';

/// Repositorio que encapsula todas las llamadas HTTP de autenticación.
class AuthRepository {
  final Dio _dio;

  AuthRepository(this._dio);

  Future<AuthResponseDto> register(RegisterRequestDto request) async {
    try {
      final response = await _dio.post(
        ApiConfig.registerEndpoint,
        data: request.toJson(),
      );
      if (response.statusCode == 201) {
        return AuthResponseDto.fromJson(response.data as Map<String, dynamic>);
      }
      throw _mapErrorResponse(response.statusCode, response.data);
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<AuthResponseDto> login(LoginRequestDto request) async {
    try {
      final response = await _dio.post(
        ApiConfig.loginEndpoint,
        data: request.toJson(),
      );
      if (response.statusCode == 200) {
        return AuthResponseDto.fromJson(response.data as Map<String, dynamic>);
      }
      throw _mapErrorResponse(response.statusCode, response.data);
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  Future<UserProfileDto> getCurrentUser() async {
    try {
      final response = await _dio.get(ApiConfig.currentUserEndpoint);
      if (response.statusCode == 200) {
        return UserProfileDto.fromJson(response.data as Map<String, dynamic>);
      }
      throw _mapErrorResponse(response.statusCode, response.data);
    } on DioException catch (e) {
      throw _mapDioException(e);
    }
  }

  // --- Mapeo de errores ---

  ApiException _mapErrorResponse(int? statusCode, dynamic body) {
    switch (statusCode) {
      case 400:
        return ValidationException(_extractMessage(body) ?? 'Datos inválidos.');
      case 401:
        return const InvalidCredentialsException();
      case 409:
        return const DuplicateEmailException();
      case 423:
        return const AccountLockedException();
      default:
        return ServerException(_extractMessage(body));
    }
  }

  ApiException _mapDioException(DioException e) {
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return const NetworkException();
    }
    if (e.response != null) {
      return _mapErrorResponse(e.response!.statusCode, e.response!.data);
    }
    return const ServerException();
  }

  String? _extractMessage(dynamic body) {
    if (body is Map<String, dynamic>) {
      return body['message'] as String? ?? body['error'] as String?;
    }
    return null;
  }
}