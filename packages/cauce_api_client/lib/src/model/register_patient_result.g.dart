// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_patient_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RegisterPatientResult extends RegisterPatientResult {
  @override
  final String? userId;
  @override
  final String? email;
  @override
  final UserStatus? status;
  @override
  final bool? emailVerificationRequired;

  factory _$RegisterPatientResult(
          [void Function(RegisterPatientResultBuilder)? updates]) =>
      (RegisterPatientResultBuilder()..update(updates))._build();

  _$RegisterPatientResult._(
      {this.userId, this.email, this.status, this.emailVerificationRequired})
      : super._();
  @override
  RegisterPatientResult rebuild(
          void Function(RegisterPatientResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RegisterPatientResultBuilder toBuilder() =>
      RegisterPatientResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RegisterPatientResult &&
        userId == other.userId &&
        email == other.email &&
        status == other.status &&
        emailVerificationRequired == other.emailVerificationRequired;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, emailVerificationRequired.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RegisterPatientResult')
          ..add('userId', userId)
          ..add('email', email)
          ..add('status', status)
          ..add('emailVerificationRequired', emailVerificationRequired))
        .toString();
  }
}

class RegisterPatientResultBuilder
    implements Builder<RegisterPatientResult, RegisterPatientResultBuilder> {
  _$RegisterPatientResult? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  UserStatus? _status;
  UserStatus? get status => _$this._status;
  set status(UserStatus? status) => _$this._status = status;

  bool? _emailVerificationRequired;
  bool? get emailVerificationRequired => _$this._emailVerificationRequired;
  set emailVerificationRequired(bool? emailVerificationRequired) =>
      _$this._emailVerificationRequired = emailVerificationRequired;

  RegisterPatientResultBuilder() {
    RegisterPatientResult._defaults(this);
  }

  RegisterPatientResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _email = $v.email;
      _status = $v.status;
      _emailVerificationRequired = $v.emailVerificationRequired;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RegisterPatientResult other) {
    _$v = other as _$RegisterPatientResult;
  }

  @override
  void update(void Function(RegisterPatientResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RegisterPatientResult build() => _build();

  _$RegisterPatientResult _build() {
    final _$result = _$v ??
        _$RegisterPatientResult._(
          userId: userId,
          email: email,
          status: status,
          emailVerificationRequired: emailVerificationRequired,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
