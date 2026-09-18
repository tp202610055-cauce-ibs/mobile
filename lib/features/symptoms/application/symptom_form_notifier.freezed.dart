// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'symptom_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SymptomFormState {
  SymptomDraft get draft => throw _privateConstructorUsedError;
  bool get submitting => throw _privateConstructorUsedError;
  SymptomSubmitOutcome? get outcome => throw _privateConstructorUsedError;

  /// Lo que el servidor confirmo sobre la ventana de 4 horas, disponible
  /// recien tras el envio con conexion.
  CreatedSymptom? get result => throw _privateConstructorUsedError;
  CauceApiError? get error => throw _privateConstructorUsedError;

  /// Create a copy of SymptomFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SymptomFormStateCopyWith<SymptomFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SymptomFormStateCopyWith<$Res> {
  factory $SymptomFormStateCopyWith(
          SymptomFormState value, $Res Function(SymptomFormState) then) =
      _$SymptomFormStateCopyWithImpl<$Res, SymptomFormState>;
  @useResult
  $Res call(
      {SymptomDraft draft,
      bool submitting,
      SymptomSubmitOutcome? outcome,
      CreatedSymptom? result,
      CauceApiError? error});

  $SymptomDraftCopyWith<$Res> get draft;
  $CreatedSymptomCopyWith<$Res>? get result;
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$SymptomFormStateCopyWithImpl<$Res, $Val extends SymptomFormState>
    implements $SymptomFormStateCopyWith<$Res> {
  _$SymptomFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SymptomFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? submitting = null,
    Object? outcome = freezed,
    Object? result = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as SymptomDraft,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      outcome: freezed == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as SymptomSubmitOutcome?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as CreatedSymptom?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ) as $Val);
  }

  /// Create a copy of SymptomFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SymptomDraftCopyWith<$Res> get draft {
    return $SymptomDraftCopyWith<$Res>(_value.draft, (value) {
      return _then(_value.copyWith(draft: value) as $Val);
    });
  }

  /// Create a copy of SymptomFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CreatedSymptomCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $CreatedSymptomCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }

  /// Create a copy of SymptomFormState
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
abstract class _$$SymptomFormStateImplCopyWith<$Res>
    implements $SymptomFormStateCopyWith<$Res> {
  factory _$$SymptomFormStateImplCopyWith(_$SymptomFormStateImpl value,
          $Res Function(_$SymptomFormStateImpl) then) =
      __$$SymptomFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {SymptomDraft draft,
      bool submitting,
      SymptomSubmitOutcome? outcome,
      CreatedSymptom? result,
      CauceApiError? error});

  @override
  $SymptomDraftCopyWith<$Res> get draft;
  @override
  $CreatedSymptomCopyWith<$Res>? get result;
  @override
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$SymptomFormStateImplCopyWithImpl<$Res>
    extends _$SymptomFormStateCopyWithImpl<$Res, _$SymptomFormStateImpl>
    implements _$$SymptomFormStateImplCopyWith<$Res> {
  __$$SymptomFormStateImplCopyWithImpl(_$SymptomFormStateImpl _value,
      $Res Function(_$SymptomFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SymptomFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? submitting = null,
    Object? outcome = freezed,
    Object? result = freezed,
    Object? error = freezed,
  }) {
    return _then(_$SymptomFormStateImpl(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as SymptomDraft,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      outcome: freezed == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as SymptomSubmitOutcome?,
      result: freezed == result
          ? _value.result
          : result // ignore: cast_nullable_to_non_nullable
              as CreatedSymptom?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ));
  }
}

/// @nodoc

class _$SymptomFormStateImpl extends _SymptomFormState {
  const _$SymptomFormStateImpl(
      {this.draft = const SymptomDraft(),
      this.submitting = false,
      this.outcome,
      this.result,
      this.error})
      : super._();

  @override
  @JsonKey()
  final SymptomDraft draft;
  @override
  @JsonKey()
  final bool submitting;
  @override
  final SymptomSubmitOutcome? outcome;

  /// Lo que el servidor confirmo sobre la ventana de 4 horas, disponible
  /// recien tras el envio con conexion.
  @override
  final CreatedSymptom? result;
  @override
  final CauceApiError? error;

  @override
  String toString() {
    return 'SymptomFormState(draft: $draft, submitting: $submitting, outcome: $outcome, result: $result, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SymptomFormStateImpl &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, draft, submitting, outcome, result, error);

  /// Create a copy of SymptomFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SymptomFormStateImplCopyWith<_$SymptomFormStateImpl> get copyWith =>
      __$$SymptomFormStateImplCopyWithImpl<_$SymptomFormStateImpl>(
          this, _$identity);
}

abstract class _SymptomFormState extends SymptomFormState {
  const factory _SymptomFormState(
      {final SymptomDraft draft,
      final bool submitting,
      final SymptomSubmitOutcome? outcome,
      final CreatedSymptom? result,
      final CauceApiError? error}) = _$SymptomFormStateImpl;
  const _SymptomFormState._() : super._();

  @override
  SymptomDraft get draft;
  @override
  bool get submitting;
  @override
  SymptomSubmitOutcome? get outcome;

  /// Lo que el servidor confirmo sobre la ventana de 4 horas, disponible
  /// recien tras el envio con conexion.
  @override
  CreatedSymptom? get result;
  @override
  CauceApiError? get error;

  /// Create a copy of SymptomFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SymptomFormStateImplCopyWith<_$SymptomFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
