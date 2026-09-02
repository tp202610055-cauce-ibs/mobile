// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'priority_level.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const PriorityLevel _$none = const PriorityLevel._('none');
const PriorityLevel _$low = const PriorityLevel._('low');
const PriorityLevel _$medium = const PriorityLevel._('medium');
const PriorityLevel _$high = const PriorityLevel._('high');

PriorityLevel _$valueOf(String name) {
  switch (name) {
    case 'none':
      return _$none;
    case 'low':
      return _$low;
    case 'medium':
      return _$medium;
    case 'high':
      return _$high;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<PriorityLevel> _$values =
    BuiltSet<PriorityLevel>(const <PriorityLevel>[
  _$none,
  _$low,
  _$medium,
  _$high,
]);

class _$PriorityLevelMeta {
  const _$PriorityLevelMeta();
  PriorityLevel get none => _$none;
  PriorityLevel get low => _$low;
  PriorityLevel get medium => _$medium;
  PriorityLevel get high => _$high;
  PriorityLevel valueOf(String name) => _$valueOf(name);
  BuiltSet<PriorityLevel> get values => _$values;
}

abstract class _$PriorityLevelMixin {
  // ignore: non_constant_identifier_names
  _$PriorityLevelMeta get PriorityLevel => const _$PriorityLevelMeta();
}

Serializer<PriorityLevel> _$priorityLevelSerializer =
    _$PriorityLevelSerializer();

class _$PriorityLevelSerializer implements PrimitiveSerializer<PriorityLevel> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'none': 'None',
    'low': 'Low',
    'medium': 'Medium',
    'high': 'High',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'None': 'none',
    'Low': 'low',
    'Medium': 'medium',
    'High': 'high',
  };

  @override
  final Iterable<Type> types = const <Type>[PriorityLevel];
  @override
  final String wireName = 'PriorityLevel';

  @override
  Object serialize(Serializers serializers, PriorityLevel object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  PriorityLevel deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      PriorityLevel.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
