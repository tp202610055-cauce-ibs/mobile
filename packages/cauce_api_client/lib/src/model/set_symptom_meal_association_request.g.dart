// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'set_symptom_meal_association_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SetSymptomMealAssociationRequest
    extends SetSymptomMealAssociationRequest {
  @override
  final String? mealId;

  factory _$SetSymptomMealAssociationRequest(
          [void Function(SetSymptomMealAssociationRequestBuilder)? updates]) =>
      (SetSymptomMealAssociationRequestBuilder()..update(updates))._build();

  _$SetSymptomMealAssociationRequest._({this.mealId}) : super._();
  @override
  SetSymptomMealAssociationRequest rebuild(
          void Function(SetSymptomMealAssociationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SetSymptomMealAssociationRequestBuilder toBuilder() =>
      SetSymptomMealAssociationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SetSymptomMealAssociationRequest && mealId == other.mealId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mealId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SetSymptomMealAssociationRequest')
          ..add('mealId', mealId))
        .toString();
  }
}

class SetSymptomMealAssociationRequestBuilder
    implements
        Builder<SetSymptomMealAssociationRequest,
            SetSymptomMealAssociationRequestBuilder> {
  _$SetSymptomMealAssociationRequest? _$v;

  String? _mealId;
  String? get mealId => _$this._mealId;
  set mealId(String? mealId) => _$this._mealId = mealId;

  SetSymptomMealAssociationRequestBuilder() {
    SetSymptomMealAssociationRequest._defaults(this);
  }

  SetSymptomMealAssociationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mealId = $v.mealId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SetSymptomMealAssociationRequest other) {
    _$v = other as _$SetSymptomMealAssociationRequest;
  }

  @override
  void update(void Function(SetSymptomMealAssociationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SetSymptomMealAssociationRequest build() => _build();

  _$SetSymptomMealAssociationRequest _build() {
    final _$result = _$v ??
        _$SetSymptomMealAssociationRequest._(
          mealId: mealId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
