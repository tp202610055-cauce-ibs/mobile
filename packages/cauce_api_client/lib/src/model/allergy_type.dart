//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'allergy_type.g.dart';

class AllergyType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Allergy')
  static const AllergyType allergy = _$allergy;
  @BuiltValueEnumConst(wireName: r'Intolerance')
  static const AllergyType intolerance = _$intolerance;
  @BuiltValueEnumConst(wireName: r'Sensitivity')
  static const AllergyType sensitivity = _$sensitivity;

  static Serializer<AllergyType> get serializer => _$allergyTypeSerializer;

  const AllergyType._(String name): super(name);

  static BuiltSet<AllergyType> get values => _$values;
  static AllergyType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AllergyTypeMixin = Object with _$AllergyTypeMixin;

