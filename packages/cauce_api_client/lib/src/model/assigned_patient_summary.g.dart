// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assigned_patient_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssignedPatientSummary extends AssignedPatientSummary {
  @override
  final String? patientUserId;
  @override
  final String? patientFullName;
  @override
  final String? assignmentId;
  @override
  final DateTime? assignedAt;
  @override
  final bool? profileCompleted;
  @override
  final IbsSubtype? ibsSubtype;
  @override
  final int? latestIbsSssScore;
  @override
  final DateTime? lastActivityAt;
  @override
  final int? pendingReviewOver24hCount;
  @override
  final PriorityLevel? priorityLevel;

  factory _$AssignedPatientSummary(
          [void Function(AssignedPatientSummaryBuilder)? updates]) =>
      (AssignedPatientSummaryBuilder()..update(updates))._build();

  _$AssignedPatientSummary._(
      {this.patientUserId,
      this.patientFullName,
      this.assignmentId,
      this.assignedAt,
      this.profileCompleted,
      this.ibsSubtype,
      this.latestIbsSssScore,
      this.lastActivityAt,
      this.pendingReviewOver24hCount,
      this.priorityLevel})
      : super._();
  @override
  AssignedPatientSummary rebuild(
          void Function(AssignedPatientSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssignedPatientSummaryBuilder toBuilder() =>
      AssignedPatientSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignedPatientSummary &&
        patientUserId == other.patientUserId &&
        patientFullName == other.patientFullName &&
        assignmentId == other.assignmentId &&
        assignedAt == other.assignedAt &&
        profileCompleted == other.profileCompleted &&
        ibsSubtype == other.ibsSubtype &&
        latestIbsSssScore == other.latestIbsSssScore &&
        lastActivityAt == other.lastActivityAt &&
        pendingReviewOver24hCount == other.pendingReviewOver24hCount &&
        priorityLevel == other.priorityLevel;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, patientUserId.hashCode);
    _$hash = $jc(_$hash, patientFullName.hashCode);
    _$hash = $jc(_$hash, assignmentId.hashCode);
    _$hash = $jc(_$hash, assignedAt.hashCode);
    _$hash = $jc(_$hash, profileCompleted.hashCode);
    _$hash = $jc(_$hash, ibsSubtype.hashCode);
    _$hash = $jc(_$hash, latestIbsSssScore.hashCode);
    _$hash = $jc(_$hash, lastActivityAt.hashCode);
    _$hash = $jc(_$hash, pendingReviewOver24hCount.hashCode);
    _$hash = $jc(_$hash, priorityLevel.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssignedPatientSummary')
          ..add('patientUserId', patientUserId)
          ..add('patientFullName', patientFullName)
          ..add('assignmentId', assignmentId)
          ..add('assignedAt', assignedAt)
          ..add('profileCompleted', profileCompleted)
          ..add('ibsSubtype', ibsSubtype)
          ..add('latestIbsSssScore', latestIbsSssScore)
          ..add('lastActivityAt', lastActivityAt)
          ..add('pendingReviewOver24hCount', pendingReviewOver24hCount)
          ..add('priorityLevel', priorityLevel))
        .toString();
  }
}

class AssignedPatientSummaryBuilder
    implements Builder<AssignedPatientSummary, AssignedPatientSummaryBuilder> {
  _$AssignedPatientSummary? _$v;

  String? _patientUserId;
  String? get patientUserId => _$this._patientUserId;
  set patientUserId(String? patientUserId) =>
      _$this._patientUserId = patientUserId;

  String? _patientFullName;
  String? get patientFullName => _$this._patientFullName;
  set patientFullName(String? patientFullName) =>
      _$this._patientFullName = patientFullName;

  String? _assignmentId;
  String? get assignmentId => _$this._assignmentId;
  set assignmentId(String? assignmentId) => _$this._assignmentId = assignmentId;

  DateTime? _assignedAt;
  DateTime? get assignedAt => _$this._assignedAt;
  set assignedAt(DateTime? assignedAt) => _$this._assignedAt = assignedAt;

  bool? _profileCompleted;
  bool? get profileCompleted => _$this._profileCompleted;
  set profileCompleted(bool? profileCompleted) =>
      _$this._profileCompleted = profileCompleted;

  IbsSubtype? _ibsSubtype;
  IbsSubtype? get ibsSubtype => _$this._ibsSubtype;
  set ibsSubtype(IbsSubtype? ibsSubtype) => _$this._ibsSubtype = ibsSubtype;

  int? _latestIbsSssScore;
  int? get latestIbsSssScore => _$this._latestIbsSssScore;
  set latestIbsSssScore(int? latestIbsSssScore) =>
      _$this._latestIbsSssScore = latestIbsSssScore;

  DateTime? _lastActivityAt;
  DateTime? get lastActivityAt => _$this._lastActivityAt;
  set lastActivityAt(DateTime? lastActivityAt) =>
      _$this._lastActivityAt = lastActivityAt;

  int? _pendingReviewOver24hCount;
  int? get pendingReviewOver24hCount => _$this._pendingReviewOver24hCount;
  set pendingReviewOver24hCount(int? pendingReviewOver24hCount) =>
      _$this._pendingReviewOver24hCount = pendingReviewOver24hCount;

  PriorityLevel? _priorityLevel;
  PriorityLevel? get priorityLevel => _$this._priorityLevel;
  set priorityLevel(PriorityLevel? priorityLevel) =>
      _$this._priorityLevel = priorityLevel;

  AssignedPatientSummaryBuilder() {
    AssignedPatientSummary._defaults(this);
  }

  AssignedPatientSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _patientUserId = $v.patientUserId;
      _patientFullName = $v.patientFullName;
      _assignmentId = $v.assignmentId;
      _assignedAt = $v.assignedAt;
      _profileCompleted = $v.profileCompleted;
      _ibsSubtype = $v.ibsSubtype;
      _latestIbsSssScore = $v.latestIbsSssScore;
      _lastActivityAt = $v.lastActivityAt;
      _pendingReviewOver24hCount = $v.pendingReviewOver24hCount;
      _priorityLevel = $v.priorityLevel;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignedPatientSummary other) {
    _$v = other as _$AssignedPatientSummary;
  }

  @override
  void update(void Function(AssignedPatientSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssignedPatientSummary build() => _build();

  _$AssignedPatientSummary _build() {
    final _$result = _$v ??
        _$AssignedPatientSummary._(
          patientUserId: patientUserId,
          patientFullName: patientFullName,
          assignmentId: assignmentId,
          assignedAt: assignedAt,
          profileCompleted: profileCompleted,
          ibsSubtype: ibsSubtype,
          latestIbsSssScore: latestIbsSssScore,
          lastActivityAt: lastActivityAt,
          pendingReviewOver24hCount: pendingReviewOver24hCount,
          priorityLevel: priorityLevel,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
