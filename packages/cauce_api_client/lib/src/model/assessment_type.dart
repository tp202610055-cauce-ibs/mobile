//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'assessment_type.g.dart';

class AssessmentType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Baseline')
  static const AssessmentType baseline = _$baseline;
  @BuiltValueEnumConst(wireName: r'Periodic')
  static const AssessmentType periodic = _$periodic;

  static Serializer<AssessmentType> get serializer => _$assessmentTypeSerializer;

  const AssessmentType._(String name): super(name);

  static BuiltSet<AssessmentType> get values => _$values;
  static AssessmentType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class AssessmentTypeMixin = Object with _$AssessmentTypeMixin;

