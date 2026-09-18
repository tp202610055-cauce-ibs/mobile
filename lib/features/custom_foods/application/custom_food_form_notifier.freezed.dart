// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_food_form_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomFoodFormState {
  CustomFoodDraft get draft => throw _privateConstructorUsedError;
  bool get submitting => throw _privateConstructorUsedError;

  /// Platos que el paciente ya tiene. Alimenta el rechazo por nombre
  /// duplicado antes de enviar (CA02).
  List<CustomFoodRecord> get existing => throw _privateConstructorUsedError;

  /// Coincidencias que devolvio el servidor y que el paciente todavia no
  /// reconocio (CA03). Mientras no este vacia, la pantalla muestra la
  /// advertencia en vez del formulario.
  List<DetectedAllergen> get pendingAllergens =>
      throw _privateConstructorUsedError;

  /// Identificador del plato ya creado, tras un envio exitoso.
  String? get createdId => throw _privateConstructorUsedError;
  CauceApiError? get error => throw _privateConstructorUsedError;

  /// Create a copy of CustomFoodFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomFoodFormStateCopyWith<CustomFoodFormState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFoodFormStateCopyWith<$Res> {
  factory $CustomFoodFormStateCopyWith(
          CustomFoodFormState value, $Res Function(CustomFoodFormState) then) =
      _$CustomFoodFormStateCopyWithImpl<$Res, CustomFoodFormState>;
  @useResult
  $Res call(
      {CustomFoodDraft draft,
      bool submitting,
      List<CustomFoodRecord> existing,
      List<DetectedAllergen> pendingAllergens,
      String? createdId,
      CauceApiError? error});

  $CustomFoodDraftCopyWith<$Res> get draft;
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class _$CustomFoodFormStateCopyWithImpl<$Res, $Val extends CustomFoodFormState>
    implements $CustomFoodFormStateCopyWith<$Res> {
  _$CustomFoodFormStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomFoodFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? submitting = null,
    Object? existing = null,
    Object? pendingAllergens = null,
    Object? createdId = freezed,
    Object? error = freezed,
  }) {
    return _then(_value.copyWith(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as CustomFoodDraft,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      existing: null == existing
          ? _value.existing
          : existing // ignore: cast_nullable_to_non_nullable
              as List<CustomFoodRecord>,
      pendingAllergens: null == pendingAllergens
          ? _value.pendingAllergens
          : pendingAllergens // ignore: cast_nullable_to_non_nullable
              as List<DetectedAllergen>,
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

  /// Create a copy of CustomFoodFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CustomFoodDraftCopyWith<$Res> get draft {
    return $CustomFoodDraftCopyWith<$Res>(_value.draft, (value) {
      return _then(_value.copyWith(draft: value) as $Val);
    });
  }

  /// Create a copy of CustomFoodFormState
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
abstract class _$$CustomFoodFormStateImplCopyWith<$Res>
    implements $CustomFoodFormStateCopyWith<$Res> {
  factory _$$CustomFoodFormStateImplCopyWith(_$CustomFoodFormStateImpl value,
          $Res Function(_$CustomFoodFormStateImpl) then) =
      __$$CustomFoodFormStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {CustomFoodDraft draft,
      bool submitting,
      List<CustomFoodRecord> existing,
      List<DetectedAllergen> pendingAllergens,
      String? createdId,
      CauceApiError? error});

  @override
  $CustomFoodDraftCopyWith<$Res> get draft;
  @override
  $CauceApiErrorCopyWith<$Res>? get error;
}

/// @nodoc
class __$$CustomFoodFormStateImplCopyWithImpl<$Res>
    extends _$CustomFoodFormStateCopyWithImpl<$Res, _$CustomFoodFormStateImpl>
    implements _$$CustomFoodFormStateImplCopyWith<$Res> {
  __$$CustomFoodFormStateImplCopyWithImpl(_$CustomFoodFormStateImpl _value,
      $Res Function(_$CustomFoodFormStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomFoodFormState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? draft = null,
    Object? submitting = null,
    Object? existing = null,
    Object? pendingAllergens = null,
    Object? createdId = freezed,
    Object? error = freezed,
  }) {
    return _then(_$CustomFoodFormStateImpl(
      draft: null == draft
          ? _value.draft
          : draft // ignore: cast_nullable_to_non_nullable
              as CustomFoodDraft,
      submitting: null == submitting
          ? _value.submitting
          : submitting // ignore: cast_nullable_to_non_nullable
              as bool,
      existing: null == existing
          ? _value._existing
          : existing // ignore: cast_nullable_to_non_nullable
              as List<CustomFoodRecord>,
      pendingAllergens: null == pendingAllergens
          ? _value._pendingAllergens
          : pendingAllergens // ignore: cast_nullable_to_non_nullable
              as List<DetectedAllergen>,
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

class _$CustomFoodFormStateImpl extends _CustomFoodFormState {
  const _$CustomFoodFormStateImpl(
      {this.draft = const CustomFoodDraft(),
      this.submitting = false,
      final List<CustomFoodRecord> existing = const <CustomFoodRecord>[],
      final List<DetectedAllergen> pendingAllergens =
          const <DetectedAllergen>[],
      this.createdId,
      this.error})
      : _existing = existing,
        _pendingAllergens = pendingAllergens,
        super._();

  @override
  @JsonKey()
  final CustomFoodDraft draft;
  @override
  @JsonKey()
  final bool submitting;

  /// Platos que el paciente ya tiene. Alimenta el rechazo por nombre
  /// duplicado antes de enviar (CA02).
  final List<CustomFoodRecord> _existing;

  /// Platos que el paciente ya tiene. Alimenta el rechazo por nombre
  /// duplicado antes de enviar (CA02).
  @override
  @JsonKey()
  List<CustomFoodRecord> get existing {
    if (_existing is EqualUnmodifiableListView) return _existing;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_existing);
  }

  /// Coincidencias que devolvio el servidor y que el paciente todavia no
  /// reconocio (CA03). Mientras no este vacia, la pantalla muestra la
  /// advertencia en vez del formulario.
  final List<DetectedAllergen> _pendingAllergens;

  /// Coincidencias que devolvio el servidor y que el paciente todavia no
  /// reconocio (CA03). Mientras no este vacia, la pantalla muestra la
  /// advertencia en vez del formulario.
  @override
  @JsonKey()
  List<DetectedAllergen> get pendingAllergens {
    if (_pendingAllergens is EqualUnmodifiableListView)
      return _pendingAllergens;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_pendingAllergens);
  }

  /// Identificador del plato ya creado, tras un envio exitoso.
  @override
  final String? createdId;
  @override
  final CauceApiError? error;

  @override
  String toString() {
    return 'CustomFoodFormState(draft: $draft, submitting: $submitting, existing: $existing, pendingAllergens: $pendingAllergens, createdId: $createdId, error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFoodFormStateImpl &&
            (identical(other.draft, draft) || other.draft == draft) &&
            (identical(other.submitting, submitting) ||
                other.submitting == submitting) &&
            const DeepCollectionEquality().equals(other._existing, _existing) &&
            const DeepCollectionEquality()
                .equals(other._pendingAllergens, _pendingAllergens) &&
            (identical(other.createdId, createdId) ||
                other.createdId == createdId) &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      draft,
      submitting,
      const DeepCollectionEquality().hash(_existing),
      const DeepCollectionEquality().hash(_pendingAllergens),
      createdId,
      error);

  /// Create a copy of CustomFoodFormState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomFoodFormStateImplCopyWith<_$CustomFoodFormStateImpl> get copyWith =>
      __$$CustomFoodFormStateImplCopyWithImpl<_$CustomFoodFormStateImpl>(
          this, _$identity);
}

abstract class _CustomFoodFormState extends CustomFoodFormState {
  const factory _CustomFoodFormState(
      {final CustomFoodDraft draft,
      final bool submitting,
      final List<CustomFoodRecord> existing,
      final List<DetectedAllergen> pendingAllergens,
      final String? createdId,
      final CauceApiError? error}) = _$CustomFoodFormStateImpl;
  const _CustomFoodFormState._() : super._();

  @override
  CustomFoodDraft get draft;
  @override
  bool get submitting;

  /// Platos que el paciente ya tiene. Alimenta el rechazo por nombre
  /// duplicado antes de enviar (CA02).
  @override
  List<CustomFoodRecord> get existing;

  /// Coincidencias que devolvio el servidor y que el paciente todavia no
  /// reconocio (CA03). Mientras no este vacia, la pantalla muestra la
  /// advertencia en vez del formulario.
  @override
  List<DetectedAllergen> get pendingAllergens;

  /// Identificador del plato ya creado, tras un envio exitoso.
  @override
  String? get createdId;
  @override
  CauceApiError? get error;

  /// Create a copy of CustomFoodFormState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomFoodFormStateImplCopyWith<_$CustomFoodFormStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
