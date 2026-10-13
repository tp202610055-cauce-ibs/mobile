// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_journal_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TodayJournalState {
  int get meals => throw _privateConstructorUsedError;
  int get symptoms => throw _privateConstructorUsedError;

  /// Create a copy of TodayJournalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TodayJournalStateCopyWith<TodayJournalState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodayJournalStateCopyWith<$Res> {
  factory $TodayJournalStateCopyWith(
          TodayJournalState value, $Res Function(TodayJournalState) then) =
      _$TodayJournalStateCopyWithImpl<$Res, TodayJournalState>;
  @useResult
  $Res call({int meals, int symptoms});
}

/// @nodoc
class _$TodayJournalStateCopyWithImpl<$Res, $Val extends TodayJournalState>
    implements $TodayJournalStateCopyWith<$Res> {
  _$TodayJournalStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TodayJournalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meals = null,
    Object? symptoms = null,
  }) {
    return _then(_value.copyWith(
      meals: null == meals
          ? _value.meals
          : meals // ignore: cast_nullable_to_non_nullable
              as int,
      symptoms: null == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TodayJournalStateImplCopyWith<$Res>
    implements $TodayJournalStateCopyWith<$Res> {
  factory _$$TodayJournalStateImplCopyWith(_$TodayJournalStateImpl value,
          $Res Function(_$TodayJournalStateImpl) then) =
      __$$TodayJournalStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int meals, int symptoms});
}

/// @nodoc
class __$$TodayJournalStateImplCopyWithImpl<$Res>
    extends _$TodayJournalStateCopyWithImpl<$Res, _$TodayJournalStateImpl>
    implements _$$TodayJournalStateImplCopyWith<$Res> {
  __$$TodayJournalStateImplCopyWithImpl(_$TodayJournalStateImpl _value,
      $Res Function(_$TodayJournalStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TodayJournalState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meals = null,
    Object? symptoms = null,
  }) {
    return _then(_$TodayJournalStateImpl(
      meals: null == meals
          ? _value.meals
          : meals // ignore: cast_nullable_to_non_nullable
              as int,
      symptoms: null == symptoms
          ? _value.symptoms
          : symptoms // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _$TodayJournalStateImpl extends _TodayJournalState {
  const _$TodayJournalStateImpl({this.meals = 0, this.symptoms = 0})
      : super._();

  @override
  @JsonKey()
  final int meals;
  @override
  @JsonKey()
  final int symptoms;

  @override
  String toString() {
    return 'TodayJournalState(meals: $meals, symptoms: $symptoms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TodayJournalStateImpl &&
            (identical(other.meals, meals) || other.meals == meals) &&
            (identical(other.symptoms, symptoms) ||
                other.symptoms == symptoms));
  }

  @override
  int get hashCode => Object.hash(runtimeType, meals, symptoms);

  /// Create a copy of TodayJournalState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TodayJournalStateImplCopyWith<_$TodayJournalStateImpl> get copyWith =>
      __$$TodayJournalStateImplCopyWithImpl<_$TodayJournalStateImpl>(
          this, _$identity);
}

abstract class _TodayJournalState extends TodayJournalState {
  const factory _TodayJournalState({final int meals, final int symptoms}) =
      _$TodayJournalStateImpl;
  const _TodayJournalState._() : super._();

  @override
  int get meals;
  @override
  int get symptoms;

  /// Create a copy of TodayJournalState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TodayJournalStateImplCopyWith<_$TodayJournalStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
