// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_time.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const MealTime _$breakfast = const MealTime._('breakfast');
const MealTime _$lunch = const MealTime._('lunch');
const MealTime _$dinner = const MealTime._('dinner');
const MealTime _$snack = const MealTime._('snack');

MealTime _$valueOf(String name) {
  switch (name) {
    case 'breakfast':
      return _$breakfast;
    case 'lunch':
      return _$lunch;
    case 'dinner':
      return _$dinner;
    case 'snack':
      return _$snack;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<MealTime> _$values = BuiltSet<MealTime>(const <MealTime>[
  _$breakfast,
  _$lunch,
  _$dinner,
  _$snack,
]);

class _$MealTimeMeta {
  const _$MealTimeMeta();
  MealTime get breakfast => _$breakfast;
  MealTime get lunch => _$lunch;
  MealTime get dinner => _$dinner;
  MealTime get snack => _$snack;
  MealTime valueOf(String name) => _$valueOf(name);
  BuiltSet<MealTime> get values => _$values;
}

abstract class _$MealTimeMixin {
  // ignore: non_constant_identifier_names
  _$MealTimeMeta get MealTime => const _$MealTimeMeta();
}

Serializer<MealTime> _$mealTimeSerializer = _$MealTimeSerializer();

class _$MealTimeSerializer implements PrimitiveSerializer<MealTime> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'breakfast': 'Breakfast',
    'lunch': 'Lunch',
    'dinner': 'Dinner',
    'snack': 'Snack',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'Breakfast': 'breakfast',
    'Lunch': 'lunch',
    'Dinner': 'dinner',
    'Snack': 'snack',
  };

  @override
  final Iterable<Type> types = const <Type>[MealTime];
  @override
  final String wireName = 'MealTime';

  @override
  Object serialize(Serializers serializers, MealTime object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  MealTime deserialize(Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      MealTime.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
