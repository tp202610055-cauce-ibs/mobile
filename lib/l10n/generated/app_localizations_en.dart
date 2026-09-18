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
  String get mealsTitle => 'Log a meal';

  @override
  String get mealsAddFood => 'Add food';

  @override
  String get mealsSearchTitle => 'Search food';

  @override
  String get mealsSearchHint => 'Type the food name';

  @override
  String get mealsSearchNoResults => 'We could not find foods with that name';

  @override
  String get mealsSuggestionsFrequent => 'The ones you log most';

  @override
  String get mealsSuggestionsRecent => 'Logged today';

  @override
  String get mealsSuggestionsCatalog => 'From the catalog';

  @override
  String get mealsQuantityLabel => 'Quantity';

  @override
  String get mealsUnitLabel => 'Unit';

  @override
  String get mealsTimeLabel => 'Time of day';

  @override
  String get mealsItemsLabel => 'Foods in this meal';

  @override
  String get mealsItemsEmpty => 'You have not added any food yet';

  @override
  String get mealsRemoveItem => 'Remove';

  @override
  String get mealsSubmit => 'Log meal';

  @override
  String get mealsRegistered => 'Meal logged';

  @override
  String get mealsQueuedOffline =>
      'Meal saved. It will be sent when the connection is back.';

  @override
  String get mealsRegisterAnother => 'Log another';

  @override
  String get mealsIssueMissingMealTime => 'Choose the time of day';

  @override
  String get mealsIssueNoItems => 'Add at least one food';

  @override
  String get mealsIssueTooManyItems => 'A meal takes up to 50 foods';

  @override
  String get mealsIssueInvalidQuantity =>
      'The quantity must be greater than zero';

  @override
  String get mealsIssueInvalidReference =>
      'Each food must come from the catalog or from your dishes';

  @override
  String get mealsIssueFutureConsumedAt =>
      'The consumption date cannot be in the future';

  @override
  String get mealsFodmapLow => 'Low FODMAP load';

  @override
  String get mealsFodmapModerate => 'Moderate FODMAP load';

  @override
  String get mealsFodmapHigh => 'High FODMAP load';

  @override
  String get mealTimeBreakfast => 'Breakfast';

  @override
  String get mealTimeLunch => 'Lunch';

  @override
  String get mealTimeDinner => 'Dinner';

  @override
  String get mealTimeSnack => 'Snack';

  @override
  String get measurementUnitGrams => 'Grams';

  @override
  String get measurementUnitCups => 'Cups';

  @override
  String get measurementUnitUnits => 'Units';

  @override
  String get measurementUnitOunces => 'Ounces';

  @override
  String get measurementUnitTablespoons => 'Tablespoons';

  @override
  String get customFoodTitle => 'Create custom dish';

  @override
  String get customFoodNameLabel => 'Dish name';

  @override
  String get customFoodNameHint => 'For example: My lomo saltado';

  @override
  String get customFoodPortionLabel => 'Portion size (g)';

  @override
  String get customFoodIngredientsLabel => 'Ingredients';

  @override
  String get customFoodIngredientsEmpty => 'You have not added ingredients yet';

  @override
  String get customFoodAddIngredient => 'Add ingredient';

  @override
  String get customFoodProportionLabel => 'Amount in the dish (g)';

  @override
  String get customFoodSubmit => 'Save dish';

  @override
  String get customFoodCreated => 'Dish saved';

  @override
  String customFoodWeightDelta(String grams) {
    return 'The ingredients add up to $grams g more than the declared portion';
  }

  @override
  String customFoodWeightDeltaShort(String grams) {
    return 'The ingredients add up to $grams g less than the declared portion';
  }

  @override
  String get customFoodEstimateTitle => 'Estimated nutritional profile';

  @override
  String get customFoodEstimateNote =>
      'This is an estimate per 100 g from the ingredients. It is not saved with the dish.';

  @override
  String get customFoodEstimatePartial =>
      'Some ingredient is missing its composition, so the estimate is partial.';

  @override
  String customFoodEstimateCalories(String value) {
    return '$value kcal';
  }

  @override
  String customFoodEstimateProtein(String value) {
    return 'Protein $value g';
  }

  @override
  String customFoodEstimateCarbs(String value) {
    return 'Carbs $value g';
  }

  @override
  String customFoodEstimateFat(String value) {
    return 'Fat $value g';
  }

  @override
  String customFoodEstimateFiber(String value) {
    return 'Fiber $value g';
  }

  @override
  String get customFoodIssueInvalidName =>
      'Give it a name of up to 150 characters';

  @override
  String get customFoodIssueDuplicateName =>
      'You already have a dish with that name';

  @override
  String get customFoodIssueInvalidPortion =>
      'The portion must be greater than zero';

  @override
  String get customFoodIssueNoIngredients => 'Add at least one ingredient';

  @override
  String get customFoodIssueInvalidProportion =>
      'Each ingredient must have an amount greater than zero';

  @override
  String get customFoodIssueDuplicateIngredient =>
      'An ingredient appears twice';

  @override
  String get customFoodAllergenTitle => 'Check these ingredients';

  @override
  String get customFoodAllergenBody =>
      'These ingredients match allergies you declared in your profile.';

  @override
  String customFoodAllergenEntry(String ingredient, String allergen) {
    return '$ingredient matches $allergen';
  }

  @override
  String get customFoodAllergenSeverityMild => 'Declared as mild';

  @override
  String get customFoodAllergenSeverityModerate => 'Declared as moderate';

  @override
  String get customFoodAllergenSeveritySevere => 'Declared as severe';

  @override
  String get customFoodAllergenSeverityUnknown => 'Severity not reported';

  @override
  String get customFoodAllergenConfirm => 'I understand, save anyway';

  @override
  String get customFoodAllergenCancel => 'Go back and edit';

  @override
  String get symptomsTitle => 'Log a symptom';

  @override
  String get symptomsTypeLabel => 'What did you feel';

  @override
  String get symptomsIntensityLabel => 'Intensity';

  @override
  String get symptomsIntensityMin => 'Mild';

  @override
  String get symptomsIntensityMax => 'Very intense';

  @override
  String get symptomsSubmit => 'Log symptom';

  @override
  String get symptomsRegistered => 'Symptom logged';

  @override
  String get symptomsQueuedOffline =>
      'Symptom saved. It will be sent when the connection is back.';

  @override
  String get symptomsRegisterAnother => 'Log another';

  @override
  String get symptomsMealAssociated =>
      'We linked it to the meal you logged earlier.';

  @override
  String get symptomsMealNotAssociated =>
      'There was no meal logged in the previous 4 hours.';

  @override
  String get symptomsMealPending =>
      'The link with your meals is computed when it syncs.';

  @override
  String get symptomsIssueMissingType => 'Choose what you felt';

  @override
  String get symptomsIssueMissingIntensity => 'Set the intensity';

  @override
  String get symptomsIssueIntensityOutOfRange => 'Intensity goes from 1 to 100';

  @override
  String get symptomsIssueFutureOccurredAt =>
      'The moment cannot be in the future';

  @override
  String get symptomTypeAbdominalPain => 'Abdominal pain';

  @override
  String get symptomTypeBloating => 'Bloating';

  @override
  String get symptomTypeFlatulence => 'Flatulence';

  @override
  String get symptomTypeDiarrhea => 'Diarrhea';

  @override
  String get symptomTypeConstipation => 'Constipation';

  @override
  String get symptomTypeNausea => 'Nausea';

  @override
  String get symptomTypeReflux => 'Reflux or heartburn';

  @override
  String get symptomTypeUrgency => 'Urgency to defecate';

  @override
  String get symptomTypeOther => 'Other';

  @override
  String get historyTitle => 'My log';

  @override
  String get historyEmpty => 'You have not logged anything yet';

  @override
  String historyMealIntensity(int value) {
    return 'Intensity $value of 100';
  }

  @override
  String get historyStatePending => 'Pending to send';

  @override
  String get historyStateFailed => 'Could not be sent';

  @override
  String get historyFailedExplanation =>
      'This record could not be sent and will not be retried. You can discard it.';

  @override
  String get historyDiscard => 'Discard';

  @override
  String get historyAddNote => 'Add note';

  @override
  String get historyNoteUnavailable => 'Available once it syncs';

  @override
  String get historyMealAssociated => 'Linked to a meal';

  @override
  String get historyRefresh => 'Refresh';

  @override
  String get clinicalNoteTitle => 'Add note';

  @override
  String get clinicalNoteSubtitle =>
      'Write down anything you want to remember about this record. Your nutritionist will see it next to the data.';

  @override
  String get clinicalNoteContentLabel => 'Note';

  @override
  String get clinicalNoteContentHint =>
      'For example: I ate in a hurry, on the street';

  @override
  String clinicalNoteRemaining(int count) {
    return '$count characters left';
  }

  @override
  String get clinicalNoteTooLong => 'The note cannot exceed 500 characters';

  @override
  String get clinicalNoteSubmit => 'Save note';

  @override
  String get clinicalNoteSaved => 'Note saved';

  @override
  String get ibsSssPeriodicTitle => 'Follow-up questionnaire';

  @override
  String get ibsSssPeriodicSubtitle =>
      'Answer the five questions thinking about the last ten days.';

  @override
  String get ibsSssPeriodicSubmit => 'Submit questionnaire';

  @override
  String get ibsSssEvolutionTitle => 'Your evolution';

  @override
  String get ibsSssEvolutionEmpty =>
      'With a single assessment there is no evolution to show yet.';

  @override
  String ibsSssEvolutionRange(int first, int last) {
    return 'From $first to $last points';
  }

  @override
  String ibsSssEvolutionDelta(int value) {
    return '$value points compared to your baseline';
  }

  @override
  String get ibsSssEvolutionImprovement =>
      'That is a reduction of 50 points or more compared to your baseline. Your nutritionist will interpret it with you.';

  @override
  String get ibsSssReminderTitle => 'Your follow-up questionnaire is due';

  @override
  String get ibsSssReminderBody =>
      'Fourteen days have passed since your last assessment.';

  @override
  String get ibsSssReminderAction => 'Answer now';

  @override
  String get errorFoodItemNotFound =>
      'That food is no longer available in the catalog';

  @override
  String get errorCustomFoodNotFound => 'We could not find that custom dish';

  @override
  String get errorDuplicateCustomFood =>
      'You already have a dish with that name';

  @override
  String get errorCustomFoodInUse =>
      'You cannot delete this dish because you already used it in a registered meal';

  @override
  String get errorDuplicateIngredient =>
      'That ingredient is already in the dish';

  @override
  String get errorIngredientNotFound =>
      'That ingredient is no longer in the dish';

  @override
  String get errorUnconfirmedAllergens =>
      'This dish contains ingredients that match your declared allergies';

  @override
  String get errorInvalidMealRegistration =>
      'We could not register the meal. Check the details and try again.';

  @override
  String get errorMealNotFound => 'We could not find that registered meal';

  @override
  String get errorSymptomNotFound =>
      'We could not find that registered symptom';

  @override
  String get errorClinicalNoteNotFound => 'We could not find that note';

  @override
  String get errorInvalidClinicalNoteAssociation =>
      'A note is linked to either a meal or a symptom, not both';

  @override
  String get errorIdempotencyMismatch =>
      'There was a conflict saving this record. Try again.';

  @override
  String get errorDomainRuleViolation =>
      'We could not complete the operation. Check the details and try again.';

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

  @override
  String get profileTitle => 'Your profile';

  @override
  String get profileOpen => 'Open your profile';

  @override
  String get profileClinicalSection => 'Clinical data';

  @override
  String profileAge(int age) {
    return '$age years old';
  }

  @override
  String get profileAllergiesNone => 'No allergies declared';

  @override
  String profileAllergiesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count allergies declared',
      one: '1 allergy declared',
    );
    return '$_temp0';
  }

  @override
  String get profilePrivacySection => 'Privacy and data';

  @override
  String get profilePrivacyEntry => 'Your informed consent';

  @override
  String get profilePrivacyEntryHint =>
      'Review and download the document you accepted';

  @override
  String get profileLoadError => 'We could not load your profile';

  @override
  String get privacyTitle => 'Privacy and data';

  @override
  String get privacySubtitle =>
      'Your rights over the information Cauce keeps about you, under Peruvian Law 29733.';

  @override
  String get privacyConsentTitle => 'Informed consent';

  @override
  String get privacyConsentBody =>
      'You agreed to take part in the clinical pilot when you created your account. That record was stored permanently and cannot be modified or deleted.';

  @override
  String get privacyConsentDownload => 'Download as PDF';

  @override
  String get privacyConsentDownloadHint =>
      'The share menu will open, where you can save it.';

  @override
  String get privacyConsentDownloaded =>
      'Done. The document matches the version you accepted.';

  @override
  String privacyConsentVersion(String version) {
    return 'Version $version';
  }

  @override
  String privacyConsentAcceptedOn(String date) {
    return 'Accepted on $date';
  }

  @override
  String get privacyConsentLoading => 'Loading your consent';

  @override
  String get privacyConsentTextUnavailable =>
      'We do not keep the text of this version, so we cannot generate the PDF. Your acceptance is still recorded and valid. If you need a copy, contact your nutritionist.';
}
