// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendation_feedback_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecommendationFeedbackFormState {
  RecommendationFeedbackDraft get draft => throw _privateConstructorUsedError;
  bool get submitting => throw _privateConstructorUsedError;
  bool get sent => throw _privateConstructorUsedError;

  /// `Idempotency-Key` del intento en curso. Se conserva ante un fallo para
  /// que el reintento de la misma respuesta la repita, y se descarta en
  /// cuanto el paciente cambia algo: la misma clave con otra carga daria
  /// 409 `idempotency_mismatch`.
  String? get pendingKey => throw _privateConstructorUsedError;
  CauceApiError? get error => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationFeedbackFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationFeedbackFormStateCopyWith<RecommendationFeedbackFormState>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationFeedbackFormStateCopyWith<$Res> {
  factory $RecommendationFeedbackFormStateCopyWith(
          RecommendationFeedbackFormState value,
          $Res Function(RecommendationFeedbackFormState) then) =
      _$RecommendationFeedbackFormStateCopyWithImpl<$Res,
          RecommendationFeedbackFormState>;
  @useResult
  $Res call(
      {RecommendationFeedbackDraft draft,
      bool submitting,
      bool sent,
      String? pendingKey,
      CauceApiError? error});

  $RecommendationFeedbackDraftCopyWith<$Res> get draft;
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$RecommendationFeedbackFormStateCopyWithImpl<$Res,
        $Val extends RecommendationFeedbackFormState>
    implements $RecommendationFeedbackFormStateCopyWith<$Res> {
  _$RecommendationFeedbackFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationFeedbackFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? submitting = null,
    Object? sent = null,
    Object? pendingKey = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as RecommendationFeedbackDraft,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      sent: null == sent
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingKey: freezed == pendingKey
          ? _value.pendingKey
          : pendingKey // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ) as $Val);
  }

  /// Create a copy of RecommendationFeedbackFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecommendationFeedbackDraftCopyWith<$Res> get draft {
    return $RecommendationFeedbackDraftCopyWith<$Res>(_value.draft, (value) {
      return _then(_value.copyWith(draft: value) as $Val);
    });
  }

  /// Create a copy of RecommendationFeedbackFormState
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
abstract class _$$RecommendationFeedbackFormStateImplCopyWith<$Res>
    implements $RecommendationFeedbackFormStateCopyWith<$Res> {
  factory _$$RecommendationFeedbackFormStateImplCopyWith(
          _$RecommendationFeedbackFormStateImpl value,
          $Res Function(_$RecommendationFeedbackFormStateImpl) then) =
      __$$RecommendationFeedbackFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {RecommendationFeedbackDraft draft,
      bool submitting,
      bool sent,
      String? pendingKey,
      CauceApiError? error});

  @override
  $RecommendationFeedbackDraftCopyWith<$Res> get draft;
  @override
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$RecommendationFeedbackFormStateImplCopyWithImpl<$Res>
    extends _$RecommendationFeedbackFormStateCopyWithImpl<$Res,
        _$RecommendationFeedbackFormStateImpl>
    implements _$$RecommendationFeedbackFormStateImplCopyWith<$Res> {
  __$$RecommendationFeedbackFormStateImplCopyWithImpl(
      _$RecommendationFeedbackFormStateImpl _value,
      $Res Function(_$RecommendationFeedbackFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendationFeedbackFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? submitting = null,
    Object? sent = null,
    Object? pendingKey = freezed,
    Object? error = freezed,
  }) {
    return _then(_$RecommendationFeedbackFormStateImpl(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as RecommendationFeedbackDraft,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      sent: null == sent
          ? _value.sent
          : sent // ignore: cast_nullable_to_non_nullable
              as bool,
      pendingKey: freezed == pendingKey
          ? _value.pendingKey
          : pendingKey // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ));
  }
}

/// @nodoc

class _$RecommendationFeedbackFormStateImpl
    extends _RecommendationFeedbackFormState {
  const _$RecommendationFeedbackFormStateImpl(
      {this.draft = const RecommendationFeedbackDraft(),
      this.submitting = false,
      this.sent = false,
      this.pendingKey,
      this.error})
      : super._();

  @override
  @JsonKey()
  final RecommendationFeedbackDraft draft;
  @override
  @JsonKey()
  final bool submitting;
  @override
  @JsonKey()
  final bool sent;

  /// `Idempotency-Key` del intento en curso. Se conserva ante un fallo para
  /// que el reintento de la misma respuesta la repita, y se descarta en
  /// cuanto el paciente cambia algo: la misma clave con otra carga daria
  /// 409 `idempotency_mismatch`.
  @override
  final String? pendingKey;
  @override
  final CauceApiError? error;

  @override
  String toString() {
    return 'RecommendationFeedbackFormState(draft: $draft, submitting: $submitting, sent: $sent, pendingKey: $pendingKey, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationFeedbackFormStateImpl &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.sent, sent) || other.sent == sent) &&
            (identical(other.pendingKey, pendingKey) ||
                other.pendingKey == pendingKey) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, draft, submitting, sent, pendingKey, error);

  /// Create a copy of RecommendationFeedbackFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationFeedbackFormStateImplCopyWith<
          _$RecommendationFeedbackFormStateImpl>
      get copyWith => __$$RecommendationFeedbackFormStateImplCopyWithImpl<
          _$RecommendationFeedbackFormStateImpl>(this, _$identity);
}

abstract class _RecommendationFeedbackFormState
    extends RecommendationFeedbackFormState {
  const factory _RecommendationFeedbackFormState(
      {final RecommendationFeedbackDraft draft,
      final bool submitting,
      final bool sent,
      final String? pendingKey,
      final CauceApiError? error}) = _$RecommendationFeedbackFormStateImpl;
  const _RecommendationFeedbackFormState._() : super._();

  @override
  RecommendationFeedbackDraft get draft;
  @override
  bool get submitting;
  @override
  bool get sent;

  /// `Idempotency-Key` del intento en curso. Se conserva ante un fallo para
  /// que el reintento de la misma respuesta la repita, y se descarta en
  /// cuanto el paciente cambia algo: la misma clave con otra carga daria
  /// 409 `idempotency_mismatch`.
  @override
  String? get pendingKey;
  @override
  CauceApiError? get error;

  /// Create a copy of RecommendationFeedbackFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationFeedbackFormStateImplCopyWith<
          _$RecommendationFeedbackFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
