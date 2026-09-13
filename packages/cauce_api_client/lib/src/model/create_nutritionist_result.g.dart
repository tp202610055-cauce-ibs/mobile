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
  final UserStatus? status;
  @override
  final bool? activationEmailSent;

  factory _$CreateNutritionistResult(
          [void Function(CreateNutritionistResultBuilder)? updates]) =>
      (CreateNutritionistResultBuilder()..update(updates))._build();

  _$CreateNutritionistResult._(
      {this.userId, this.email, this.status, this.activationEmailSent})
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
        status == other.status &&
        activationEmailSent == other.activationEmailSent;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, activationEmailSent.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateNutritionistResult')
          ..add('userId', userId)
          ..add('email', email)
          ..add('status', status)
          ..add('activationEmailSent', activationEmailSent))
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

  UserStatus? _status;
  UserStatus? get status => _$this._status;
  set status(UserStatus? status) => _$this._status = status;

  bool? _activationEmailSent;
  bool? get activationEmailSent => _$this._activationEmailSent;
  set activationEmailSent(bool? activationEmailSent) =>
      _$this._activationEmailSent = activationEmailSent;

  CreateNutritionistResultBuilder() {
    CreateNutritionistResult._defaults(this);
  }

  CreateNutritionistResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _email = $v.email;
      _status = $v.status;
      _activationEmailSent = $v.activationEmailSent;
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
          status: status,
          activationEmailSent: activationEmailSent,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
