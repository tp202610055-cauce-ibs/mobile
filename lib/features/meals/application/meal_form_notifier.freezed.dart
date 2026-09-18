// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'meal_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$MealFormState {
  MealDraft get draft => throw _privateConstructorUsedError;
  bool get submitting => throw _privateConstructorUsedError;

  /// Resultado del ultimo envio, o `null` si todavia no se envio.
  MealSubmitOutcome? get outcome => throw _privateConstructorUsedError;

  /// Carga FODMAP que devolvio el servidor, cuando hubo conexion.
  FodmapLoad? get aggregatedFodmap => throw _privateConstructorUsedError;
  CauceApiError? get error => throw _privateConstructorUsedError;

  /// Create a copy of MealFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MealFormStateCopyWith<MealFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MealFormStateCopyWith<$Res> {
  factory $MealFormStateCopyWith(
          MealFormState value, $Res Function(MealFormState) then) =
      _$MealFormStateCopyWithImpl<$Res, MealFormState>;
  @useResult
  $Res call(
      {MealDraft draft,
      bool submitting,
      MealSubmitOutcome? outcome,
      FodmapLoad? aggregatedFodmap,
      CauceApiError? error});

  $MealDraftCopyWith<$Res> get draft;
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$MealFormStateCopyWithImpl<$Res, $Val extends MealFormState>
    implements $MealFormStateCopyWith<$Res> {
  _$MealFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MealFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? submitting = null,
    Object? outcome = freezed,
    Object? aggregatedFodmap = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as MealDraft,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      outcome: freezed == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as MealSubmitOutcome?,
      aggregatedFodmap: freezed == aggregatedFodmap
          ? _value.aggregatedFodmap
          : aggregatedFodmap // ignore: cast_nullable_to_non_nullable
              as FodmapLoad?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ) as $Val);
  }

  /// Create a copy of MealFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MealDraftCopyWith<$Res> get draft {
    return $MealDraftCopyWith<$Res>(_value.draft, (value) {
      return _then(_value.copyWith(draft: value) as $Val);
    });
  }

  /// Create a copy of MealFormState
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
abstract class _$$MealFormStateImplCopyWith<$Res>
    implements $MealFormStateCopyWith<$Res> {
  factory _$$MealFormStateImplCopyWith(
          _$MealFormStateImpl value, $Res Function(_$MealFormStateImpl) then) =
      __$$MealFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {MealDraft draft,
      bool submitting,
      MealSubmitOutcome? outcome,
      FodmapLoad? aggregatedFodmap,
      CauceApiError? error});

  @override
  $MealDraftCopyWith<$Res> get draft;
  @override
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$MealFormStateImplCopyWithImpl<$Res>
    extends _$MealFormStateCopyWithImpl<$Res, _$MealFormStateImpl>
    implements _$$MealFormStateImplCopyWith<$Res> {
  __$$MealFormStateImplCopyWithImpl(
      _$MealFormStateImpl _value, $Res Function(_$MealFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of MealFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? submitting = null,
    Object? outcome = freezed,
    Object? aggregatedFodmap = freezed,
    Object? error = freezed,
  }) {
    return _then(_$MealFormStateImpl(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as MealDraft,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      outcome: freezed == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as MealSubmitOutcome?,
      aggregatedFodmap: freezed == aggregatedFodmap
          ? _value.aggregatedFodmap
          : aggregatedFodmap // ignore: cast_nullable_to_non_nullable
              as FodmapLoad?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ));
  }
}

/// @nodoc

class _$MealFormStateImpl extends _MealFormState {
  const _$MealFormStateImpl(
      {this.draft = const MealDraft(),
      this.submitting = false,
      this.outcome,
      this.aggregatedFodmap,
      this.error})
      : super._();

  @override
  @JsonKey()
  final MealDraft draft;
  @override
  @JsonKey()
  final bool submitting;

  /// Resultado del ultimo envio, o `null` si todavia no se envio.
  @override
  final MealSubmitOutcome? outcome;

  /// Carga FODMAP que devolvio el servidor, cuando hubo conexion.
  @override
  final FodmapLoad? aggregatedFodmap;
  @override
  final CauceApiError? error;

  @override
  String toString() {
    return 'MealFormState(draft: $draft, submitting: $submitting, outcome: $outcome, aggregatedFodmap: $aggregatedFodmap, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MealFormStateImpl &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            (identical(other.aggregatedFodmap, aggregatedFodmap) ||
                other.aggregatedFodmap == aggregatedFodmap) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, draft, submitting, outcome, aggregatedFodmap, error);

  /// Create a copy of MealFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MealFormStateImplCopyWith<_$MealFormStateImpl> get copyWith =>
      __$$MealFormStateImplCopyWithImpl<_$MealFormStateImpl>(this, _$identity);
}

abstract class _MealFormState extends MealFormState {
  const factory _MealFormState(
      {final MealDraft draft,
      final bool submitting,
      final MealSubmitOutcome? outcome,
      final FodmapLoad? aggregatedFodmap,
      final CauceApiError? error}) = _$MealFormStateImpl;
  const _MealFormState._() : super._();

  @override
  MealDraft get draft;
  @override
  bool get submitting;

  /// Resultado del ultimo envio, o `null` si todavia no se envio.
  @override
  MealSubmitOutcome? get outcome;

  /// Carga FODMAP que devolvio el servidor, cuando hubo conexion.
  @override
  FodmapLoad? get aggregatedFodmap;
  @override
  CauceApiError? get error;

  /// Create a copy of MealFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MealFormStateImplCopyWith<_$MealFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
