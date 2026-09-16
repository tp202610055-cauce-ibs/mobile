// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'allergy.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$AllergyCatalogEntry {
  String get allergyId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  AllergyTypeOption? get type => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

  /// Create a copy of AllergyCatalogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllergyCatalogEntryCopyWith<AllergyCatalogEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllergyCatalogEntryCopyWith<$Res> {
  factory $AllergyCatalogEntryCopyWith(
          AllergyCatalogEntry value, $Res Function(AllergyCatalogEntry) then) =
      _$AllergyCatalogEntryCopyWithImpl<$Res, AllergyCatalogEntry>;
  @useResult
  $Res call(
      {String allergyId,
      String name,
      AllergyTypeOption? type,
      String? description});
}

/// @nodoc
class _$AllergyCatalogEntryCopyWithImpl<$Res, $Val extends AllergyCatalogEntry>
    implements $AllergyCatalogEntryCopyWith<$Res> {
  _$AllergyCatalogEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllergyCatalogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allergyId = null,
    Object? name = null,
    Object? type = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      allergyId: null == allergyId
          ? _value.allergyId
          : allergyId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AllergyTypeOption?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllergyCatalogEntryImplCopyWith<$Res>
    implements $AllergyCatalogEntryCopyWith<$Res> {
  factory _$$AllergyCatalogEntryImplCopyWith(_$AllergyCatalogEntryImpl value,
          $Res Function(_$AllergyCatalogEntryImpl) then) =
      __$$AllergyCatalogEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String allergyId,
      String name,
      AllergyTypeOption? type,
      String? description});
}

/// @nodoc
class __$$AllergyCatalogEntryImplCopyWithImpl<$Res>
    extends _$AllergyCatalogEntryCopyWithImpl<$Res, _$AllergyCatalogEntryImpl>
    implements _$$AllergyCatalogEntryImplCopyWith<$Res> {
  __$$AllergyCatalogEntryImplCopyWithImpl(_$AllergyCatalogEntryImpl _value,
      $Res Function(_$AllergyCatalogEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllergyCatalogEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allergyId = null,
    Object? name = null,
    Object? type = freezed,
    Object? description = freezed,
  }) {
    return _then(_$AllergyCatalogEntryImpl(
      allergyId: null == allergyId
          ? _value.allergyId
          : allergyId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AllergyTypeOption?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AllergyCatalogEntryImpl extends _AllergyCatalogEntry {
  const _$AllergyCatalogEntryImpl(
      {required this.allergyId,
      required this.name,
      this.type,
      this.description})
      : super._();

  @override
  final String allergyId;
  @override
  final String name;
  @override
  final AllergyTypeOption? type;
  @override
  final String? description;

  @override
  String toString() {
    return 'AllergyCatalogEntry(allergyId: $allergyId, name: $name, type: $type, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllergyCatalogEntryImpl &&
            (identical(other.allergyId, allergyId) ||
                other.allergyId == allergyId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, allergyId, name, type, description);

  /// Create a copy of AllergyCatalogEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllergyCatalogEntryImplCopyWith<_$AllergyCatalogEntryImpl> get copyWith =>
      __$$AllergyCatalogEntryImplCopyWithImpl<_$AllergyCatalogEntryImpl>(
          this, _$identity);
}

abstract class _AllergyCatalogEntry extends AllergyCatalogEntry {
  const factory _AllergyCatalogEntry(
      {required final String allergyId,
      required final String name,
      final AllergyTypeOption? type,
      final String? description}) = _$AllergyCatalogEntryImpl;
  const _AllergyCatalogEntry._() : super._();

  @override
  String get allergyId;
  @override
  String get name;
  @override
  AllergyTypeOption? get type;
  @override
  String? get description;

  /// Create a copy of AllergyCatalogEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllergyCatalogEntryImplCopyWith<_$AllergyCatalogEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AllergyDeclarationDraft {
  String get allergyId => throw _privateConstructorUsedError;
  AllergySeverityLevel get severity => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Create a copy of AllergyDeclarationDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllergyDeclarationDraftCopyWith<AllergyDeclarationDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllergyDeclarationDraftCopyWith<$Res> {
  factory $AllergyDeclarationDraftCopyWith(AllergyDeclarationDraft value,
          $Res Function(AllergyDeclarationDraft) then) =
      _$AllergyDeclarationDraftCopyWithImpl<$Res, AllergyDeclarationDraft>;
  @useResult
  $Res call({String allergyId, AllergySeverityLevel severity, String? notes});
}

/// @nodoc
class _$AllergyDeclarationDraftCopyWithImpl<$Res,
        $Val extends AllergyDeclarationDraft>
    implements $AllergyDeclarationDraftCopyWith<$Res> {
  _$AllergyDeclarationDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllergyDeclarationDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allergyId = null,
    Object? severity = null,
    Object? notes = freezed,
  }) {
    return _then(_value.copyWith(
      allergyId: null == allergyId
          ? _value.allergyId
          : allergyId // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as AllergySeverityLevel,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllergyDeclarationDraftImplCopyWith<$Res>
    implements $AllergyDeclarationDraftCopyWith<$Res> {
  factory _$$AllergyDeclarationDraftImplCopyWith(
          _$AllergyDeclarationDraftImpl value,
          $Res Function(_$AllergyDeclarationDraftImpl) then) =
      __$$AllergyDeclarationDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String allergyId, AllergySeverityLevel severity, String? notes});
}

/// @nodoc
class __$$AllergyDeclarationDraftImplCopyWithImpl<$Res>
    extends _$AllergyDeclarationDraftCopyWithImpl<$Res,
        _$AllergyDeclarationDraftImpl>
    implements _$$AllergyDeclarationDraftImplCopyWith<$Res> {
  __$$AllergyDeclarationDraftImplCopyWithImpl(
      _$AllergyDeclarationDraftImpl _value,
      $Res Function(_$AllergyDeclarationDraftImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllergyDeclarationDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? allergyId = null,
    Object? severity = null,
    Object? notes = freezed,
  }) {
    return _then(_$AllergyDeclarationDraftImpl(
      allergyId: null == allergyId
          ? _value.allergyId
          : allergyId // ignore: cast_nullable_to_non_nullable
              as String,
      severity: null == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as AllergySeverityLevel,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$AllergyDeclarationDraftImpl extends _AllergyDeclarationDraft {
  const _$AllergyDeclarationDraftImpl(
      {required this.allergyId, required this.severity, this.notes})
      : super._();

  @override
  final String allergyId;
  @override
  final AllergySeverityLevel severity;
  @override
  final String? notes;

  @override
  String toString() {
    return 'AllergyDeclarationDraft(allergyId: $allergyId, severity: $severity, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllergyDeclarationDraftImpl &&
            (identical(other.allergyId, allergyId) ||
                other.allergyId == allergyId) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @override
  int get hashCode => Object.hash(runtimeType, allergyId, severity, notes);

  /// Create a copy of AllergyDeclarationDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllergyDeclarationDraftImplCopyWith<_$AllergyDeclarationDraftImpl>
      get copyWith => __$$AllergyDeclarationDraftImplCopyWithImpl<
          _$AllergyDeclarationDraftImpl>(this, _$identity);
}

abstract class _AllergyDeclarationDraft extends AllergyDeclarationDraft {
  const factory _AllergyDeclarationDraft(
      {required final String allergyId,
      required final AllergySeverityLevel severity,
      final String? notes}) = _$AllergyDeclarationDraftImpl;
  const _AllergyDeclarationDraft._() : super._();

  @override
  String get allergyId;
  @override
  AllergySeverityLevel get severity;
  @override
  String? get notes;

  /// Create a copy of AllergyDeclarationDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllergyDeclarationDraftImplCopyWith<_$AllergyDeclarationDraftImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$AllergyDeclaration {
  String get patientAllergyId => throw _privateConstructorUsedError;
  String get allergyId => throw _privateConstructorUsedError;
  String get allergyName => throw _privateConstructorUsedError;
  AllergyTypeOption? get type => throw _privateConstructorUsedError;
  AllergySeverityLevel? get severity => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;
  DateTime? get declaredAt => throw _privateConstructorUsedError;

  /// Create a copy of AllergyDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AllergyDeclarationCopyWith<AllergyDeclaration> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AllergyDeclarationCopyWith<$Res> {
  factory $AllergyDeclarationCopyWith(
          AllergyDeclaration value, $Res Function(AllergyDeclaration) then) =
      _$AllergyDeclarationCopyWithImpl<$Res, AllergyDeclaration>;
  @useResult
  $Res call(
      {String patientAllergyId,
      String allergyId,
      String allergyName,
      AllergyTypeOption? type,
      AllergySeverityLevel? severity,
      String? notes,
      DateTime? declaredAt});
}

/// @nodoc
class _$AllergyDeclarationCopyWithImpl<$Res, $Val extends AllergyDeclaration>
    implements $AllergyDeclarationCopyWith<$Res> {
  _$AllergyDeclarationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AllergyDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientAllergyId = null,
    Object? allergyId = null,
    Object? allergyName = null,
    Object? type = freezed,
    Object? severity = freezed,
    Object? notes = freezed,
    Object? declaredAt = freezed,
  }) {
    return _then(_value.copyWith(
      patientAllergyId: null == patientAllergyId
          ? _value.patientAllergyId
          : patientAllergyId // ignore: cast_nullable_to_non_nullable
              as String,
      allergyId: null == allergyId
          ? _value.allergyId
          : allergyId // ignore: cast_nullable_to_non_nullable
              as String,
      allergyName: null == allergyName
          ? _value.allergyName
          : allergyName // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AllergyTypeOption?,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as AllergySeverityLevel?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      declaredAt: freezed == declaredAt
          ? _value.declaredAt
          : declaredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AllergyDeclarationImplCopyWith<$Res>
    implements $AllergyDeclarationCopyWith<$Res> {
  factory _$$AllergyDeclarationImplCopyWith(_$AllergyDeclarationImpl value,
          $Res Function(_$AllergyDeclarationImpl) then) =
      __$$AllergyDeclarationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String patientAllergyId,
      String allergyId,
      String allergyName,
      AllergyTypeOption? type,
      AllergySeverityLevel? severity,
      String? notes,
      DateTime? declaredAt});
}

/// @nodoc
class __$$AllergyDeclarationImplCopyWithImpl<$Res>
    extends _$AllergyDeclarationCopyWithImpl<$Res, _$AllergyDeclarationImpl>
    implements _$$AllergyDeclarationImplCopyWith<$Res> {
  __$$AllergyDeclarationImplCopyWithImpl(_$AllergyDeclarationImpl _value,
      $Res Function(_$AllergyDeclarationImpl) _then)
      : super(_value, _then);

  /// Create a copy of AllergyDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? patientAllergyId = null,
    Object? allergyId = null,
    Object? allergyName = null,
    Object? type = freezed,
    Object? severity = freezed,
    Object? notes = freezed,
    Object? declaredAt = freezed,
  }) {
    return _then(_$AllergyDeclarationImpl(
      patientAllergyId: null == patientAllergyId
          ? _value.patientAllergyId
          : patientAllergyId // ignore: cast_nullable_to_non_nullable
              as String,
      allergyId: null == allergyId
          ? _value.allergyId
          : allergyId // ignore: cast_nullable_to_non_nullable
              as String,
      allergyName: null == allergyName
          ? _value.allergyName
          : allergyName // ignore: cast_nullable_to_non_nullable
              as String,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as AllergyTypeOption?,
      severity: freezed == severity
          ? _value.severity
          : severity // ignore: cast_nullable_to_non_nullable
              as AllergySeverityLevel?,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
      declaredAt: freezed == declaredAt
          ? _value.declaredAt
          : declaredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$AllergyDeclarationImpl extends _AllergyDeclaration {
  const _$AllergyDeclarationImpl(
      {required this.patientAllergyId,
      required this.allergyId,
      required this.allergyName,
      this.type,
      this.severity,
      this.notes,
      this.declaredAt})
      : super._();

  @override
  final String patientAllergyId;
  @override
  final String allergyId;
  @override
  final String allergyName;
  @override
  final AllergyTypeOption? type;
  @override
  final AllergySeverityLevel? severity;
  @override
  final String? notes;
  @override
  final DateTime? declaredAt;

  @override
  String toString() {
    return 'AllergyDeclaration(patientAllergyId: $patientAllergyId, allergyId: $allergyId, allergyName: $allergyName, type: $type, severity: $severity, notes: $notes, declaredAt: $declaredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AllergyDeclarationImpl &&
            (identical(other.patientAllergyId, patientAllergyId) ||
                other.patientAllergyId == patientAllergyId) &&
            (identical(other.allergyId, allergyId) ||
                other.allergyId == allergyId) &&
            (identical(other.allergyName, allergyName) ||
                other.allergyName == allergyName) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.severity, severity) ||
                other.severity == severity) &&
            (identical(other.notes, notes) || other.notes == notes) &&
            (identical(other.declaredAt, declaredAt) ||
                other.declaredAt == declaredAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, patientAllergyId, allergyId,
      allergyName, type, severity, notes, declaredAt);

  /// Create a copy of AllergyDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AllergyDeclarationImplCopyWith<_$AllergyDeclarationImpl> get copyWith =>
      __$$AllergyDeclarationImplCopyWithImpl<_$AllergyDeclarationImpl>(
          this, _$identity);
}

abstract class _AllergyDeclaration extends AllergyDeclaration {
  const factory _AllergyDeclaration(
      {required final String patientAllergyId,
      required final String allergyId,
      required final String allergyName,
      final AllergyTypeOption? type,
      final AllergySeverityLevel? severity,
      final String? notes,
      final DateTime? declaredAt}) = _$AllergyDeclarationImpl;
  const _AllergyDeclaration._() : super._();

  @override
  String get patientAllergyId;
  @override
  String get allergyId;
  @override
  String get allergyName;
  @override
  AllergyTypeOption? get type;
  @override
  AllergySeverityLevel? get severity;
  @override
  String? get notes;
  @override
  DateTime? get declaredAt;

  /// Create a copy of AllergyDeclaration
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AllergyDeclarationImplCopyWith<_$AllergyDeclarationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
