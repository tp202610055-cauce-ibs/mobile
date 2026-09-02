// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'declare_allergy_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DeclareAllergyRequest extends DeclareAllergyRequest {
  @override
  final String? allergyId;
  @override
  final AllergySeverity? severity;
  @override
  final String? notes;

  factory _$DeclareAllergyRequest(
          [void Function(DeclareAllergyRequestBuilder)? updates]) =>
      (DeclareAllergyRequestBuilder()..update(updates))._build();

  _$DeclareAllergyRequest._({this.allergyId, this.severity, this.notes})
      : super._();
  @override
  DeclareAllergyRequest rebuild(
          void Function(DeclareAllergyRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DeclareAllergyRequestBuilder toBuilder() =>
      DeclareAllergyRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DeclareAllergyRequest &&
        allergyId == other.allergyId &&
        severity == other.severity &&
        notes == other.notes;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, allergyId.hashCode);
    _$hash = $jc(_$hash, severity.hashCode);
    _$hash = $jc(_$hash, notes.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DeclareAllergyRequest')
          ..add('allergyId', allergyId)
          ..add('severity', severity)
          ..add('notes', notes))
        .toString();
  }
}

class DeclareAllergyRequestBuilder
    implements Builder<DeclareAllergyRequest, DeclareAllergyRequestBuilder> {
  _$DeclareAllergyRequest? _$v;

  String? _allergyId;
  String? get allergyId => _$this._allergyId;
  set allergyId(String? allergyId) => _$this._allergyId = allergyId;

  AllergySeverity? _severity;
  AllergySeverity? get severity => _$this._severity;
  set severity(AllergySeverity? severity) => _$this._severity = severity;

  String? _notes;
  String? get notes => _$this._notes;
  set notes(String? notes) => _$this._notes = notes;

  DeclareAllergyRequestBuilder() {
    DeclareAllergyRequest._defaults(this);
  }

  DeclareAllergyRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _allergyId = $v.allergyId;
      _severity = $v.severity;
      _notes = $v.notes;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DeclareAllergyRequest other) {
    _$v = other as _$DeclareAllergyRequest;
  }

  @override
  void update(void Function(DeclareAllergyRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DeclareAllergyRequest build() => _build();

  _$DeclareAllergyRequest _build() {
    final _$result = _$v ??
        _$DeclareAllergyRequest._(
          allergyId: allergyId,
          severity: severity,
          notes: notes,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
