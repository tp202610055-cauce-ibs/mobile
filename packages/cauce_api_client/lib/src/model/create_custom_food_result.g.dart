// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_custom_food_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateCustomFoodResult extends CreateCustomFoodResult {
  @override
  final String? customFoodId;

  factory _$CreateCustomFoodResult(
          [void Function(CreateCustomFoodResultBuilder)? updates]) =>
      (CreateCustomFoodResultBuilder()..update(updates))._build();

  _$CreateCustomFoodResult._({this.customFoodId}) : super._();
  @override
  CreateCustomFoodResult rebuild(
          void Function(CreateCustomFoodResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateCustomFoodResultBuilder toBuilder() =>
      CreateCustomFoodResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateCustomFoodResult &&
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
    return (newBuiltValueToStringHelper(r'CreateCustomFoodResult')
          ..add('customFoodId', customFoodId))
        .toString();
  }
}

class CreateCustomFoodResultBuilder
    implements Builder<CreateCustomFoodResult, CreateCustomFoodResultBuilder> {
  _$CreateCustomFoodResult? _$v;

  String? _customFoodId;
  String? get customFoodId => _$this._customFoodId;
  set customFoodId(String? customFoodId) => _$this._customFoodId = customFoodId;

  CreateCustomFoodResultBuilder() {
    CreateCustomFoodResult._defaults(this);
  }

  CreateCustomFoodResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _customFoodId = $v.customFoodId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateCustomFoodResult other) {
    _$v = other as _$CreateCustomFoodResult;
  }

  @override
  void update(void Function(CreateCustomFoodResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateCustomFoodResult build() => _build();

  _$CreateCustomFoodResult _build() {
    final _$result = _$v ??
        _$CreateCustomFoodResult._(
          customFoodId: customFoodId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
