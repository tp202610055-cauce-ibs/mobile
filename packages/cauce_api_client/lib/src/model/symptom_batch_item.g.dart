// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_batch_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SymptomBatchItem extends SymptomBatchItem {
  @override
  final String? clientGuid;
  @override
  final SymptomType? symptomType;
  @override
  final int? intensity;
  @override
  final DateTime? occurredAt;
  @override
  final DateTime? clientCreatedAt;

  factory _$SymptomBatchItem(
          [void Function(SymptomBatchItemBuilder)? updates]) =>
      (SymptomBatchItemBuilder()..update(updates))._build();

  _$SymptomBatchItem._(
      {this.clientGuid,
      this.symptomType,
      this.intensity,
      this.occurredAt,
      this.clientCreatedAt})
      : super._();
  @override
  SymptomBatchItem rebuild(void Function(SymptomBatchItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SymptomBatchItemBuilder toBuilder() =>
      SymptomBatchItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SymptomBatchItem &&
        clientGuid == other.clientGuid &&
        symptomType == other.symptomType &&
        intensity == other.intensity &&
        occurredAt == other.occurredAt &&
        clientCreatedAt == other.clientCreatedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientGuid.hashCode);
    _$hash = $jc(_$hash, symptomType.hashCode);
    _$hash = $jc(_$hash, intensity.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jc(_$hash, clientCreatedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SymptomBatchItem')
          ..add('clientGuid', clientGuid)
          ..add('symptomType', symptomType)
          ..add('intensity', intensity)
          ..add('occurredAt', occurredAt)
          ..add('clientCreatedAt', clientCreatedAt))
        .toString();
  }
}

class SymptomBatchItemBuilder
    implements Builder<SymptomBatchItem, SymptomBatchItemBuilder> {
  _$SymptomBatchItem? _$v;

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

  DateTime? _clientCreatedAt;
  DateTime? get clientCreatedAt => _$this._clientCreatedAt;
  set clientCreatedAt(DateTime? clientCreatedAt) =>
      _$this._clientCreatedAt = clientCreatedAt;

  SymptomBatchItemBuilder() {
    SymptomBatchItem._defaults(this);
  }

  SymptomBatchItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientGuid = $v.clientGuid;
      _symptomType = $v.symptomType;
      _intensity = $v.intensity;
      _occurredAt = $v.occurredAt;
      _clientCreatedAt = $v.clientCreatedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SymptomBatchItem other) {
    _$v = other as _$SymptomBatchItem;
  }

  @override
  void update(void Function(SymptomBatchItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SymptomBatchItem build() => _build();

  _$SymptomBatchItem _build() {
    final _$result = _$v ??
        _$SymptomBatchItem._(
          clientGuid: clientGuid,
          symptomType: symptomType,
          intensity: intensity,
          occurredAt: occurredAt,
          clientCreatedAt: clientCreatedAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
