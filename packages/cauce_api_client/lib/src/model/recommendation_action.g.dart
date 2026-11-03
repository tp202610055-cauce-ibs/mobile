// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_action.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RecommendationAction _$approve = const RecommendationAction._('approve');
const RecommendationAction _$modify = const RecommendationAction._('modify');
const RecommendationAction _$reject = const RecommendationAction._('reject');
const RecommendationAction _$archive = const RecommendationAction._('archive');

RecommendationAction _$valueOf(String name) {
  switch (name) {
    case 'approve':
      return _$approve;
    case 'modify':
      return _$modify;
    case 'reject':
      return _$reject;
    case 'archive':
      return _$archive;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<RecommendationAction> _$values =
    BuiltSet<RecommendationAction>(const <RecommendationAction>[
  _$approve,
  _$modify,
  _$reject,
  _$archive,
]);

class _$RecommendationActionMeta {
  const _$RecommendationActionMeta();
  RecommendationAction get approve => _$approve;
  RecommendationAction get modify => _$modify;
  RecommendationAction get reject => _$reject;
  RecommendationAction get archive => _$archive;
  RecommendationAction valueOf(String name) => _$valueOf(name);
  BuiltSet<RecommendationAction> get values => _$values;
}

abstract class _$RecommendationActionMixin {
  // ignore: non_constant_identifier_names
  _$RecommendationActionMeta get RecommendationAction =>
      const _$RecommendationActionMeta();
}

Serializer<RecommendationAction> _$recommendationActionSerializer =
    _$RecommendationActionSerializer();

class _$RecommendationActionSerializer
    implements PrimitiveSerializer<RecommendationAction> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'approve': 'Approve',
    'modify': 'Modify',
    'reject': 'Reject',
    'archive': 'Archive',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Approve': 'approve',
    'Modify': 'modify',
    'Reject': 'reject',
    'Archive': 'archive',
  };

  @override
  final Iterable<Type> types = const <Type>[RecommendationAction];
  @override
  final String wireName = 'RecommendationAction';

  @override
  Object serialize(Serializers serializers, RecommendationAction object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RecommendationAction deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RecommendationAction.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
