// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_evolution_for_nutritionist_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PatientEvolutionForNutritionistResult
    extends PatientEvolutionForNutritionistResult {
  @override
  final BuiltList<IbsSssEvolutionEntry>? ibsSssTimeline;
  @override
  final int? baselineScore;
  @override
  final int? latestScore;
  @override
  final double? percentChangeFromBaseline;
  @override
  final bool? significantClinicalResponse;
  @override
  final int? registrationFrequency14d;

  factory _$PatientEvolutionForNutritionistResult(
          [void Function(PatientEvolutionForNutritionistResultBuilder)?
              updates]) =>
      (PatientEvolutionForNutritionistResultBuilder()..update(updates))
          ._build();

  _$PatientEvolutionForNutritionistResult._(
      {this.ibsSssTimeline,
      this.baselineScore,
      this.latestScore,
      this.percentChangeFromBaseline,
      this.significantClinicalResponse,
      this.registrationFrequency14d})
      : super._();
  @override
  PatientEvolutionForNutritionistResult rebuild(
          void Function(PatientEvolutionForNutritionistResultBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PatientEvolutionForNutritionistResultBuilder toBuilder() =>
      PatientEvolutionForNutritionistResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PatientEvolutionForNutritionistResult &&
        ibsSssTimeline == other.ibsSssTimeline &&
        baselineScore == other.baselineScore &&
        latestScore == other.latestScore &&
        percentChangeFromBaseline == other.percentChangeFromBaseline &&
        significantClinicalResponse == other.significantClinicalResponse &&
        registrationFrequency14d == other.registrationFrequency14d;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, ibsSssTimeline.hashCode);
    _$hash = $jc(_$hash, baselineScore.hashCode);
    _$hash = $jc(_$hash, latestScore.hashCode);
    _$hash = $jc(_$hash, percentChangeFromBaseline.hashCode);
    _$hash = $jc(_$hash, significantClinicalResponse.hashCode);
    _$hash = $jc(_$hash, registrationFrequency14d.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'PatientEvolutionForNutritionistResult')
          ..add('ibsSssTimeline', ibsSssTimeline)
          ..add('baselineScore', baselineScore)
          ..add('latestScore', latestScore)
          ..add('percentChangeFromBaseline', percentChangeFromBaseline)
          ..add('significantClinicalResponse', significantClinicalResponse)
          ..add('registrationFrequency14d', registrationFrequency14d))
        .toString();
  }
}

class PatientEvolutionForNutritionistResultBuilder
    implements
        Builder<PatientEvolutionForNutritionistResult,
            PatientEvolutionForNutritionistResultBuilder> {
  _$PatientEvolutionForNutritionistResult? _$v;

  ListBuilder<IbsSssEvolutionEntry>? _ibsSssTimeline;
  ListBuilder<IbsSssEvolutionEntry> get ibsSssTimeline =>
      _$this._ibsSssTimeline ??= ListBuilder<IbsSssEvolutionEntry>();
  set ibsSssTimeline(ListBuilder<IbsSssEvolutionEntry>? ibsSssTimeline) =>
      _$this._ibsSssTimeline = ibsSssTimeline;

  int? _baselineScore;
  int? get baselineScore => _$this._baselineScore;
  set baselineScore(int? baselineScore) =>
      _$this._baselineScore = baselineScore;

  int? _latestScore;
  int? get latestScore => _$this._latestScore;
  set latestScore(int? latestScore) => _$this._latestScore = latestScore;

  double? _percentChangeFromBaseline;
  double? get percentChangeFromBaseline => _$this._percentChangeFromBaseline;
  set percentChangeFromBaseline(double? percentChangeFromBaseline) =>
      _$this._percentChangeFromBaseline = percentChangeFromBaseline;

  bool? _significantClinicalResponse;
  bool? get significantClinicalResponse => _$this._significantClinicalResponse;
  set significantClinicalResponse(bool? significantClinicalResponse) =>
      _$this._significantClinicalResponse = significantClinicalResponse;

  int? _registrationFrequency14d;
  int? get registrationFrequency14d => _$this._registrationFrequency14d;
  set registrationFrequency14d(int? registrationFrequency14d) =>
      _$this._registrationFrequency14d = registrationFrequency14d;

  PatientEvolutionForNutritionistResultBuilder() {
    PatientEvolutionForNutritionistResult._defaults(this);
  }

  PatientEvolutionForNutritionistResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _ibsSssTimeline = $v.ibsSssTimeline?.toBuilder();
      _baselineScore = $v.baselineScore;
      _latestScore = $v.latestScore;
      _percentChangeFromBaseline = $v.percentChangeFromBaseline;
      _significantClinicalResponse = $v.significantClinicalResponse;
      _registrationFrequency14d = $v.registrationFrequency14d;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PatientEvolutionForNutritionistResult other) {
    _$v = other as _$PatientEvolutionForNutritionistResult;
  }

  @override
  void update(
      void Function(PatientEvolutionForNutritionistResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PatientEvolutionForNutritionistResult build() => _build();

  _$PatientEvolutionForNutritionistResult _build() {
    _$PatientEvolutionForNutritionistResult _$result;
    try {
      _$result = _$v ??
          _$PatientEvolutionForNutritionistResult._(
            ibsSssTimeline: _ibsSssTimeline?.build(),
            baselineScore: baselineScore,
            latestScore: latestScore,
            percentChangeFromBaseline: percentChangeFromBaseline,
            significantClinicalResponse: significantClinicalResponse,
            registrationFrequency14d: registrationFrequency14d,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'ibsSssTimeline';
        _ibsSssTimeline?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'PatientEvolutionForNutritionistResult',
            _$failedField,
            e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
