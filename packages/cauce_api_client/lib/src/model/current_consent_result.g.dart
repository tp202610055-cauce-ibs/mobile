// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_consent_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CurrentConsentResult extends CurrentConsentResult {
  @override
  final String? version;
  @override
  final String? text;
  @override
  final String? hash;

  factory _$CurrentConsentResult(
          [void Function(CurrentConsentResultBuilder)? updates]) =>
      (CurrentConsentResultBuilder()..update(updates))._build();

  _$CurrentConsentResult._({this.version, this.text, this.hash}) : super._();
  @override
  CurrentConsentResult rebuild(
          void Function(CurrentConsentResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CurrentConsentResultBuilder toBuilder() =>
      CurrentConsentResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CurrentConsentResult &&
        version == other.version &&
        text == other.text &&
        hash == other.hash;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, text.hashCode);
    _$hash = $jc(_$hash, hash.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CurrentConsentResult')
          ..add('version', version)
          ..add('text', text)
          ..add('hash', hash))
        .toString();
  }
}

class CurrentConsentResultBuilder
    implements Builder<CurrentConsentResult, CurrentConsentResultBuilder> {
  _$CurrentConsentResult? _$v;

  String? _version;
  String? get version => _$this._version;
  set version(String? version) => _$this._version = version;

  String? _text;
  String? get text => _$this._text;
  set text(String? text) => _$this._text = text;

  String? _hash;
  String? get hash => _$this._hash;
  set hash(String? hash) => _$this._hash = hash;

  CurrentConsentResultBuilder() {
    CurrentConsentResult._defaults(this);
  }

  CurrentConsentResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _version = $v.version;
      _text = $v.text;
      _hash = $v.hash;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CurrentConsentResult other) {
    _$v = other as _$CurrentConsentResult;
  }

  @override
  void update(void Function(CurrentConsentResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CurrentConsentResult build() => _build();

  _$CurrentConsentResult _build() {
    final _$result = _$v ??
        _$CurrentConsentResult._(
          version: version,
          text: text,
          hash: hash,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
