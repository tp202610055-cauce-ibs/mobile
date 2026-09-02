// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_symptom_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateSymptomRequest extends CreateSymptomRequest {
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

  factory _$CreateSymptomRequest(
          [void Function(CreateSymptomRequestBuilder)? updates]) =>
      (CreateSymptomRequestBuilder()..update(updates))._build();

  _$CreateSymptomRequest._(
      {this.clientGuid,
      this.symptomType,
      this.intensity,
      this.occurredAt,
      this.clientCreatedAt})
      : super._();
  @override
  CreateSymptomRequest rebuild(
          void Function(CreateSymptomRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateSymptomRequestBuilder toBuilder() =>
      CreateSymptomRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSymptomRequest &&
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
    return (newBuiltValueToStringHelper(r'CreateSymptomRequest')
          ..add('clientGuid', clientGuid)
          ..add('symptomType', symptomType)
          ..add('intensity', intensity)
          ..add('occurredAt', occurredAt)
          ..add('clientCreatedAt', clientCreatedAt))
        .toString();
  }
}

class CreateSymptomRequestBuilder
    implements Builder<CreateSymptomRequest, CreateSymptomRequestBuilder> {
  _$CreateSymptomRequest? _$v;

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

  CreateSymptomRequestBuilder() {
    CreateSymptomRequest._defaults(this);
  }

  CreateSymptomRequestBuilder get _$this {
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
  void replace(CreateSymptomRequest other) {
    _$v = other as _$CreateSymptomRequest;
  }

  @override
  void update(void Function(CreateSymptomRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSymptomRequest build() => _build();

  _$CreateSymptomRequest _build() {
    final _$result = _$v ??
        _$CreateSymptomRequest._(
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
