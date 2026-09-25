import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// Nombre de la aplicacion, visible en la barra de tareas y el AppBar
  ///
  /// In es, this message translates to:
  /// **'Cauce'**
  String get appTitle;

  /// No description provided for @commonContinue.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get commonContinue;

  /// No description provided for @commonCancel.
  ///
  /// In es, this message translates to:
  /// **'Cancelar'**
  String get commonCancel;

  /// No description provided for @commonBack.
  ///
  /// In es, this message translates to:
  /// **'Volver'**
  String get commonBack;

  /// No description provided for @commonRetry.
  ///
  /// In es, this message translates to:
  /// **'Reintentar'**
  String get commonRetry;

  /// No description provided for @commonAccept.
  ///
  /// In es, this message translates to:
  /// **'Aceptar'**
  String get commonAccept;

  /// Texto accesible del indicador de carga, leido por lectores de pantalla
  ///
  /// In es, this message translates to:
  /// **'Cargando'**
  String get commonLoading;

  /// Mensaje bajo el logo mientras el SplashScreen resuelve el bootstrap de sesion
  ///
  /// In es, this message translates to:
  /// **'Preparando tu sesión'**
  String get splashLoading;

  /// No description provided for @loginTitle.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesión'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Ingresa a tu cuenta para continuar con tu seguimiento'**
  String get loginSubtitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get loginEmailLabel;

  /// No description provided for @loginEmailHint.
  ///
  /// In es, this message translates to:
  /// **'tucorreo@ejemplo.com'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Tu contraseña'**
  String get loginPasswordHint;

  /// No description provided for @loginSubmit.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesión'**
  String get loginSubmit;

  /// No description provided for @loginForgotPassword.
  ///
  /// In es, this message translates to:
  /// **'Olvidé mi contraseña'**
  String get loginForgotPassword;

  /// No description provided for @loginCreateAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get loginCreateAccount;

  /// No description provided for @loginNoAccountPrompt.
  ///
  /// In es, this message translates to:
  /// **'¿No tienes cuenta?'**
  String get loginNoAccountPrompt;

  /// No description provided for @loginShowPassword.
  ///
  /// In es, this message translates to:
  /// **'Mostrar contraseña'**
  String get loginShowPassword;

  /// No description provided for @loginHidePassword.
  ///
  /// In es, this message translates to:
  /// **'Ocultar contraseña'**
  String get loginHidePassword;

  /// No description provided for @registerTitle.
  ///
  /// In es, this message translates to:
  /// **'Crea tu cuenta'**
  String get registerTitle;

  /// No description provided for @registerSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Registrate para participar en el seguimiento nutricional'**
  String get registerSubtitle;

  /// No description provided for @registerFullNameLabel.
  ///
  /// In es, this message translates to:
  /// **'Nombre completo'**
  String get registerFullNameLabel;

  /// No description provided for @registerFullNameHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre y apellidos'**
  String get registerFullNameHint;

  /// No description provided for @registerEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get registerEmailLabel;

  /// No description provided for @registerEmailHint.
  ///
  /// In es, this message translates to:
  /// **'tucorreo@ejemplo.com'**
  String get registerEmailHint;

  /// No description provided for @registerPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contraseña'**
  String get registerPasswordLabel;

  /// No description provided for @registerPasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Mínimo 8 caracteres'**
  String get registerPasswordHint;

  /// No description provided for @registerPasswordConfirmLabel.
  ///
  /// In es, this message translates to:
  /// **'Confirma tu contraseña'**
  String get registerPasswordConfirmLabel;

  /// No description provided for @registerInvitationCodeLabel.
  ///
  /// In es, this message translates to:
  /// **'Código de invitación'**
  String get registerInvitationCodeLabel;

  /// No description provided for @registerInvitationCodeHint.
  ///
  /// In es, this message translates to:
  /// **'Opcional'**
  String get registerInvitationCodeHint;

  /// No description provided for @registerConsentSectionTitle.
  ///
  /// In es, this message translates to:
  /// **'Consentimiento informado'**
  String get registerConsentSectionTitle;

  /// No description provided for @registerConsentCheckbox.
  ///
  /// In es, this message translates to:
  /// **'He leido y acepto el consentimiento informado'**
  String get registerConsentCheckbox;

  /// No description provided for @registerConsentLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando el consentimiento vigente'**
  String get registerConsentLoading;

  /// Alerta cuando el backend responde 400 consent_text_mismatch y hay que recargar el consentimiento
  ///
  /// In es, this message translates to:
  /// **'El consentimiento fue actualizado. Revisa los cambios antes de continuar.'**
  String get registerConsentUpdated;

  /// No description provided for @registerSubmit.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get registerSubmit;

  /// No description provided for @registerHasAccountPrompt.
  ///
  /// In es, this message translates to:
  /// **'¿Ya tienes cuenta?'**
  String get registerHasAccountPrompt;

  /// No description provided for @passwordRecoveryTitle.
  ///
  /// In es, this message translates to:
  /// **'Recupera tu contraseña'**
  String get passwordRecoveryTitle;

  /// No description provided for @passwordRecoverySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Te enviaremos un enlace para restablecerla'**
  String get passwordRecoverySubtitle;

  /// No description provided for @passwordRecoveryEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electrónico'**
  String get passwordRecoveryEmailLabel;

  /// No description provided for @passwordRecoverySubmit.
  ///
  /// In es, this message translates to:
  /// **'Enviar enlace'**
  String get passwordRecoverySubmit;

  /// No description provided for @passwordRecoverySentTitle.
  ///
  /// In es, this message translates to:
  /// **'Revisa tu correo'**
  String get passwordRecoverySentTitle;

  /// No description provided for @passwordRecoverySentBody.
  ///
  /// In es, this message translates to:
  /// **'Si el correo existe en nuestro sistema, recibirás un enlace de recuperación válido por 30 minutos.'**
  String get passwordRecoverySentBody;

  /// No description provided for @passwordRecoverySentBackToLogin.
  ///
  /// In es, this message translates to:
  /// **'Volver a iniciar sesión'**
  String get passwordRecoverySentBackToLogin;

  /// No description provided for @passwordResetTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva contraseña'**
  String get passwordResetTitle;

  /// No description provided for @passwordResetSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Elige una contraseña que no hayas usado antes'**
  String get passwordResetSubtitle;

  /// No description provided for @passwordResetNewPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Nueva contraseña'**
  String get passwordResetNewPasswordLabel;

  /// No description provided for @passwordResetConfirmLabel.
  ///
  /// In es, this message translates to:
  /// **'Confirma la nueva contraseña'**
  String get passwordResetConfirmLabel;

  /// No description provided for @passwordResetSubmit.
  ///
  /// In es, this message translates to:
  /// **'Restablecer contraseña'**
  String get passwordResetSubmit;

  /// No description provided for @passwordResetSuccessTitle.
  ///
  /// In es, this message translates to:
  /// **'Contraseña actualizada'**
  String get passwordResetSuccessTitle;

  /// No description provided for @passwordResetSuccessBody.
  ///
  /// In es, this message translates to:
  /// **'Ya puedes iniciar sesión con tu nueva contraseña.'**
  String get passwordResetSuccessBody;

  /// No description provided for @passwordResetRequestNewLink.
  ///
  /// In es, this message translates to:
  /// **'Solicitar un enlace nuevo'**
  String get passwordResetRequestNewLink;

  /// No description provided for @verifyEmailPendingTitle.
  ///
  /// In es, this message translates to:
  /// **'Verifica tu correo'**
  String get verifyEmailPendingTitle;

  /// Aviso post registro con el correo al que se envio la verificacion
  ///
  /// In es, this message translates to:
  /// **'Registramos tu cuenta. Te enviamos un correo de verificación a {email}. Sigue el enlace para activarla.'**
  String verifyEmailPendingBody(String email);

  /// No description provided for @verifyEmailPendingNoEmailHint.
  ///
  /// In es, this message translates to:
  /// **'Si no recibiste el correo, comunícate con soporte.'**
  String get verifyEmailPendingNoEmailHint;

  /// No description provided for @verifyEmailPendingLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get verifyEmailPendingLogout;

  /// Saludo de bienvenida en HomeScreen
  ///
  /// In es, this message translates to:
  /// **'Hola, {fullName}'**
  String homeGreeting(String fullName);

  /// No description provided for @homeLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get homeLogout;

  /// No description provided for @validationRequired.
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio'**
  String get validationRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un correo electrónico válido'**
  String get validationEmailInvalid;

  /// No description provided for @validationEmailTooLong.
  ///
  /// In es, this message translates to:
  /// **'El correo no puede superar los 150 caracteres'**
  String get validationEmailTooLong;

  /// No description provided for @validationFullNameLength.
  ///
  /// In es, this message translates to:
  /// **'El nombre debe tener entre 2 y 150 caracteres'**
  String get validationFullNameLength;

  /// No description provided for @validationPasswordTooShort.
  ///
  /// In es, this message translates to:
  /// **'La contraseña debe tener al menos 8 caracteres'**
  String get validationPasswordTooShort;

  /// No description provided for @validationPasswordWeak.
  ///
  /// In es, this message translates to:
  /// **'Debe incluir una mayuscula, una minuscula y un digito'**
  String get validationPasswordWeak;

  /// No description provided for @validationPasswordMismatch.
  ///
  /// In es, this message translates to:
  /// **'Las contraseñas no coinciden'**
  String get validationPasswordMismatch;

  /// No description provided for @validationInvitationCodeFormat.
  ///
  /// In es, this message translates to:
  /// **'El código debe tener entre 8 y 20 caracteres, solo letras y números'**
  String get validationInvitationCodeFormat;

  /// No description provided for @validationConsentRequired.
  ///
  /// In es, this message translates to:
  /// **'Debes aceptar el consentimiento informado para continuar'**
  String get validationConsentRequired;

  /// No description provided for @validationNumberInvalid.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un número válido'**
  String get validationNumberInvalid;

  /// No description provided for @validationDateOfBirthFuture.
  ///
  /// In es, this message translates to:
  /// **'La fecha de nacimiento no puede ser futura'**
  String get validationDateOfBirthFuture;

  /// Rango de edad que acepta PatientProfile del backend. El minimo de 18 es requisito del piloto clinico, no una preferencia de diseno
  ///
  /// In es, this message translates to:
  /// **'El piloto admite participantes entre {min} y {max} años'**
  String validationAgeOutOfRange(int min, int max);

  /// No description provided for @validationDiagnosisDateFuture.
  ///
  /// In es, this message translates to:
  /// **'La fecha de diagnóstico no puede ser futura'**
  String get validationDiagnosisDateFuture;

  /// No description provided for @validationWeightOutOfRange.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un peso mayor que 0 y menor que 500 kg'**
  String get validationWeightOutOfRange;

  /// No description provided for @validationHeightOutOfRange.
  ///
  /// In es, this message translates to:
  /// **'Ingresa una estatura mayor que 0 y menor que 250 cm'**
  String get validationHeightOutOfRange;

  /// Tope de longitud de campos opcionales de texto libre: medicacion (1000) y notas de alergia (500)
  ///
  /// In es, this message translates to:
  /// **'No puede superar los {max} caracteres'**
  String validationTextTooLong(int max);

  /// errorCode validation_error (400). Los detalles por campo van en cada CauceTextField
  ///
  /// In es, this message translates to:
  /// **'Revisa los datos ingresados'**
  String get errorValidation;

  /// errorCode consent_text_mismatch (400)
  ///
  /// In es, this message translates to:
  /// **'El consentimiento informado cambio. Vuelve a leerlo y aceptalo.'**
  String get errorConsentTextMismatch;

  /// errorCode invalid_invitation_code (400)
  ///
  /// In es, this message translates to:
  /// **'El código de invitación no existe'**
  String get errorInvalidInvitationCode;

  /// errorCode expired_invitation_code (400)
  ///
  /// In es, this message translates to:
  /// **'El código de invitación venció'**
  String get errorExpiredInvitationCode;

  /// errorCode invitation_code_already_used (400)
  ///
  /// In es, this message translates to:
  /// **'El código de invitación ya fue usado'**
  String get errorInvitationCodeAlreadyUsed;

  /// errorCode nutritionist_not_available (409) con la extension reason en pending_activation. El codigo no se consume, asi que reintentar con el mismo es valido
  ///
  /// In es, this message translates to:
  /// **'Este nutricionista todavía no activó su cuenta. Intenta de nuevo más tarde o comunícate directamente con él.'**
  String get errorNutritionistPendingActivation;

  /// errorCode nutritionist_not_available (409) con la extension reason en inactive o suspended. Tambien cubre el reason ausente o desconocido, que ErrorMapper degrada a inactive
  ///
  /// In es, this message translates to:
  /// **'Este código ya no está disponible. Comunícate con tu nutricionista para obtener uno nuevo.'**
  String get errorNutritionistUnavailable;

  /// errorCode patient_already_assigned (409). El backend no sobrescribe la asignacion vigente
  ///
  /// In es, this message translates to:
  /// **'Ya tienes un nutricionista asignado'**
  String get errorPatientAlreadyAssigned;

  /// errorCode patient_profile_not_found (404). En el onboarding no llega a mostrarse: PatientsRepository.fetchProfile lo traduce a null porque ahi significa paso 1 pendiente
  ///
  /// In es, this message translates to:
  /// **'Todavía no registraste tu perfil clínico'**
  String get errorPatientProfileNotFound;

  /// errorCode duplicate_patient_profile (409). Tipicamente el envio anterior si entro aunque el dispositivo no vio la respuesta
  ///
  /// In es, this message translates to:
  /// **'Tu perfil clínico ya está registrado'**
  String get errorDuplicateProfile;

  /// errorCode invalid_biometric_value (400). Lo emite la entidad de dominio del backend, asi que no trae errors por campo y el mensaje no puede senalar cual fallo
  ///
  /// In es, this message translates to:
  /// **'Alguno de los datos clínicos está fuera del rango permitido. Revísalos e inténtalo de nuevo.'**
  String get errorInvalidBiometricValue;

  /// errorCode allergy_not_found (404). La entrada fue desactivada mientras el paciente completaba el formulario
  ///
  /// In es, this message translates to:
  /// **'Esta alergia ya no está disponible en el catálogo'**
  String get errorAllergyNotFound;

  /// errorCode duplicate_patient_allergy (409). En el reintento del paso 1 la capa de aplicacion lo trata como exito y este mensaje no llega a la pantalla
  ///
  /// In es, this message translates to:
  /// **'Esta alergia ya figura en tu perfil'**
  String get errorDuplicateAllergy;

  /// errorCode invalid_ibs_sss_dimension (400). Inalcanzable desde la UI porque el control esta acotado; se traduce por completitud del switch
  ///
  /// In es, this message translates to:
  /// **'Alguna respuesta quedó fuera del rango de 0 a 100'**
  String get errorInvalidIbsSssDimension;

  /// errorCode duplicate_baseline_assessment (409). El onboarding ya quedo cerrado: corresponde releer el estado, no reintentar
  ///
  /// In es, this message translates to:
  /// **'Tu cuestionario de línea base ya está registrado'**
  String get errorDuplicateBaselineAssessment;

  /// Titulo de la pantalla de registro de comida (US09)
  ///
  /// In es, this message translates to:
  /// **'Registrar comida'**
  String get mealsTitle;

  /// Accion que abre el buscador del catalogo
  ///
  /// In es, this message translates to:
  /// **'Agregar alimento'**
  String get mealsAddFood;

  /// Titulo del modal de busqueda
  ///
  /// In es, this message translates to:
  /// **'Buscar alimento'**
  String get mealsSearchTitle;

  /// Placeholder del campo de busqueda
  ///
  /// In es, this message translates to:
  /// **'Escribe el nombre del alimento'**
  String get mealsSearchHint;

  /// Busqueda local sin coincidencias
  ///
  /// In es, this message translates to:
  /// **'No encontramos alimentos con ese nombre'**
  String get mealsSearchNoResults;

  /// Seccion frequentLast30Days de GET /foods/suggestions
  ///
  /// In es, this message translates to:
  /// **'Los que más registras'**
  String get mealsSuggestionsFrequent;

  /// Seccion recentLast24Hours de GET /foods/suggestions
  ///
  /// In es, this message translates to:
  /// **'Registrados hoy'**
  String get mealsSuggestionsRecent;

  /// Seccion catalogSuggestions de GET /foods/suggestions
  ///
  /// In es, this message translates to:
  /// **'Del catálogo'**
  String get mealsSuggestionsCatalog;

  /// Etiqueta del campo de cantidad
  ///
  /// In es, this message translates to:
  /// **'Cantidad'**
  String get mealsQuantityLabel;

  /// Etiqueta del selector de unidad
  ///
  /// In es, this message translates to:
  /// **'Unidad'**
  String get mealsUnitLabel;

  /// Etiqueta del selector de MealTime
  ///
  /// In es, this message translates to:
  /// **'Momento del día'**
  String get mealsTimeLabel;

  /// Encabezado de la lista de items
  ///
  /// In es, this message translates to:
  /// **'Alimentos de esta comida'**
  String get mealsItemsLabel;

  /// Lista de items vacia
  ///
  /// In es, this message translates to:
  /// **'Todavía no agregaste ningún alimento'**
  String get mealsItemsEmpty;

  /// Accion que saca un alimento de la comida
  ///
  /// In es, this message translates to:
  /// **'Quitar'**
  String get mealsRemoveItem;

  /// Boton de envio del formulario
  ///
  /// In es, this message translates to:
  /// **'Registrar comida'**
  String get mealsSubmit;

  /// Confirmacion cuando el servidor la acepto
  ///
  /// In es, this message translates to:
  /// **'Comida registrada'**
  String get mealsRegistered;

  /// Confirmacion de CA02: el registro quedo en la cola local (CP023)
  ///
  /// In es, this message translates to:
  /// **'Comida guardada. Se enviará cuando vuelva la conexión.'**
  String get mealsQueuedOffline;

  /// Accion para vaciar el formulario y anotar otra comida
  ///
  /// In es, this message translates to:
  /// **'Registrar otra'**
  String get mealsRegisterAnother;

  /// CA04: falta MealTime
  ///
  /// In es, this message translates to:
  /// **'Elige el momento del día'**
  String get mealsIssueMissingMealTime;

  /// CA04: la comida no tiene items
  ///
  /// In es, this message translates to:
  /// **'Agrega al menos un alimento'**
  String get mealsIssueNoItems;

  /// Tope de Meal.Register
  ///
  /// In es, this message translates to:
  /// **'Una comida admite hasta 50 alimentos'**
  String get mealsIssueTooManyItems;

  /// CA04: cantidad invalida
  ///
  /// In es, this message translates to:
  /// **'La cantidad debe ser mayor que cero'**
  String get mealsIssueInvalidQuantity;

  /// Invariante XOR de Meal.Register
  ///
  /// In es, this message translates to:
  /// **'Cada alimento debe venir del catálogo o de tus platos'**
  String get mealsIssueInvalidReference;

  /// Invariante de fecha de Meal.Register
  ///
  /// In es, this message translates to:
  /// **'La fecha de consumo no puede estar en el futuro'**
  String get mealsIssueFutureConsumedAt;

  /// FodmapLevel Low de la comida agregada
  ///
  /// In es, this message translates to:
  /// **'Carga FODMAP baja'**
  String get mealsFodmapLow;

  /// FodmapLevel Moderate
  ///
  /// In es, this message translates to:
  /// **'Carga FODMAP moderada'**
  String get mealsFodmapModerate;

  /// FodmapLevel High
  ///
  /// In es, this message translates to:
  /// **'Carga FODMAP alta'**
  String get mealsFodmapHigh;

  /// MealTime Breakfast
  ///
  /// In es, this message translates to:
  /// **'Desayuno'**
  String get mealTimeBreakfast;

  /// MealTime Lunch
  ///
  /// In es, this message translates to:
  /// **'Almuerzo'**
  String get mealTimeLunch;

  /// MealTime Dinner
  ///
  /// In es, this message translates to:
  /// **'Cena'**
  String get mealTimeDinner;

  /// MealTime Snack
  ///
  /// In es, this message translates to:
  /// **'Refrigerio'**
  String get mealTimeSnack;

  /// MeasurementUnit Grams
  ///
  /// In es, this message translates to:
  /// **'Gramos'**
  String get measurementUnitGrams;

  /// MeasurementUnit Cups
  ///
  /// In es, this message translates to:
  /// **'Tazas'**
  String get measurementUnitCups;

  /// MeasurementUnit Units
  ///
  /// In es, this message translates to:
  /// **'Unidades'**
  String get measurementUnitUnits;

  /// MeasurementUnit Ounces
  ///
  /// In es, this message translates to:
  /// **'Onzas'**
  String get measurementUnitOunces;

  /// MeasurementUnit Tablespoons
  ///
  /// In es, this message translates to:
  /// **'Cucharadas'**
  String get measurementUnitTablespoons;

  /// Titulo de la pantalla del constructor de platos (US10)
  ///
  /// In es, this message translates to:
  /// **'Crear plato personalizado'**
  String get customFoodTitle;

  /// Campo de nombre
  ///
  /// In es, this message translates to:
  /// **'Nombre del plato'**
  String get customFoodNameLabel;

  /// Placeholder del nombre
  ///
  /// In es, this message translates to:
  /// **'Por ejemplo: Mi lomo saltado'**
  String get customFoodNameHint;

  /// Campo de portionSizeGrams
  ///
  /// In es, this message translates to:
  /// **'Tamaño de porción (g)'**
  String get customFoodPortionLabel;

  /// Encabezado de la lista de ingredientes
  ///
  /// In es, this message translates to:
  /// **'Ingredientes'**
  String get customFoodIngredientsLabel;

  /// Lista de ingredientes vacia
  ///
  /// In es, this message translates to:
  /// **'Todavía no agregaste ingredientes'**
  String get customFoodIngredientsEmpty;

  /// Accion que abre el buscador del catalogo
  ///
  /// In es, this message translates to:
  /// **'Agregar ingrediente'**
  String get customFoodAddIngredient;

  /// Campo de proportionGrams de un ingrediente
  ///
  /// In es, this message translates to:
  /// **'Cantidad en el plato (g)'**
  String get customFoodProportionLabel;

  /// Boton de envio
  ///
  /// In es, this message translates to:
  /// **'Guardar plato'**
  String get customFoodSubmit;

  /// Confirmacion de creacion
  ///
  /// In es, this message translates to:
  /// **'Plato guardado'**
  String get customFoodCreated;

  /// Diferencia entre la suma de proporciones y portionSizeGrams. Informativa: el backend no la valida
  ///
  /// In es, this message translates to:
  /// **'Los ingredientes suman {grams} g más que la porción declarada'**
  String customFoodWeightDelta(String grams);

  /// Misma diferencia, cuando los ingredientes pesan menos
  ///
  /// In es, this message translates to:
  /// **'Los ingredientes suman {grams} g menos que la porción declarada'**
  String customFoodWeightDeltaShort(String grams);

  /// Encabezado de la vista previa de CA01
  ///
  /// In es, this message translates to:
  /// **'Perfil nutricional estimado'**
  String get customFoodEstimateTitle;

  /// Aclaracion de CA01: el calculo es del cliente y el contrato no lo persiste
  ///
  /// In es, this message translates to:
  /// **'Es una estimación por 100 g a partir de los ingredientes. No se guarda con el plato.'**
  String get customFoodEstimateNote;

  /// Aviso cuando algun ingrediente no tiene FoodItemDetail
  ///
  /// In es, this message translates to:
  /// **'Falta la composición de algún ingrediente, así que la estimación es parcial.'**
  String get customFoodEstimatePartial;

  /// Calorias por 100 g
  ///
  /// In es, this message translates to:
  /// **'{value} kcal'**
  String customFoodEstimateCalories(String value);

  /// Proteina por 100 g
  ///
  /// In es, this message translates to:
  /// **'Proteina {value} g'**
  String customFoodEstimateProtein(String value);

  /// Carbohidratos por 100 g
  ///
  /// In es, this message translates to:
  /// **'Carbohidratos {value} g'**
  String customFoodEstimateCarbs(String value);

  /// Grasa por 100 g
  ///
  /// In es, this message translates to:
  /// **'Grasa {value} g'**
  String customFoodEstimateFat(String value);

  /// Fibra por 100 g
  ///
  /// In es, this message translates to:
  /// **'Fibra {value} g'**
  String customFoodEstimateFiber(String value);

  /// Invariante de CustomFood.EnsureValidName
  ///
  /// In es, this message translates to:
  /// **'Ponle un nombre de hasta 150 caracteres'**
  String get customFoodIssueInvalidName;

  /// CA02: validacion instantanea contra la lista ya cargada
  ///
  /// In es, this message translates to:
  /// **'Ya tienes un plato con ese nombre'**
  String get customFoodIssueDuplicateName;

  /// Invariante de portionSizeGrams
  ///
  /// In es, this message translates to:
  /// **'La porción debe ser mayor que cero'**
  String get customFoodIssueInvalidPortion;

  /// Plato sin ingredientes
  ///
  /// In es, this message translates to:
  /// **'Agrega al menos un ingrediente'**
  String get customFoodIssueNoIngredients;

  /// Invariante de CustomFoodIngredient
  ///
  /// In es, this message translates to:
  /// **'Cada ingrediente debe tener una cantidad mayor que cero'**
  String get customFoodIssueInvalidProportion;

  /// Invariante de CustomFood.AddIngredient
  ///
  /// In es, this message translates to:
  /// **'Un ingrediente aparece dos veces'**
  String get customFoodIssueDuplicateIngredient;

  /// Titulo de la advertencia de alergenos (CA03, CP027)
  ///
  /// In es, this message translates to:
  /// **'Revisa estos ingredientes'**
  String get customFoodAllergenTitle;

  /// Cuerpo de la advertencia de alergenos
  ///
  /// In es, this message translates to:
  /// **'Estos ingredientes coinciden con alergias que declaraste en tu perfil.'**
  String get customFoodAllergenBody;

  /// Una coincidencia ingrediente-alergeno
  ///
  /// In es, this message translates to:
  /// **'{ingredient} coincide con {allergen}'**
  String customFoodAllergenEntry(String ingredient, String allergen);

  /// Severidad Mild de la alergia declarada
  ///
  /// In es, this message translates to:
  /// **'Declarada como leve'**
  String get customFoodAllergenSeverityMild;

  /// Severidad Moderate
  ///
  /// In es, this message translates to:
  /// **'Declarada como moderada'**
  String get customFoodAllergenSeverityModerate;

  /// Severidad Severe
  ///
  /// In es, this message translates to:
  /// **'Declarada como severa'**
  String get customFoodAllergenSeveritySevere;

  /// El servidor mando una severidad que el cliente no reconoce. No se inventa un valor
  ///
  /// In es, this message translates to:
  /// **'Severidad no informada'**
  String get customFoodAllergenSeverityUnknown;

  /// Confirmacion explicita que reenvia con confirmedAllergens en true
  ///
  /// In es, this message translates to:
  /// **'Entiendo, guardar igual'**
  String get customFoodAllergenConfirm;

  /// Vuelve al formulario para sacar el ingrediente
  ///
  /// In es, this message translates to:
  /// **'Volver y editar'**
  String get customFoodAllergenCancel;

  /// Titulo de la pantalla de registro de sintoma (US11)
  ///
  /// In es, this message translates to:
  /// **'Registrar síntoma'**
  String get symptomsTitle;

  /// Etiqueta del selector de SymptomType
  ///
  /// In es, this message translates to:
  /// **'Qué sentiste'**
  String get symptomsTypeLabel;

  /// Etiqueta de la escala de intensidad
  ///
  /// In es, this message translates to:
  /// **'Intensidad'**
  String get symptomsIntensityLabel;

  /// Extremo inferior de la escala, valor 1
  ///
  /// In es, this message translates to:
  /// **'Leve'**
  String get symptomsIntensityMin;

  /// Extremo superior de la escala, valor 100
  ///
  /// In es, this message translates to:
  /// **'Muy intenso'**
  String get symptomsIntensityMax;

  /// Boton de envio
  ///
  /// In es, this message translates to:
  /// **'Registrar síntoma'**
  String get symptomsSubmit;

  /// Confirmacion cuando el servidor lo acepto
  ///
  /// In es, this message translates to:
  /// **'Síntoma registrado'**
  String get symptomsRegistered;

  /// Confirmacion cuando quedo en la cola local
  ///
  /// In es, this message translates to:
  /// **'Síntoma guardado. Se enviará cuando vuelva la conexión.'**
  String get symptomsQueuedOffline;

  /// Accion para vaciar el formulario
  ///
  /// In es, this message translates to:
  /// **'Registrar otro'**
  String get symptomsRegisterAnother;

  /// CA01: el servidor encontro una comida en la ventana de 4 horas
  ///
  /// In es, this message translates to:
  /// **'Lo asociamos con la comida que registraste antes.'**
  String get symptomsMealAssociated;

  /// CA02: el servidor respondio hasMealAssociation en false. No es un error
  ///
  /// In es, this message translates to:
  /// **'No habia una comida registrada en las 4 horas previas.'**
  String get symptomsMealNotAssociated;

  /// Sin conexion: la ventana de 4 horas la resuelve el servidor, no el cliente
  ///
  /// In es, this message translates to:
  /// **'La relación con tus comidas se calcula al sincronizar.'**
  String get symptomsMealPending;

  /// Falta SymptomType
  ///
  /// In es, this message translates to:
  /// **'Elige qué sentiste'**
  String get symptomsIssueMissingType;

  /// Falta mover la escala
  ///
  /// In es, this message translates to:
  /// **'Indica la intensidad'**
  String get symptomsIssueMissingIntensity;

  /// Invariante Symptom.MinIntensity del backend
  ///
  /// In es, this message translates to:
  /// **'La intensidad va de 1 a 100'**
  String get symptomsIssueIntensityOutOfRange;

  /// Invariante de fecha de Symptom.Report
  ///
  /// In es, this message translates to:
  /// **'El momento no puede estar en el futuro'**
  String get symptomsIssueFutureOccurredAt;

  /// SymptomType AbdominalPain
  ///
  /// In es, this message translates to:
  /// **'Dolor abdominal'**
  String get symptomTypeAbdominalPain;

  /// SymptomType Bloating
  ///
  /// In es, this message translates to:
  /// **'Distensión abdominal'**
  String get symptomTypeBloating;

  /// SymptomType Flatulence
  ///
  /// In es, this message translates to:
  /// **'Flatulencia'**
  String get symptomTypeFlatulence;

  /// SymptomType Diarrhea
  ///
  /// In es, this message translates to:
  /// **'Diarrea'**
  String get symptomTypeDiarrhea;

  /// SymptomType Constipation
  ///
  /// In es, this message translates to:
  /// **'Estreñimiento'**
  String get symptomTypeConstipation;

  /// SymptomType Nausea
  ///
  /// In es, this message translates to:
  /// **'Náuseas'**
  String get symptomTypeNausea;

  /// SymptomType Reflux
  ///
  /// In es, this message translates to:
  /// **'Reflujo o acidez'**
  String get symptomTypeReflux;

  /// SymptomType Urgency
  ///
  /// In es, this message translates to:
  /// **'Urgencia para evacuar'**
  String get symptomTypeUrgency;

  /// SymptomType Other
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get symptomTypeOther;

  /// Titulo de la pantalla de historial
  ///
  /// In es, this message translates to:
  /// **'Mi registro'**
  String get historyTitle;

  /// Historial vacio
  ///
  /// In es, this message translates to:
  /// **'Todavía no registraste nada'**
  String get historyEmpty;

  /// Intensidad de un sintoma en el historial
  ///
  /// In es, this message translates to:
  /// **'Intensidad {value} de 100'**
  String historyMealIntensity(int value);

  /// Fila local con sync_status pending
  ///
  /// In es, this message translates to:
  /// **'Pendiente de enviar'**
  String get historyStatePending;

  /// Fila local con sync_status failed, estado terminal
  ///
  /// In es, this message translates to:
  /// **'No se pudo enviar'**
  String get historyStateFailed;

  /// Explicacion del estado terminal, con su salida
  ///
  /// In es, this message translates to:
  /// **'Este registro no se pudo enviar y no va a reintentarse. Puedes descartarlo.'**
  String get historyFailedExplanation;

  /// Accion que borra una fila local rechazada
  ///
  /// In es, this message translates to:
  /// **'Descartar'**
  String get historyDiscard;

  /// Accion que abre el formulario de nota de contexto (US13)
  ///
  /// In es, this message translates to:
  /// **'Agregar nota'**
  String get historyAddNote;

  /// Por que no se puede adjuntar una nota: CreateClinicalNoteRequest exige un id del servidor
  ///
  /// In es, this message translates to:
  /// **'Disponible cuando se sincronice'**
  String get historyNoteUnavailable;

  /// El servidor vinculo el sintoma con una comida en la ventana de 4 horas
  ///
  /// In es, this message translates to:
  /// **'Asociado a una comida'**
  String get historyMealAssociated;

  /// Accion que relee el historial
  ///
  /// In es, this message translates to:
  /// **'Actualizar'**
  String get historyRefresh;

  /// Titulo de la pantalla de nota de contexto (US13)
  ///
  /// In es, this message translates to:
  /// **'Agregar nota'**
  String get clinicalNoteTitle;

  /// Bajada de la pantalla de nota
  ///
  /// In es, this message translates to:
  /// **'Anota lo que quieras recordar sobre este registro. Tu nutricionista lo vera junto al dato.'**
  String get clinicalNoteSubtitle;

  /// Campo de texto de la nota
  ///
  /// In es, this message translates to:
  /// **'Nota'**
  String get clinicalNoteContentLabel;

  /// Placeholder del campo de nota
  ///
  /// In es, this message translates to:
  /// **'Por ejemplo: comi apurado, en la calle'**
  String get clinicalNoteContentHint;

  /// Contador visible de CA02. Se vuelve negativo si el paciente pasa el tope
  ///
  /// In es, this message translates to:
  /// **'Quedan {count} caracteres'**
  String clinicalNoteRemaining(int count);

  /// CA02: el texto supera el tope de ClinicalNote.Create
  ///
  /// In es, this message translates to:
  /// **'La nota no puede superar los 500 caracteres'**
  String get clinicalNoteTooLong;

  /// Boton de envio
  ///
  /// In es, this message translates to:
  /// **'Guardar nota'**
  String get clinicalNoteSubmit;

  /// Confirmacion de creacion
  ///
  /// In es, this message translates to:
  /// **'Nota guardada'**
  String get clinicalNoteSaved;

  /// Titulo de la evaluacion IBS-SSS periodica (US12)
  ///
  /// In es, this message translates to:
  /// **'Cuestionario de seguimiento'**
  String get ibsSssPeriodicTitle;

  /// Bajada del cuestionario periodico. Mismo instrumento que la linea base
  ///
  /// In es, this message translates to:
  /// **'Responde las cinco preguntas pensando en los últimos diez días.'**
  String get ibsSssPeriodicSubtitle;

  /// Boton de envio del cuestionario periodico
  ///
  /// In es, this message translates to:
  /// **'Enviar cuestionario'**
  String get ibsSssPeriodicSubmit;

  /// Encabezado del grafico de evolucion (CA03)
  ///
  /// In es, this message translates to:
  /// **'Tu evolución'**
  String get ibsSssEvolutionTitle;

  /// Menos de dos puntos: no hay linea que trazar
  ///
  /// In es, this message translates to:
  /// **'Con una sola evaluación todavía no hay evolución que mostrar.'**
  String get ibsSssEvolutionEmpty;

  /// Extremos de la serie, en texto, porque el grafico no dibuja escala
  ///
  /// In es, this message translates to:
  /// **'De {first} a {last} puntos'**
  String ibsSssEvolutionRange(int first, int last);

  /// Diferencia contra la linea base. Negativo es mejoria
  ///
  /// In es, this message translates to:
  /// **'{value} puntos respecto de tu línea base'**
  String ibsSssEvolutionDelta(int value);

  /// MCID del IBS-SSS. Se enuncia como dato, no como felicitacion
  ///
  /// In es, this message translates to:
  /// **'Es una reducción de 50 puntos o más respecto de tu línea base. Tu nutricionista lo interpretará contigo.'**
  String get ibsSssEvolutionImprovement;

  /// Titulo del aviso de la home cuando vencio el ciclo (CA01)
  ///
  /// In es, this message translates to:
  /// **'Toca tu cuestionario de seguimiento'**
  String get ibsSssReminderTitle;

  /// Cuerpo del aviso de la home
  ///
  /// In es, this message translates to:
  /// **'Pasaron los catorce días desde tu última evaluación.'**
  String get ibsSssReminderBody;

  /// Accion del aviso que lleva al cuestionario
  ///
  /// In es, this message translates to:
  /// **'Responder ahora'**
  String get ibsSssReminderAction;

  /// errorCode food_item_not_found (404). Alcanzable desde la caja local del catalogo, que puede sobrevivir a la desactivacion del alimento en el servidor
  ///
  /// In es, this message translates to:
  /// **'Ese alimento ya no está disponible en el catálogo'**
  String get errorFoodItemNotFound;

  /// errorCode custom_food_not_found (404)
  ///
  /// In es, this message translates to:
  /// **'No encontramos ese plato personalizado'**
  String get errorCustomFoodNotFound;

  /// errorCode duplicate_custom_food (409). El constructor valida contra la lista ya cargada, asi que esto llega cuando la lista local quedo vieja
  ///
  /// In es, this message translates to:
  /// **'Ya tienes un plato con ese nombre'**
  String get errorDuplicateCustomFood;

  /// errorCode custom_food_in_use (409)
  ///
  /// In es, this message translates to:
  /// **'No puedes eliminar este plato porque ya lo usaste en una comida registrada'**
  String get errorCustomFoodInUse;

  /// errorCode duplicate_ingredient (409). La UI lo impide sumando proporciones en vez de repetir la fila
  ///
  /// In es, this message translates to:
  /// **'Ese ingrediente ya está en el plato'**
  String get errorDuplicateIngredient;

  /// errorCode ingredient_not_found (404)
  ///
  /// In es, this message translates to:
  /// **'Ese ingrediente ya no está en el plato'**
  String get errorIngredientNotFound;

  /// errorCode unconfirmed_allergens (409), US10 CA03. Encabezado del flujo de confirmacion, no un error terminal: el detalle por ingrediente lo pinta la pantalla desde la extension allergens
  ///
  /// In es, this message translates to:
  /// **'Este plato contiene ingredientes que coinciden con tus alergias declaradas'**
  String get errorUnconfirmedAllergens;

  /// errorCode invalid_meal_registration (400). Lo lanza la entidad de dominio del backend y no FluentValidation, asi que no trae errores por campo
  ///
  /// In es, this message translates to:
  /// **'No pudimos registrar la comida. Revisa los datos e intenta de nuevo.'**
  String get errorInvalidMealRegistration;

  /// errorCode meal_not_found (404)
  ///
  /// In es, this message translates to:
  /// **'No encontramos esa comida registrada'**
  String get errorMealNotFound;

  /// errorCode symptom_not_found (404)
  ///
  /// In es, this message translates to:
  /// **'No encontramos ese síntoma registrado'**
  String get errorSymptomNotFound;

  /// errorCode clinical_note_not_found (404)
  ///
  /// In es, this message translates to:
  /// **'No encontramos esa nota'**
  String get errorClinicalNoteNotFound;

  /// errorCode invalid_clinical_note_association (400)
  ///
  /// In es, this message translates to:
  /// **'Una nota se asocia a una comida o a un síntoma, no a los dos'**
  String get errorInvalidClinicalNoteAssociation;

  /// errorCode idempotency_mismatch (409). Señala un bug del cliente, no una accion del paciente: el reintento debe repetir el mismo client_guid intacto
  ///
  /// In es, this message translates to:
  /// **'Hubo un conflicto al guardar este registro. Intenta de nuevo.'**
  String get errorIdempotencyMismatch;

  /// errorCode domain_rule_violation (400). Caso general de DomainException para las reglas sin errorCode propio
  ///
  /// In es, this message translates to:
  /// **'No pudimos completar la operación. Revisa los datos e intenta de nuevo.'**
  String get errorDomainRuleViolation;

  /// errorCode patient_has_no_data_in_period (422). CP063 pasos 4 y 5: avisar y sugerir otro rango
  ///
  /// In es, this message translates to:
  /// **'No hay datos registrados en ese período. Elige un rango de fechas diferente.'**
  String get errorPatientHasNoDataInPeriod;

  /// errorCode report_period_invalid (422)
  ///
  /// In es, this message translates to:
  /// **'El período solicitado no es válido. Elige un rango de hasta 90 días que no incluya fechas futuras.'**
  String get errorReportPeriodInvalid;

  /// errorCode recommendation_not_found (404). Tambien cubre las que existen pero no son visibles para el paciente (acta A24)
  ///
  /// In es, this message translates to:
  /// **'Esta recomendación ya no está disponible.'**
  String get errorRecommendationNotFound;

  /// errorCode recommendation_access_denied (403). La recomendacion es de otro paciente
  ///
  /// In es, this message translates to:
  /// **'No tienes acceso a esta recomendación.'**
  String get errorRecommendationAccessDenied;

  /// errorCode conflict_state (409). Transicion de estado invalida en el modulo de recomendaciones
  ///
  /// In es, this message translates to:
  /// **'Esta recomendación cambió mientras la veías. La actualizamos para mostrarte su estado actual.'**
  String get errorConflictState;

  /// errorCode recommendation_expired (409). Vencio su ventana de 72 horas sin entregarse
  ///
  /// In es, this message translates to:
  /// **'Esta recomendación venció y ya no está disponible.'**
  String get errorRecommendationExpired;

  /// errorCode insufficient_clinical_history (422). La pantalla de Consejos no lo muestra como error: es el estado vacio
  ///
  /// In es, this message translates to:
  /// **'Todavía no hay suficientes registros para preparar una recomendación. Sigue registrando tus comidas y síntomas.'**
  String get errorInsufficientClinicalHistory;

  /// errorCode all_candidates_filtered_by_allergies (422)
  ///
  /// In es, this message translates to:
  /// **'Por tus alergias declaradas no encontramos alimentos para recomendarte. Tu nutricionista puede ayudarte a revisarlo.'**
  String get errorAllCandidatesFilteredByAllergies;

  /// errorCode no_active_model_version (422). Condicion del servidor, no del paciente
  ///
  /// In es, this message translates to:
  /// **'Las recomendaciones no están disponibles en este momento. Inténtalo más tarde.'**
  String get errorNoActiveModelVersion;

  /// errorCode duplicate_email (409)
  ///
  /// In es, this message translates to:
  /// **'Ya existe una cuenta con este correo'**
  String get errorDuplicateEmail;

  /// errorCode keycloak_integration_error (502)
  ///
  /// In es, this message translates to:
  /// **'No pudimos crear tu cuenta. Intenta de nuevo en unos minutos.'**
  String get errorKeycloakIntegration;

  /// errorCode invalid_credentials (401). Mensaje deliberadamente generico: tambien cubre el caso de correo no verificado, y distinguirlos filtraria si la cuenta existe
  ///
  /// In es, this message translates to:
  /// **'Credenciales incorrectas'**
  String get errorInvalidCredentials;

  /// errorCode account_locked (423). Los minutos salen del countdown contra la extension lockedUntil
  ///
  /// In es, this message translates to:
  /// **'Cuenta bloqueada por intentos fallidos. Vuelve a intentar en {minutes} minutos.'**
  String errorAccountLocked(int minutes);

  /// errorCode account_locked (423) cuando el countdown baja de un minuto
  ///
  /// In es, this message translates to:
  /// **'Cuenta bloqueada por intentos fallidos. Vuelve a intentar en menos de un minuto.'**
  String get errorAccountLockedSoon;

  /// errorCode invalid_refresh_token (401)
  ///
  /// In es, this message translates to:
  /// **'Tu sesión expiró. Inicia sesión de nuevo.'**
  String get errorInvalidRefreshToken;

  /// errorCode invalid_password_reset_token (400)
  ///
  /// In es, this message translates to:
  /// **'El enlace de recuperación no es válido'**
  String get errorInvalidPasswordResetToken;

  /// errorCode expired_password_reset_token (400)
  ///
  /// In es, this message translates to:
  /// **'El enlace de recuperación venció o ya fue usado'**
  String get errorExpiredPasswordResetToken;

  /// errorCode user_local_missing (500). Inconsistencia de aprovisionamiento entre Keycloak y el backend
  ///
  /// In es, this message translates to:
  /// **'Hay un problema con tu cuenta. Comunícate con soporte.'**
  String get errorUserLocalMissing;

  /// errorCode internal_server_error (500)
  ///
  /// In es, this message translates to:
  /// **'Ocurrio un error en el servidor. Intenta de nuevo.'**
  String get errorInternalServer;

  /// errorCode consent_record_not_found (404). Solo aplica a US01 CA04, fuera del alcance de Mobile-1b
  ///
  /// In es, this message translates to:
  /// **'No encontramos tu consentimiento registrado'**
  String get errorConsentRecordNotFound;

  /// errorCode forbidden (403)
  ///
  /// In es, this message translates to:
  /// **'No tienes permiso para realizar esta acción'**
  String get errorForbidden;

  /// HTTP 429, que no trae errorCode. Los segundos salen de la extension retryAfterSeconds o del header Retry-After
  ///
  /// In es, this message translates to:
  /// **'Demasiados intentos. Espera {seconds} segundos.'**
  String errorRateLimited(int seconds);

  /// Timeout o ausencia de red, sin respuesta del servidor
  ///
  /// In es, this message translates to:
  /// **'Sin conexión. Verifica tu internet e intenta de nuevo.'**
  String get errorNetwork;

  /// Fallback para cualquier status no contemplado
  ///
  /// In es, this message translates to:
  /// **'Ocurrio un error inesperado. Intenta de nuevo.'**
  String get errorUnknown;

  /// Indicador de progreso del wizard de onboarding clinico
  ///
  /// In es, this message translates to:
  /// **'Paso {current} de {total}'**
  String onboardingStepLabel(int current, int total);

  /// US03 CA05 y US04 CA05. Aplaza el paso y deja usar el resto de la app
  ///
  /// In es, this message translates to:
  /// **'Completar más tarde'**
  String get onboardingDefer;

  /// No description provided for @onboardingReminderTitle.
  ///
  /// In es, this message translates to:
  /// **'Te falta completar tu perfil'**
  String get onboardingReminderTitle;

  /// No description provided for @onboardingReminderBodyProfile.
  ///
  /// In es, this message translates to:
  /// **'Tu nutricionista necesita tus datos clínicos para darte recomendaciones.'**
  String get onboardingReminderBodyProfile;

  /// No description provided for @onboardingReminderBodyBaseline.
  ///
  /// In es, this message translates to:
  /// **'Falta el cuestionario inicial. Es el punto de partida para medir tu evolución.'**
  String get onboardingReminderBodyBaseline;

  /// No description provided for @onboardingReminderAction.
  ///
  /// In es, this message translates to:
  /// **'Continuar ahora'**
  String get onboardingReminderAction;

  /// No description provided for @clinicalProfileTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu perfil clínico'**
  String get clinicalProfileTitle;

  /// No description provided for @clinicalProfileSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Estos datos le permiten a tu nutricionista ajustar tus recomendaciones.'**
  String get clinicalProfileSubtitle;

  /// No description provided for @clinicalProfileDateOfBirthLabel.
  ///
  /// In es, this message translates to:
  /// **'Fecha de nacimiento'**
  String get clinicalProfileDateOfBirthLabel;

  /// No description provided for @clinicalProfileDatePlaceholder.
  ///
  /// In es, this message translates to:
  /// **'Selecciona una fecha'**
  String get clinicalProfileDatePlaceholder;

  /// No description provided for @clinicalProfileBiologicalSexLabel.
  ///
  /// In es, this message translates to:
  /// **'Sexo biológico'**
  String get clinicalProfileBiologicalSexLabel;

  /// No description provided for @biologicalSexFemale.
  ///
  /// In es, this message translates to:
  /// **'Femenino'**
  String get biologicalSexFemale;

  /// No description provided for @biologicalSexMale.
  ///
  /// In es, this message translates to:
  /// **'Masculino'**
  String get biologicalSexMale;

  /// No description provided for @biologicalSexOther.
  ///
  /// In es, this message translates to:
  /// **'Otro'**
  String get biologicalSexOther;

  /// No description provided for @clinicalProfileWeightLabel.
  ///
  /// In es, this message translates to:
  /// **'Peso (kg)'**
  String get clinicalProfileWeightLabel;

  /// No description provided for @clinicalProfileWeightHint.
  ///
  /// In es, this message translates to:
  /// **'Por ejemplo, 62.5'**
  String get clinicalProfileWeightHint;

  /// No description provided for @clinicalProfileHeightLabel.
  ///
  /// In es, this message translates to:
  /// **'Estatura (cm)'**
  String get clinicalProfileHeightLabel;

  /// No description provided for @clinicalProfileHeightHint.
  ///
  /// In es, this message translates to:
  /// **'Por ejemplo, 162'**
  String get clinicalProfileHeightHint;

  /// No description provided for @clinicalProfileIbsSubtypeLabel.
  ///
  /// In es, this message translates to:
  /// **'Subtipo de síndrome de intestino irritable'**
  String get clinicalProfileIbsSubtypeLabel;

  /// No description provided for @ibsSubtypeD.
  ///
  /// In es, this message translates to:
  /// **'SII-D'**
  String get ibsSubtypeD;

  /// No description provided for @ibsSubtypeDDescription.
  ///
  /// In es, this message translates to:
  /// **'Con predominio de diarrea'**
  String get ibsSubtypeDDescription;

  /// No description provided for @ibsSubtypeC.
  ///
  /// In es, this message translates to:
  /// **'SII-C'**
  String get ibsSubtypeC;

  /// No description provided for @ibsSubtypeCDescription.
  ///
  /// In es, this message translates to:
  /// **'Con predominio de estreñimiento'**
  String get ibsSubtypeCDescription;

  /// No description provided for @ibsSubtypeM.
  ///
  /// In es, this message translates to:
  /// **'SII-M'**
  String get ibsSubtypeM;

  /// No description provided for @ibsSubtypeMDescription.
  ///
  /// In es, this message translates to:
  /// **'Mixto: alterna diarrea y estreñimiento'**
  String get ibsSubtypeMDescription;

  /// No description provided for @ibsSubtypeU.
  ///
  /// In es, this message translates to:
  /// **'SII-NC'**
  String get ibsSubtypeU;

  /// No description provided for @ibsSubtypeUDescription.
  ///
  /// In es, this message translates to:
  /// **'No clasificado'**
  String get ibsSubtypeUDescription;

  /// No description provided for @clinicalProfileDiagnosisDateLabel.
  ///
  /// In es, this message translates to:
  /// **'Fecha de diagnóstico (opcional)'**
  String get clinicalProfileDiagnosisDateLabel;

  /// No description provided for @clinicalProfileMedicationsLabel.
  ///
  /// In es, this message translates to:
  /// **'Medicación actual (opcional)'**
  String get clinicalProfileMedicationsLabel;

  /// No description provided for @clinicalProfileMedicationsHint.
  ///
  /// In es, this message translates to:
  /// **'Nombre y dosis, si tomas algo por el SII'**
  String get clinicalProfileMedicationsHint;

  /// No description provided for @clinicalProfileSubmit.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get clinicalProfileSubmit;

  /// No description provided for @bmiTitle.
  ///
  /// In es, this message translates to:
  /// **'Índice de masa corporal'**
  String get bmiTitle;

  /// IMC calculado en vivo mientras el paciente completa peso y estatura (US03 CA04)
  ///
  /// In es, this message translates to:
  /// **'{value} kg/m²'**
  String bmiValue(String value);

  /// No description provided for @bmiCategoryUnderweight.
  ///
  /// In es, this message translates to:
  /// **'Bajo peso'**
  String get bmiCategoryUnderweight;

  /// No description provided for @bmiCategoryNormal.
  ///
  /// In es, this message translates to:
  /// **'Peso normal'**
  String get bmiCategoryNormal;

  /// No description provided for @bmiCategoryOverweight.
  ///
  /// In es, this message translates to:
  /// **'Sobrepeso'**
  String get bmiCategoryOverweight;

  /// No description provided for @bmiCategoryObese.
  ///
  /// In es, this message translates to:
  /// **'Obesidad'**
  String get bmiCategoryObese;

  /// Encuadre neutro del IMC. Es un dato informativo, no un diagnostico ni un veredicto
  ///
  /// In es, this message translates to:
  /// **'Referencia de la OMS. Tu nutricionista lo interpreta junto al resto de tu historia clínica.'**
  String get bmiNote;

  /// No description provided for @bmiPending.
  ///
  /// In es, this message translates to:
  /// **'Completa peso y estatura para verlo.'**
  String get bmiPending;

  /// No description provided for @allergiesTitle.
  ///
  /// In es, this message translates to:
  /// **'Alergias e intolerancias'**
  String get allergiesTitle;

  /// No description provided for @allergiesSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Marca las que tengas. Puedes dejarlo vacío si no aplica.'**
  String get allergiesSubtitle;

  /// No description provided for @allergiesLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando el catálogo'**
  String get allergiesLoading;

  /// No description provided for @allergiesEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay alergias en el catálogo.'**
  String get allergiesEmpty;

  /// No description provided for @allergySeverityLabel.
  ///
  /// In es, this message translates to:
  /// **'Severidad'**
  String get allergySeverityLabel;

  /// No description provided for @allergySeverityMild.
  ///
  /// In es, this message translates to:
  /// **'Leve'**
  String get allergySeverityMild;

  /// No description provided for @allergySeverityModerate.
  ///
  /// In es, this message translates to:
  /// **'Moderada'**
  String get allergySeverityModerate;

  /// No description provided for @allergySeveritySevere.
  ///
  /// In es, this message translates to:
  /// **'Severa'**
  String get allergySeveritySevere;

  /// No description provided for @allergyNotesLabel.
  ///
  /// In es, this message translates to:
  /// **'Nota (opcional)'**
  String get allergyNotesLabel;

  /// No description provided for @allergyTypeAllergy.
  ///
  /// In es, this message translates to:
  /// **'Alergia'**
  String get allergyTypeAllergy;

  /// No description provided for @allergyTypeIntolerance.
  ///
  /// In es, this message translates to:
  /// **'Intolerancia'**
  String get allergyTypeIntolerance;

  /// No description provided for @allergyTypeSensitivity.
  ///
  /// In es, this message translates to:
  /// **'Sensibilidad'**
  String get allergyTypeSensitivity;

  /// No description provided for @ibsSssTitle.
  ///
  /// In es, this message translates to:
  /// **'Cuestionario inicial'**
  String get ibsSssTitle;

  /// No description provided for @ibsSssSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Responde las cinco preguntas pensando en los últimos diez días.'**
  String get ibsSssSubtitle;

  /// No description provided for @ibsSssQuestionPainSeverity.
  ///
  /// In es, this message translates to:
  /// **'¿Qué tan intenso fue tu dolor abdominal?'**
  String get ibsSssQuestionPainSeverity;

  /// No description provided for @ibsSssPainSeverityMin.
  ///
  /// In es, this message translates to:
  /// **'Sin dolor'**
  String get ibsSssPainSeverityMin;

  /// No description provided for @ibsSssPainSeverityMax.
  ///
  /// In es, this message translates to:
  /// **'Muy intenso'**
  String get ibsSssPainSeverityMax;

  /// No description provided for @ibsSssQuestionPainFrequency.
  ///
  /// In es, this message translates to:
  /// **'¿Con qué frecuencia tuviste dolor abdominal?'**
  String get ibsSssQuestionPainFrequency;

  /// No description provided for @ibsSssPainFrequencyMin.
  ///
  /// In es, this message translates to:
  /// **'Ningún día'**
  String get ibsSssPainFrequencyMin;

  /// No description provided for @ibsSssPainFrequencyMax.
  ///
  /// In es, this message translates to:
  /// **'Todos los días'**
  String get ibsSssPainFrequencyMax;

  /// No description provided for @ibsSssQuestionBloatingSeverity.
  ///
  /// In es, this message translates to:
  /// **'¿Qué tan intensa fue la distensión o hinchazón?'**
  String get ibsSssQuestionBloatingSeverity;

  /// No description provided for @ibsSssBloatingSeverityMin.
  ///
  /// In es, this message translates to:
  /// **'Sin distensión'**
  String get ibsSssBloatingSeverityMin;

  /// No description provided for @ibsSssBloatingSeverityMax.
  ///
  /// In es, this message translates to:
  /// **'Muy intensa'**
  String get ibsSssBloatingSeverityMax;

  /// No description provided for @ibsSssQuestionBowelHabits.
  ///
  /// In es, this message translates to:
  /// **'¿Qué tan insatisfecho estuviste con tu hábito intestinal?'**
  String get ibsSssQuestionBowelHabits;

  /// No description provided for @ibsSssBowelHabitsMin.
  ///
  /// In es, this message translates to:
  /// **'Muy satisfecho'**
  String get ibsSssBowelHabitsMin;

  /// No description provided for @ibsSssBowelHabitsMax.
  ///
  /// In es, this message translates to:
  /// **'Muy insatisfecho'**
  String get ibsSssBowelHabitsMax;

  /// No description provided for @ibsSssQuestionLifeInterference.
  ///
  /// In es, this message translates to:
  /// **'¿Cuánto interfirieron los síntomas en tu vida diaria?'**
  String get ibsSssQuestionLifeInterference;

  /// No description provided for @ibsSssLifeInterferenceMin.
  ///
  /// In es, this message translates to:
  /// **'Nada'**
  String get ibsSssLifeInterferenceMin;

  /// No description provided for @ibsSssLifeInterferenceMax.
  ///
  /// In es, this message translates to:
  /// **'Muchísimo'**
  String get ibsSssLifeInterferenceMax;

  /// US04 CA02. El envio queda bloqueado hasta que las cinco esten respondidas
  ///
  /// In es, this message translates to:
  /// **'Faltan {count} preguntas por responder.'**
  String ibsSssPending(int count);

  /// No description provided for @ibsSssSubmit.
  ///
  /// In es, this message translates to:
  /// **'Enviar cuestionario'**
  String get ibsSssSubmit;

  /// No description provided for @ibsSssResultTitle.
  ///
  /// In es, this message translates to:
  /// **'Registramos tu cuestionario'**
  String get ibsSssResultTitle;

  /// Puntaje IBS-SSS calculado por el servidor. El cliente no lo computa
  ///
  /// In es, this message translates to:
  /// **'Puntaje: {score} de 500'**
  String ibsSssResultScore(int score);

  /// No description provided for @ibsSssSeverityMild.
  ///
  /// In es, this message translates to:
  /// **'Severidad leve'**
  String get ibsSssSeverityMild;

  /// No description provided for @ibsSssSeverityModerate.
  ///
  /// In es, this message translates to:
  /// **'Severidad moderada'**
  String get ibsSssSeverityModerate;

  /// No description provided for @ibsSssSeveritySevere.
  ///
  /// In es, this message translates to:
  /// **'Severidad severa'**
  String get ibsSssSeveritySevere;

  /// Encuadre neutro del resultado. Registro informativo, sin adjetivos de alarma
  ///
  /// In es, this message translates to:
  /// **'Es tu punto de partida para medir la evolución. Tu nutricionista lo revisa contigo en consulta.'**
  String get ibsSssResultNote;

  /// No description provided for @ibsSssResultContinue.
  ///
  /// In es, this message translates to:
  /// **'Ir al inicio'**
  String get ibsSssResultContinue;

  /// Acceso a la pantalla de Evolucion desde la tarjeta de Perfil (HU0023)
  ///
  /// In es, this message translates to:
  /// **'Ver tu evolución completa'**
  String get evolutionOpen;

  /// No description provided for @evolutionLoadError.
  ///
  /// In es, this message translates to:
  /// **'No pudimos cargar tu evolución'**
  String get evolutionLoadError;

  /// No description provided for @evolutionEmpty.
  ///
  /// In es, this message translates to:
  /// **'Todavía no registraste ninguna evaluación.'**
  String get evolutionEmpty;

  /// Puntaje IBS-SSS sobre el máximo del instrumento
  ///
  /// In es, this message translates to:
  /// **'{score} / 500'**
  String evolutionScore(int score);

  /// No description provided for @evolutionRangeLabel.
  ///
  /// In es, this message translates to:
  /// **'Período'**
  String get evolutionRangeLabel;

  /// No description provided for @evolutionRangeLastMonth.
  ///
  /// In es, this message translates to:
  /// **'Último mes'**
  String get evolutionRangeLastMonth;

  /// No description provided for @evolutionRangeLastQuarter.
  ///
  /// In es, this message translates to:
  /// **'Últimos 3 meses'**
  String get evolutionRangeLastQuarter;

  /// No description provided for @evolutionRangeAll.
  ///
  /// In es, this message translates to:
  /// **'Todo'**
  String get evolutionRangeAll;

  /// No description provided for @evolutionRangeEmpty.
  ///
  /// In es, this message translates to:
  /// **'No hay evaluaciones en este período. Probá con uno más amplio.'**
  String get evolutionRangeEmpty;

  /// No description provided for @evolutionPercentLabel.
  ///
  /// In es, this message translates to:
  /// **'Cambio respecto de tu línea base'**
  String get evolutionPercentLabel;

  /// Mejora porcentual. El backend entrega el cambio como negativo cuando el puntaje baja
  ///
  /// In es, this message translates to:
  /// **'{percent} % menos'**
  String evolutionPercentDown(String percent);

  /// Empeoramiento porcentual. Se muestra en tono neutro, nunca en rojo
  ///
  /// In es, this message translates to:
  /// **'{percent} % más'**
  String evolutionPercentUp(String percent);

  /// No description provided for @evolutionPercentSame.
  ///
  /// In es, this message translates to:
  /// **'Igual que tu línea base'**
  String get evolutionPercentSame;

  /// Descripcion del grafico para lectores de pantalla
  ///
  /// In es, this message translates to:
  /// **'Gráfico de tu puntaje IBS-SSS: {count} evaluaciones, de {first} a {last} puntos.'**
  String evolutionChartSemantics(int count, int first, int last);

  /// Globo que aparece al tocar un punto del grafico
  ///
  /// In es, this message translates to:
  /// **'{score} puntos el {date}'**
  String evolutionPointTooltip(int score, String date);

  /// No description provided for @evolutionBaselineOnlyTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu línea base'**
  String get evolutionBaselineOnlyTitle;

  /// No description provided for @evolutionBaselineOnlyBody.
  ///
  /// In es, this message translates to:
  /// **'Tu gráfico completo va a aparecer acá después de tu primera evaluación periódica.'**
  String get evolutionBaselineOnlyBody;

  /// Fecha que agenda el backend a catorce dias de la ultima evaluacion (CP061)
  ///
  /// In es, this message translates to:
  /// **'Próxima evaluación: {date}'**
  String evolutionNextAssessment(String date);

  /// No description provided for @profileTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu perfil'**
  String get profileTitle;

  /// Tooltip del acceso al perfil desde la barra superior
  ///
  /// In es, this message translates to:
  /// **'Abrir tu perfil'**
  String get profileOpen;

  /// No description provided for @profileClinicalSection.
  ///
  /// In es, this message translates to:
  /// **'Mi perfil clínico'**
  String get profileClinicalSection;

  /// Edad que calcula el backend a partir de la fecha de nacimiento
  ///
  /// In es, this message translates to:
  /// **'{age} años'**
  String profileAge(int age);

  /// No description provided for @profileAllergiesNone.
  ///
  /// In es, this message translates to:
  /// **'Sin alergias declaradas'**
  String get profileAllergiesNone;

  /// Cantidad de alergias que el paciente declaro en su perfil
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{1 alergia declarada} other{{count} alergias declaradas}}'**
  String profileAllergiesCount(int count);

  /// No description provided for @profilePrivacySection.
  ///
  /// In es, this message translates to:
  /// **'Privacidad y datos'**
  String get profilePrivacySection;

  /// No description provided for @profilePrivacyEntry.
  ///
  /// In es, this message translates to:
  /// **'Tu consentimiento informado'**
  String get profilePrivacyEntry;

  /// No description provided for @profilePrivacyEntryHint.
  ///
  /// In es, this message translates to:
  /// **'Consulta y descarga el documento que aceptaste'**
  String get profilePrivacyEntryHint;

  /// No description provided for @profileLoadError.
  ///
  /// In es, this message translates to:
  /// **'No pudimos cargar tu perfil'**
  String get profileLoadError;

  /// Tooltip del engranaje de la barra superior de Perfil
  ///
  /// In es, this message translates to:
  /// **'Ajustes y privacidad'**
  String get profileSettings;

  /// No description provided for @profileTrackingSection.
  ///
  /// In es, this message translates to:
  /// **'Mi seguimiento'**
  String get profileTrackingSection;

  /// No description provided for @profileTrackingStart.
  ///
  /// In es, this message translates to:
  /// **'Inicio del piloto'**
  String get profileTrackingStart;

  /// No description provided for @profileTrackingElapsed.
  ///
  /// In es, this message translates to:
  /// **'Tiempo transcurrido'**
  String get profileTrackingElapsed;

  /// Semanas completas desde el inicio del piloto
  ///
  /// In es, this message translates to:
  /// **'{weeks, plural, =1{1 semana} other{{weeks} semanas}}'**
  String profileTrackingElapsedWeeks(int weeks);

  /// No description provided for @profileTrackingElapsedFresh.
  ///
  /// In es, this message translates to:
  /// **'Menos de una semana'**
  String get profileTrackingElapsedFresh;

  /// No description provided for @profileTrackingNutritionist.
  ///
  /// In es, this message translates to:
  /// **'Mi nutricionista'**
  String get profileTrackingNutritionist;

  /// No description provided for @profileTrackingNutritionistPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente de asignación'**
  String get profileTrackingNutritionistPending;

  /// No description provided for @profileClinicalSubtype.
  ///
  /// In es, this message translates to:
  /// **'Subtipo de SII'**
  String get profileClinicalSubtype;

  /// No description provided for @profileEvolutionSection.
  ///
  /// In es, this message translates to:
  /// **'Mi evolución IBS-SSS'**
  String get profileEvolutionSection;

  /// No description provided for @profileEvolutionBaseline.
  ///
  /// In es, this message translates to:
  /// **'Línea base'**
  String get profileEvolutionBaseline;

  /// No description provided for @profileEvolutionLatest.
  ///
  /// In es, this message translates to:
  /// **'Último puntaje'**
  String get profileEvolutionLatest;

  /// No description provided for @profileEvolutionChange.
  ///
  /// In es, this message translates to:
  /// **'Cambio acumulado'**
  String get profileEvolutionChange;

  /// Puntaje IBS-SSS sobre el máximo del instrumento
  ///
  /// In es, this message translates to:
  /// **'{score} / 500'**
  String profileEvolutionScore(int score);

  /// Mejora respecto de la línea base. El backend la entrega como un cambio negativo
  ///
  /// In es, this message translates to:
  /// **'{points, plural, =1{1 punto menos} other{{points} puntos menos}}'**
  String profileEvolutionChangeDown(int points);

  /// Empeoramiento respecto de la línea base. Se muestra en tono neutro, nunca en rojo
  ///
  /// In es, this message translates to:
  /// **'{points, plural, =1{1 punto más} other{{points} puntos más}}'**
  String profileEvolutionChangeUp(int points);

  /// No description provided for @profileEvolutionChangeSame.
  ///
  /// In es, this message translates to:
  /// **'Igual que tu línea base'**
  String get profileEvolutionChangeSame;

  /// No description provided for @profileEvolutionAchievement.
  ///
  /// In es, this message translates to:
  /// **'Respuesta clínica significativa'**
  String get profileEvolutionAchievement;

  /// No description provided for @profileEvolutionOngoing.
  ///
  /// In es, this message translates to:
  /// **'Sigues en tu proceso de seguimiento'**
  String get profileEvolutionOngoing;

  /// No description provided for @profileEvolutionEmpty.
  ///
  /// In es, this message translates to:
  /// **'Completa tu primera evaluación para ver tu evolución acá.'**
  String get profileEvolutionEmpty;

  /// No description provided for @profileEvolutionEmptyAction.
  ///
  /// In es, this message translates to:
  /// **'Responder el cuestionario'**
  String get profileEvolutionEmptyAction;

  /// No description provided for @profileEdit.
  ///
  /// In es, this message translates to:
  /// **'Editar mi información'**
  String get profileEdit;

  /// No description provided for @profileEditUnavailable.
  ///
  /// In es, this message translates to:
  /// **'La edición de tus datos llega en una próxima versión.'**
  String get profileEditUnavailable;

  /// No description provided for @privacyTitle.
  ///
  /// In es, this message translates to:
  /// **'Privacidad y datos'**
  String get privacyTitle;

  /// No description provided for @privacySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Tus derechos sobre la información que Cauce guarda de ti, según la Ley N.° 29733.'**
  String get privacySubtitle;

  /// No description provided for @privacyConsentTitle.
  ///
  /// In es, this message translates to:
  /// **'Consentimiento informado'**
  String get privacyConsentTitle;

  /// No description provided for @privacyConsentBody.
  ///
  /// In es, this message translates to:
  /// **'Aceptaste participar en el piloto clínico al crear tu cuenta. Ese registro quedó guardado de forma permanente y no puede modificarse ni eliminarse.'**
  String get privacyConsentBody;

  /// No description provided for @privacyConsentDownload.
  ///
  /// In es, this message translates to:
  /// **'Descargar en PDF'**
  String get privacyConsentDownload;

  /// No description provided for @privacyConsentDownloadHint.
  ///
  /// In es, this message translates to:
  /// **'Se abrirá el menú para compartir, desde donde puedes guardarlo.'**
  String get privacyConsentDownloadHint;

  /// Confirmacion tras descargar el comprobante. HU0001 escenario 4, CP004 paso 7
  ///
  /// In es, this message translates to:
  /// **'Listo. El documento corresponde a la versión que aceptaste.'**
  String get privacyConsentDownloaded;

  /// Version del documento que acepto el paciente, no la vigente hoy
  ///
  /// In es, this message translates to:
  /// **'Versión {version}'**
  String privacyConsentVersion(String version);

  /// Fecha de aceptacion del consentimiento, en dd/MM/yyyy
  ///
  /// In es, this message translates to:
  /// **'Aceptado el {date}'**
  String privacyConsentAcceptedOn(String date);

  /// No description provided for @privacyConsentLoading.
  ///
  /// In es, this message translates to:
  /// **'Cargando tu consentimiento'**
  String get privacyConsentLoading;

  /// Aceptaciones anteriores a que el backend guardara el texto por version. El endpoint del PDF responde 404 para estas
  ///
  /// In es, this message translates to:
  /// **'No conservamos el texto de esta versión, así que no podemos generar el PDF. Tu aceptación sigue registrada y es válida. Si necesitas una copia, comunícate con tu nutricionista.'**
  String get privacyConsentTextUnavailable;

  /// No description provided for @settingsTitle.
  ///
  /// In es, this message translates to:
  /// **'Ajustes y privacidad'**
  String get settingsTitle;

  /// No description provided for @settingsEntry.
  ///
  /// In es, this message translates to:
  /// **'Ajustes y privacidad'**
  String get settingsEntry;

  /// No description provided for @settingsEntryHint.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones, tus derechos y tu cuenta'**
  String get settingsEntryHint;

  /// Etiqueta de una fila sin soporte todavia. Va en la fila misma, no en un tooltip
  ///
  /// In es, this message translates to:
  /// **'Próximamente'**
  String get settingsComingSoon;

  /// No description provided for @settingsNotificationsSection.
  ///
  /// In es, this message translates to:
  /// **'Notificaciones'**
  String get settingsNotificationsSection;

  /// No description provided for @settingsNotifAssessmentTitle.
  ///
  /// In es, this message translates to:
  /// **'Evaluaciones quincenales'**
  String get settingsNotifAssessmentTitle;

  /// No description provided for @settingsNotifAssessmentBody.
  ///
  /// In es, this message translates to:
  /// **'Recordatorio cada 14 días para responder el cuestionario IBS-SSS'**
  String get settingsNotifAssessmentBody;

  /// No description provided for @settingsNotifAdviceTitle.
  ///
  /// In es, this message translates to:
  /// **'Nuevas recomendaciones'**
  String get settingsNotifAdviceTitle;

  /// No description provided for @settingsNotifAdviceBody.
  ///
  /// In es, this message translates to:
  /// **'Aviso cuando tu nutricionista te envía una recomendación nueva'**
  String get settingsNotifAdviceBody;

  /// No description provided for @settingsRightsSection.
  ///
  /// In es, this message translates to:
  /// **'Mis derechos sobre mis datos'**
  String get settingsRightsSection;

  /// No description provided for @settingsRightsIntro.
  ///
  /// In es, this message translates to:
  /// **'Según la Ley N.° 29733 de Protección de Datos Personales, tienes derechos sobre la información que recopilamos sobre ti.'**
  String get settingsRightsIntro;

  /// No description provided for @settingsExportTitle.
  ///
  /// In es, this message translates to:
  /// **'Descargar mis datos'**
  String get settingsExportTitle;

  /// No description provided for @settingsExportBody.
  ///
  /// In es, this message translates to:
  /// **'Obtén un archivo con toda tu información registrada'**
  String get settingsExportBody;

  /// No description provided for @settingsExportConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Descargar tus datos?'**
  String get settingsExportConfirmTitle;

  /// No description provided for @settingsExportConfirmBody.
  ///
  /// In es, this message translates to:
  /// **'Vamos a preparar un archivo comprimido con tus comidas, síntomas, evaluaciones IBS-SSS, recomendaciones y tu perfil clínico. El enlace de descarga es personal y vence en 60 minutos.'**
  String get settingsExportConfirmBody;

  /// No description provided for @settingsExportConfirmAction.
  ///
  /// In es, this message translates to:
  /// **'Preparar mi archivo'**
  String get settingsExportConfirmAction;

  /// No description provided for @settingsExportOpened.
  ///
  /// In es, this message translates to:
  /// **'Abrimos tu descarga. El enlace vence en 60 minutos.'**
  String get settingsExportOpened;

  /// No description provided for @settingsExportNotOpened.
  ///
  /// In es, this message translates to:
  /// **'Preparamos tu archivo, pero no pudimos abrir el enlace. Revisa que tengas un navegador disponible e inténtalo otra vez.'**
  String get settingsExportNotOpened;

  /// No description provided for @settingsDeleteTitle.
  ///
  /// In es, this message translates to:
  /// **'Eliminar mi cuenta'**
  String get settingsDeleteTitle;

  /// No description provided for @settingsDeleteBody.
  ///
  /// In es, this message translates to:
  /// **'Solicita eliminar tu cuenta y tus datos identificables'**
  String get settingsDeleteBody;

  /// No description provided for @settingsDeleteConfirmTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Eliminar tu cuenta?'**
  String get settingsDeleteConfirmTitle;

  /// No description provided for @settingsDeleteConfirmBody.
  ///
  /// In es, this message translates to:
  /// **'Vamos a eliminar tu nombre, tu correo y todo dato que te identifique. Tus registros clínicos se conservan de forma anonimizada, sin ninguna referencia a ti, porque la normativa de investigación clínica obliga a mantenerlos. Perderás el acceso de inmediato y esta acción no se puede deshacer.'**
  String get settingsDeleteConfirmBody;

  /// No description provided for @settingsDeleteConfirmAction.
  ///
  /// In es, this message translates to:
  /// **'Continuar'**
  String get settingsDeleteConfirmAction;

  /// No description provided for @settingsDeletePilotTitle.
  ///
  /// In es, this message translates to:
  /// **'Estás en el piloto clínico'**
  String get settingsDeletePilotTitle;

  /// No description provided for @settingsDeletePilotBody.
  ///
  /// In es, this message translates to:
  /// **'Tu participación en el piloto del Complejo Hospitalario Guillermo Kaelín de la Fuente sigue activa. Al eliminar tu cuenta dejas el estudio. Las evaluaciones y registros que ya entregaste se conservan anonimizados y seguirán formando parte del análisis, porque retirarlos comprometería resultados ya publicados.'**
  String get settingsDeletePilotBody;

  /// No description provided for @settingsDeletePilotAction.
  ///
  /// In es, this message translates to:
  /// **'Entiendo, eliminar mi cuenta'**
  String get settingsDeletePilotAction;

  /// No description provided for @settingsDeleteDone.
  ///
  /// In es, this message translates to:
  /// **'Tu cuenta fue eliminada.'**
  String get settingsDeleteDone;

  /// No description provided for @settingsCorrectTitle.
  ///
  /// In es, this message translates to:
  /// **'Corregir mis datos'**
  String get settingsCorrectTitle;

  /// No description provided for @settingsCorrectBody.
  ///
  /// In es, this message translates to:
  /// **'Modifica la información personal que registraste'**
  String get settingsCorrectBody;

  /// No description provided for @settingsObjectTitle.
  ///
  /// In es, this message translates to:
  /// **'Oponerme al uso de mis datos'**
  String get settingsObjectTitle;

  /// No description provided for @settingsObjectBody.
  ///
  /// In es, this message translates to:
  /// **'Solicita limitar el uso de tu información para investigación'**
  String get settingsObjectBody;

  /// No description provided for @settingsRedFlagsSection.
  ///
  /// In es, this message translates to:
  /// **'¿Cuándo consultar al médico?'**
  String get settingsRedFlagsSection;

  /// No description provided for @settingsRedFlagsIntro.
  ///
  /// In es, this message translates to:
  /// **'Algunas señales no son típicas del SII y pueden requerir atención médica directa. Si experimentas alguna de estas, considera contactar a tu médico:'**
  String get settingsRedFlagsIntro;

  /// No description provided for @settingsRedFlagBlood.
  ///
  /// In es, this message translates to:
  /// **'Sangre en heces'**
  String get settingsRedFlagBlood;

  /// No description provided for @settingsRedFlagVomiting.
  ///
  /// In es, this message translates to:
  /// **'Vómitos persistentes'**
  String get settingsRedFlagVomiting;

  /// No description provided for @settingsRedFlagWeightLoss.
  ///
  /// In es, this message translates to:
  /// **'Pérdida de peso sin razón aparente'**
  String get settingsRedFlagWeightLoss;

  /// No description provided for @settingsRedFlagFever.
  ///
  /// In es, this message translates to:
  /// **'Fiebre alta sostenida'**
  String get settingsRedFlagFever;

  /// No description provided for @settingsRedFlagPain.
  ///
  /// In es, this message translates to:
  /// **'Dolor abdominal muy intenso e inusual'**
  String get settingsRedFlagPain;

  /// No description provided for @settingsRedFlagStool.
  ///
  /// In es, this message translates to:
  /// **'Heces muy oscuras o con color inusual'**
  String get settingsRedFlagStool;

  /// No description provided for @settingsEmergencyLabel.
  ///
  /// In es, this message translates to:
  /// **'En caso de emergencia'**
  String get settingsEmergencyLabel;

  /// No description provided for @settingsEmergencyValue.
  ///
  /// In es, this message translates to:
  /// **'EsSalud Línea 411'**
  String get settingsEmergencyValue;

  /// No description provided for @settingsAboutSection.
  ///
  /// In es, this message translates to:
  /// **'Sobre la app'**
  String get settingsAboutSection;

  /// No description provided for @settingsTerms.
  ///
  /// In es, this message translates to:
  /// **'Términos y condiciones'**
  String get settingsTerms;

  /// Fila que abre PrivacyScreen. El mockup la llama Politica de privacidad; se renombra porque el destino es el consentimiento que el paciente acepto, no un documento legal aparte
  ///
  /// In es, this message translates to:
  /// **'Tu consentimiento y tus datos'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsPrivacyPolicyHint.
  ///
  /// In es, this message translates to:
  /// **'Consulta y descarga el documento que aceptaste'**
  String get settingsPrivacyPolicyHint;

  /// No description provided for @settingsVersion.
  ///
  /// In es, this message translates to:
  /// **'Versión de la app'**
  String get settingsVersion;

  /// Version y numero de compilacion que resuelve package_info_plus
  ///
  /// In es, this message translates to:
  /// **'{version} ({build})'**
  String settingsVersionValue(String version, String build);

  /// No description provided for @settingsCredits.
  ///
  /// In es, this message translates to:
  /// **'Desarrollado por la Universidad Peruana de Ciencias Aplicadas en convenio con EsSalud · Complejo Hospitalario Guillermo Kaelín de la Fuente'**
  String get settingsCredits;

  /// No description provided for @reportTitle.
  ///
  /// In es, this message translates to:
  /// **'Tu reporte clínico'**
  String get reportTitle;

  /// No description provided for @reportEntry.
  ///
  /// In es, this message translates to:
  /// **'Generar mi reporte'**
  String get reportEntry;

  /// No description provided for @reportEntryHint.
  ///
  /// In es, this message translates to:
  /// **'Un PDF con tu historial para llevar a la consulta'**
  String get reportEntryHint;

  /// No description provided for @reportIntro.
  ///
  /// In es, this message translates to:
  /// **'Genera un PDF con tu historial de comidas, tus síntomas con sus intensidades, tus puntajes IBS-SSS y las recomendaciones que recibiste. Sirve para llevarlo a una consulta fuera de la aplicación.'**
  String get reportIntro;

  /// No description provided for @reportPeriodLabel.
  ///
  /// In es, this message translates to:
  /// **'Período del reporte'**
  String get reportPeriodLabel;

  /// No description provided for @reportPeriodLast30.
  ///
  /// In es, this message translates to:
  /// **'Últimos 30 días'**
  String get reportPeriodLast30;

  /// No description provided for @reportPeriodLast90.
  ///
  /// In es, this message translates to:
  /// **'Últimos 90 días'**
  String get reportPeriodLast90;

  /// No description provided for @reportSubmit.
  ///
  /// In es, this message translates to:
  /// **'Generar el reporte'**
  String get reportSubmit;

  /// No description provided for @reportGenerating.
  ///
  /// In es, this message translates to:
  /// **'Preparando tu reporte'**
  String get reportGenerating;

  /// Titulo del estado de exito. Afirma solo lo que el servidor confirmo: el PDF se genero
  ///
  /// In es, this message translates to:
  /// **'Tu reporte está listo'**
  String get reportReadyTitle;

  /// No description provided for @reportReadyBody.
  ///
  /// In es, this message translates to:
  /// **'El enlace de descarga queda disponible por 24 horas.'**
  String get reportReadyBody;

  /// El backend envia el correo despues de responder y no confirma la entrega. Se describe como el paso esperado, nunca como un hecho
  ///
  /// In es, this message translates to:
  /// **'El PDF está protegido. La contraseña para abrirlo llega por separado a tu correo.'**
  String get reportReadyPassword;

  /// No description provided for @reportReadyRetryHint.
  ///
  /// In es, this message translates to:
  /// **'Si en unos minutos no llega, genera el reporte de nuevo: cada intento crea una contraseña nueva.'**
  String get reportReadyRetryHint;

  /// No description provided for @reportOpenDownload.
  ///
  /// In es, this message translates to:
  /// **'Abrir la descarga'**
  String get reportOpenDownload;

  /// No description provided for @reportOpened.
  ///
  /// In es, this message translates to:
  /// **'Abrimos tu descarga.'**
  String get reportOpened;

  /// No description provided for @reportNotOpened.
  ///
  /// In es, this message translates to:
  /// **'Tu reporte se generó, pero no pudimos abrir el enlace. Revisa que tengas un navegador disponible.'**
  String get reportNotOpened;

  /// No description provided for @reportNoDataHint.
  ///
  /// In es, this message translates to:
  /// **'Elige un rango de fechas diferente y vuelve a intentarlo.'**
  String get reportNoDataHint;

  /// No description provided for @glossaryTitle.
  ///
  /// In es, this message translates to:
  /// **'Glosario'**
  String get glossaryTitle;

  /// No description provided for @glossaryEntryHint.
  ///
  /// In es, this message translates to:
  /// **'Términos médicos y nutricionales explicados'**
  String get glossaryEntryHint;

  /// No description provided for @glossarySearchLabel.
  ///
  /// In es, this message translates to:
  /// **'Buscar un término'**
  String get glossarySearchLabel;

  /// No description provided for @glossarySearchHint.
  ///
  /// In es, this message translates to:
  /// **'Por ejemplo: FODMAP'**
  String get glossarySearchHint;

  /// HU0027 CA2, CP069 paso 3. La busqueda no encontro ningun termino
  ///
  /// In es, this message translates to:
  /// **'Ese término no está en el glosario'**
  String get glossaryNotFoundTitle;

  /// No description provided for @glossaryNotFoundBody.
  ///
  /// In es, this message translates to:
  /// **'Revisa cómo lo escribiste o prueba con otra palabra.'**
  String get glossaryNotFoundBody;

  /// HU0027 CA2, CP069 paso 4. Encabezado de las sugerencias por prefijo compartido
  ///
  /// In es, this message translates to:
  /// **'Términos parecidos'**
  String get glossarySuggestionsLabel;

  /// Categoria Nutritional. Texto literal de CP068 paso 6
  ///
  /// In es, this message translates to:
  /// **'Nutricional'**
  String get glossaryCategoryNutritional;

  /// Categoria ClinicalIbs. Texto literal de CP068 paso 6, en minuscula como en el caso de prueba
  ///
  /// In es, this message translates to:
  /// **'clínico del SII'**
  String get glossaryCategoryClinicalIbs;

  /// Categoria System. Texto literal de CP068 paso 6, en minuscula como en el caso de prueba
  ///
  /// In es, this message translates to:
  /// **'propio del sistema'**
  String get glossaryCategorySystem;

  /// Se muestra mientras el backend declare contentStatus draft-pending-clinical-review (acta A27 del backend)
  ///
  /// In es, this message translates to:
  /// **'Estas definiciones son una guía general y todavía están pendientes de la validación clínica final. Ante cualquier duda, consulta con tu equipo de salud.'**
  String get glossaryDraftNote;

  /// No description provided for @glossaryEmpty.
  ///
  /// In es, this message translates to:
  /// **'El glosario todavía no tiene términos.'**
  String get glossaryEmpty;

  /// No description provided for @glossaryLoadError.
  ///
  /// In es, this message translates to:
  /// **'No pudimos cargar el glosario'**
  String get glossaryLoadError;

  /// Etiqueta del primer destino de la barra inferior (design system, seccion H)
  ///
  /// In es, this message translates to:
  /// **'Inicio'**
  String get navHome;

  /// No description provided for @navJournal.
  ///
  /// In es, this message translates to:
  /// **'Diario'**
  String get navJournal;

  /// No description provided for @navAdvice.
  ///
  /// In es, this message translates to:
  /// **'Consejos'**
  String get navAdvice;

  /// No description provided for @navProfile.
  ///
  /// In es, this message translates to:
  /// **'Perfil'**
  String get navProfile;

  /// Etiqueta accesible del boton flotante con el menu cerrado
  ///
  /// In es, this message translates to:
  /// **'Acción rápida'**
  String get fabQuickAction;

  /// Etiqueta accesible del boton flotante con el menu abierto
  ///
  /// In es, this message translates to:
  /// **'Cerrar menú'**
  String get fabCloseMenu;

  /// No description provided for @fabLogMeal.
  ///
  /// In es, this message translates to:
  /// **'Registrar comida'**
  String get fabLogMeal;

  /// No description provided for @fabLogSymptom.
  ///
  /// In es, this message translates to:
  /// **'Registrar síntoma'**
  String get fabLogSymptom;

  /// No description provided for @fabIbsSss.
  ///
  /// In es, this message translates to:
  /// **'Cuestionario IBS-SSS'**
  String get fabIbsSss;

  /// No description provided for @recommendationsTitle.
  ///
  /// In es, this message translates to:
  /// **'Consejos'**
  String get recommendationsTitle;

  /// Estado vacio de la pestana Consejos (mockup 10, variante 'Sin recomendaciones aun'). Cubre tambien el 422 insufficient_clinical_history del disparo automatico
  ///
  /// In es, this message translates to:
  /// **'Aún no hay recomendaciones'**
  String get recommendationsEmptyTitle;

  /// No description provided for @recommendationsEmptyBody.
  ///
  /// In es, this message translates to:
  /// **'Estamos analizando tus primeros registros. Mientras más comidas y síntomas registres, mejor podremos recomendarte.'**
  String get recommendationsEmptyBody;

  /// Boton secundario del estado vacio (mockup 10): invita a registrar para que haya historial
  ///
  /// In es, this message translates to:
  /// **'Registrar comida'**
  String get recommendationsEmptyAction;

  /// HU0014 CA2 / CP037. Sin tiempo estimado: el backend no calcula ninguno
  ///
  /// In es, this message translates to:
  /// **'Tu recomendación está en revisión'**
  String get recommendationsPendingTitle;

  /// No description provided for @recommendationsPendingBody.
  ///
  /// In es, this message translates to:
  /// **'Tu nutricionista la está revisando antes de que llegue a ti. Mientras tanto, puedes seguir usando la app con normalidad.'**
  String get recommendationsPendingBody;

  /// No description provided for @recommendationsLoadError.
  ///
  /// In es, this message translates to:
  /// **'No pudimos cargar tus recomendaciones.'**
  String get recommendationsLoadError;

  /// No description provided for @recommendationsListHeader.
  ///
  /// In es, this message translates to:
  /// **'Tus recomendaciones'**
  String get recommendationsListHeader;

  /// No description provided for @recommendationsListHint.
  ///
  /// In es, this message translates to:
  /// **'Toca una para ver el detalle'**
  String get recommendationsListHint;

  /// HU0014 CA1: aprobada y todavia sin abrir
  ///
  /// In es, this message translates to:
  /// **'Nueva'**
  String get recommendationNewBadge;

  /// Parte del titulo compuesto de una tarjeta (decision 3). Va en minuscula: la pantalla capitaliza la primera parte
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{evitar 1 alimento} other{evitar {count} alimentos}}'**
  String recommendationActionAvoid(int count);

  /// No description provided for @recommendationActionSubstitute.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{sustituir 1 alimento} other{sustituir {count} alimentos}}'**
  String recommendationActionSubstitute(int count);

  /// No description provided for @recommendationActionReduce.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{reducir 1 alimento} other{reducir {count} alimentos}}'**
  String recommendationActionReduce(int count);

  /// No description provided for @recommendationActionSuggest.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{incorporar 1 alimento} other{incorporar {count} alimentos}}'**
  String recommendationActionSuggest(int count);

  /// Cola de la descripcion compuesta: 'Cebolla, ajo, manzana y 2 más'
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{y 1 más} other{y {count} más}}'**
  String recommendationFoodsMore(int count);

  /// No description provided for @recommendationManualTitle.
  ///
  /// In es, this message translates to:
  /// **'Indicación de tu nutricionista'**
  String get recommendationManualTitle;

  /// No description provided for @recommendationFallbackTitle.
  ///
  /// In es, this message translates to:
  /// **'Recomendación para ti'**
  String get recommendationFallbackTitle;

  /// Pildora de origen del mockup 11 (decision 10) para Approved
  ///
  /// In es, this message translates to:
  /// **'Sugerencia del sistema'**
  String get recommendationOriginSystem;

  /// No description provided for @recommendationOriginModified.
  ///
  /// In es, this message translates to:
  /// **'Modificada por {name}'**
  String recommendationOriginModified(String name);

  /// No description provided for @recommendationOriginManual.
  ///
  /// In es, this message translates to:
  /// **'Indicación de {name}'**
  String recommendationOriginManual(String name);

  /// Respaldo cuando el backend no manda el nombre del revisor. Va en minuscula porque se inserta en una frase
  ///
  /// In es, this message translates to:
  /// **'tu nutricionista'**
  String get recommendationYourNutritionist;

  /// HU0015 CA2 / CP041: el encabezado indica la revision y el nombre del profesional
  ///
  /// In es, this message translates to:
  /// **'Revisada y validada por {name}'**
  String recommendationReviewedBy(String name);

  /// No description provided for @recommendationDateToday.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get recommendationDateToday;

  /// No description provided for @recommendationDateYesterday.
  ///
  /// In es, this message translates to:
  /// **'Ayer'**
  String get recommendationDateYesterday;

  /// No description provided for @recommendationDateDaysAgo.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{Hace 1 día} other{Hace {count} días}}'**
  String recommendationDateDaysAgo(int count);

  /// No description provided for @recommendationDetailTitle.
  ///
  /// In es, this message translates to:
  /// **'Detalle de la recomendación'**
  String get recommendationDetailTitle;

  /// No description provided for @recommendationSectionWhy.
  ///
  /// In es, this message translates to:
  /// **'Por qué te lo recomendamos'**
  String get recommendationSectionWhy;

  /// Texto literal del mockup 11 (atribucion fija, no generada). Decision 6: siempre que explanationSource no sea Manual
  ///
  /// In es, this message translates to:
  /// **'Clasificación FODMAP basada en el catálogo de Monash University (2019).'**
  String get recommendationAttribution;

  /// No description provided for @recommendationSectionItems.
  ///
  /// In es, this message translates to:
  /// **'Qué te proponemos'**
  String get recommendationSectionItems;

  /// No description provided for @recommendationItemsSuggest.
  ///
  /// In es, this message translates to:
  /// **'Incorporar'**
  String get recommendationItemsSuggest;

  /// No description provided for @recommendationItemsReduce.
  ///
  /// In es, this message translates to:
  /// **'Reducir'**
  String get recommendationItemsReduce;

  /// No description provided for @recommendationItemsAvoid.
  ///
  /// In es, this message translates to:
  /// **'Evitar'**
  String get recommendationItemsAvoid;

  /// No description provided for @recommendationItemsSubstitute.
  ///
  /// In es, this message translates to:
  /// **'Sustituir'**
  String get recommendationItemsSubstitute;

  /// No description provided for @recommendationSubstituteBy.
  ///
  /// In es, this message translates to:
  /// **'{food} por {substitute}'**
  String recommendationSubstituteBy(String food, String substitute);

  /// No description provided for @recommendationSectionNote.
  ///
  /// In es, this message translates to:
  /// **'Nota de tu nutricionista'**
  String get recommendationSectionNote;

  /// No description provided for @recommendationSectionSteps.
  ///
  /// In es, this message translates to:
  /// **'Cómo aplicarlo'**
  String get recommendationSectionSteps;

  /// No description provided for @recommendationSectionData.
  ///
  /// In es, this message translates to:
  /// **'Basado en estos datos'**
  String get recommendationSectionData;

  /// No description provided for @recommendationDataSymptoms.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{síntoma registrado en los últimos {days} días} other{síntomas registrados en los últimos {days} días}}'**
  String recommendationDataSymptoms(int count, int days);

  /// No description provided for @recommendationDataMeals.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =1{comida registrada en los últimos {days} días} other{comidas registradas en los últimos {days} días}}'**
  String recommendationDataMeals(int count, int days);

  /// No description provided for @recommendationDataHours.
  ///
  /// In es, this message translates to:
  /// **'{hours} h'**
  String recommendationDataHours(int hours);

  /// No description provided for @recommendationDataWindow.
  ///
  /// In es, this message translates to:
  /// **'ventana que usa el sistema para relacionar una comida con los síntomas que vienen después'**
  String get recommendationDataWindow;

  /// No description provided for @recommendationDataTopFoods.
  ///
  /// In es, this message translates to:
  /// **'Alimentos altos en FODMAP que más registraste: {foods}'**
  String recommendationDataTopFoods(String foods);

  /// Banner informativo del pie del mockup 11, literal
  ///
  /// In es, this message translates to:
  /// **'¿Tienes dudas sobre esta recomendación? Tu nutricionista revisará tu progreso en la próxima consulta y podrás conversar sobre cualquier ajuste.'**
  String get recommendationInfoBanner;

  /// Seccion F del design system. Umbral >= 0.70 (AvoidThreshold del motor), reversible (acta M47)
  ///
  /// In es, this message translates to:
  /// **'Confianza alta'**
  String get recommendationConfidenceHigh;

  /// No description provided for @recommendationConfidenceMedium.
  ///
  /// In es, this message translates to:
  /// **'Confianza media'**
  String get recommendationConfidenceMedium;

  /// No description provided for @recommendationConfidenceLow.
  ///
  /// In es, this message translates to:
  /// **'Confianza baja'**
  String get recommendationConfidenceLow;

  /// HU0015 CA1: que significa el nivel en terminos practicos. Redaccion del cliente, pendiente de revision clinica
  ///
  /// In es, this message translates to:
  /// **'Tus registros muestran un patrón claro y repetido que respalda esta recomendación.'**
  String get recommendationConfidenceHighBody;

  /// No description provided for @recommendationConfidenceMediumBody.
  ///
  /// In es, this message translates to:
  /// **'Tus registros muestran un patrón, pero con pocas repeticiones todavía. Seguir registrando ayuda a confirmarlo.'**
  String get recommendationConfidenceMediumBody;

  /// No description provided for @recommendationConfidenceLowBody.
  ///
  /// In es, this message translates to:
  /// **'Hay pocas señales en tus registros. Tómala como un punto de partida para conversar con tu nutricionista.'**
  String get recommendationConfidenceLowBody;

  /// No description provided for @recommendationConfidenceHint.
  ///
  /// In es, this message translates to:
  /// **'Toca para ver qué significa'**
  String get recommendationConfidenceHint;

  /// No description provided for @recommendationFeedbackTitle.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo te fue?'**
  String get recommendationFeedbackTitle;

  /// No description provided for @recommendationFeedbackIntro.
  ///
  /// In es, this message translates to:
  /// **'Cuéntanos si aplicaste esta recomendación y cómo te sentiste. Tu respuesta ayuda a mejorar las próximas.'**
  String get recommendationFeedbackIntro;

  /// No description provided for @recommendationFeedbackAppliedLabel.
  ///
  /// In es, this message translates to:
  /// **'¿Aplicaste la recomendación?'**
  String get recommendationFeedbackAppliedLabel;

  /// No description provided for @recommendationFeedbackAppliedYes.
  ///
  /// In es, this message translates to:
  /// **'Sí'**
  String get recommendationFeedbackAppliedYes;

  /// No description provided for @recommendationFeedbackAppliedNo.
  ///
  /// In es, this message translates to:
  /// **'No'**
  String get recommendationFeedbackAppliedNo;

  /// No description provided for @recommendationFeedbackOutcomeLabel.
  ///
  /// In es, this message translates to:
  /// **'¿Cómo están tus síntomas?'**
  String get recommendationFeedbackOutcomeLabel;

  /// No description provided for @recommendationFeedbackOutcomeImprovement.
  ///
  /// In es, this message translates to:
  /// **'Mejoraron'**
  String get recommendationFeedbackOutcomeImprovement;

  /// No description provided for @recommendationFeedbackOutcomeNoChange.
  ///
  /// In es, this message translates to:
  /// **'Siguen igual'**
  String get recommendationFeedbackOutcomeNoChange;

  /// No description provided for @recommendationFeedbackOutcomeWorsening.
  ///
  /// In es, this message translates to:
  /// **'Empeoraron'**
  String get recommendationFeedbackOutcomeWorsening;

  /// No description provided for @recommendationFeedbackCommentLabel.
  ///
  /// In es, this message translates to:
  /// **'Comentario (opcional)'**
  String get recommendationFeedbackCommentLabel;

  /// No description provided for @recommendationFeedbackCommentHint.
  ///
  /// In es, this message translates to:
  /// **'Por ejemplo: menos hinchazón en las noches'**
  String get recommendationFeedbackCommentHint;

  /// Contador del comentario opcional (maximo 500, SubmitFeedbackCommandValidator). Se vuelve negativo si se pasa el tope
  ///
  /// In es, this message translates to:
  /// **'Quedan {count} caracteres'**
  String recommendationFeedbackRemaining(int count);

  /// No description provided for @recommendationFeedbackTooLong.
  ///
  /// In es, this message translates to:
  /// **'El comentario supera los 500 caracteres.'**
  String get recommendationFeedbackTooLong;

  /// No description provided for @recommendationFeedbackSubmit.
  ///
  /// In es, this message translates to:
  /// **'Enviar mi respuesta'**
  String get recommendationFeedbackSubmit;

  /// Decision 8: el feedback es solo online. Sin conexion se avisa con un toast de error y reintento, sin cola local
  ///
  /// In es, this message translates to:
  /// **'No pudimos enviar tu respuesta'**
  String get recommendationFeedbackNetworkError;

  /// No description provided for @recommendationFeedbackNetworkErrorBody.
  ///
  /// In es, this message translates to:
  /// **'Revisa tu conexión e inténtalo otra vez.'**
  String get recommendationFeedbackNetworkErrorBody;

  /// No description provided for @recommendationFeedbackSent.
  ///
  /// In es, this message translates to:
  /// **'Gracias por contarnos cómo te fue'**
  String get recommendationFeedbackSent;

  /// No description provided for @recommendationFeedbackSummaryTitle.
  ///
  /// In es, this message translates to:
  /// **'Ya nos contaste cómo te fue'**
  String get recommendationFeedbackSummaryTitle;

  /// No description provided for @recommendationFeedbackSummaryApplied.
  ///
  /// In es, this message translates to:
  /// **'Aplicaste la recomendación'**
  String get recommendationFeedbackSummaryApplied;

  /// No description provided for @recommendationFeedbackSummaryNotApplied.
  ///
  /// In es, this message translates to:
  /// **'No aplicaste la recomendación'**
  String get recommendationFeedbackSummaryNotApplied;

  /// No description provided for @recommendationFeedbackSummaryImprovement.
  ///
  /// In es, this message translates to:
  /// **'Tus síntomas mejoraron'**
  String get recommendationFeedbackSummaryImprovement;

  /// No description provided for @recommendationFeedbackSummaryNoChange.
  ///
  /// In es, this message translates to:
  /// **'Tus síntomas siguieron igual'**
  String get recommendationFeedbackSummaryNoChange;

  /// No description provided for @recommendationFeedbackSummaryWorsening.
  ///
  /// In es, this message translates to:
  /// **'Tus síntomas empeoraron'**
  String get recommendationFeedbackSummaryWorsening;

  /// No description provided for @recommendationNotAvailableTitle.
  ///
  /// In es, this message translates to:
  /// **'Esta recomendación ya no está disponible'**
  String get recommendationNotAvailableTitle;

  /// No description provided for @recommendationNotAvailableBody.
  ///
  /// In es, this message translates to:
  /// **'Puede que haya vencido o que tu nutricionista la haya retirado.'**
  String get recommendationNotAvailableBody;

  /// No description provided for @recommendationNotAvailableAction.
  ///
  /// In es, this message translates to:
  /// **'Volver a mis consejos'**
  String get recommendationNotAvailableAction;

  /// Enlace del mockup 06 hacia la pestana Consejos
  ///
  /// In es, this message translates to:
  /// **'Ver todas'**
  String get homeAdviceSeeAll;

  /// No description provided for @homeAdviceNothingNew.
  ///
  /// In es, this message translates to:
  /// **'No tienes recomendaciones nuevas.'**
  String get homeAdviceNothingNew;

  /// Decision 1: aviso in-app en Inicio, hermano del de IBS-SSS, sin push
  ///
  /// In es, this message translates to:
  /// **'Tu recomendación está en revisión'**
  String get homeRecommendationPendingTitle;

  /// No description provided for @homeRecommendationPendingBody.
  ///
  /// In es, this message translates to:
  /// **'Tu nutricionista la está revisando. Cuando la apruebe, la vas a encontrar en Consejos.'**
  String get homeRecommendationPendingBody;

  /// No description provided for @homeRecommendationPendingAction.
  ///
  /// In es, this message translates to:
  /// **'Ver mis consejos'**
  String get homeRecommendationPendingAction;

  /// Restriccion de la pestana Consejos con el onboarding pendiente (CP011 paso 6)
  ///
  /// In es, this message translates to:
  /// **'Disponible al completar tu perfil'**
  String get recommendationsLockedTitle;

  /// No description provided for @recommendationsLockedBody.
  ///
  /// In es, this message translates to:
  /// **'Tus consejos se arman a partir de tu perfil clínico y de tu primera evaluación. Completa esos dos pasos y los activamos.'**
  String get recommendationsLockedBody;

  /// No description provided for @recommendationsLockedAction.
  ///
  /// In es, this message translates to:
  /// **'Continuar donde quedé'**
  String get recommendationsLockedAction;

  /// No description provided for @profileSessionSection.
  ///
  /// In es, this message translates to:
  /// **'Tu sesión'**
  String get profileSessionSection;

  /// No description provided for @profileLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesión'**
  String get profileLogout;

  /// No description provided for @profileLogoutHint.
  ///
  /// In es, this message translates to:
  /// **'Tus registros quedan guardados en este dispositivo'**
  String get profileLogoutHint;

  /// Cuadro de confirmacion antes de cerrar sesion (CP020 paso 3)
  ///
  /// In es, this message translates to:
  /// **'¿Cerrar tu sesión?'**
  String get profileLogoutConfirmTitle;

  /// No description provided for @profileLogoutConfirmBody.
  ///
  /// In es, this message translates to:
  /// **'Vas a volver a la pantalla de inicio de sesión. Lo que ya registraste se conserva y se sincroniza cuando vuelvas a entrar.'**
  String get profileLogoutConfirmBody;

  /// Encabezado del primer grupo del diario (CP022 paso 2)
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get historyToday;

  /// No description provided for @historyEmptyTodayTitle.
  ///
  /// In es, this message translates to:
  /// **'Aún no tienes comidas registradas hoy'**
  String get historyEmptyTodayTitle;

  /// No description provided for @historyEmptyTodayBody.
  ///
  /// In es, this message translates to:
  /// **'Cuando registres una comida, aparecerá aquí en tu diario.'**
  String get historyEmptyTodayBody;

  /// No description provided for @historyEmptyTodayAction.
  ///
  /// In es, this message translates to:
  /// **'Registrar primera comida'**
  String get historyEmptyTodayAction;

  /// No description provided for @historyTodayNothingYet.
  ///
  /// In es, this message translates to:
  /// **'Todavía no registraste nada hoy.'**
  String get historyTodayNothingYet;

  /// No description provided for @historySyncPending.
  ///
  /// In es, this message translates to:
  /// **'Pendiente de sincronizar'**
  String get historySyncPending;

  /// No description provided for @historySyncDone.
  ///
  /// In es, this message translates to:
  /// **'Sincronizado'**
  String get historySyncDone;

  /// Tercer estado local de sincronizacion (acta M34). No existe en el design system: se diseno coherente con la seccion F
  ///
  /// In es, this message translates to:
  /// **'No se pudo sincronizar'**
  String get historySyncFailed;

  /// No description provided for @historyIntensityBadge.
  ///
  /// In es, this message translates to:
  /// **'Intensidad {value}'**
  String historyIntensityBadge(int value);

  /// Linea de asociacion de la tarjeta de sintoma (seccion G). La ventana de 4 horas la resuelve el servidor
  ///
  /// In es, this message translates to:
  /// **'Asociado con {meal}, {delay} después'**
  String historyMealAssociatedWith(String meal, String delay);

  /// No description provided for @historyDelayHoursMinutes.
  ///
  /// In es, this message translates to:
  /// **'{hours} h {minutes} min'**
  String historyDelayHoursMinutes(int hours, int minutes);

  /// No description provided for @historyDelayMinutes.
  ///
  /// In es, this message translates to:
  /// **'{minutes} min'**
  String historyDelayMinutes(int minutes);

  /// No description provided for @historyFodmapLow.
  ///
  /// In es, this message translates to:
  /// **'Bajo en FODMAP'**
  String get historyFodmapLow;

  /// No description provided for @historyFodmapModerate.
  ///
  /// In es, this message translates to:
  /// **'Moderado FODMAP'**
  String get historyFodmapModerate;

  /// No description provided for @historyFodmapHigh.
  ///
  /// In es, this message translates to:
  /// **'Alto en FODMAP'**
  String get historyFodmapHigh;

  /// No description provided for @mealsMyDishes.
  ///
  /// In es, this message translates to:
  /// **'Mis platos'**
  String get mealsMyDishes;

  /// CP025 paso 9: el plato propio se muestra diferenciado del catalogo oficial TPCA-CENAN
  ///
  /// In es, this message translates to:
  /// **'Plato propio · no validado'**
  String get mealsOwnDishBadge;

  /// No description provided for @mealsOwnDishesOffline.
  ///
  /// In es, this message translates to:
  /// **'Tus platos propios se cargan con conexión. Los del catálogo se pueden buscar igual.'**
  String get mealsOwnDishesOffline;

  /// No description provided for @mealsSearchNoResultsTitle.
  ///
  /// In es, this message translates to:
  /// **'No encontramos ese alimento'**
  String get mealsSearchNoResultsTitle;

  /// No description provided for @mealsSearchNoResultsBody.
  ///
  /// In es, this message translates to:
  /// **'Si es una preparación tuya, puedes crearla como plato personalizado y usarla en tus comidas.'**
  String get mealsSearchNoResultsBody;

  /// CP025 paso 3: salida cuando la busqueda no encuentra el alimento
  ///
  /// In es, this message translates to:
  /// **'Crear alimento personalizado'**
  String get mealsCreateCustomFood;

  /// No description provided for @fabHintCompleteProfile.
  ///
  /// In es, this message translates to:
  /// **'Completa tu perfil clínico para registrar'**
  String get fabHintCompleteProfile;

  /// No description provided for @fabHintBaselinePending.
  ///
  /// In es, this message translates to:
  /// **'Primero responde tu evaluación inicial'**
  String get fabHintBaselinePending;

  /// Tercer estado del item del cuestionario: visible, deshabilitado y con la fecha en que vence el ciclo
  ///
  /// In es, this message translates to:
  /// **'Disponible el {date}'**
  String fabHintNotDue(String date);

  /// Titulo del aviso al tocar el cuestionario con candado
  ///
  /// In es, this message translates to:
  /// **'Todavía no toca responderlo'**
  String get fabIbsSssLockedTitle;

  /// Cuerpo del aviso al tocar el cuestionario con candado
  ///
  /// In es, this message translates to:
  /// **'Se responde cada catorce días, para que la comparación con tu línea base sea válida. El próximo se habilita el {date}.'**
  String fabIbsSssLockedBody(String date);

  /// Aviso al tocar una accion cerrada que no tiene explicacion propia
  ///
  /// In es, this message translates to:
  /// **'Esto se habilita cuando completes tu perfil clínico'**
  String get fabLockedGeneric;

  /// Restriccion del Diario con el perfil clinico pendiente (HU0003 CA01)
  ///
  /// In es, this message translates to:
  /// **'Disponible al completar tu perfil'**
  String get journalLockedTitle;

  /// No description provided for @journalLockedBody.
  ///
  /// In es, this message translates to:
  /// **'Tu diario se habilita cuando guardas tu perfil clínico. Es un paso corto y lo puedes retomar ahora.'**
  String get journalLockedBody;

  /// No description provided for @journalLockedAction.
  ///
  /// In es, this message translates to:
  /// **'Continuar donde quedé'**
  String get journalLockedAction;

  /// No description provided for @mealsIssueQuantityOutOfRange.
  ///
  /// In es, this message translates to:
  /// **'Indica una cantidad entre 0 y {max} {unit}'**
  String mealsIssueQuantityOutOfRange(String unit, String max);

  /// Tarjeta del mockup 06-home-dashboard, version minima de Mobile-3.2
  ///
  /// In es, this message translates to:
  /// **'Tu puntaje IBS-SSS'**
  String get homeScoreTitle;

  /// No description provided for @homeScoreEmpty.
  ///
  /// In es, this message translates to:
  /// **'Tu primera evaluación todavía no está registrada.'**
  String get homeScoreEmpty;

  /// No description provided for @homeScoreBaseline.
  ///
  /// In es, this message translates to:
  /// **'Es tu línea base, el punto de partida de tu seguimiento.'**
  String get homeScoreBaseline;

  /// Delta contra la linea base. Negativo es mejoria; el texto no lo califica (encuadre neutro)
  ///
  /// In es, this message translates to:
  /// **'{value} puntos respecto de tu línea base'**
  String homeScoreDelta(String value);

  /// No description provided for @homeScoreNext.
  ///
  /// In es, this message translates to:
  /// **'Próximo cuestionario: {date}'**
  String homeScoreNext(String date);

  /// No description provided for @homeScoreDue.
  ///
  /// In es, this message translates to:
  /// **'Tu próximo cuestionario ya está disponible'**
  String get homeScoreDue;

  /// No description provided for @homeTodayTitle.
  ///
  /// In es, this message translates to:
  /// **'Hoy'**
  String get homeTodayTitle;

  /// No description provided for @homeTodayEmpty.
  ///
  /// In es, this message translates to:
  /// **'Todavía no registraste nada hoy'**
  String get homeTodayEmpty;

  /// No description provided for @homeTodayMeals.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{Sin comidas} =1{1 comida} other{{count} comidas}}'**
  String homeTodayMeals(int count);

  /// No description provided for @homeTodaySymptoms.
  ///
  /// In es, this message translates to:
  /// **'{count, plural, =0{sin síntomas} =1{1 síntoma} other{{count} síntomas}}'**
  String homeTodaySymptoms(int count);

  /// No description provided for @homeTodayOpen.
  ///
  /// In es, this message translates to:
  /// **'Ver mi diario'**
  String get homeTodayOpen;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
