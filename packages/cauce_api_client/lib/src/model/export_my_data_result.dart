//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'export_my_data_result.g.dart';

/// ExportMyDataResult
///
/// Properties:
/// * [downloadUrl] 
/// * [expiresAtUtc] 
@BuiltValue()
abstract class ExportMyDataResult implements Built<ExportMyDataResult, ExportMyDataResultBuilder> {
  @BuiltValueField(wireName: r'downloadUrl')
  String? get downloadUrl;

  @BuiltValueField(wireName: r'expiresAtUtc')
  DateTime? get expiresAtUtc;

  ExportMyDataResult._();

  factory ExportMyDataResult([void updates(ExportMyDataResultBuilder b)]) = _$ExportMyDataResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExportMyDataResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExportMyDataResult> get serializer => _$ExportMyDataResultSerializer();
}

class _$ExportMyDataResultSerializer implements PrimitiveSerializer<ExportMyDataResult> {
  @override
  final Iterable<Type> types = const [ExportMyDataResult, _$ExportMyDataResult];

  @override
  final String wireName = r'ExportMyDataResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExportMyDataResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.downloadUrl != null) {
      yield r'downloadUrl';
      yield serializers.serialize(
        object.downloadUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.expiresAtUtc != null) {
      yield r'expiresAtUtc';
      yield serializers.serialize(
        object.expiresAtUtc,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ExportMyDataResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExportMyDataResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'downloadUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.downloadUrl = valueDes;
          break;
        case r'expiresAtUtc':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.expiresAtUtc = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExportMyDataResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExportMyDataResultBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}

