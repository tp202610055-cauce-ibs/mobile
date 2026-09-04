// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'measurement_unit.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MeasurementUnit _$grams = const MeasurementUnit._('grams');
const MeasurementUnit _$cups = const MeasurementUnit._('cups');
const MeasurementUnit _$units = const MeasurementUnit._('units');
const MeasurementUnit _$ounces = const MeasurementUnit._('ounces');
const MeasurementUnit _$tablespoons = const MeasurementUnit._('tablespoons');

MeasurementUnit _$valueOf(String name) {
  switch (name) {
    case 'grams':
      return _$grams;
    case 'cups':
      return _$cups;
    case 'units':
      return _$units;
    case 'ounces':
      return _$ounces;
    case 'tablespoons':
      return _$tablespoons;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MeasurementUnit> _$values =
    BuiltSet<MeasurementUnit>(const <MeasurementUnit>[
  _$grams,
  _$cups,
  _$units,
  _$ounces,
  _$tablespoons,
]);

class _$MeasurementUnitMeta {
  const _$MeasurementUnitMeta();
  MeasurementUnit get grams => _$grams;
  MeasurementUnit get cups => _$cups;
  MeasurementUnit get units => _$units;
  MeasurementUnit get ounces => _$ounces;
  MeasurementUnit get tablespoons => _$tablespoons;
  MeasurementUnit valueOf(String name) => _$valueOf(name);
  BuiltSet<MeasurementUnit> get values => _$values;
}

abstract class _$MeasurementUnitMixin {
  // ignore: non_constant_identifier_names
  _$MeasurementUnitMeta get MeasurementUnit => const _$MeasurementUnitMeta();
}

Serializer<MeasurementUnit> _$measurementUnitSerializer =
    _$MeasurementUnitSerializer();

class _$MeasurementUnitSerializer
    implements PrimitiveSerializer<MeasurementUnit> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'grams': 'Grams',
    'cups': 'Cups',
    'units': 'Units',
    'ounces': 'Ounces',
    'tablespoons': 'Tablespoons',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Grams': 'grams',
    'Cups': 'cups',
    'Units': 'units',
    'Ounces': 'ounces',
    'Tablespoons': 'tablespoons',
  };

  @override
  final Iterable<Type> types = const <Type>[MeasurementUnit];
  @override
  final String wireName = 'MeasurementUnit';

  @override
  Object serialize(Serializers serializers, MeasurementUnit object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MeasurementUnit deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MeasurementUnit.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
