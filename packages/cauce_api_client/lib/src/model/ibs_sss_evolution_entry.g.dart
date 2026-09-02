// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ibs_sss_evolution_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$IbsSssEvolutionEntry extends IbsSssEvolutionEntry {
  @override
  final IbsSssAssessmentSummary? assessment;
  @override
  final int? deltaFromBaseline;

  factory _$IbsSssEvolutionEntry(
          [void Function(IbsSssEvolutionEntryBuilder)? updates]) =>
      (IbsSssEvolutionEntryBuilder()..update(updates))._build();

  _$IbsSssEvolutionEntry._({this.assessment, this.deltaFromBaseline})
      : super._();
  @override
  IbsSssEvolutionEntry rebuild(
          void Function(IbsSssEvolutionEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  IbsSssEvolutionEntryBuilder toBuilder() =>
      IbsSssEvolutionEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is IbsSssEvolutionEntry &&
        assessment == other.assessment &&
        deltaFromBaseline == other.deltaFromBaseline;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, assessment.hashCode);
    _$hash = $jc(_$hash, deltaFromBaseline.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'IbsSssEvolutionEntry')
          ..add('assessment', assessment)
          ..add('deltaFromBaseline', deltaFromBaseline))
        .toString();
  }
}

class IbsSssEvolutionEntryBuilder
    implements Builder<IbsSssEvolutionEntry, IbsSssEvolutionEntryBuilder> {
  _$IbsSssEvolutionEntry? _$v;

  IbsSssAssessmentSummaryBuilder? _assessment;
  IbsSssAssessmentSummaryBuilder get assessment =>
      _$this._assessment ??= IbsSssAssessmentSummaryBuilder();
  set assessment(IbsSssAssessmentSummaryBuilder? assessment) =>
      _$this._assessment = assessment;

  int? _deltaFromBaseline;
  int? get deltaFromBaseline => _$this._deltaFromBaseline;
  set deltaFromBaseline(int? deltaFromBaseline) =>
      _$this._deltaFromBaseline = deltaFromBaseline;

  IbsSssEvolutionEntryBuilder() {
    IbsSssEvolutionEntry._defaults(this);
  }

  IbsSssEvolutionEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _assessment = $v.assessment?.toBuilder();
      _deltaFromBaseline = $v.deltaFromBaseline;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(IbsSssEvolutionEntry other) {
    _$v = other as _$IbsSssEvolutionEntry;
  }

  @override
  void update(void Function(IbsSssEvolutionEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  IbsSssEvolutionEntry build() => _build();

  _$IbsSssEvolutionEntry _build() {
    _$IbsSssEvolutionEntry _$result;
    try {
      _$result = _$v ??
          _$IbsSssEvolutionEntry._(
            assessment: _assessment?.build(),
            deltaFromBaseline: deltaFromBaseline,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'assessment';
        _assessment?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'IbsSssEvolutionEntry', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
