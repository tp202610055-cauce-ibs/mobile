import '../../l10n/generated/app_localizations.dart';
import 'cauce_api_error.dart';

/// Traduce un [CauceApiError] al mensaje que ve el paciente.
///
/// Vive en un solo lugar para que las cinco pantallas de identidad no
/// dupliquen el switch, y para que agregar un `errorCode` nuevo al contrato
/// falle en compilacion aca y no pase inadvertido en cuatro archivos.
extension CauceApiErrorMessage on CauceApiError {
  /// Mensaje principal, apto para mostrar en un banner.
  ///
  /// [now] se inyecta para que el countdown del bloqueo de cuenta sea
  /// verificable sin depender del reloj real.
  String localizedMessage(AppLocalizations l10n, {DateTime? now}) {
    return switch (this) {
      ValidationError() => l10n.errorValidation,
      ConsentMismatchError() => l10n.errorConsentTextMismatch,
      InvitationCodeError(:final reason) => switch (reason) {
          InvitationCodeReason.invalid => l10n.errorInvalidInvitationCode,
          InvitationCodeReason.expired => l10n.errorExpiredInvitationCode,
          InvitationCodeReason.alreadyUsed =>
            l10n.errorInvitationCodeAlreadyUsed,
        },
      NutritionistNotAvailableError(:final reason) => switch (reason) {
          NutritionistNotAvailableReason.pendingActivation =>
            l10n.errorNutritionistPendingActivation,
          // Los dos estados terminales comparten mensaje: para el paciente la
          // accion util es la misma, pedir un codigo nuevo.
          NutritionistNotAvailableReason.inactive ||
          NutritionistNotAvailableReason.suspended =>
            l10n.errorNutritionistUnavailable,
        },
      PatientAlreadyAssignedError() => l10n.errorPatientAlreadyAssigned,
      PatientProfileNotFoundError() => l10n.errorPatientProfileNotFound,
      DuplicateProfileError() => l10n.errorDuplicateProfile,
      InvalidBiometricValueError() => l10n.errorInvalidBiometricValue,
      AllergyNotFoundError() => l10n.errorAllergyNotFound,
      DuplicateAllergyError() => l10n.errorDuplicateAllergy,
      InvalidIbsSssDimensionError() => l10n.errorInvalidIbsSssDimension,
      DuplicateBaselineAssessmentError() =>
        l10n.errorDuplicateBaselineAssessment,
      FoodItemNotFoundError() => l10n.errorFoodItemNotFound,
      CustomFoodNotFoundError() => l10n.errorCustomFoodNotFound,
      DuplicateCustomFoodError() => l10n.errorDuplicateCustomFood,
      CustomFoodInUseError() => l10n.errorCustomFoodInUse,
      DuplicateIngredientError() => l10n.errorDuplicateIngredient,
      IngredientNotFoundError() => l10n.errorIngredientNotFound,
      // Es el paso intermedio del flujo de confirmacion, no un error terminal.
      // El mensaje sirve de encabezado; el detalle por ingrediente lo pinta la
      // pantalla a partir de `allergens`.
      UnconfirmedAllergensError() => l10n.errorUnconfirmedAllergens,
      InvalidMealRegistrationError() => l10n.errorInvalidMealRegistration,
      MealNotFoundError() => l10n.errorMealNotFound,
      SymptomNotFoundError() => l10n.errorSymptomNotFound,
      ClinicalNoteNotFoundError() => l10n.errorClinicalNoteNotFound,
      InvalidClinicalNoteAssociationError() =>
        l10n.errorInvalidClinicalNoteAssociation,
      IdempotencyMismatchError() => l10n.errorIdempotencyMismatch,
      PatientHasNoDataInPeriodError() => l10n.errorPatientHasNoDataInPeriod,
      ReportPeriodInvalidError() => l10n.errorReportPeriodInvalid,
      DomainRuleViolationError() => l10n.errorDomainRuleViolation,
      RecommendationNotFoundError() => l10n.errorRecommendationNotFound,
      RecommendationAccessDeniedError() => l10n.errorRecommendationAccessDenied,
      ConflictStateError() => l10n.errorConflictState,
      RecommendationExpiredError() => l10n.errorRecommendationExpired,
      InsufficientClinicalHistoryError() =>
        l10n.errorInsufficientClinicalHistory,
      AllCandidatesFilteredByAllergiesError() =>
        l10n.errorAllCandidatesFilteredByAllergies,
      NoActiveModelVersionError() => l10n.errorNoActiveModelVersion,
      DuplicateEmailError() => l10n.errorDuplicateEmail,
      KeycloakIntegrationError() => l10n.errorKeycloakIntegration,
      InvalidCredentialsError() => l10n.errorInvalidCredentials,
      AccountLockedError(:final lockedUntil) => _lockedMessage(
          l10n,
          lockedUntil,
          now ?? DateTime.now().toUtc(),
        ),
      InvalidRefreshTokenError() => l10n.errorInvalidRefreshToken,
      PasswordResetTokenError(:final reason) => switch (reason) {
          PasswordResetTokenReason.invalid =>
            l10n.errorInvalidPasswordResetToken,
          PasswordResetTokenReason.expired =>
            l10n.errorExpiredPasswordResetToken,
        },
      RateLimitedError(:final retryAfterSeconds) => l10n.errorRateLimited(
          retryAfterSeconds,
        ),
      UserLocalMissingError() => l10n.errorUserLocalMissing,
      ConsentRecordNotFoundError() => l10n.errorConsentRecordNotFound,
      ForbiddenError() => l10n.errorForbidden,
      NetworkError() => l10n.errorNetwork,
      UnknownError(:final statusCode) =>
        statusCode >= 500 ? l10n.errorInternalServer : l10n.errorUnknown,
    };
  }

  /// Errores por campo, para pintar bajo cada input del formulario.
  ///
  /// Las claves llegan en camelCase desde la v1.1 del contrato, listas para
  /// casar contra los campos. Vacio para todo error que no sea de validacion.
  Map<String, List<String>> get fieldErrors => switch (this) {
        ValidationError(:final fieldErrors) => fieldErrors,
        _ => const <String, List<String>>{},
      };

  /// Momento en que expira el bloqueo, si el error es un 423.
  DateTime? get lockedUntil => switch (this) {
        AccountLockedError(:final lockedUntil) => lockedUntil,
        _ => null,
      };

  /// Segundos de espera, si el error es un 429.
  int? get retryAfterSeconds => switch (this) {
        RateLimitedError(:final retryAfterSeconds) => retryAfterSeconds,
        _ => null,
      };

  static String _lockedMessage(
    AppLocalizations l10n,
    DateTime lockedUntil,
    DateTime now,
  ) {
    final remaining = lockedUntil.difference(now);
    // Por debajo del minuto, redondear a "0 minutos" resultaria en un mensaje
    // que parece decir que ya se puede reintentar.
    if (remaining.inMinutes < 1) {
      return l10n.errorAccountLockedSoon;
    }
    return l10n.errorAccountLocked(remaining.inMinutes);
  }
}
