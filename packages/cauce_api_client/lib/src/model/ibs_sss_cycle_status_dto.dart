//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:cauce_api_client/src/model/ibs_sss_cycle_status.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'ibs_sss_cycle_status_dto.g.dart';

/// IbsSssCycleStatusDto
///
/// Properties:
/// * [status] 
/// * [dueDate] 
/// * [reminderSentAt] 
/// * [completedAt] 
@BuiltValue()
abstract class IbsSssCycleStatusDto implements Built<IbsSssCycleStatusDto, IbsSssCycleStatusDtoBuilder> {
  @BuiltValueField(wireName: r'status')
  IbsSssCycleStatus? get status;
  // enum statusEnum {  None,  Pending,  Missed,  Completed,  };

  @BuiltValueField(wireName: r'dueDate')
  DateTime? get dueDate;

  @BuiltValueField(wireName: r'reminderSentAt')
  DateTime? get reminderSentAt;

  @BuiltValueField(wireName: r'completedAt')
  DateTime? get completedAt;

  IbsSssCycleStatusDto._();

  factory IbsSssCycleStatusDto([void updates(IbsSssCycleStatusDtoBuilder b)]) = _$IbsSssCycleStatusDto;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(IbsSssCycleStatusDtoBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<IbsSssCycleStatusDto> get serializer => _$IbsSssCycleStatusDtoSerializer();
}

class _$IbsSssCycleStatusDtoSerializer implements PrimitiveSerializer<IbsSssCycleStatusDto> {
  @override
  final Iterable<Type> types = const [IbsSssCycleStatusDto, _$IbsSssCycleStatusDto];

  @override
  final String wireName = r'IbsSssCycleStatusDto';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    IbsSssCycleStatusDto object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(IbsSssCycleStatus),
      );
    }
    if (object.dueDate != null) {
      yield r'dueDate';
      yield serializers.serialize(
        object.dueDate,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.reminderSentAt != null) {
      yield r'reminderSentAt';
      yield serializers.serialize(
        object.reminderSentAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
    if (object.completedAt != null) {
      yield r'completedAt';
      yield serializers.serialize(
        object.completedAt,
        specifiedType: const FullType.nullable(DateTime),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    IbsSssCycleStatusDto object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required IbsSssCycleStatusDtoBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(IbsSssCycleStatus),
          ) as IbsSssCycleStatus;
          result.status = valueDes;
          break;
        case r'dueDate':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.dueDate = valueDes;
          break;
        case r'reminderSentAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.reminderSentAt = valueDes;
          break;
        case r'completedAt':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(DateTime),
          ) as DateTime?;
          if (valueDes == null) continue;
          result.completedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  IbsSssCycleStatusDto deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = IbsSssCycleStatusDtoBuilder();
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

