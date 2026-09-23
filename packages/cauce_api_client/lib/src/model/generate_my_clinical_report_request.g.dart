// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_my_clinical_report_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenerateMyClinicalReportRequest
    extends GenerateMyClinicalReportRequest {
  @override
  final Date? periodStart;
  @override
  final Date? periodEnd;

  factory _$GenerateMyClinicalReportRequest(
          [void Function(GenerateMyClinicalReportRequestBuilder)? updates]) =>
      (GenerateMyClinicalReportRequestBuilder()..update(updates))._build();

  _$GenerateMyClinicalReportRequest._({this.periodStart, this.periodEnd})
      : super._();
  @override
  GenerateMyClinicalReportRequest rebuild(
          void Function(GenerateMyClinicalReportRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenerateMyClinicalReportRequestBuilder toBuilder() =>
      GenerateMyClinicalReportRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateMyClinicalReportRequest &&
        periodStart == other.periodStart &&
        periodEnd == other.periodEnd;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, periodStart.hashCode);
    _$hash = $jc(_$hash, periodEnd.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenerateMyClinicalReportRequest')
          ..add('periodStart', periodStart)
          ..add('periodEnd', periodEnd))
        .toString();
  }
}

class GenerateMyClinicalReportRequestBuilder
    implements
        Builder<GenerateMyClinicalReportRequest,
            GenerateMyClinicalReportRequestBuilder> {
  _$GenerateMyClinicalReportRequest? _$v;

  Date? _periodStart;
  Date? get periodStart => _$this._periodStart;
  set periodStart(Date? periodStart) => _$this._periodStart = periodStart;

  Date? _periodEnd;
  Date? get periodEnd => _$this._periodEnd;
  set periodEnd(Date? periodEnd) => _$this._periodEnd = periodEnd;

  GenerateMyClinicalReportRequestBuilder() {
    GenerateMyClinicalReportRequest._defaults(this);
  }

  GenerateMyClinicalReportRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _periodStart = $v.periodStart;
      _periodEnd = $v.periodEnd;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerateMyClinicalReportRequest other) {
    _$v = other as _$GenerateMyClinicalReportRequest;
  }

  @override
  void update(void Function(GenerateMyClinicalReportRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateMyClinicalReportRequest build() => _build();

  _$GenerateMyClinicalReportRequest _build() {
    final _$result = _$v ??
        _$GenerateMyClinicalReportRequest._(
          periodStart: periodStart,
          periodEnd: periodEnd,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
