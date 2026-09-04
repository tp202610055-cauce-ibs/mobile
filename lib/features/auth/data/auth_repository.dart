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

/// Resultado de un registro aceptado (201).
///
/// No trae tokens: el backend exige verificar el correo antes del primer
/// login, de modo que aca no hay sesion que persistir.
class RegistrationResult {
  const RegistrationResult({
    required this.userId,
    required this.email,
    required this.emailVerificationRequired,
  });

  final String userId;
  final String email;
  final bool emailVerificationRequired;
}

/// Consentimiento informado vigente (US01 CA01).
class CurrentConsent {
  const CurrentConsent({
    required this.version,
    required this.text,
    required this.hash,
  });

  /// Version del documento, tal como la publica el backend.
  final String version;

  /// Texto completo que el paciente debe leer.
  final String text;

  /// Hash del texto.
  ///
  /// El movil lo reenvia **tal cual lo recibio**, sin recalcularlo. El backend
  /// lo computa sobre el texto normalizado con un algoritmo propio; replicarlo
  /// aca produciria un hash distinto y un 400 `consent_text_mismatch` en cada
  /// registro.
  final String hash;
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
  const AuthRepository(this._api, this._consentApi);

  final AuthApi _api;
  final ConsentApi _consentApi;

  /// US01 CA01. `GET /api/v1/consent/current`.
  ///
  /// Ruta anonima: la consume la pantalla de registro antes de que exista
  /// cuenta alguna.
  Future<CurrentConsent> currentConsent() {
    return _guard(() async {
      final response = await _consentApi.apiV1ConsentCurrentGet();
      final result = response.data;
      final version = result?.version;
      final text = result?.text;
      final hash = result?.hash;

      if (version == null || text == null || hash == null) {
        throw const FormatException(
          'El consentimiento vigente llego sin version, texto o hash.',
        );
      }
      return CurrentConsent(version: version, text: text, hash: hash);
    });
  }

  /// US01 CA01 y CA02. `POST /api/v1/auth/register`.
  ///
  /// [consentDocumentVersion] y [consentTextHash] son los que devolvio
  /// [currentConsent], sin recalcular.
  Future<RegistrationResult> register({
    required String email,
    required String fullName,
    required String password,
    required String consentDocumentVersion,
    required String consentTextHash,
    String? invitationCode,
  }) {
    return _guard(() async {
      final response = await _api.apiV1AuthRegisterPost(
        registerPatientRequest: RegisterPatientRequest(
          (b) => b
            ..email = email
            ..fullName = fullName
            ..password = password
            ..consentDocumentVersion = consentDocumentVersion
            ..consentTextHash = consentTextHash
            // Se omite si el paciente no ingreso ninguno: mandar cadena vacia
            // haria que el backend la valide como codigo y responda 400.
            ..invitationCode =
                (invitationCode?.isEmpty ?? true) ? null : invitationCode,
        ),
      );
      final result = response.data;
      final userId = result?.userId;
      if (userId == null) {
        throw const FormatException('El registro respondio sin userId.');
      }
      return RegistrationResult(
        userId: userId,
        email: result?.email ?? email,
        emailVerificationRequired: result?.emailVerificationRequired ?? true,
      );
    });
  }

  /// US08 CA01. `POST /api/v1/auth/logout`.
  ///
  /// Avisa al backend para que revoque el refresh token del lado servidor. El
  /// cierre local no depende de que esto prospere.
  Future<void> logout({required String refreshToken}) {
    return _guard(() async {
      await _api.apiV1AuthLogoutPost(
        logoutRequest: LogoutRequest(
          (b) => b
            ..refreshToken = refreshToken
            ..clientId = Env.clientId,
        ),
      );
    });
  }

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
  return AuthRepository(
    ref.watch(authApiProvider),
    ref.watch(consentApiProvider),
  );
}

/// Consentimiento vigente, cacheado mientras la pantalla de registro viva.
///
/// Se declara como provider aparte y no se lee dentro del notifier para que la
/// pantalla pueda mostrar carga, error y reintento con `AsyncValue`, sin
/// mezclar ese ciclo con el del envio del formulario.
@riverpod
Future<CurrentConsent> currentConsent(Ref ref) {
  return ref.watch(authRepositoryProvider).currentConsent();
}
