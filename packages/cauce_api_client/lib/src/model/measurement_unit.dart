//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'measurement_unit.g.dart';

class MeasurementUnit extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Grams')
  static const MeasurementUnit grams = _$grams;
  @BuiltValueEnumConst(wireName: r'Cups')
  static const MeasurementUnit cups = _$cups;
  @BuiltValueEnumConst(wireName: r'Units')
  static const MeasurementUnit units = _$units;
  @BuiltValueEnumConst(wireName: r'Ounces')
  static const MeasurementUnit ounces = _$ounces;
  @BuiltValueEnumConst(wireName: r'Tablespoons')
  static const MeasurementUnit tablespoons = _$tablespoons;

  static Serializer<MeasurementUnit> get serializer => _$measurementUnitSerializer;

  const MeasurementUnit._(String name): super(name);

  static BuiltSet<MeasurementUnit> get values => _$values;
  static MeasurementUnit valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class MeasurementUnitMixin = Object with _$MeasurementUnitMixin;

