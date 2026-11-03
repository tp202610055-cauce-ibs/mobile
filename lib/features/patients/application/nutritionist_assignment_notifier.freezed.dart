// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'nutritionist_assignment_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$NutritionistAssignmentState {
  bool get submitting => throw _privateConstructorUsedError;
  NutritionistAssignment? get assignment => throw _privateConstructorUsedError;
  CauceApiError? get error => throw _privateConstructorUsedError;

  /// Create a copy of NutritionistAssignmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NutritionistAssignmentStateCopyWith<NutritionistAssignmentState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NutritionistAssignmentStateCopyWith<$Res> {
  factory $NutritionistAssignmentStateCopyWith(
          NutritionistAssignmentState value,
          $Res Function(NutritionistAssignmentState) then) =
      _$NutritionistAssignmentStateCopyWithImpl<$Res,
          NutritionistAssignmentState>;
  @useResult
  $Res call(
      {bool submitting,
      NutritionistAssignment? assignment,
      CauceApiError? error});

  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$NutritionistAssignmentStateCopyWithImpl<$Res,
        $Val extends NutritionistAssignmentState>
    implements $NutritionistAssignmentStateCopyWith<$Res> {
  _$NutritionistAssignmentStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NutritionistAssignmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submitting = null,
    Object? assignment = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      assignment: freezed == assignment
          ? _value.assignment
          : assignment // ignore: cast_nullable_to_non_nullable
              as NutritionistAssignment?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ) as $Val);
  }

  /// Create a copy of NutritionistAssignmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CauceApiErrorCopyWith<$Res>? get error {
    if (_value.error == null) {
      return null;
    }

    return $CauceApiErrorCopyWith<$Res>(_value.error!, (value) {
      return _then(_value.copyWith(error: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$NutritionistAssignmentStateImplCopyWith<$Res>
    implements $NutritionistAssignmentStateCopyWith<$Res> {
  factory _$$NutritionistAssignmentStateImplCopyWith(
          _$NutritionistAssignmentStateImpl value,
          $Res Function(_$NutritionistAssignmentStateImpl) then) =
      __$$NutritionistAssignmentStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool submitting,
      NutritionistAssignment? assignment,
      CauceApiError? error});

  @override
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$NutritionistAssignmentStateImplCopyWithImpl<$Res>
    extends _$NutritionistAssignmentStateCopyWithImpl<$Res,
        _$NutritionistAssignmentStateImpl>
    implements _$$NutritionistAssignmentStateImplCopyWith<$Res> {
  __$$NutritionistAssignmentStateImplCopyWithImpl(
      _$NutritionistAssignmentStateImpl _value,
      $Res Function(_$NutritionistAssignmentStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of NutritionistAssignmentState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? submitting = null,
    Object? assignment = freezed,
    Object? error = freezed,
  }) {
    return _then(_$NutritionistAssignmentStateImpl(
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      assignment: freezed == assignment
          ? _value.assignment
          : assignment // ignore: cast_nullable_to_non_nullable
              as NutritionistAssignment?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ));
  }
}

/// @nodoc

class _$NutritionistAssignmentStateImpl
    implements _NutritionistAssignmentState {
  const _$NutritionistAssignmentStateImpl(
      {this.submitting = false, this.assignment, this.error});

  @override
  @JsonKey()
  final bool submitting;
  @override
  final NutritionistAssignment? assignment;
  @override
  final CauceApiError? error;

  @override
  String toString() {
    return 'NutritionistAssignmentState(submitting: $submitting, assignment: $assignment, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NutritionistAssignmentStateImpl &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.assignment, assignment) ||
                other.assignment == assignment) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, submitting, assignment, error);

  /// Create a copy of NutritionistAssignmentState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NutritionistAssignmentStateImplCopyWith<_$NutritionistAssignmentStateImpl>
      get copyWith => __$$NutritionistAssignmentStateImplCopyWithImpl<
          _$NutritionistAssignmentStateImpl>(this, _$identity);
}

abstract class _NutritionistAssignmentState
    implements NutritionistAssignmentState {
  const factory _NutritionistAssignmentState(
      {final bool submitting,
      final NutritionistAssignment? assignment,
      final CauceApiError? error}) = _$NutritionistAssignmentStateImpl;

  @override
  bool get submitting;
  @override
  NutritionistAssignment? get assignment;
  @override
  CauceApiError? get error;

  /// Create a copy of NutritionistAssignmentState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NutritionistAssignmentStateImplCopyWith<_$NutritionistAssignmentStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
