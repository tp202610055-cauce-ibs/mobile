//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'feedback_outcome.g.dart';

class FeedbackOutcome extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Improvement')
  static const FeedbackOutcome improvement = _$improvement;
  @BuiltValueEnumConst(wireName: r'NoChange')
  static const FeedbackOutcome noChange = _$noChange;
  @BuiltValueEnumConst(wireName: r'Worsening')
  static const FeedbackOutcome worsening = _$worsening;

  static Serializer<FeedbackOutcome> get serializer => _$feedbackOutcomeSerializer;

  const FeedbackOutcome._(String name): super(name);

  static BuiltSet<FeedbackOutcome> get values => _$values;
  static FeedbackOutcome valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class FeedbackOutcomeMixin = Object with _$FeedbackOutcomeMixin;

