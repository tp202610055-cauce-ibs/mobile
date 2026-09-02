// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_nutritionist_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateNutritionistRequest extends CreateNutritionistRequest {
  @override
  final String? email;
  @override
  final String? fullName;

  factory _$CreateNutritionistRequest(
          [void Function(CreateNutritionistRequestBuilder)? updates]) =>
      (CreateNutritionistRequestBuilder()..update(updates))._build();

  _$CreateNutritionistRequest._({this.email, this.fullName}) : super._();
  @override
  CreateNutritionistRequest rebuild(
          void Function(CreateNutritionistRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateNutritionistRequestBuilder toBuilder() =>
      CreateNutritionistRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateNutritionistRequest &&
        email == other.email &&
        fullName == other.fullName;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateNutritionistRequest')
          ..add('email', email)
          ..add('fullName', fullName))
        .toString();
  }
}

class CreateNutritionistRequestBuilder
    implements
        Builder<CreateNutritionistRequest, CreateNutritionistRequestBuilder> {
  _$CreateNutritionistRequest? _$v;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  CreateNutritionistRequestBuilder() {
    CreateNutritionistRequest._defaults(this);
  }

  CreateNutritionistRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _email = $v.email;
      _fullName = $v.fullName;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateNutritionistRequest other) {
    _$v = other as _$CreateNutritionistRequest;
  }

  @override
  void update(void Function(CreateNutritionistRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateNutritionistRequest build() => _build();

  _$CreateNutritionistRequest _build() {
    final _$result = _$v ??
        _$CreateNutritionistRequest._(
          email: email,
          fullName: fullName,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
