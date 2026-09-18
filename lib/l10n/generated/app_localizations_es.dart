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
  String get splashLoading => 'Preparando tu sesion';

  @override
  String get loginTitle => 'Inicia sesion';

  @override
  String get loginSubtitle =>
      'Ingresa a tu cuenta para continuar con tu seguimiento';

  @override
  String get loginEmailLabel => 'Correo electronico';

  @override
  String get loginEmailHint => 'tucorreo@ejemplo.com';

  @override
  String get loginPasswordLabel => 'Contrasena';

  @override
  String get loginPasswordHint => 'Tu contrasena';

  @override
  String get loginSubmit => 'Iniciar sesion';

  @override
  String get loginForgotPassword => 'Olvide mi contrasena';

  @override
  String get loginCreateAccount => 'Crear cuenta';

  @override
  String get loginNoAccountPrompt => 'No tienes cuenta?';

  @override
  String get loginShowPassword => 'Mostrar contrasena';

  @override
  String get loginHidePassword => 'Ocultar contrasena';

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
  String get registerEmailLabel => 'Correo electronico';

  @override
  String get registerEmailHint => 'tucorreo@ejemplo.com';

  @override
  String get registerPasswordLabel => 'Contrasena';

  @override
  String get registerPasswordHint => 'Minimo 8 caracteres';

  @override
  String get registerPasswordConfirmLabel => 'Confirma tu contrasena';

  @override
  String get registerInvitationCodeLabel => 'Codigo de invitacion';

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
  String get registerHasAccountPrompt => 'Ya tienes cuenta?';

  @override
  String get passwordRecoveryTitle => 'Recupera tu contrasena';

  @override
  String get passwordRecoverySubtitle =>
      'Te enviaremos un enlace para restablecerla';

  @override
  String get passwordRecoveryEmailLabel => 'Correo electronico';

  @override
  String get passwordRecoverySubmit => 'Enviar enlace';

  @override
  String get passwordRecoverySentTitle => 'Revisa tu correo';

  @override
  String get passwordRecoverySentBody =>
      'Si el correo existe en nuestro sistema, recibiras un enlace de recuperacion valido por 30 minutos.';

  @override
  String get passwordRecoverySentBackToLogin => 'Volver a iniciar sesion';

  @override
  String get passwordResetTitle => 'Nueva contrasena';

  @override
  String get passwordResetSubtitle =>
      'Elige una contrasena que no hayas usado antes';

  @override
  String get passwordResetNewPasswordLabel => 'Nueva contrasena';

  @override
  String get passwordResetConfirmLabel => 'Confirma la nueva contrasena';

  @override
  String get passwordResetSubmit => 'Restablecer contrasena';

  @override
  String get passwordResetSuccessTitle => 'Contrasena actualizada';

  @override
  String get passwordResetSuccessBody =>
      'Ya puedes iniciar sesion con tu nueva contrasena.';

  @override
  String get passwordResetRequestNewLink => 'Solicitar un enlace nuevo';

  @override
  String get verifyEmailPendingTitle => 'Verifica tu correo';

  @override
  String verifyEmailPendingBody(String email) {
    return 'Registramos tu cuenta. Te enviamos un correo de verificacion a $email. Sigue el enlace para activarla.';
  }

  @override
  String get verifyEmailPendingNoEmailHint =>
      'Si no recibiste el correo, comunicate con soporte.';

  @override
  String get verifyEmailPendingLogout => 'Cerrar sesion';

  @override
  String homeGreeting(String fullName) {
    return 'Hola, $fullName';
  }

  @override
  String get homeLogout => 'Cerrar sesion';

  @override
  String get validationRequired => 'Este campo es obligatorio';

  @override
  String get validationEmailInvalid => 'Ingresa un correo electronico valido';

  @override
  String get validationEmailTooLong =>
      'El correo no puede superar los 150 caracteres';

  @override
  String get validationFullNameLength =>
      'El nombre debe tener entre 2 y 150 caracteres';

  @override
  String get validationPasswordTooShort =>
      'La contrasena debe tener al menos 8 caracteres';

  @override
  String get validationPasswordWeak =>
      'Debe incluir una mayuscula, una minuscula y un digito';

  @override
  String get validationPasswordMismatch => 'Las contrasenas no coinciden';

  @override
  String get validationInvitationCodeFormat =>
      'El codigo debe tener entre 8 y 20 caracteres, solo letras y numeros';

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
  String get errorInvalidInvitationCode => 'El codigo de invitacion no existe';

  @override
  String get errorExpiredInvitationCode => 'El codigo de invitacion vencio';

  @override
  String get errorInvitationCodeAlreadyUsed =>
      'El codigo de invitacion ya fue usado';

  @override
  String get errorNutritionistPendingActivation =>
      'Este nutricionista todavia no activo su cuenta. Intenta de nuevo mas tarde o comunicate directamente con el.';

  @override
  String get errorNutritionistUnavailable =>
      'Este codigo ya no esta disponible. Comunicate con tu nutricionista para obtener uno nuevo.';

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
      'Tu sesion expiro. Inicia sesion de nuevo.';

  @override
  String get errorInvalidPasswordResetToken =>
      'El enlace de recuperacion no es valido';

  @override
  String get errorExpiredPasswordResetToken =>
      'El enlace de recuperacion vencio o ya fue usado';

  @override
  String get errorUserLocalMissing =>
      'Hay un problema con tu cuenta. Comunicate con soporte.';

  @override
  String get errorInternalServer =>
      'Ocurrio un error en el servidor. Intenta de nuevo.';

  @override
  String get errorConsentRecordNotFound =>
      'No encontramos tu consentimiento registrado';

  @override
  String get errorForbidden => 'No tienes permiso para realizar esta accion';

  @override
  String errorRateLimited(int seconds) {
    return 'Demasiados intentos. Espera $seconds segundos.';
  }

  @override
  String get errorNetwork =>
      'Sin conexion. Verifica tu internet e intenta de nuevo.';

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
  String get profileTitle => 'Tu perfil';

  @override
  String get profileOpen => 'Abrir tu perfil';

  @override
  String get profileClinicalSection => 'Datos clínicos';

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
}
