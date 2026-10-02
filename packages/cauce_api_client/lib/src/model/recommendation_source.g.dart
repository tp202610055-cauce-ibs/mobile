// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_source.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const RecommendationSource _$engineGenerated =
    const RecommendationSource._('engineGenerated');
const RecommendationSource _$manual = const RecommendationSource._('manual');

RecommendationSource _$valueOf(String name) {
  switch (name) {
    case 'engineGenerated':
      return _$engineGenerated;
    case 'manual':
      return _$manual;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<RecommendationSource> _$values =
    BuiltSet<RecommendationSource>(const <RecommendationSource>[
  _$engineGenerated,
  _$manual,
]);

class _$RecommendationSourceMeta {
  const _$RecommendationSourceMeta();
  RecommendationSource get engineGenerated => _$engineGenerated;
  RecommendationSource get manual => _$manual;
  RecommendationSource valueOf(String name) => _$valueOf(name);
  BuiltSet<RecommendationSource> get values => _$values;
}

abstract class _$RecommendationSourceMixin {
  // ignore: non_constant_identifier_names
  _$RecommendationSourceMeta get RecommendationSource =>
      const _$RecommendationSourceMeta();
}

Serializer<RecommendationSource> _$recommendationSourceSerializer =
    _$RecommendationSourceSerializer();

class _$RecommendationSourceSerializer
    implements PrimitiveSerializer<RecommendationSource> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'engineGenerated': 'EngineGenerated',
    'manual': 'Manual',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'EngineGenerated': 'engineGenerated',
    'Manual': 'manual',
  };

  @override
  final Iterable<Type> types = const <Type>[RecommendationSource];
  @override
  final String wireName = 'RecommendationSource';

  @override
  Object serialize(Serializers serializers, RecommendationSource object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  RecommendationSource deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      RecommendationSource.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
