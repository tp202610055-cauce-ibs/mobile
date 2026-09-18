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
  /// **'Preparando tu sesion'**
  String get splashLoading;

  /// No description provided for @loginTitle.
  ///
  /// In es, this message translates to:
  /// **'Inicia sesion'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Ingresa a tu cuenta para continuar con tu seguimiento'**
  String get loginSubtitle;

  /// No description provided for @loginEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electronico'**
  String get loginEmailLabel;

  /// No description provided for @loginEmailHint.
  ///
  /// In es, this message translates to:
  /// **'tucorreo@ejemplo.com'**
  String get loginEmailHint;

  /// No description provided for @loginPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contrasena'**
  String get loginPasswordLabel;

  /// No description provided for @loginPasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Tu contrasena'**
  String get loginPasswordHint;

  /// No description provided for @loginSubmit.
  ///
  /// In es, this message translates to:
  /// **'Iniciar sesion'**
  String get loginSubmit;

  /// No description provided for @loginForgotPassword.
  ///
  /// In es, this message translates to:
  /// **'Olvide mi contrasena'**
  String get loginForgotPassword;

  /// No description provided for @loginCreateAccount.
  ///
  /// In es, this message translates to:
  /// **'Crear cuenta'**
  String get loginCreateAccount;

  /// No description provided for @loginNoAccountPrompt.
  ///
  /// In es, this message translates to:
  /// **'No tienes cuenta?'**
  String get loginNoAccountPrompt;

  /// No description provided for @loginShowPassword.
  ///
  /// In es, this message translates to:
  /// **'Mostrar contrasena'**
  String get loginShowPassword;

  /// No description provided for @loginHidePassword.
  ///
  /// In es, this message translates to:
  /// **'Ocultar contrasena'**
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
  /// **'Correo electronico'**
  String get registerEmailLabel;

  /// No description provided for @registerEmailHint.
  ///
  /// In es, this message translates to:
  /// **'tucorreo@ejemplo.com'**
  String get registerEmailHint;

  /// No description provided for @registerPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Contrasena'**
  String get registerPasswordLabel;

  /// No description provided for @registerPasswordHint.
  ///
  /// In es, this message translates to:
  /// **'Minimo 8 caracteres'**
  String get registerPasswordHint;

  /// No description provided for @registerPasswordConfirmLabel.
  ///
  /// In es, this message translates to:
  /// **'Confirma tu contrasena'**
  String get registerPasswordConfirmLabel;

  /// No description provided for @registerInvitationCodeLabel.
  ///
  /// In es, this message translates to:
  /// **'Codigo de invitacion'**
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
  /// **'Ya tienes cuenta?'**
  String get registerHasAccountPrompt;

  /// No description provided for @passwordRecoveryTitle.
  ///
  /// In es, this message translates to:
  /// **'Recupera tu contrasena'**
  String get passwordRecoveryTitle;

  /// No description provided for @passwordRecoverySubtitle.
  ///
  /// In es, this message translates to:
  /// **'Te enviaremos un enlace para restablecerla'**
  String get passwordRecoverySubtitle;

  /// No description provided for @passwordRecoveryEmailLabel.
  ///
  /// In es, this message translates to:
  /// **'Correo electronico'**
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
  /// **'Si el correo existe en nuestro sistema, recibiras un enlace de recuperacion valido por 30 minutos.'**
  String get passwordRecoverySentBody;

  /// No description provided for @passwordRecoverySentBackToLogin.
  ///
  /// In es, this message translates to:
  /// **'Volver a iniciar sesion'**
  String get passwordRecoverySentBackToLogin;

  /// No description provided for @passwordResetTitle.
  ///
  /// In es, this message translates to:
  /// **'Nueva contrasena'**
  String get passwordResetTitle;

  /// No description provided for @passwordResetSubtitle.
  ///
  /// In es, this message translates to:
  /// **'Elige una contrasena que no hayas usado antes'**
  String get passwordResetSubtitle;

  /// No description provided for @passwordResetNewPasswordLabel.
  ///
  /// In es, this message translates to:
  /// **'Nueva contrasena'**
  String get passwordResetNewPasswordLabel;

  /// No description provided for @passwordResetConfirmLabel.
  ///
  /// In es, this message translates to:
  /// **'Confirma la nueva contrasena'**
  String get passwordResetConfirmLabel;

  /// No description provided for @passwordResetSubmit.
  ///
  /// In es, this message translates to:
  /// **'Restablecer contrasena'**
  String get passwordResetSubmit;

  /// No description provided for @passwordResetSuccessTitle.
  ///
  /// In es, this message translates to:
  /// **'Contrasena actualizada'**
  String get passwordResetSuccessTitle;

  /// No description provided for @passwordResetSuccessBody.
  ///
  /// In es, this message translates to:
  /// **'Ya puedes iniciar sesion con tu nueva contrasena.'**
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
  /// **'Registramos tu cuenta. Te enviamos un correo de verificacion a {email}. Sigue el enlace para activarla.'**
  String verifyEmailPendingBody(String email);

  /// No description provided for @verifyEmailPendingNoEmailHint.
  ///
  /// In es, this message translates to:
  /// **'Si no recibiste el correo, comunicate con soporte.'**
  String get verifyEmailPendingNoEmailHint;

  /// No description provided for @verifyEmailPendingLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesion'**
  String get verifyEmailPendingLogout;

  /// Saludo de bienvenida en HomeScreen
  ///
  /// In es, this message translates to:
  /// **'Hola, {fullName}'**
  String homeGreeting(String fullName);

  /// No description provided for @homeLogout.
  ///
  /// In es, this message translates to:
  /// **'Cerrar sesion'**
  String get homeLogout;

  /// No description provided for @validationRequired.
  ///
  /// In es, this message translates to:
  /// **'Este campo es obligatorio'**
  String get validationRequired;

  /// No description provided for @validationEmailInvalid.
  ///
  /// In es, this message translates to:
  /// **'Ingresa un correo electronico valido'**
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
  /// **'La contrasena debe tener al menos 8 caracteres'**
  String get validationPasswordTooShort;

  /// No description provided for @validationPasswordWeak.
  ///
  /// In es, this message translates to:
  /// **'Debe incluir una mayuscula, una minuscula y un digito'**
  String get validationPasswordWeak;

  /// No description provided for @validationPasswordMismatch.
  ///
  /// In es, this message translates to:
  /// **'Las contrasenas no coinciden'**
  String get validationPasswordMismatch;

  /// No description provided for @validationInvitationCodeFormat.
  ///
  /// In es, this message translates to:
  /// **'El codigo debe tener entre 8 y 20 caracteres, solo letras y numeros'**
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
  /// **'El codigo de invitacion no existe'**
  String get errorInvalidInvitationCode;

  /// errorCode expired_invitation_code (400)
  ///
  /// In es, this message translates to:
  /// **'El codigo de invitacion vencio'**
  String get errorExpiredInvitationCode;

  /// errorCode invitation_code_already_used (400)
  ///
  /// In es, this message translates to:
  /// **'El codigo de invitacion ya fue usado'**
  String get errorInvitationCodeAlreadyUsed;

  /// errorCode nutritionist_not_available (409) con la extension reason en pending_activation. El codigo no se consume, asi que reintentar con el mismo es valido
  ///
  /// In es, this message translates to:
  /// **'Este nutricionista todavia no activo su cuenta. Intenta de nuevo mas tarde o comunicate directamente con el.'**
  String get errorNutritionistPendingActivation;

  /// errorCode nutritionist_not_available (409) con la extension reason en inactive o suspended. Tambien cubre el reason ausente o desconocido, que ErrorMapper degrada a inactive
  ///
  /// In es, this message translates to:
  /// **'Este codigo ya no esta disponible. Comunicate con tu nutricionista para obtener uno nuevo.'**
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
  /// **'Los que mas registras'**
  String get mealsSuggestionsFrequent;

  /// Seccion recentLast24Hours de GET /foods/suggestions
  ///
  /// In es, this message translates to:
  /// **'Registrados hoy'**
  String get mealsSuggestionsRecent;

  /// Seccion catalogSuggestions de GET /foods/suggestions
  ///
  /// In es, this message translates to:
  /// **'Del catalogo'**
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
  /// **'Momento del dia'**
  String get mealsTimeLabel;

  /// Encabezado de la lista de items
  ///
  /// In es, this message translates to:
  /// **'Alimentos de esta comida'**
  String get mealsItemsLabel;

  /// Lista de items vacia
  ///
  /// In es, this message translates to:
  /// **'Todavia no agregaste ningun alimento'**
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
  /// **'Comida guardada. Se enviara cuando vuelva la conexion.'**
  String get mealsQueuedOffline;

  /// Accion para vaciar el formulario y anotar otra comida
  ///
  /// In es, this message translates to:
  /// **'Registrar otra'**
  String get mealsRegisterAnother;

  /// CA04: falta MealTime
  ///
  /// In es, this message translates to:
  /// **'Elige el momento del dia'**
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
  /// **'Cada alimento debe venir del catalogo o de tus platos'**
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
  /// **'Tamano de porcion (g)'**
  String get customFoodPortionLabel;

  /// Encabezado de la lista de ingredientes
  ///
  /// In es, this message translates to:
  /// **'Ingredientes'**
  String get customFoodIngredientsLabel;

  /// Lista de ingredientes vacia
  ///
  /// In es, this message translates to:
  /// **'Todavia no agregaste ingredientes'**
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
  /// **'Los ingredientes suman {grams} g mas que la porcion declarada'**
  String customFoodWeightDelta(String grams);

  /// Misma diferencia, cuando los ingredientes pesan menos
  ///
  /// In es, this message translates to:
  /// **'Los ingredientes suman {grams} g menos que la porcion declarada'**
  String customFoodWeightDeltaShort(String grams);

  /// Encabezado de la vista previa de CA01
  ///
  /// In es, this message translates to:
  /// **'Perfil nutricional estimado'**
  String get customFoodEstimateTitle;

  /// Aclaracion de CA01: el calculo es del cliente y el contrato no lo persiste
  ///
  /// In es, this message translates to:
  /// **'Es una estimacion por 100 g a partir de los ingredientes. No se guarda con el plato.'**
  String get customFoodEstimateNote;

  /// Aviso cuando algun ingrediente no tiene FoodItemDetail
  ///
  /// In es, this message translates to:
  /// **'Falta la composicion de algun ingrediente, asi que la estimacion es parcial.'**
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
  /// **'La porcion debe ser mayor que cero'**
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
  /// **'Registrar sintoma'**
  String get symptomsTitle;

  /// Etiqueta del selector de SymptomType
  ///
  /// In es, this message translates to:
  /// **'Que sentiste'**
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
  /// **'Registrar sintoma'**
  String get symptomsSubmit;

  /// Confirmacion cuando el servidor lo acepto
  ///
  /// In es, this message translates to:
  /// **'Sintoma registrado'**
  String get symptomsRegistered;

  /// Confirmacion cuando quedo en la cola local
  ///
  /// In es, this message translates to:
  /// **'Sintoma guardado. Se enviara cuando vuelva la conexion.'**
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
  /// **'La relacion con tus comidas se calcula al sincronizar.'**
  String get symptomsMealPending;

  /// Falta SymptomType
  ///
  /// In es, this message translates to:
  /// **'Elige que sentiste'**
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
  /// **'Distension abdominal'**
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
  /// **'Estrenimiento'**
  String get symptomTypeConstipation;

  /// SymptomType Nausea
  ///
  /// In es, this message translates to:
  /// **'Nauseas'**
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
  /// **'Todavia no registraste nada'**
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
  /// **'Responde las cinco preguntas pensando en los ultimos diez dias.'**
  String get ibsSssPeriodicSubtitle;

  /// Boton de envio del cuestionario periodico
  ///
  /// In es, this message translates to:
  /// **'Enviar cuestionario'**
  String get ibsSssPeriodicSubmit;

  /// Encabezado del grafico de evolucion (CA03)
  ///
  /// In es, this message translates to:
  /// **'Tu evolucion'**
  String get ibsSssEvolutionTitle;

  /// Menos de dos puntos: no hay linea que trazar
  ///
  /// In es, this message translates to:
  /// **'Con una sola evaluacion todavia no hay evolucion que mostrar.'**
  String get ibsSssEvolutionEmpty;

  /// Extremos de la serie, en texto, porque el grafico no dibuja escala
  ///
  /// In es, this message translates to:
  /// **'De {first} a {last} puntos'**
  String ibsSssEvolutionRange(int first, int last);

  /// Diferencia contra la linea base. Negativo es mejoria
  ///
  /// In es, this message translates to:
  /// **'{value} puntos respecto de tu linea base'**
  String ibsSssEvolutionDelta(int value);

  /// MCID del IBS-SSS. Se enuncia como dato, no como felicitacion
  ///
  /// In es, this message translates to:
  /// **'Es una reduccion de 50 puntos o mas respecto de tu linea base. Tu nutricionista lo interpretara contigo.'**
  String get ibsSssEvolutionImprovement;

  /// Titulo del aviso de la home cuando vencio el ciclo (CA01)
  ///
  /// In es, this message translates to:
  /// **'Toca tu cuestionario de seguimiento'**
  String get ibsSssReminderTitle;

  /// Cuerpo del aviso de la home
  ///
  /// In es, this message translates to:
  /// **'Pasaron los catorce dias desde tu ultima evaluacion.'**
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
  /// **'Tu sesion expiro. Inicia sesion de nuevo.'**
  String get errorInvalidRefreshToken;

  /// errorCode invalid_password_reset_token (400)
  ///
  /// In es, this message translates to:
  /// **'El enlace de recuperacion no es valido'**
  String get errorInvalidPasswordResetToken;

  /// errorCode expired_password_reset_token (400)
  ///
  /// In es, this message translates to:
  /// **'El enlace de recuperacion vencio o ya fue usado'**
  String get errorExpiredPasswordResetToken;

  /// errorCode user_local_missing (500). Inconsistencia de aprovisionamiento entre Keycloak y el backend
  ///
  /// In es, this message translates to:
  /// **'Hay un problema con tu cuenta. Comunicate con soporte.'**
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
  /// **'No tienes permiso para realizar esta accion'**
  String get errorForbidden;

  /// HTTP 429, que no trae errorCode. Los segundos salen de la extension retryAfterSeconds o del header Retry-After
  ///
  /// In es, this message translates to:
  /// **'Demasiados intentos. Espera {seconds} segundos.'**
  String errorRateLimited(int seconds);

  /// Timeout o ausencia de red, sin respuesta del servidor
  ///
  /// In es, this message translates to:
  /// **'Sin conexion. Verifica tu internet e intenta de nuevo.'**
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
  /// **'Datos clínicos'**
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
