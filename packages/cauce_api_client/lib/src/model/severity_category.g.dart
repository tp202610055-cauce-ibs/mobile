// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'severity_category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const SeverityCategory _$mild = const SeverityCategory._('mild');
const SeverityCategory _$moderate = const SeverityCategory._('moderate');
const SeverityCategory _$severe = const SeverityCategory._('severe');

SeverityCategory _$valueOf(String name) {
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

final BuiltSet<SeverityCategory> _$values =
    BuiltSet<SeverityCategory>(const <SeverityCategory>[
  _$mild,
  _$moderate,
  _$severe,
]);

class _$SeverityCategoryMeta {
  const _$SeverityCategoryMeta();
  SeverityCategory get mild => _$mild;
  SeverityCategory get moderate => _$moderate;
  SeverityCategory get severe => _$severe;
  SeverityCategory valueOf(String name) => _$valueOf(name);
  BuiltSet<SeverityCategory> get values => _$values;
}

abstract class _$SeverityCategoryMixin {
  // ignore: non_constant_identifier_names
  _$SeverityCategoryMeta get SeverityCategory => const _$SeverityCategoryMeta();
}

Serializer<SeverityCategory> _$severityCategorySerializer =
    _$SeverityCategorySerializer();

class _$SeverityCategorySerializer
    implements PrimitiveSerializer<SeverityCategory> {
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
  final Iterable<Type> types = const <Type>[SeverityCategory];
  @override
  final String wireName = 'SeverityCategory';

  @override
  Object serialize(Serializers serializers, SeverityCategory object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  SeverityCategory deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      SeverityCategory.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
