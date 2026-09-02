// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_duplicate_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SyncDuplicateEntry extends SyncDuplicateEntry {
  @override
  final String? clientGuid;
  @override
  final String? existingServerId;

  factory _$SyncDuplicateEntry(
          [void Function(SyncDuplicateEntryBuilder)? updates]) =>
      (SyncDuplicateEntryBuilder()..update(updates))._build();

  _$SyncDuplicateEntry._({this.clientGuid, this.existingServerId}) : super._();
  @override
  SyncDuplicateEntry rebuild(
          void Function(SyncDuplicateEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SyncDuplicateEntryBuilder toBuilder() =>
      SyncDuplicateEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncDuplicateEntry &&
        clientGuid == other.clientGuid &&
        existingServerId == other.existingServerId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientGuid.hashCode);
    _$hash = $jc(_$hash, existingServerId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SyncDuplicateEntry')
          ..add('clientGuid', clientGuid)
          ..add('existingServerId', existingServerId))
        .toString();
  }
}

class SyncDuplicateEntryBuilder
    implements Builder<SyncDuplicateEntry, SyncDuplicateEntryBuilder> {
  _$SyncDuplicateEntry? _$v;

  String? _clientGuid;
  String? get clientGuid => _$this._clientGuid;
  set clientGuid(String? clientGuid) => _$this._clientGuid = clientGuid;

  String? _existingServerId;
  String? get existingServerId => _$this._existingServerId;
  set existingServerId(String? existingServerId) =>
      _$this._existingServerId = existingServerId;

  SyncDuplicateEntryBuilder() {
    SyncDuplicateEntry._defaults(this);
  }

  SyncDuplicateEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientGuid = $v.clientGuid;
      _existingServerId = $v.existingServerId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SyncDuplicateEntry other) {
    _$v = other as _$SyncDuplicateEntry;
  }

  @override
  void update(void Function(SyncDuplicateEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncDuplicateEntry build() => _build();

  _$SyncDuplicateEntry _build() {
    final _$result = _$v ??
        _$SyncDuplicateEntry._(
          clientGuid: clientGuid,
          existingServerId: existingServerId,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
