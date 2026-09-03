import 'package:cauce_api_client/cauce_api_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/auth/authenticated_user_snapshot.dart';
import '../../../core/config/env.dart';
import '../../../core/errors/cauce_api_error.dart';
import '../../../core/network/dio_provider.dart';
import '../../../core/network/error_mapper.dart';

part 'auth_repository.g.dart';

/// Resultado de un login exitoso, ya traducido al dominio.
class LoginSession {
  const LoginSession({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  final String accessToken;
  final String refreshToken;
  final AuthenticatedUserSnapshot user;
}

/// Acceso a los endpoints de identidad del backend.
///
/// Es la frontera entre el cliente generado y el resto de la app. Hacia
/// adentro habla `built_value` y `DioException`; hacia afuera solo tipos del
/// dominio y [CauceApiError]. Ningun notifier deberia importar dio ni el
/// package generado.
///
/// Todos los metodos lanzan [CauceApiError], nunca [DioException].
class AuthRepository {
  const AuthRepository(this._api);

  final AuthApi _api;

  /// US05. `POST /api/v1/auth/login`.
  Future<LoginSession> login({
    required String email,
    required String password,
  }) {
    return _guard(() async {
      final response = await _api.apiV1AuthLoginPost(
        loginRequest: LoginRequest(
          (b) => b
            ..email = email
            ..password = password
            ..clientId = Env.clientId,
        ),
      );
      return _toSession(response.data);
    });
  }

  /// US07 CA01. `POST /api/v1/auth/password-reset/request`.
  ///
  /// El backend responde 200 exista o no la cuenta, para no filtrar si un
  /// correo esta registrado. La UI no distingue los dos casos.
  Future<void> requestPasswordReset({required String email}) {
    return _guard(() async {
      await _api.apiV1AuthPasswordResetRequestPost(
        requestPasswordResetRequest: RequestPasswordResetRequest(
          (b) => b
            ..email = email
            ..clientId = Env.clientId,
        ),
      );
    });
  }

  /// US07 CA02. `POST /api/v1/auth/password-reset/confirm`.
  Future<void> confirmPasswordReset({
    required String token,
    required String newPassword,
  }) {
    return _guard(() async {
      await _api.apiV1AuthPasswordResetConfirmPost(
        confirmPasswordResetRequest: ConfirmPasswordResetRequest(
          (b) => b
            ..token = token
            ..newPassword = newPassword,
        ),
      );
    });
  }

  /// Ejecuta la llamada traduciendo cualquier falla al dominio.
  ///
  /// La [FormatException] se atrapa aparte: la lanza el mapeo del usuario
  /// cuando el backend responde 200 con un cuerpo incompleto. Es una respuesta
  /// exitosa que no sirve, y sin esto escaparia como excepcion cruda hasta la
  /// UI.
  Future<T> _guard<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (error) {
      throw ErrorMapper.map(error);
    } on FormatException catch (error) {
      throw CauceApiError.unknown(statusCode: 200, detail: error.message);
    }
  }

  LoginSession _toSession(LoginResult? result) {
    final accessToken = result?.accessToken;
    final refreshToken = result?.refreshToken;
    final user = result?.user;

    if (accessToken == null || refreshToken == null || user == null) {
      throw const FormatException(
        'El login respondio sin tokens o sin el objeto user.',
      );
    }

    return LoginSession(
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: AuthenticatedUserSnapshot.fromApi(user),
    );
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  return AuthRepository(ref.watch(authApiProvider));
}
