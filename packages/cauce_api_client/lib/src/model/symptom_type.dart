//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'symptom_type.g.dart';

class SymptomType extends EnumClass {

  @BuiltValueEnumConst(wireName: r'AbdominalPain')
  static const SymptomType abdominalPain = _$abdominalPain;
  @BuiltValueEnumConst(wireName: r'Bloating')
  static const SymptomType bloating = _$bloating;
  @BuiltValueEnumConst(wireName: r'Flatulence')
  static const SymptomType flatulence = _$flatulence;
  @BuiltValueEnumConst(wireName: r'Diarrhea')
  static const SymptomType diarrhea = _$diarrhea;
  @BuiltValueEnumConst(wireName: r'Constipation')
  static const SymptomType constipation = _$constipation;
  @BuiltValueEnumConst(wireName: r'Other')
  static const SymptomType other = _$other;
  @BuiltValueEnumConst(wireName: r'Nausea')
  static const SymptomType nausea = _$nausea;
  @BuiltValueEnumConst(wireName: r'Reflux')
  static const SymptomType reflux = _$reflux;
  @BuiltValueEnumConst(wireName: r'Urgency')
  static const SymptomType urgency = _$urgency;

  static Serializer<SymptomType> get serializer => _$symptomTypeSerializer;

  const SymptomType._(String name): super(name);

  static BuiltSet<SymptomType> get values => _$values;
  static SymptomType valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class SymptomTypeMixin = Object with _$SymptomTypeMixin;

