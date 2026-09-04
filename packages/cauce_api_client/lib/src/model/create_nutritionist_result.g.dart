// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_nutritionist_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateNutritionistResult extends CreateNutritionistResult {
  @override
  final String? userId;
  @override
  final String? email;
  @override
  final bool? temporaryCredentialsEmailSent;

  factory _$CreateNutritionistResult(
          [void Function(CreateNutritionistResultBuilder)? updates]) =>
      (CreateNutritionistResultBuilder()..update(updates))._build();

  _$CreateNutritionistResult._(
      {this.userId, this.email, this.temporaryCredentialsEmailSent})
      : super._();
  @override
  CreateNutritionistResult rebuild(
          void Function(CreateNutritionistResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateNutritionistResultBuilder toBuilder() =>
      CreateNutritionistResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateNutritionistResult &&
        userId == other.userId &&
        email == other.email &&
        temporaryCredentialsEmailSent == other.temporaryCredentialsEmailSent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, temporaryCredentialsEmailSent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateNutritionistResult')
          ..add('userId', userId)
          ..add('email', email)
          ..add('temporaryCredentialsEmailSent', temporaryCredentialsEmailSent))
        .toString();
  }
}

class CreateNutritionistResultBuilder
    implements
        Builder<CreateNutritionistResult, CreateNutritionistResultBuilder> {
  _$CreateNutritionistResult? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  bool? _temporaryCredentialsEmailSent;
  bool? get temporaryCredentialsEmailSent =>
      _$this._temporaryCredentialsEmailSent;
  set temporaryCredentialsEmailSent(bool? temporaryCredentialsEmailSent) =>
      _$this._temporaryCredentialsEmailSent = temporaryCredentialsEmailSent;

  CreateNutritionistResultBuilder() {
    CreateNutritionistResult._defaults(this);
  }

  CreateNutritionistResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _email = $v.email;
      _temporaryCredentialsEmailSent = $v.temporaryCredentialsEmailSent;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateNutritionistResult other) {
    _$v = other as _$CreateNutritionistResult;
  }

  @override
  void update(void Function(CreateNutritionistResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateNutritionistResult build() => _build();

  _$CreateNutritionistResult _build() {
    final _$result = _$v ??
        _$CreateNutritionistResult._(
          userId: userId,
          email: email,
          temporaryCredentialsEmailSent: temporaryCredentialsEmailSent,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
