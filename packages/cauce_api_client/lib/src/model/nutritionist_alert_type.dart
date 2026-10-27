//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'nutritionist_alert_type.g.dart';

class NutritionistAlertType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'PatientLinked')
  static const NutritionistAlertType patientLinked = _$patientLinked;
  @BuiltValueEnumConst(wireName: r'PatientSubtypeChanged')
  static const NutritionistAlertType patientSubtypeChanged = _$patientSubtypeChanged;

  static Serializer<NutritionistAlertType> get serializer => _$nutritionistAlertTypeSerializer;

  const NutritionistAlertType._(String name): super(name);

  static BuiltSet<NutritionistAlertType> get values => _$values;
  static NutritionistAlertType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class NutritionistAlertTypeMixin = Object with _$NutritionistAlertTypeMixin;

