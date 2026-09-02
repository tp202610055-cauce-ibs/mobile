//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generate_my_clinical_report_result.g.dart';

/// GenerateMyClinicalReportResult
///
/// Properties:
/// * [reportId] 
/// * [presignedUrl] 
/// * [presignedUrlExpiresAt] 
@BuiltValue()
abstract class GenerateMyClinicalReportResult implements Built<GenerateMyClinicalReportResult, GenerateMyClinicalReportResultBuilder> {
  @BuiltValueField(wireName: r'reportId')
  String? get reportId;

  @BuiltValueField(wireName: r'presignedUrl')
  String? get presignedUrl;

  @BuiltValueField(wireName: r'presignedUrlExpiresAt')
  DateTime? get presignedUrlExpiresAt;

  GenerateMyClinicalReportResult._();

  factory GenerateMyClinicalReportResult([void updates(GenerateMyClinicalReportResultBuilder b)]) = _$GenerateMyClinicalReportResult;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenerateMyClinicalReportResultBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenerateMyClinicalReportResult> get serializer => _$GenerateMyClinicalReportResultSerializer();
}

class _$GenerateMyClinicalReportResultSerializer implements PrimitiveSerializer<GenerateMyClinicalReportResult> {
  @override
  final Iterable<Type> types = const [GenerateMyClinicalReportResult, _$GenerateMyClinicalReportResult];

  @override
  final String wireName = r'GenerateMyClinicalReportResult';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenerateMyClinicalReportResult object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.reportId != null) {
      yield r'reportId';
      yield serializers.serialize(
        object.reportId,
        specifiedType: const FullType(String),
      );
    }
    if (object.presignedUrl != null) {
      yield r'presignedUrl';
      yield serializers.serialize(
        object.presignedUrl,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.presignedUrlExpiresAt != null) {
      yield r'presignedUrlExpiresAt';
      yield serializers.serialize(
        object.presignedUrlExpiresAt,
        specifiedType: const FullType(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GenerateMyClinicalReportResult object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GenerateMyClinicalReportResultBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'reportId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.reportId = valueDes;
          break;
        case r'presignedUrl':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.presignedUrl = valueDes;
          break;
        case r'presignedUrlExpiresAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.presignedUrlExpiresAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GenerateMyClinicalReportResult deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenerateMyClinicalReportResultBuilder();
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

