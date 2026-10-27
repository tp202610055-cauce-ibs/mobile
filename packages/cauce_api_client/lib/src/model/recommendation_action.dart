//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recommendation_action.g.dart';

class RecommendationAction extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Approve')
  static const RecommendationAction approve = _$approve;
  @BuiltValueEnumConst(wireName: r'Modify')
  static const RecommendationAction modify = _$modify;
  @BuiltValueEnumConst(wireName: r'Reject')
  static const RecommendationAction reject = _$reject;
  @BuiltValueEnumConst(wireName: r'Archive')
  static const RecommendationAction archive = _$archive;

  static Serializer<RecommendationAction> get serializer => _$recommendationActionSerializer;

  const RecommendationAction._(String name): super(name);

  static BuiltSet<RecommendationAction> get values => _$values;
  static RecommendationAction valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class RecommendationActionMixin = Object with _$RecommendationActionMixin;

