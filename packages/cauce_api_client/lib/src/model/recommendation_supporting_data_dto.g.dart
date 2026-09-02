// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_supporting_data_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecommendationSupportingDataDto
    extends RecommendationSupportingDataDto {
  @override
  final int? symptomCountsLast14d;
  @override
  final int? mealCountsLast14d;
  @override
  final BuiltList<String>? topFodmapHighFoodsLast14d;
  @override
  final int? correlationWindowHours;
  @override
  final DateTime? analysisWindowFrom;
  @override
  final DateTime? analysisWindowTo;

  factory _$RecommendationSupportingDataDto(
          [void Function(RecommendationSupportingDataDtoBuilder)? updates]) =>
      (RecommendationSupportingDataDtoBuilder()..update(updates))._build();

  _$RecommendationSupportingDataDto._(
      {this.symptomCountsLast14d,
      this.mealCountsLast14d,
      this.topFodmapHighFoodsLast14d,
      this.correlationWindowHours,
      this.analysisWindowFrom,
      this.analysisWindowTo})
      : super._();
  @override
  RecommendationSupportingDataDto rebuild(
          void Function(RecommendationSupportingDataDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecommendationSupportingDataDtoBuilder toBuilder() =>
      RecommendationSupportingDataDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecommendationSupportingDataDto &&
        symptomCountsLast14d == other.symptomCountsLast14d &&
        mealCountsLast14d == other.mealCountsLast14d &&
        topFodmapHighFoodsLast14d == other.topFodmapHighFoodsLast14d &&
        correlationWindowHours == other.correlationWindowHours &&
        analysisWindowFrom == other.analysisWindowFrom &&
        analysisWindowTo == other.analysisWindowTo;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symptomCountsLast14d.hashCode);
    _$hash = $jc(_$hash, mealCountsLast14d.hashCode);
    _$hash = $jc(_$hash, topFodmapHighFoodsLast14d.hashCode);
    _$hash = $jc(_$hash, correlationWindowHours.hashCode);
    _$hash = $jc(_$hash, analysisWindowFrom.hashCode);
    _$hash = $jc(_$hash, analysisWindowTo.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecommendationSupportingDataDto')
          ..add('symptomCountsLast14d', symptomCountsLast14d)
          ..add('mealCountsLast14d', mealCountsLast14d)
          ..add('topFodmapHighFoodsLast14d', topFodmapHighFoodsLast14d)
          ..add('correlationWindowHours', correlationWindowHours)
          ..add('analysisWindowFrom', analysisWindowFrom)
          ..add('analysisWindowTo', analysisWindowTo))
        .toString();
  }
}

class RecommendationSupportingDataDtoBuilder
    implements
        Builder<RecommendationSupportingDataDto,
            RecommendationSupportingDataDtoBuilder> {
  _$RecommendationSupportingDataDto? _$v;

  int? _symptomCountsLast14d;
  int? get symptomCountsLast14d => _$this._symptomCountsLast14d;
  set symptomCountsLast14d(int? symptomCountsLast14d) =>
      _$this._symptomCountsLast14d = symptomCountsLast14d;

  int? _mealCountsLast14d;
  int? get mealCountsLast14d => _$this._mealCountsLast14d;
  set mealCountsLast14d(int? mealCountsLast14d) =>
      _$this._mealCountsLast14d = mealCountsLast14d;

  ListBuilder<String>? _topFodmapHighFoodsLast14d;
  ListBuilder<String> get topFodmapHighFoodsLast14d =>
      _$this._topFodmapHighFoodsLast14d ??= ListBuilder<String>();
  set topFodmapHighFoodsLast14d(
          ListBuilder<String>? topFodmapHighFoodsLast14d) =>
      _$this._topFodmapHighFoodsLast14d = topFodmapHighFoodsLast14d;

  int? _correlationWindowHours;
  int? get correlationWindowHours => _$this._correlationWindowHours;
  set correlationWindowHours(int? correlationWindowHours) =>
      _$this._correlationWindowHours = correlationWindowHours;

  DateTime? _analysisWindowFrom;
  DateTime? get analysisWindowFrom => _$this._analysisWindowFrom;
  set analysisWindowFrom(DateTime? analysisWindowFrom) =>
      _$this._analysisWindowFrom = analysisWindowFrom;

  DateTime? _analysisWindowTo;
  DateTime? get analysisWindowTo => _$this._analysisWindowTo;
  set analysisWindowTo(DateTime? analysisWindowTo) =>
      _$this._analysisWindowTo = analysisWindowTo;

  RecommendationSupportingDataDtoBuilder() {
    RecommendationSupportingDataDto._defaults(this);
  }

  RecommendationSupportingDataDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symptomCountsLast14d = $v.symptomCountsLast14d;
      _mealCountsLast14d = $v.mealCountsLast14d;
      _topFodmapHighFoodsLast14d = $v.topFodmapHighFoodsLast14d?.toBuilder();
      _correlationWindowHours = $v.correlationWindowHours;
      _analysisWindowFrom = $v.analysisWindowFrom;
      _analysisWindowTo = $v.analysisWindowTo;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecommendationSupportingDataDto other) {
    _$v = other as _$RecommendationSupportingDataDto;
  }

  @override
  void update(void Function(RecommendationSupportingDataDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecommendationSupportingDataDto build() => _build();

  _$RecommendationSupportingDataDto _build() {
    _$RecommendationSupportingDataDto _$result;
    try {
      _$result = _$v ??
          _$RecommendationSupportingDataDto._(
            symptomCountsLast14d: symptomCountsLast14d,
            mealCountsLast14d: mealCountsLast14d,
            topFodmapHighFoodsLast14d: _topFodmapHighFoodsLast14d?.build(),
            correlationWindowHours: correlationWindowHours,
            analysisWindowFrom: analysisWindowFrom,
            analysisWindowTo: analysisWindowTo,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'topFodmapHighFoodsLast14d';
        _topFodmapHighFoodsLast14d?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RecommendationSupportingDataDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
