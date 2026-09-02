// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ibs_sss_assessment_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IbsSssAssessmentSummary extends IbsSssAssessmentSummary {
  @override
  final String? assessmentId;
  @override
  final AssessmentType? assessmentType;
  @override
  final int? cycleNumber;
  @override
  final int? painSeverity;
  @override
  final int? painFrequency;
  @override
  final int? bloatingSeverity;
  @override
  final int? bowelHabitsDissatisfaction;
  @override
  final int? lifeInterference;
  @override
  final int? totalScore;
  @override
  final SeverityCategory? severityCategory;
  @override
  final DateTime? completedAt;
  @override
  final Date? nextAssessmentDate;

  factory _$IbsSssAssessmentSummary(
          [void Function(IbsSssAssessmentSummaryBuilder)? updates]) =>
      (IbsSssAssessmentSummaryBuilder()..update(updates))._build();

  _$IbsSssAssessmentSummary._(
      {this.assessmentId,
      this.assessmentType,
      this.cycleNumber,
      this.painSeverity,
      this.painFrequency,
      this.bloatingSeverity,
      this.bowelHabitsDissatisfaction,
      this.lifeInterference,
      this.totalScore,
      this.severityCategory,
      this.completedAt,
      this.nextAssessmentDate})
      : super._();
  @override
  IbsSssAssessmentSummary rebuild(
          void Function(IbsSssAssessmentSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IbsSssAssessmentSummaryBuilder toBuilder() =>
      IbsSssAssessmentSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IbsSssAssessmentSummary &&
        assessmentId == other.assessmentId &&
        assessmentType == other.assessmentType &&
        cycleNumber == other.cycleNumber &&
        painSeverity == other.painSeverity &&
        painFrequency == other.painFrequency &&
        bloatingSeverity == other.bloatingSeverity &&
        bowelHabitsDissatisfaction == other.bowelHabitsDissatisfaction &&
        lifeInterference == other.lifeInterference &&
        totalScore == other.totalScore &&
        severityCategory == other.severityCategory &&
        completedAt == other.completedAt &&
        nextAssessmentDate == other.nextAssessmentDate;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assessmentId.hashCode);
    _$hash = $jc(_$hash, assessmentType.hashCode);
    _$hash = $jc(_$hash, cycleNumber.hashCode);
    _$hash = $jc(_$hash, painSeverity.hashCode);
    _$hash = $jc(_$hash, painFrequency.hashCode);
    _$hash = $jc(_$hash, bloatingSeverity.hashCode);
    _$hash = $jc(_$hash, bowelHabitsDissatisfaction.hashCode);
    _$hash = $jc(_$hash, lifeInterference.hashCode);
    _$hash = $jc(_$hash, totalScore.hashCode);
    _$hash = $jc(_$hash, severityCategory.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jc(_$hash, nextAssessmentDate.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IbsSssAssessmentSummary')
          ..add('assessmentId', assessmentId)
          ..add('assessmentType', assessmentType)
          ..add('cycleNumber', cycleNumber)
          ..add('painSeverity', painSeverity)
          ..add('painFrequency', painFrequency)
          ..add('bloatingSeverity', bloatingSeverity)
          ..add('bowelHabitsDissatisfaction', bowelHabitsDissatisfaction)
          ..add('lifeInterference', lifeInterference)
          ..add('totalScore', totalScore)
          ..add('severityCategory', severityCategory)
          ..add('completedAt', completedAt)
          ..add('nextAssessmentDate', nextAssessmentDate))
        .toString();
  }
}

class IbsSssAssessmentSummaryBuilder
    implements
        Builder<IbsSssAssessmentSummary, IbsSssAssessmentSummaryBuilder> {
  _$IbsSssAssessmentSummary? _$v;

  String? _assessmentId;
  String? get assessmentId => _$this._assessmentId;
  set assessmentId(String? assessmentId) => _$this._assessmentId = assessmentId;

  AssessmentType? _assessmentType;
  AssessmentType? get assessmentType => _$this._assessmentType;
  set assessmentType(AssessmentType? assessmentType) =>
      _$this._assessmentType = assessmentType;

  int? _cycleNumber;
  int? get cycleNumber => _$this._cycleNumber;
  set cycleNumber(int? cycleNumber) => _$this._cycleNumber = cycleNumber;

  int? _painSeverity;
  int? get painSeverity => _$this._painSeverity;
  set painSeverity(int? painSeverity) => _$this._painSeverity = painSeverity;

  int? _painFrequency;
  int? get painFrequency => _$this._painFrequency;
  set painFrequency(int? painFrequency) =>
      _$this._painFrequency = painFrequency;

  int? _bloatingSeverity;
  int? get bloatingSeverity => _$this._bloatingSeverity;
  set bloatingSeverity(int? bloatingSeverity) =>
      _$this._bloatingSeverity = bloatingSeverity;

  int? _bowelHabitsDissatisfaction;
  int? get bowelHabitsDissatisfaction => _$this._bowelHabitsDissatisfaction;
  set bowelHabitsDissatisfaction(int? bowelHabitsDissatisfaction) =>
      _$this._bowelHabitsDissatisfaction = bowelHabitsDissatisfaction;

  int? _lifeInterference;
  int? get lifeInterference => _$this._lifeInterference;
  set lifeInterference(int? lifeInterference) =>
      _$this._lifeInterference = lifeInterference;

  int? _totalScore;
  int? get totalScore => _$this._totalScore;
  set totalScore(int? totalScore) => _$this._totalScore = totalScore;

  SeverityCategory? _severityCategory;
  SeverityCategory? get severityCategory => _$this._severityCategory;
  set severityCategory(SeverityCategory? severityCategory) =>
      _$this._severityCategory = severityCategory;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  Date? _nextAssessmentDate;
  Date? get nextAssessmentDate => _$this._nextAssessmentDate;
  set nextAssessmentDate(Date? nextAssessmentDate) =>
      _$this._nextAssessmentDate = nextAssessmentDate;

  IbsSssAssessmentSummaryBuilder() {
    IbsSssAssessmentSummary._defaults(this);
  }

  IbsSssAssessmentSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assessmentId = $v.assessmentId;
      _assessmentType = $v.assessmentType;
      _cycleNumber = $v.cycleNumber;
      _painSeverity = $v.painSeverity;
      _painFrequency = $v.painFrequency;
      _bloatingSeverity = $v.bloatingSeverity;
      _bowelHabitsDissatisfaction = $v.bowelHabitsDissatisfaction;
      _lifeInterference = $v.lifeInterference;
      _totalScore = $v.totalScore;
      _severityCategory = $v.severityCategory;
      _completedAt = $v.completedAt;
      _nextAssessmentDate = $v.nextAssessmentDate;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IbsSssAssessmentSummary other) {
    _$v = other as _$IbsSssAssessmentSummary;
  }

  @override
  void update(void Function(IbsSssAssessmentSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IbsSssAssessmentSummary build() => _build();

  _$IbsSssAssessmentSummary _build() {
    final _$result = _$v ??
        _$IbsSssAssessmentSummary._(
          assessmentId: assessmentId,
          assessmentType: assessmentType,
          cycleNumber: cycleNumber,
          painSeverity: painSeverity,
          painFrequency: painFrequency,
          bloatingSeverity: bloatingSeverity,
          bowelHabitsDissatisfaction: bowelHabitsDissatisfaction,
          lifeInterference: lifeInterference,
          totalScore: totalScore,
          severityCategory: severityCategory,
          completedAt: completedAt,
          nextAssessmentDate: nextAssessmentDate,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
