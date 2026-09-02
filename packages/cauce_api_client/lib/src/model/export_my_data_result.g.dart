// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'export_my_data_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExportMyDataResult extends ExportMyDataResult {
  @override
  final String? downloadUrl;
  @override
  final DateTime? expiresAtUtc;

  factory _$ExportMyDataResult(
          [void Function(ExportMyDataResultBuilder)? updates]) =>
      (ExportMyDataResultBuilder()..update(updates))._build();

  _$ExportMyDataResult._({this.downloadUrl, this.expiresAtUtc}) : super._();
  @override
  ExportMyDataResult rebuild(
          void Function(ExportMyDataResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExportMyDataResultBuilder toBuilder() =>
      ExportMyDataResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExportMyDataResult &&
        downloadUrl == other.downloadUrl &&
        expiresAtUtc == other.expiresAtUtc;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, downloadUrl.hashCode);
    _$hash = $jc(_$hash, expiresAtUtc.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExportMyDataResult')
          ..add('downloadUrl', downloadUrl)
          ..add('expiresAtUtc', expiresAtUtc))
        .toString();
  }
}

class ExportMyDataResultBuilder
    implements Builder<ExportMyDataResult, ExportMyDataResultBuilder> {
  _$ExportMyDataResult? _$v;

  String? _downloadUrl;
  String? get downloadUrl => _$this._downloadUrl;
  set downloadUrl(String? downloadUrl) => _$this._downloadUrl = downloadUrl;

  DateTime? _expiresAtUtc;
  DateTime? get expiresAtUtc => _$this._expiresAtUtc;
  set expiresAtUtc(DateTime? expiresAtUtc) =>
      _$this._expiresAtUtc = expiresAtUtc;

  ExportMyDataResultBuilder() {
    ExportMyDataResult._defaults(this);
  }

  ExportMyDataResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _downloadUrl = $v.downloadUrl;
      _expiresAtUtc = $v.expiresAtUtc;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExportMyDataResult other) {
    _$v = other as _$ExportMyDataResult;
  }

  @override
  void update(void Function(ExportMyDataResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExportMyDataResult build() => _build();

  _$ExportMyDataResult _build() {
    final _$result = _$v ??
        _$ExportMyDataResult._(
          downloadUrl: downloadUrl,
          expiresAtUtc: expiresAtUtc,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
