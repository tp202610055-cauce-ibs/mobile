// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assign_nutritionist_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AssignNutritionistRequest extends AssignNutritionistRequest {
  @override
  final String? invitationCode;

  factory _$AssignNutritionistRequest(
          [void Function(AssignNutritionistRequestBuilder)? updates]) =>
      (AssignNutritionistRequestBuilder()..update(updates))._build();

  _$AssignNutritionistRequest._({this.invitationCode}) : super._();
  @override
  AssignNutritionistRequest rebuild(
          void Function(AssignNutritionistRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AssignNutritionistRequestBuilder toBuilder() =>
      AssignNutritionistRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AssignNutritionistRequest &&
        invitationCode == other.invitationCode;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, invitationCode.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AssignNutritionistRequest')
          ..add('invitationCode', invitationCode))
        .toString();
  }
}

class AssignNutritionistRequestBuilder
    implements
        Builder<AssignNutritionistRequest, AssignNutritionistRequestBuilder> {
  _$AssignNutritionistRequest? _$v;

  String? _invitationCode;
  String? get invitationCode => _$this._invitationCode;
  set invitationCode(String? invitationCode) =>
      _$this._invitationCode = invitationCode;

  AssignNutritionistRequestBuilder() {
    AssignNutritionistRequest._defaults(this);
  }

  AssignNutritionistRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _invitationCode = $v.invitationCode;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AssignNutritionistRequest other) {
    _$v = other as _$AssignNutritionistRequest;
  }

  @override
  void update(void Function(AssignNutritionistRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AssignNutritionistRequest build() => _build();

  _$AssignNutritionistRequest _build() {
    final _$result = _$v ??
        _$AssignNutritionistRequest._(
          invitationCode: invitationCode,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
