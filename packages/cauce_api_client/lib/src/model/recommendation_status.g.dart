// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_status.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RecommendationStatus _$generated =
    const RecommendationStatus._('generated');
const RecommendationStatus _$pendingReview =
    const RecommendationStatus._('pendingReview');
const RecommendationStatus _$approved =
    const RecommendationStatus._('approved');
const RecommendationStatus _$modifiedApproved =
    const RecommendationStatus._('modifiedApproved');
const RecommendationStatus _$manualApproved =
    const RecommendationStatus._('manualApproved');
const RecommendationStatus _$rejected =
    const RecommendationStatus._('rejected');
const RecommendationStatus _$delivered =
    const RecommendationStatus._('delivered');
const RecommendationStatus _$feedbackReceived =
    const RecommendationStatus._('feedbackReceived');
const RecommendationStatus _$expired = const RecommendationStatus._('expired');

RecommendationStatus _$valueOf(String name) {
  switch (name) {
    case 'generated':
      return _$generated;
    case 'pendingReview':
      return _$pendingReview;
    case 'approved':
      return _$approved;
    case 'modifiedApproved':
      return _$modifiedApproved;
    case 'manualApproved':
      return _$manualApproved;
    case 'rejected':
      return _$rejected;
    case 'delivered':
      return _$delivered;
    case 'feedbackReceived':
      return _$feedbackReceived;
    case 'expired':
      return _$expired;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<RecommendationStatus> _$values =
    BuiltSet<RecommendationStatus>(const <RecommendationStatus>[
  _$generated,
  _$pendingReview,
  _$approved,
  _$modifiedApproved,
  _$manualApproved,
  _$rejected,
  _$delivered,
  _$feedbackReceived,
  _$expired,
]);

class _$RecommendationStatusMeta {
  const _$RecommendationStatusMeta();
  RecommendationStatus get generated => _$generated;
  RecommendationStatus get pendingReview => _$pendingReview;
  RecommendationStatus get approved => _$approved;
  RecommendationStatus get modifiedApproved => _$modifiedApproved;
  RecommendationStatus get manualApproved => _$manualApproved;
  RecommendationStatus get rejected => _$rejected;
  RecommendationStatus get delivered => _$delivered;
  RecommendationStatus get feedbackReceived => _$feedbackReceived;
  RecommendationStatus get expired => _$expired;
  RecommendationStatus valueOf(String name) => _$valueOf(name);
  BuiltSet<RecommendationStatus> get values => _$values;
}

abstract class _$RecommendationStatusMixin {
  // ignore: non_constant_identifier_names
  _$RecommendationStatusMeta get RecommendationStatus =>
      const _$RecommendationStatusMeta();
}

Serializer<RecommendationStatus> _$recommendationStatusSerializer =
    _$RecommendationStatusSerializer();

class _$RecommendationStatusSerializer
    implements PrimitiveSerializer<RecommendationStatus> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'generated': 'Generated',
    'pendingReview': 'PendingReview',
    'approved': 'Approved',
    'modifiedApproved': 'ModifiedApproved',
    'manualApproved': 'ManualApproved',
    'rejected': 'Rejected',
    'delivered': 'Delivered',
    'feedbackReceived': 'FeedbackReceived',
    'expired': 'Expired',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Generated': 'generated',
    'PendingReview': 'pendingReview',
    'Approved': 'approved',
    'ModifiedApproved': 'modifiedApproved',
    'ManualApproved': 'manualApproved',
    'Rejected': 'rejected',
    'Delivered': 'delivered',
    'FeedbackReceived': 'feedbackReceived',
    'Expired': 'expired',
  };

  @override
  final Iterable<Type> types = const <Type>[RecommendationStatus];
  @override
  final String wireName = 'RecommendationStatus';

  @override
  Object serialize(Serializers serializers, RecommendationStatus object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RecommendationStatus deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RecommendationStatus.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
