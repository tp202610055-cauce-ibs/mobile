// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recommendation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RecommendationSummary {
  String get id => throw _privateConstructorUsedError;
  RecommendationStatusOption get status => throw _privateConstructorUsedError;
  double get confidenceScore => throw _privateConstructorUsedError;
  int get itemsCount => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationSummaryCopyWith<RecommendationSummary> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationSummaryCopyWith<$Res> {
  factory $RecommendationSummaryCopyWith(RecommendationSummary value,
          $Res Function(RecommendationSummary) then) =
      _$RecommendationSummaryCopyWithImpl<$Res, RecommendationSummary>;
  @useResult
  $Res call(
      {String id,
      RecommendationStatusOption status,
      double confidenceScore,
      int itemsCount,
      DateTime generatedAt,
      DateTime? expiresAt});
}

/// @nodoc
class _$RecommendationSummaryCopyWithImpl<$Res,
        $Val extends RecommendationSummary>
    implements $RecommendationSummaryCopyWith<$Res> {
  _$RecommendationSummaryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? confidenceScore = null,
    Object? itemsCount = null,
    Object? generatedAt = null,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecommendationStatusOption,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      itemsCount: null == itemsCount
          ? _value.itemsCount
          : itemsCount // ignore: cast_nullable_to_non_nullable
              as int,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecommendationSummaryImplCopyWith<$Res>
    implements $RecommendationSummaryCopyWith<$Res> {
  factory _$$RecommendationSummaryImplCopyWith(
          _$RecommendationSummaryImpl value,
          $Res Function(_$RecommendationSummaryImpl) then) =
      __$$RecommendationSummaryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      RecommendationStatusOption status,
      double confidenceScore,
      int itemsCount,
      DateTime generatedAt,
      DateTime? expiresAt});
}

/// @nodoc
class __$$RecommendationSummaryImplCopyWithImpl<$Res>
    extends _$RecommendationSummaryCopyWithImpl<$Res,
        _$RecommendationSummaryImpl>
    implements _$$RecommendationSummaryImplCopyWith<$Res> {
  __$$RecommendationSummaryImplCopyWithImpl(_$RecommendationSummaryImpl _value,
      $Res Function(_$RecommendationSummaryImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendationSummary
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? confidenceScore = null,
    Object? itemsCount = null,
    Object? generatedAt = null,
    Object? expiresAt = freezed,
  }) {
    return _then(_$RecommendationSummaryImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecommendationStatusOption,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      itemsCount: null == itemsCount
          ? _value.itemsCount
          : itemsCount // ignore: cast_nullable_to_non_nullable
              as int,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$RecommendationSummaryImpl implements _RecommendationSummary {
  const _$RecommendationSummaryImpl(
      {required this.id,
      required this.status,
      required this.confidenceScore,
      required this.itemsCount,
      required this.generatedAt,
      this.expiresAt});

  @override
  final String id;
  @override
  final RecommendationStatusOption status;
  @override
  final double confidenceScore;
  @override
  final int itemsCount;
  @override
  final DateTime generatedAt;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'RecommendationSummary(id: $id, status: $status, confidenceScore: $confidenceScore, itemsCount: $itemsCount, generatedAt: $generatedAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationSummaryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore) &&
            (identical(other.itemsCount, itemsCount) ||
                other.itemsCount == itemsCount) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, status, confidenceScore,
      itemsCount, generatedAt, expiresAt);

  /// Create a copy of RecommendationSummary
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationSummaryImplCopyWith<_$RecommendationSummaryImpl>
      get copyWith => __$$RecommendationSummaryImplCopyWithImpl<
          _$RecommendationSummaryImpl>(this, _$identity);
}

abstract class _RecommendationSummary implements RecommendationSummary {
  const factory _RecommendationSummary(
      {required final String id,
      required final RecommendationStatusOption status,
      required final double confidenceScore,
      required final int itemsCount,
      required final DateTime generatedAt,
      final DateTime? expiresAt}) = _$RecommendationSummaryImpl;

  @override
  String get id;
  @override
  RecommendationStatusOption get status;
  @override
  double get confidenceScore;
  @override
  int get itemsCount;
  @override
  DateTime get generatedAt;
  @override
  DateTime? get expiresAt;

  /// Create a copy of RecommendationSummary
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationSummaryImplCopyWith<_$RecommendationSummaryImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$GeneratedRecommendation {
  String get id => throw _privateConstructorUsedError;
  RecommendationStatusOption get status => throw _privateConstructorUsedError;
  DateTime? get generatedAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;

  /// Create a copy of GeneratedRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GeneratedRecommendationCopyWith<GeneratedRecommendation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GeneratedRecommendationCopyWith<$Res> {
  factory $GeneratedRecommendationCopyWith(GeneratedRecommendation value,
          $Res Function(GeneratedRecommendation) then) =
      _$GeneratedRecommendationCopyWithImpl<$Res, GeneratedRecommendation>;
  @useResult
  $Res call(
      {String id,
      RecommendationStatusOption status,
      DateTime? generatedAt,
      DateTime? expiresAt});
}

/// @nodoc
class _$GeneratedRecommendationCopyWithImpl<$Res,
        $Val extends GeneratedRecommendation>
    implements $GeneratedRecommendationCopyWith<$Res> {
  _$GeneratedRecommendationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GeneratedRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? generatedAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecommendationStatusOption,
      generatedAt: freezed == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GeneratedRecommendationImplCopyWith<$Res>
    implements $GeneratedRecommendationCopyWith<$Res> {
  factory _$$GeneratedRecommendationImplCopyWith(
          _$GeneratedRecommendationImpl value,
          $Res Function(_$GeneratedRecommendationImpl) then) =
      __$$GeneratedRecommendationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      RecommendationStatusOption status,
      DateTime? generatedAt,
      DateTime? expiresAt});
}

/// @nodoc
class __$$GeneratedRecommendationImplCopyWithImpl<$Res>
    extends _$GeneratedRecommendationCopyWithImpl<$Res,
        _$GeneratedRecommendationImpl>
    implements _$$GeneratedRecommendationImplCopyWith<$Res> {
  __$$GeneratedRecommendationImplCopyWithImpl(
      _$GeneratedRecommendationImpl _value,
      $Res Function(_$GeneratedRecommendationImpl) _then)
      : super(_value, _then);

  /// Create a copy of GeneratedRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? generatedAt = freezed,
    Object? expiresAt = freezed,
  }) {
    return _then(_$GeneratedRecommendationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecommendationStatusOption,
      generatedAt: freezed == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$GeneratedRecommendationImpl extends _GeneratedRecommendation {
  const _$GeneratedRecommendationImpl(
      {required this.id,
      required this.status,
      this.generatedAt,
      this.expiresAt})
      : super._();

  @override
  final String id;
  @override
  final RecommendationStatusOption status;
  @override
  final DateTime? generatedAt;
  @override
  final DateTime? expiresAt;

  @override
  String toString() {
    return 'GeneratedRecommendation(id: $id, status: $status, generatedAt: $generatedAt, expiresAt: $expiresAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GeneratedRecommendationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, id, status, generatedAt, expiresAt);

  /// Create a copy of GeneratedRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GeneratedRecommendationImplCopyWith<_$GeneratedRecommendationImpl>
      get copyWith => __$$GeneratedRecommendationImplCopyWithImpl<
          _$GeneratedRecommendationImpl>(this, _$identity);
}

abstract class _GeneratedRecommendation extends GeneratedRecommendation {
  const factory _GeneratedRecommendation(
      {required final String id,
      required final RecommendationStatusOption status,
      final DateTime? generatedAt,
      final DateTime? expiresAt}) = _$GeneratedRecommendationImpl;
  const _GeneratedRecommendation._() : super._();

  @override
  String get id;
  @override
  RecommendationStatusOption get status;
  @override
  DateTime? get generatedAt;
  @override
  DateTime? get expiresAt;

  /// Create a copy of GeneratedRecommendation
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GeneratedRecommendationImplCopyWith<_$GeneratedRecommendationImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecommendationItem {
  String get id => throw _privateConstructorUsedError;
  String get foodName => throw _privateConstructorUsedError;
  RecommendationAction get action => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;
  String? get substituteFoodName => throw _privateConstructorUsedError;

  /// Justificacion breve del motor. Llega tal cual del servidor.
  String? get reasoning => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationItemCopyWith<RecommendationItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationItemCopyWith<$Res> {
  factory $RecommendationItemCopyWith(
          RecommendationItem value, $Res Function(RecommendationItem) then) =
      _$RecommendationItemCopyWithImpl<$Res, RecommendationItem>;
  @useResult
  $Res call(
      {String id,
      String foodName,
      RecommendationAction action,
      String? category,
      String? substituteFoodName,
      String? reasoning});
}

/// @nodoc
class _$RecommendationItemCopyWithImpl<$Res, $Val extends RecommendationItem>
    implements $RecommendationItemCopyWith<$Res> {
  _$RecommendationItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodName = null,
    Object? action = null,
    Object? category = freezed,
    Object? substituteFoodName = freezed,
    Object? reasoning = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      foodName: null == foodName
          ? _value.foodName
          : foodName // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as RecommendationAction,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      substituteFoodName: freezed == substituteFoodName
          ? _value.substituteFoodName
          : substituteFoodName // ignore: cast_nullable_to_non_nullable
              as String?,
      reasoning: freezed == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecommendationItemImplCopyWith<$Res>
    implements $RecommendationItemCopyWith<$Res> {
  factory _$$RecommendationItemImplCopyWith(_$RecommendationItemImpl value,
          $Res Function(_$RecommendationItemImpl) then) =
      __$$RecommendationItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String foodName,
      RecommendationAction action,
      String? category,
      String? substituteFoodName,
      String? reasoning});
}

/// @nodoc
class __$$RecommendationItemImplCopyWithImpl<$Res>
    extends _$RecommendationItemCopyWithImpl<$Res, _$RecommendationItemImpl>
    implements _$$RecommendationItemImplCopyWith<$Res> {
  __$$RecommendationItemImplCopyWithImpl(_$RecommendationItemImpl _value,
      $Res Function(_$RecommendationItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendationItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? foodName = null,
    Object? action = null,
    Object? category = freezed,
    Object? substituteFoodName = freezed,
    Object? reasoning = freezed,
  }) {
    return _then(_$RecommendationItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      foodName: null == foodName
          ? _value.foodName
          : foodName // ignore: cast_nullable_to_non_nullable
              as String,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as RecommendationAction,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String?,
      substituteFoodName: freezed == substituteFoodName
          ? _value.substituteFoodName
          : substituteFoodName // ignore: cast_nullable_to_non_nullable
              as String?,
      reasoning: freezed == reasoning
          ? _value.reasoning
          : reasoning // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RecommendationItemImpl implements _RecommendationItem {
  const _$RecommendationItemImpl(
      {required this.id,
      required this.foodName,
      required this.action,
      this.category,
      this.substituteFoodName,
      this.reasoning});

  @override
  final String id;
  @override
  final String foodName;
  @override
  final RecommendationAction action;
  @override
  final String? category;
  @override
  final String? substituteFoodName;

  /// Justificacion breve del motor. Llega tal cual del servidor.
  @override
  final String? reasoning;

  @override
  String toString() {
    return 'RecommendationItem(id: $id, foodName: $foodName, action: $action, category: $category, substituteFoodName: $substituteFoodName, reasoning: $reasoning)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.foodName, foodName) ||
                other.foodName == foodName) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.substituteFoodName, substituteFoodName) ||
                other.substituteFoodName == substituteFoodName) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, foodName, action, category,
      substituteFoodName, reasoning);

  /// Create a copy of RecommendationItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationItemImplCopyWith<_$RecommendationItemImpl> get copyWith =>
      __$$RecommendationItemImplCopyWithImpl<_$RecommendationItemImpl>(
          this, _$identity);
}

abstract class _RecommendationItem implements RecommendationItem {
  const factory _RecommendationItem(
      {required final String id,
      required final String foodName,
      required final RecommendationAction action,
      final String? category,
      final String? substituteFoodName,
      final String? reasoning}) = _$RecommendationItemImpl;

  @override
  String get id;
  @override
  String get foodName;
  @override
  RecommendationAction get action;
  @override
  String? get category;
  @override
  String? get substituteFoodName;

  /// Justificacion breve del motor. Llega tal cual del servidor.
  @override
  String? get reasoning;

  /// Create a copy of RecommendationItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationItemImplCopyWith<_$RecommendationItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecommendationSupportingData {
  int get symptomCount => throw _privateConstructorUsedError;
  int get mealCount => throw _privateConstructorUsedError;
  int get correlationWindowHours => throw _privateConstructorUsedError;
  DateTime get windowFrom => throw _privateConstructorUsedError;
  DateTime get windowTo => throw _privateConstructorUsedError;
  List<String> get topHighFodmapFoods => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationSupportingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationSupportingDataCopyWith<RecommendationSupportingData>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationSupportingDataCopyWith<$Res> {
  factory $RecommendationSupportingDataCopyWith(
          RecommendationSupportingData value,
          $Res Function(RecommendationSupportingData) then) =
      _$RecommendationSupportingDataCopyWithImpl<$Res,
          RecommendationSupportingData>;
  @useResult
  $Res call(
      {int symptomCount,
      int mealCount,
      int correlationWindowHours,
      DateTime windowFrom,
      DateTime windowTo,
      List<String> topHighFodmapFoods});
}

/// @nodoc
class _$RecommendationSupportingDataCopyWithImpl<$Res,
        $Val extends RecommendationSupportingData>
    implements $RecommendationSupportingDataCopyWith<$Res> {
  _$RecommendationSupportingDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationSupportingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symptomCount = null,
    Object? mealCount = null,
    Object? correlationWindowHours = null,
    Object? windowFrom = null,
    Object? windowTo = null,
    Object? topHighFodmapFoods = null,
  }) {
    return _then(_value.copyWith(
      symptomCount: null == symptomCount
          ? _value.symptomCount
          : symptomCount // ignore: cast_nullable_to_non_nullable
              as int,
      mealCount: null == mealCount
          ? _value.mealCount
          : mealCount // ignore: cast_nullable_to_non_nullable
              as int,
      correlationWindowHours: null == correlationWindowHours
          ? _value.correlationWindowHours
          : correlationWindowHours // ignore: cast_nullable_to_non_nullable
              as int,
      windowFrom: null == windowFrom
          ? _value.windowFrom
          : windowFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      windowTo: null == windowTo
          ? _value.windowTo
          : windowTo // ignore: cast_nullable_to_non_nullable
              as DateTime,
      topHighFodmapFoods: null == topHighFodmapFoods
          ? _value.topHighFodmapFoods
          : topHighFodmapFoods // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecommendationSupportingDataImplCopyWith<$Res>
    implements $RecommendationSupportingDataCopyWith<$Res> {
  factory _$$RecommendationSupportingDataImplCopyWith(
          _$RecommendationSupportingDataImpl value,
          $Res Function(_$RecommendationSupportingDataImpl) then) =
      __$$RecommendationSupportingDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int symptomCount,
      int mealCount,
      int correlationWindowHours,
      DateTime windowFrom,
      DateTime windowTo,
      List<String> topHighFodmapFoods});
}

/// @nodoc
class __$$RecommendationSupportingDataImplCopyWithImpl<$Res>
    extends _$RecommendationSupportingDataCopyWithImpl<$Res,
        _$RecommendationSupportingDataImpl>
    implements _$$RecommendationSupportingDataImplCopyWith<$Res> {
  __$$RecommendationSupportingDataImplCopyWithImpl(
      _$RecommendationSupportingDataImpl _value,
      $Res Function(_$RecommendationSupportingDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendationSupportingData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? symptomCount = null,
    Object? mealCount = null,
    Object? correlationWindowHours = null,
    Object? windowFrom = null,
    Object? windowTo = null,
    Object? topHighFodmapFoods = null,
  }) {
    return _then(_$RecommendationSupportingDataImpl(
      symptomCount: null == symptomCount
          ? _value.symptomCount
          : symptomCount // ignore: cast_nullable_to_non_nullable
              as int,
      mealCount: null == mealCount
          ? _value.mealCount
          : mealCount // ignore: cast_nullable_to_non_nullable
              as int,
      correlationWindowHours: null == correlationWindowHours
          ? _value.correlationWindowHours
          : correlationWindowHours // ignore: cast_nullable_to_non_nullable
              as int,
      windowFrom: null == windowFrom
          ? _value.windowFrom
          : windowFrom // ignore: cast_nullable_to_non_nullable
              as DateTime,
      windowTo: null == windowTo
          ? _value.windowTo
          : windowTo // ignore: cast_nullable_to_non_nullable
              as DateTime,
      topHighFodmapFoods: null == topHighFodmapFoods
          ? _value._topHighFodmapFoods
          : topHighFodmapFoods // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$RecommendationSupportingDataImpl extends _RecommendationSupportingData {
  const _$RecommendationSupportingDataImpl(
      {required this.symptomCount,
      required this.mealCount,
      required this.correlationWindowHours,
      required this.windowFrom,
      required this.windowTo,
      final List<String> topHighFodmapFoods = const <String>[]})
      : _topHighFodmapFoods = topHighFodmapFoods,
        super._();

  @override
  final int symptomCount;
  @override
  final int mealCount;
  @override
  final int correlationWindowHours;
  @override
  final DateTime windowFrom;
  @override
  final DateTime windowTo;
  final List<String> _topHighFodmapFoods;
  @override
  @JsonKey()
  List<String> get topHighFodmapFoods {
    if (_topHighFodmapFoods is EqualUnmodifiableListView)
      return _topHighFodmapFoods;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topHighFodmapFoods);
  }

  @override
  String toString() {
    return 'RecommendationSupportingData(symptomCount: $symptomCount, mealCount: $mealCount, correlationWindowHours: $correlationWindowHours, windowFrom: $windowFrom, windowTo: $windowTo, topHighFodmapFoods: $topHighFodmapFoods)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationSupportingDataImpl &&
            (identical(other.symptomCount, symptomCount) ||
                other.symptomCount == symptomCount) &&
            (identical(other.mealCount, mealCount) ||
                other.mealCount == mealCount) &&
            (identical(other.correlationWindowHours, correlationWindowHours) ||
                other.correlationWindowHours == correlationWindowHours) &&
            (identical(other.windowFrom, windowFrom) ||
                other.windowFrom == windowFrom) &&
            (identical(other.windowTo, windowTo) ||
                other.windowTo == windowTo) &&
            const DeepCollectionEquality()
                .equals(other._topHighFodmapFoods, _topHighFodmapFoods));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      symptomCount,
      mealCount,
      correlationWindowHours,
      windowFrom,
      windowTo,
      const DeepCollectionEquality().hash(_topHighFodmapFoods));

  /// Create a copy of RecommendationSupportingData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationSupportingDataImplCopyWith<
          _$RecommendationSupportingDataImpl>
      get copyWith => __$$RecommendationSupportingDataImplCopyWithImpl<
          _$RecommendationSupportingDataImpl>(this, _$identity);
}

abstract class _RecommendationSupportingData
    extends RecommendationSupportingData {
  const factory _RecommendationSupportingData(
          {required final int symptomCount,
          required final int mealCount,
          required final int correlationWindowHours,
          required final DateTime windowFrom,
          required final DateTime windowTo,
          final List<String> topHighFodmapFoods}) =
      _$RecommendationSupportingDataImpl;
  const _RecommendationSupportingData._() : super._();

  @override
  int get symptomCount;
  @override
  int get mealCount;
  @override
  int get correlationWindowHours;
  @override
  DateTime get windowFrom;
  @override
  DateTime get windowTo;
  @override
  List<String> get topHighFodmapFoods;

  /// Create a copy of RecommendationSupportingData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationSupportingDataImplCopyWith<
          _$RecommendationSupportingDataImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecommendationFeedback {
  bool get wasApplied => throw _privateConstructorUsedError;
  FeedbackOutcomeOption get outcome => throw _privateConstructorUsedError;
  DateTime get submittedAt => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationFeedbackCopyWith<RecommendationFeedback> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationFeedbackCopyWith<$Res> {
  factory $RecommendationFeedbackCopyWith(RecommendationFeedback value,
          $Res Function(RecommendationFeedback) then) =
      _$RecommendationFeedbackCopyWithImpl<$Res, RecommendationFeedback>;
  @useResult
  $Res call(
      {bool wasApplied,
      FeedbackOutcomeOption outcome,
      DateTime submittedAt,
      String? comment});
}

/// @nodoc
class _$RecommendationFeedbackCopyWithImpl<$Res,
        $Val extends RecommendationFeedback>
    implements $RecommendationFeedbackCopyWith<$Res> {
  _$RecommendationFeedbackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wasApplied = null,
    Object? outcome = null,
    Object? submittedAt = null,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      wasApplied: null == wasApplied
          ? _value.wasApplied
          : wasApplied // ignore: cast_nullable_to_non_nullable
              as bool,
      outcome: null == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as FeedbackOutcomeOption,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RecommendationFeedbackImplCopyWith<$Res>
    implements $RecommendationFeedbackCopyWith<$Res> {
  factory _$$RecommendationFeedbackImplCopyWith(
          _$RecommendationFeedbackImpl value,
          $Res Function(_$RecommendationFeedbackImpl) then) =
      __$$RecommendationFeedbackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool wasApplied,
      FeedbackOutcomeOption outcome,
      DateTime submittedAt,
      String? comment});
}

/// @nodoc
class __$$RecommendationFeedbackImplCopyWithImpl<$Res>
    extends _$RecommendationFeedbackCopyWithImpl<$Res,
        _$RecommendationFeedbackImpl>
    implements _$$RecommendationFeedbackImplCopyWith<$Res> {
  __$$RecommendationFeedbackImplCopyWithImpl(
      _$RecommendationFeedbackImpl _value,
      $Res Function(_$RecommendationFeedbackImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendationFeedback
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? wasApplied = null,
    Object? outcome = null,
    Object? submittedAt = null,
    Object? comment = freezed,
  }) {
    return _then(_$RecommendationFeedbackImpl(
      wasApplied: null == wasApplied
          ? _value.wasApplied
          : wasApplied // ignore: cast_nullable_to_non_nullable
              as bool,
      outcome: null == outcome
          ? _value.outcome
          : outcome // ignore: cast_nullable_to_non_nullable
              as FeedbackOutcomeOption,
      submittedAt: null == submittedAt
          ? _value.submittedAt
          : submittedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$RecommendationFeedbackImpl implements _RecommendationFeedback {
  const _$RecommendationFeedbackImpl(
      {required this.wasApplied,
      required this.outcome,
      required this.submittedAt,
      this.comment});

  @override
  final bool wasApplied;
  @override
  final FeedbackOutcomeOption outcome;
  @override
  final DateTime submittedAt;
  @override
  final String? comment;

  @override
  String toString() {
    return 'RecommendationFeedback(wasApplied: $wasApplied, outcome: $outcome, submittedAt: $submittedAt, comment: $comment)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationFeedbackImpl &&
            (identical(other.wasApplied, wasApplied) ||
                other.wasApplied == wasApplied) &&
            (identical(other.outcome, outcome) || other.outcome == outcome) &&
            (identical(other.submittedAt, submittedAt) ||
                other.submittedAt == submittedAt) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, wasApplied, outcome, submittedAt, comment);

  /// Create a copy of RecommendationFeedback
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationFeedbackImplCopyWith<_$RecommendationFeedbackImpl>
      get copyWith => __$$RecommendationFeedbackImplCopyWithImpl<
          _$RecommendationFeedbackImpl>(this, _$identity);
}

abstract class _RecommendationFeedback implements RecommendationFeedback {
  const factory _RecommendationFeedback(
      {required final bool wasApplied,
      required final FeedbackOutcomeOption outcome,
      required final DateTime submittedAt,
      final String? comment}) = _$RecommendationFeedbackImpl;

  @override
  bool get wasApplied;
  @override
  FeedbackOutcomeOption get outcome;
  @override
  DateTime get submittedAt;
  @override
  String? get comment;

  /// Create a copy of RecommendationFeedback
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationFeedbackImplCopyWith<_$RecommendationFeedbackImpl>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RecommendationDetail {
  String get id => throw _privateConstructorUsedError;
  RecommendationStatusOption get status => throw _privateConstructorUsedError;
  double get confidenceScore => throw _privateConstructorUsedError;
  DateTime get generatedAt => throw _privateConstructorUsedError;
  bool get autoApproved => throw _privateConstructorUsedError;
  String? get reviewerId => throw _privateConstructorUsedError;
  String? get reviewerName => throw _privateConstructorUsedError;
  String? get nutritionistNote => throw _privateConstructorUsedError;
  String? get explanation => throw _privateConstructorUsedError;
  ExplanationOrigin? get explanationSource =>
      throw _privateConstructorUsedError;
  DateTime? get reviewedAt => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  DateTime? get expiresAt => throw _privateConstructorUsedError;
  List<RecommendationItem> get items => throw _privateConstructorUsedError;
  List<String> get steps => throw _privateConstructorUsedError;
  RecommendationSupportingData? get supportingData =>
      throw _privateConstructorUsedError;
  RecommendationFeedback? get feedback => throw _privateConstructorUsedError;

  /// Origen que este dispositivo vio antes de la entrega, cuando lo sabe.
  ///
  /// El contrato lo pierde al entregar (ver [RecommendationOrigin.resolve]);
  /// lo completa la capa de aplicacion con lo que observo antes.
  RecommendationOrigin? get knownOrigin => throw _privateConstructorUsedError;

  /// Create a copy of RecommendationDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RecommendationDetailCopyWith<RecommendationDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RecommendationDetailCopyWith<$Res> {
  factory $RecommendationDetailCopyWith(RecommendationDetail value,
          $Res Function(RecommendationDetail) then) =
      _$RecommendationDetailCopyWithImpl<$Res, RecommendationDetail>;
  @useResult
  $Res call(
      {String id,
      RecommendationStatusOption status,
      double confidenceScore,
      DateTime generatedAt,
      bool autoApproved,
      String? reviewerId,
      String? reviewerName,
      String? nutritionistNote,
      String? explanation,
      ExplanationOrigin? explanationSource,
      DateTime? reviewedAt,
      DateTime? deliveredAt,
      DateTime? expiresAt,
      List<RecommendationItem> items,
      List<String> steps,
      RecommendationSupportingData? supportingData,
      RecommendationFeedback? feedback,
      RecommendationOrigin? knownOrigin});

  $RecommendationSupportingDataCopyWith<$Res>? get supportingData;
  $RecommendationFeedbackCopyWith<$Res>? get feedback;
}

/// @nodoc
class _$RecommendationDetailCopyWithImpl<$Res,
        $Val extends RecommendationDetail>
    implements $RecommendationDetailCopyWith<$Res> {
  _$RecommendationDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RecommendationDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? confidenceScore = null,
    Object? generatedAt = null,
    Object? autoApproved = null,
    Object? reviewerId = freezed,
    Object? reviewerName = freezed,
    Object? nutritionistNote = freezed,
    Object? explanation = freezed,
    Object? explanationSource = freezed,
    Object? reviewedAt = freezed,
    Object? deliveredAt = freezed,
    Object? expiresAt = freezed,
    Object? items = null,
    Object? steps = null,
    Object? supportingData = freezed,
    Object? feedback = freezed,
    Object? knownOrigin = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecommendationStatusOption,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      autoApproved: null == autoApproved
          ? _value.autoApproved
          : autoApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      reviewerId: freezed == reviewerId
          ? _value.reviewerId
          : reviewerId // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewerName: freezed == reviewerName
          ? _value.reviewerName
          : reviewerName // ignore: cast_nullable_to_non_nullable
              as String?,
      nutritionistNote: freezed == nutritionistNote
          ? _value.nutritionistNote
          : nutritionistNote // ignore: cast_nullable_to_non_nullable
              as String?,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      explanationSource: freezed == explanationSource
          ? _value.explanationSource
          : explanationSource // ignore: cast_nullable_to_non_nullable
              as ExplanationOrigin?,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RecommendationItem>,
      steps: null == steps
          ? _value.steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      supportingData: freezed == supportingData
          ? _value.supportingData
          : supportingData // ignore: cast_nullable_to_non_nullable
              as RecommendationSupportingData?,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as RecommendationFeedback?,
      knownOrigin: freezed == knownOrigin
          ? _value.knownOrigin
          : knownOrigin // ignore: cast_nullable_to_non_nullable
              as RecommendationOrigin?,
    ) as $Val);
  }

  /// Create a copy of RecommendationDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecommendationSupportingDataCopyWith<$Res>? get supportingData {
    if (_value.supportingData == null) {
      return null;
    }

    return $RecommendationSupportingDataCopyWith<$Res>(_value.supportingData!,
        (value) {
      return _then(_value.copyWith(supportingData: value) as $Val);
    });
  }

  /// Create a copy of RecommendationDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RecommendationFeedbackCopyWith<$Res>? get feedback {
    if (_value.feedback == null) {
      return null;
    }

    return $RecommendationFeedbackCopyWith<$Res>(_value.feedback!, (value) {
      return _then(_value.copyWith(feedback: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$RecommendationDetailImplCopyWith<$Res>
    implements $RecommendationDetailCopyWith<$Res> {
  factory _$$RecommendationDetailImplCopyWith(_$RecommendationDetailImpl value,
          $Res Function(_$RecommendationDetailImpl) then) =
      __$$RecommendationDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      RecommendationStatusOption status,
      double confidenceScore,
      DateTime generatedAt,
      bool autoApproved,
      String? reviewerId,
      String? reviewerName,
      String? nutritionistNote,
      String? explanation,
      ExplanationOrigin? explanationSource,
      DateTime? reviewedAt,
      DateTime? deliveredAt,
      DateTime? expiresAt,
      List<RecommendationItem> items,
      List<String> steps,
      RecommendationSupportingData? supportingData,
      RecommendationFeedback? feedback,
      RecommendationOrigin? knownOrigin});

  @override
  $RecommendationSupportingDataCopyWith<$Res>? get supportingData;
  @override
  $RecommendationFeedbackCopyWith<$Res>? get feedback;
}

/// @nodoc
class __$$RecommendationDetailImplCopyWithImpl<$Res>
    extends _$RecommendationDetailCopyWithImpl<$Res, _$RecommendationDetailImpl>
    implements _$$RecommendationDetailImplCopyWith<$Res> {
  __$$RecommendationDetailImplCopyWithImpl(_$RecommendationDetailImpl _value,
      $Res Function(_$RecommendationDetailImpl) _then)
      : super(_value, _then);

  /// Create a copy of RecommendationDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? confidenceScore = null,
    Object? generatedAt = null,
    Object? autoApproved = null,
    Object? reviewerId = freezed,
    Object? reviewerName = freezed,
    Object? nutritionistNote = freezed,
    Object? explanation = freezed,
    Object? explanationSource = freezed,
    Object? reviewedAt = freezed,
    Object? deliveredAt = freezed,
    Object? expiresAt = freezed,
    Object? items = null,
    Object? steps = null,
    Object? supportingData = freezed,
    Object? feedback = freezed,
    Object? knownOrigin = freezed,
  }) {
    return _then(_$RecommendationDetailImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RecommendationStatusOption,
      confidenceScore: null == confidenceScore
          ? _value.confidenceScore
          : confidenceScore // ignore: cast_nullable_to_non_nullable
              as double,
      generatedAt: null == generatedAt
          ? _value.generatedAt
          : generatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      autoApproved: null == autoApproved
          ? _value.autoApproved
          : autoApproved // ignore: cast_nullable_to_non_nullable
              as bool,
      reviewerId: freezed == reviewerId
          ? _value.reviewerId
          : reviewerId // ignore: cast_nullable_to_non_nullable
              as String?,
      reviewerName: freezed == reviewerName
          ? _value.reviewerName
          : reviewerName // ignore: cast_nullable_to_non_nullable
              as String?,
      nutritionistNote: freezed == nutritionistNote
          ? _value.nutritionistNote
          : nutritionistNote // ignore: cast_nullable_to_non_nullable
              as String?,
      explanation: freezed == explanation
          ? _value.explanation
          : explanation // ignore: cast_nullable_to_non_nullable
              as String?,
      explanationSource: freezed == explanationSource
          ? _value.explanationSource
          : explanationSource // ignore: cast_nullable_to_non_nullable
              as ExplanationOrigin?,
      reviewedAt: freezed == reviewedAt
          ? _value.reviewedAt
          : reviewedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      expiresAt: freezed == expiresAt
          ? _value.expiresAt
          : expiresAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<RecommendationItem>,
      steps: null == steps
          ? _value._steps
          : steps // ignore: cast_nullable_to_non_nullable
              as List<String>,
      supportingData: freezed == supportingData
          ? _value.supportingData
          : supportingData // ignore: cast_nullable_to_non_nullable
              as RecommendationSupportingData?,
      feedback: freezed == feedback
          ? _value.feedback
          : feedback // ignore: cast_nullable_to_non_nullable
              as RecommendationFeedback?,
      knownOrigin: freezed == knownOrigin
          ? _value.knownOrigin
          : knownOrigin // ignore: cast_nullable_to_non_nullable
              as RecommendationOrigin?,
    ));
  }
}

/// @nodoc

class _$RecommendationDetailImpl extends _RecommendationDetail {
  const _$RecommendationDetailImpl(
      {required this.id,
      required this.status,
      required this.confidenceScore,
      required this.generatedAt,
      this.autoApproved = false,
      this.reviewerId,
      this.reviewerName,
      this.nutritionistNote,
      this.explanation,
      this.explanationSource,
      this.reviewedAt,
      this.deliveredAt,
      this.expiresAt,
      final List<RecommendationItem> items = const <RecommendationItem>[],
      final List<String> steps = const <String>[],
      this.supportingData,
      this.feedback,
      this.knownOrigin})
      : _items = items,
        _steps = steps,
        super._();

  @override
  final String id;
  @override
  final RecommendationStatusOption status;
  @override
  final double confidenceScore;
  @override
  final DateTime generatedAt;
  @override
  @JsonKey()
  final bool autoApproved;
  @override
  final String? reviewerId;
  @override
  final String? reviewerName;
  @override
  final String? nutritionistNote;
  @override
  final String? explanation;
  @override
  final ExplanationOrigin? explanationSource;
  @override
  final DateTime? reviewedAt;
  @override
  final DateTime? deliveredAt;
  @override
  final DateTime? expiresAt;
  final List<RecommendationItem> _items;
  @override
  @JsonKey()
  List<RecommendationItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  final List<String> _steps;
  @override
  @JsonKey()
  List<String> get steps {
    if (_steps is EqualUnmodifiableListView) return _steps;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_steps);
  }

  @override
  final RecommendationSupportingData? supportingData;
  @override
  final RecommendationFeedback? feedback;

  /// Origen que este dispositivo vio antes de la entrega, cuando lo sabe.
  ///
  /// El contrato lo pierde al entregar (ver [RecommendationOrigin.resolve]);
  /// lo completa la capa de aplicacion con lo que observo antes.
  @override
  final RecommendationOrigin? knownOrigin;

  @override
  String toString() {
    return 'RecommendationDetail(id: $id, status: $status, confidenceScore: $confidenceScore, generatedAt: $generatedAt, autoApproved: $autoApproved, reviewerId: $reviewerId, reviewerName: $reviewerName, nutritionistNote: $nutritionistNote, explanation: $explanation, explanationSource: $explanationSource, reviewedAt: $reviewedAt, deliveredAt: $deliveredAt, expiresAt: $expiresAt, items: $items, steps: $steps, supportingData: $supportingData, feedback: $feedback, knownOrigin: $knownOrigin)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RecommendationDetailImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.confidenceScore, confidenceScore) ||
                other.confidenceScore == confidenceScore) &&
            (identical(other.generatedAt, generatedAt) ||
                other.generatedAt == generatedAt) &&
            (identical(other.autoApproved, autoApproved) ||
                other.autoApproved == autoApproved) &&
            (identical(other.reviewerId, reviewerId) ||
                other.reviewerId == reviewerId) &&
            (identical(other.reviewerName, reviewerName) ||
                other.reviewerName == reviewerName) &&
            (identical(other.nutritionistNote, nutritionistNote) ||
                other.nutritionistNote == nutritionistNote) &&
            (identical(other.explanation, explanation) ||
                other.explanation == explanation) &&
            (identical(other.explanationSource, explanationSource) ||
                other.explanationSource == explanationSource) &&
            (identical(other.reviewedAt, reviewedAt) ||
                other.reviewedAt == reviewedAt) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other._steps, _steps) &&
            (identical(other.supportingData, supportingData) ||
                other.supportingData == supportingData) &&
            (identical(other.feedback, feedback) ||
                other.feedback == feedback) &&
            (identical(other.knownOrigin, knownOrigin) ||
                other.knownOrigin == knownOrigin));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      confidenceScore,
      generatedAt,
      autoApproved,
      reviewerId,
      reviewerName,
      nutritionistNote,
      explanation,
      explanationSource,
      reviewedAt,
      deliveredAt,
      expiresAt,
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_steps),
      supportingData,
      feedback,
      knownOrigin);

  /// Create a copy of RecommendationDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RecommendationDetailImplCopyWith<_$RecommendationDetailImpl>
      get copyWith =>
          __$$RecommendationDetailImplCopyWithImpl<_$RecommendationDetailImpl>(
              this, _$identity);
}

abstract class _RecommendationDetail extends RecommendationDetail {
  const factory _RecommendationDetail(
      {required final String id,
      required final RecommendationStatusOption status,
      required final double confidenceScore,
      required final DateTime generatedAt,
      final bool autoApproved,
      final String? reviewerId,
      final String? reviewerName,
      final String? nutritionistNote,
      final String? explanation,
      final ExplanationOrigin? explanationSource,
      final DateTime? reviewedAt,
      final DateTime? deliveredAt,
      final DateTime? expiresAt,
      final List<RecommendationItem> items,
      final List<String> steps,
      final RecommendationSupportingData? supportingData,
      final RecommendationFeedback? feedback,
      final RecommendationOrigin? knownOrigin}) = _$RecommendationDetailImpl;
  const _RecommendationDetail._() : super._();

  @override
  String get id;
  @override
  RecommendationStatusOption get status;
  @override
  double get confidenceScore;
  @override
  DateTime get generatedAt;
  @override
  bool get autoApproved;
  @override
  String? get reviewerId;
  @override
  String? get reviewerName;
  @override
  String? get nutritionistNote;
  @override
  String? get explanation;
  @override
  ExplanationOrigin? get explanationSource;
  @override
  DateTime? get reviewedAt;
  @override
  DateTime? get deliveredAt;
  @override
  DateTime? get expiresAt;
  @override
  List<RecommendationItem> get items;
  @override
  List<String> get steps;
  @override
  RecommendationSupportingData? get supportingData;
  @override
  RecommendationFeedback? get feedback;

  /// Origen que este dispositivo vio antes de la entrega, cuando lo sabe.
  ///
  /// El contrato lo pierde al entregar (ver [RecommendationOrigin.resolve]);
  /// lo completa la capa de aplicacion con lo que observo antes.
  @override
  RecommendationOrigin? get knownOrigin;

  /// Create a copy of RecommendationDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RecommendationDetailImplCopyWith<_$RecommendationDetailImpl>
      get copyWith => throw _privateConstructorUsedError;
}
