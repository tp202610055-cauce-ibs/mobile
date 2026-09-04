// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AllergyType _$allergy = const AllergyType._('allergy');
const AllergyType _$intolerance = const AllergyType._('intolerance');
const AllergyType _$sensitivity = const AllergyType._('sensitivity');

AllergyType _$valueOf(String name) {
  switch (name) {
    case 'allergy':
      return _$allergy;
    case 'intolerance':
      return _$intolerance;
    case 'sensitivity':
      return _$sensitivity;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AllergyType> _$values =
    BuiltSet<AllergyType>(const <AllergyType>[
  _$allergy,
  _$intolerance,
  _$sensitivity,
]);

class _$AllergyTypeMeta {
  const _$AllergyTypeMeta();
  AllergyType get allergy => _$allergy;
  AllergyType get intolerance => _$intolerance;
  AllergyType get sensitivity => _$sensitivity;
  AllergyType valueOf(String name) => _$valueOf(name);
  BuiltSet<AllergyType> get values => _$values;
}

abstract class _$AllergyTypeMixin {
  // ignore: non_constant_identifier_names
  _$AllergyTypeMeta get AllergyType => const _$AllergyTypeMeta();
}

Serializer<AllergyType> _$allergyTypeSerializer = _$AllergyTypeSerializer();

class _$AllergyTypeSerializer implements PrimitiveSerializer<AllergyType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'allergy': 'Allergy',
    'intolerance': 'Intolerance',
    'sensitivity': 'Sensitivity',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Allergy': 'allergy',
    'Intolerance': 'intolerance',
    'Sensitivity': 'sensitivity',
  };

  @override
  final Iterable<Type> types = const <Type>[AllergyType];
  @override
  final String wireName = 'AllergyType';

  @override
  Object serialize(Serializers serializers, AllergyType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AllergyType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AllergyType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
