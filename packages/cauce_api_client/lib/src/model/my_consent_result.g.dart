// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_consent_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$MyConsentResult extends MyConsentResult {
  @override
  final String? documentVersion;
  @override
  final DateTime? acceptedAt;
  @override
  final String? consentTextHash;
  @override
  final bool? textAvailable;

  factory _$MyConsentResult([void Function(MyConsentResultBuilder)? updates]) =>
      (MyConsentResultBuilder()..update(updates))._build();

  _$MyConsentResult._(
      {this.documentVersion,
      this.acceptedAt,
      this.consentTextHash,
      this.textAvailable})
      : super._();
  @override
  MyConsentResult rebuild(void Function(MyConsentResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MyConsentResultBuilder toBuilder() => MyConsentResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is MyConsentResult &&
        documentVersion == other.documentVersion &&
        acceptedAt == other.acceptedAt &&
        consentTextHash == other.consentTextHash &&
        textAvailable == other.textAvailable;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, documentVersion.hashCode);
    _$hash = $jc(_$hash, acceptedAt.hashCode);
    _$hash = $jc(_$hash, consentTextHash.hashCode);
    _$hash = $jc(_$hash, textAvailable.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'MyConsentResult')
          ..add('documentVersion', documentVersion)
          ..add('acceptedAt', acceptedAt)
          ..add('consentTextHash', consentTextHash)
          ..add('textAvailable', textAvailable))
        .toString();
  }
}

class MyConsentResultBuilder
    implements Builder<MyConsentResult, MyConsentResultBuilder> {
  _$MyConsentResult? _$v;

  String? _documentVersion;
  String? get documentVersion => _$this._documentVersion;
  set documentVersion(String? documentVersion) =>
      _$this._documentVersion = documentVersion;

  DateTime? _acceptedAt;
  DateTime? get acceptedAt => _$this._acceptedAt;
  set acceptedAt(DateTime? acceptedAt) => _$this._acceptedAt = acceptedAt;

  String? _consentTextHash;
  String? get consentTextHash => _$this._consentTextHash;
  set consentTextHash(String? consentTextHash) =>
      _$this._consentTextHash = consentTextHash;

  bool? _textAvailable;
  bool? get textAvailable => _$this._textAvailable;
  set textAvailable(bool? textAvailable) =>
      _$this._textAvailable = textAvailable;

  MyConsentResultBuilder() {
    MyConsentResult._defaults(this);
  }

  MyConsentResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _documentVersion = $v.documentVersion;
      _acceptedAt = $v.acceptedAt;
      _consentTextHash = $v.consentTextHash;
      _textAvailable = $v.textAvailable;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(MyConsentResult other) {
    _$v = other as _$MyConsentResult;
  }

  @override
  void update(void Function(MyConsentResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  MyConsentResult build() => _build();

  _$MyConsentResult _build() {
    final _$result = _$v ??
        _$MyConsentResult._(
          documentVersion: documentVersion,
          acceptedAt: acceptedAt,
          consentTextHash: consentTextHash,
          textAvailable: textAvailable,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
