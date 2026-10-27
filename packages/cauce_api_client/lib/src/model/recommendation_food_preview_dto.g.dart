// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_food_preview_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecommendationFoodPreviewDto extends RecommendationFoodPreviewDto {
  @override
  final String? foodName;
  @override
  final ActionType? actionType;
  @override
  final String? substituteFoodName;

  factory _$RecommendationFoodPreviewDto(
          [void Function(RecommendationFoodPreviewDtoBuilder)? updates]) =>
      (RecommendationFoodPreviewDtoBuilder()..update(updates))._build();

  _$RecommendationFoodPreviewDto._(
      {this.foodName, this.actionType, this.substituteFoodName})
      : super._();
  @override
  RecommendationFoodPreviewDto rebuild(
          void Function(RecommendationFoodPreviewDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecommendationFoodPreviewDtoBuilder toBuilder() =>
      RecommendationFoodPreviewDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecommendationFoodPreviewDto &&
        foodName == other.foodName &&
        actionType == other.actionType &&
        substituteFoodName == other.substituteFoodName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, foodName.hashCode);
    _$hash = $jc(_$hash, actionType.hashCode);
    _$hash = $jc(_$hash, substituteFoodName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecommendationFoodPreviewDto')
          ..add('foodName', foodName)
          ..add('actionType', actionType)
          ..add('substituteFoodName', substituteFoodName))
        .toString();
  }
}

class RecommendationFoodPreviewDtoBuilder
    implements
        Builder<RecommendationFoodPreviewDto,
            RecommendationFoodPreviewDtoBuilder> {
  _$RecommendationFoodPreviewDto? _$v;

  String? _foodName;
  String? get foodName => _$this._foodName;
  set foodName(String? foodName) => _$this._foodName = foodName;

  ActionType? _actionType;
  ActionType? get actionType => _$this._actionType;
  set actionType(ActionType? actionType) => _$this._actionType = actionType;

  String? _substituteFoodName;
  String? get substituteFoodName => _$this._substituteFoodName;
  set substituteFoodName(String? substituteFoodName) =>
      _$this._substituteFoodName = substituteFoodName;

  RecommendationFoodPreviewDtoBuilder() {
    RecommendationFoodPreviewDto._defaults(this);
  }

  RecommendationFoodPreviewDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _foodName = $v.foodName;
      _actionType = $v.actionType;
      _substituteFoodName = $v.substituteFoodName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecommendationFoodPreviewDto other) {
    _$v = other as _$RecommendationFoodPreviewDto;
  }

  @override
  void update(void Function(RecommendationFoodPreviewDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecommendationFoodPreviewDto build() => _build();

  _$RecommendationFoodPreviewDto _build() {
    final _$result = _$v ??
        _$RecommendationFoodPreviewDto._(
          foodName: foodName,
          actionType: actionType,
          substituteFoodName: substituteFoodName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
