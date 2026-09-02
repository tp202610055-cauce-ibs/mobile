//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'allergy_severity.g.dart';

class AllergySeverity extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Mild')
  static const AllergySeverity mild = _$mild;
  @BuiltValueEnumConst(wireName: r'Moderate')
  static const AllergySeverity moderate = _$moderate;
  @BuiltValueEnumConst(wireName: r'Severe')
  static const AllergySeverity severe = _$severe;

  static Serializer<AllergySeverity> get serializer => _$allergySeveritySerializer;

  const AllergySeverity._(String name): super(name);

  static BuiltSet<AllergySeverity> get values => _$values;
  static AllergySeverity valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AllergySeverityMixin = Object with _$AllergySeverityMixin;

