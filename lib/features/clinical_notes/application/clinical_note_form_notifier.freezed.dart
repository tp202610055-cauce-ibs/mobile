// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinical_note_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClinicalNoteFormState {
  ClinicalNoteDraft get draft => throw _privateConstructorUsedError;
  bool get submitting => throw _privateConstructorUsedError;

  /// Identificador de la nota creada, tras un envio exitoso.
  String? get createdId => throw _privateConstructorUsedError;
  CauceApiError? get error => throw _privateConstructorUsedError;

  /// Create a copy of ClinicalNoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ClinicalNoteFormStateCopyWith<ClinicalNoteFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicalNoteFormStateCopyWith<$Res> {
  factory $ClinicalNoteFormStateCopyWith(ClinicalNoteFormState value,
          $Res Function(ClinicalNoteFormState) then) =
      _$ClinicalNoteFormStateCopyWithImpl<$Res, ClinicalNoteFormState>;
  @useResult
  $Res call(
      {ClinicalNoteDraft draft,
      bool submitting,
      String? createdId,
      CauceApiError? error});

  $ClinicalNoteDraftCopyWith<$Res> get draft;
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$ClinicalNoteFormStateCopyWithImpl<$Res,
        $Val extends ClinicalNoteFormState>
    implements $ClinicalNoteFormStateCopyWith<$Res> {
  _$ClinicalNoteFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicalNoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? submitting = null,
    Object? createdId = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as ClinicalNoteDraft,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      createdId: freezed == createdId
          ? _value.createdId
          : createdId // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ) as $Val);
  }

  /// Create a copy of ClinicalNoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ClinicalNoteDraftCopyWith<$Res> get draft {
    return $ClinicalNoteDraftCopyWith<$Res>(_value.draft, (value) {
      return _then(_value.copyWith(draft: value) as $Val);
    });
  }

  /// Create a copy of ClinicalNoteFormState
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
abstract class _$$ClinicalNoteFormStateImplCopyWith<$Res>
    implements $ClinicalNoteFormStateCopyWith<$Res> {
  factory _$$ClinicalNoteFormStateImplCopyWith(
          _$ClinicalNoteFormStateImpl value,
          $Res Function(_$ClinicalNoteFormStateImpl) then) =
      __$$ClinicalNoteFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {ClinicalNoteDraft draft,
      bool submitting,
      String? createdId,
      CauceApiError? error});

  @override
  $ClinicalNoteDraftCopyWith<$Res> get draft;
  @override
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$ClinicalNoteFormStateImplCopyWithImpl<$Res>
    extends _$ClinicalNoteFormStateCopyWithImpl<$Res,
        _$ClinicalNoteFormStateImpl>
    implements _$$ClinicalNoteFormStateImplCopyWith<$Res> {
  __$$ClinicalNoteFormStateImplCopyWithImpl(_$ClinicalNoteFormStateImpl _value,
      $Res Function(_$ClinicalNoteFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicalNoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? submitting = null,
    Object? createdId = freezed,
    Object? error = freezed,
  }) {
    return _then(_$ClinicalNoteFormStateImpl(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as ClinicalNoteDraft,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      createdId: freezed == createdId
          ? _value.createdId
          : createdId // ignore: cast_nullable_to_non_nullable
              as String?,
      error: freezed == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ));
  }
}

/// @nodoc

class _$ClinicalNoteFormStateImpl extends _ClinicalNoteFormState {
  const _$ClinicalNoteFormStateImpl(
      {this.draft = const ClinicalNoteDraft(),
      this.submitting = false,
      this.createdId,
      this.error})
      : super._();

  @override
  @JsonKey()
  final ClinicalNoteDraft draft;
  @override
  @JsonKey()
  final bool submitting;

  /// Identificador de la nota creada, tras un envio exitoso.
  @override
  final String? createdId;
  @override
  final CauceApiError? error;

  @override
  String toString() {
    return 'ClinicalNoteFormState(draft: $draft, submitting: $submitting, createdId: $createdId, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicalNoteFormStateImpl &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            (identical(other.createdId, createdId) ||
                other.createdId == createdId) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, draft, submitting, createdId, error);

  /// Create a copy of ClinicalNoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicalNoteFormStateImplCopyWith<_$ClinicalNoteFormStateImpl>
      get copyWith => __$$ClinicalNoteFormStateImplCopyWithImpl<
          _$ClinicalNoteFormStateImpl>(this, _$identity);
}

abstract class _ClinicalNoteFormState extends ClinicalNoteFormState {
  const factory _ClinicalNoteFormState(
      {final ClinicalNoteDraft draft,
      final bool submitting,
      final String? createdId,
      final CauceApiError? error}) = _$ClinicalNoteFormStateImpl;
  const _ClinicalNoteFormState._() : super._();

  @override
  ClinicalNoteDraft get draft;
  @override
  bool get submitting;

  /// Identificador de la nota creada, tras un envio exitoso.
  @override
  String? get createdId;
  @override
  CauceApiError? get error;

  /// Create a copy of ClinicalNoteFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicalNoteFormStateImplCopyWith<_$ClinicalNoteFormStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
