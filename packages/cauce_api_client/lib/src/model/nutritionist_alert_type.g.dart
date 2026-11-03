// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritionist_alert_type.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const NutritionistAlertType _$patientLinked =
    const NutritionistAlertType._('patientLinked');
const NutritionistAlertType _$patientSubtypeChanged =
    const NutritionistAlertType._('patientSubtypeChanged');

NutritionistAlertType _$valueOf(String name) {
  switch (name) {
    case 'patientLinked':
      return _$patientLinked;
    case 'patientSubtypeChanged':
      return _$patientSubtypeChanged;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<NutritionistAlertType> _$values =
    BuiltSet<NutritionistAlertType>(const <NutritionistAlertType>[
  _$patientLinked,
  _$patientSubtypeChanged,
]);

class _$NutritionistAlertTypeMeta {
  const _$NutritionistAlertTypeMeta();
  NutritionistAlertType get patientLinked => _$patientLinked;
  NutritionistAlertType get patientSubtypeChanged => _$patientSubtypeChanged;
  NutritionistAlertType valueOf(String name) => _$valueOf(name);
  BuiltSet<NutritionistAlertType> get values => _$values;
}

abstract class _$NutritionistAlertTypeMixin {
  // ignore: non_constant_identifier_names
  _$NutritionistAlertTypeMeta get NutritionistAlertType =>
      const _$NutritionistAlertTypeMeta();
}

Serializer<NutritionistAlertType> _$nutritionistAlertTypeSerializer =
    _$NutritionistAlertTypeSerializer();

class _$NutritionistAlertTypeSerializer
    implements PrimitiveSerializer<NutritionistAlertType> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'patientLinked': 'PatientLinked',
    'patientSubtypeChanged': 'PatientSubtypeChanged',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'PatientLinked': 'patientLinked',
    'PatientSubtypeChanged': 'patientSubtypeChanged',
  };

  @override
  final Iterable<Type> types = const <Type>[NutritionistAlertType];
  @override
  final String wireName = 'NutritionistAlertType';

  @override
  Object serialize(Serializers serializers, NutritionistAlertType object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  NutritionistAlertType deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      NutritionistAlertType.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
