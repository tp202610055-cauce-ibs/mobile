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
  String get validationNumberInvalid => 'Enter a valid number';

  @override
  String get validationDateOfBirthFuture =>
      'The date of birth cannot be in the future';

  @override
  String validationAgeOutOfRange(int min, int max) {
    return 'The pilot accepts participants between $min and $max years old';
  }

  @override
  String get validationDiagnosisDateFuture =>
      'The diagnosis date cannot be in the future';

  @override
  String get validationWeightOutOfRange =>
      'Enter a weight greater than 0 and less than 500 kg';

  @override
  String get validationHeightOutOfRange =>
      'Enter a height greater than 0 and less than 250 cm';

  @override
  String validationTextTooLong(int max) {
    return 'It cannot exceed $max characters';
  }

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
  String get errorNutritionistPendingActivation =>
      'This nutritionist has not activated their account yet. Try again later or contact them directly.';

  @override
  String get errorNutritionistUnavailable =>
      'This code is no longer available. Contact your nutritionist to get a new one.';

  @override
  String get errorPatientAlreadyAssigned =>
      'You already have a nutritionist assigned';

  @override
  String get errorPatientProfileNotFound =>
      'You have not registered your clinical profile yet';

  @override
  String get errorDuplicateProfile =>
      'Your clinical profile is already registered';

  @override
  String get errorInvalidBiometricValue =>
      'One of the clinical values is outside the allowed range. Please review it and try again.';

  @override
  String get errorAllergyNotFound =>
      'This allergy is no longer available in the catalog';

  @override
  String get errorDuplicateAllergy =>
      'This allergy is already listed in your profile';

  @override
  String get errorInvalidIbsSssDimension =>
      'One of the answers fell outside the 0 to 100 range';

  @override
  String get errorDuplicateBaselineAssessment =>
      'Your baseline questionnaire is already registered';

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

  @override
  String onboardingStepLabel(int current, int total) {
    return 'Step $current of $total';
  }

  @override
  String get onboardingDefer => 'Complete later';

  @override
  String get onboardingReminderTitle => 'Your profile is incomplete';

  @override
  String get onboardingReminderBodyProfile =>
      'Your nutritionist needs your clinical data to give you recommendations.';

  @override
  String get onboardingReminderBodyBaseline =>
      'The initial questionnaire is missing. It is the starting point to measure your progress.';

  @override
  String get onboardingReminderAction => 'Continue now';

  @override
  String get clinicalProfileTitle => 'Your clinical profile';

  @override
  String get clinicalProfileSubtitle =>
      'These details let your nutritionist tailor your recommendations.';

  @override
  String get clinicalProfileDateOfBirthLabel => 'Date of birth';

  @override
  String get clinicalProfileDatePlaceholder => 'Select a date';

  @override
  String get clinicalProfileBiologicalSexLabel => 'Biological sex';

  @override
  String get biologicalSexFemale => 'Female';

  @override
  String get biologicalSexMale => 'Male';

  @override
  String get biologicalSexOther => 'Other';

  @override
  String get clinicalProfileWeightLabel => 'Weight (kg)';

  @override
  String get clinicalProfileWeightHint => 'For example, 62.5';

  @override
  String get clinicalProfileHeightLabel => 'Height (cm)';

  @override
  String get clinicalProfileHeightHint => 'For example, 162';

  @override
  String get clinicalProfileIbsSubtypeLabel =>
      'Irritable bowel syndrome subtype';

  @override
  String get ibsSubtypeD => 'IBS-D';

  @override
  String get ibsSubtypeDDescription => 'Diarrhoea predominant';

  @override
  String get ibsSubtypeC => 'IBS-C';

  @override
  String get ibsSubtypeCDescription => 'Constipation predominant';

  @override
  String get ibsSubtypeM => 'IBS-M';

  @override
  String get ibsSubtypeMDescription =>
      'Mixed: alternates diarrhoea and constipation';

  @override
  String get ibsSubtypeU => 'IBS-U';

  @override
  String get ibsSubtypeUDescription => 'Unclassified';

  @override
  String get clinicalProfileDiagnosisDateLabel => 'Diagnosis date (optional)';

  @override
  String get clinicalProfileMedicationsLabel => 'Current medication (optional)';

  @override
  String get clinicalProfileMedicationsHint =>
      'Name and dose, if you take anything for IBS';

  @override
  String get clinicalProfileSubmit => 'Continue';

  @override
  String get bmiTitle => 'Body mass index';

  @override
  String bmiValue(String value) {
    return '$value kg/m²';
  }

  @override
  String get bmiCategoryUnderweight => 'Underweight';

  @override
  String get bmiCategoryNormal => 'Normal weight';

  @override
  String get bmiCategoryOverweight => 'Overweight';

  @override
  String get bmiCategoryObese => 'Obesity';

  @override
  String get bmiNote =>
      'WHO reference. Your nutritionist interprets it alongside the rest of your clinical history.';

  @override
  String get bmiPending => 'Fill in weight and height to see it.';

  @override
  String get allergiesTitle => 'Allergies and intolerances';

  @override
  String get allergiesSubtitle =>
      'Select the ones you have. You can leave it empty if none apply.';

  @override
  String get allergiesLoading => 'Loading the catalog';

  @override
  String get allergiesEmpty => 'There are no allergies in the catalog.';

  @override
  String get allergySeverityLabel => 'Severity';

  @override
  String get allergySeverityMild => 'Mild';

  @override
  String get allergySeverityModerate => 'Moderate';

  @override
  String get allergySeveritySevere => 'Severe';

  @override
  String get allergyNotesLabel => 'Note (optional)';

  @override
  String get allergyTypeAllergy => 'Allergy';

  @override
  String get allergyTypeIntolerance => 'Intolerance';

  @override
  String get allergyTypeSensitivity => 'Sensitivity';

  @override
  String get ibsSssTitle => 'Initial questionnaire';

  @override
  String get ibsSssSubtitle =>
      'Answer the five questions thinking about the last ten days.';

  @override
  String get ibsSssQuestionPainSeverity =>
      'How severe was your abdominal pain?';

  @override
  String get ibsSssPainSeverityMin => 'No pain';

  @override
  String get ibsSssPainSeverityMax => 'Very severe';

  @override
  String get ibsSssQuestionPainFrequency =>
      'How often did you have abdominal pain?';

  @override
  String get ibsSssPainFrequencyMin => 'No days';

  @override
  String get ibsSssPainFrequencyMax => 'Every day';

  @override
  String get ibsSssQuestionBloatingSeverity =>
      'How severe was the bloating or distension?';

  @override
  String get ibsSssBloatingSeverityMin => 'No bloating';

  @override
  String get ibsSssBloatingSeverityMax => 'Very severe';

  @override
  String get ibsSssQuestionBowelHabits =>
      'How dissatisfied were you with your bowel habits?';

  @override
  String get ibsSssBowelHabitsMin => 'Very satisfied';

  @override
  String get ibsSssBowelHabitsMax => 'Very dissatisfied';

  @override
  String get ibsSssQuestionLifeInterference =>
      'How much did the symptoms interfere with your daily life?';

  @override
  String get ibsSssLifeInterferenceMin => 'Not at all';

  @override
  String get ibsSssLifeInterferenceMax => 'A great deal';

  @override
  String ibsSssPending(int count) {
    return '$count questions still unanswered.';
  }

  @override
  String get ibsSssSubmit => 'Submit questionnaire';

  @override
  String get ibsSssResultTitle => 'We recorded your questionnaire';

  @override
  String ibsSssResultScore(int score) {
    return 'Score: $score out of 500';
  }

  @override
  String get ibsSssSeverityMild => 'Mild severity';

  @override
  String get ibsSssSeverityModerate => 'Moderate severity';

  @override
  String get ibsSssSeveritySevere => 'Severe severity';

  @override
  String get ibsSssResultNote =>
      'It is your starting point to measure progress. Your nutritionist reviews it with you.';

  @override
  String get ibsSssResultContinue => 'Go to home';
}
