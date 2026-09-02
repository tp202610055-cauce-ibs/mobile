// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_ibs_sss_assessment_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateIbsSssAssessmentRequest extends CreateIbsSssAssessmentRequest {
  @override
  final AssessmentType? assessmentType;
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

  factory _$CreateIbsSssAssessmentRequest(
          [void Function(CreateIbsSssAssessmentRequestBuilder)? updates]) =>
      (CreateIbsSssAssessmentRequestBuilder()..update(updates))._build();

  _$CreateIbsSssAssessmentRequest._(
      {this.assessmentType,
      this.painSeverity,
      this.painFrequency,
      this.bloatingSeverity,
      this.bowelHabitsDissatisfaction,
      this.lifeInterference})
      : super._();
  @override
  CreateIbsSssAssessmentRequest rebuild(
          void Function(CreateIbsSssAssessmentRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateIbsSssAssessmentRequestBuilder toBuilder() =>
      CreateIbsSssAssessmentRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateIbsSssAssessmentRequest &&
        assessmentType == other.assessmentType &&
        painSeverity == other.painSeverity &&
        painFrequency == other.painFrequency &&
        bloatingSeverity == other.bloatingSeverity &&
        bowelHabitsDissatisfaction == other.bowelHabitsDissatisfaction &&
        lifeInterference == other.lifeInterference;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assessmentType.hashCode);
    _$hash = $jc(_$hash, painSeverity.hashCode);
    _$hash = $jc(_$hash, painFrequency.hashCode);
    _$hash = $jc(_$hash, bloatingSeverity.hashCode);
    _$hash = $jc(_$hash, bowelHabitsDissatisfaction.hashCode);
    _$hash = $jc(_$hash, lifeInterference.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateIbsSssAssessmentRequest')
          ..add('assessmentType', assessmentType)
          ..add('painSeverity', painSeverity)
          ..add('painFrequency', painFrequency)
          ..add('bloatingSeverity', bloatingSeverity)
          ..add('bowelHabitsDissatisfaction', bowelHabitsDissatisfaction)
          ..add('lifeInterference', lifeInterference))
        .toString();
  }
}

class CreateIbsSssAssessmentRequestBuilder
    implements
        Builder<CreateIbsSssAssessmentRequest,
            CreateIbsSssAssessmentRequestBuilder> {
  _$CreateIbsSssAssessmentRequest? _$v;

  AssessmentType? _assessmentType;
  AssessmentType? get assessmentType => _$this._assessmentType;
  set assessmentType(AssessmentType? assessmentType) =>
      _$this._assessmentType = assessmentType;

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

  CreateIbsSssAssessmentRequestBuilder() {
    CreateIbsSssAssessmentRequest._defaults(this);
  }

  CreateIbsSssAssessmentRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assessmentType = $v.assessmentType;
      _painSeverity = $v.painSeverity;
      _painFrequency = $v.painFrequency;
      _bloatingSeverity = $v.bloatingSeverity;
      _bowelHabitsDissatisfaction = $v.bowelHabitsDissatisfaction;
      _lifeInterference = $v.lifeInterference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateIbsSssAssessmentRequest other) {
    _$v = other as _$CreateIbsSssAssessmentRequest;
  }

  @override
  void update(void Function(CreateIbsSssAssessmentRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateIbsSssAssessmentRequest build() => _build();

  _$CreateIbsSssAssessmentRequest _build() {
    final _$result = _$v ??
        _$CreateIbsSssAssessmentRequest._(
          assessmentType: assessmentType,
          painSeverity: painSeverity,
          painFrequency: painFrequency,
          bloatingSeverity: bloatingSeverity,
          bowelHabitsDissatisfaction: bowelHabitsDissatisfaction,
          lifeInterference: lifeInterference,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
