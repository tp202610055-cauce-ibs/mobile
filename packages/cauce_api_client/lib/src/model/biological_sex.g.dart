// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'biological_sex.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const BiologicalSex _$male = const BiologicalSex._('male');
const BiologicalSex _$female = const BiologicalSex._('female');
const BiologicalSex _$other = const BiologicalSex._('other');

BiologicalSex _$valueOf(String name) {
  switch (name) {
    case 'male':
      return _$male;
    case 'female':
      return _$female;
    case 'other':
      return _$other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<BiologicalSex> _$values =
    BuiltSet<BiologicalSex>(const <BiologicalSex>[
  _$male,
  _$female,
  _$other,
]);

class _$BiologicalSexMeta {
  const _$BiologicalSexMeta();
  BiologicalSex get male => _$male;
  BiologicalSex get female => _$female;
  BiologicalSex get other => _$other;
  BiologicalSex valueOf(String name) => _$valueOf(name);
  BuiltSet<BiologicalSex> get values => _$values;
}

abstract class _$BiologicalSexMixin {
  // ignore: non_constant_identifier_names
  _$BiologicalSexMeta get BiologicalSex => const _$BiologicalSexMeta();
}

Serializer<BiologicalSex> _$biologicalSexSerializer =
    _$BiologicalSexSerializer();

class _$BiologicalSexSerializer implements PrimitiveSerializer<BiologicalSex> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'male': 'Male',
    'female': 'Female',
    'other': 'Other',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Male': 'male',
    'Female': 'female',
    'Other': 'other',
  };

  @override
  final Iterable<Type> types = const <Type>[BiologicalSex];
  @override
  final String wireName = 'BiologicalSex';

  @override
  Object serialize(Serializers serializers, BiologicalSex object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  BiologicalSex deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      BiologicalSex.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
