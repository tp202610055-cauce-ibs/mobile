// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_nutritionist_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GetNutritionistResult extends GetNutritionistResult {
  @override
  final String? userId;
  @override
  final String? email;
  @override
  final String? fullName;
  @override
  final UserStatus? status;

  factory _$GetNutritionistResult(
          [void Function(GetNutritionistResultBuilder)? updates]) =>
      (GetNutritionistResultBuilder()..update(updates))._build();

  _$GetNutritionistResult._(
      {this.userId, this.email, this.fullName, this.status})
      : super._();
  @override
  GetNutritionistResult rebuild(
          void Function(GetNutritionistResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GetNutritionistResultBuilder toBuilder() =>
      GetNutritionistResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GetNutritionistResult &&
        userId == other.userId &&
        email == other.email &&
        fullName == other.fullName &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, userId.hashCode);
    _$hash = $jc(_$hash, email.hashCode);
    _$hash = $jc(_$hash, fullName.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GetNutritionistResult')
          ..add('userId', userId)
          ..add('email', email)
          ..add('fullName', fullName)
          ..add('status', status))
        .toString();
  }
}

class GetNutritionistResultBuilder
    implements Builder<GetNutritionistResult, GetNutritionistResultBuilder> {
  _$GetNutritionistResult? _$v;

  String? _userId;
  String? get userId => _$this._userId;
  set userId(String? userId) => _$this._userId = userId;

  String? _email;
  String? get email => _$this._email;
  set email(String? email) => _$this._email = email;

  String? _fullName;
  String? get fullName => _$this._fullName;
  set fullName(String? fullName) => _$this._fullName = fullName;

  UserStatus? _status;
  UserStatus? get status => _$this._status;
  set status(UserStatus? status) => _$this._status = status;

  GetNutritionistResultBuilder() {
    GetNutritionistResult._defaults(this);
  }

  GetNutritionistResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _email = $v.email;
      _fullName = $v.fullName;
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GetNutritionistResult other) {
    _$v = other as _$GetNutritionistResult;
  }

  @override
  void update(void Function(GetNutritionistResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GetNutritionistResult build() => _build();

  _$GetNutritionistResult _build() {
    final _$result = _$v ??
        _$GetNutritionistResult._(
          userId: userId,
          email: email,
          fullName: fullName,
          status: status,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
