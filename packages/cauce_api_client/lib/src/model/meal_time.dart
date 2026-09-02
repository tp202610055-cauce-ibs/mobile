//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'meal_time.g.dart';

class MealTime extends EnumClass {

  @BuiltValueEnumConst(wireName: r'Breakfast')
  static const MealTime breakfast = _$breakfast;
  @BuiltValueEnumConst(wireName: r'Lunch')
  static const MealTime lunch = _$lunch;
  @BuiltValueEnumConst(wireName: r'Dinner')
  static const MealTime dinner = _$dinner;
  @BuiltValueEnumConst(wireName: r'Snack')
  static const MealTime snack = _$snack;

  static Serializer<MealTime> get serializer => _$mealTimeSerializer;

  const MealTime._(String name): super(name);

  static BuiltSet<MealTime> get values => _$values;
  static MealTime valueOf(String name) => _$valueOf(name);
}

/// Optionally, enum_class can generate a mixin to go with your enum for use
/// with Angular. It exposes your enum constants as getters. So, if you mix it
/// in to your Dart component class, the values become available to the
/// corresponding Angular template.
///
/// Trigger mixin generation by writing a line like this one next to your enum.
abstract class MealTimeMixin = Object with _$MealTimeMixin;

