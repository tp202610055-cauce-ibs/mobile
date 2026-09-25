// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pending_recommendation_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PendingRecommendationRequest {
  /// Paciente que la pidio. Un marcador de otra cuenta en el mismo
  /// dispositivo se descarta.
  String get ownerUserId => throw _privateConstructorUsedError;

  /// `Idempotency-Key` del `POST /recommendations`.
  String get idempotencyKey => throw _privateConstructorUsedError;

  /// Momento del pedido, o de la generacion si el servidor ya respondio.
  DateTime get requestedAt => throw _privateConstructorUsedError;
  String? get recommendationId => throw _privateConstructorUsedError;

  /// Vencimiento que informo el servidor (72 h desde la generacion).
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Create a copy of PendingRecommendationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PendingRecommendationRequestCopyWith<PendingRecommendationRequest>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PendingRecommendationRequestCopyWith<$Res> {
  factory $PendingRecommendationRequestCopyWith(
          PendingRecommendationRequest value,
          $Res Function(PendingRecommendationRequest) then) =
      _$PendingRecommendationRequestCopyWithImpl<$Res,
          PendingRecommendationRequest>;
  @useResult
  $Res call(
      {String ownerUserId,
      String idempotencyKey,
      DateTime requestedAt,
      String? recommendationId,
      DateTime? expiresAt});
}

/// @nodoc
class _$PendingRecommendationRequestCopyWithImpl<$Res,
        $Val extends PendingRecommendationRequest>
    implements $PendingRecommendationRequestCopyWith<$Res> {
  _$PendingRecommendationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PendingRecommendationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ownerUserId = null,
    Object? idempotencyKey = null,
    Object? requestedAt = null,
    Object? recommendationId = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      ownerUserId: null == ownerUserId
          ? _value.ownerUserId
          : ownerUserId // ignore: cast_nullable_to_non_nullable
              as String,
      idempotencyKey: null == idempotencyKey
          ? _value.idempotencyKey
          : idempotencyKey // ignore: cast_nullable_to_non_nullable
              as String,
      requestedAt: null == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recommendationId: freezed == recommendationId
          ? _value.recommendationId
          : recommendationId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PendingRecommendationRequestImplCopyWith<$Res>
    implements $PendingRecommendationRequestCopyWith<$Res> {
  factory _$$PendingRecommendationRequestImplCopyWith(
          _$PendingRecommendationRequestImpl value,
          $Res Function(_$PendingRecommendationRequestImpl) then) =
      __$$PendingRecommendationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String ownerUserId,
      String idempotencyKey,
      DateTime requestedAt,
      String? recommendationId,
      DateTime? expiresAt});
}

/// @nodoc
class __$$PendingRecommendationRequestImplCopyWithImpl<$Res>
    extends _$PendingRecommendationRequestCopyWithImpl<$Res,
        _$PendingRecommendationRequestImpl>
    implements _$$PendingRecommendationRequestImplCopyWith<$Res> {
  __$$PendingRecommendationRequestImplCopyWithImpl(
      _$PendingRecommendationRequestImpl _value,
      $Res Function(_$PendingRecommendationRequestImpl) _then)
      : super(_value, _then);

  /// Create a copy of PendingRecommendationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ownerUserId = null,
    Object? idempotencyKey = null,
    Object? requestedAt = null,
    Object? recommendationId = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$PendingRecommendationRequestImpl(
      ownerUserId: null == ownerUserId
          ? _value.ownerUserId
          : ownerUserId // ignore: cast_nullable_to_non_nullable
              as String,
      idempotencyKey: null == idempotencyKey
          ? _value.idempotencyKey
          : idempotencyKey // ignore: cast_nullable_to_non_nullable
              as String,
      requestedAt: null == requestedAt
          ? _value.requestedAt
          : requestedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      recommendationId: freezed == recommendationId
          ? _value.recommendationId
          : recommendationId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$PendingRecommendationRequestImpl extends _PendingRecommendationRequest {
  const _$PendingRecommendationRequestImpl(
      {required this.ownerUserId,
      required this.idempotencyKey,
      required this.requestedAt,
      this.recommendationId,
      this.expiresAt})
      : super._();

  /// Paciente que la pidio. Un marcador de otra cuenta en el mismo
  /// dispositivo se descarta.
  @override
  final String ownerUserId;

  /// `Idempotency-Key` del `POST /recommendations`.
  @override
  final String idempotencyKey;

  /// Momento del pedido, o de la generacion si el servidor ya respondio.
  @override
  final DateTime requestedAt;
  @override
  final String? recommendationId;

  /// Vencimiento que informo el servidor (72 h desde la generacion).
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'PendingRecommendationRequest(ownerUserId: $ownerUserId, idempotencyKey: $idempotencyKey, requestedAt: $requestedAt, recommendationId: $recommendationId, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PendingRecommendationRequestImpl &&
            (identical(other.ownerUserId, ownerUserId) ||
                other.ownerUserId == ownerUserId) &&
            (identical(other.idempotencyKey, idempotencyKey) ||
                other.idempotencyKey == idempotencyKey) &&
            (identical(other.requestedAt, requestedAt) ||
                other.requestedAt == requestedAt) &&
            (identical(other.recommendationId, recommendationId) ||
                other.recommendationId == recommendationId) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, ownerUserId, idempotencyKey,
      requestedAt, recommendationId, expiresAt);

  /// Create a copy of PendingRecommendationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PendingRecommendationRequestImplCopyWith<
          _$PendingRecommendationRequestImpl>
      get copyWith => __$$PendingRecommendationRequestImplCopyWithImpl<
          _$PendingRecommendationRequestImpl>(this, _$identity);
}

abstract class _PendingRecommendationRequest
    extends PendingRecommendationRequest {
  const factory _PendingRecommendationRequest(
      {required final String ownerUserId,
      required final String idempotencyKey,
      required final DateTime requestedAt,
      final String? recommendationId,
      final DateTime? expiresAt}) = _$PendingRecommendationRequestImpl;
  const _PendingRecommendationRequest._() : super._();

  /// Paciente que la pidio. Un marcador de otra cuenta en el mismo
  /// dispositivo se descarta.
  @override
  String get ownerUserId;

  /// `Idempotency-Key` del `POST /recommendations`.
  @override
  String get idempotencyKey;

  /// Momento del pedido, o de la generacion si el servidor ya respondio.
  @override
  DateTime get requestedAt;
  @override
  String? get recommendationId;

  /// Vencimiento que informo el servidor (72 h desde la generacion).
  @override
  DateTime? get expiresAt;

  /// Create a copy of PendingRecommendationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PendingRecommendationRequestImplCopyWith<
          _$PendingRecommendationRequestImpl>
      get copyWith => throw _privateConstructorUsedError;
}
