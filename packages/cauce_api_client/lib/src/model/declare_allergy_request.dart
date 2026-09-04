//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/allergy_severity.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'declare_allergy_request.g.dart';

/// Cuerpo de la petición para declarar una alergia del paciente.
///
/// Properties:
/// * [allergyId] - Identificador de la alergia del catálogo.
/// * [severity] 
/// * [notes] - Notas opcionales.
@BuiltValue()
abstract class DeclareAllergyRequest implements Built<DeclareAllergyRequest, DeclareAllergyRequestBuilder> {
  /// Identificador de la alergia del catálogo.
  @BuiltValueField(wireName: r'allergyId')
  String? get allergyId;

  @BuiltValueField(wireName: r'severity')
  AllergySeverity? get severity;
  // enum severityEnum {  Mild,  Moderate,  Severe,  };

  /// Notas opcionales.
  @BuiltValueField(wireName: r'notes')
  String? get notes;

  DeclareAllergyRequest._();

  factory DeclareAllergyRequest([void updates(DeclareAllergyRequestBuilder b)]) = _$DeclareAllergyRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DeclareAllergyRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DeclareAllergyRequest> get serializer => _$DeclareAllergyRequestSerializer();
}

class _$DeclareAllergyRequestSerializer implements PrimitiveSerializer<DeclareAllergyRequest> {
  @override
  final Iterable<Type> types = const [DeclareAllergyRequest, _$DeclareAllergyRequest];

  @override
  final String wireName = r'DeclareAllergyRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DeclareAllergyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.allergyId != null) {
      yield r'allergyId';
      yield serializers.serialize(
        object.allergyId,
        specifiedType: const FullType(String),
      );
    }
    if (object.severity != null) {
      yield r'severity';
      yield serializers.serialize(
        object.severity,
        specifiedType: const FullType(AllergySeverity),
      );
    }
    if (object.notes != null) {
      yield r'notes';
      yield serializers.serialize(
        object.notes,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    DeclareAllergyRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DeclareAllergyRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'allergyId':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.allergyId = valueDes;
          break;
        case r'severity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(AllergySeverity),
          ) as AllergySeverity;
          result.severity = valueDes;
          break;
        case r'notes':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.notes = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DeclareAllergyRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DeclareAllergyRequestBuilder();
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

