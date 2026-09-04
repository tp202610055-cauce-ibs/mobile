// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SyncStatus _$syncPending = const SyncStatus._('syncPending');
const SyncStatus _$syncCompleted = const SyncStatus._('syncCompleted');

SyncStatus _$valueOf(String name) {
  switch (name) {
    case 'syncPending':
      return _$syncPending;
    case 'syncCompleted':
      return _$syncCompleted;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SyncStatus> _$values = BuiltSet<SyncStatus>(const <SyncStatus>[
  _$syncPending,
  _$syncCompleted,
]);

class _$SyncStatusMeta {
  const _$SyncStatusMeta();
  SyncStatus get syncPending => _$syncPending;
  SyncStatus get syncCompleted => _$syncCompleted;
  SyncStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<SyncStatus> get values => _$values;
}

abstract class _$SyncStatusMixin {
  // ignore: non_constant_identifier_names
  _$SyncStatusMeta get SyncStatus => const _$SyncStatusMeta();
}

Serializer<SyncStatus> _$syncStatusSerializer = _$SyncStatusSerializer();

class _$SyncStatusSerializer implements PrimitiveSerializer<SyncStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'syncPending': 'SyncPending',
    'syncCompleted': 'SyncCompleted',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'SyncPending': 'syncPending',
    'SyncCompleted': 'syncCompleted',
  };

  @override
  final Iterable<Type> types = const <Type>[SyncStatus];
  @override
  final String wireName = 'SyncStatus';

  @override
  Object serialize(Serializers serializers, SyncStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SyncStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SyncStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
