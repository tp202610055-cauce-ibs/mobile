// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explanation_source.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const ExplanationSource _$llmGenerated =
    const ExplanationSource._('llmGenerated');
const ExplanationSource _$fallback = const ExplanationSource._('fallback');
const ExplanationSource _$manual = const ExplanationSource._('manual');

ExplanationSource _$valueOf(String name) {
  switch (name) {
    case 'llmGenerated':
      return _$llmGenerated;
    case 'fallback':
      return _$fallback;
    case 'manual':
      return _$manual;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<ExplanationSource> _$values =
    BuiltSet<ExplanationSource>(const <ExplanationSource>[
  _$llmGenerated,
  _$fallback,
  _$manual,
]);

class _$ExplanationSourceMeta {
  const _$ExplanationSourceMeta();
  ExplanationSource get llmGenerated => _$llmGenerated;
  ExplanationSource get fallback => _$fallback;
  ExplanationSource get manual => _$manual;
  ExplanationSource valueOf(String name) => _$valueOf(name);
  BuiltSet<ExplanationSource> get values => _$values;
}

abstract class _$ExplanationSourceMixin {
  // ignore: non_constant_identifier_names
  _$ExplanationSourceMeta get ExplanationSource =>
      const _$ExplanationSourceMeta();
}

Serializer<ExplanationSource> _$explanationSourceSerializer =
    _$ExplanationSourceSerializer();

class _$ExplanationSourceSerializer
    implements PrimitiveSerializer<ExplanationSource> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'llmGenerated': 'LlmGenerated',
    'fallback': 'Fallback',
    'manual': 'Manual',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'LlmGenerated': 'llmGenerated',
    'Fallback': 'fallback',
    'Manual': 'manual',
  };

  @override
  final Iterable<Type> types = const <Type>[ExplanationSource];
  @override
  final String wireName = 'ExplanationSource';

  @override
  Object serialize(Serializers serializers, ExplanationSource object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  ExplanationSource deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      ExplanationSource.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
