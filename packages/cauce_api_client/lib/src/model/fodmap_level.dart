//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'fodmap_level.g.dart';

class FodmapLevel extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Low')
  static const FodmapLevel low = _$low;
  @BuiltValueEnumConst(wireName: r'Moderate')
  static const FodmapLevel moderate = _$moderate;
  @BuiltValueEnumConst(wireName: r'High')
  static const FodmapLevel high = _$high;

  static Serializer<FodmapLevel> get serializer => _$fodmapLevelSerializer;

  const FodmapLevel._(String name): super(name);

  static BuiltSet<FodmapLevel> get values => _$values;
  static FodmapLevel valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FodmapLevelMixin = Object with _$FodmapLevelMixin;

