// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_reason.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ArchiveReason _$temporalExpiration =
    const ArchiveReason._('temporalExpiration');
const ArchiveReason _$manualSubstitution =
    const ArchiveReason._('manualSubstitution');
const ArchiveReason _$objectiveMet = const ArchiveReason._('objectiveMet');
const ArchiveReason _$planChange = const ArchiveReason._('planChange');

ArchiveReason _$valueOf(String name) {
  switch (name) {
    case 'temporalExpiration':
      return _$temporalExpiration;
    case 'manualSubstitution':
      return _$manualSubstitution;
    case 'objectiveMet':
      return _$objectiveMet;
    case 'planChange':
      return _$planChange;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ArchiveReason> _$values =
    BuiltSet<ArchiveReason>(const <ArchiveReason>[
  _$temporalExpiration,
  _$manualSubstitution,
  _$objectiveMet,
  _$planChange,
]);

class _$ArchiveReasonMeta {
  const _$ArchiveReasonMeta();
  ArchiveReason get temporalExpiration => _$temporalExpiration;
  ArchiveReason get manualSubstitution => _$manualSubstitution;
  ArchiveReason get objectiveMet => _$objectiveMet;
  ArchiveReason get planChange => _$planChange;
  ArchiveReason valueOf(String name) => _$valueOf(name);
  BuiltSet<ArchiveReason> get values => _$values;
}

abstract class _$ArchiveReasonMixin {
  // ignore: non_constant_identifier_names
  _$ArchiveReasonMeta get ArchiveReason => const _$ArchiveReasonMeta();
}

Serializer<ArchiveReason> _$archiveReasonSerializer =
    _$ArchiveReasonSerializer();

class _$ArchiveReasonSerializer implements PrimitiveSerializer<ArchiveReason> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'temporalExpiration': 'TemporalExpiration',
    'manualSubstitution': 'ManualSubstitution',
    'objectiveMet': 'ObjectiveMet',
    'planChange': 'PlanChange',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'TemporalExpiration': 'temporalExpiration',
    'ManualSubstitution': 'manualSubstitution',
    'ObjectiveMet': 'objectiveMet',
    'PlanChange': 'planChange',
  };

  @override
  final Iterable<Type> types = const <Type>[ArchiveReason];
  @override
  final String wireName = 'ArchiveReason';

  @override
  Object serialize(Serializers serializers, ArchiveReason object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ArchiveReason deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ArchiveReason.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
