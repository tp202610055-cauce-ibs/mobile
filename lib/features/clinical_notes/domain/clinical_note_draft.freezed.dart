// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinical_note_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClinicalNoteDraft {
  String get content => throw _privateConstructorUsedError;
  String? get mealId => throw _privateConstructorUsedError;
  String? get symptomId => throw _privateConstructorUsedError;

  /// Create a copy of ClinicalNoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicalNoteDraftCopyWith<ClinicalNoteDraft> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicalNoteDraftCopyWith<$Res> {
  factory $ClinicalNoteDraftCopyWith(
          ClinicalNoteDraft value, $Res Function(ClinicalNoteDraft) then) =
      _$ClinicalNoteDraftCopyWithImpl<$Res, ClinicalNoteDraft>;
  @useResult
  $Res call({String content, String? mealId, String? symptomId});
}

/// @nodoc
class _$ClinicalNoteDraftCopyWithImpl<$Res, $Val extends ClinicalNoteDraft>
    implements $ClinicalNoteDraftCopyWith<$Res> {
  _$ClinicalNoteDraftCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicalNoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? mealId = freezed,
    Object? symptomId = freezed,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: freezed == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String?,
      symptomId: freezed == symptomId
          ? _value.symptomId
          : symptomId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ClinicalNoteDraftImplCopyWith<$Res>
    implements $ClinicalNoteDraftCopyWith<$Res> {
  factory _$$ClinicalNoteDraftImplCopyWith(_$ClinicalNoteDraftImpl value,
          $Res Function(_$ClinicalNoteDraftImpl) then) =
      __$$ClinicalNoteDraftImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content, String? mealId, String? symptomId});
}

/// @nodoc
class __$$ClinicalNoteDraftImplCopyWithImpl<$Res>
    extends _$ClinicalNoteDraftCopyWithImpl<$Res, _$ClinicalNoteDraftImpl>
    implements _$$ClinicalNoteDraftImplCopyWith<$Res> {
  __$$ClinicalNoteDraftImplCopyWithImpl(_$ClinicalNoteDraftImpl _value,
      $Res Function(_$ClinicalNoteDraftImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicalNoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? mealId = freezed,
    Object? symptomId = freezed,
  }) {
    return _then(_$ClinicalNoteDraftImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      mealId: freezed == mealId
          ? _value.mealId
          : mealId // ignore: cast_nullable_to_non_nullable
              as String?,
      symptomId: freezed == symptomId
          ? _value.symptomId
          : symptomId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$ClinicalNoteDraftImpl extends _ClinicalNoteDraft {
  const _$ClinicalNoteDraftImpl(
      {this.content = '', this.mealId, this.symptomId})
      : super._();

  @override
  @JsonKey()
  final String content;
  @override
  final String? mealId;
  @override
  final String? symptomId;

  @override
  String toString() {
    return 'ClinicalNoteDraft(content: $content, mealId: $mealId, symptomId: $symptomId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicalNoteDraftImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.mealId, mealId) || other.mealId == mealId) &&
            (identical(other.symptomId, symptomId) ||
                other.symptomId == symptomId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, mealId, symptomId);

  /// Create a copy of ClinicalNoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicalNoteDraftImplCopyWith<_$ClinicalNoteDraftImpl> get copyWith =>
      __$$ClinicalNoteDraftImplCopyWithImpl<_$ClinicalNoteDraftImpl>(
          this, _$identity);
}

abstract class _ClinicalNoteDraft extends ClinicalNoteDraft {
  const factory _ClinicalNoteDraft(
      {final String content,
      final String? mealId,
      final String? symptomId}) = _$ClinicalNoteDraftImpl;
  const _ClinicalNoteDraft._() : super._();

  @override
  String get content;
  @override
  String? get mealId;
  @override
  String? get symptomId;

  /// Create a copy of ClinicalNoteDraft
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicalNoteDraftImplCopyWith<_$ClinicalNoteDraftImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
