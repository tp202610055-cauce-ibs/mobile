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

/// Severidad que el paciente declaro para la alergia que se detecto.
///
/// Espeja `AllergySeverity` del contrato, que llega en PascalCase dentro de la
/// extension `allergens`. No se reutiliza `AllergySeverityLevel` de
/// `features/patients/domain/allergy.dart` a proposito: importar una feature
/// desde `core/` invertiria la direccion de la dependencia.
enum DetectedAllergenSeverity {
  mild,
  moderate,
  severe;

  /// Traduce el valor del contrato, o `null` si no lo reconoce.
  ///
  /// Nullable y no degradado a un valor concreto, con el mismo criterio que
  /// `AllergyTypeOption.fromApi` e `IbsSssSeverity.fromApi`: la UI de
  /// confirmacion trata el caso ausente de forma explicita en vez de que el
  /// cliente invente una severidad que el servidor no dijo.
  static DetectedAllergenSeverity? fromWire(Object? value) {
    return switch (value) {
      'Mild' => DetectedAllergenSeverity.mild,
      'Moderate' => DetectedAllergenSeverity.moderate,
      'Severe' => DetectedAllergenSeverity.severe,
      _ => null,
    };
  }
}

/// Coincidencia entre un ingrediente del plato y una alergia ya declarada.
///
/// Llega en la extension `allergens` del 409 `unconfirmed_allergens` (US10
/// CA03). El cruce lo hace el servidor contra las alergias del perfil: el
/// cliente no lo recalcula, solo lo muestra y pide confirmacion.
@freezed
abstract class DetectedAllergen with _$DetectedAllergen {
  const factory DetectedAllergen({
    /// Nombre del alimento del catalogo que dispara la coincidencia.
    required String ingredientName,

    /// Nombre de la alergia declarada con la que coincide.
    required String allergenName,

    /// Severidad declarada, o `null` si el valor no se reconocio.
    DetectedAllergenSeverity? severity,
  }) = _DetectedAllergen;

  const DetectedAllergen._();
}

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

  // ---------------------------------------------------------------------
  // Modulo ClinicalRegistry (EP0002). Agregados en Mobile-3.
  // ---------------------------------------------------------------------

  /// 404 `food_item_not_found`. El alimento del catalogo no existe o fue
  /// desactivado.
  ///
  /// Alcanzable con la caja local de la busqueda: el catalogo se cachea en
  /// `food_catalog_cache` y una fila puede sobrevivir a la desactivacion del
  /// alimento en el servidor. Tambien llega por lote, dentro de `errors[]` de
  /// `POST /sync/batch`, donde se clasifica como falla permanente.
  const factory CauceApiError.foodItemNotFound() = FoodItemNotFoundError;

  /// 404 `custom_food_not_found`. El plato personalizado no existe o pertenece
  /// a otro paciente.
  const factory CauceApiError.customFoodNotFound() = CustomFoodNotFoundError;

  /// 409 `duplicate_custom_food`. El paciente ya tiene un plato con ese nombre.
  ///
  /// El constructor valida contra la lista ya cargada antes de enviar, asi que
  /// esto llega cuando la lista local quedo vieja.
  const factory CauceApiError.duplicateCustomFood() = DuplicateCustomFoodError;

  /// 409 `custom_food_in_use`. No se puede borrar un plato que alguna comida
  /// ya registrada referencia.
  const factory CauceApiError.customFoodInUse() = CustomFoodInUseError;

  /// 409 `duplicate_ingredient`. El mismo alimento aparece dos veces en el
  /// plato.
  ///
  /// La UI del constructor lo impide sumando proporciones en vez de repetir la
  /// fila. Se mapea para que un cambio de contrato no degrade a desconocido.
  const factory CauceApiError.duplicateIngredient() = DuplicateIngredientError;

  /// 404 `ingredient_not_found`. Se intento quitar un ingrediente que el plato
  /// no tiene.
  const factory CauceApiError.ingredientNotFound() = IngredientNotFoundError;

  /// 409 `unconfirmed_allergens` (US10 CA03). Hay coincidencias entre los
  /// ingredientes y las alergias declaradas, y el paciente todavia no las
  /// reconocio.
  ///
  /// **No es un error terminal**: es el paso intermedio del flujo. El cliente
  /// muestra [allergens], pide confirmacion explicita y reenvia con
  /// `confirmedAllergens: true`. El cruce lo hace el servidor contra el perfil;
  /// el cliente no lo recalcula.
  const factory CauceApiError.unconfirmedAllergens({
    required List<DetectedAllergen> allergens,
  }) = UnconfirmedAllergensError;

  /// 400 `invalid_meal_registration`. Alguna invariante de `Meal` del backend.
  ///
  /// Lo lanza la entidad de dominio y no FluentValidation, de modo que **no
  /// trae `errors` por campo**. Son siete invariantes: `client_guid` vacio,
  /// paciente vacio, fecha de consumo futura, fecha de creacion futura, ítems
  /// fuera de 1 a 50, ítem que no referencia exactamente un alimento del
  /// catalogo o uno personalizado, y cantidad menor o igual a cero.
  ///
  /// Las dos de fecha toleran 5 minutos de desfase de reloj del dispositivo,
  /// asi que un reloj levemente adelantado no las dispara.
  const factory CauceApiError.invalidMealRegistration() =
      InvalidMealRegistrationError;

  /// 404 `meal_not_found`. La comida no existe o pertenece a otro paciente.
  const factory CauceApiError.mealNotFound() = MealNotFoundError;

  /// 404 `symptom_not_found`. El sintoma no existe o pertenece a otro paciente.
  const factory CauceApiError.symptomNotFound() = SymptomNotFoundError;

  /// 404 `clinical_note_not_found`. La nota no existe o pertenece a otro
  /// paciente.
  const factory CauceApiError.clinicalNoteNotFound() =
      ClinicalNoteNotFoundError;

  /// 400 `invalid_clinical_note_association`. Una nota se asocia a exactamente
  /// una comida **o** un sintoma, nunca a las dos ni a ninguna.
  const factory CauceApiError.invalidClinicalNoteAssociation() =
      InvalidClinicalNoteAssociationError;

  /// 409 `idempotency_mismatch`. Se reuso un `client_guid` con una carga
  /// distinta de la del envio original.
  ///
  /// Señala un bug del cliente, no una accion del paciente: cada registro
  /// genera su UUID v4 una sola vez y el reintento debe repetirlo intacto.
  const factory CauceApiError.idempotencyMismatch() = IdempotencyMismatchError;

  /// 400 `domain_rule_violation`. Caso general de `DomainException` en el
  /// backend, para las reglas que no tienen un `errorCode` propio.
  ///
  /// [detail] trae el mensaje del servidor, en español y sin garantia de
  /// estabilidad: sirve para diagnostico, no para hacer `switch`.
  const factory CauceApiError.domainRuleViolation({String? detail}) =
      DomainRuleViolationError;

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

  /// 422 `patient_has_no_data_in_period`. El periodo pedido no tiene ningun
  /// registro (HU0024 CA02, CP063).
  ///
  /// **No es un fallo.** El backend comprueba `HasDataInPeriodAsync` antes de
  /// generar nada, justamente para no emitir un PDF vacio. La pantalla lo
  /// trata como una respuesta valida y sugiere otro rango.
  const factory CauceApiError.patientHasNoDataInPeriod() =
      PatientHasNoDataInPeriodError;

  /// 422 `report_period_invalid`. Invariante de dominio del periodo.
  ///
  /// Las reglas del validador (los dos extremos, orden, tope de 90 dias)
  /// responden **400 con `errors`**, no este codigo. Se mapea igual para no
  /// dejar el switch incompleto.
  const factory CauceApiError.reportPeriodInvalid() = ReportPeriodInvalidError;

  // Modulo Recommendations (EP0003). Mobile-5, bloque 6.

  /// 404 `recommendation_not_found`. No existe **o no es visible** para el
  /// paciente: en revision, rechazada, vencida o archivada. El backend no
  /// distingue los casos a proposito (acta A24), para no revelar que existe.
  const factory CauceApiError.recommendationNotFound() =
      RecommendationNotFoundError;

  /// 403 `recommendation_access_denied`. La recomendacion es de otro paciente.
  const factory CauceApiError.recommendationAccessDenied() =
      RecommendationAccessDeniedError;

  /// 409 `conflict_state`. La transicion pedida no vale desde el estado
  /// actual: entregar una ya entregada, o enviar feedback sobre una que no
  /// esta entregada o que ya lo tiene. Solo lo emite este modulo.
  const factory CauceApiError.conflictState() = ConflictStateError;

  /// 409 `recommendation_expired`. Vencio su ventana de 72 horas sin
  /// entregarse, y el propio intento de entrega la marco como vencida.
  const factory CauceApiError.recommendationExpired() =
      RecommendationExpiredError;

  /// 422 `insufficient_clinical_history`. Hay menos alimentos candidatos que
  /// el minimo del motor en los ultimos 14 dias.
  ///
  /// **No es un fallo para el paciente.** Lo recibe un disparo automatico que
  /// el paciente no pidio, y la pantalla lo trata como "todavia no hay
  /// recomendaciones", sin banner de error.
  const factory CauceApiError.insufficientClinicalHistory() =
      InsufficientClinicalHistoryError;

  /// 422 `all_candidates_filtered_by_allergies`. Las alergias declaradas
  /// dejaron sin ningun alimento que recomendar.
  const factory CauceApiError.allCandidatesFilteredByAllergies() =
      AllCandidatesFilteredByAllergiesError;

  /// 422 `no_active_model_version`. El backend no tiene una version del motor
  /// activa. Es una condicion del servidor, no del paciente.
  const factory CauceApiError.noActiveModelVersion() =
      NoActiveModelVersionError;

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
