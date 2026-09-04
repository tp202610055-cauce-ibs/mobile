// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ActionType _$suggest = const ActionType._('suggest');
const ActionType _$reduce = const ActionType._('reduce');
const ActionType _$avoid = const ActionType._('avoid');
const ActionType _$substitute = const ActionType._('substitute');

ActionType _$valueOf(String name) {
  switch (name) {
    case 'suggest':
      return _$suggest;
    case 'reduce':
      return _$reduce;
    case 'avoid':
      return _$avoid;
    case 'substitute':
      return _$substitute;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ActionType> _$values = BuiltSet<ActionType>(const <ActionType>[
  _$suggest,
  _$reduce,
  _$avoid,
  _$substitute,
]);

class _$ActionTypeMeta {
  const _$ActionTypeMeta();
  ActionType get suggest => _$suggest;
  ActionType get reduce => _$reduce;
  ActionType get avoid => _$avoid;
  ActionType get substitute => _$substitute;
  ActionType valueOf(String name) => _$valueOf(name);
  BuiltSet<ActionType> get values => _$values;
}

abstract class _$ActionTypeMixin {
  // ignore: non_constant_identifier_names
  _$ActionTypeMeta get ActionType => const _$ActionTypeMeta();
}

Serializer<ActionType> _$actionTypeSerializer = _$ActionTypeSerializer();

class _$ActionTypeSerializer implements PrimitiveSerializer<ActionType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'suggest': 'Suggest',
    'reduce': 'Reduce',
    'avoid': 'Avoid',
    'substitute': 'Substitute',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Suggest': 'suggest',
    'Reduce': 'reduce',
    'Avoid': 'avoid',
    'Substitute': 'substitute',
  };

  @override
  final Iterable<Type> types = const <Type>[ActionType];
  @override
  final String wireName = 'ActionType';

  @override
  Object serialize(Serializers serializers, ActionType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ActionType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ActionType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
