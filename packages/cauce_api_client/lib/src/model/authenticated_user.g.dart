// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authenticated_user.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AuthenticatedUser extends AuthenticatedUser {
  @override
  final String? userId;
  @override
  final String? keycloakId;
  @override
  final String? email;
  @override
  final String? role;
  @override
  final String? fullName;
  @override
  final bool? emailVerified;
  @override
  final bool? isInActivePilot;

  factory _$AuthenticatedUser(
          [void Function(AuthenticatedUserBuilder)? updates]) =>
      (AuthenticatedUserBuilder()..update(updates))._build();

  _$AuthenticatedUser._(
      {this.userId,
      this.keycloakId,
      this.email,
      this.role,
      this.fullName,
      this.emailVerified,
      this.isInActivePilot})
      : super._();
  @override
  AuthenticatedUser rebuild(void Function(AuthenticatedUserBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AuthenticatedUserBuilder toBuilder() =>
      AuthenticatedUserBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AuthenticatedUser &&
        userId == other.userId &&
        keycloakId == other.keycloakId &&
        email == other.email &&
        role == other.role &&
        fullName == other.fullName &&
        emailVerified == other.emailVerified &&
        isInActivePilot == other.isInActivePilot;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, keycloakId.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, emailVerified.hashCode);
    _$hash = $jc(_$hash, isInActivePilot.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AuthenticatedUser')
          ..add('userId', userId)
          ..add('keycloakId', keycloakId)
          ..add('email', email)
          ..add('role', role)
          ..add('fullName', fullName)
          ..add('emailVerified', emailVerified)
          ..add('isInActivePilot', isInActivePilot))
        .toString();
  }
}

class AuthenticatedUserBuilder
    implements Builder<AuthenticatedUser, AuthenticatedUserBuilder> {
  _$AuthenticatedUser? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _keycloakId;
  String? get keycloakId => _$this._keycloakId;
  set keycloakId(String? keycloakId) => _$this._keycloakId = keycloakId;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  bool? _emailVerified;
  bool? get emailVerified => _$this._emailVerified;
  set emailVerified(bool? emailVerified) =>
      _$this._emailVerified = emailVerified;

  bool? _isInActivePilot;
  bool? get isInActivePilot => _$this._isInActivePilot;
  set isInActivePilot(bool? isInActivePilot) =>
      _$this._isInActivePilot = isInActivePilot;

  AuthenticatedUserBuilder() {
    AuthenticatedUser._defaults(this);
  }

  AuthenticatedUserBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _keycloakId = $v.keycloakId;
      _email = $v.email;
      _role = $v.role;
      _fullName = $v.fullName;
      _emailVerified = $v.emailVerified;
      _isInActivePilot = $v.isInActivePilot;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AuthenticatedUser other) {
    _$v = other as _$AuthenticatedUser;
  }

  @override
  void update(void Function(AuthenticatedUserBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AuthenticatedUser build() => _build();

  _$AuthenticatedUser _build() {
    final _$result = _$v ??
        _$AuthenticatedUser._(
          userId: userId,
          keycloakId: keycloakId,
          email: email,
          role: role,
          fullName: fullName,
          emailVerified: emailVerified,
          isInActivePilot: isInActivePilot,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
