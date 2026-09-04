// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modify_recommendation_item_input.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ModifyRecommendationItemInput extends ModifyRecommendationItemInput {
  @override
  final String? foodId;
  @override
  final ActionType? actionType;
  @override
  final String? reasoning;
  @override
  final String? substituteFoodId;

  factory _$ModifyRecommendationItemInput(
          [void Function(ModifyRecommendationItemInputBuilder)? updates]) =>
      (ModifyRecommendationItemInputBuilder()..update(updates))._build();

  _$ModifyRecommendationItemInput._(
      {this.foodId, this.actionType, this.reasoning, this.substituteFoodId})
      : super._();
  @override
  ModifyRecommendationItemInput rebuild(
          void Function(ModifyRecommendationItemInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ModifyRecommendationItemInputBuilder toBuilder() =>
      ModifyRecommendationItemInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ModifyRecommendationItemInput &&
        foodId == other.foodId &&
        actionType == other.actionType &&
        reasoning == other.reasoning &&
        substituteFoodId == other.substituteFoodId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, foodId.hashCode);
    _$hash = $jc(_$hash, actionType.hashCode);
    _$hash = $jc(_$hash, reasoning.hashCode);
    _$hash = $jc(_$hash, substituteFoodId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ModifyRecommendationItemInput')
          ..add('foodId', foodId)
          ..add('actionType', actionType)
          ..add('reasoning', reasoning)
          ..add('substituteFoodId', substituteFoodId))
        .toString();
  }
}

class ModifyRecommendationItemInputBuilder
    implements
        Builder<ModifyRecommendationItemInput,
            ModifyRecommendationItemInputBuilder> {
  _$ModifyRecommendationItemInput? _$v;

  String? _foodId;
  String? get foodId => _$this._foodId;
  set foodId(String? foodId) => _$this._foodId = foodId;

  ActionType? _actionType;
  ActionType? get actionType => _$this._actionType;
  set actionType(ActionType? actionType) => _$this._actionType = actionType;

  String? _reasoning;
  String? get reasoning => _$this._reasoning;
  set reasoning(String? reasoning) => _$this._reasoning = reasoning;

  String? _substituteFoodId;
  String? get substituteFoodId => _$this._substituteFoodId;
  set substituteFoodId(String? substituteFoodId) =>
      _$this._substituteFoodId = substituteFoodId;

  ModifyRecommendationItemInputBuilder() {
    ModifyRecommendationItemInput._defaults(this);
  }

  ModifyRecommendationItemInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _foodId = $v.foodId;
      _actionType = $v.actionType;
      _reasoning = $v.reasoning;
      _substituteFoodId = $v.substituteFoodId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ModifyRecommendationItemInput other) {
    _$v = other as _$ModifyRecommendationItemInput;
  }

  @override
  void update(void Function(ModifyRecommendationItemInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ModifyRecommendationItemInput build() => _build();

  _$ModifyRecommendationItemInput _build() {
    final _$result = _$v ??
        _$ModifyRecommendationItemInput._(
          foodId: foodId,
          actionType: actionType,
          reasoning: reasoning,
          substituteFoodId: substituteFoodId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
