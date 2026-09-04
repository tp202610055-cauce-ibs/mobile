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
}
