//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recommendation_source.g.dart';

class RecommendationSource extends EnumClass {

  @BuiltValueEnumConst(wireName: r'EngineGenerated')
  static const RecommendationSource engineGenerated = _$engineGenerated;
  @BuiltValueEnumConst(wireName: r'Manual')
  static const RecommendationSource manual = _$manual;

  static Serializer<RecommendationSource> get serializer => _$recommendationSourceSerializer;

  const RecommendationSource._(String name): super(name);

  static BuiltSet<RecommendationSource> get values => _$values;
  static RecommendationSource valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class RecommendationSourceMixin = Object with _$RecommendationSourceMixin;

