// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_meal_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateMealResult extends CreateMealResult {
  @override
  final String? mealId;
  @override
  final FodmapLevel? aggregatedFodmap;

  factory _$CreateMealResult(
          [void Function(CreateMealResultBuilder)? updates]) =>
      (CreateMealResultBuilder()..update(updates))._build();

  _$CreateMealResult._({this.mealId, this.aggregatedFodmap}) : super._();
  @override
  CreateMealResult rebuild(void Function(CreateMealResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateMealResultBuilder toBuilder() =>
      CreateMealResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateMealResult &&
        mealId == other.mealId &&
        aggregatedFodmap == other.aggregatedFodmap;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mealId.hashCode);
    _$hash = $jc(_$hash, aggregatedFodmap.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateMealResult')
          ..add('mealId', mealId)
          ..add('aggregatedFodmap', aggregatedFodmap))
        .toString();
  }
}

class CreateMealResultBuilder
    implements Builder<CreateMealResult, CreateMealResultBuilder> {
  _$CreateMealResult? _$v;

  String? _mealId;
  String? get mealId => _$this._mealId;
  set mealId(String? mealId) => _$this._mealId = mealId;

  FodmapLevel? _aggregatedFodmap;
  FodmapLevel? get aggregatedFodmap => _$this._aggregatedFodmap;
  set aggregatedFodmap(FodmapLevel? aggregatedFodmap) =>
      _$this._aggregatedFodmap = aggregatedFodmap;

  CreateMealResultBuilder() {
    CreateMealResult._defaults(this);
  }

  CreateMealResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mealId = $v.mealId;
      _aggregatedFodmap = $v.aggregatedFodmap;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateMealResult other) {
    _$v = other as _$CreateMealResult;
  }

  @override
  void update(void Function(CreateMealResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateMealResult build() => _build();

  _$CreateMealResult _build() {
    final _$result = _$v ??
        _$CreateMealResult._(
          mealId: mealId,
          aggregatedFodmap: aggregatedFodmap,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
