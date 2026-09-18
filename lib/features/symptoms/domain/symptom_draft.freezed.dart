// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symptom_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SymptomDraft {
  SymptomTypeOption? get symptomType => throw _privateConstructorUsedError;

  /// De 1 a 100, o `null` mientras el paciente no responda.
  int? get intensity => throw _privateConstructorUsedError;
  DateTime? get occurredAt => throw _privateConstructorUsedError;

  /// Create a copy of SymptomDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SymptomDraftCopyWith<SymptomDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SymptomDraftCopyWith<$Res> {
  factory $SymptomDraftCopyWith(
          SymptomDraft value, $Res Function(SymptomDraft) then) =
      _$SymptomDraftCopyWithImpl<$Res, SymptomDraft>;
  @useResult
  $Res call(
      {SymptomTypeOption? symptomType, int? intensity, DateTime? occurredAt});
}

/// @nodoc
class _$SymptomDraftCopyWithImpl<$Res, $Val extends SymptomDraft>
    implements $SymptomDraftCopyWith<$Res> {
  _$SymptomDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SymptomDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symptomType = freezed,
    Object? intensity = freezed,
    Object? occurredAt = freezed,
  }) {
    return _then(_value.copyWith(
      symptomType: freezed == symptomType
          ? _value.symptomType
          : symptomType // ignore: cast_nullable_to_non_nullable
              as SymptomTypeOption?,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int?,
      occurredAt: freezed == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SymptomDraftImplCopyWith<$Res>
    implements $SymptomDraftCopyWith<$Res> {
  factory _$$SymptomDraftImplCopyWith(
          _$SymptomDraftImpl value, $Res Function(_$SymptomDraftImpl) then) =
      __$$SymptomDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SymptomTypeOption? symptomType, int? intensity, DateTime? occurredAt});
}

/// @nodoc
class __$$SymptomDraftImplCopyWithImpl<$Res>
    extends _$SymptomDraftCopyWithImpl<$Res, _$SymptomDraftImpl>
    implements _$$SymptomDraftImplCopyWith<$Res> {
  __$$SymptomDraftImplCopyWithImpl(
      _$SymptomDraftImpl _value, $Res Function(_$SymptomDraftImpl) _then)
      : super(_value, _then);

  /// Create a copy of SymptomDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symptomType = freezed,
    Object? intensity = freezed,
    Object? occurredAt = freezed,
  }) {
    return _then(_$SymptomDraftImpl(
      symptomType: freezed == symptomType
          ? _value.symptomType
          : symptomType // ignore: cast_nullable_to_non_nullable
              as SymptomTypeOption?,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int?,
      occurredAt: freezed == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$SymptomDraftImpl extends _SymptomDraft {
  const _$SymptomDraftImpl({this.symptomType, this.intensity, this.occurredAt})
      : super._();

  @override
  final SymptomTypeOption? symptomType;

  /// De 1 a 100, o `null` mientras el paciente no responda.
  @override
  final int? intensity;
  @override
  final DateTime? occurredAt;

  @override
  String toString() {
    return 'SymptomDraft(symptomType: $symptomType, intensity: $intensity, occurredAt: $occurredAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SymptomDraftImpl &&
            (identical(other.symptomType, symptomType) ||
                other.symptomType == symptomType) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, symptomType, intensity, occurredAt);

  /// Create a copy of SymptomDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SymptomDraftImplCopyWith<_$SymptomDraftImpl> get copyWith =>
      __$$SymptomDraftImplCopyWithImpl<_$SymptomDraftImpl>(this, _$identity);
}

abstract class _SymptomDraft extends SymptomDraft {
  const factory _SymptomDraft(
      {final SymptomTypeOption? symptomType,
      final int? intensity,
      final DateTime? occurredAt}) = _$SymptomDraftImpl;
  const _SymptomDraft._() : super._();

  @override
  SymptomTypeOption? get symptomType;

  /// De 1 a 100, o `null` mientras el paciente no responda.
  @override
  int? get intensity;
  @override
  DateTime? get occurredAt;

  /// Create a copy of SymptomDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SymptomDraftImplCopyWith<_$SymptomDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CreatedSymptom {
  String get symptomId => throw _privateConstructorUsedError;

  /// Comida con la que el servidor lo asocio, si hubo alguna en la ventana.
  String? get associatedMealId => throw _privateConstructorUsedError;

  /// Lo que respondio el servidor sobre la asociacion (CA02).
  bool get hasMealAssociation => throw _privateConstructorUsedError;

  /// Create a copy of CreatedSymptom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CreatedSymptomCopyWith<CreatedSymptom> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CreatedSymptomCopyWith<$Res> {
  factory $CreatedSymptomCopyWith(
          CreatedSymptom value, $Res Function(CreatedSymptom) then) =
      _$CreatedSymptomCopyWithImpl<$Res, CreatedSymptom>;
  @useResult
  $Res call(
      {String symptomId, String? associatedMealId, bool hasMealAssociation});
}

/// @nodoc
class _$CreatedSymptomCopyWithImpl<$Res, $Val extends CreatedSymptom>
    implements $CreatedSymptomCopyWith<$Res> {
  _$CreatedSymptomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CreatedSymptom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symptomId = null,
    Object? associatedMealId = freezed,
    Object? hasMealAssociation = null,
  }) {
    return _then(_value.copyWith(
      symptomId: null == symptomId
          ? _value.symptomId
          : symptomId // ignore: cast_nullable_to_non_nullable
              as String,
      associatedMealId: freezed == associatedMealId
          ? _value.associatedMealId
          : associatedMealId // ignore: cast_nullable_to_non_nullable
              as String?,
      hasMealAssociation: null == hasMealAssociation
          ? _value.hasMealAssociation
          : hasMealAssociation // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CreatedSymptomImplCopyWith<$Res>
    implements $CreatedSymptomCopyWith<$Res> {
  factory _$$CreatedSymptomImplCopyWith(_$CreatedSymptomImpl value,
          $Res Function(_$CreatedSymptomImpl) then) =
      __$$CreatedSymptomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symptomId, String? associatedMealId, bool hasMealAssociation});
}

/// @nodoc
class __$$CreatedSymptomImplCopyWithImpl<$Res>
    extends _$CreatedSymptomCopyWithImpl<$Res, _$CreatedSymptomImpl>
    implements _$$CreatedSymptomImplCopyWith<$Res> {
  __$$CreatedSymptomImplCopyWithImpl(
      _$CreatedSymptomImpl _value, $Res Function(_$CreatedSymptomImpl) _then)
      : super(_value, _then);

  /// Create a copy of CreatedSymptom
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symptomId = null,
    Object? associatedMealId = freezed,
    Object? hasMealAssociation = null,
  }) {
    return _then(_$CreatedSymptomImpl(
      symptomId: null == symptomId
          ? _value.symptomId
          : symptomId // ignore: cast_nullable_to_non_nullable
              as String,
      associatedMealId: freezed == associatedMealId
          ? _value.associatedMealId
          : associatedMealId // ignore: cast_nullable_to_non_nullable
              as String?,
      hasMealAssociation: null == hasMealAssociation
          ? _value.hasMealAssociation
          : hasMealAssociation // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CreatedSymptomImpl extends _CreatedSymptom {
  const _$CreatedSymptomImpl(
      {required this.symptomId,
      this.associatedMealId,
      this.hasMealAssociation = false})
      : super._();

  @override
  final String symptomId;

  /// Comida con la que el servidor lo asocio, si hubo alguna en la ventana.
  @override
  final String? associatedMealId;

  /// Lo que respondio el servidor sobre la asociacion (CA02).
  @override
  @JsonKey()
  final bool hasMealAssociation;

  @override
  String toString() {
    return 'CreatedSymptom(symptomId: $symptomId, associatedMealId: $associatedMealId, hasMealAssociation: $hasMealAssociation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CreatedSymptomImpl &&
            (identical(other.symptomId, symptomId) ||
                other.symptomId == symptomId) &&
            (identical(other.associatedMealId, associatedMealId) ||
                other.associatedMealId == associatedMealId) &&
            (identical(other.hasMealAssociation, hasMealAssociation) ||
                other.hasMealAssociation == hasMealAssociation));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, symptomId, associatedMealId, hasMealAssociation);

  /// Create a copy of CreatedSymptom
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CreatedSymptomImplCopyWith<_$CreatedSymptomImpl> get copyWith =>
      __$$CreatedSymptomImplCopyWithImpl<_$CreatedSymptomImpl>(
          this, _$identity);
}

abstract class _CreatedSymptom extends CreatedSymptom {
  const factory _CreatedSymptom(
      {required final String symptomId,
      final String? associatedMealId,
      final bool hasMealAssociation}) = _$CreatedSymptomImpl;
  const _CreatedSymptom._() : super._();

  @override
  String get symptomId;

  /// Comida con la que el servidor lo asocio, si hubo alguna en la ventana.
  @override
  String? get associatedMealId;

  /// Lo que respondio el servidor sobre la asociacion (CA02).
  @override
  bool get hasMealAssociation;

  /// Create a copy of CreatedSymptom
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CreatedSymptomImplCopyWith<_$CreatedSymptomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SymptomRecord {
  String get symptomId => throw _privateConstructorUsedError;
  DateTime get occurredAt => throw _privateConstructorUsedError;
  int get intensity => throw _privateConstructorUsedError;
  String? get clientGuid => throw _privateConstructorUsedError;
  SymptomTypeOption? get symptomType => throw _privateConstructorUsedError;
  String? get associatedMealId => throw _privateConstructorUsedError;
  bool get hasMealAssociation => throw _privateConstructorUsedError;

  /// Create a copy of SymptomRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SymptomRecordCopyWith<SymptomRecord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SymptomRecordCopyWith<$Res> {
  factory $SymptomRecordCopyWith(
          SymptomRecord value, $Res Function(SymptomRecord) then) =
      _$SymptomRecordCopyWithImpl<$Res, SymptomRecord>;
  @useResult
  $Res call(
      {String symptomId,
      DateTime occurredAt,
      int intensity,
      String? clientGuid,
      SymptomTypeOption? symptomType,
      String? associatedMealId,
      bool hasMealAssociation});
}

/// @nodoc
class _$SymptomRecordCopyWithImpl<$Res, $Val extends SymptomRecord>
    implements $SymptomRecordCopyWith<$Res> {
  _$SymptomRecordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SymptomRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symptomId = null,
    Object? occurredAt = null,
    Object? intensity = null,
    Object? clientGuid = freezed,
    Object? symptomType = freezed,
    Object? associatedMealId = freezed,
    Object? hasMealAssociation = null,
  }) {
    return _then(_value.copyWith(
      symptomId: null == symptomId
          ? _value.symptomId
          : symptomId // ignore: cast_nullable_to_non_nullable
              as String,
      occurredAt: null == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int,
      clientGuid: freezed == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String?,
      symptomType: freezed == symptomType
          ? _value.symptomType
          : symptomType // ignore: cast_nullable_to_non_nullable
              as SymptomTypeOption?,
      associatedMealId: freezed == associatedMealId
          ? _value.associatedMealId
          : associatedMealId // ignore: cast_nullable_to_non_nullable
              as String?,
      hasMealAssociation: null == hasMealAssociation
          ? _value.hasMealAssociation
          : hasMealAssociation // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SymptomRecordImplCopyWith<$Res>
    implements $SymptomRecordCopyWith<$Res> {
  factory _$$SymptomRecordImplCopyWith(
          _$SymptomRecordImpl value, $Res Function(_$SymptomRecordImpl) then) =
      __$$SymptomRecordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String symptomId,
      DateTime occurredAt,
      int intensity,
      String? clientGuid,
      SymptomTypeOption? symptomType,
      String? associatedMealId,
      bool hasMealAssociation});
}

/// @nodoc
class __$$SymptomRecordImplCopyWithImpl<$Res>
    extends _$SymptomRecordCopyWithImpl<$Res, _$SymptomRecordImpl>
    implements _$$SymptomRecordImplCopyWith<$Res> {
  __$$SymptomRecordImplCopyWithImpl(
      _$SymptomRecordImpl _value, $Res Function(_$SymptomRecordImpl) _then)
      : super(_value, _then);

  /// Create a copy of SymptomRecord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symptomId = null,
    Object? occurredAt = null,
    Object? intensity = null,
    Object? clientGuid = freezed,
    Object? symptomType = freezed,
    Object? associatedMealId = freezed,
    Object? hasMealAssociation = null,
  }) {
    return _then(_$SymptomRecordImpl(
      symptomId: null == symptomId
          ? _value.symptomId
          : symptomId // ignore: cast_nullable_to_non_nullable
              as String,
      occurredAt: null == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      intensity: null == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int,
      clientGuid: freezed == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String?,
      symptomType: freezed == symptomType
          ? _value.symptomType
          : symptomType // ignore: cast_nullable_to_non_nullable
              as SymptomTypeOption?,
      associatedMealId: freezed == associatedMealId
          ? _value.associatedMealId
          : associatedMealId // ignore: cast_nullable_to_non_nullable
              as String?,
      hasMealAssociation: null == hasMealAssociation
          ? _value.hasMealAssociation
          : hasMealAssociation // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SymptomRecordImpl extends _SymptomRecord {
  const _$SymptomRecordImpl(
      {required this.symptomId,
      required this.occurredAt,
      required this.intensity,
      this.clientGuid,
      this.symptomType,
      this.associatedMealId,
      this.hasMealAssociation = false})
      : super._();

  @override
  final String symptomId;
  @override
  final DateTime occurredAt;
  @override
  final int intensity;
  @override
  final String? clientGuid;
  @override
  final SymptomTypeOption? symptomType;
  @override
  final String? associatedMealId;
  @override
  @JsonKey()
  final bool hasMealAssociation;

  @override
  String toString() {
    return 'SymptomRecord(symptomId: $symptomId, occurredAt: $occurredAt, intensity: $intensity, clientGuid: $clientGuid, symptomType: $symptomType, associatedMealId: $associatedMealId, hasMealAssociation: $hasMealAssociation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SymptomRecordImpl &&
            (identical(other.symptomId, symptomId) ||
                other.symptomId == symptomId) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.clientGuid, clientGuid) ||
                other.clientGuid == clientGuid) &&
            (identical(other.symptomType, symptomType) ||
                other.symptomType == symptomType) &&
            (identical(other.associatedMealId, associatedMealId) ||
                other.associatedMealId == associatedMealId) &&
            (identical(other.hasMealAssociation, hasMealAssociation) ||
                other.hasMealAssociation == hasMealAssociation));
  }

  @override
  int get hashCode => Object.hash(runtimeType, symptomId, occurredAt, intensity,
      clientGuid, symptomType, associatedMealId, hasMealAssociation);

  /// Create a copy of SymptomRecord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SymptomRecordImplCopyWith<_$SymptomRecordImpl> get copyWith =>
      __$$SymptomRecordImplCopyWithImpl<_$SymptomRecordImpl>(this, _$identity);
}

abstract class _SymptomRecord extends SymptomRecord {
  const factory _SymptomRecord(
      {required final String symptomId,
      required final DateTime occurredAt,
      required final int intensity,
      final String? clientGuid,
      final SymptomTypeOption? symptomType,
      final String? associatedMealId,
      final bool hasMealAssociation}) = _$SymptomRecordImpl;
  const _SymptomRecord._() : super._();

  @override
  String get symptomId;
  @override
  DateTime get occurredAt;
  @override
  int get intensity;
  @override
  String? get clientGuid;
  @override
  SymptomTypeOption? get symptomType;
  @override
  String? get associatedMealId;
  @override
  bool get hasMealAssociation;

  /// Create a copy of SymptomRecord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SymptomRecordImplCopyWith<_$SymptomRecordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SymptomHistoryPage {
  List<SymptomRecord> get items => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;

  /// Create a copy of SymptomHistoryPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SymptomHistoryPageCopyWith<SymptomHistoryPage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SymptomHistoryPageCopyWith<$Res> {
  factory $SymptomHistoryPageCopyWith(
          SymptomHistoryPage value, $Res Function(SymptomHistoryPage) then) =
      _$SymptomHistoryPageCopyWithImpl<$Res, SymptomHistoryPage>;
  @useResult
  $Res call(
      {List<SymptomRecord> items, int page, int pageSize, int totalCount});
}

/// @nodoc
class _$SymptomHistoryPageCopyWithImpl<$Res, $Val extends SymptomHistoryPage>
    implements $SymptomHistoryPageCopyWith<$Res> {
  _$SymptomHistoryPageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SymptomHistoryPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? pageSize = null,
    Object? totalCount = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SymptomRecord>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SymptomHistoryPageImplCopyWith<$Res>
    implements $SymptomHistoryPageCopyWith<$Res> {
  factory _$$SymptomHistoryPageImplCopyWith(_$SymptomHistoryPageImpl value,
          $Res Function(_$SymptomHistoryPageImpl) then) =
      __$$SymptomHistoryPageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SymptomRecord> items, int page, int pageSize, int totalCount});
}

/// @nodoc
class __$$SymptomHistoryPageImplCopyWithImpl<$Res>
    extends _$SymptomHistoryPageCopyWithImpl<$Res, _$SymptomHistoryPageImpl>
    implements _$$SymptomHistoryPageImplCopyWith<$Res> {
  __$$SymptomHistoryPageImplCopyWithImpl(_$SymptomHistoryPageImpl _value,
      $Res Function(_$SymptomHistoryPageImpl) _then)
      : super(_value, _then);

  /// Create a copy of SymptomHistoryPage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? page = null,
    Object? pageSize = null,
    Object? totalCount = null,
  }) {
    return _then(_$SymptomHistoryPageImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<SymptomRecord>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      pageSize: null == pageSize
          ? _value.pageSize
          : pageSize // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$SymptomHistoryPageImpl extends _SymptomHistoryPage {
  const _$SymptomHistoryPageImpl(
      {final List<SymptomRecord> items = const <SymptomRecord>[],
      this.page = 1,
      this.pageSize = 50,
      this.totalCount = 0})
      : _items = items,
        super._();

  final List<SymptomRecord> _items;
  @override
  @JsonKey()
  List<SymptomRecord> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  @JsonKey()
  final int page;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final int totalCount;

  @override
  String toString() {
    return 'SymptomHistoryPage(items: $items, page: $page, pageSize: $pageSize, totalCount: $totalCount)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SymptomHistoryPageImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_items), page, pageSize, totalCount);

  /// Create a copy of SymptomHistoryPage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SymptomHistoryPageImplCopyWith<_$SymptomHistoryPageImpl> get copyWith =>
      __$$SymptomHistoryPageImplCopyWithImpl<_$SymptomHistoryPageImpl>(
          this, _$identity);
}

abstract class _SymptomHistoryPage extends SymptomHistoryPage {
  const factory _SymptomHistoryPage(
      {final List<SymptomRecord> items,
      final int page,
      final int pageSize,
      final int totalCount}) = _$SymptomHistoryPageImpl;
  const _SymptomHistoryPage._() : super._();

  @override
  List<SymptomRecord> get items;
  @override
  int get page;
  @override
  int get pageSize;
  @override
  int get totalCount;

  /// Create a copy of SymptomHistoryPage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SymptomHistoryPageImplCopyWith<_$SymptomHistoryPageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
