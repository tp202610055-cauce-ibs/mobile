// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'food_search_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$FoodSearchState {
  String get query => throw _privateConstructorUsedError;
  List<FoodItem> get results => throw _privateConstructorUsedError;

  /// Platos propios del paciente que coinciden con la busqueda (CP025
  /// paso 10). Con la caja vacia son todos los que tenga.
  List<CustomFoodRecord> get customResults =>
      throw _privateConstructorUsedError;

  /// Sugerencias del servidor, o `null` si no se pudieron traer.
  FoodSuggestions? get suggestions => throw _privateConstructorUsedError;
  bool get loadingSuggestions => throw _privateConstructorUsedError;

  /// Create a copy of FoodSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FoodSearchStateCopyWith<FoodSearchState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FoodSearchStateCopyWith<$Res> {
  factory $FoodSearchStateCopyWith(
          FoodSearchState value, $Res Function(FoodSearchState) then) =
      _$FoodSearchStateCopyWithImpl<$Res, FoodSearchState>;
  @useResult
  $Res call(
      {String query,
      List<FoodItem> results,
      List<CustomFoodRecord> customResults,
      FoodSuggestions? suggestions,
      bool loadingSuggestions});

  $FoodSuggestionsCopyWith<$Res>? get suggestions;
}

/// @nodoc
class _$FoodSearchStateCopyWithImpl<$Res, $Val extends FoodSearchState>
    implements $FoodSearchStateCopyWith<$Res> {
  _$FoodSearchStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FoodSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? results = null,
    Object? customResults = null,
    Object? suggestions = freezed,
    Object? loadingSuggestions = null,
  }) {
    return _then(_value.copyWith(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
      customResults: null == customResults
          ? _value.customResults
          : customResults // ignore: cast_nullable_to_non_nullable
              as List<CustomFoodRecord>,
      suggestions: freezed == suggestions
          ? _value.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as FoodSuggestions?,
      loadingSuggestions: null == loadingSuggestions
          ? _value.loadingSuggestions
          : loadingSuggestions // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }

  /// Create a copy of FoodSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FoodSuggestionsCopyWith<$Res>? get suggestions {
    if (_value.suggestions == null) {
      return null;
    }

    return $FoodSuggestionsCopyWith<$Res>(_value.suggestions!, (value) {
      return _then(_value.copyWith(suggestions: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FoodSearchStateImplCopyWith<$Res>
    implements $FoodSearchStateCopyWith<$Res> {
  factory _$$FoodSearchStateImplCopyWith(_$FoodSearchStateImpl value,
          $Res Function(_$FoodSearchStateImpl) then) =
      __$$FoodSearchStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String query,
      List<FoodItem> results,
      List<CustomFoodRecord> customResults,
      FoodSuggestions? suggestions,
      bool loadingSuggestions});

  @override
  $FoodSuggestionsCopyWith<$Res>? get suggestions;
}

/// @nodoc
class __$$FoodSearchStateImplCopyWithImpl<$Res>
    extends _$FoodSearchStateCopyWithImpl<$Res, _$FoodSearchStateImpl>
    implements _$$FoodSearchStateImplCopyWith<$Res> {
  __$$FoodSearchStateImplCopyWithImpl(
      _$FoodSearchStateImpl _value, $Res Function(_$FoodSearchStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of FoodSearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? query = null,
    Object? results = null,
    Object? customResults = null,
    Object? suggestions = freezed,
    Object? loadingSuggestions = null,
  }) {
    return _then(_$FoodSearchStateImpl(
      query: null == query
          ? _value.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<FoodItem>,
      customResults: null == customResults
          ? _value._customResults
          : customResults // ignore: cast_nullable_to_non_nullable
              as List<CustomFoodRecord>,
      suggestions: freezed == suggestions
          ? _value.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as FoodSuggestions?,
      loadingSuggestions: null == loadingSuggestions
          ? _value.loadingSuggestions
          : loadingSuggestions // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$FoodSearchStateImpl extends _FoodSearchState {
  const _$FoodSearchStateImpl(
      {this.query = '',
      final List<FoodItem> results = const <FoodItem>[],
      final List<CustomFoodRecord> customResults = const <CustomFoodRecord>[],
      this.suggestions,
      this.loadingSuggestions = false})
      : _results = results,
        _customResults = customResults,
        super._();

  @override
  @JsonKey()
  final String query;
  final List<FoodItem> _results;
  @override
  @JsonKey()
  List<FoodItem> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  /// Platos propios del paciente que coinciden con la busqueda (CP025
  /// paso 10). Con la caja vacia son todos los que tenga.
  final List<CustomFoodRecord> _customResults;

  /// Platos propios del paciente que coinciden con la busqueda (CP025
  /// paso 10). Con la caja vacia son todos los que tenga.
  @override
  @JsonKey()
  List<CustomFoodRecord> get customResults {
    if (_customResults is EqualUnmodifiableListView) return _customResults;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_customResults);
  }

  /// Sugerencias del servidor, o `null` si no se pudieron traer.
  @override
  final FoodSuggestions? suggestions;
  @override
  @JsonKey()
  final bool loadingSuggestions;

  @override
  String toString() {
    return 'FoodSearchState(query: $query, results: $results, customResults: $customResults, suggestions: $suggestions, loadingSuggestions: $loadingSuggestions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FoodSearchStateImpl &&
            (identical(other.query, query) || other.query == query) &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            const DeepCollectionEquality()
                .equals(other._customResults, _customResults) &&
            (identical(other.suggestions, suggestions) ||
                other.suggestions == suggestions) &&
            (identical(other.loadingSuggestions, loadingSuggestions) ||
                other.loadingSuggestions == loadingSuggestions));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      query,
      const DeepCollectionEquality().hash(_results),
      const DeepCollectionEquality().hash(_customResults),
      suggestions,
      loadingSuggestions);

  /// Create a copy of FoodSearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FoodSearchStateImplCopyWith<_$FoodSearchStateImpl> get copyWith =>
      __$$FoodSearchStateImplCopyWithImpl<_$FoodSearchStateImpl>(
          this, _$identity);
}

abstract class _FoodSearchState extends FoodSearchState {
  const factory _FoodSearchState(
      {final String query,
      final List<FoodItem> results,
      final List<CustomFoodRecord> customResults,
      final FoodSuggestions? suggestions,
      final bool loadingSuggestions}) = _$FoodSearchStateImpl;
  const _FoodSearchState._() : super._();

  @override
  String get query;
  @override
  List<FoodItem> get results;

  /// Platos propios del paciente que coinciden con la busqueda (CP025
  /// paso 10). Con la caja vacia son todos los que tenga.
  @override
  List<CustomFoodRecord> get customResults;

  /// Sugerencias del servidor, o `null` si no se pudieron traer.
  @override
  FoodSuggestions? get suggestions;
  @override
  bool get loadingSuggestions;

  /// Create a copy of FoodSearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FoodSearchStateImplCopyWith<_$FoodSearchStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
