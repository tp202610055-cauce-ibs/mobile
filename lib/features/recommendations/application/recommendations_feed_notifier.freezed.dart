// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendations_feed_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecommendationsFeed {
  /// Recomendaciones visibles, ya filtradas por el repositorio.
  List<RecommendationSummary> get summaries =>
      throw _privateConstructorUsedError;

  /// Marcador vigente tras reconciliarlo con la lista: un pedido en curso
  /// o una recomendacion en revision.
  PendingRecommendationRequest? get request =>
      throw _privateConstructorUsedError;

  /// Hay una recomendacion propia en revision (HU0014 CA2, CP037).
  bool get awaitingReview => throw _privateConstructorUsedError;

  /// Hay un `POST /recommendations` en vuelo.
  bool get generating => throw _privateConstructorUsedError;

  /// Fallo del pedido que el paciente si tiene que ver: red o servidor.
  /// Los 422 de negocio no llegan aca (decision 2).
  CauceApiError? get generationError => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationsFeed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationsFeedCopyWith<RecommendationsFeed> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationsFeedCopyWith<$Res> {
  factory $RecommendationsFeedCopyWith(
          RecommendationsFeed value, $Res Function(RecommendationsFeed) then) =
      _$RecommendationsFeedCopyWithImpl<$Res, RecommendationsFeed>;
  @useResult
  $Res call(
      {List<RecommendationSummary> summaries,
      PendingRecommendationRequest? request,
      bool awaitingReview,
      bool generating,
      CauceApiError? generationError});

  $PendingRecommendationRequestCopyWith<$Res>? get request;
  $CauceApiErrorCopyWith<$Res>? get generationError;
}

/// @nodoc
class _$RecommendationsFeedCopyWithImpl<$Res, $Val extends RecommendationsFeed>
    implements $RecommendationsFeedCopyWith<$Res> {
  _$RecommendationsFeedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationsFeed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summaries = null,
    Object? request = freezed,
    Object? awaitingReview = null,
    Object? generating = null,
    Object? generationError = freezed,
  }) {
    return _then(_value.copyWith(
      summaries: null == summaries
          ? _value.summaries
          : summaries // ignore: cast_nullable_to_non_nullable
              as List<RecommendationSummary>,
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as PendingRecommendationRequest?,
      awaitingReview: null == awaitingReview
          ? _value.awaitingReview
          : awaitingReview // ignore: cast_nullable_to_non_nullable
              as bool,
      generating: null == generating
          ? _value.generating
          : generating // ignore: cast_nullable_to_non_nullable
              as bool,
      generationError: freezed == generationError
          ? _value.generationError
          : generationError // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ) as $Val);
  }

  /// Create a copy of RecommendationsFeed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PendingRecommendationRequestCopyWith<$Res>? get request {
    if (_value.request == null) {
      return null;
    }

    return $PendingRecommendationRequestCopyWith<$Res>(_value.request!,
        (value) {
      return _then(_value.copyWith(request: value) as $Val);
    });
  }

  /// Create a copy of RecommendationsFeed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CauceApiErrorCopyWith<$Res>? get generationError {
    if (_value.generationError == null) {
      return null;
    }

    return $CauceApiErrorCopyWith<$Res>(_value.generationError!, (value) {
      return _then(_value.copyWith(generationError: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecommendationsFeedImplCopyWith<$Res>
    implements $RecommendationsFeedCopyWith<$Res> {
  factory _$$RecommendationsFeedImplCopyWith(_$RecommendationsFeedImpl value,
          $Res Function(_$RecommendationsFeedImpl) then) =
      __$$RecommendationsFeedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<RecommendationSummary> summaries,
      PendingRecommendationRequest? request,
      bool awaitingReview,
      bool generating,
      CauceApiError? generationError});

  @override
  $PendingRecommendationRequestCopyWith<$Res>? get request;
  @override
  $CauceApiErrorCopyWith<$Res>? get generationError;
}

/// @nodoc
class __$$RecommendationsFeedImplCopyWithImpl<$Res>
    extends _$RecommendationsFeedCopyWithImpl<$Res, _$RecommendationsFeedImpl>
    implements _$$RecommendationsFeedImplCopyWith<$Res> {
  __$$RecommendationsFeedImplCopyWithImpl(_$RecommendationsFeedImpl _value,
      $Res Function(_$RecommendationsFeedImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendationsFeed
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? summaries = null,
    Object? request = freezed,
    Object? awaitingReview = null,
    Object? generating = null,
    Object? generationError = freezed,
  }) {
    return _then(_$RecommendationsFeedImpl(
      summaries: null == summaries
          ? _value._summaries
          : summaries // ignore: cast_nullable_to_non_nullable
              as List<RecommendationSummary>,
      request: freezed == request
          ? _value.request
          : request // ignore: cast_nullable_to_non_nullable
              as PendingRecommendationRequest?,
      awaitingReview: null == awaitingReview
          ? _value.awaitingReview
          : awaitingReview // ignore: cast_nullable_to_non_nullable
              as bool,
      generating: null == generating
          ? _value.generating
          : generating // ignore: cast_nullable_to_non_nullable
              as bool,
      generationError: freezed == generationError
          ? _value.generationError
          : generationError // ignore: cast_nullable_to_non_nullable
              as CauceApiError?,
    ));
  }
}

/// @nodoc

class _$RecommendationsFeedImpl extends _RecommendationsFeed {
  const _$RecommendationsFeedImpl(
      {final List<RecommendationSummary> summaries =
          const <RecommendationSummary>[],
      this.request,
      this.awaitingReview = false,
      this.generating = false,
      this.generationError})
      : _summaries = summaries,
        super._();

  /// Recomendaciones visibles, ya filtradas por el repositorio.
  final List<RecommendationSummary> _summaries;

  /// Recomendaciones visibles, ya filtradas por el repositorio.
  @override
  @JsonKey()
  List<RecommendationSummary> get summaries {
    if (_summaries is EqualUnmodifiableListView) return _summaries;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_summaries);
  }

  /// Marcador vigente tras reconciliarlo con la lista: un pedido en curso
  /// o una recomendacion en revision.
  @override
  final PendingRecommendationRequest? request;

  /// Hay una recomendacion propia en revision (HU0014 CA2, CP037).
  @override
  @JsonKey()
  final bool awaitingReview;

  /// Hay un `POST /recommendations` en vuelo.
  @override
  @JsonKey()
  final bool generating;

  /// Fallo del pedido que el paciente si tiene que ver: red o servidor.
  /// Los 422 de negocio no llegan aca (decision 2).
  @override
  final CauceApiError? generationError;

  @override
  String toString() {
    return 'RecommendationsFeed(summaries: $summaries, request: $request, awaitingReview: $awaitingReview, generating: $generating, generationError: $generationError)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationsFeedImpl &&
            const DeepCollectionEquality()
                .equals(other._summaries, _summaries) &&
            (identical(other.request, request) || other.request == request) &&
            (identical(other.awaitingReview, awaitingReview) ||
                other.awaitingReview == awaitingReview) &&
            (identical(other.generating, generating) ||
                other.generating == generating) &&
            (identical(other.generationError, generationError) ||
                other.generationError == generationError));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_summaries),
      request,
      awaitingReview,
      generating,
      generationError);

  /// Create a copy of RecommendationsFeed
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationsFeedImplCopyWith<_$RecommendationsFeedImpl> get copyWith =>
      __$$RecommendationsFeedImplCopyWithImpl<_$RecommendationsFeedImpl>(
          this, _$identity);
}

abstract class _RecommendationsFeed extends RecommendationsFeed {
  const factory _RecommendationsFeed(
      {final List<RecommendationSummary> summaries,
      final PendingRecommendationRequest? request,
      final bool awaitingReview,
      final bool generating,
      final CauceApiError? generationError}) = _$RecommendationsFeedImpl;
  const _RecommendationsFeed._() : super._();

  /// Recomendaciones visibles, ya filtradas por el repositorio.
  @override
  List<RecommendationSummary> get summaries;

  /// Marcador vigente tras reconciliarlo con la lista: un pedido en curso
  /// o una recomendacion en revision.
  @override
  PendingRecommendationRequest? get request;

  /// Hay una recomendacion propia en revision (HU0014 CA2, CP037).
  @override
  bool get awaitingReview;

  /// Hay un `POST /recommendations` en vuelo.
  @override
  bool get generating;

  /// Fallo del pedido que el paciente si tiene que ver: red o servidor.
  /// Los 422 de negocio no llegan aca (decision 2).
  @override
  CauceApiError? get generationError;

  /// Create a copy of RecommendationsFeed
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationsFeedImplCopyWith<_$RecommendationsFeedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
