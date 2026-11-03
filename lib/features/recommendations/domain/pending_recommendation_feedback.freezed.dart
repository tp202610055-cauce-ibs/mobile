// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_recommendation_feedback.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PendingRecommendationFeedback {
  String get recommendationId => throw _privateConstructorUsedError;
  String get idempotencyKey => throw _privateConstructorUsedError;
  bool get wasApplied => throw _privateConstructorUsedError;
  FeedbackOutcomeOption get outcome => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// El servidor la rechazo por algo que no mejora reintentando.
  bool get rejected => throw _privateConstructorUsedError;
  String? get lastErrorCode => throw _privateConstructorUsedError;

  /// Create a copy of PendingRecommendationFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingRecommendationFeedbackCopyWith<PendingRecommendationFeedback>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingRecommendationFeedbackCopyWith<$Res> {
  factory $PendingRecommendationFeedbackCopyWith(
          PendingRecommendationFeedback value,
          $Res Function(PendingRecommendationFeedback) then) =
      _$PendingRecommendationFeedbackCopyWithImpl<$Res,
          PendingRecommendationFeedback>;
  @useResult
  $Res call(
      {String recommendationId,
      String idempotencyKey,
      bool wasApplied,
      FeedbackOutcomeOption outcome,
      String? comment,
      DateTime createdAt,
      bool rejected,
      String? lastErrorCode});
}

/// @nodoc
class _$PendingRecommendationFeedbackCopyWithImpl<$Res,
        $Val extends PendingRecommendationFeedback>
    implements $PendingRecommendationFeedbackCopyWith<$Res> {
  _$PendingRecommendationFeedbackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingRecommendationFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recommendationId = null,
    Object? idempotencyKey = null,
    Object? wasApplied = null,
    Object? outcome = null,
    Object? comment = freezed,
    Object? createdAt = null,
    Object? rejected = null,
    Object? lastErrorCode = freezed,
  }) {
    return _then(_value.copyWith(
      recommendationId: null == recommendationId
          ? _value.recommendationId
          : recommendationId // ignore: cast_nullable_to_non_nullable
              as String,
      idempotencyKey: null == idempotencyKey
          ? _value.idempotencyKey
          : idempotencyKey // ignore: cast_nullable_to_non_nullable
              as String,
      wasApplied: null == wasApplied
          ? _value.wasApplied
          : wasApplied // ignore: cast_nullable_to_non_nullable
              as bool,
      outcome: null == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as FeedbackOutcomeOption,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rejected: null == rejected
          ? _value.rejected
          : rejected // ignore: cast_nullable_to_non_nullable
              as bool,
      lastErrorCode: freezed == lastErrorCode
          ? _value.lastErrorCode
          : lastErrorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PendingRecommendationFeedbackImplCopyWith<$Res>
    implements $PendingRecommendationFeedbackCopyWith<$Res> {
  factory _$$PendingRecommendationFeedbackImplCopyWith(
          _$PendingRecommendationFeedbackImpl value,
          $Res Function(_$PendingRecommendationFeedbackImpl) then) =
      __$$PendingRecommendationFeedbackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String recommendationId,
      String idempotencyKey,
      bool wasApplied,
      FeedbackOutcomeOption outcome,
      String? comment,
      DateTime createdAt,
      bool rejected,
      String? lastErrorCode});
}

/// @nodoc
class __$$PendingRecommendationFeedbackImplCopyWithImpl<$Res>
    extends _$PendingRecommendationFeedbackCopyWithImpl<$Res,
        _$PendingRecommendationFeedbackImpl>
    implements _$$PendingRecommendationFeedbackImplCopyWith<$Res> {
  __$$PendingRecommendationFeedbackImplCopyWithImpl(
      _$PendingRecommendationFeedbackImpl _value,
      $Res Function(_$PendingRecommendationFeedbackImpl) _then)
      : super(_value, _then);

  /// Create a copy of PendingRecommendationFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recommendationId = null,
    Object? idempotencyKey = null,
    Object? wasApplied = null,
    Object? outcome = null,
    Object? comment = freezed,
    Object? createdAt = null,
    Object? rejected = null,
    Object? lastErrorCode = freezed,
  }) {
    return _then(_$PendingRecommendationFeedbackImpl(
      recommendationId: null == recommendationId
          ? _value.recommendationId
          : recommendationId // ignore: cast_nullable_to_non_nullable
              as String,
      idempotencyKey: null == idempotencyKey
          ? _value.idempotencyKey
          : idempotencyKey // ignore: cast_nullable_to_non_nullable
              as String,
      wasApplied: null == wasApplied
          ? _value.wasApplied
          : wasApplied // ignore: cast_nullable_to_non_nullable
              as bool,
      outcome: null == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as FeedbackOutcomeOption,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      rejected: null == rejected
          ? _value.rejected
          : rejected // ignore: cast_nullable_to_non_nullable
              as bool,
      lastErrorCode: freezed == lastErrorCode
          ? _value.lastErrorCode
          : lastErrorCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$PendingRecommendationFeedbackImpl
    extends _PendingRecommendationFeedback {
  const _$PendingRecommendationFeedbackImpl(
      {required this.recommendationId,
      required this.idempotencyKey,
      required this.wasApplied,
      required this.outcome,
      this.comment,
      required this.createdAt,
      this.rejected = false,
      this.lastErrorCode})
      : super._();

  @override
  final String recommendationId;
  @override
  final String idempotencyKey;
  @override
  final bool wasApplied;
  @override
  final FeedbackOutcomeOption outcome;
  @override
  final String? comment;
  @override
  final DateTime createdAt;

  /// El servidor la rechazo por algo que no mejora reintentando.
  @override
  @JsonKey()
  final bool rejected;
  @override
  final String? lastErrorCode;

  @override
  String toString() {
    return 'PendingRecommendationFeedback(recommendationId: $recommendationId, idempotencyKey: $idempotencyKey, wasApplied: $wasApplied, outcome: $outcome, comment: $comment, createdAt: $createdAt, rejected: $rejected, lastErrorCode: $lastErrorCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingRecommendationFeedbackImpl &&
            (identical(other.recommendationId, recommendationId) ||
                other.recommendationId == recommendationId) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey) &&
            (identical(other.wasApplied, wasApplied) ||
                other.wasApplied == wasApplied) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.rejected, rejected) ||
                other.rejected == rejected) &&
            (identical(other.lastErrorCode, lastErrorCode) ||
                other.lastErrorCode == lastErrorCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, recommendationId, idempotencyKey,
      wasApplied, outcome, comment, createdAt, rejected, lastErrorCode);

  /// Create a copy of PendingRecommendationFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingRecommendationFeedbackImplCopyWith<
          _$PendingRecommendationFeedbackImpl>
      get copyWith => __$$PendingRecommendationFeedbackImplCopyWithImpl<
          _$PendingRecommendationFeedbackImpl>(this, _$identity);
}

abstract class _PendingRecommendationFeedback
    extends PendingRecommendationFeedback {
  const factory _PendingRecommendationFeedback(
      {required final String recommendationId,
      required final String idempotencyKey,
      required final bool wasApplied,
      required final FeedbackOutcomeOption outcome,
      final String? comment,
      required final DateTime createdAt,
      final bool rejected,
      final String? lastErrorCode}) = _$PendingRecommendationFeedbackImpl;
  const _PendingRecommendationFeedback._() : super._();

  @override
  String get recommendationId;
  @override
  String get idempotencyKey;
  @override
  bool get wasApplied;
  @override
  FeedbackOutcomeOption get outcome;
  @override
  String? get comment;
  @override
  DateTime get createdAt;

  /// El servidor la rechazo por algo que no mejora reintentando.
  @override
  bool get rejected;
  @override
  String? get lastErrorCode;

  /// Create a copy of PendingRecommendationFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingRecommendationFeedbackImplCopyWith<
          _$PendingRecommendationFeedbackImpl>
      get copyWith => throw _privateConstructorUsedError;
}
