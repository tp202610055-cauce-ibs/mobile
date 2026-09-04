// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Cauce';

  @override
  String get commonContinue => 'Continue';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonBack => 'Back';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonAccept => 'Accept';

  @override
  String get commonLoading => 'Loading';

  @override
  String get splashLoading => 'Preparing your session';

  @override
  String get loginTitle => 'Sign in';

  @override
  String get loginSubtitle => 'Sign in to continue with your follow-up';

  @override
  String get loginEmailLabel => 'Email';

  @override
  String get loginEmailHint => 'you@example.com';

  @override
  String get loginPasswordLabel => 'Password';

  @override
  String get loginPasswordHint => 'Your password';

  @override
  String get loginSubmit => 'Sign in';

  @override
  String get loginForgotPassword => 'I forgot my password';

  @override
  String get loginCreateAccount => 'Create account';

  @override
  String get loginNoAccountPrompt => 'Don\'t have an account?';

  @override
  String get loginShowPassword => 'Show password';

  @override
  String get loginHidePassword => 'Hide password';

  @override
  String get registerTitle => 'Create your account';

  @override
  String get registerSubtitle => 'Sign up to join the nutritional follow-up';

  @override
  String get registerFullNameLabel => 'Full name';

  @override
  String get registerFullNameHint => 'First and last name';

  @override
  String get registerEmailLabel => 'Email';

  @override
  String get registerEmailHint => 'you@example.com';

  @override
  String get registerPasswordLabel => 'Password';

  @override
  String get registerPasswordHint => 'At least 8 characters';

  @override
  String get registerPasswordConfirmLabel => 'Confirm your password';

  @override
  String get registerInvitationCodeLabel => 'Invitation code';

  @override
  String get registerInvitationCodeHint => 'Optional';

  @override
  String get registerConsentSectionTitle => 'Informed consent';

  @override
  String get registerConsentCheckbox =>
      'I have read and accept the informed consent';

  @override
  String get registerConsentLoading => 'Loading the current consent';

  @override
  String get registerConsentUpdated =>
      'The consent was updated. Review the changes before continuing.';

  @override
  String get registerSubmit => 'Create account';

  @override
  String get registerHasAccountPrompt => 'Already have an account?';

  @override
  String get passwordRecoveryTitle => 'Recover your password';

  @override
  String get passwordRecoverySubtitle => 'We will send you a link to reset it';

  @override
  String get passwordRecoveryEmailLabel => 'Email';

  @override
  String get passwordRecoverySubmit => 'Send link';

  @override
  String get passwordRecoverySentTitle => 'Check your email';

  @override
  String get passwordRecoverySentBody =>
      'If the email exists in our system, you will receive a recovery link valid for 30 minutes.';

  @override
  String get passwordRecoverySentBackToLogin => 'Back to sign in';

  @override
  String get passwordResetTitle => 'New password';

  @override
  String get passwordResetSubtitle =>
      'Choose a password you have not used before';

  @override
  String get passwordResetNewPasswordLabel => 'New password';

  @override
  String get passwordResetConfirmLabel => 'Confirm the new password';

  @override
  String get passwordResetSubmit => 'Reset password';

  @override
  String get passwordResetSuccessTitle => 'Password updated';

  @override
  String get passwordResetSuccessBody =>
      'You can now sign in with your new password.';

  @override
  String get passwordResetRequestNewLink => 'Request a new link';

  @override
  String get verifyEmailPendingTitle => 'Verify your email';

  @override
  String verifyEmailPendingBody(String email) {
    return 'We registered your account. We sent a verification email to $email. Follow the link to activate it.';
  }

  @override
  String get verifyEmailPendingNoEmailHint =>
      'If you did not receive the email, contact support.';

  @override
  String get verifyEmailPendingLogout => 'Sign out';

  @override
  String homeGreeting(String fullName) {
    return 'Hello, $fullName';
  }

  @override
  String get homeLogout => 'Sign out';

  @override
  String get validationRequired => 'This field is required';

  @override
  String get validationEmailInvalid => 'Enter a valid email address';

  @override
  String get validationEmailTooLong => 'The email cannot exceed 150 characters';

  @override
  String get validationFullNameLength =>
      'The name must be between 2 and 150 characters';

  @override
  String get validationPasswordTooShort =>
      'The password must be at least 8 characters';

  @override
  String get validationPasswordWeak =>
      'Must include an uppercase letter, a lowercase letter and a digit';

  @override
  String get validationPasswordMismatch => 'The passwords do not match';

  @override
  String get validationInvitationCodeFormat =>
      'The code must be 8 to 20 characters, letters and numbers only';

  @override
  String get validationConsentRequired =>
      'You must accept the informed consent to continue';

  @override
  String get errorValidation => 'Check the information you entered';

  @override
  String get errorConsentTextMismatch =>
      'The informed consent changed. Read it again and accept it.';

  @override
  String get errorInvalidInvitationCode => 'The invitation code does not exist';

  @override
  String get errorExpiredInvitationCode => 'The invitation code expired';

  @override
  String get errorInvitationCodeAlreadyUsed =>
      'The invitation code was already used';

  @override
  String get errorDuplicateEmail => 'An account with this email already exists';

  @override
  String get errorKeycloakIntegration =>
      'We could not create your account. Try again in a few minutes.';

  @override
  String get errorInvalidCredentials => 'Incorrect credentials';

  @override
  String errorAccountLocked(int minutes) {
    return 'Account locked after failed attempts. Try again in $minutes minutes.';
  }

  @override
  String get errorAccountLockedSoon =>
      'Account locked after failed attempts. Try again in less than a minute.';

  @override
  String get errorInvalidRefreshToken => 'Your session expired. Sign in again.';

  @override
  String get errorInvalidPasswordResetToken => 'The recovery link is not valid';

  @override
  String get errorExpiredPasswordResetToken =>
      'The recovery link expired or was already used';

  @override
  String get errorUserLocalMissing =>
      'There is a problem with your account. Contact support.';

  @override
  String get errorInternalServer => 'A server error occurred. Try again.';

  @override
  String get errorConsentRecordNotFound =>
      'We could not find your registered consent';

  @override
  String get errorForbidden =>
      'You do not have permission to perform this action';

  @override
  String errorRateLimited(int seconds) {
    return 'Too many attempts. Wait $seconds seconds.';
  }

  @override
  String get errorNetwork =>
      'No connection. Check your internet and try again.';

  @override
  String get errorUnknown => 'An unexpected error occurred. Try again.';
}
