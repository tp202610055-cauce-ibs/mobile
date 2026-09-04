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
