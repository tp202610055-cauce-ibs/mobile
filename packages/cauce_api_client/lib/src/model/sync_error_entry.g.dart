// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_error_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SyncErrorEntry extends SyncErrorEntry {
  @override
  final String? clientGuid;
  @override
  final String? errorCode;
  @override
  final String? message;

  factory _$SyncErrorEntry([void Function(SyncErrorEntryBuilder)? updates]) =>
      (SyncErrorEntryBuilder()..update(updates))._build();

  _$SyncErrorEntry._({this.clientGuid, this.errorCode, this.message})
      : super._();
  @override
  SyncErrorEntry rebuild(void Function(SyncErrorEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SyncErrorEntryBuilder toBuilder() => SyncErrorEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncErrorEntry &&
        clientGuid == other.clientGuid &&
        errorCode == other.errorCode &&
        message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientGuid.hashCode);
    _$hash = $jc(_$hash, errorCode.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SyncErrorEntry')
          ..add('clientGuid', clientGuid)
          ..add('errorCode', errorCode)
          ..add('message', message))
        .toString();
  }
}

class SyncErrorEntryBuilder
    implements Builder<SyncErrorEntry, SyncErrorEntryBuilder> {
  _$SyncErrorEntry? _$v;

  String? _clientGuid;
  String? get clientGuid => _$this._clientGuid;
  set clientGuid(String? clientGuid) => _$this._clientGuid = clientGuid;

  String? _errorCode;
  String? get errorCode => _$this._errorCode;
  set errorCode(String? errorCode) => _$this._errorCode = errorCode;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  SyncErrorEntryBuilder() {
    SyncErrorEntry._defaults(this);
  }

  SyncErrorEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientGuid = $v.clientGuid;
      _errorCode = $v.errorCode;
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SyncErrorEntry other) {
    _$v = other as _$SyncErrorEntry;
  }

  @override
  void update(void Function(SyncErrorEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncErrorEntry build() => _build();

  _$SyncErrorEntry _build() {
    final _$result = _$v ??
        _$SyncErrorEntry._(
          clientGuid: clientGuid,
          errorCode: errorCode,
          message: message,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
