// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_history_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SymptomHistoryItem extends SymptomHistoryItem {
  @override
  final String? symptomId;
  @override
  final String? clientGuid;
  @override
  final SymptomType? symptomType;
  @override
  final int? intensity;
  @override
  final DateTime? occurredAt;
  @override
  final String? associatedMealId;
  @override
  final bool? hasMealAssociation;
  @override
  final SyncStatus? syncStatus;

  factory _$SymptomHistoryItem(
          [void Function(SymptomHistoryItemBuilder)? updates]) =>
      (SymptomHistoryItemBuilder()..update(updates))._build();

  _$SymptomHistoryItem._(
      {this.symptomId,
      this.clientGuid,
      this.symptomType,
      this.intensity,
      this.occurredAt,
      this.associatedMealId,
      this.hasMealAssociation,
      this.syncStatus})
      : super._();
  @override
  SymptomHistoryItem rebuild(
          void Function(SymptomHistoryItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SymptomHistoryItemBuilder toBuilder() =>
      SymptomHistoryItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SymptomHistoryItem &&
        symptomId == other.symptomId &&
        clientGuid == other.clientGuid &&
        symptomType == other.symptomType &&
        intensity == other.intensity &&
        occurredAt == other.occurredAt &&
        associatedMealId == other.associatedMealId &&
        hasMealAssociation == other.hasMealAssociation &&
        syncStatus == other.syncStatus;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symptomId.hashCode);
    _$hash = $jc(_$hash, clientGuid.hashCode);
    _$hash = $jc(_$hash, symptomType.hashCode);
    _$hash = $jc(_$hash, intensity.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jc(_$hash, associatedMealId.hashCode);
    _$hash = $jc(_$hash, hasMealAssociation.hashCode);
    _$hash = $jc(_$hash, syncStatus.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SymptomHistoryItem')
          ..add('symptomId', symptomId)
          ..add('clientGuid', clientGuid)
          ..add('symptomType', symptomType)
          ..add('intensity', intensity)
          ..add('occurredAt', occurredAt)
          ..add('associatedMealId', associatedMealId)
          ..add('hasMealAssociation', hasMealAssociation)
          ..add('syncStatus', syncStatus))
        .toString();
  }
}

class SymptomHistoryItemBuilder
    implements Builder<SymptomHistoryItem, SymptomHistoryItemBuilder> {
  _$SymptomHistoryItem? _$v;

  String? _symptomId;
  String? get symptomId => _$this._symptomId;
  set symptomId(String? symptomId) => _$this._symptomId = symptomId;

  String? _clientGuid;
  String? get clientGuid => _$this._clientGuid;
  set clientGuid(String? clientGuid) => _$this._clientGuid = clientGuid;

  SymptomType? _symptomType;
  SymptomType? get symptomType => _$this._symptomType;
  set symptomType(SymptomType? symptomType) =>
      _$this._symptomType = symptomType;

  int? _intensity;
  int? get intensity => _$this._intensity;
  set intensity(int? intensity) => _$this._intensity = intensity;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  String? _associatedMealId;
  String? get associatedMealId => _$this._associatedMealId;
  set associatedMealId(String? associatedMealId) =>
      _$this._associatedMealId = associatedMealId;

  bool? _hasMealAssociation;
  bool? get hasMealAssociation => _$this._hasMealAssociation;
  set hasMealAssociation(bool? hasMealAssociation) =>
      _$this._hasMealAssociation = hasMealAssociation;

  SyncStatus? _syncStatus;
  SyncStatus? get syncStatus => _$this._syncStatus;
  set syncStatus(SyncStatus? syncStatus) => _$this._syncStatus = syncStatus;

  SymptomHistoryItemBuilder() {
    SymptomHistoryItem._defaults(this);
  }

  SymptomHistoryItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symptomId = $v.symptomId;
      _clientGuid = $v.clientGuid;
      _symptomType = $v.symptomType;
      _intensity = $v.intensity;
      _occurredAt = $v.occurredAt;
      _associatedMealId = $v.associatedMealId;
      _hasMealAssociation = $v.hasMealAssociation;
      _syncStatus = $v.syncStatus;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SymptomHistoryItem other) {
    _$v = other as _$SymptomHistoryItem;
  }

  @override
  void update(void Function(SymptomHistoryItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SymptomHistoryItem build() => _build();

  _$SymptomHistoryItem _build() {
    final _$result = _$v ??
        _$SymptomHistoryItem._(
          symptomId: symptomId,
          clientGuid: clientGuid,
          symptomType: symptomType,
          intensity: intensity,
          occurredAt: occurredAt,
          associatedMealId: associatedMealId,
          hasMealAssociation: hasMealAssociation,
          syncStatus: syncStatus,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
