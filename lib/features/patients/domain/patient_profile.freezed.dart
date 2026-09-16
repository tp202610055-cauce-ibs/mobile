// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'patient_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PatientProfileDraft {
  /// Fecha de nacimiento. Solo la parte de fecha es significativa; la hora
  /// se descarta al serializar.
  DateTime get dateOfBirth => throw _privateConstructorUsedError;
  BiologicalSexOption get biologicalSex => throw _privateConstructorUsedError;
  double get weightKg => throw _privateConstructorUsedError;
  double get heightCm => throw _privateConstructorUsedError;
  IbsSubtypeOption get ibsSubtype => throw _privateConstructorUsedError;
  DateTime? get diagnosisDate => throw _privateConstructorUsedError;
  String? get medications => throw _privateConstructorUsedError;

  /// Create a copy of PatientProfileDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientProfileDraftCopyWith<PatientProfileDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientProfileDraftCopyWith<$Res> {
  factory $PatientProfileDraftCopyWith(
          PatientProfileDraft value, $Res Function(PatientProfileDraft) then) =
      _$PatientProfileDraftCopyWithImpl<$Res, PatientProfileDraft>;
  @useResult
  $Res call(
      {DateTime dateOfBirth,
      BiologicalSexOption biologicalSex,
      double weightKg,
      double heightCm,
      IbsSubtypeOption ibsSubtype,
      DateTime? diagnosisDate,
      String? medications});
}

/// @nodoc
class _$PatientProfileDraftCopyWithImpl<$Res, $Val extends PatientProfileDraft>
    implements $PatientProfileDraftCopyWith<$Res> {
  _$PatientProfileDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientProfileDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateOfBirth = null,
    Object? biologicalSex = null,
    Object? weightKg = null,
    Object? heightCm = null,
    Object? ibsSubtype = null,
    Object? diagnosisDate = freezed,
    Object? medications = freezed,
  }) {
    return _then(_value.copyWith(
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      biologicalSex: null == biologicalSex
          ? _value.biologicalSex
          : biologicalSex // ignore: cast_nullable_to_non_nullable
              as BiologicalSexOption,
      weightKg: null == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      ibsSubtype: null == ibsSubtype
          ? _value.ibsSubtype
          : ibsSubtype // ignore: cast_nullable_to_non_nullable
              as IbsSubtypeOption,
      diagnosisDate: freezed == diagnosisDate
          ? _value.diagnosisDate
          : diagnosisDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      medications: freezed == medications
          ? _value.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatientProfileDraftImplCopyWith<$Res>
    implements $PatientProfileDraftCopyWith<$Res> {
  factory _$$PatientProfileDraftImplCopyWith(_$PatientProfileDraftImpl value,
          $Res Function(_$PatientProfileDraftImpl) then) =
      __$$PatientProfileDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime dateOfBirth,
      BiologicalSexOption biologicalSex,
      double weightKg,
      double heightCm,
      IbsSubtypeOption ibsSubtype,
      DateTime? diagnosisDate,
      String? medications});
}

/// @nodoc
class __$$PatientProfileDraftImplCopyWithImpl<$Res>
    extends _$PatientProfileDraftCopyWithImpl<$Res, _$PatientProfileDraftImpl>
    implements _$$PatientProfileDraftImplCopyWith<$Res> {
  __$$PatientProfileDraftImplCopyWithImpl(_$PatientProfileDraftImpl _value,
      $Res Function(_$PatientProfileDraftImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientProfileDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? dateOfBirth = null,
    Object? biologicalSex = null,
    Object? weightKg = null,
    Object? heightCm = null,
    Object? ibsSubtype = null,
    Object? diagnosisDate = freezed,
    Object? medications = freezed,
  }) {
    return _then(_$PatientProfileDraftImpl(
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      biologicalSex: null == biologicalSex
          ? _value.biologicalSex
          : biologicalSex // ignore: cast_nullable_to_non_nullable
              as BiologicalSexOption,
      weightKg: null == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      ibsSubtype: null == ibsSubtype
          ? _value.ibsSubtype
          : ibsSubtype // ignore: cast_nullable_to_non_nullable
              as IbsSubtypeOption,
      diagnosisDate: freezed == diagnosisDate
          ? _value.diagnosisDate
          : diagnosisDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      medications: freezed == medications
          ? _value.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PatientProfileDraftImpl extends _PatientProfileDraft {
  const _$PatientProfileDraftImpl(
      {required this.dateOfBirth,
      required this.biologicalSex,
      required this.weightKg,
      required this.heightCm,
      required this.ibsSubtype,
      this.diagnosisDate,
      this.medications})
      : super._();

  /// Fecha de nacimiento. Solo la parte de fecha es significativa; la hora
  /// se descarta al serializar.
  @override
  final DateTime dateOfBirth;
  @override
  final BiologicalSexOption biologicalSex;
  @override
  final double weightKg;
  @override
  final double heightCm;
  @override
  final IbsSubtypeOption ibsSubtype;
  @override
  final DateTime? diagnosisDate;
  @override
  final String? medications;

  @override
  String toString() {
    return 'PatientProfileDraft(dateOfBirth: $dateOfBirth, biologicalSex: $biologicalSex, weightKg: $weightKg, heightCm: $heightCm, ibsSubtype: $ibsSubtype, diagnosisDate: $diagnosisDate, medications: $medications)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientProfileDraftImpl &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.biologicalSex, biologicalSex) ||
                other.biologicalSex == biologicalSex) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.heightCm, heightCm) ||
                other.heightCm == heightCm) &&
            (identical(other.ibsSubtype, ibsSubtype) ||
                other.ibsSubtype == ibsSubtype) &&
            (identical(other.diagnosisDate, diagnosisDate) ||
                other.diagnosisDate == diagnosisDate) &&
            (identical(other.medications, medications) ||
                other.medications == medications));
  }

  @override
  int get hashCode => Object.hash(runtimeType, dateOfBirth, biologicalSex,
      weightKg, heightCm, ibsSubtype, diagnosisDate, medications);

  /// Create a copy of PatientProfileDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientProfileDraftImplCopyWith<_$PatientProfileDraftImpl> get copyWith =>
      __$$PatientProfileDraftImplCopyWithImpl<_$PatientProfileDraftImpl>(
          this, _$identity);
}

abstract class _PatientProfileDraft extends PatientProfileDraft {
  const factory _PatientProfileDraft(
      {required final DateTime dateOfBirth,
      required final BiologicalSexOption biologicalSex,
      required final double weightKg,
      required final double heightCm,
      required final IbsSubtypeOption ibsSubtype,
      final DateTime? diagnosisDate,
      final String? medications}) = _$PatientProfileDraftImpl;
  const _PatientProfileDraft._() : super._();

  /// Fecha de nacimiento. Solo la parte de fecha es significativa; la hora
  /// se descarta al serializar.
  @override
  DateTime get dateOfBirth;
  @override
  BiologicalSexOption get biologicalSex;
  @override
  double get weightKg;
  @override
  double get heightCm;
  @override
  IbsSubtypeOption get ibsSubtype;
  @override
  DateTime? get diagnosisDate;
  @override
  String? get medications;

  /// Create a copy of PatientProfileDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientProfileDraftImplCopyWith<_$PatientProfileDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PatientProfile {
  String get profileId => throw _privateConstructorUsedError;
  DateTime get dateOfBirth => throw _privateConstructorUsedError;
  double get weightKg => throw _privateConstructorUsedError;
  double get heightCm => throw _privateConstructorUsedError;
  double get bmi => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;

  /// `true` cuando el paciente ya registro su linea base IBS-SSS. Es el
  /// dato que decide si el wizard de onboarding tiene que mostrarse.
  bool get onboardingCompleted => throw _privateConstructorUsedError;
  BiologicalSexOption? get biologicalSex => throw _privateConstructorUsedError;
  IbsSubtypeOption? get ibsSubtype => throw _privateConstructorUsedError;
  BmiCategory? get bmiCategory => throw _privateConstructorUsedError;
  DateTime? get diagnosisDate => throw _privateConstructorUsedError;
  String? get medications => throw _privateConstructorUsedError;
  List<AllergyDeclaration> get allergies => throw _privateConstructorUsedError;

  /// Create a copy of PatientProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PatientProfileCopyWith<PatientProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PatientProfileCopyWith<$Res> {
  factory $PatientProfileCopyWith(
          PatientProfile value, $Res Function(PatientProfile) then) =
      _$PatientProfileCopyWithImpl<$Res, PatientProfile>;
  @useResult
  $Res call(
      {String profileId,
      DateTime dateOfBirth,
      double weightKg,
      double heightCm,
      double bmi,
      int age,
      bool onboardingCompleted,
      BiologicalSexOption? biologicalSex,
      IbsSubtypeOption? ibsSubtype,
      BmiCategory? bmiCategory,
      DateTime? diagnosisDate,
      String? medications,
      List<AllergyDeclaration> allergies});
}

/// @nodoc
class _$PatientProfileCopyWithImpl<$Res, $Val extends PatientProfile>
    implements $PatientProfileCopyWith<$Res> {
  _$PatientProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PatientProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileId = null,
    Object? dateOfBirth = null,
    Object? weightKg = null,
    Object? heightCm = null,
    Object? bmi = null,
    Object? age = null,
    Object? onboardingCompleted = null,
    Object? biologicalSex = freezed,
    Object? ibsSubtype = freezed,
    Object? bmiCategory = freezed,
    Object? diagnosisDate = freezed,
    Object? medications = freezed,
    Object? allergies = null,
  }) {
    return _then(_value.copyWith(
      profileId: null == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weightKg: null == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      bmi: null == bmi
          ? _value.bmi
          : bmi // ignore: cast_nullable_to_non_nullable
              as double,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      onboardingCompleted: null == onboardingCompleted
          ? _value.onboardingCompleted
          : onboardingCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      biologicalSex: freezed == biologicalSex
          ? _value.biologicalSex
          : biologicalSex // ignore: cast_nullable_to_non_nullable
              as BiologicalSexOption?,
      ibsSubtype: freezed == ibsSubtype
          ? _value.ibsSubtype
          : ibsSubtype // ignore: cast_nullable_to_non_nullable
              as IbsSubtypeOption?,
      bmiCategory: freezed == bmiCategory
          ? _value.bmiCategory
          : bmiCategory // ignore: cast_nullable_to_non_nullable
              as BmiCategory?,
      diagnosisDate: freezed == diagnosisDate
          ? _value.diagnosisDate
          : diagnosisDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      medications: freezed == medications
          ? _value.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as String?,
      allergies: null == allergies
          ? _value.allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<AllergyDeclaration>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PatientProfileImplCopyWith<$Res>
    implements $PatientProfileCopyWith<$Res> {
  factory _$$PatientProfileImplCopyWith(_$PatientProfileImpl value,
          $Res Function(_$PatientProfileImpl) then) =
      __$$PatientProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String profileId,
      DateTime dateOfBirth,
      double weightKg,
      double heightCm,
      double bmi,
      int age,
      bool onboardingCompleted,
      BiologicalSexOption? biologicalSex,
      IbsSubtypeOption? ibsSubtype,
      BmiCategory? bmiCategory,
      DateTime? diagnosisDate,
      String? medications,
      List<AllergyDeclaration> allergies});
}

/// @nodoc
class __$$PatientProfileImplCopyWithImpl<$Res>
    extends _$PatientProfileCopyWithImpl<$Res, _$PatientProfileImpl>
    implements _$$PatientProfileImplCopyWith<$Res> {
  __$$PatientProfileImplCopyWithImpl(
      _$PatientProfileImpl _value, $Res Function(_$PatientProfileImpl) _then)
      : super(_value, _then);

  /// Create a copy of PatientProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profileId = null,
    Object? dateOfBirth = null,
    Object? weightKg = null,
    Object? heightCm = null,
    Object? bmi = null,
    Object? age = null,
    Object? onboardingCompleted = null,
    Object? biologicalSex = freezed,
    Object? ibsSubtype = freezed,
    Object? bmiCategory = freezed,
    Object? diagnosisDate = freezed,
    Object? medications = freezed,
    Object? allergies = null,
  }) {
    return _then(_$PatientProfileImpl(
      profileId: null == profileId
          ? _value.profileId
          : profileId // ignore: cast_nullable_to_non_nullable
              as String,
      dateOfBirth: null == dateOfBirth
          ? _value.dateOfBirth
          : dateOfBirth // ignore: cast_nullable_to_non_nullable
              as DateTime,
      weightKg: null == weightKg
          ? _value.weightKg
          : weightKg // ignore: cast_nullable_to_non_nullable
              as double,
      heightCm: null == heightCm
          ? _value.heightCm
          : heightCm // ignore: cast_nullable_to_non_nullable
              as double,
      bmi: null == bmi
          ? _value.bmi
          : bmi // ignore: cast_nullable_to_non_nullable
              as double,
      age: null == age
          ? _value.age
          : age // ignore: cast_nullable_to_non_nullable
              as int,
      onboardingCompleted: null == onboardingCompleted
          ? _value.onboardingCompleted
          : onboardingCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      biologicalSex: freezed == biologicalSex
          ? _value.biologicalSex
          : biologicalSex // ignore: cast_nullable_to_non_nullable
              as BiologicalSexOption?,
      ibsSubtype: freezed == ibsSubtype
          ? _value.ibsSubtype
          : ibsSubtype // ignore: cast_nullable_to_non_nullable
              as IbsSubtypeOption?,
      bmiCategory: freezed == bmiCategory
          ? _value.bmiCategory
          : bmiCategory // ignore: cast_nullable_to_non_nullable
              as BmiCategory?,
      diagnosisDate: freezed == diagnosisDate
          ? _value.diagnosisDate
          : diagnosisDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      medications: freezed == medications
          ? _value.medications
          : medications // ignore: cast_nullable_to_non_nullable
              as String?,
      allergies: null == allergies
          ? _value._allergies
          : allergies // ignore: cast_nullable_to_non_nullable
              as List<AllergyDeclaration>,
    ));
  }
}

/// @nodoc

class _$PatientProfileImpl extends _PatientProfile {
  const _$PatientProfileImpl(
      {required this.profileId,
      required this.dateOfBirth,
      required this.weightKg,
      required this.heightCm,
      required this.bmi,
      required this.age,
      required this.onboardingCompleted,
      this.biologicalSex,
      this.ibsSubtype,
      this.bmiCategory,
      this.diagnosisDate,
      this.medications,
      final List<AllergyDeclaration> allergies = const <AllergyDeclaration>[]})
      : _allergies = allergies,
        super._();

  @override
  final String profileId;
  @override
  final DateTime dateOfBirth;
  @override
  final double weightKg;
  @override
  final double heightCm;
  @override
  final double bmi;
  @override
  final int age;

  /// `true` cuando el paciente ya registro su linea base IBS-SSS. Es el
  /// dato que decide si el wizard de onboarding tiene que mostrarse.
  @override
  final bool onboardingCompleted;
  @override
  final BiologicalSexOption? biologicalSex;
  @override
  final IbsSubtypeOption? ibsSubtype;
  @override
  final BmiCategory? bmiCategory;
  @override
  final DateTime? diagnosisDate;
  @override
  final String? medications;
  final List<AllergyDeclaration> _allergies;
  @override
  @JsonKey()
  List<AllergyDeclaration> get allergies {
    if (_allergies is EqualUnmodifiableListView) return _allergies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_allergies);
  }

  @override
  String toString() {
    return 'PatientProfile(profileId: $profileId, dateOfBirth: $dateOfBirth, weightKg: $weightKg, heightCm: $heightCm, bmi: $bmi, age: $age, onboardingCompleted: $onboardingCompleted, biologicalSex: $biologicalSex, ibsSubtype: $ibsSubtype, bmiCategory: $bmiCategory, diagnosisDate: $diagnosisDate, medications: $medications, allergies: $allergies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PatientProfileImpl &&
            (identical(other.profileId, profileId) ||
                other.profileId == profileId) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.weightKg, weightKg) ||
                other.weightKg == weightKg) &&
            (identical(other.heightCm, heightCm) ||
                other.heightCm == heightCm) &&
            (identical(other.bmi, bmi) || other.bmi == bmi) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.onboardingCompleted, onboardingCompleted) ||
                other.onboardingCompleted == onboardingCompleted) &&
            (identical(other.biologicalSex, biologicalSex) ||
                other.biologicalSex == biologicalSex) &&
            (identical(other.ibsSubtype, ibsSubtype) ||
                other.ibsSubtype == ibsSubtype) &&
            (identical(other.bmiCategory, bmiCategory) ||
                other.bmiCategory == bmiCategory) &&
            (identical(other.diagnosisDate, diagnosisDate) ||
                other.diagnosisDate == diagnosisDate) &&
            (identical(other.medications, medications) ||
                other.medications == medications) &&
            const DeepCollectionEquality()
                .equals(other._allergies, _allergies));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      profileId,
      dateOfBirth,
      weightKg,
      heightCm,
      bmi,
      age,
      onboardingCompleted,
      biologicalSex,
      ibsSubtype,
      bmiCategory,
      diagnosisDate,
      medications,
      const DeepCollectionEquality().hash(_allergies));

  /// Create a copy of PatientProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PatientProfileImplCopyWith<_$PatientProfileImpl> get copyWith =>
      __$$PatientProfileImplCopyWithImpl<_$PatientProfileImpl>(
          this, _$identity);
}

abstract class _PatientProfile extends PatientProfile {
  const factory _PatientProfile(
      {required final String profileId,
      required final DateTime dateOfBirth,
      required final double weightKg,
      required final double heightCm,
      required final double bmi,
      required final int age,
      required final bool onboardingCompleted,
      final BiologicalSexOption? biologicalSex,
      final IbsSubtypeOption? ibsSubtype,
      final BmiCategory? bmiCategory,
      final DateTime? diagnosisDate,
      final String? medications,
      final List<AllergyDeclaration> allergies}) = _$PatientProfileImpl;
  const _PatientProfile._() : super._();

  @override
  String get profileId;
  @override
  DateTime get dateOfBirth;
  @override
  double get weightKg;
  @override
  double get heightCm;
  @override
  double get bmi;
  @override
  int get age;

  /// `true` cuando el paciente ya registro su linea base IBS-SSS. Es el
  /// dato que decide si el wizard de onboarding tiene que mostrarse.
  @override
  bool get onboardingCompleted;
  @override
  BiologicalSexOption? get biologicalSex;
  @override
  IbsSubtypeOption? get ibsSubtype;
  @override
  BmiCategory? get bmiCategory;
  @override
  DateTime? get diagnosisDate;
  @override
  String? get medications;
  @override
  List<AllergyDeclaration> get allergies;

  /// Create a copy of PatientProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PatientProfileImplCopyWith<_$PatientProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
