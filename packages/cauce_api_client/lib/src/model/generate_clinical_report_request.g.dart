// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_clinical_report_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenerateClinicalReportRequest extends GenerateClinicalReportRequest {
  @override
  final Date? periodStart;
  @override
  final Date? periodEnd;

  factory _$GenerateClinicalReportRequest(
          [void Function(GenerateClinicalReportRequestBuilder)? updates]) =>
      (GenerateClinicalReportRequestBuilder()..update(updates))._build();

  _$GenerateClinicalReportRequest._({this.periodStart, this.periodEnd})
      : super._();
  @override
  GenerateClinicalReportRequest rebuild(
          void Function(GenerateClinicalReportRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenerateClinicalReportRequestBuilder toBuilder() =>
      GenerateClinicalReportRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateClinicalReportRequest &&
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
    return (newBuiltValueToStringHelper(r'GenerateClinicalReportRequest')
          ..add('periodStart', periodStart)
          ..add('periodEnd', periodEnd))
        .toString();
  }
}

class GenerateClinicalReportRequestBuilder
    implements
        Builder<GenerateClinicalReportRequest,
            GenerateClinicalReportRequestBuilder> {
  _$GenerateClinicalReportRequest? _$v;

  Date? _periodStart;
  Date? get periodStart => _$this._periodStart;
  set periodStart(Date? periodStart) => _$this._periodStart = periodStart;

  Date? _periodEnd;
  Date? get periodEnd => _$this._periodEnd;
  set periodEnd(Date? periodEnd) => _$this._periodEnd = periodEnd;

  GenerateClinicalReportRequestBuilder() {
    GenerateClinicalReportRequest._defaults(this);
  }

  GenerateClinicalReportRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _periodStart = $v.periodStart;
      _periodEnd = $v.periodEnd;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerateClinicalReportRequest other) {
    _$v = other as _$GenerateClinicalReportRequest;
  }

  @override
  void update(void Function(GenerateClinicalReportRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateClinicalReportRequest build() => _build();

  _$GenerateClinicalReportRequest _build() {
    final _$result = _$v ??
        _$GenerateClinicalReportRequest._(
          periodStart: periodStart,
          periodEnd: periodEnd,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
