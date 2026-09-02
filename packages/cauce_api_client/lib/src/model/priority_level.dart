//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'priority_level.g.dart';

class PriorityLevel extends EnumClass {

  @BuiltValueEnumConst(wireName: r'None')
  static const PriorityLevel none = _$none;
  @BuiltValueEnumConst(wireName: r'Low')
  static const PriorityLevel low = _$low;
  @BuiltValueEnumConst(wireName: r'Medium')
  static const PriorityLevel medium = _$medium;
  @BuiltValueEnumConst(wireName: r'High')
  static const PriorityLevel high = _$high;

  static Serializer<PriorityLevel> get serializer => _$priorityLevelSerializer;

  const PriorityLevel._(String name): super(name);

  static BuiltSet<PriorityLevel> get values => _$values;
  static PriorityLevel valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class PriorityLevelMixin = Object with _$PriorityLevelMixin;

