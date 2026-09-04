import 'package:freezed_annotation/freezed_annotation.dart';

part 'cauce_api_error.freezed.dart';

/// Motivo por el que un codigo de invitacion fue rechazado.
enum InvitationCodeReason { invalid, expired, alreadyUsed }

/// Motivo por el que un token de recuperacion de contrasena fue rechazado.
enum PasswordResetTokenReason { invalid, expired }

/// Dominio de errores del cliente frente al backend Cauce.
///
/// Es la traduccion del envelope RFC 7807 a tipos sobre los que la capa de
/// aplicacion puede hacer `switch` exhaustivo. Ningun notifier debe volver a
/// mirar un `DioException`, un status HTTP ni un `errorCode` en crudo.
///
/// El campo autoritativo del envelope es la extension `errorCode`, nunca el
/// mensaje ni el `title`, que estan en espanol y pueden cambiar sin aviso.
@freezed
sealed class CauceApiError with _$CauceApiError {
  /// 400. Errores por campo.
  ///
  /// [fieldErrors] tiene claves camelCase desde la v1.1 del contrato, listas
  /// para casar contra los campos del formulario. [errorCode] es `null` cuando
  /// el 400 viene del binding automatico de `[ApiController]` en vez de
  /// FluentValidation: ese camino trae `errors` pero no `errorCode`.
  const factory CauceApiError.validation({
    required Map<String, List<String>> fieldErrors,
    String? errorCode,
  }) = ValidationError;

  /// 401 `invalid_credentials`. Cubre tambien el correo sin verificar, y el
  /// backend no los distingue a proposito, para no filtrar si la cuenta existe.
  const factory CauceApiError.invalidCredentials() = InvalidCredentialsError;

  /// 423 `account_locked`. [lockedUntil] llega en la extension homonima, en
  /// ISO 8601 UTC, y alimenta el countdown de la pantalla de login.
  const factory CauceApiError.accountLocked({required DateTime lockedUntil}) =
      AccountLockedError;

  /// 400 `consent_text_mismatch`. La version o el hash del consentimiento no
  /// coinciden con el vigente, tipicamente porque cambio mientras el paciente
  /// completaba el formulario.
  const factory CauceApiError.consentMismatch() = ConsentMismatchError;

  /// 409 `duplicate_email`.
  const factory CauceApiError.duplicateEmail() = DuplicateEmailError;

  /// 400 sobre el codigo de invitacion, en sus tres variantes.
  const factory CauceApiError.invitationCode({
    required InvitationCodeReason reason,
  }) = InvitationCodeError;

  /// 400 sobre el token de recuperacion, en sus dos variantes.
  const factory CauceApiError.passwordResetToken({
    required PasswordResetTokenReason reason,
  }) = PasswordResetTokenError;

  /// 401 `invalid_refresh_token`. El refresh expiro, fue revocado o ya se
  /// consumio. Obliga a limpiar la sesion local y volver al login.
  const factory CauceApiError.invalidRefreshToken() = InvalidRefreshTokenError;

  /// 429. No trae `errorCode`: se detecta por status.
  const factory CauceApiError.rateLimited({required int retryAfterSeconds}) =
      RateLimitedError;

  /// 502 `keycloak_integration_error`. Fallo el aprovisionamiento en Keycloak.
  const factory CauceApiError.keycloakIntegration() = KeycloakIntegrationError;

  /// 500 `user_local_missing`. Existe en Keycloak pero no en el backend.
  const factory CauceApiError.userLocalMissing() = UserLocalMissingError;

  /// 404 `consent_record_not_found`. Aplica a US01 CA04, diferido a Mobile-3
  /// por acta M15. Se mapea igual para no dejar el switch incompleto.
  const factory CauceApiError.consentRecordNotFound() =
      ConsentRecordNotFoundError;

  /// 403 `forbidden`.
  const factory CauceApiError.forbidden() = ForbiddenError;

  /// Timeout, DNS o ausencia de red. No hubo respuesta del servidor.
  const factory CauceApiError.network() = NetworkError;

  /// Cualquier caso no contemplado. [statusCode] es 0 si no hubo respuesta.
  const factory CauceApiError.unknown({
    required int statusCode,
    String? errorCode,
    String? detail,
  }) = UnknownError;
}
