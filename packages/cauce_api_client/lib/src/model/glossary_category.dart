//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'glossary_category.g.dart';

class GlossaryCategory extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Nutritional')
  static const GlossaryCategory nutritional = _$nutritional;
  @BuiltValueEnumConst(wireName: r'ClinicalIbs')
  static const GlossaryCategory clinicalIbs = _$clinicalIbs;
  @BuiltValueEnumConst(wireName: r'System')
  static const GlossaryCategory system = _$system;

  static Serializer<GlossaryCategory> get serializer => _$glossaryCategorySerializer;

  const GlossaryCategory._(String name): super(name);

  static BuiltSet<GlossaryCategory> get values => _$values;
  static GlossaryCategory valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class GlossaryCategoryMixin = Object with _$GlossaryCategoryMixin;

