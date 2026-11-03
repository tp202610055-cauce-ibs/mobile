// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ibs_sss_cycle_status_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IbsSssCycleStatusDto extends IbsSssCycleStatusDto {
  @override
  final IbsSssCycleStatus? status;
  @override
  final DateTime? dueDate;
  @override
  final DateTime? reminderSentAt;
  @override
  final DateTime? completedAt;

  factory _$IbsSssCycleStatusDto(
          [void Function(IbsSssCycleStatusDtoBuilder)? updates]) =>
      (IbsSssCycleStatusDtoBuilder()..update(updates))._build();

  _$IbsSssCycleStatusDto._(
      {this.status, this.dueDate, this.reminderSentAt, this.completedAt})
      : super._();
  @override
  IbsSssCycleStatusDto rebuild(
          void Function(IbsSssCycleStatusDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IbsSssCycleStatusDtoBuilder toBuilder() =>
      IbsSssCycleStatusDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IbsSssCycleStatusDto &&
        status == other.status &&
        dueDate == other.dueDate &&
        reminderSentAt == other.reminderSentAt &&
        completedAt == other.completedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, dueDate.hashCode);
    _$hash = $jc(_$hash, reminderSentAt.hashCode);
    _$hash = $jc(_$hash, completedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IbsSssCycleStatusDto')
          ..add('status', status)
          ..add('dueDate', dueDate)
          ..add('reminderSentAt', reminderSentAt)
          ..add('completedAt', completedAt))
        .toString();
  }
}

class IbsSssCycleStatusDtoBuilder
    implements Builder<IbsSssCycleStatusDto, IbsSssCycleStatusDtoBuilder> {
  _$IbsSssCycleStatusDto? _$v;

  IbsSssCycleStatus? _status;
  IbsSssCycleStatus? get status => _$this._status;
  set status(IbsSssCycleStatus? status) => _$this._status = status;

  DateTime? _dueDate;
  DateTime? get dueDate => _$this._dueDate;
  set dueDate(DateTime? dueDate) => _$this._dueDate = dueDate;

  DateTime? _reminderSentAt;
  DateTime? get reminderSentAt => _$this._reminderSentAt;
  set reminderSentAt(DateTime? reminderSentAt) =>
      _$this._reminderSentAt = reminderSentAt;

  DateTime? _completedAt;
  DateTime? get completedAt => _$this._completedAt;
  set completedAt(DateTime? completedAt) => _$this._completedAt = completedAt;

  IbsSssCycleStatusDtoBuilder() {
    IbsSssCycleStatusDto._defaults(this);
  }

  IbsSssCycleStatusDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _status = $v.status;
      _dueDate = $v.dueDate;
      _reminderSentAt = $v.reminderSentAt;
      _completedAt = $v.completedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IbsSssCycleStatusDto other) {
    _$v = other as _$IbsSssCycleStatusDto;
  }

  @override
  void update(void Function(IbsSssCycleStatusDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IbsSssCycleStatusDto build() => _build();

  _$IbsSssCycleStatusDto _build() {
    final _$result = _$v ??
        _$IbsSssCycleStatusDto._(
          status: status,
          dueDate: dueDate,
          reminderSentAt: reminderSentAt,
          completedAt: completedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
