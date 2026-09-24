// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Cauce';

  @override
  String get commonContinue => 'Continuar';

  @override
  String get commonCancel => 'Cancelar';

  @override
  String get commonBack => 'Volver';

  @override
  String get commonRetry => 'Reintentar';

  @override
  String get commonAccept => 'Aceptar';

  @override
  String get commonLoading => 'Cargando';

  @override
  String get splashLoading => 'Preparando tu sesión';

  @override
  String get loginTitle => 'Inicia sesión';

  @override
  String get loginSubtitle =>
      'Ingresa a tu cuenta para continuar con tu seguimiento';

  @override
  String get loginEmailLabel => 'Correo electrónico';

  @override
  String get loginEmailHint => 'tucorreo@ejemplo.com';

  @override
  String get loginPasswordLabel => 'Contraseña';

  @override
  String get loginPasswordHint => 'Tu contraseña';

  @override
  String get loginSubmit => 'Iniciar sesión';

  @override
  String get loginForgotPassword => 'Olvidé mi contraseña';

  @override
  String get loginCreateAccount => 'Crear cuenta';

  @override
  String get loginNoAccountPrompt => '¿No tienes cuenta?';

  @override
  String get loginShowPassword => 'Mostrar contraseña';

  @override
  String get loginHidePassword => 'Ocultar contraseña';

  @override
  String get registerTitle => 'Crea tu cuenta';

  @override
  String get registerSubtitle =>
      'Registrate para participar en el seguimiento nutricional';

  @override
  String get registerFullNameLabel => 'Nombre completo';

  @override
  String get registerFullNameHint => 'Nombre y apellidos';

  @override
  String get registerEmailLabel => 'Correo electrónico';

  @override
  String get registerEmailHint => 'tucorreo@ejemplo.com';

  @override
  String get registerPasswordLabel => 'Contraseña';

  @override
  String get registerPasswordHint => 'Mínimo 8 caracteres';

  @override
  String get registerPasswordConfirmLabel => 'Confirma tu contraseña';

  @override
  String get registerInvitationCodeLabel => 'Código de invitación';

  @override
  String get registerInvitationCodeHint => 'Opcional';

  @override
  String get registerConsentSectionTitle => 'Consentimiento informado';

  @override
  String get registerConsentCheckbox =>
      'He leido y acepto el consentimiento informado';

  @override
  String get registerConsentLoading => 'Cargando el consentimiento vigente';

  @override
  String get registerConsentUpdated =>
      'El consentimiento fue actualizado. Revisa los cambios antes de continuar.';

  @override
  String get registerSubmit => 'Crear cuenta';

  @override
  String get registerHasAccountPrompt => '¿Ya tienes cuenta?';

  @override
  String get passwordRecoveryTitle => 'Recupera tu contraseña';

  @override
  String get passwordRecoverySubtitle =>
      'Te enviaremos un enlace para restablecerla';

  @override
  String get passwordRecoveryEmailLabel => 'Correo electrónico';

  @override
  String get passwordRecoverySubmit => 'Enviar enlace';

  @override
  String get passwordRecoverySentTitle => 'Revisa tu correo';

  @override
  String get passwordRecoverySentBody =>
      'Si el correo existe en nuestro sistema, recibirás un enlace de recuperación válido por 30 minutos.';

  @override
  String get passwordRecoverySentBackToLogin => 'Volver a iniciar sesión';

  @override
  String get passwordResetTitle => 'Nueva contraseña';

  @override
  String get passwordResetSubtitle =>
      'Elige una contraseña que no hayas usado antes';

  @override
  String get passwordResetNewPasswordLabel => 'Nueva contraseña';

  @override
  String get passwordResetConfirmLabel => 'Confirma la nueva contraseña';

  @override
  String get passwordResetSubmit => 'Restablecer contraseña';

  @override
  String get passwordResetSuccessTitle => 'Contraseña actualizada';

  @override
  String get passwordResetSuccessBody =>
      'Ya puedes iniciar sesión con tu nueva contraseña.';

  @override
  String get passwordResetRequestNewLink => 'Solicitar un enlace nuevo';

  @override
  String get verifyEmailPendingTitle => 'Verifica tu correo';

  @override
  String verifyEmailPendingBody(String email) {
    return 'Registramos tu cuenta. Te enviamos un correo de verificación a $email. Sigue el enlace para activarla.';
  }

  @override
  String get verifyEmailPendingNoEmailHint =>
      'Si no recibiste el correo, comunícate con soporte.';

  @override
  String get verifyEmailPendingLogout => 'Cerrar sesión';

  @override
  String homeGreeting(String fullName) {
    return 'Hola, $fullName';
  }

  @override
  String get homeLogout => 'Cerrar sesión';

  @override
  String get validationRequired => 'Este campo es obligatorio';

  @override
  String get validationEmailInvalid => 'Ingresa un correo electrónico válido';

  @override
  String get validationEmailTooLong =>
      'El correo no puede superar los 150 caracteres';

  @override
  String get validationFullNameLength =>
      'El nombre debe tener entre 2 y 150 caracteres';

  @override
  String get validationPasswordTooShort =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get validationPasswordWeak =>
      'Debe incluir una mayuscula, una minuscula y un digito';

  @override
  String get validationPasswordMismatch => 'Las contraseñas no coinciden';

  @override
  String get validationInvitationCodeFormat =>
      'El código debe tener entre 8 y 20 caracteres, solo letras y números';

  @override
  String get validationConsentRequired =>
      'Debes aceptar el consentimiento informado para continuar';

  @override
  String get validationNumberInvalid => 'Ingresa un número válido';

  @override
  String get validationDateOfBirthFuture =>
      'La fecha de nacimiento no puede ser futura';

  @override
  String validationAgeOutOfRange(int min, int max) {
    return 'El piloto admite participantes entre $min y $max años';
  }

  @override
  String get validationDiagnosisDateFuture =>
      'La fecha de diagnóstico no puede ser futura';

  @override
  String get validationWeightOutOfRange =>
      'Ingresa un peso mayor que 0 y menor que 500 kg';

  @override
  String get validationHeightOutOfRange =>
      'Ingresa una estatura mayor que 0 y menor que 250 cm';

  @override
  String validationTextTooLong(int max) {
    return 'No puede superar los $max caracteres';
  }

  @override
  String get errorValidation => 'Revisa los datos ingresados';

  @override
  String get errorConsentTextMismatch =>
      'El consentimiento informado cambio. Vuelve a leerlo y aceptalo.';

  @override
  String get errorInvalidInvitationCode => 'El código de invitación no existe';

  @override
  String get errorExpiredInvitationCode => 'El código de invitación venció';

  @override
  String get errorInvitationCodeAlreadyUsed =>
      'El código de invitación ya fue usado';

  @override
  String get errorNutritionistPendingActivation =>
      'Este nutricionista todavía no activó su cuenta. Intenta de nuevo más tarde o comunícate directamente con él.';

  @override
  String get errorNutritionistUnavailable =>
      'Este código ya no está disponible. Comunícate con tu nutricionista para obtener uno nuevo.';

  @override
  String get errorPatientAlreadyAssigned =>
      'Ya tienes un nutricionista asignado';

  @override
  String get errorPatientProfileNotFound =>
      'Todavía no registraste tu perfil clínico';

  @override
  String get errorDuplicateProfile => 'Tu perfil clínico ya está registrado';

  @override
  String get errorInvalidBiometricValue =>
      'Alguno de los datos clínicos está fuera del rango permitido. Revísalos e inténtalo de nuevo.';

  @override
  String get errorAllergyNotFound =>
      'Esta alergia ya no está disponible en el catálogo';

  @override
  String get errorDuplicateAllergy => 'Esta alergia ya figura en tu perfil';

  @override
  String get errorInvalidIbsSssDimension =>
      'Alguna respuesta quedó fuera del rango de 0 a 100';

  @override
  String get errorDuplicateBaselineAssessment =>
      'Tu cuestionario de línea base ya está registrado';

  @override
  String get mealsTitle => 'Registrar comida';

  @override
  String get mealsAddFood => 'Agregar alimento';

  @override
  String get mealsSearchTitle => 'Buscar alimento';

  @override
  String get mealsSearchHint => 'Escribe el nombre del alimento';

  @override
  String get mealsSearchNoResults => 'No encontramos alimentos con ese nombre';

  @override
  String get mealsSuggestionsFrequent => 'Los que más registras';

  @override
  String get mealsSuggestionsRecent => 'Registrados hoy';

  @override
  String get mealsSuggestionsCatalog => 'Del catálogo';

  @override
  String get mealsQuantityLabel => 'Cantidad';

  @override
  String get mealsUnitLabel => 'Unidad';

  @override
  String get mealsTimeLabel => 'Momento del día';

  @override
  String get mealsItemsLabel => 'Alimentos de esta comida';

  @override
  String get mealsItemsEmpty => 'Todavía no agregaste ningún alimento';

  @override
  String get mealsRemoveItem => 'Quitar';

  @override
  String get mealsSubmit => 'Registrar comida';

  @override
  String get mealsRegistered => 'Comida registrada';

  @override
  String get mealsQueuedOffline =>
      'Comida guardada. Se enviará cuando vuelva la conexión.';

  @override
  String get mealsRegisterAnother => 'Registrar otra';

  @override
  String get mealsIssueMissingMealTime => 'Elige el momento del día';

  @override
  String get mealsIssueNoItems => 'Agrega al menos un alimento';

  @override
  String get mealsIssueTooManyItems => 'Una comida admite hasta 50 alimentos';

  @override
  String get mealsIssueInvalidQuantity => 'La cantidad debe ser mayor que cero';

  @override
  String get mealsIssueInvalidReference =>
      'Cada alimento debe venir del catálogo o de tus platos';

  @override
  String get mealsIssueFutureConsumedAt =>
      'La fecha de consumo no puede estar en el futuro';

  @override
  String get mealsFodmapLow => 'Carga FODMAP baja';

  @override
  String get mealsFodmapModerate => 'Carga FODMAP moderada';

  @override
  String get mealsFodmapHigh => 'Carga FODMAP alta';

  @override
  String get mealTimeBreakfast => 'Desayuno';

  @override
  String get mealTimeLunch => 'Almuerzo';

  @override
  String get mealTimeDinner => 'Cena';

  @override
  String get mealTimeSnack => 'Refrigerio';

  @override
  String get measurementUnitGrams => 'Gramos';

  @override
  String get measurementUnitCups => 'Tazas';

  @override
  String get measurementUnitUnits => 'Unidades';

  @override
  String get measurementUnitOunces => 'Onzas';

  @override
  String get measurementUnitTablespoons => 'Cucharadas';

  @override
  String get customFoodTitle => 'Crear plato personalizado';

  @override
  String get customFoodNameLabel => 'Nombre del plato';

  @override
  String get customFoodNameHint => 'Por ejemplo: Mi lomo saltado';

  @override
  String get customFoodPortionLabel => 'Tamaño de porción (g)';

  @override
  String get customFoodIngredientsLabel => 'Ingredientes';

  @override
  String get customFoodIngredientsEmpty => 'Todavía no agregaste ingredientes';

  @override
  String get customFoodAddIngredient => 'Agregar ingrediente';

  @override
  String get customFoodProportionLabel => 'Cantidad en el plato (g)';

  @override
  String get customFoodSubmit => 'Guardar plato';

  @override
  String get customFoodCreated => 'Plato guardado';

  @override
  String customFoodWeightDelta(String grams) {
    return 'Los ingredientes suman $grams g más que la porción declarada';
  }

  @override
  String customFoodWeightDeltaShort(String grams) {
    return 'Los ingredientes suman $grams g menos que la porción declarada';
  }

  @override
  String get customFoodEstimateTitle => 'Perfil nutricional estimado';

  @override
  String get customFoodEstimateNote =>
      'Es una estimación por 100 g a partir de los ingredientes. No se guarda con el plato.';

  @override
  String get customFoodEstimatePartial =>
      'Falta la composición de algún ingrediente, así que la estimación es parcial.';

  @override
  String customFoodEstimateCalories(String value) {
    return '$value kcal';
  }

  @override
  String customFoodEstimateProtein(String value) {
    return 'Proteina $value g';
  }

  @override
  String customFoodEstimateCarbs(String value) {
    return 'Carbohidratos $value g';
  }

  @override
  String customFoodEstimateFat(String value) {
    return 'Grasa $value g';
  }

  @override
  String customFoodEstimateFiber(String value) {
    return 'Fibra $value g';
  }

  @override
  String get customFoodIssueInvalidName =>
      'Ponle un nombre de hasta 150 caracteres';

  @override
  String get customFoodIssueDuplicateName =>
      'Ya tienes un plato con ese nombre';

  @override
  String get customFoodIssueInvalidPortion =>
      'La porción debe ser mayor que cero';

  @override
  String get customFoodIssueNoIngredients => 'Agrega al menos un ingrediente';

  @override
  String get customFoodIssueInvalidProportion =>
      'Cada ingrediente debe tener una cantidad mayor que cero';

  @override
  String get customFoodIssueDuplicateIngredient =>
      'Un ingrediente aparece dos veces';

  @override
  String get customFoodAllergenTitle => 'Revisa estos ingredientes';

  @override
  String get customFoodAllergenBody =>
      'Estos ingredientes coinciden con alergias que declaraste en tu perfil.';

  @override
  String customFoodAllergenEntry(String ingredient, String allergen) {
    return '$ingredient coincide con $allergen';
  }

  @override
  String get customFoodAllergenSeverityMild => 'Declarada como leve';

  @override
  String get customFoodAllergenSeverityModerate => 'Declarada como moderada';

  @override
  String get customFoodAllergenSeveritySevere => 'Declarada como severa';

  @override
  String get customFoodAllergenSeverityUnknown => 'Severidad no informada';

  @override
  String get customFoodAllergenConfirm => 'Entiendo, guardar igual';

  @override
  String get customFoodAllergenCancel => 'Volver y editar';

  @override
  String get symptomsTitle => 'Registrar síntoma';

  @override
  String get symptomsTypeLabel => 'Qué sentiste';

  @override
  String get symptomsIntensityLabel => 'Intensidad';

  @override
  String get symptomsIntensityMin => 'Leve';

  @override
  String get symptomsIntensityMax => 'Muy intenso';

  @override
  String get symptomsSubmit => 'Registrar síntoma';

  @override
  String get symptomsRegistered => 'Síntoma registrado';

  @override
  String get symptomsQueuedOffline =>
      'Síntoma guardado. Se enviará cuando vuelva la conexión.';

  @override
  String get symptomsRegisterAnother => 'Registrar otro';

  @override
  String get symptomsMealAssociated =>
      'Lo asociamos con la comida que registraste antes.';

  @override
  String get symptomsMealNotAssociated =>
      'No habia una comida registrada en las 4 horas previas.';

  @override
  String get symptomsMealPending =>
      'La relación con tus comidas se calcula al sincronizar.';

  @override
  String get symptomsIssueMissingType => 'Elige qué sentiste';

  @override
  String get symptomsIssueMissingIntensity => 'Indica la intensidad';

  @override
  String get symptomsIssueIntensityOutOfRange => 'La intensidad va de 1 a 100';

  @override
  String get symptomsIssueFutureOccurredAt =>
      'El momento no puede estar en el futuro';

  @override
  String get symptomTypeAbdominalPain => 'Dolor abdominal';

  @override
  String get symptomTypeBloating => 'Distensión abdominal';

  @override
  String get symptomTypeFlatulence => 'Flatulencia';

  @override
  String get symptomTypeDiarrhea => 'Diarrea';

  @override
  String get symptomTypeConstipation => 'Estreñimiento';

  @override
  String get symptomTypeNausea => 'Náuseas';

  @override
  String get symptomTypeReflux => 'Reflujo o acidez';

  @override
  String get symptomTypeUrgency => 'Urgencia para evacuar';

  @override
  String get symptomTypeOther => 'Otro';

  @override
  String get historyTitle => 'Mi registro';

  @override
  String get historyEmpty => 'Todavía no registraste nada';

  @override
  String historyMealIntensity(int value) {
    return 'Intensidad $value de 100';
  }

  @override
  String get historyStatePending => 'Pendiente de enviar';

  @override
  String get historyStateFailed => 'No se pudo enviar';

  @override
  String get historyFailedExplanation =>
      'Este registro no se pudo enviar y no va a reintentarse. Puedes descartarlo.';

  @override
  String get historyDiscard => 'Descartar';

  @override
  String get historyAddNote => 'Agregar nota';

  @override
  String get historyNoteUnavailable => 'Disponible cuando se sincronice';

  @override
  String get historyMealAssociated => 'Asociado a una comida';

  @override
  String get historyRefresh => 'Actualizar';

  @override
  String get clinicalNoteTitle => 'Agregar nota';

  @override
  String get clinicalNoteSubtitle =>
      'Anota lo que quieras recordar sobre este registro. Tu nutricionista lo vera junto al dato.';

  @override
  String get clinicalNoteContentLabel => 'Nota';

  @override
  String get clinicalNoteContentHint =>
      'Por ejemplo: comi apurado, en la calle';

  @override
  String clinicalNoteRemaining(int count) {
    return 'Quedan $count caracteres';
  }

  @override
  String get clinicalNoteTooLong =>
      'La nota no puede superar los 500 caracteres';

  @override
  String get clinicalNoteSubmit => 'Guardar nota';

  @override
  String get clinicalNoteSaved => 'Nota guardada';

  @override
  String get ibsSssPeriodicTitle => 'Cuestionario de seguimiento';

  @override
  String get ibsSssPeriodicSubtitle =>
      'Responde las cinco preguntas pensando en los últimos diez días.';

  @override
  String get ibsSssPeriodicSubmit => 'Enviar cuestionario';

  @override
  String get ibsSssEvolutionTitle => 'Tu evolución';

  @override
  String get ibsSssEvolutionEmpty =>
      'Con una sola evaluación todavía no hay evolución que mostrar.';

  @override
  String ibsSssEvolutionRange(int first, int last) {
    return 'De $first a $last puntos';
  }

  @override
  String ibsSssEvolutionDelta(int value) {
    return '$value puntos respecto de tu línea base';
  }

  @override
  String get ibsSssEvolutionImprovement =>
      'Es una reducción de 50 puntos o más respecto de tu línea base. Tu nutricionista lo interpretará contigo.';

  @override
  String get ibsSssReminderTitle => 'Toca tu cuestionario de seguimiento';

  @override
  String get ibsSssReminderBody =>
      'Pasaron los catorce días desde tu última evaluación.';

  @override
  String get ibsSssReminderAction => 'Responder ahora';

  @override
  String get errorFoodItemNotFound =>
      'Ese alimento ya no está disponible en el catálogo';

  @override
  String get errorCustomFoodNotFound =>
      'No encontramos ese plato personalizado';

  @override
  String get errorDuplicateCustomFood => 'Ya tienes un plato con ese nombre';

  @override
  String get errorCustomFoodInUse =>
      'No puedes eliminar este plato porque ya lo usaste en una comida registrada';

  @override
  String get errorDuplicateIngredient => 'Ese ingrediente ya está en el plato';

  @override
  String get errorIngredientNotFound =>
      'Ese ingrediente ya no está en el plato';

  @override
  String get errorUnconfirmedAllergens =>
      'Este plato contiene ingredientes que coinciden con tus alergias declaradas';

  @override
  String get errorInvalidMealRegistration =>
      'No pudimos registrar la comida. Revisa los datos e intenta de nuevo.';

  @override
  String get errorMealNotFound => 'No encontramos esa comida registrada';

  @override
  String get errorSymptomNotFound => 'No encontramos ese síntoma registrado';

  @override
  String get errorClinicalNoteNotFound => 'No encontramos esa nota';

  @override
  String get errorInvalidClinicalNoteAssociation =>
      'Una nota se asocia a una comida o a un síntoma, no a los dos';

  @override
  String get errorIdempotencyMismatch =>
      'Hubo un conflicto al guardar este registro. Intenta de nuevo.';

  @override
  String get errorDomainRuleViolation =>
      'No pudimos completar la operación. Revisa los datos e intenta de nuevo.';

  @override
  String get errorDuplicateEmail => 'Ya existe una cuenta con este correo';

  @override
  String get errorKeycloakIntegration =>
      'No pudimos crear tu cuenta. Intenta de nuevo en unos minutos.';

  @override
  String get errorInvalidCredentials => 'Credenciales incorrectas';

  @override
  String errorAccountLocked(int minutes) {
    return 'Cuenta bloqueada por intentos fallidos. Vuelve a intentar en $minutes minutos.';
  }

  @override
  String get errorAccountLockedSoon =>
      'Cuenta bloqueada por intentos fallidos. Vuelve a intentar en menos de un minuto.';

  @override
  String get errorInvalidRefreshToken =>
      'Tu sesión expiró. Inicia sesión de nuevo.';

  @override
  String get errorInvalidPasswordResetToken =>
      'El enlace de recuperación no es válido';

  @override
  String get errorExpiredPasswordResetToken =>
      'El enlace de recuperación venció o ya fue usado';

  @override
  String get errorUserLocalMissing =>
      'Hay un problema con tu cuenta. Comunícate con soporte.';

  @override
  String get errorInternalServer =>
      'Ocurrio un error en el servidor. Intenta de nuevo.';

  @override
  String get errorConsentRecordNotFound =>
      'No encontramos tu consentimiento registrado';

  @override
  String get errorForbidden => 'No tienes permiso para realizar esta acción';

  @override
  String errorRateLimited(int seconds) {
    return 'Demasiados intentos. Espera $seconds segundos.';
  }

  @override
  String get errorNetwork =>
      'Sin conexión. Verifica tu internet e intenta de nuevo.';

  @override
  String get errorUnknown => 'Ocurrio un error inesperado. Intenta de nuevo.';

  @override
  String onboardingStepLabel(int current, int total) {
    return 'Paso $current de $total';
  }

  @override
  String get onboardingDefer => 'Completar más tarde';

  @override
  String get onboardingReminderTitle => 'Te falta completar tu perfil';

  @override
  String get onboardingReminderBodyProfile =>
      'Tu nutricionista necesita tus datos clínicos para darte recomendaciones.';

  @override
  String get onboardingReminderBodyBaseline =>
      'Falta el cuestionario inicial. Es el punto de partida para medir tu evolución.';

  @override
  String get onboardingReminderAction => 'Continuar ahora';

  @override
  String get clinicalProfileTitle => 'Tu perfil clínico';

  @override
  String get clinicalProfileSubtitle =>
      'Estos datos le permiten a tu nutricionista ajustar tus recomendaciones.';

  @override
  String get clinicalProfileDateOfBirthLabel => 'Fecha de nacimiento';

  @override
  String get clinicalProfileDatePlaceholder => 'Selecciona una fecha';

  @override
  String get clinicalProfileBiologicalSexLabel => 'Sexo biológico';

  @override
  String get biologicalSexFemale => 'Femenino';

  @override
  String get biologicalSexMale => 'Masculino';

  @override
  String get biologicalSexOther => 'Otro';

  @override
  String get clinicalProfileWeightLabel => 'Peso (kg)';

  @override
  String get clinicalProfileWeightHint => 'Por ejemplo, 62.5';

  @override
  String get clinicalProfileHeightLabel => 'Estatura (cm)';

  @override
  String get clinicalProfileHeightHint => 'Por ejemplo, 162';

  @override
  String get clinicalProfileIbsSubtypeLabel =>
      'Subtipo de síndrome de intestino irritable';

  @override
  String get ibsSubtypeD => 'SII-D';

  @override
  String get ibsSubtypeDDescription => 'Con predominio de diarrea';

  @override
  String get ibsSubtypeC => 'SII-C';

  @override
  String get ibsSubtypeCDescription => 'Con predominio de estreñimiento';

  @override
  String get ibsSubtypeM => 'SII-M';

  @override
  String get ibsSubtypeMDescription => 'Mixto: alterna diarrea y estreñimiento';

  @override
  String get ibsSubtypeU => 'SII-NC';

  @override
  String get ibsSubtypeUDescription => 'No clasificado';

  @override
  String get clinicalProfileDiagnosisDateLabel =>
      'Fecha de diagnóstico (opcional)';

  @override
  String get clinicalProfileMedicationsLabel => 'Medicación actual (opcional)';

  @override
  String get clinicalProfileMedicationsHint =>
      'Nombre y dosis, si tomas algo por el SII';

  @override
  String get clinicalProfileSubmit => 'Continuar';

  @override
  String get bmiTitle => 'Índice de masa corporal';

  @override
  String bmiValue(String value) {
    return '$value kg/m²';
  }

  @override
  String get bmiCategoryUnderweight => 'Bajo peso';

  @override
  String get bmiCategoryNormal => 'Peso normal';

  @override
  String get bmiCategoryOverweight => 'Sobrepeso';

  @override
  String get bmiCategoryObese => 'Obesidad';

  @override
  String get bmiNote =>
      'Referencia de la OMS. Tu nutricionista lo interpreta junto al resto de tu historia clínica.';

  @override
  String get bmiPending => 'Completa peso y estatura para verlo.';

  @override
  String get allergiesTitle => 'Alergias e intolerancias';

  @override
  String get allergiesSubtitle =>
      'Marca las que tengas. Puedes dejarlo vacío si no aplica.';

  @override
  String get allergiesLoading => 'Cargando el catálogo';

  @override
  String get allergiesEmpty => 'No hay alergias en el catálogo.';

  @override
  String get allergySeverityLabel => 'Severidad';

  @override
  String get allergySeverityMild => 'Leve';

  @override
  String get allergySeverityModerate => 'Moderada';

  @override
  String get allergySeveritySevere => 'Severa';

  @override
  String get allergyNotesLabel => 'Nota (opcional)';

  @override
  String get allergyTypeAllergy => 'Alergia';

  @override
  String get allergyTypeIntolerance => 'Intolerancia';

  @override
  String get allergyTypeSensitivity => 'Sensibilidad';

  @override
  String get ibsSssTitle => 'Cuestionario inicial';

  @override
  String get ibsSssSubtitle =>
      'Responde las cinco preguntas pensando en los últimos diez días.';

  @override
  String get ibsSssQuestionPainSeverity =>
      '¿Qué tan intenso fue tu dolor abdominal?';

  @override
  String get ibsSssPainSeverityMin => 'Sin dolor';

  @override
  String get ibsSssPainSeverityMax => 'Muy intenso';

  @override
  String get ibsSssQuestionPainFrequency =>
      '¿Con qué frecuencia tuviste dolor abdominal?';

  @override
  String get ibsSssPainFrequencyMin => 'Ningún día';

  @override
  String get ibsSssPainFrequencyMax => 'Todos los días';

  @override
  String get ibsSssQuestionBloatingSeverity =>
      '¿Qué tan intensa fue la distensión o hinchazón?';

  @override
  String get ibsSssBloatingSeverityMin => 'Sin distensión';

  @override
  String get ibsSssBloatingSeverityMax => 'Muy intensa';

  @override
  String get ibsSssQuestionBowelHabits =>
      '¿Qué tan insatisfecho estuviste con tu hábito intestinal?';

  @override
  String get ibsSssBowelHabitsMin => 'Muy satisfecho';

  @override
  String get ibsSssBowelHabitsMax => 'Muy insatisfecho';

  @override
  String get ibsSssQuestionLifeInterference =>
      '¿Cuánto interfirieron los síntomas en tu vida diaria?';

  @override
  String get ibsSssLifeInterferenceMin => 'Nada';

  @override
  String get ibsSssLifeInterferenceMax => 'Muchísimo';

  @override
  String ibsSssPending(int count) {
    return 'Faltan $count preguntas por responder.';
  }

  @override
  String get ibsSssSubmit => 'Enviar cuestionario';

  @override
  String get ibsSssResultTitle => 'Registramos tu cuestionario';

  @override
  String ibsSssResultScore(int score) {
    return 'Puntaje: $score de 500';
  }

  @override
  String get ibsSssSeverityMild => 'Severidad leve';

  @override
  String get ibsSssSeverityModerate => 'Severidad moderada';

  @override
  String get ibsSssSeveritySevere => 'Severidad severa';

  @override
  String get ibsSssResultNote =>
      'Es tu punto de partida para medir la evolución. Tu nutricionista lo revisa contigo en consulta.';

  @override
  String get ibsSssResultContinue => 'Ir al inicio';

  @override
  String get evolutionOpen => 'Ver tu evolución completa';

  @override
  String get evolutionLoadError => 'No pudimos cargar tu evolución';

  @override
  String get evolutionEmpty => 'Todavía no registraste ninguna evaluación.';

  @override
  String evolutionScore(int score) {
    return '$score / 500';
  }

  @override
  String get evolutionRangeLabel => 'Período';

  @override
  String get evolutionRangeLastMonth => 'Último mes';

  @override
  String get evolutionRangeLastQuarter => 'Últimos 3 meses';

  @override
  String get evolutionRangeAll => 'Todo';

  @override
  String get evolutionRangeEmpty =>
      'No hay evaluaciones en este período. Probá con uno más amplio.';

  @override
  String get evolutionPercentLabel => 'Cambio respecto de tu línea base';

  @override
  String evolutionPercentDown(String percent) {
    return '$percent % menos';
  }

  @override
  String evolutionPercentUp(String percent) {
    return '$percent % más';
  }

  @override
  String get evolutionPercentSame => 'Igual que tu línea base';

  @override
  String evolutionChartSemantics(int count, int first, int last) {
    return 'Gráfico de tu puntaje IBS-SSS: $count evaluaciones, de $first a $last puntos.';
  }

  @override
  String evolutionPointTooltip(int score, String date) {
    return '$score puntos el $date';
  }

  @override
  String get evolutionBaselineOnlyTitle => 'Tu línea base';

  @override
  String get evolutionBaselineOnlyBody =>
      'Tu gráfico completo va a aparecer acá después de tu primera evaluación periódica.';

  @override
  String evolutionNextAssessment(String date) {
    return 'Próxima evaluación: $date';
  }

  @override
  String get profileTitle => 'Tu perfil';

  @override
  String get profileOpen => 'Abrir tu perfil';

  @override
  String get profileClinicalSection => 'Mi perfil clínico';

  @override
  String profileAge(int age) {
    return '$age años';
  }

  @override
  String get profileAllergiesNone => 'Sin alergias declaradas';

  @override
  String profileAllergiesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count alergias declaradas',
      one: '1 alergia declarada',
    );
    return '$_temp0';
  }

  @override
  String get profilePrivacySection => 'Privacidad y datos';

  @override
  String get profilePrivacyEntry => 'Tu consentimiento informado';

  @override
  String get profilePrivacyEntryHint =>
      'Consulta y descarga el documento que aceptaste';

  @override
  String get profileLoadError => 'No pudimos cargar tu perfil';

  @override
  String get profileSettings => 'Ajustes y privacidad';

  @override
  String get profileTrackingSection => 'Mi seguimiento';

  @override
  String get profileTrackingStart => 'Inicio del piloto';

  @override
  String get profileTrackingElapsed => 'Tiempo transcurrido';

  @override
  String profileTrackingElapsedWeeks(int weeks) {
    String _temp0 = intl.Intl.pluralLogic(
      weeks,
      locale: localeName,
      other: '$weeks semanas',
      one: '1 semana',
    );
    return '$_temp0';
  }

  @override
  String get profileTrackingElapsedFresh => 'Menos de una semana';

  @override
  String get profileTrackingNutritionist => 'Mi nutricionista';

  @override
  String get profileTrackingNutritionistPending => 'Pendiente de asignación';

  @override
  String get profileClinicalSubtype => 'Subtipo de SII';

  @override
  String get profileEvolutionSection => 'Mi evolución IBS-SSS';

  @override
  String get profileEvolutionBaseline => 'Línea base';

  @override
  String get profileEvolutionLatest => 'Último puntaje';

  @override
  String get profileEvolutionChange => 'Cambio acumulado';

  @override
  String profileEvolutionScore(int score) {
    return '$score / 500';
  }

  @override
  String profileEvolutionChangeDown(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points puntos menos',
      one: '1 punto menos',
    );
    return '$_temp0';
  }

  @override
  String profileEvolutionChangeUp(int points) {
    String _temp0 = intl.Intl.pluralLogic(
      points,
      locale: localeName,
      other: '$points puntos más',
      one: '1 punto más',
    );
    return '$_temp0';
  }

  @override
  String get profileEvolutionChangeSame => 'Igual que tu línea base';

  @override
  String get profileEvolutionAchievement => 'Respuesta clínica significativa';

  @override
  String get profileEvolutionOngoing => 'Sigues en tu proceso de seguimiento';

  @override
  String get profileEvolutionEmpty =>
      'Completa tu primera evaluación para ver tu evolución acá.';

  @override
  String get profileEvolutionEmptyAction => 'Responder el cuestionario';

  @override
  String get profileEdit => 'Editar mi información';

  @override
  String get profileEditUnavailable =>
      'La edición de tus datos llega en una próxima versión.';

  @override
  String get privacyTitle => 'Privacidad y datos';

  @override
  String get privacySubtitle =>
      'Tus derechos sobre la información que Cauce guarda de ti, según la Ley N.° 29733.';

  @override
  String get privacyConsentTitle => 'Consentimiento informado';

  @override
  String get privacyConsentBody =>
      'Aceptaste participar en el piloto clínico al crear tu cuenta. Ese registro quedó guardado de forma permanente y no puede modificarse ni eliminarse.';

  @override
  String get privacyConsentDownload => 'Descargar en PDF';

  @override
  String get privacyConsentDownloadHint =>
      'Se abrirá el menú para compartir, desde donde puedes guardarlo.';

  @override
  String get privacyConsentDownloaded =>
      'Listo. El documento corresponde a la versión que aceptaste.';

  @override
  String privacyConsentVersion(String version) {
    return 'Versión $version';
  }

  @override
  String privacyConsentAcceptedOn(String date) {
    return 'Aceptado el $date';
  }

  @override
  String get privacyConsentLoading => 'Cargando tu consentimiento';

  @override
  String get privacyConsentTextUnavailable =>
      'No conservamos el texto de esta versión, así que no podemos generar el PDF. Tu aceptación sigue registrada y es válida. Si necesitas una copia, comunícate con tu nutricionista.';

  @override
  String get navHome => 'Inicio';

  @override
  String get navJournal => 'Diario';

  @override
  String get navAdvice => 'Consejos';

  @override
  String get navProfile => 'Perfil';

  @override
  String get fabQuickAction => 'Acción rápida';

  @override
  String get fabCloseMenu => 'Cerrar menú';

  @override
  String get fabLogMeal => 'Registrar comida';

  @override
  String get fabLogSymptom => 'Registrar síntoma';

  @override
  String get fabIbsSss => 'Cuestionario IBS-SSS';

  @override
  String get recommendationsTitle => 'Consejos';

  @override
  String get recommendationsEmptyTitle => 'Aún no hay consejos aprobados';

  @override
  String get recommendationsEmptyBody =>
      'Cuando tu nutricionista apruebe una recomendación para ti, la vas a encontrar acá.';

  @override
  String get recommendationsLockedTitle => 'Disponible al completar tu perfil';

  @override
  String get recommendationsLockedBody =>
      'Tus consejos se arman a partir de tu perfil clínico y de tu primera evaluación. Completa esos dos pasos y los activamos.';

  @override
  String get recommendationsLockedAction => 'Continuar donde quedé';

  @override
  String get profileSessionSection => 'Tu sesión';

  @override
  String get profileLogout => 'Cerrar sesión';

  @override
  String get profileLogoutHint =>
      'Tus registros quedan guardados en este dispositivo';

  @override
  String get profileLogoutConfirmTitle => '¿Cerrar tu sesión?';

  @override
  String get profileLogoutConfirmBody =>
      'Vas a volver a la pantalla de inicio de sesión. Lo que ya registraste se conserva y se sincroniza cuando vuelvas a entrar.';

  @override
  String get historyToday => 'Hoy';

  @override
  String get historyEmptyTodayTitle => 'Aún no tienes comidas registradas hoy';

  @override
  String get historyEmptyTodayBody =>
      'Cuando registres una comida, aparecerá aquí en tu diario.';

  @override
  String get historyEmptyTodayAction => 'Registrar primera comida';

  @override
  String get historyTodayNothingYet => 'Todavía no registraste nada hoy.';

  @override
  String get historySyncPending => 'Pendiente de sincronizar';

  @override
  String get historySyncDone => 'Sincronizado';

  @override
  String get historySyncFailed => 'No se pudo sincronizar';

  @override
  String historyIntensityBadge(int value) {
    return 'Intensidad $value';
  }

  @override
  String historyMealAssociatedWith(String meal, String delay) {
    return 'Asociado con $meal, $delay después';
  }

  @override
  String historyDelayHoursMinutes(int hours, int minutes) {
    return '$hours h $minutes min';
  }

  @override
  String historyDelayMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get historyFodmapLow => 'Bajo en FODMAP';

  @override
  String get historyFodmapModerate => 'Moderado FODMAP';

  @override
  String get historyFodmapHigh => 'Alto en FODMAP';

  @override
  String get mealsMyDishes => 'Mis platos';

  @override
  String get mealsOwnDishBadge => 'Plato propio · no validado';

  @override
  String get mealsOwnDishesOffline =>
      'Tus platos propios se cargan con conexión. Los del catálogo se pueden buscar igual.';

  @override
  String get mealsSearchNoResultsTitle => 'No encontramos ese alimento';

  @override
  String get mealsSearchNoResultsBody =>
      'Si es una preparación tuya, puedes crearla como plato personalizado y usarla en tus comidas.';

  @override
  String get mealsCreateCustomFood => 'Crear alimento personalizado';

  @override
  String get fabHintCompleteProfile =>
      'Completa tu perfil clínico para registrar';

  @override
  String get fabHintBaselinePending => 'Primero responde tu evaluación inicial';

  @override
  String fabHintNotDue(String date) {
    return 'Disponible el $date';
  }

  @override
  String get fabIbsSssLockedTitle => 'Todavía no toca responderlo';

  @override
  String fabIbsSssLockedBody(String date) {
    return 'Se responde cada catorce días, para que la comparación con tu línea base sea válida. El próximo se habilita el $date.';
  }

  @override
  String get fabLockedGeneric =>
      'Esto se habilita cuando completes tu perfil clínico';

  @override
  String get journalLockedTitle => 'Disponible al completar tu perfil';

  @override
  String get journalLockedBody =>
      'Tu diario se habilita cuando guardas tu perfil clínico. Es un paso corto y lo puedes retomar ahora.';

  @override
  String get journalLockedAction => 'Continuar donde quedé';

  @override
  String mealsIssueQuantityOutOfRange(String unit, String max) {
    return 'Indica una cantidad entre 0 y $max $unit';
  }

  @override
  String get homeScoreTitle => 'Tu puntaje IBS-SSS';

  @override
  String get homeScoreEmpty =>
      'Tu primera evaluación todavía no está registrada.';

  @override
  String get homeScoreBaseline =>
      'Es tu línea base, el punto de partida de tu seguimiento.';

  @override
  String homeScoreDelta(String value) {
    return '$value puntos respecto de tu línea base';
  }

  @override
  String homeScoreNext(String date) {
    return 'Próximo cuestionario: $date';
  }

  @override
  String get homeScoreDue => 'Tu próximo cuestionario ya está disponible';

  @override
  String get homeTodayTitle => 'Hoy';

  @override
  String get homeTodayEmpty => 'Todavía no registraste nada hoy';

  @override
  String homeTodayMeals(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count comidas',
      one: '1 comida',
      zero: 'Sin comidas',
    );
    return '$_temp0';
  }

  @override
  String homeTodaySymptoms(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count síntomas',
      one: '1 síntoma',
      zero: 'sin síntomas',
    );
    return '$_temp0';
  }

  @override
  String get homeTodayOpen => 'Ver mi diario';
}
