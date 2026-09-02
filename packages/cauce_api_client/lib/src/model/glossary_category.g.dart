// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glossary_category.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const GlossaryCategory _$nutritional = const GlossaryCategory._('nutritional');
const GlossaryCategory _$clinicalIbs = const GlossaryCategory._('clinicalIbs');
const GlossaryCategory _$system = const GlossaryCategory._('system');

GlossaryCategory _$valueOf(String name) {
  switch (name) {
    case 'nutritional':
      return _$nutritional;
    case 'clinicalIbs':
      return _$clinicalIbs;
    case 'system':
      return _$system;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<GlossaryCategory> _$values =
    BuiltSet<GlossaryCategory>(const <GlossaryCategory>[
  _$nutritional,
  _$clinicalIbs,
  _$system,
]);

class _$GlossaryCategoryMeta {
  const _$GlossaryCategoryMeta();
  GlossaryCategory get nutritional => _$nutritional;
  GlossaryCategory get clinicalIbs => _$clinicalIbs;
  GlossaryCategory get system => _$system;
  GlossaryCategory valueOf(String name) => _$valueOf(name);
  BuiltSet<GlossaryCategory> get values => _$values;
}

abstract class _$GlossaryCategoryMixin {
  // ignore: non_constant_identifier_names
  _$GlossaryCategoryMeta get GlossaryCategory => const _$GlossaryCategoryMeta();
}

Serializer<GlossaryCategory> _$glossaryCategorySerializer =
    _$GlossaryCategorySerializer();

class _$GlossaryCategorySerializer
    implements PrimitiveSerializer<GlossaryCategory> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'nutritional': 'Nutritional',
    'clinicalIbs': 'ClinicalIbs',
    'system': 'System',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Nutritional': 'nutritional',
    'ClinicalIbs': 'clinicalIbs',
    'System': 'system',
  };

  @override
  final Iterable<Type> types = const <Type>[GlossaryCategory];
  @override
  final String wireName = 'GlossaryCategory';

  @override
  Object serialize(Serializers serializers, GlossaryCategory object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  GlossaryCategory deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      GlossaryCategory.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
