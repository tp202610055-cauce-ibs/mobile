// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_item_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecommendationItemDto extends RecommendationItemDto {
  @override
  final String? recommendationItemId;
  @override
  final String? foodId;
  @override
  final String? foodName;
  @override
  final String? category;
  @override
  final ActionType? actionType;
  @override
  final String? substituteFoodId;
  @override
  final String? substituteFoodName;
  @override
  final String? reasoning;

  factory _$RecommendationItemDto(
          [void Function(RecommendationItemDtoBuilder)? updates]) =>
      (RecommendationItemDtoBuilder()..update(updates))._build();

  _$RecommendationItemDto._(
      {this.recommendationItemId,
      this.foodId,
      this.foodName,
      this.category,
      this.actionType,
      this.substituteFoodId,
      this.substituteFoodName,
      this.reasoning})
      : super._();
  @override
  RecommendationItemDto rebuild(
          void Function(RecommendationItemDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecommendationItemDtoBuilder toBuilder() =>
      RecommendationItemDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecommendationItemDto &&
        recommendationItemId == other.recommendationItemId &&
        foodId == other.foodId &&
        foodName == other.foodName &&
        category == other.category &&
        actionType == other.actionType &&
        substituteFoodId == other.substituteFoodId &&
        substituteFoodName == other.substituteFoodName &&
        reasoning == other.reasoning;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recommendationItemId.hashCode);
    _$hash = $jc(_$hash, foodId.hashCode);
    _$hash = $jc(_$hash, foodName.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, actionType.hashCode);
    _$hash = $jc(_$hash, substituteFoodId.hashCode);
    _$hash = $jc(_$hash, substituteFoodName.hashCode);
    _$hash = $jc(_$hash, reasoning.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecommendationItemDto')
          ..add('recommendationItemId', recommendationItemId)
          ..add('foodId', foodId)
          ..add('foodName', foodName)
          ..add('category', category)
          ..add('actionType', actionType)
          ..add('substituteFoodId', substituteFoodId)
          ..add('substituteFoodName', substituteFoodName)
          ..add('reasoning', reasoning))
        .toString();
  }
}

class RecommendationItemDtoBuilder
    implements Builder<RecommendationItemDto, RecommendationItemDtoBuilder> {
  _$RecommendationItemDto? _$v;

  String? _recommendationItemId;
  String? get recommendationItemId => _$this._recommendationItemId;
  set recommendationItemId(String? recommendationItemId) =>
      _$this._recommendationItemId = recommendationItemId;

  String? _foodId;
  String? get foodId => _$this._foodId;
  set foodId(String? foodId) => _$this._foodId = foodId;

  String? _foodName;
  String? get foodName => _$this._foodName;
  set foodName(String? foodName) => _$this._foodName = foodName;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  ActionType? _actionType;
  ActionType? get actionType => _$this._actionType;
  set actionType(ActionType? actionType) => _$this._actionType = actionType;

  String? _substituteFoodId;
  String? get substituteFoodId => _$this._substituteFoodId;
  set substituteFoodId(String? substituteFoodId) =>
      _$this._substituteFoodId = substituteFoodId;

  String? _substituteFoodName;
  String? get substituteFoodName => _$this._substituteFoodName;
  set substituteFoodName(String? substituteFoodName) =>
      _$this._substituteFoodName = substituteFoodName;

  String? _reasoning;
  String? get reasoning => _$this._reasoning;
  set reasoning(String? reasoning) => _$this._reasoning = reasoning;

  RecommendationItemDtoBuilder() {
    RecommendationItemDto._defaults(this);
  }

  RecommendationItemDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recommendationItemId = $v.recommendationItemId;
      _foodId = $v.foodId;
      _foodName = $v.foodName;
      _category = $v.category;
      _actionType = $v.actionType;
      _substituteFoodId = $v.substituteFoodId;
      _substituteFoodName = $v.substituteFoodName;
      _reasoning = $v.reasoning;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecommendationItemDto other) {
    _$v = other as _$RecommendationItemDto;
  }

  @override
  void update(void Function(RecommendationItemDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecommendationItemDto build() => _build();

  _$RecommendationItemDto _build() {
    final _$result = _$v ??
        _$RecommendationItemDto._(
          recommendationItemId: recommendationItemId,
          foodId: foodId,
          foodName: foodName,
          category: category,
          actionType: actionType,
          substituteFoodId: substituteFoodId,
          substituteFoodName: substituteFoodName,
          reasoning: reasoning,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
