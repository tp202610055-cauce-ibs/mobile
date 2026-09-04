// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritionist_assignment_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NutritionistAssignmentSummary extends NutritionistAssignmentSummary {
  @override
  final String? assignmentId;
  @override
  final String? nutritionistUserId;
  @override
  final String? nutritionistFullName;
  @override
  final DateTime? assignedAt;

  factory _$NutritionistAssignmentSummary(
          [void Function(NutritionistAssignmentSummaryBuilder)? updates]) =>
      (NutritionistAssignmentSummaryBuilder()..update(updates))._build();

  _$NutritionistAssignmentSummary._(
      {this.assignmentId,
      this.nutritionistUserId,
      this.nutritionistFullName,
      this.assignedAt})
      : super._();
  @override
  NutritionistAssignmentSummary rebuild(
          void Function(NutritionistAssignmentSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NutritionistAssignmentSummaryBuilder toBuilder() =>
      NutritionistAssignmentSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NutritionistAssignmentSummary &&
        assignmentId == other.assignmentId &&
        nutritionistUserId == other.nutritionistUserId &&
        nutritionistFullName == other.nutritionistFullName &&
        assignedAt == other.assignedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assignmentId.hashCode);
    _$hash = $jc(_$hash, nutritionistUserId.hashCode);
    _$hash = $jc(_$hash, nutritionistFullName.hashCode);
    _$hash = $jc(_$hash, assignedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NutritionistAssignmentSummary')
          ..add('assignmentId', assignmentId)
          ..add('nutritionistUserId', nutritionistUserId)
          ..add('nutritionistFullName', nutritionistFullName)
          ..add('assignedAt', assignedAt))
        .toString();
  }
}

class NutritionistAssignmentSummaryBuilder
    implements
        Builder<NutritionistAssignmentSummary,
            NutritionistAssignmentSummaryBuilder> {
  _$NutritionistAssignmentSummary? _$v;

  String? _assignmentId;
  String? get assignmentId => _$this._assignmentId;
  set assignmentId(String? assignmentId) => _$this._assignmentId = assignmentId;

  String? _nutritionistUserId;
  String? get nutritionistUserId => _$this._nutritionistUserId;
  set nutritionistUserId(String? nutritionistUserId) =>
      _$this._nutritionistUserId = nutritionistUserId;

  String? _nutritionistFullName;
  String? get nutritionistFullName => _$this._nutritionistFullName;
  set nutritionistFullName(String? nutritionistFullName) =>
      _$this._nutritionistFullName = nutritionistFullName;

  DateTime? _assignedAt;
  DateTime? get assignedAt => _$this._assignedAt;
  set assignedAt(DateTime? assignedAt) => _$this._assignedAt = assignedAt;

  NutritionistAssignmentSummaryBuilder() {
    NutritionistAssignmentSummary._defaults(this);
  }

  NutritionistAssignmentSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assignmentId = $v.assignmentId;
      _nutritionistUserId = $v.nutritionistUserId;
      _nutritionistFullName = $v.nutritionistFullName;
      _assignedAt = $v.assignedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NutritionistAssignmentSummary other) {
    _$v = other as _$NutritionistAssignmentSummary;
  }

  @override
  void update(void Function(NutritionistAssignmentSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NutritionistAssignmentSummary build() => _build();

  _$NutritionistAssignmentSummary _build() {
    final _$result = _$v ??
        _$NutritionistAssignmentSummary._(
          assignmentId: assignmentId,
          nutritionistUserId: nutritionistUserId,
          nutritionistFullName: nutritionistFullName,
          assignedAt: assignedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
