import 'package:freezed_annotation/freezed_annotation.dart';

part 'cauce_api_error.freezed.dart';

/// Motivo por el que un codigo de invitacion fue rechazado.
enum InvitationCodeReason { invalid, expired, alreadyUsed }

/// Motivo por el que un token de recuperacion de contrasena fue rechazado.
enum PasswordResetTokenReason { invalid, expired }

/// Estado de la cuenta del nutricionista que impide que atienda.
///
/// Llega en la extension `reason` del 409 `nutritionist_not_available`. El
/// contrato usa un solo `errorCode` para el escenario y manda el estado exacto
/// aparte, de modo que el cliente puede afinar el mensaje o mostrar uno
/// generico.
enum NutritionistNotAvailableReason { pendingActivation, inactive, suspended }

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

  /// 409 `nutritionist_not_available`. El nutricionista dueno del codigo no
  /// esta en condiciones de atender, con el estado exacto en [reason].
  ///
  /// Lo emiten tanto el registro con codigo (contrato v1.3) como el canje
  /// posterior (v1.2). En los dos casos el codigo **no** se consume, asi que
  /// el paciente puede reintentar con el mismo.
  const factory CauceApiError.nutritionistNotAvailable({
    required NutritionistNotAvailableReason reason,
  }) = NutritionistNotAvailableError;

  /// 409 `patient_already_assigned`. El paciente ya tiene un nutricionista
  /// activo y el backend no lo sobrescribe: cambiar de nutricionista es una
  /// decision clinica, no el efecto de pegar otro codigo.
  const factory CauceApiError.patientAlreadyAssigned() =
      PatientAlreadyAssignedError;

  /// 404 `patient_profile_not_found`. El paciente todavia no creo su perfil
  /// clinico.
  ///
  /// En el onboarding **no es un error**: es el estado "paso 1 pendiente", y
  /// `PatientsRepository.fetchProfile()` lo traduce a `null` antes de que
  /// llegue a la capa de aplicacion. Se mapea igual porque otros consumidores
  /// del perfil si necesitan distinguirlo.
  const factory CauceApiError.patientProfileNotFound() =
      PatientProfileNotFoundError;

  /// 409 `duplicate_patient_profile`. Ya existe un perfil para este paciente.
  ///
  /// Se alcanza cuando el envio del paso 1 prospero en el servidor pero la
  /// respuesta no llego al dispositivo, y el paciente reintenta. El perfil
  /// esta creado: lo correcto es releerlo y avanzar, no reintentar.
  const factory CauceApiError.duplicateProfile() = DuplicateProfileError;

  /// 400 `invalid_biometric_value`. Peso, estatura, edad, fecha de diagnostico
  /// o longitud de medicacion fuera de rango.
  ///
  /// El contrato lo emite desde la entidad de dominio y no desde
  /// FluentValidation, de modo que **no trae `errors` por campo**: el detalle
  /// va en prosa dentro de `detail`. Los validadores locales de [Validators]
  /// existen justamente para que este error casi nunca llegue.
  const factory CauceApiError.invalidBiometricValue() =
      InvalidBiometricValueError;

  /// 404 `allergy_not_found`. La alergia del catalogo no existe o fue
  /// desactivada mientras el paciente completaba el formulario.
  const factory CauceApiError.allergyNotFound() = AllergyNotFoundError;

  /// 409 `duplicate_patient_allergy`. El paciente ya declaro esa alergia.
  ///
  /// El paso 1 declara las alergias de a una, sin idempotencia. Si el envio
  /// falla a mitad de camino, el reintento reencuentra las que si entraron, y
  /// la capa de aplicacion trata este error como exito.
  const factory CauceApiError.duplicateAllergy() = DuplicateAllergyError;

  /// 400 `invalid_ibs_sss_dimension`. Alguna de las cinco dimensiones cayo
  /// fuera de 0 a 100.
  ///
  /// Inalcanzable desde la UI, porque el control esta acotado a ese rango. Se
  /// mapea para que un cambio de contrato no degrade a error desconocido.
  const factory CauceApiError.invalidIbsSssDimension() =
      InvalidIbsSssDimensionError;

  /// 409 `duplicate_baseline_assessment`. Ya existe una linea base.
  ///
  /// Significa que el envio anterior si entro, aunque el dispositivo no haya
  /// visto la respuesta. El onboarding esta cerrado: corresponde releer el
  /// estado y seguir, no reintentar.
  const factory CauceApiError.duplicateBaselineAssessment() =
      DuplicateBaselineAssessmentError;

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
