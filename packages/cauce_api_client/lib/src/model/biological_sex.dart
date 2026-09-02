//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'biological_sex.g.dart';

class BiologicalSex extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Male')
  static const BiologicalSex male = _$male;
  @BuiltValueEnumConst(wireName: r'Female')
  static const BiologicalSex female = _$female;
  @BuiltValueEnumConst(wireName: r'Other')
  static const BiologicalSex other = _$other;

  static Serializer<BiologicalSex> get serializer => _$biologicalSexSerializer;

  const BiologicalSex._(String name): super(name);

  static BuiltSet<BiologicalSex> get values => _$values;
  static BiologicalSex valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class BiologicalSexMixin = Object with _$BiologicalSexMixin;

