// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_invitation_code_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$GenerateInvitationCodeResult extends GenerateInvitationCodeResult {
  @override
  final String? code;
  @override
  final DateTime? expiresAt;

  factory _$GenerateInvitationCodeResult(
          [void Function(GenerateInvitationCodeResultBuilder)? updates]) =>
      (GenerateInvitationCodeResultBuilder()..update(updates))._build();

  _$GenerateInvitationCodeResult._({this.code, this.expiresAt}) : super._();
  @override
  GenerateInvitationCodeResult rebuild(
          void Function(GenerateInvitationCodeResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GenerateInvitationCodeResultBuilder toBuilder() =>
      GenerateInvitationCodeResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GenerateInvitationCodeResult &&
        code == other.code &&
        expiresAt == other.expiresAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, code.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'GenerateInvitationCodeResult')
          ..add('code', code)
          ..add('expiresAt', expiresAt))
        .toString();
  }
}

class GenerateInvitationCodeResultBuilder
    implements
        Builder<GenerateInvitationCodeResult,
            GenerateInvitationCodeResultBuilder> {
  _$GenerateInvitationCodeResult? _$v;

  String? _code;
  String? get code => _$this._code;
  set code(String? code) => _$this._code = code;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  GenerateInvitationCodeResultBuilder() {
    GenerateInvitationCodeResult._defaults(this);
  }

  GenerateInvitationCodeResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _code = $v.code;
      _expiresAt = $v.expiresAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GenerateInvitationCodeResult other) {
    _$v = other as _$GenerateInvitationCodeResult;
  }

  @override
  void update(void Function(GenerateInvitationCodeResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  GenerateInvitationCodeResult build() => _build();

  _$GenerateInvitationCodeResult _build() {
    final _$result = _$v ??
        _$GenerateInvitationCodeResult._(
          code: code,
          expiresAt: expiresAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
