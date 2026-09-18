// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cauce_api_error.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DetectedAllergen {
  /// Nombre del alimento del catalogo que dispara la coincidencia.
  String get ingredientName => throw _privateConstructorUsedError;

  /// Nombre de la alergia declarada con la que coincide.
  String get allergenName => throw _privateConstructorUsedError;

  /// Severidad declarada, o `null` si el valor no se reconocio.
  DetectedAllergenSeverity? get severity => throw _privateConstructorUsedError;

  /// Create a copy of DetectedAllergen
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DetectedAllergenCopyWith<DetectedAllergen> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DetectedAllergenCopyWith<$Res> {
  factory $DetectedAllergenCopyWith(
          DetectedAllergen value, $Res Function(DetectedAllergen) then) =
      _$DetectedAllergenCopyWithImpl<$Res, DetectedAllergen>;
  @useResult
  $Res call(
      {String ingredientName,
      String allergenName,
      DetectedAllergenSeverity? severity});
}

/// @nodoc
class _$DetectedAllergenCopyWithImpl<$Res, $Val extends DetectedAllergen>
    implements $DetectedAllergenCopyWith<$Res> {
  _$DetectedAllergenCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DetectedAllergen
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredientName = null,
    Object? allergenName = null,
    Object? severity = freezed,
  }) {
    return _then(_value.copyWith(
      ingredientName: null == ingredientName
          ? _value.ingredientName
          : ingredientName // ignore: cast_nullable_to_non_nullable
              as String,
      allergenName: null == allergenName
          ? _value.allergenName
          : allergenName // ignore: cast_nullable_to_non_nullable
              as String,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as DetectedAllergenSeverity?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DetectedAllergenImplCopyWith<$Res>
    implements $DetectedAllergenCopyWith<$Res> {
  factory _$$DetectedAllergenImplCopyWith(_$DetectedAllergenImpl value,
          $Res Function(_$DetectedAllergenImpl) then) =
      __$$DetectedAllergenImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ingredientName,
      String allergenName,
      DetectedAllergenSeverity? severity});
}

/// @nodoc
class __$$DetectedAllergenImplCopyWithImpl<$Res>
    extends _$DetectedAllergenCopyWithImpl<$Res, _$DetectedAllergenImpl>
    implements _$$DetectedAllergenImplCopyWith<$Res> {
  __$$DetectedAllergenImplCopyWithImpl(_$DetectedAllergenImpl _value,
      $Res Function(_$DetectedAllergenImpl) _then)
      : super(_value, _then);

  /// Create a copy of DetectedAllergen
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ingredientName = null,
    Object? allergenName = null,
    Object? severity = freezed,
  }) {
    return _then(_$DetectedAllergenImpl(
      ingredientName: null == ingredientName
          ? _value.ingredientName
          : ingredientName // ignore: cast_nullable_to_non_nullable
              as String,
      allergenName: null == allergenName
          ? _value.allergenName
          : allergenName // ignore: cast_nullable_to_non_nullable
              as String,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as DetectedAllergenSeverity?,
    ));
  }
}

/// @nodoc

class _$DetectedAllergenImpl extends _DetectedAllergen {
  const _$DetectedAllergenImpl(
      {required this.ingredientName, required this.allergenName, this.severity})
      : super._();

  /// Nombre del alimento del catalogo que dispara la coincidencia.
  @override
  final String ingredientName;

  /// Nombre de la alergia declarada con la que coincide.
  @override
  final String allergenName;

  /// Severidad declarada, o `null` si el valor no se reconocio.
  @override
  final DetectedAllergenSeverity? severity;

  @override
  String toString() {
    return 'DetectedAllergen(ingredientName: $ingredientName, allergenName: $allergenName, severity: $severity)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DetectedAllergenImpl &&
            (identical(other.ingredientName, ingredientName) ||
                other.ingredientName == ingredientName) &&
            (identical(other.allergenName, allergenName) ||
                other.allergenName == allergenName) &&
            (identical(other.severity, severity) ||
                other.severity == severity));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, ingredientName, allergenName, severity);

  /// Create a copy of DetectedAllergen
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DetectedAllergenImplCopyWith<_$DetectedAllergenImpl> get copyWith =>
      __$$DetectedAllergenImplCopyWithImpl<_$DetectedAllergenImpl>(
          this, _$identity);
}

abstract class _DetectedAllergen extends DetectedAllergen {
  const factory _DetectedAllergen(
      {required final String ingredientName,
      required final String allergenName,
      final DetectedAllergenSeverity? severity}) = _$DetectedAllergenImpl;
  const _DetectedAllergen._() : super._();

  /// Nombre del alimento del catalogo que dispara la coincidencia.
  @override
  String get ingredientName;

  /// Nombre de la alergia declarada con la que coincide.
  @override
  String get allergenName;

  /// Severidad declarada, o `null` si el valor no se reconocio.
  @override
  DetectedAllergenSeverity? get severity;

  /// Create a copy of DetectedAllergen
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DetectedAllergenImplCopyWith<_$DetectedAllergenImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CauceApiError {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CauceApiErrorCopyWith<$Res> {
  factory $CauceApiErrorCopyWith(
          CauceApiError value, $Res Function(CauceApiError) then) =
      _$CauceApiErrorCopyWithImpl<$Res, CauceApiError>;
}

/// @nodoc
class _$CauceApiErrorCopyWithImpl<$Res, $Val extends CauceApiError>
    implements $CauceApiErrorCopyWith<$Res> {
  _$CauceApiErrorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ValidationErrorImplCopyWith<$Res> {
  factory _$$ValidationErrorImplCopyWith(_$ValidationErrorImpl value,
          $Res Function(_$ValidationErrorImpl) then) =
      __$$ValidationErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({Map<String, List<String>> fieldErrors, String? errorCode});
}

/// @nodoc
class __$$ValidationErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$ValidationErrorImpl>
    implements _$$ValidationErrorImplCopyWith<$Res> {
  __$$ValidationErrorImplCopyWithImpl(
      _$ValidationErrorImpl _value, $Res Function(_$ValidationErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fieldErrors = null,
    Object? errorCode = freezed,
  }) {
    return _then(_$ValidationErrorImpl(
      fieldErrors: null == fieldErrors
          ? _value._fieldErrors
          : fieldErrors // ignore: cast_nullable_to_non_nullable
              as Map<String, List<String>>,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ValidationErrorImpl implements ValidationError {
  const _$ValidationErrorImpl(
      {required final Map<String, List<String>> fieldErrors, this.errorCode})
      : _fieldErrors = fieldErrors;

  final Map<String, List<String>> _fieldErrors;
  @override
  Map<String, List<String>> get fieldErrors {
    if (_fieldErrors is EqualUnmodifiableMapView) return _fieldErrors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_fieldErrors);
  }

  @override
  final String? errorCode;

  @override
  String toString() {
    return 'CauceApiError.validation(fieldErrors: $fieldErrors, errorCode: $errorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ValidationErrorImpl &&
            const DeepCollectionEquality()
                .equals(other._fieldErrors, _fieldErrors) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_fieldErrors), errorCode);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ValidationErrorImplCopyWith<_$ValidationErrorImpl> get copyWith =>
      __$$ValidationErrorImplCopyWithImpl<_$ValidationErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return validation(fieldErrors, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return validation?.call(fieldErrors, errorCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(fieldErrors, errorCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return validation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return validation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (validation != null) {
      return validation(this);
    }
    return orElse();
  }
}

abstract class ValidationError implements CauceApiError {
  const factory ValidationError(
      {required final Map<String, List<String>> fieldErrors,
      final String? errorCode}) = _$ValidationErrorImpl;

  Map<String, List<String>> get fieldErrors;
  String? get errorCode;

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ValidationErrorImplCopyWith<_$ValidationErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidCredentialsErrorImplCopyWith<$Res> {
  factory _$$InvalidCredentialsErrorImplCopyWith(
          _$InvalidCredentialsErrorImpl value,
          $Res Function(_$InvalidCredentialsErrorImpl) then) =
      __$$InvalidCredentialsErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidCredentialsErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$InvalidCredentialsErrorImpl>
    implements _$$InvalidCredentialsErrorImplCopyWith<$Res> {
  __$$InvalidCredentialsErrorImplCopyWithImpl(
      _$InvalidCredentialsErrorImpl _value,
      $Res Function(_$InvalidCredentialsErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InvalidCredentialsErrorImpl implements InvalidCredentialsError {
  const _$InvalidCredentialsErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.invalidCredentials()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidCredentialsErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return invalidCredentials();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return invalidCredentials?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (invalidCredentials != null) {
      return invalidCredentials();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return invalidCredentials(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return invalidCredentials?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (invalidCredentials != null) {
      return invalidCredentials(this);
    }
    return orElse();
  }
}

abstract class InvalidCredentialsError implements CauceApiError {
  const factory InvalidCredentialsError() = _$InvalidCredentialsErrorImpl;
}

/// @nodoc
abstract class _$$AccountLockedErrorImplCopyWith<$Res> {
  factory _$$AccountLockedErrorImplCopyWith(_$AccountLockedErrorImpl value,
          $Res Function(_$AccountLockedErrorImpl) then) =
      __$$AccountLockedErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({DateTime lockedUntil});
}

/// @nodoc
class __$$AccountLockedErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$AccountLockedErrorImpl>
    implements _$$AccountLockedErrorImplCopyWith<$Res> {
  __$$AccountLockedErrorImplCopyWithImpl(_$AccountLockedErrorImpl _value,
      $Res Function(_$AccountLockedErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lockedUntil = null,
  }) {
    return _then(_$AccountLockedErrorImpl(
      lockedUntil: null == lockedUntil
          ? _value.lockedUntil
          : lockedUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$AccountLockedErrorImpl implements AccountLockedError {
  const _$AccountLockedErrorImpl({required this.lockedUntil});

  @override
  final DateTime lockedUntil;

  @override
  String toString() {
    return 'CauceApiError.accountLocked(lockedUntil: $lockedUntil)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AccountLockedErrorImpl &&
            (identical(other.lockedUntil, lockedUntil) ||
                other.lockedUntil == lockedUntil));
  }

  @override
  int get hashCode => Object.hash(runtimeType, lockedUntil);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AccountLockedErrorImplCopyWith<_$AccountLockedErrorImpl> get copyWith =>
      __$$AccountLockedErrorImplCopyWithImpl<_$AccountLockedErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return accountLocked(lockedUntil);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return accountLocked?.call(lockedUntil);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (accountLocked != null) {
      return accountLocked(lockedUntil);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return accountLocked(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return accountLocked?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (accountLocked != null) {
      return accountLocked(this);
    }
    return orElse();
  }
}

abstract class AccountLockedError implements CauceApiError {
  const factory AccountLockedError({required final DateTime lockedUntil}) =
      _$AccountLockedErrorImpl;

  DateTime get lockedUntil;

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AccountLockedErrorImplCopyWith<_$AccountLockedErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ConsentMismatchErrorImplCopyWith<$Res> {
  factory _$$ConsentMismatchErrorImplCopyWith(_$ConsentMismatchErrorImpl value,
          $Res Function(_$ConsentMismatchErrorImpl) then) =
      __$$ConsentMismatchErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConsentMismatchErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$ConsentMismatchErrorImpl>
    implements _$$ConsentMismatchErrorImplCopyWith<$Res> {
  __$$ConsentMismatchErrorImplCopyWithImpl(_$ConsentMismatchErrorImpl _value,
      $Res Function(_$ConsentMismatchErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConsentMismatchErrorImpl implements ConsentMismatchError {
  const _$ConsentMismatchErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.consentMismatch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsentMismatchErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return consentMismatch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return consentMismatch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (consentMismatch != null) {
      return consentMismatch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return consentMismatch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return consentMismatch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (consentMismatch != null) {
      return consentMismatch(this);
    }
    return orElse();
  }
}

abstract class ConsentMismatchError implements CauceApiError {
  const factory ConsentMismatchError() = _$ConsentMismatchErrorImpl;
}

/// @nodoc
abstract class _$$DuplicateEmailErrorImplCopyWith<$Res> {
  factory _$$DuplicateEmailErrorImplCopyWith(_$DuplicateEmailErrorImpl value,
          $Res Function(_$DuplicateEmailErrorImpl) then) =
      __$$DuplicateEmailErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DuplicateEmailErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$DuplicateEmailErrorImpl>
    implements _$$DuplicateEmailErrorImplCopyWith<$Res> {
  __$$DuplicateEmailErrorImplCopyWithImpl(_$DuplicateEmailErrorImpl _value,
      $Res Function(_$DuplicateEmailErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DuplicateEmailErrorImpl implements DuplicateEmailError {
  const _$DuplicateEmailErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.duplicateEmail()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuplicateEmailErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return duplicateEmail();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return duplicateEmail?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (duplicateEmail != null) {
      return duplicateEmail();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return duplicateEmail(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return duplicateEmail?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (duplicateEmail != null) {
      return duplicateEmail(this);
    }
    return orElse();
  }
}

abstract class DuplicateEmailError implements CauceApiError {
  const factory DuplicateEmailError() = _$DuplicateEmailErrorImpl;
}

/// @nodoc
abstract class _$$InvitationCodeErrorImplCopyWith<$Res> {
  factory _$$InvitationCodeErrorImplCopyWith(_$InvitationCodeErrorImpl value,
          $Res Function(_$InvitationCodeErrorImpl) then) =
      __$$InvitationCodeErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({InvitationCodeReason reason});
}

/// @nodoc
class __$$InvitationCodeErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$InvitationCodeErrorImpl>
    implements _$$InvitationCodeErrorImplCopyWith<$Res> {
  __$$InvitationCodeErrorImplCopyWithImpl(_$InvitationCodeErrorImpl _value,
      $Res Function(_$InvitationCodeErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_$InvitationCodeErrorImpl(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as InvitationCodeReason,
    ));
  }
}

/// @nodoc

class _$InvitationCodeErrorImpl implements InvitationCodeError {
  const _$InvitationCodeErrorImpl({required this.reason});

  @override
  final InvitationCodeReason reason;

  @override
  String toString() {
    return 'CauceApiError.invitationCode(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationCodeErrorImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationCodeErrorImplCopyWith<_$InvitationCodeErrorImpl> get copyWith =>
      __$$InvitationCodeErrorImplCopyWithImpl<_$InvitationCodeErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return invitationCode(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return invitationCode?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (invitationCode != null) {
      return invitationCode(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return invitationCode(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return invitationCode?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (invitationCode != null) {
      return invitationCode(this);
    }
    return orElse();
  }
}

abstract class InvitationCodeError implements CauceApiError {
  const factory InvitationCodeError(
      {required final InvitationCodeReason reason}) = _$InvitationCodeErrorImpl;

  InvitationCodeReason get reason;

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationCodeErrorImplCopyWith<_$InvitationCodeErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PasswordResetTokenErrorImplCopyWith<$Res> {
  factory _$$PasswordResetTokenErrorImplCopyWith(
          _$PasswordResetTokenErrorImpl value,
          $Res Function(_$PasswordResetTokenErrorImpl) then) =
      __$$PasswordResetTokenErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({PasswordResetTokenReason reason});
}

/// @nodoc
class __$$PasswordResetTokenErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$PasswordResetTokenErrorImpl>
    implements _$$PasswordResetTokenErrorImplCopyWith<$Res> {
  __$$PasswordResetTokenErrorImplCopyWithImpl(
      _$PasswordResetTokenErrorImpl _value,
      $Res Function(_$PasswordResetTokenErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_$PasswordResetTokenErrorImpl(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as PasswordResetTokenReason,
    ));
  }
}

/// @nodoc

class _$PasswordResetTokenErrorImpl implements PasswordResetTokenError {
  const _$PasswordResetTokenErrorImpl({required this.reason});

  @override
  final PasswordResetTokenReason reason;

  @override
  String toString() {
    return 'CauceApiError.passwordResetToken(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PasswordResetTokenErrorImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PasswordResetTokenErrorImplCopyWith<_$PasswordResetTokenErrorImpl>
      get copyWith => __$$PasswordResetTokenErrorImplCopyWithImpl<
          _$PasswordResetTokenErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return passwordResetToken(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return passwordResetToken?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (passwordResetToken != null) {
      return passwordResetToken(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return passwordResetToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return passwordResetToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (passwordResetToken != null) {
      return passwordResetToken(this);
    }
    return orElse();
  }
}

abstract class PasswordResetTokenError implements CauceApiError {
  const factory PasswordResetTokenError(
          {required final PasswordResetTokenReason reason}) =
      _$PasswordResetTokenErrorImpl;

  PasswordResetTokenReason get reason;

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PasswordResetTokenErrorImplCopyWith<_$PasswordResetTokenErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$NutritionistNotAvailableErrorImplCopyWith<$Res> {
  factory _$$NutritionistNotAvailableErrorImplCopyWith(
          _$NutritionistNotAvailableErrorImpl value,
          $Res Function(_$NutritionistNotAvailableErrorImpl) then) =
      __$$NutritionistNotAvailableErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({NutritionistNotAvailableReason reason});
}

/// @nodoc
class __$$NutritionistNotAvailableErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res,
        _$NutritionistNotAvailableErrorImpl>
    implements _$$NutritionistNotAvailableErrorImplCopyWith<$Res> {
  __$$NutritionistNotAvailableErrorImplCopyWithImpl(
      _$NutritionistNotAvailableErrorImpl _value,
      $Res Function(_$NutritionistNotAvailableErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? reason = null,
  }) {
    return _then(_$NutritionistNotAvailableErrorImpl(
      reason: null == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as NutritionistNotAvailableReason,
    ));
  }
}

/// @nodoc

class _$NutritionistNotAvailableErrorImpl
    implements NutritionistNotAvailableError {
  const _$NutritionistNotAvailableErrorImpl({required this.reason});

  @override
  final NutritionistNotAvailableReason reason;

  @override
  String toString() {
    return 'CauceApiError.nutritionistNotAvailable(reason: $reason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionistNotAvailableErrorImpl &&
            (identical(other.reason, reason) || other.reason == reason));
  }

  @override
  int get hashCode => Object.hash(runtimeType, reason);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionistNotAvailableErrorImplCopyWith<
          _$NutritionistNotAvailableErrorImpl>
      get copyWith => __$$NutritionistNotAvailableErrorImplCopyWithImpl<
          _$NutritionistNotAvailableErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return nutritionistNotAvailable(reason);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return nutritionistNotAvailable?.call(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (nutritionistNotAvailable != null) {
      return nutritionistNotAvailable(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return nutritionistNotAvailable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return nutritionistNotAvailable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (nutritionistNotAvailable != null) {
      return nutritionistNotAvailable(this);
    }
    return orElse();
  }
}

abstract class NutritionistNotAvailableError implements CauceApiError {
  const factory NutritionistNotAvailableError(
          {required final NutritionistNotAvailableReason reason}) =
      _$NutritionistNotAvailableErrorImpl;

  NutritionistNotAvailableReason get reason;

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionistNotAvailableErrorImplCopyWith<
          _$NutritionistNotAvailableErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$PatientAlreadyAssignedErrorImplCopyWith<$Res> {
  factory _$$PatientAlreadyAssignedErrorImplCopyWith(
          _$PatientAlreadyAssignedErrorImpl value,
          $Res Function(_$PatientAlreadyAssignedErrorImpl) then) =
      __$$PatientAlreadyAssignedErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PatientAlreadyAssignedErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$PatientAlreadyAssignedErrorImpl>
    implements _$$PatientAlreadyAssignedErrorImplCopyWith<$Res> {
  __$$PatientAlreadyAssignedErrorImplCopyWithImpl(
      _$PatientAlreadyAssignedErrorImpl _value,
      $Res Function(_$PatientAlreadyAssignedErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PatientAlreadyAssignedErrorImpl implements PatientAlreadyAssignedError {
  const _$PatientAlreadyAssignedErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.patientAlreadyAssigned()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientAlreadyAssignedErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return patientAlreadyAssigned();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return patientAlreadyAssigned?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (patientAlreadyAssigned != null) {
      return patientAlreadyAssigned();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return patientAlreadyAssigned(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return patientAlreadyAssigned?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (patientAlreadyAssigned != null) {
      return patientAlreadyAssigned(this);
    }
    return orElse();
  }
}

abstract class PatientAlreadyAssignedError implements CauceApiError {
  const factory PatientAlreadyAssignedError() =
      _$PatientAlreadyAssignedErrorImpl;
}

/// @nodoc
abstract class _$$PatientProfileNotFoundErrorImplCopyWith<$Res> {
  factory _$$PatientProfileNotFoundErrorImplCopyWith(
          _$PatientProfileNotFoundErrorImpl value,
          $Res Function(_$PatientProfileNotFoundErrorImpl) then) =
      __$$PatientProfileNotFoundErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$PatientProfileNotFoundErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$PatientProfileNotFoundErrorImpl>
    implements _$$PatientProfileNotFoundErrorImplCopyWith<$Res> {
  __$$PatientProfileNotFoundErrorImplCopyWithImpl(
      _$PatientProfileNotFoundErrorImpl _value,
      $Res Function(_$PatientProfileNotFoundErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$PatientProfileNotFoundErrorImpl implements PatientProfileNotFoundError {
  const _$PatientProfileNotFoundErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.patientProfileNotFound()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientProfileNotFoundErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return patientProfileNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return patientProfileNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (patientProfileNotFound != null) {
      return patientProfileNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return patientProfileNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return patientProfileNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (patientProfileNotFound != null) {
      return patientProfileNotFound(this);
    }
    return orElse();
  }
}

abstract class PatientProfileNotFoundError implements CauceApiError {
  const factory PatientProfileNotFoundError() =
      _$PatientProfileNotFoundErrorImpl;
}

/// @nodoc
abstract class _$$DuplicateProfileErrorImplCopyWith<$Res> {
  factory _$$DuplicateProfileErrorImplCopyWith(
          _$DuplicateProfileErrorImpl value,
          $Res Function(_$DuplicateProfileErrorImpl) then) =
      __$$DuplicateProfileErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DuplicateProfileErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$DuplicateProfileErrorImpl>
    implements _$$DuplicateProfileErrorImplCopyWith<$Res> {
  __$$DuplicateProfileErrorImplCopyWithImpl(_$DuplicateProfileErrorImpl _value,
      $Res Function(_$DuplicateProfileErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DuplicateProfileErrorImpl implements DuplicateProfileError {
  const _$DuplicateProfileErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.duplicateProfile()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuplicateProfileErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return duplicateProfile();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return duplicateProfile?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (duplicateProfile != null) {
      return duplicateProfile();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return duplicateProfile(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return duplicateProfile?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (duplicateProfile != null) {
      return duplicateProfile(this);
    }
    return orElse();
  }
}

abstract class DuplicateProfileError implements CauceApiError {
  const factory DuplicateProfileError() = _$DuplicateProfileErrorImpl;
}

/// @nodoc
abstract class _$$InvalidBiometricValueErrorImplCopyWith<$Res> {
  factory _$$InvalidBiometricValueErrorImplCopyWith(
          _$InvalidBiometricValueErrorImpl value,
          $Res Function(_$InvalidBiometricValueErrorImpl) then) =
      __$$InvalidBiometricValueErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidBiometricValueErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$InvalidBiometricValueErrorImpl>
    implements _$$InvalidBiometricValueErrorImplCopyWith<$Res> {
  __$$InvalidBiometricValueErrorImplCopyWithImpl(
      _$InvalidBiometricValueErrorImpl _value,
      $Res Function(_$InvalidBiometricValueErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InvalidBiometricValueErrorImpl implements InvalidBiometricValueError {
  const _$InvalidBiometricValueErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.invalidBiometricValue()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidBiometricValueErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return invalidBiometricValue();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return invalidBiometricValue?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (invalidBiometricValue != null) {
      return invalidBiometricValue();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return invalidBiometricValue(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return invalidBiometricValue?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (invalidBiometricValue != null) {
      return invalidBiometricValue(this);
    }
    return orElse();
  }
}

abstract class InvalidBiometricValueError implements CauceApiError {
  const factory InvalidBiometricValueError() = _$InvalidBiometricValueErrorImpl;
}

/// @nodoc
abstract class _$$AllergyNotFoundErrorImplCopyWith<$Res> {
  factory _$$AllergyNotFoundErrorImplCopyWith(_$AllergyNotFoundErrorImpl value,
          $Res Function(_$AllergyNotFoundErrorImpl) then) =
      __$$AllergyNotFoundErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AllergyNotFoundErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$AllergyNotFoundErrorImpl>
    implements _$$AllergyNotFoundErrorImplCopyWith<$Res> {
  __$$AllergyNotFoundErrorImplCopyWithImpl(_$AllergyNotFoundErrorImpl _value,
      $Res Function(_$AllergyNotFoundErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$AllergyNotFoundErrorImpl implements AllergyNotFoundError {
  const _$AllergyNotFoundErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.allergyNotFound()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllergyNotFoundErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return allergyNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return allergyNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (allergyNotFound != null) {
      return allergyNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return allergyNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return allergyNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (allergyNotFound != null) {
      return allergyNotFound(this);
    }
    return orElse();
  }
}

abstract class AllergyNotFoundError implements CauceApiError {
  const factory AllergyNotFoundError() = _$AllergyNotFoundErrorImpl;
}

/// @nodoc
abstract class _$$DuplicateAllergyErrorImplCopyWith<$Res> {
  factory _$$DuplicateAllergyErrorImplCopyWith(
          _$DuplicateAllergyErrorImpl value,
          $Res Function(_$DuplicateAllergyErrorImpl) then) =
      __$$DuplicateAllergyErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DuplicateAllergyErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$DuplicateAllergyErrorImpl>
    implements _$$DuplicateAllergyErrorImplCopyWith<$Res> {
  __$$DuplicateAllergyErrorImplCopyWithImpl(_$DuplicateAllergyErrorImpl _value,
      $Res Function(_$DuplicateAllergyErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DuplicateAllergyErrorImpl implements DuplicateAllergyError {
  const _$DuplicateAllergyErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.duplicateAllergy()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuplicateAllergyErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return duplicateAllergy();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return duplicateAllergy?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (duplicateAllergy != null) {
      return duplicateAllergy();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return duplicateAllergy(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return duplicateAllergy?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (duplicateAllergy != null) {
      return duplicateAllergy(this);
    }
    return orElse();
  }
}

abstract class DuplicateAllergyError implements CauceApiError {
  const factory DuplicateAllergyError() = _$DuplicateAllergyErrorImpl;
}

/// @nodoc
abstract class _$$InvalidIbsSssDimensionErrorImplCopyWith<$Res> {
  factory _$$InvalidIbsSssDimensionErrorImplCopyWith(
          _$InvalidIbsSssDimensionErrorImpl value,
          $Res Function(_$InvalidIbsSssDimensionErrorImpl) then) =
      __$$InvalidIbsSssDimensionErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidIbsSssDimensionErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$InvalidIbsSssDimensionErrorImpl>
    implements _$$InvalidIbsSssDimensionErrorImplCopyWith<$Res> {
  __$$InvalidIbsSssDimensionErrorImplCopyWithImpl(
      _$InvalidIbsSssDimensionErrorImpl _value,
      $Res Function(_$InvalidIbsSssDimensionErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InvalidIbsSssDimensionErrorImpl implements InvalidIbsSssDimensionError {
  const _$InvalidIbsSssDimensionErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.invalidIbsSssDimension()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidIbsSssDimensionErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return invalidIbsSssDimension();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return invalidIbsSssDimension?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (invalidIbsSssDimension != null) {
      return invalidIbsSssDimension();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return invalidIbsSssDimension(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return invalidIbsSssDimension?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (invalidIbsSssDimension != null) {
      return invalidIbsSssDimension(this);
    }
    return orElse();
  }
}

abstract class InvalidIbsSssDimensionError implements CauceApiError {
  const factory InvalidIbsSssDimensionError() =
      _$InvalidIbsSssDimensionErrorImpl;
}

/// @nodoc
abstract class _$$DuplicateBaselineAssessmentErrorImplCopyWith<$Res> {
  factory _$$DuplicateBaselineAssessmentErrorImplCopyWith(
          _$DuplicateBaselineAssessmentErrorImpl value,
          $Res Function(_$DuplicateBaselineAssessmentErrorImpl) then) =
      __$$DuplicateBaselineAssessmentErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DuplicateBaselineAssessmentErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res,
        _$DuplicateBaselineAssessmentErrorImpl>
    implements _$$DuplicateBaselineAssessmentErrorImplCopyWith<$Res> {
  __$$DuplicateBaselineAssessmentErrorImplCopyWithImpl(
      _$DuplicateBaselineAssessmentErrorImpl _value,
      $Res Function(_$DuplicateBaselineAssessmentErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DuplicateBaselineAssessmentErrorImpl
    implements DuplicateBaselineAssessmentError {
  const _$DuplicateBaselineAssessmentErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.duplicateBaselineAssessment()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuplicateBaselineAssessmentErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return duplicateBaselineAssessment();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return duplicateBaselineAssessment?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (duplicateBaselineAssessment != null) {
      return duplicateBaselineAssessment();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return duplicateBaselineAssessment(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return duplicateBaselineAssessment?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (duplicateBaselineAssessment != null) {
      return duplicateBaselineAssessment(this);
    }
    return orElse();
  }
}

abstract class DuplicateBaselineAssessmentError implements CauceApiError {
  const factory DuplicateBaselineAssessmentError() =
      _$DuplicateBaselineAssessmentErrorImpl;
}

/// @nodoc
abstract class _$$FoodItemNotFoundErrorImplCopyWith<$Res> {
  factory _$$FoodItemNotFoundErrorImplCopyWith(
          _$FoodItemNotFoundErrorImpl value,
          $Res Function(_$FoodItemNotFoundErrorImpl) then) =
      __$$FoodItemNotFoundErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$FoodItemNotFoundErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$FoodItemNotFoundErrorImpl>
    implements _$$FoodItemNotFoundErrorImplCopyWith<$Res> {
  __$$FoodItemNotFoundErrorImplCopyWithImpl(_$FoodItemNotFoundErrorImpl _value,
      $Res Function(_$FoodItemNotFoundErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$FoodItemNotFoundErrorImpl implements FoodItemNotFoundError {
  const _$FoodItemNotFoundErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.foodItemNotFound()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodItemNotFoundErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return foodItemNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return foodItemNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (foodItemNotFound != null) {
      return foodItemNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return foodItemNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return foodItemNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (foodItemNotFound != null) {
      return foodItemNotFound(this);
    }
    return orElse();
  }
}

abstract class FoodItemNotFoundError implements CauceApiError {
  const factory FoodItemNotFoundError() = _$FoodItemNotFoundErrorImpl;
}

/// @nodoc
abstract class _$$CustomFoodNotFoundErrorImplCopyWith<$Res> {
  factory _$$CustomFoodNotFoundErrorImplCopyWith(
          _$CustomFoodNotFoundErrorImpl value,
          $Res Function(_$CustomFoodNotFoundErrorImpl) then) =
      __$$CustomFoodNotFoundErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CustomFoodNotFoundErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$CustomFoodNotFoundErrorImpl>
    implements _$$CustomFoodNotFoundErrorImplCopyWith<$Res> {
  __$$CustomFoodNotFoundErrorImplCopyWithImpl(
      _$CustomFoodNotFoundErrorImpl _value,
      $Res Function(_$CustomFoodNotFoundErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CustomFoodNotFoundErrorImpl implements CustomFoodNotFoundError {
  const _$CustomFoodNotFoundErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.customFoodNotFound()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFoodNotFoundErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return customFoodNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return customFoodNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (customFoodNotFound != null) {
      return customFoodNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return customFoodNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return customFoodNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (customFoodNotFound != null) {
      return customFoodNotFound(this);
    }
    return orElse();
  }
}

abstract class CustomFoodNotFoundError implements CauceApiError {
  const factory CustomFoodNotFoundError() = _$CustomFoodNotFoundErrorImpl;
}

/// @nodoc
abstract class _$$DuplicateCustomFoodErrorImplCopyWith<$Res> {
  factory _$$DuplicateCustomFoodErrorImplCopyWith(
          _$DuplicateCustomFoodErrorImpl value,
          $Res Function(_$DuplicateCustomFoodErrorImpl) then) =
      __$$DuplicateCustomFoodErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DuplicateCustomFoodErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$DuplicateCustomFoodErrorImpl>
    implements _$$DuplicateCustomFoodErrorImplCopyWith<$Res> {
  __$$DuplicateCustomFoodErrorImplCopyWithImpl(
      _$DuplicateCustomFoodErrorImpl _value,
      $Res Function(_$DuplicateCustomFoodErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DuplicateCustomFoodErrorImpl implements DuplicateCustomFoodError {
  const _$DuplicateCustomFoodErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.duplicateCustomFood()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuplicateCustomFoodErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return duplicateCustomFood();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return duplicateCustomFood?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (duplicateCustomFood != null) {
      return duplicateCustomFood();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return duplicateCustomFood(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return duplicateCustomFood?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (duplicateCustomFood != null) {
      return duplicateCustomFood(this);
    }
    return orElse();
  }
}

abstract class DuplicateCustomFoodError implements CauceApiError {
  const factory DuplicateCustomFoodError() = _$DuplicateCustomFoodErrorImpl;
}

/// @nodoc
abstract class _$$CustomFoodInUseErrorImplCopyWith<$Res> {
  factory _$$CustomFoodInUseErrorImplCopyWith(_$CustomFoodInUseErrorImpl value,
          $Res Function(_$CustomFoodInUseErrorImpl) then) =
      __$$CustomFoodInUseErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$CustomFoodInUseErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$CustomFoodInUseErrorImpl>
    implements _$$CustomFoodInUseErrorImplCopyWith<$Res> {
  __$$CustomFoodInUseErrorImplCopyWithImpl(_$CustomFoodInUseErrorImpl _value,
      $Res Function(_$CustomFoodInUseErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$CustomFoodInUseErrorImpl implements CustomFoodInUseError {
  const _$CustomFoodInUseErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.customFoodInUse()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFoodInUseErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return customFoodInUse();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return customFoodInUse?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (customFoodInUse != null) {
      return customFoodInUse();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return customFoodInUse(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return customFoodInUse?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (customFoodInUse != null) {
      return customFoodInUse(this);
    }
    return orElse();
  }
}

abstract class CustomFoodInUseError implements CauceApiError {
  const factory CustomFoodInUseError() = _$CustomFoodInUseErrorImpl;
}

/// @nodoc
abstract class _$$DuplicateIngredientErrorImplCopyWith<$Res> {
  factory _$$DuplicateIngredientErrorImplCopyWith(
          _$DuplicateIngredientErrorImpl value,
          $Res Function(_$DuplicateIngredientErrorImpl) then) =
      __$$DuplicateIngredientErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$DuplicateIngredientErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$DuplicateIngredientErrorImpl>
    implements _$$DuplicateIngredientErrorImplCopyWith<$Res> {
  __$$DuplicateIngredientErrorImplCopyWithImpl(
      _$DuplicateIngredientErrorImpl _value,
      $Res Function(_$DuplicateIngredientErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$DuplicateIngredientErrorImpl implements DuplicateIngredientError {
  const _$DuplicateIngredientErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.duplicateIngredient()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DuplicateIngredientErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return duplicateIngredient();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return duplicateIngredient?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (duplicateIngredient != null) {
      return duplicateIngredient();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return duplicateIngredient(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return duplicateIngredient?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (duplicateIngredient != null) {
      return duplicateIngredient(this);
    }
    return orElse();
  }
}

abstract class DuplicateIngredientError implements CauceApiError {
  const factory DuplicateIngredientError() = _$DuplicateIngredientErrorImpl;
}

/// @nodoc
abstract class _$$IngredientNotFoundErrorImplCopyWith<$Res> {
  factory _$$IngredientNotFoundErrorImplCopyWith(
          _$IngredientNotFoundErrorImpl value,
          $Res Function(_$IngredientNotFoundErrorImpl) then) =
      __$$IngredientNotFoundErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IngredientNotFoundErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$IngredientNotFoundErrorImpl>
    implements _$$IngredientNotFoundErrorImplCopyWith<$Res> {
  __$$IngredientNotFoundErrorImplCopyWithImpl(
      _$IngredientNotFoundErrorImpl _value,
      $Res Function(_$IngredientNotFoundErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IngredientNotFoundErrorImpl implements IngredientNotFoundError {
  const _$IngredientNotFoundErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.ingredientNotFound()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IngredientNotFoundErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return ingredientNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return ingredientNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (ingredientNotFound != null) {
      return ingredientNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return ingredientNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return ingredientNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (ingredientNotFound != null) {
      return ingredientNotFound(this);
    }
    return orElse();
  }
}

abstract class IngredientNotFoundError implements CauceApiError {
  const factory IngredientNotFoundError() = _$IngredientNotFoundErrorImpl;
}

/// @nodoc
abstract class _$$UnconfirmedAllergensErrorImplCopyWith<$Res> {
  factory _$$UnconfirmedAllergensErrorImplCopyWith(
          _$UnconfirmedAllergensErrorImpl value,
          $Res Function(_$UnconfirmedAllergensErrorImpl) then) =
      __$$UnconfirmedAllergensErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({List<DetectedAllergen> allergens});
}

/// @nodoc
class __$$UnconfirmedAllergensErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$UnconfirmedAllergensErrorImpl>
    implements _$$UnconfirmedAllergensErrorImplCopyWith<$Res> {
  __$$UnconfirmedAllergensErrorImplCopyWithImpl(
      _$UnconfirmedAllergensErrorImpl _value,
      $Res Function(_$UnconfirmedAllergensErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allergens = null,
  }) {
    return _then(_$UnconfirmedAllergensErrorImpl(
      allergens: null == allergens
          ? _value._allergens
          : allergens // ignore: cast_nullable_to_non_nullable
              as List<DetectedAllergen>,
    ));
  }
}

/// @nodoc

class _$UnconfirmedAllergensErrorImpl implements UnconfirmedAllergensError {
  const _$UnconfirmedAllergensErrorImpl(
      {required final List<DetectedAllergen> allergens})
      : _allergens = allergens;

  final List<DetectedAllergen> _allergens;
  @override
  List<DetectedAllergen> get allergens {
    if (_allergens is EqualUnmodifiableListView) return _allergens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergens);
  }

  @override
  String toString() {
    return 'CauceApiError.unconfirmedAllergens(allergens: $allergens)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnconfirmedAllergensErrorImpl &&
            const DeepCollectionEquality()
                .equals(other._allergens, _allergens));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_allergens));

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnconfirmedAllergensErrorImplCopyWith<_$UnconfirmedAllergensErrorImpl>
      get copyWith => __$$UnconfirmedAllergensErrorImplCopyWithImpl<
          _$UnconfirmedAllergensErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return unconfirmedAllergens(allergens);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return unconfirmedAllergens?.call(allergens);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (unconfirmedAllergens != null) {
      return unconfirmedAllergens(allergens);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return unconfirmedAllergens(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return unconfirmedAllergens?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (unconfirmedAllergens != null) {
      return unconfirmedAllergens(this);
    }
    return orElse();
  }
}

abstract class UnconfirmedAllergensError implements CauceApiError {
  const factory UnconfirmedAllergensError(
          {required final List<DetectedAllergen> allergens}) =
      _$UnconfirmedAllergensErrorImpl;

  List<DetectedAllergen> get allergens;

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnconfirmedAllergensErrorImplCopyWith<_$UnconfirmedAllergensErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidMealRegistrationErrorImplCopyWith<$Res> {
  factory _$$InvalidMealRegistrationErrorImplCopyWith(
          _$InvalidMealRegistrationErrorImpl value,
          $Res Function(_$InvalidMealRegistrationErrorImpl) then) =
      __$$InvalidMealRegistrationErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidMealRegistrationErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res,
        _$InvalidMealRegistrationErrorImpl>
    implements _$$InvalidMealRegistrationErrorImplCopyWith<$Res> {
  __$$InvalidMealRegistrationErrorImplCopyWithImpl(
      _$InvalidMealRegistrationErrorImpl _value,
      $Res Function(_$InvalidMealRegistrationErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InvalidMealRegistrationErrorImpl
    implements InvalidMealRegistrationError {
  const _$InvalidMealRegistrationErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.invalidMealRegistration()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidMealRegistrationErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return invalidMealRegistration();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return invalidMealRegistration?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (invalidMealRegistration != null) {
      return invalidMealRegistration();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return invalidMealRegistration(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return invalidMealRegistration?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (invalidMealRegistration != null) {
      return invalidMealRegistration(this);
    }
    return orElse();
  }
}

abstract class InvalidMealRegistrationError implements CauceApiError {
  const factory InvalidMealRegistrationError() =
      _$InvalidMealRegistrationErrorImpl;
}

/// @nodoc
abstract class _$$MealNotFoundErrorImplCopyWith<$Res> {
  factory _$$MealNotFoundErrorImplCopyWith(_$MealNotFoundErrorImpl value,
          $Res Function(_$MealNotFoundErrorImpl) then) =
      __$$MealNotFoundErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$MealNotFoundErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$MealNotFoundErrorImpl>
    implements _$$MealNotFoundErrorImplCopyWith<$Res> {
  __$$MealNotFoundErrorImplCopyWithImpl(_$MealNotFoundErrorImpl _value,
      $Res Function(_$MealNotFoundErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$MealNotFoundErrorImpl implements MealNotFoundError {
  const _$MealNotFoundErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.mealNotFound()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$MealNotFoundErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return mealNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return mealNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (mealNotFound != null) {
      return mealNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return mealNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return mealNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (mealNotFound != null) {
      return mealNotFound(this);
    }
    return orElse();
  }
}

abstract class MealNotFoundError implements CauceApiError {
  const factory MealNotFoundError() = _$MealNotFoundErrorImpl;
}

/// @nodoc
abstract class _$$SymptomNotFoundErrorImplCopyWith<$Res> {
  factory _$$SymptomNotFoundErrorImplCopyWith(_$SymptomNotFoundErrorImpl value,
          $Res Function(_$SymptomNotFoundErrorImpl) then) =
      __$$SymptomNotFoundErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$SymptomNotFoundErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$SymptomNotFoundErrorImpl>
    implements _$$SymptomNotFoundErrorImplCopyWith<$Res> {
  __$$SymptomNotFoundErrorImplCopyWithImpl(_$SymptomNotFoundErrorImpl _value,
      $Res Function(_$SymptomNotFoundErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$SymptomNotFoundErrorImpl implements SymptomNotFoundError {
  const _$SymptomNotFoundErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.symptomNotFound()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SymptomNotFoundErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return symptomNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return symptomNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (symptomNotFound != null) {
      return symptomNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return symptomNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return symptomNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (symptomNotFound != null) {
      return symptomNotFound(this);
    }
    return orElse();
  }
}

abstract class SymptomNotFoundError implements CauceApiError {
  const factory SymptomNotFoundError() = _$SymptomNotFoundErrorImpl;
}

/// @nodoc
abstract class _$$ClinicalNoteNotFoundErrorImplCopyWith<$Res> {
  factory _$$ClinicalNoteNotFoundErrorImplCopyWith(
          _$ClinicalNoteNotFoundErrorImpl value,
          $Res Function(_$ClinicalNoteNotFoundErrorImpl) then) =
      __$$ClinicalNoteNotFoundErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClinicalNoteNotFoundErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$ClinicalNoteNotFoundErrorImpl>
    implements _$$ClinicalNoteNotFoundErrorImplCopyWith<$Res> {
  __$$ClinicalNoteNotFoundErrorImplCopyWithImpl(
      _$ClinicalNoteNotFoundErrorImpl _value,
      $Res Function(_$ClinicalNoteNotFoundErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClinicalNoteNotFoundErrorImpl implements ClinicalNoteNotFoundError {
  const _$ClinicalNoteNotFoundErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.clinicalNoteNotFound()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicalNoteNotFoundErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return clinicalNoteNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return clinicalNoteNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (clinicalNoteNotFound != null) {
      return clinicalNoteNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return clinicalNoteNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return clinicalNoteNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (clinicalNoteNotFound != null) {
      return clinicalNoteNotFound(this);
    }
    return orElse();
  }
}

abstract class ClinicalNoteNotFoundError implements CauceApiError {
  const factory ClinicalNoteNotFoundError() = _$ClinicalNoteNotFoundErrorImpl;
}

/// @nodoc
abstract class _$$InvalidClinicalNoteAssociationErrorImplCopyWith<$Res> {
  factory _$$InvalidClinicalNoteAssociationErrorImplCopyWith(
          _$InvalidClinicalNoteAssociationErrorImpl value,
          $Res Function(_$InvalidClinicalNoteAssociationErrorImpl) then) =
      __$$InvalidClinicalNoteAssociationErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidClinicalNoteAssociationErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res,
        _$InvalidClinicalNoteAssociationErrorImpl>
    implements _$$InvalidClinicalNoteAssociationErrorImplCopyWith<$Res> {
  __$$InvalidClinicalNoteAssociationErrorImplCopyWithImpl(
      _$InvalidClinicalNoteAssociationErrorImpl _value,
      $Res Function(_$InvalidClinicalNoteAssociationErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InvalidClinicalNoteAssociationErrorImpl
    implements InvalidClinicalNoteAssociationError {
  const _$InvalidClinicalNoteAssociationErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.invalidClinicalNoteAssociation()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidClinicalNoteAssociationErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return invalidClinicalNoteAssociation();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return invalidClinicalNoteAssociation?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (invalidClinicalNoteAssociation != null) {
      return invalidClinicalNoteAssociation();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return invalidClinicalNoteAssociation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return invalidClinicalNoteAssociation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (invalidClinicalNoteAssociation != null) {
      return invalidClinicalNoteAssociation(this);
    }
    return orElse();
  }
}

abstract class InvalidClinicalNoteAssociationError implements CauceApiError {
  const factory InvalidClinicalNoteAssociationError() =
      _$InvalidClinicalNoteAssociationErrorImpl;
}

/// @nodoc
abstract class _$$IdempotencyMismatchErrorImplCopyWith<$Res> {
  factory _$$IdempotencyMismatchErrorImplCopyWith(
          _$IdempotencyMismatchErrorImpl value,
          $Res Function(_$IdempotencyMismatchErrorImpl) then) =
      __$$IdempotencyMismatchErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$IdempotencyMismatchErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$IdempotencyMismatchErrorImpl>
    implements _$$IdempotencyMismatchErrorImplCopyWith<$Res> {
  __$$IdempotencyMismatchErrorImplCopyWithImpl(
      _$IdempotencyMismatchErrorImpl _value,
      $Res Function(_$IdempotencyMismatchErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$IdempotencyMismatchErrorImpl implements IdempotencyMismatchError {
  const _$IdempotencyMismatchErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.idempotencyMismatch()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$IdempotencyMismatchErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return idempotencyMismatch();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return idempotencyMismatch?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (idempotencyMismatch != null) {
      return idempotencyMismatch();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return idempotencyMismatch(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return idempotencyMismatch?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (idempotencyMismatch != null) {
      return idempotencyMismatch(this);
    }
    return orElse();
  }
}

abstract class IdempotencyMismatchError implements CauceApiError {
  const factory IdempotencyMismatchError() = _$IdempotencyMismatchErrorImpl;
}

/// @nodoc
abstract class _$$DomainRuleViolationErrorImplCopyWith<$Res> {
  factory _$$DomainRuleViolationErrorImplCopyWith(
          _$DomainRuleViolationErrorImpl value,
          $Res Function(_$DomainRuleViolationErrorImpl) then) =
      __$$DomainRuleViolationErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String? detail});
}

/// @nodoc
class __$$DomainRuleViolationErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$DomainRuleViolationErrorImpl>
    implements _$$DomainRuleViolationErrorImplCopyWith<$Res> {
  __$$DomainRuleViolationErrorImplCopyWithImpl(
      _$DomainRuleViolationErrorImpl _value,
      $Res Function(_$DomainRuleViolationErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? detail = freezed,
  }) {
    return _then(_$DomainRuleViolationErrorImpl(
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$DomainRuleViolationErrorImpl implements DomainRuleViolationError {
  const _$DomainRuleViolationErrorImpl({this.detail});

  @override
  final String? detail;

  @override
  String toString() {
    return 'CauceApiError.domainRuleViolation(detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DomainRuleViolationErrorImpl &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, detail);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DomainRuleViolationErrorImplCopyWith<_$DomainRuleViolationErrorImpl>
      get copyWith => __$$DomainRuleViolationErrorImplCopyWithImpl<
          _$DomainRuleViolationErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return domainRuleViolation(detail);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return domainRuleViolation?.call(detail);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (domainRuleViolation != null) {
      return domainRuleViolation(detail);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return domainRuleViolation(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return domainRuleViolation?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (domainRuleViolation != null) {
      return domainRuleViolation(this);
    }
    return orElse();
  }
}

abstract class DomainRuleViolationError implements CauceApiError {
  const factory DomainRuleViolationError({final String? detail}) =
      _$DomainRuleViolationErrorImpl;

  String? get detail;

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DomainRuleViolationErrorImplCopyWith<_$DomainRuleViolationErrorImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$InvalidRefreshTokenErrorImplCopyWith<$Res> {
  factory _$$InvalidRefreshTokenErrorImplCopyWith(
          _$InvalidRefreshTokenErrorImpl value,
          $Res Function(_$InvalidRefreshTokenErrorImpl) then) =
      __$$InvalidRefreshTokenErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$InvalidRefreshTokenErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$InvalidRefreshTokenErrorImpl>
    implements _$$InvalidRefreshTokenErrorImplCopyWith<$Res> {
  __$$InvalidRefreshTokenErrorImplCopyWithImpl(
      _$InvalidRefreshTokenErrorImpl _value,
      $Res Function(_$InvalidRefreshTokenErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$InvalidRefreshTokenErrorImpl implements InvalidRefreshTokenError {
  const _$InvalidRefreshTokenErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.invalidRefreshToken()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvalidRefreshTokenErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return invalidRefreshToken();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return invalidRefreshToken?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (invalidRefreshToken != null) {
      return invalidRefreshToken();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return invalidRefreshToken(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return invalidRefreshToken?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (invalidRefreshToken != null) {
      return invalidRefreshToken(this);
    }
    return orElse();
  }
}

abstract class InvalidRefreshTokenError implements CauceApiError {
  const factory InvalidRefreshTokenError() = _$InvalidRefreshTokenErrorImpl;
}

/// @nodoc
abstract class _$$RateLimitedErrorImplCopyWith<$Res> {
  factory _$$RateLimitedErrorImplCopyWith(_$RateLimitedErrorImpl value,
          $Res Function(_$RateLimitedErrorImpl) then) =
      __$$RateLimitedErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int retryAfterSeconds});
}

/// @nodoc
class __$$RateLimitedErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$RateLimitedErrorImpl>
    implements _$$RateLimitedErrorImplCopyWith<$Res> {
  __$$RateLimitedErrorImplCopyWithImpl(_$RateLimitedErrorImpl _value,
      $Res Function(_$RateLimitedErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? retryAfterSeconds = null,
  }) {
    return _then(_$RateLimitedErrorImpl(
      retryAfterSeconds: null == retryAfterSeconds
          ? _value.retryAfterSeconds
          : retryAfterSeconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$RateLimitedErrorImpl implements RateLimitedError {
  const _$RateLimitedErrorImpl({required this.retryAfterSeconds});

  @override
  final int retryAfterSeconds;

  @override
  String toString() {
    return 'CauceApiError.rateLimited(retryAfterSeconds: $retryAfterSeconds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RateLimitedErrorImpl &&
            (identical(other.retryAfterSeconds, retryAfterSeconds) ||
                other.retryAfterSeconds == retryAfterSeconds));
  }

  @override
  int get hashCode => Object.hash(runtimeType, retryAfterSeconds);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RateLimitedErrorImplCopyWith<_$RateLimitedErrorImpl> get copyWith =>
      __$$RateLimitedErrorImplCopyWithImpl<_$RateLimitedErrorImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return rateLimited(retryAfterSeconds);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return rateLimited?.call(retryAfterSeconds);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (rateLimited != null) {
      return rateLimited(retryAfterSeconds);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return rateLimited(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return rateLimited?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (rateLimited != null) {
      return rateLimited(this);
    }
    return orElse();
  }
}

abstract class RateLimitedError implements CauceApiError {
  const factory RateLimitedError({required final int retryAfterSeconds}) =
      _$RateLimitedErrorImpl;

  int get retryAfterSeconds;

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RateLimitedErrorImplCopyWith<_$RateLimitedErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$KeycloakIntegrationErrorImplCopyWith<$Res> {
  factory _$$KeycloakIntegrationErrorImplCopyWith(
          _$KeycloakIntegrationErrorImpl value,
          $Res Function(_$KeycloakIntegrationErrorImpl) then) =
      __$$KeycloakIntegrationErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$KeycloakIntegrationErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$KeycloakIntegrationErrorImpl>
    implements _$$KeycloakIntegrationErrorImplCopyWith<$Res> {
  __$$KeycloakIntegrationErrorImplCopyWithImpl(
      _$KeycloakIntegrationErrorImpl _value,
      $Res Function(_$KeycloakIntegrationErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$KeycloakIntegrationErrorImpl implements KeycloakIntegrationError {
  const _$KeycloakIntegrationErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.keycloakIntegration()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KeycloakIntegrationErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return keycloakIntegration();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return keycloakIntegration?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (keycloakIntegration != null) {
      return keycloakIntegration();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return keycloakIntegration(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return keycloakIntegration?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (keycloakIntegration != null) {
      return keycloakIntegration(this);
    }
    return orElse();
  }
}

abstract class KeycloakIntegrationError implements CauceApiError {
  const factory KeycloakIntegrationError() = _$KeycloakIntegrationErrorImpl;
}

/// @nodoc
abstract class _$$UserLocalMissingErrorImplCopyWith<$Res> {
  factory _$$UserLocalMissingErrorImplCopyWith(
          _$UserLocalMissingErrorImpl value,
          $Res Function(_$UserLocalMissingErrorImpl) then) =
      __$$UserLocalMissingErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$UserLocalMissingErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$UserLocalMissingErrorImpl>
    implements _$$UserLocalMissingErrorImplCopyWith<$Res> {
  __$$UserLocalMissingErrorImplCopyWithImpl(_$UserLocalMissingErrorImpl _value,
      $Res Function(_$UserLocalMissingErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$UserLocalMissingErrorImpl implements UserLocalMissingError {
  const _$UserLocalMissingErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.userLocalMissing()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserLocalMissingErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return userLocalMissing();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return userLocalMissing?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (userLocalMissing != null) {
      return userLocalMissing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return userLocalMissing(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return userLocalMissing?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (userLocalMissing != null) {
      return userLocalMissing(this);
    }
    return orElse();
  }
}

abstract class UserLocalMissingError implements CauceApiError {
  const factory UserLocalMissingError() = _$UserLocalMissingErrorImpl;
}

/// @nodoc
abstract class _$$ConsentRecordNotFoundErrorImplCopyWith<$Res> {
  factory _$$ConsentRecordNotFoundErrorImplCopyWith(
          _$ConsentRecordNotFoundErrorImpl value,
          $Res Function(_$ConsentRecordNotFoundErrorImpl) then) =
      __$$ConsentRecordNotFoundErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ConsentRecordNotFoundErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$ConsentRecordNotFoundErrorImpl>
    implements _$$ConsentRecordNotFoundErrorImplCopyWith<$Res> {
  __$$ConsentRecordNotFoundErrorImplCopyWithImpl(
      _$ConsentRecordNotFoundErrorImpl _value,
      $Res Function(_$ConsentRecordNotFoundErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ConsentRecordNotFoundErrorImpl implements ConsentRecordNotFoundError {
  const _$ConsentRecordNotFoundErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.consentRecordNotFound()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConsentRecordNotFoundErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return consentRecordNotFound();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return consentRecordNotFound?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (consentRecordNotFound != null) {
      return consentRecordNotFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return consentRecordNotFound(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return consentRecordNotFound?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (consentRecordNotFound != null) {
      return consentRecordNotFound(this);
    }
    return orElse();
  }
}

abstract class ConsentRecordNotFoundError implements CauceApiError {
  const factory ConsentRecordNotFoundError() = _$ConsentRecordNotFoundErrorImpl;
}

/// @nodoc
abstract class _$$ForbiddenErrorImplCopyWith<$Res> {
  factory _$$ForbiddenErrorImplCopyWith(_$ForbiddenErrorImpl value,
          $Res Function(_$ForbiddenErrorImpl) then) =
      __$$ForbiddenErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ForbiddenErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$ForbiddenErrorImpl>
    implements _$$ForbiddenErrorImplCopyWith<$Res> {
  __$$ForbiddenErrorImplCopyWithImpl(
      _$ForbiddenErrorImpl _value, $Res Function(_$ForbiddenErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ForbiddenErrorImpl implements ForbiddenError {
  const _$ForbiddenErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.forbidden()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ForbiddenErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return forbidden();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return forbidden?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return forbidden(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return forbidden?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (forbidden != null) {
      return forbidden(this);
    }
    return orElse();
  }
}

abstract class ForbiddenError implements CauceApiError {
  const factory ForbiddenError() = _$ForbiddenErrorImpl;
}

/// @nodoc
abstract class _$$NetworkErrorImplCopyWith<$Res> {
  factory _$$NetworkErrorImplCopyWith(
          _$NetworkErrorImpl value, $Res Function(_$NetworkErrorImpl) then) =
      __$$NetworkErrorImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$NetworkErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$NetworkErrorImpl>
    implements _$$NetworkErrorImplCopyWith<$Res> {
  __$$NetworkErrorImplCopyWithImpl(
      _$NetworkErrorImpl _value, $Res Function(_$NetworkErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$NetworkErrorImpl implements NetworkError {
  const _$NetworkErrorImpl();

  @override
  String toString() {
    return 'CauceApiError.network()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$NetworkErrorImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return network();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return network?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return network(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return network?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (network != null) {
      return network(this);
    }
    return orElse();
  }
}

abstract class NetworkError implements CauceApiError {
  const factory NetworkError() = _$NetworkErrorImpl;
}

/// @nodoc
abstract class _$$UnknownErrorImplCopyWith<$Res> {
  factory _$$UnknownErrorImplCopyWith(
          _$UnknownErrorImpl value, $Res Function(_$UnknownErrorImpl) then) =
      __$$UnknownErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({int statusCode, String? errorCode, String? detail});
}

/// @nodoc
class __$$UnknownErrorImplCopyWithImpl<$Res>
    extends _$CauceApiErrorCopyWithImpl<$Res, _$UnknownErrorImpl>
    implements _$$UnknownErrorImplCopyWith<$Res> {
  __$$UnknownErrorImplCopyWithImpl(
      _$UnknownErrorImpl _value, $Res Function(_$UnknownErrorImpl) _then)
      : super(_value, _then);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = null,
    Object? errorCode = freezed,
    Object? detail = freezed,
  }) {
    return _then(_$UnknownErrorImpl(
      statusCode: null == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      detail: freezed == detail
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$UnknownErrorImpl implements UnknownError {
  const _$UnknownErrorImpl(
      {required this.statusCode, this.errorCode, this.detail});

  @override
  final int statusCode;
  @override
  final String? errorCode;
  @override
  final String? detail;

  @override
  String toString() {
    return 'CauceApiError.unknown(statusCode: $statusCode, errorCode: $errorCode, detail: $detail)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UnknownErrorImpl &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.detail, detail) || other.detail == detail));
  }

  @override
  int get hashCode => Object.hash(runtimeType, statusCode, errorCode, detail);

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      __$$UnknownErrorImplCopyWithImpl<_$UnknownErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(
            Map<String, List<String>> fieldErrors, String? errorCode)
        validation,
    required TResult Function() invalidCredentials,
    required TResult Function(DateTime lockedUntil) accountLocked,
    required TResult Function() consentMismatch,
    required TResult Function() duplicateEmail,
    required TResult Function(InvitationCodeReason reason) invitationCode,
    required TResult Function(PasswordResetTokenReason reason)
        passwordResetToken,
    required TResult Function(NutritionistNotAvailableReason reason)
        nutritionistNotAvailable,
    required TResult Function() patientAlreadyAssigned,
    required TResult Function() patientProfileNotFound,
    required TResult Function() duplicateProfile,
    required TResult Function() invalidBiometricValue,
    required TResult Function() allergyNotFound,
    required TResult Function() duplicateAllergy,
    required TResult Function() invalidIbsSssDimension,
    required TResult Function() duplicateBaselineAssessment,
    required TResult Function() foodItemNotFound,
    required TResult Function() customFoodNotFound,
    required TResult Function() duplicateCustomFood,
    required TResult Function() customFoodInUse,
    required TResult Function() duplicateIngredient,
    required TResult Function() ingredientNotFound,
    required TResult Function(List<DetectedAllergen> allergens)
        unconfirmedAllergens,
    required TResult Function() invalidMealRegistration,
    required TResult Function() mealNotFound,
    required TResult Function() symptomNotFound,
    required TResult Function() clinicalNoteNotFound,
    required TResult Function() invalidClinicalNoteAssociation,
    required TResult Function() idempotencyMismatch,
    required TResult Function(String? detail) domainRuleViolation,
    required TResult Function() invalidRefreshToken,
    required TResult Function(int retryAfterSeconds) rateLimited,
    required TResult Function() keycloakIntegration,
    required TResult Function() userLocalMissing,
    required TResult Function() consentRecordNotFound,
    required TResult Function() forbidden,
    required TResult Function() network,
    required TResult Function(int statusCode, String? errorCode, String? detail)
        unknown,
  }) {
    return unknown(statusCode, errorCode, detail);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult? Function()? invalidCredentials,
    TResult? Function(DateTime lockedUntil)? accountLocked,
    TResult? Function()? consentMismatch,
    TResult? Function()? duplicateEmail,
    TResult? Function(InvitationCodeReason reason)? invitationCode,
    TResult? Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult? Function()? patientAlreadyAssigned,
    TResult? Function()? patientProfileNotFound,
    TResult? Function()? duplicateProfile,
    TResult? Function()? invalidBiometricValue,
    TResult? Function()? allergyNotFound,
    TResult? Function()? duplicateAllergy,
    TResult? Function()? invalidIbsSssDimension,
    TResult? Function()? duplicateBaselineAssessment,
    TResult? Function()? foodItemNotFound,
    TResult? Function()? customFoodNotFound,
    TResult? Function()? duplicateCustomFood,
    TResult? Function()? customFoodInUse,
    TResult? Function()? duplicateIngredient,
    TResult? Function()? ingredientNotFound,
    TResult? Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult? Function()? invalidMealRegistration,
    TResult? Function()? mealNotFound,
    TResult? Function()? symptomNotFound,
    TResult? Function()? clinicalNoteNotFound,
    TResult? Function()? invalidClinicalNoteAssociation,
    TResult? Function()? idempotencyMismatch,
    TResult? Function(String? detail)? domainRuleViolation,
    TResult? Function()? invalidRefreshToken,
    TResult? Function(int retryAfterSeconds)? rateLimited,
    TResult? Function()? keycloakIntegration,
    TResult? Function()? userLocalMissing,
    TResult? Function()? consentRecordNotFound,
    TResult? Function()? forbidden,
    TResult? Function()? network,
    TResult? Function(int statusCode, String? errorCode, String? detail)?
        unknown,
  }) {
    return unknown?.call(statusCode, errorCode, detail);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(Map<String, List<String>> fieldErrors, String? errorCode)?
        validation,
    TResult Function()? invalidCredentials,
    TResult Function(DateTime lockedUntil)? accountLocked,
    TResult Function()? consentMismatch,
    TResult Function()? duplicateEmail,
    TResult Function(InvitationCodeReason reason)? invitationCode,
    TResult Function(PasswordResetTokenReason reason)? passwordResetToken,
    TResult Function(NutritionistNotAvailableReason reason)?
        nutritionistNotAvailable,
    TResult Function()? patientAlreadyAssigned,
    TResult Function()? patientProfileNotFound,
    TResult Function()? duplicateProfile,
    TResult Function()? invalidBiometricValue,
    TResult Function()? allergyNotFound,
    TResult Function()? duplicateAllergy,
    TResult Function()? invalidIbsSssDimension,
    TResult Function()? duplicateBaselineAssessment,
    TResult Function()? foodItemNotFound,
    TResult Function()? customFoodNotFound,
    TResult Function()? duplicateCustomFood,
    TResult Function()? customFoodInUse,
    TResult Function()? duplicateIngredient,
    TResult Function()? ingredientNotFound,
    TResult Function(List<DetectedAllergen> allergens)? unconfirmedAllergens,
    TResult Function()? invalidMealRegistration,
    TResult Function()? mealNotFound,
    TResult Function()? symptomNotFound,
    TResult Function()? clinicalNoteNotFound,
    TResult Function()? invalidClinicalNoteAssociation,
    TResult Function()? idempotencyMismatch,
    TResult Function(String? detail)? domainRuleViolation,
    TResult Function()? invalidRefreshToken,
    TResult Function(int retryAfterSeconds)? rateLimited,
    TResult Function()? keycloakIntegration,
    TResult Function()? userLocalMissing,
    TResult Function()? consentRecordNotFound,
    TResult Function()? forbidden,
    TResult Function()? network,
    TResult Function(int statusCode, String? errorCode, String? detail)?
        unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(statusCode, errorCode, detail);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ValidationError value) validation,
    required TResult Function(InvalidCredentialsError value) invalidCredentials,
    required TResult Function(AccountLockedError value) accountLocked,
    required TResult Function(ConsentMismatchError value) consentMismatch,
    required TResult Function(DuplicateEmailError value) duplicateEmail,
    required TResult Function(InvitationCodeError value) invitationCode,
    required TResult Function(PasswordResetTokenError value) passwordResetToken,
    required TResult Function(NutritionistNotAvailableError value)
        nutritionistNotAvailable,
    required TResult Function(PatientAlreadyAssignedError value)
        patientAlreadyAssigned,
    required TResult Function(PatientProfileNotFoundError value)
        patientProfileNotFound,
    required TResult Function(DuplicateProfileError value) duplicateProfile,
    required TResult Function(InvalidBiometricValueError value)
        invalidBiometricValue,
    required TResult Function(AllergyNotFoundError value) allergyNotFound,
    required TResult Function(DuplicateAllergyError value) duplicateAllergy,
    required TResult Function(InvalidIbsSssDimensionError value)
        invalidIbsSssDimension,
    required TResult Function(DuplicateBaselineAssessmentError value)
        duplicateBaselineAssessment,
    required TResult Function(FoodItemNotFoundError value) foodItemNotFound,
    required TResult Function(CustomFoodNotFoundError value) customFoodNotFound,
    required TResult Function(DuplicateCustomFoodError value)
        duplicateCustomFood,
    required TResult Function(CustomFoodInUseError value) customFoodInUse,
    required TResult Function(DuplicateIngredientError value)
        duplicateIngredient,
    required TResult Function(IngredientNotFoundError value) ingredientNotFound,
    required TResult Function(UnconfirmedAllergensError value)
        unconfirmedAllergens,
    required TResult Function(InvalidMealRegistrationError value)
        invalidMealRegistration,
    required TResult Function(MealNotFoundError value) mealNotFound,
    required TResult Function(SymptomNotFoundError value) symptomNotFound,
    required TResult Function(ClinicalNoteNotFoundError value)
        clinicalNoteNotFound,
    required TResult Function(InvalidClinicalNoteAssociationError value)
        invalidClinicalNoteAssociation,
    required TResult Function(IdempotencyMismatchError value)
        idempotencyMismatch,
    required TResult Function(DomainRuleViolationError value)
        domainRuleViolation,
    required TResult Function(InvalidRefreshTokenError value)
        invalidRefreshToken,
    required TResult Function(RateLimitedError value) rateLimited,
    required TResult Function(KeycloakIntegrationError value)
        keycloakIntegration,
    required TResult Function(UserLocalMissingError value) userLocalMissing,
    required TResult Function(ConsentRecordNotFoundError value)
        consentRecordNotFound,
    required TResult Function(ForbiddenError value) forbidden,
    required TResult Function(NetworkError value) network,
    required TResult Function(UnknownError value) unknown,
  }) {
    return unknown(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ValidationError value)? validation,
    TResult? Function(InvalidCredentialsError value)? invalidCredentials,
    TResult? Function(AccountLockedError value)? accountLocked,
    TResult? Function(ConsentMismatchError value)? consentMismatch,
    TResult? Function(DuplicateEmailError value)? duplicateEmail,
    TResult? Function(InvitationCodeError value)? invitationCode,
    TResult? Function(PasswordResetTokenError value)? passwordResetToken,
    TResult? Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult? Function(PatientAlreadyAssignedError value)?
        patientAlreadyAssigned,
    TResult? Function(PatientProfileNotFoundError value)?
        patientProfileNotFound,
    TResult? Function(DuplicateProfileError value)? duplicateProfile,
    TResult? Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult? Function(AllergyNotFoundError value)? allergyNotFound,
    TResult? Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult? Function(InvalidIbsSssDimensionError value)?
        invalidIbsSssDimension,
    TResult? Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult? Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult? Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult? Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult? Function(CustomFoodInUseError value)? customFoodInUse,
    TResult? Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult? Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult? Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult? Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult? Function(MealNotFoundError value)? mealNotFound,
    TResult? Function(SymptomNotFoundError value)? symptomNotFound,
    TResult? Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult? Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult? Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult? Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult? Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult? Function(RateLimitedError value)? rateLimited,
    TResult? Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult? Function(UserLocalMissingError value)? userLocalMissing,
    TResult? Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult? Function(ForbiddenError value)? forbidden,
    TResult? Function(NetworkError value)? network,
    TResult? Function(UnknownError value)? unknown,
  }) {
    return unknown?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ValidationError value)? validation,
    TResult Function(InvalidCredentialsError value)? invalidCredentials,
    TResult Function(AccountLockedError value)? accountLocked,
    TResult Function(ConsentMismatchError value)? consentMismatch,
    TResult Function(DuplicateEmailError value)? duplicateEmail,
    TResult Function(InvitationCodeError value)? invitationCode,
    TResult Function(PasswordResetTokenError value)? passwordResetToken,
    TResult Function(NutritionistNotAvailableError value)?
        nutritionistNotAvailable,
    TResult Function(PatientAlreadyAssignedError value)? patientAlreadyAssigned,
    TResult Function(PatientProfileNotFoundError value)? patientProfileNotFound,
    TResult Function(DuplicateProfileError value)? duplicateProfile,
    TResult Function(InvalidBiometricValueError value)? invalidBiometricValue,
    TResult Function(AllergyNotFoundError value)? allergyNotFound,
    TResult Function(DuplicateAllergyError value)? duplicateAllergy,
    TResult Function(InvalidIbsSssDimensionError value)? invalidIbsSssDimension,
    TResult Function(DuplicateBaselineAssessmentError value)?
        duplicateBaselineAssessment,
    TResult Function(FoodItemNotFoundError value)? foodItemNotFound,
    TResult Function(CustomFoodNotFoundError value)? customFoodNotFound,
    TResult Function(DuplicateCustomFoodError value)? duplicateCustomFood,
    TResult Function(CustomFoodInUseError value)? customFoodInUse,
    TResult Function(DuplicateIngredientError value)? duplicateIngredient,
    TResult Function(IngredientNotFoundError value)? ingredientNotFound,
    TResult Function(UnconfirmedAllergensError value)? unconfirmedAllergens,
    TResult Function(InvalidMealRegistrationError value)?
        invalidMealRegistration,
    TResult Function(MealNotFoundError value)? mealNotFound,
    TResult Function(SymptomNotFoundError value)? symptomNotFound,
    TResult Function(ClinicalNoteNotFoundError value)? clinicalNoteNotFound,
    TResult Function(InvalidClinicalNoteAssociationError value)?
        invalidClinicalNoteAssociation,
    TResult Function(IdempotencyMismatchError value)? idempotencyMismatch,
    TResult Function(DomainRuleViolationError value)? domainRuleViolation,
    TResult Function(InvalidRefreshTokenError value)? invalidRefreshToken,
    TResult Function(RateLimitedError value)? rateLimited,
    TResult Function(KeycloakIntegrationError value)? keycloakIntegration,
    TResult Function(UserLocalMissingError value)? userLocalMissing,
    TResult Function(ConsentRecordNotFoundError value)? consentRecordNotFound,
    TResult Function(ForbiddenError value)? forbidden,
    TResult Function(NetworkError value)? network,
    TResult Function(UnknownError value)? unknown,
    required TResult orElse(),
  }) {
    if (unknown != null) {
      return unknown(this);
    }
    return orElse();
  }
}

abstract class UnknownError implements CauceApiError {
  const factory UnknownError(
      {required final int statusCode,
      final String? errorCode,
      final String? detail}) = _$UnknownErrorImpl;

  int get statusCode;
  String? get errorCode;
  String? get detail;

  /// Create a copy of CauceApiError
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UnknownErrorImplCopyWith<_$UnknownErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
