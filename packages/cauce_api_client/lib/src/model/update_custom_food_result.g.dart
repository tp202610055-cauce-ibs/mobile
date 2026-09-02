// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_custom_food_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$UpdateCustomFoodResult extends UpdateCustomFoodResult {
  @override
  final String? customFoodId;

  factory _$UpdateCustomFoodResult(
          [void Function(UpdateCustomFoodResultBuilder)? updates]) =>
      (UpdateCustomFoodResultBuilder()..update(updates))._build();

  _$UpdateCustomFoodResult._({this.customFoodId}) : super._();
  @override
  UpdateCustomFoodResult rebuild(
          void Function(UpdateCustomFoodResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateCustomFoodResultBuilder toBuilder() =>
      UpdateCustomFoodResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateCustomFoodResult &&
        customFoodId == other.customFoodId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, customFoodId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'UpdateCustomFoodResult')
          ..add('customFoodId', customFoodId))
        .toString();
  }
}

class UpdateCustomFoodResultBuilder
    implements Builder<UpdateCustomFoodResult, UpdateCustomFoodResultBuilder> {
  _$UpdateCustomFoodResult? _$v;

  String? _customFoodId;
  String? get customFoodId => _$this._customFoodId;
  set customFoodId(String? customFoodId) => _$this._customFoodId = customFoodId;

  UpdateCustomFoodResultBuilder() {
    UpdateCustomFoodResult._defaults(this);
  }

  UpdateCustomFoodResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _customFoodId = $v.customFoodId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateCustomFoodResult other) {
    _$v = other as _$UpdateCustomFoodResult;
  }

  @override
  void update(void Function(UpdateCustomFoodResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateCustomFoodResult build() => _build();

  _$UpdateCustomFoodResult _build() {
    final _$result = _$v ??
        _$UpdateCustomFoodResult._(
          customFoodId: customFoodId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
