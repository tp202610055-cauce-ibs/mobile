//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generate_clinical_report_request.g.dart';

/// Solicitud de generación de un reporte clínico para un paciente en un período.
///
/// Properties:
/// * [periodStart] - Inicio del período.
/// * [periodEnd] - Fin del período.
@BuiltValue()
abstract class GenerateClinicalReportRequest implements Built<GenerateClinicalReportRequest, GenerateClinicalReportRequestBuilder> {
  /// Inicio del período.
  @BuiltValueField(wireName: r'periodStart')
  Date? get periodStart;

  /// Fin del período.
  @BuiltValueField(wireName: r'periodEnd')
  Date? get periodEnd;

  GenerateClinicalReportRequest._();

  factory GenerateClinicalReportRequest([void updates(GenerateClinicalReportRequestBuilder b)]) = _$GenerateClinicalReportRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenerateClinicalReportRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenerateClinicalReportRequest> get serializer => _$GenerateClinicalReportRequestSerializer();
}

class _$GenerateClinicalReportRequestSerializer implements PrimitiveSerializer<GenerateClinicalReportRequest> {
  @override
  final Iterable<Type> types = const [GenerateClinicalReportRequest, _$GenerateClinicalReportRequest];

  @override
  final String wireName = r'GenerateClinicalReportRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenerateClinicalReportRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.periodStart != null) {
      yield r'periodStart';
      yield serializers.serialize(
        object.periodStart,
        specifiedType: const FullType(Date),
      );
    }
    if (object.periodEnd != null) {
      yield r'periodEnd';
      yield serializers.serialize(
        object.periodEnd,
        specifiedType: const FullType(Date),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GenerateClinicalReportRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GenerateClinicalReportRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'periodStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.periodStart = valueDes;
          break;
        case r'periodEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(Date),
          ) as Date;
          result.periodEnd = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  GenerateClinicalReportRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenerateClinicalReportRequestBuilder();
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

