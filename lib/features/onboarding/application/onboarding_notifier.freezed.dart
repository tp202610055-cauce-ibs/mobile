// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$OnboardingState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OnboardingStep step) pending,
    required TResult Function(OnboardingStep step) deferred,
    required TResult Function() completed,
    required TResult Function() unavailable,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OnboardingStep step)? pending,
    TResult? Function(OnboardingStep step)? deferred,
    TResult? Function()? completed,
    TResult? Function()? unavailable,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OnboardingStep step)? pending,
    TResult Function(OnboardingStep step)? deferred,
    TResult Function()? completed,
    TResult Function()? unavailable,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OnboardingPending value) pending,
    required TResult Function(OnboardingDeferred value) deferred,
    required TResult Function(OnboardingCompleted value) completed,
    required TResult Function(OnboardingUnavailable value) unavailable,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OnboardingPending value)? pending,
    TResult? Function(OnboardingDeferred value)? deferred,
    TResult? Function(OnboardingCompleted value)? completed,
    TResult? Function(OnboardingUnavailable value)? unavailable,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OnboardingPending value)? pending,
    TResult Function(OnboardingDeferred value)? deferred,
    TResult Function(OnboardingCompleted value)? completed,
    TResult Function(OnboardingUnavailable value)? unavailable,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnboardingStateCopyWith<$Res> {
  factory $OnboardingStateCopyWith(
          OnboardingState value, $Res Function(OnboardingState) then) =
      _$OnboardingStateCopyWithImpl<$Res, OnboardingState>;
}

/// @nodoc
class _$OnboardingStateCopyWithImpl<$Res, $Val extends OnboardingState>
    implements $OnboardingStateCopyWith<$Res> {
  _$OnboardingStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$OnboardingPendingImplCopyWith<$Res> {
  factory _$$OnboardingPendingImplCopyWith(_$OnboardingPendingImpl value,
          $Res Function(_$OnboardingPendingImpl) then) =
      __$$OnboardingPendingImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OnboardingStep step});
}

/// @nodoc
class __$$OnboardingPendingImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$OnboardingPendingImpl>
    implements _$$OnboardingPendingImplCopyWith<$Res> {
  __$$OnboardingPendingImplCopyWithImpl(_$OnboardingPendingImpl _value,
      $Res Function(_$OnboardingPendingImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
  }) {
    return _then(_$OnboardingPendingImpl(
      null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as OnboardingStep,
    ));
  }
}

/// @nodoc

class _$OnboardingPendingImpl extends OnboardingPending {
  const _$OnboardingPendingImpl(this.step) : super._();

  @override
  final OnboardingStep step;

  @override
  String toString() {
    return 'OnboardingState.pending(step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingPendingImpl &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, step);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingPendingImplCopyWith<_$OnboardingPendingImpl> get copyWith =>
      __$$OnboardingPendingImplCopyWithImpl<_$OnboardingPendingImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OnboardingStep step) pending,
    required TResult Function(OnboardingStep step) deferred,
    required TResult Function() completed,
    required TResult Function() unavailable,
  }) {
    return pending(step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OnboardingStep step)? pending,
    TResult? Function(OnboardingStep step)? deferred,
    TResult? Function()? completed,
    TResult? Function()? unavailable,
  }) {
    return pending?.call(step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OnboardingStep step)? pending,
    TResult Function(OnboardingStep step)? deferred,
    TResult Function()? completed,
    TResult Function()? unavailable,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending(step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OnboardingPending value) pending,
    required TResult Function(OnboardingDeferred value) deferred,
    required TResult Function(OnboardingCompleted value) completed,
    required TResult Function(OnboardingUnavailable value) unavailable,
  }) {
    return pending(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OnboardingPending value)? pending,
    TResult? Function(OnboardingDeferred value)? deferred,
    TResult? Function(OnboardingCompleted value)? completed,
    TResult? Function(OnboardingUnavailable value)? unavailable,
  }) {
    return pending?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OnboardingPending value)? pending,
    TResult Function(OnboardingDeferred value)? deferred,
    TResult Function(OnboardingCompleted value)? completed,
    TResult Function(OnboardingUnavailable value)? unavailable,
    required TResult orElse(),
  }) {
    if (pending != null) {
      return pending(this);
    }
    return orElse();
  }
}

abstract class OnboardingPending extends OnboardingState {
  const factory OnboardingPending(final OnboardingStep step) =
      _$OnboardingPendingImpl;
  const OnboardingPending._() : super._();

  OnboardingStep get step;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingPendingImplCopyWith<_$OnboardingPendingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnboardingDeferredImplCopyWith<$Res> {
  factory _$$OnboardingDeferredImplCopyWith(_$OnboardingDeferredImpl value,
          $Res Function(_$OnboardingDeferredImpl) then) =
      __$$OnboardingDeferredImplCopyWithImpl<$Res>;
  @useResult
  $Res call({OnboardingStep step});
}

/// @nodoc
class __$$OnboardingDeferredImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$OnboardingDeferredImpl>
    implements _$$OnboardingDeferredImplCopyWith<$Res> {
  __$$OnboardingDeferredImplCopyWithImpl(_$OnboardingDeferredImpl _value,
      $Res Function(_$OnboardingDeferredImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? step = null,
  }) {
    return _then(_$OnboardingDeferredImpl(
      null == step
          ? _value.step
          : step // ignore: cast_nullable_to_non_nullable
              as OnboardingStep,
    ));
  }
}

/// @nodoc

class _$OnboardingDeferredImpl extends OnboardingDeferred {
  const _$OnboardingDeferredImpl(this.step) : super._();

  @override
  final OnboardingStep step;

  @override
  String toString() {
    return 'OnboardingState.deferred(step: $step)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingDeferredImpl &&
            (identical(other.step, step) || other.step == step));
  }

  @override
  int get hashCode => Object.hash(runtimeType, step);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OnboardingDeferredImplCopyWith<_$OnboardingDeferredImpl> get copyWith =>
      __$$OnboardingDeferredImplCopyWithImpl<_$OnboardingDeferredImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OnboardingStep step) pending,
    required TResult Function(OnboardingStep step) deferred,
    required TResult Function() completed,
    required TResult Function() unavailable,
  }) {
    return deferred(step);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OnboardingStep step)? pending,
    TResult? Function(OnboardingStep step)? deferred,
    TResult? Function()? completed,
    TResult? Function()? unavailable,
  }) {
    return deferred?.call(step);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OnboardingStep step)? pending,
    TResult Function(OnboardingStep step)? deferred,
    TResult Function()? completed,
    TResult Function()? unavailable,
    required TResult orElse(),
  }) {
    if (deferred != null) {
      return deferred(step);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OnboardingPending value) pending,
    required TResult Function(OnboardingDeferred value) deferred,
    required TResult Function(OnboardingCompleted value) completed,
    required TResult Function(OnboardingUnavailable value) unavailable,
  }) {
    return deferred(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OnboardingPending value)? pending,
    TResult? Function(OnboardingDeferred value)? deferred,
    TResult? Function(OnboardingCompleted value)? completed,
    TResult? Function(OnboardingUnavailable value)? unavailable,
  }) {
    return deferred?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OnboardingPending value)? pending,
    TResult Function(OnboardingDeferred value)? deferred,
    TResult Function(OnboardingCompleted value)? completed,
    TResult Function(OnboardingUnavailable value)? unavailable,
    required TResult orElse(),
  }) {
    if (deferred != null) {
      return deferred(this);
    }
    return orElse();
  }
}

abstract class OnboardingDeferred extends OnboardingState {
  const factory OnboardingDeferred(final OnboardingStep step) =
      _$OnboardingDeferredImpl;
  const OnboardingDeferred._() : super._();

  OnboardingStep get step;

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OnboardingDeferredImplCopyWith<_$OnboardingDeferredImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$OnboardingCompletedImplCopyWith<$Res> {
  factory _$$OnboardingCompletedImplCopyWith(_$OnboardingCompletedImpl value,
          $Res Function(_$OnboardingCompletedImpl) then) =
      __$$OnboardingCompletedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnboardingCompletedImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$OnboardingCompletedImpl>
    implements _$$OnboardingCompletedImplCopyWith<$Res> {
  __$$OnboardingCompletedImplCopyWithImpl(_$OnboardingCompletedImpl _value,
      $Res Function(_$OnboardingCompletedImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OnboardingCompletedImpl extends OnboardingCompleted {
  const _$OnboardingCompletedImpl() : super._();

  @override
  String toString() {
    return 'OnboardingState.completed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingCompletedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OnboardingStep step) pending,
    required TResult Function(OnboardingStep step) deferred,
    required TResult Function() completed,
    required TResult Function() unavailable,
  }) {
    return completed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OnboardingStep step)? pending,
    TResult? Function(OnboardingStep step)? deferred,
    TResult? Function()? completed,
    TResult? Function()? unavailable,
  }) {
    return completed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OnboardingStep step)? pending,
    TResult Function(OnboardingStep step)? deferred,
    TResult Function()? completed,
    TResult Function()? unavailable,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OnboardingPending value) pending,
    required TResult Function(OnboardingDeferred value) deferred,
    required TResult Function(OnboardingCompleted value) completed,
    required TResult Function(OnboardingUnavailable value) unavailable,
  }) {
    return completed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OnboardingPending value)? pending,
    TResult? Function(OnboardingDeferred value)? deferred,
    TResult? Function(OnboardingCompleted value)? completed,
    TResult? Function(OnboardingUnavailable value)? unavailable,
  }) {
    return completed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OnboardingPending value)? pending,
    TResult Function(OnboardingDeferred value)? deferred,
    TResult Function(OnboardingCompleted value)? completed,
    TResult Function(OnboardingUnavailable value)? unavailable,
    required TResult orElse(),
  }) {
    if (completed != null) {
      return completed(this);
    }
    return orElse();
  }
}

abstract class OnboardingCompleted extends OnboardingState {
  const factory OnboardingCompleted() = _$OnboardingCompletedImpl;
  const OnboardingCompleted._() : super._();
}

/// @nodoc
abstract class _$$OnboardingUnavailableImplCopyWith<$Res> {
  factory _$$OnboardingUnavailableImplCopyWith(
          _$OnboardingUnavailableImpl value,
          $Res Function(_$OnboardingUnavailableImpl) then) =
      __$$OnboardingUnavailableImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$OnboardingUnavailableImplCopyWithImpl<$Res>
    extends _$OnboardingStateCopyWithImpl<$Res, _$OnboardingUnavailableImpl>
    implements _$$OnboardingUnavailableImplCopyWith<$Res> {
  __$$OnboardingUnavailableImplCopyWithImpl(_$OnboardingUnavailableImpl _value,
      $Res Function(_$OnboardingUnavailableImpl) _then)
      : super(_value, _then);

  /// Create a copy of OnboardingState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$OnboardingUnavailableImpl extends OnboardingUnavailable {
  const _$OnboardingUnavailableImpl() : super._();

  @override
  String toString() {
    return 'OnboardingState.unavailable()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnboardingUnavailableImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(OnboardingStep step) pending,
    required TResult Function(OnboardingStep step) deferred,
    required TResult Function() completed,
    required TResult Function() unavailable,
  }) {
    return unavailable();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(OnboardingStep step)? pending,
    TResult? Function(OnboardingStep step)? deferred,
    TResult? Function()? completed,
    TResult? Function()? unavailable,
  }) {
    return unavailable?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(OnboardingStep step)? pending,
    TResult Function(OnboardingStep step)? deferred,
    TResult Function()? completed,
    TResult Function()? unavailable,
    required TResult orElse(),
  }) {
    if (unavailable != null) {
      return unavailable();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(OnboardingPending value) pending,
    required TResult Function(OnboardingDeferred value) deferred,
    required TResult Function(OnboardingCompleted value) completed,
    required TResult Function(OnboardingUnavailable value) unavailable,
  }) {
    return unavailable(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(OnboardingPending value)? pending,
    TResult? Function(OnboardingDeferred value)? deferred,
    TResult? Function(OnboardingCompleted value)? completed,
    TResult? Function(OnboardingUnavailable value)? unavailable,
  }) {
    return unavailable?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(OnboardingPending value)? pending,
    TResult Function(OnboardingDeferred value)? deferred,
    TResult Function(OnboardingCompleted value)? completed,
    TResult Function(OnboardingUnavailable value)? unavailable,
    required TResult orElse(),
  }) {
    if (unavailable != null) {
      return unavailable(this);
    }
    return orElse();
  }
}

abstract class OnboardingUnavailable extends OnboardingState {
  const factory OnboardingUnavailable() = _$OnboardingUnavailableImpl;
  const OnboardingUnavailable._() : super._();
}
