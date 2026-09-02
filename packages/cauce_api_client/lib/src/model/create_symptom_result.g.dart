// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_symptom_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateSymptomResult extends CreateSymptomResult {
  @override
  final String? symptomId;
  @override
  final String? associatedMealId;
  @override
  final bool? hasMealAssociation;

  factory _$CreateSymptomResult(
          [void Function(CreateSymptomResultBuilder)? updates]) =>
      (CreateSymptomResultBuilder()..update(updates))._build();

  _$CreateSymptomResult._(
      {this.symptomId, this.associatedMealId, this.hasMealAssociation})
      : super._();
  @override
  CreateSymptomResult rebuild(
          void Function(CreateSymptomResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateSymptomResultBuilder toBuilder() =>
      CreateSymptomResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateSymptomResult &&
        symptomId == other.symptomId &&
        associatedMealId == other.associatedMealId &&
        hasMealAssociation == other.hasMealAssociation;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, symptomId.hashCode);
    _$hash = $jc(_$hash, associatedMealId.hashCode);
    _$hash = $jc(_$hash, hasMealAssociation.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateSymptomResult')
          ..add('symptomId', symptomId)
          ..add('associatedMealId', associatedMealId)
          ..add('hasMealAssociation', hasMealAssociation))
        .toString();
  }
}

class CreateSymptomResultBuilder
    implements Builder<CreateSymptomResult, CreateSymptomResultBuilder> {
  _$CreateSymptomResult? _$v;

  String? _symptomId;
  String? get symptomId => _$this._symptomId;
  set symptomId(String? symptomId) => _$this._symptomId = symptomId;

  String? _associatedMealId;
  String? get associatedMealId => _$this._associatedMealId;
  set associatedMealId(String? associatedMealId) =>
      _$this._associatedMealId = associatedMealId;

  bool? _hasMealAssociation;
  bool? get hasMealAssociation => _$this._hasMealAssociation;
  set hasMealAssociation(bool? hasMealAssociation) =>
      _$this._hasMealAssociation = hasMealAssociation;

  CreateSymptomResultBuilder() {
    CreateSymptomResult._defaults(this);
  }

  CreateSymptomResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _symptomId = $v.symptomId;
      _associatedMealId = $v.associatedMealId;
      _hasMealAssociation = $v.hasMealAssociation;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateSymptomResult other) {
    _$v = other as _$CreateSymptomResult;
  }

  @override
  void update(void Function(CreateSymptomResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateSymptomResult build() => _build();

  _$CreateSymptomResult _build() {
    final _$result = _$v ??
        _$CreateSymptomResult._(
          symptomId: symptomId,
          associatedMealId: associatedMealId,
          hasMealAssociation: hasMealAssociation,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
