// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_accepted_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SyncAcceptedEntry extends SyncAcceptedEntry {
  @override
  final String? clientGuid;
  @override
  final String? serverId;
  @override
  final String? entityType;

  factory _$SyncAcceptedEntry(
          [void Function(SyncAcceptedEntryBuilder)? updates]) =>
      (SyncAcceptedEntryBuilder()..update(updates))._build();

  _$SyncAcceptedEntry._({this.clientGuid, this.serverId, this.entityType})
      : super._();
  @override
  SyncAcceptedEntry rebuild(void Function(SyncAcceptedEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SyncAcceptedEntryBuilder toBuilder() =>
      SyncAcceptedEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncAcceptedEntry &&
        clientGuid == other.clientGuid &&
        serverId == other.serverId &&
        entityType == other.entityType;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientGuid.hashCode);
    _$hash = $jc(_$hash, serverId.hashCode);
    _$hash = $jc(_$hash, entityType.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SyncAcceptedEntry')
          ..add('clientGuid', clientGuid)
          ..add('serverId', serverId)
          ..add('entityType', entityType))
        .toString();
  }
}

class SyncAcceptedEntryBuilder
    implements Builder<SyncAcceptedEntry, SyncAcceptedEntryBuilder> {
  _$SyncAcceptedEntry? _$v;

  String? _clientGuid;
  String? get clientGuid => _$this._clientGuid;
  set clientGuid(String? clientGuid) => _$this._clientGuid = clientGuid;

  String? _serverId;
  String? get serverId => _$this._serverId;
  set serverId(String? serverId) => _$this._serverId = serverId;

  String? _entityType;
  String? get entityType => _$this._entityType;
  set entityType(String? entityType) => _$this._entityType = entityType;

  SyncAcceptedEntryBuilder() {
    SyncAcceptedEntry._defaults(this);
  }

  SyncAcceptedEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientGuid = $v.clientGuid;
      _serverId = $v.serverId;
      _entityType = $v.entityType;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SyncAcceptedEntry other) {
    _$v = other as _$SyncAcceptedEntry;
  }

  @override
  void update(void Function(SyncAcceptedEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncAcceptedEntry build() => _build();

  _$SyncAcceptedEntry _build() {
    final _$result = _$v ??
        _$SyncAcceptedEntry._(
          clientGuid: clientGuid,
          serverId: serverId,
          entityType: entityType,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
