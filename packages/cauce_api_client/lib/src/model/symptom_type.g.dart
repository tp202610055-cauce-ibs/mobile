// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symptom_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SymptomType _$abdominalPain = const SymptomType._('abdominalPain');
const SymptomType _$bloating = const SymptomType._('bloating');
const SymptomType _$flatulence = const SymptomType._('flatulence');
const SymptomType _$diarrhea = const SymptomType._('diarrhea');
const SymptomType _$constipation = const SymptomType._('constipation');
const SymptomType _$other = const SymptomType._('other');
const SymptomType _$nausea = const SymptomType._('nausea');
const SymptomType _$reflux = const SymptomType._('reflux');
const SymptomType _$urgency = const SymptomType._('urgency');

SymptomType _$valueOf(String name) {
  switch (name) {
    case 'abdominalPain':
      return _$abdominalPain;
    case 'bloating':
      return _$bloating;
    case 'flatulence':
      return _$flatulence;
    case 'diarrhea':
      return _$diarrhea;
    case 'constipation':
      return _$constipation;
    case 'other':
      return _$other;
    case 'nausea':
      return _$nausea;
    case 'reflux':
      return _$reflux;
    case 'urgency':
      return _$urgency;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<SymptomType> _$values =
    BuiltSet<SymptomType>(const <SymptomType>[
  _$abdominalPain,
  _$bloating,
  _$flatulence,
  _$diarrhea,
  _$constipation,
  _$other,
  _$nausea,
  _$reflux,
  _$urgency,
]);

class _$SymptomTypeMeta {
  const _$SymptomTypeMeta();
  SymptomType get abdominalPain => _$abdominalPain;
  SymptomType get bloating => _$bloating;
  SymptomType get flatulence => _$flatulence;
  SymptomType get diarrhea => _$diarrhea;
  SymptomType get constipation => _$constipation;
  SymptomType get other => _$other;
  SymptomType get nausea => _$nausea;
  SymptomType get reflux => _$reflux;
  SymptomType get urgency => _$urgency;
  SymptomType valueOf(String name) => _$valueOf(name);
  BuiltSet<SymptomType> get values => _$values;
}

abstract class _$SymptomTypeMixin {
  // ignore: non_constant_identifier_names
  _$SymptomTypeMeta get SymptomType => const _$SymptomTypeMeta();
}

Serializer<SymptomType> _$symptomTypeSerializer = _$SymptomTypeSerializer();

class _$SymptomTypeSerializer implements PrimitiveSerializer<SymptomType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'abdominalPain': 'AbdominalPain',
    'bloating': 'Bloating',
    'flatulence': 'Flatulence',
    'diarrhea': 'Diarrhea',
    'constipation': 'Constipation',
    'other': 'Other',
    'nausea': 'Nausea',
    'reflux': 'Reflux',
    'urgency': 'Urgency',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'AbdominalPain': 'abdominalPain',
    'Bloating': 'bloating',
    'Flatulence': 'flatulence',
    'Diarrhea': 'diarrhea',
    'Constipation': 'constipation',
    'Other': 'other',
    'Nausea': 'nausea',
    'Reflux': 'reflux',
    'Urgency': 'urgency',
  };

  @override
  final Iterable<Type> types = const <Type>[SymptomType];
  @override
  final String wireName = 'SymptomType';

  @override
  Object serialize(Serializers serializers, SymptomType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SymptomType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SymptomType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
