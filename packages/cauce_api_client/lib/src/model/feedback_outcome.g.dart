// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feedback_outcome.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const FeedbackOutcome _$improvement = const FeedbackOutcome._('improvement');
const FeedbackOutcome _$noChange = const FeedbackOutcome._('noChange');
const FeedbackOutcome _$worsening = const FeedbackOutcome._('worsening');

FeedbackOutcome _$valueOf(String name) {
  switch (name) {
    case 'improvement':
      return _$improvement;
    case 'noChange':
      return _$noChange;
    case 'worsening':
      return _$worsening;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<FeedbackOutcome> _$values =
    BuiltSet<FeedbackOutcome>(const <FeedbackOutcome>[
  _$improvement,
  _$noChange,
  _$worsening,
]);

class _$FeedbackOutcomeMeta {
  const _$FeedbackOutcomeMeta();
  FeedbackOutcome get improvement => _$improvement;
  FeedbackOutcome get noChange => _$noChange;
  FeedbackOutcome get worsening => _$worsening;
  FeedbackOutcome valueOf(String name) => _$valueOf(name);
  BuiltSet<FeedbackOutcome> get values => _$values;
}

abstract class _$FeedbackOutcomeMixin {
  // ignore: non_constant_identifier_names
  _$FeedbackOutcomeMeta get FeedbackOutcome => const _$FeedbackOutcomeMeta();
}

Serializer<FeedbackOutcome> _$feedbackOutcomeSerializer =
    _$FeedbackOutcomeSerializer();

class _$FeedbackOutcomeSerializer
    implements PrimitiveSerializer<FeedbackOutcome> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'improvement': 'Improvement',
    'noChange': 'NoChange',
    'worsening': 'Worsening',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Improvement': 'improvement',
    'NoChange': 'noChange',
    'Worsening': 'worsening',
  };

  @override
  final Iterable<Type> types = const <Type>[FeedbackOutcome];
  @override
  final String wireName = 'FeedbackOutcome';

  @override
  Object serialize(Serializers serializers, FeedbackOutcome object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  FeedbackOutcome deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      FeedbackOutcome.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
