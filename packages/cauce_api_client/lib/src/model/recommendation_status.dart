//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'recommendation_status.g.dart';

class RecommendationStatus extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Generated')
  static const RecommendationStatus generated = _$generated;
  @BuiltValueEnumConst(wireName: r'PendingReview')
  static const RecommendationStatus pendingReview = _$pendingReview;
  @BuiltValueEnumConst(wireName: r'Approved')
  static const RecommendationStatus approved = _$approved;
  @BuiltValueEnumConst(wireName: r'ModifiedApproved')
  static const RecommendationStatus modifiedApproved = _$modifiedApproved;
  @BuiltValueEnumConst(wireName: r'ManualApproved')
  static const RecommendationStatus manualApproved = _$manualApproved;
  @BuiltValueEnumConst(wireName: r'Rejected')
  static const RecommendationStatus rejected = _$rejected;
  @BuiltValueEnumConst(wireName: r'Delivered')
  static const RecommendationStatus delivered = _$delivered;
  @BuiltValueEnumConst(wireName: r'FeedbackReceived')
  static const RecommendationStatus feedbackReceived = _$feedbackReceived;
  @BuiltValueEnumConst(wireName: r'Expired')
  static const RecommendationStatus expired = _$expired;

  static Serializer<RecommendationStatus> get serializer => _$recommendationStatusSerializer;

  const RecommendationStatus._(String name): super(name);

  static BuiltSet<RecommendationStatus> get values => _$values;
  static RecommendationStatus valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class RecommendationStatusMixin = Object with _$RecommendationStatusMixin;

