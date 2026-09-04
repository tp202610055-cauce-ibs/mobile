// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UserStatus _$pendingActivation = const UserStatus._('pendingActivation');
const UserStatus _$active = const UserStatus._('active');
const UserStatus _$inactive = const UserStatus._('inactive');
const UserStatus _$suspended = const UserStatus._('suspended');

UserStatus _$valueOf(String name) {
  switch (name) {
    case 'pendingActivation':
      return _$pendingActivation;
    case 'active':
      return _$active;
    case 'inactive':
      return _$inactive;
    case 'suspended':
      return _$suspended;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UserStatus> _$values = BuiltSet<UserStatus>(const <UserStatus>[
  _$pendingActivation,
  _$active,
  _$inactive,
  _$suspended,
]);

class _$UserStatusMeta {
  const _$UserStatusMeta();
  UserStatus get pendingActivation => _$pendingActivation;
  UserStatus get active => _$active;
  UserStatus get inactive => _$inactive;
  UserStatus get suspended => _$suspended;
  UserStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<UserStatus> get values => _$values;
}

abstract class _$UserStatusMixin {
  // ignore: non_constant_identifier_names
  _$UserStatusMeta get UserStatus => const _$UserStatusMeta();
}

Serializer<UserStatus> _$userStatusSerializer = _$UserStatusSerializer();

class _$UserStatusSerializer implements PrimitiveSerializer<UserStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'pendingActivation': 'PendingActivation',
    'active': 'Active',
    'inactive': 'Inactive',
    'suspended': 'Suspended',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PendingActivation': 'pendingActivation',
    'Active': 'active',
    'Inactive': 'inactive',
    'Suspended': 'suspended',
  };

  @override
  final Iterable<Type> types = const <Type>[UserStatus];
  @override
  final String wireName = 'UserStatus';

  @override
  Object serialize(Serializers serializers, UserStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UserStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UserStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
