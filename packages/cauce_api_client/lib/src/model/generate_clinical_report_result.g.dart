// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_clinical_report_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenerateClinicalReportResult extends GenerateClinicalReportResult {
  @override
  final String? reportId;
  @override
  final String? presignedUrl;
  @override
  final DateTime? presignedUrlExpiresAt;

  factory _$GenerateClinicalReportResult(
          [void Function(GenerateClinicalReportResultBuilder)? updates]) =>
      (GenerateClinicalReportResultBuilder()..update(updates))._build();

  _$GenerateClinicalReportResult._(
      {this.reportId, this.presignedUrl, this.presignedUrlExpiresAt})
      : super._();
  @override
  GenerateClinicalReportResult rebuild(
          void Function(GenerateClinicalReportResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenerateClinicalReportResultBuilder toBuilder() =>
      GenerateClinicalReportResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateClinicalReportResult &&
        reportId == other.reportId &&
        presignedUrl == other.presignedUrl &&
        presignedUrlExpiresAt == other.presignedUrlExpiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, reportId.hashCode);
    _$hash = $jc(_$hash, presignedUrl.hashCode);
    _$hash = $jc(_$hash, presignedUrlExpiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenerateClinicalReportResult')
          ..add('reportId', reportId)
          ..add('presignedUrl', presignedUrl)
          ..add('presignedUrlExpiresAt', presignedUrlExpiresAt))
        .toString();
  }
}

class GenerateClinicalReportResultBuilder
    implements
        Builder<GenerateClinicalReportResult,
            GenerateClinicalReportResultBuilder> {
  _$GenerateClinicalReportResult? _$v;

  String? _reportId;
  String? get reportId => _$this._reportId;
  set reportId(String? reportId) => _$this._reportId = reportId;

  String? _presignedUrl;
  String? get presignedUrl => _$this._presignedUrl;
  set presignedUrl(String? presignedUrl) => _$this._presignedUrl = presignedUrl;

  DateTime? _presignedUrlExpiresAt;
  DateTime? get presignedUrlExpiresAt => _$this._presignedUrlExpiresAt;
  set presignedUrlExpiresAt(DateTime? presignedUrlExpiresAt) =>
      _$this._presignedUrlExpiresAt = presignedUrlExpiresAt;

  GenerateClinicalReportResultBuilder() {
    GenerateClinicalReportResult._defaults(this);
  }

  GenerateClinicalReportResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _reportId = $v.reportId;
      _presignedUrl = $v.presignedUrl;
      _presignedUrlExpiresAt = $v.presignedUrlExpiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerateClinicalReportResult other) {
    _$v = other as _$GenerateClinicalReportResult;
  }

  @override
  void update(void Function(GenerateClinicalReportResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateClinicalReportResult build() => _build();

  _$GenerateClinicalReportResult _build() {
    final _$result = _$v ??
        _$GenerateClinicalReportResult._(
          reportId: reportId,
          presignedUrl: presignedUrl,
          presignedUrlExpiresAt: presignedUrlExpiresAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
