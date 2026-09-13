// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_nutritionist_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssignNutritionistResult extends AssignNutritionistResult {
  @override
  final String? nutritionistId;
  @override
  final String? nutritionistFullName;
  @override
  final DateTime? assignedAt;

  factory _$AssignNutritionistResult(
          [void Function(AssignNutritionistResultBuilder)? updates]) =>
      (AssignNutritionistResultBuilder()..update(updates))._build();

  _$AssignNutritionistResult._(
      {this.nutritionistId, this.nutritionistFullName, this.assignedAt})
      : super._();
  @override
  AssignNutritionistResult rebuild(
          void Function(AssignNutritionistResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssignNutritionistResultBuilder toBuilder() =>
      AssignNutritionistResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignNutritionistResult &&
        nutritionistId == other.nutritionistId &&
        nutritionistFullName == other.nutritionistFullName &&
        assignedAt == other.assignedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, nutritionistId.hashCode);
    _$hash = $jc(_$hash, nutritionistFullName.hashCode);
    _$hash = $jc(_$hash, assignedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssignNutritionistResult')
          ..add('nutritionistId', nutritionistId)
          ..add('nutritionistFullName', nutritionistFullName)
          ..add('assignedAt', assignedAt))
        .toString();
  }
}

class AssignNutritionistResultBuilder
    implements
        Builder<AssignNutritionistResult, AssignNutritionistResultBuilder> {
  _$AssignNutritionistResult? _$v;

  String? _nutritionistId;
  String? get nutritionistId => _$this._nutritionistId;
  set nutritionistId(String? nutritionistId) =>
      _$this._nutritionistId = nutritionistId;

  String? _nutritionistFullName;
  String? get nutritionistFullName => _$this._nutritionistFullName;
  set nutritionistFullName(String? nutritionistFullName) =>
      _$this._nutritionistFullName = nutritionistFullName;

  DateTime? _assignedAt;
  DateTime? get assignedAt => _$this._assignedAt;
  set assignedAt(DateTime? assignedAt) => _$this._assignedAt = assignedAt;

  AssignNutritionistResultBuilder() {
    AssignNutritionistResult._defaults(this);
  }

  AssignNutritionistResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nutritionistId = $v.nutritionistId;
      _nutritionistFullName = $v.nutritionistFullName;
      _assignedAt = $v.assignedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignNutritionistResult other) {
    _$v = other as _$AssignNutritionistResult;
  }

  @override
  void update(void Function(AssignNutritionistResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssignNutritionistResult build() => _build();

  _$AssignNutritionistResult _build() {
    final _$result = _$v ??
        _$AssignNutritionistResult._(
          nutritionistId: nutritionistId,
          nutritionistFullName: nutritionistFullName,
          assignedAt: assignedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
