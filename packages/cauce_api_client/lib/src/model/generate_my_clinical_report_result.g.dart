// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_my_clinical_report_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenerateMyClinicalReportResult extends GenerateMyClinicalReportResult {
  @override
  final String? reportId;
  @override
  final String? presignedUrl;
  @override
  final DateTime? presignedUrlExpiresAt;

  factory _$GenerateMyClinicalReportResult(
          [void Function(GenerateMyClinicalReportResultBuilder)? updates]) =>
      (GenerateMyClinicalReportResultBuilder()..update(updates))._build();

  _$GenerateMyClinicalReportResult._(
      {this.reportId, this.presignedUrl, this.presignedUrlExpiresAt})
      : super._();
  @override
  GenerateMyClinicalReportResult rebuild(
          void Function(GenerateMyClinicalReportResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenerateMyClinicalReportResultBuilder toBuilder() =>
      GenerateMyClinicalReportResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateMyClinicalReportResult &&
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
    return (newBuiltValueToStringHelper(r'GenerateMyClinicalReportResult')
          ..add('reportId', reportId)
          ..add('presignedUrl', presignedUrl)
          ..add('presignedUrlExpiresAt', presignedUrlExpiresAt))
        .toString();
  }
}

class GenerateMyClinicalReportResultBuilder
    implements
        Builder<GenerateMyClinicalReportResult,
            GenerateMyClinicalReportResultBuilder> {
  _$GenerateMyClinicalReportResult? _$v;

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

  GenerateMyClinicalReportResultBuilder() {
    GenerateMyClinicalReportResult._defaults(this);
  }

  GenerateMyClinicalReportResultBuilder get _$this {
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
  void replace(GenerateMyClinicalReportResult other) {
    _$v = other as _$GenerateMyClinicalReportResult;
  }

  @override
  void update(void Function(GenerateMyClinicalReportResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateMyClinicalReportResult build() => _build();

  _$GenerateMyClinicalReportResult _build() {
    final _$result = _$v ??
        _$GenerateMyClinicalReportResult._(
          reportId: reportId,
          presignedUrl: presignedUrl,
          presignedUrlExpiresAt: presignedUrlExpiresAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
