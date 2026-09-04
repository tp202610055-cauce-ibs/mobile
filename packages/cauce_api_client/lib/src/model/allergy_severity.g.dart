// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy_severity.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const AllergySeverity _$mild = const AllergySeverity._('mild');
const AllergySeverity _$moderate = const AllergySeverity._('moderate');
const AllergySeverity _$severe = const AllergySeverity._('severe');

AllergySeverity _$valueOf(String name) {
  switch (name) {
    case 'mild':
      return _$mild;
    case 'moderate':
      return _$moderate;
    case 'severe':
      return _$severe;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<AllergySeverity> _$values =
    BuiltSet<AllergySeverity>(const <AllergySeverity>[
  _$mild,
  _$moderate,
  _$severe,
]);

class _$AllergySeverityMeta {
  const _$AllergySeverityMeta();
  AllergySeverity get mild => _$mild;
  AllergySeverity get moderate => _$moderate;
  AllergySeverity get severe => _$severe;
  AllergySeverity valueOf(String name) => _$valueOf(name);
  BuiltSet<AllergySeverity> get values => _$values;
}

abstract class _$AllergySeverityMixin {
  // ignore: non_constant_identifier_names
  _$AllergySeverityMeta get AllergySeverity => const _$AllergySeverityMeta();
}

Serializer<AllergySeverity> _$allergySeveritySerializer =
    _$AllergySeveritySerializer();

class _$AllergySeveritySerializer
    implements PrimitiveSerializer<AllergySeverity> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'mild': 'Mild',
    'moderate': 'Moderate',
    'severe': 'Severe',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Mild': 'mild',
    'Moderate': 'moderate',
    'Severe': 'severe',
  };

  @override
  final Iterable<Type> types = const <Type>[AllergySeverity];
  @override
  final String wireName = 'AllergySeverity';

  @override
  Object serialize(Serializers serializers, AllergySeverity object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  AllergySeverity deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      AllergySeverity.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
