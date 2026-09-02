//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'severity_category.g.dart';

class SeverityCategory extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Mild')
  static const SeverityCategory mild = _$mild;
  @BuiltValueEnumConst(wireName: r'Moderate')
  static const SeverityCategory moderate = _$moderate;
  @BuiltValueEnumConst(wireName: r'Severe')
  static const SeverityCategory severe = _$severe;

  static Serializer<SeverityCategory> get serializer => _$severityCategorySerializer;

  const SeverityCategory._(String name): super(name);

  static BuiltSet<SeverityCategory> get values => _$values;
  static SeverityCategory valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class SeverityCategoryMixin = Object with _$SeverityCategoryMixin;

