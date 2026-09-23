//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/date.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'generate_my_clinical_report_request.g.dart';

/// Cuerpo opcional de la solicitud del autoreporte clínico del paciente (US24). Si se omite el  cuerpo, o si ambos extremos llegan en null, el reporte cubre la ventana por  defecto de 90 días hacia atrás.
///
/// Properties:
/// * [periodStart] - Inicio del período, o null.
/// * [periodEnd] - Fin del período, o null.
@BuiltValue()
abstract class GenerateMyClinicalReportRequest implements Built<GenerateMyClinicalReportRequest, GenerateMyClinicalReportRequestBuilder> {
  /// Inicio del período, o null.
  @BuiltValueField(wireName: r'periodStart')
  Date? get periodStart;

  /// Fin del período, o null.
  @BuiltValueField(wireName: r'periodEnd')
  Date? get periodEnd;

  GenerateMyClinicalReportRequest._();

  factory GenerateMyClinicalReportRequest([void updates(GenerateMyClinicalReportRequestBuilder b)]) = _$GenerateMyClinicalReportRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(GenerateMyClinicalReportRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<GenerateMyClinicalReportRequest> get serializer => _$GenerateMyClinicalReportRequestSerializer();
}

class _$GenerateMyClinicalReportRequestSerializer implements PrimitiveSerializer<GenerateMyClinicalReportRequest> {
  @override
  final Iterable<Type> types = const [GenerateMyClinicalReportRequest, _$GenerateMyClinicalReportRequest];

  @override
  final String wireName = r'GenerateMyClinicalReportRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    GenerateMyClinicalReportRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.periodStart != null) {
      yield r'periodStart';
      yield serializers.serialize(
        object.periodStart,
        specifiedType: const FullType.nullable(Date),
      );
    }
    if (object.periodEnd != null) {
      yield r'periodEnd';
      yield serializers.serialize(
        object.periodEnd,
        specifiedType: const FullType.nullable(Date),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    GenerateMyClinicalReportRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required GenerateMyClinicalReportRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'periodStart':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
          result.periodStart = valueDes;
          break;
        case r'periodEnd':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(Date),
          ) as Date?;
          if (valueDes == null) continue;
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
  GenerateMyClinicalReportRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = GenerateMyClinicalReportRequestBuilder();
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

