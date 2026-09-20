// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'custom_foods_cache.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$CustomFoodsCacheState {
  List<CustomFoodRecord> get items => throw _privateConstructorUsedError;

  /// `true` cuando el ultimo intento de traerlos no prospero.
  bool get stale => throw _privateConstructorUsedError;

  /// Create a copy of CustomFoodsCacheState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CustomFoodsCacheStateCopyWith<CustomFoodsCacheState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomFoodsCacheStateCopyWith<$Res> {
  factory $CustomFoodsCacheStateCopyWith(CustomFoodsCacheState value,
          $Res Function(CustomFoodsCacheState) then) =
      _$CustomFoodsCacheStateCopyWithImpl<$Res, CustomFoodsCacheState>;
  @useResult
  $Res call({List<CustomFoodRecord> items, bool stale});
}

/// @nodoc
class _$CustomFoodsCacheStateCopyWithImpl<$Res,
        $Val extends CustomFoodsCacheState>
    implements $CustomFoodsCacheStateCopyWith<$Res> {
  _$CustomFoodsCacheStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CustomFoodsCacheState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? stale = null,
  }) {
    return _then(_value.copyWith(
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CustomFoodRecord>,
      stale: null == stale
          ? _value.stale
          : stale // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomFoodsCacheStateImplCopyWith<$Res>
    implements $CustomFoodsCacheStateCopyWith<$Res> {
  factory _$$CustomFoodsCacheStateImplCopyWith(
          _$CustomFoodsCacheStateImpl value,
          $Res Function(_$CustomFoodsCacheStateImpl) then) =
      __$$CustomFoodsCacheStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CustomFoodRecord> items, bool stale});
}

/// @nodoc
class __$$CustomFoodsCacheStateImplCopyWithImpl<$Res>
    extends _$CustomFoodsCacheStateCopyWithImpl<$Res,
        _$CustomFoodsCacheStateImpl>
    implements _$$CustomFoodsCacheStateImplCopyWith<$Res> {
  __$$CustomFoodsCacheStateImplCopyWithImpl(_$CustomFoodsCacheStateImpl _value,
      $Res Function(_$CustomFoodsCacheStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of CustomFoodsCacheState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = null,
    Object? stale = null,
  }) {
    return _then(_$CustomFoodsCacheStateImpl(
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<CustomFoodRecord>,
      stale: null == stale
          ? _value.stale
          : stale // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$CustomFoodsCacheStateImpl extends _CustomFoodsCacheState {
  const _$CustomFoodsCacheStateImpl(
      {final List<CustomFoodRecord> items = const <CustomFoodRecord>[],
      this.stale = false})
      : _items = items,
        super._();

  final List<CustomFoodRecord> _items;
  @override
  @JsonKey()
  List<CustomFoodRecord> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// `true` cuando el ultimo intento de traerlos no prospero.
  @override
  @JsonKey()
  final bool stale;

  @override
  String toString() {
    return 'CustomFoodsCacheState(items: $items, stale: $stale)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomFoodsCacheStateImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.stale, stale) || other.stale == stale));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), stale);

  /// Create a copy of CustomFoodsCacheState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomFoodsCacheStateImplCopyWith<_$CustomFoodsCacheStateImpl>
      get copyWith => __$$CustomFoodsCacheStateImplCopyWithImpl<
          _$CustomFoodsCacheStateImpl>(this, _$identity);
}

abstract class _CustomFoodsCacheState extends CustomFoodsCacheState {
  const factory _CustomFoodsCacheState(
      {final List<CustomFoodRecord> items,
      final bool stale}) = _$CustomFoodsCacheStateImpl;
  const _CustomFoodsCacheState._() : super._();

  @override
  List<CustomFoodRecord> get items;

  /// `true` cuando el ultimo intento de traerlos no prospero.
  @override
  bool get stale;

  /// Create a copy of CustomFoodsCacheState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CustomFoodsCacheStateImplCopyWith<_$CustomFoodsCacheStateImpl>
      get copyWith => throw _privateConstructorUsedError;
}
