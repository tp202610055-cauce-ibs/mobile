// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fodmap_level.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FodmapLevel _$low = const FodmapLevel._('low');
const FodmapLevel _$moderate = const FodmapLevel._('moderate');
const FodmapLevel _$high = const FodmapLevel._('high');

FodmapLevel _$valueOf(String name) {
  switch (name) {
    case 'low':
      return _$low;
    case 'moderate':
      return _$moderate;
    case 'high':
      return _$high;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FodmapLevel> _$values =
    BuiltSet<FodmapLevel>(const <FodmapLevel>[
  _$low,
  _$moderate,
  _$high,
]);

class _$FodmapLevelMeta {
  const _$FodmapLevelMeta();
  FodmapLevel get low => _$low;
  FodmapLevel get moderate => _$moderate;
  FodmapLevel get high => _$high;
  FodmapLevel valueOf(String name) => _$valueOf(name);
  BuiltSet<FodmapLevel> get values => _$values;
}

abstract class _$FodmapLevelMixin {
  // ignore: non_constant_identifier_names
  _$FodmapLevelMeta get FodmapLevel => const _$FodmapLevelMeta();
}

Serializer<FodmapLevel> _$fodmapLevelSerializer = _$FodmapLevelSerializer();

class _$FodmapLevelSerializer implements PrimitiveSerializer<FodmapLevel> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'low': 'Low',
    'moderate': 'Moderate',
    'high': 'High',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Low': 'low',
    'Moderate': 'moderate',
    'High': 'high',
  };

  @override
  final Iterable<Type> types = const <Type>[FodmapLevel];
  @override
  final String wireName = 'FodmapLevel';

  @override
  Object serialize(Serializers serializers, FodmapLevel object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FodmapLevel deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FodmapLevel.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
