//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'explanation_source.g.dart';

class ExplanationSource extends EnumClass {

  @BuiltValueEnumConst(wireName: r'LlmGenerated')
  static const ExplanationSource llmGenerated = _$llmGenerated;
  @BuiltValueEnumConst(wireName: r'Fallback')
  static const ExplanationSource fallback = _$fallback;
  @BuiltValueEnumConst(wireName: r'Manual')
  static const ExplanationSource manual = _$manual;

  static Serializer<ExplanationSource> get serializer => _$explanationSourceSerializer;

  const ExplanationSource._(String name): super(name);

  static BuiltSet<ExplanationSource> get values => _$values;
  static ExplanationSource valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class ExplanationSourceMixin = Object with _$ExplanationSourceMixin;

