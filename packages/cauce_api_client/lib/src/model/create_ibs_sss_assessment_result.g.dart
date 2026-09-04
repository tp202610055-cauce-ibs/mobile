// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ibs_sss_assessment_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateIbsSssAssessmentResult extends CreateIbsSssAssessmentResult {
  @override
  final String? assessmentId;
  @override
  final int? totalScore;
  @override
  final SeverityCategory? severityCategory;
  @override
  final Date? nextAssessmentDate;
  @override
  final bool? triggeredOnboardingCompletion;

  factory _$CreateIbsSssAssessmentResult(
          [void Function(CreateIbsSssAssessmentResultBuilder)? updates]) =>
      (CreateIbsSssAssessmentResultBuilder()..update(updates))._build();

  _$CreateIbsSssAssessmentResult._(
      {this.assessmentId,
      this.totalScore,
      this.severityCategory,
      this.nextAssessmentDate,
      this.triggeredOnboardingCompletion})
      : super._();
  @override
  CreateIbsSssAssessmentResult rebuild(
          void Function(CreateIbsSssAssessmentResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateIbsSssAssessmentResultBuilder toBuilder() =>
      CreateIbsSssAssessmentResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateIbsSssAssessmentResult &&
        assessmentId == other.assessmentId &&
        totalScore == other.totalScore &&
        severityCategory == other.severityCategory &&
        nextAssessmentDate == other.nextAssessmentDate &&
        triggeredOnboardingCompletion == other.triggeredOnboardingCompletion;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assessmentId.hashCode);
    _$hash = $jc(_$hash, totalScore.hashCode);
    _$hash = $jc(_$hash, severityCategory.hashCode);
    _$hash = $jc(_$hash, nextAssessmentDate.hashCode);
    _$hash = $jc(_$hash, triggeredOnboardingCompletion.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateIbsSssAssessmentResult')
          ..add('assessmentId', assessmentId)
          ..add('totalScore', totalScore)
          ..add('severityCategory', severityCategory)
          ..add('nextAssessmentDate', nextAssessmentDate)
          ..add('triggeredOnboardingCompletion', triggeredOnboardingCompletion))
        .toString();
  }
}

class CreateIbsSssAssessmentResultBuilder
    implements
        Builder<CreateIbsSssAssessmentResult,
            CreateIbsSssAssessmentResultBuilder> {
  _$CreateIbsSssAssessmentResult? _$v;

  String? _assessmentId;
  String? get assessmentId => _$this._assessmentId;
  set assessmentId(String? assessmentId) => _$this._assessmentId = assessmentId;

  int? _totalScore;
  int? get totalScore => _$this._totalScore;
  set totalScore(int? totalScore) => _$this._totalScore = totalScore;

  SeverityCategory? _severityCategory;
  SeverityCategory? get severityCategory => _$this._severityCategory;
  set severityCategory(SeverityCategory? severityCategory) =>
      _$this._severityCategory = severityCategory;

  Date? _nextAssessmentDate;
  Date? get nextAssessmentDate => _$this._nextAssessmentDate;
  set nextAssessmentDate(Date? nextAssessmentDate) =>
      _$this._nextAssessmentDate = nextAssessmentDate;

  bool? _triggeredOnboardingCompletion;
  bool? get triggeredOnboardingCompletion =>
      _$this._triggeredOnboardingCompletion;
  set triggeredOnboardingCompletion(bool? triggeredOnboardingCompletion) =>
      _$this._triggeredOnboardingCompletion = triggeredOnboardingCompletion;

  CreateIbsSssAssessmentResultBuilder() {
    CreateIbsSssAssessmentResult._defaults(this);
  }

  CreateIbsSssAssessmentResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assessmentId = $v.assessmentId;
      _totalScore = $v.totalScore;
      _severityCategory = $v.severityCategory;
      _nextAssessmentDate = $v.nextAssessmentDate;
      _triggeredOnboardingCompletion = $v.triggeredOnboardingCompletion;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateIbsSssAssessmentResult other) {
    _$v = other as _$CreateIbsSssAssessmentResult;
  }

  @override
  void update(void Function(CreateIbsSssAssessmentResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateIbsSssAssessmentResult build() => _build();

  _$CreateIbsSssAssessmentResult _build() {
    final _$result = _$v ??
        _$CreateIbsSssAssessmentResult._(
          assessmentId: assessmentId,
          totalScore: totalScore,
          severityCategory: severityCategory,
          nextAssessmentDate: nextAssessmentDate,
          triggeredOnboardingCompletion: triggeredOnboardingCompletion,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
