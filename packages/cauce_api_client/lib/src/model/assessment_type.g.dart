// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AssessmentType _$baseline = const AssessmentType._('baseline');
const AssessmentType _$periodic = const AssessmentType._('periodic');

AssessmentType _$valueOf(String name) {
  switch (name) {
    case 'baseline':
      return _$baseline;
    case 'periodic':
      return _$periodic;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AssessmentType> _$values =
    BuiltSet<AssessmentType>(const <AssessmentType>[
  _$baseline,
  _$periodic,
]);

class _$AssessmentTypeMeta {
  const _$AssessmentTypeMeta();
  AssessmentType get baseline => _$baseline;
  AssessmentType get periodic => _$periodic;
  AssessmentType valueOf(String name) => _$valueOf(name);
  BuiltSet<AssessmentType> get values => _$values;
}

abstract class _$AssessmentTypeMixin {
  // ignore: non_constant_identifier_names
  _$AssessmentTypeMeta get AssessmentType => const _$AssessmentTypeMeta();
}

Serializer<AssessmentType> _$assessmentTypeSerializer =
    _$AssessmentTypeSerializer();

class _$AssessmentTypeSerializer
    implements PrimitiveSerializer<AssessmentType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'baseline': 'Baseline',
    'periodic': 'Periodic',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Baseline': 'baseline',
    'Periodic': 'periodic',
  };

  @override
  final Iterable<Type> types = const <Type>[AssessmentType];
  @override
  final String wireName = 'AssessmentType';

  @override
  Object serialize(Serializers serializers, AssessmentType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AssessmentType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AssessmentType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
