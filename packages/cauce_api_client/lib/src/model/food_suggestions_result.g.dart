// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_suggestions_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$FoodSuggestionsResult extends FoodSuggestionsResult {
  @override
  final BuiltList<FoodItemSummary>? frequentLast30Days;
  @override
  final BuiltList<FoodItemSummary>? recentLast24Hours;
  @override
  final BuiltList<FoodItemSummary>? catalogSuggestions;

  factory _$FoodSuggestionsResult(
          [void Function(FoodSuggestionsResultBuilder)? updates]) =>
      (FoodSuggestionsResultBuilder()..update(updates))._build();

  _$FoodSuggestionsResult._(
      {this.frequentLast30Days,
      this.recentLast24Hours,
      this.catalogSuggestions})
      : super._();
  @override
  FoodSuggestionsResult rebuild(
          void Function(FoodSuggestionsResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  FoodSuggestionsResultBuilder toBuilder() =>
      FoodSuggestionsResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is FoodSuggestionsResult &&
        frequentLast30Days == other.frequentLast30Days &&
        recentLast24Hours == other.recentLast24Hours &&
        catalogSuggestions == other.catalogSuggestions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, frequentLast30Days.hashCode);
    _$hash = $jc(_$hash, recentLast24Hours.hashCode);
    _$hash = $jc(_$hash, catalogSuggestions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'FoodSuggestionsResult')
          ..add('frequentLast30Days', frequentLast30Days)
          ..add('recentLast24Hours', recentLast24Hours)
          ..add('catalogSuggestions', catalogSuggestions))
        .toString();
  }
}

class FoodSuggestionsResultBuilder
    implements Builder<FoodSuggestionsResult, FoodSuggestionsResultBuilder> {
  _$FoodSuggestionsResult? _$v;

  ListBuilder<FoodItemSummary>? _frequentLast30Days;
  ListBuilder<FoodItemSummary> get frequentLast30Days =>
      _$this._frequentLast30Days ??= ListBuilder<FoodItemSummary>();
  set frequentLast30Days(ListBuilder<FoodItemSummary>? frequentLast30Days) =>
      _$this._frequentLast30Days = frequentLast30Days;

  ListBuilder<FoodItemSummary>? _recentLast24Hours;
  ListBuilder<FoodItemSummary> get recentLast24Hours =>
      _$this._recentLast24Hours ??= ListBuilder<FoodItemSummary>();
  set recentLast24Hours(ListBuilder<FoodItemSummary>? recentLast24Hours) =>
      _$this._recentLast24Hours = recentLast24Hours;

  ListBuilder<FoodItemSummary>? _catalogSuggestions;
  ListBuilder<FoodItemSummary> get catalogSuggestions =>
      _$this._catalogSuggestions ??= ListBuilder<FoodItemSummary>();
  set catalogSuggestions(ListBuilder<FoodItemSummary>? catalogSuggestions) =>
      _$this._catalogSuggestions = catalogSuggestions;

  FoodSuggestionsResultBuilder() {
    FoodSuggestionsResult._defaults(this);
  }

  FoodSuggestionsResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _frequentLast30Days = $v.frequentLast30Days?.toBuilder();
      _recentLast24Hours = $v.recentLast24Hours?.toBuilder();
      _catalogSuggestions = $v.catalogSuggestions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(FoodSuggestionsResult other) {
    _$v = other as _$FoodSuggestionsResult;
  }

  @override
  void update(void Function(FoodSuggestionsResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  FoodSuggestionsResult build() => _build();

  _$FoodSuggestionsResult _build() {
    _$FoodSuggestionsResult _$result;
    try {
      _$result = _$v ??
          _$FoodSuggestionsResult._(
            frequentLast30Days: _frequentLast30Days?.build(),
            recentLast24Hours: _recentLast24Hours?.build(),
            catalogSuggestions: _catalogSuggestions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'frequentLast30Days';
        _frequentLast30Days?.build();
        _$failedField = 'recentLast24Hours';
        _recentLast24Hours?.build();
        _$failedField = 'catalogSuggestions';
        _catalogSuggestions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'FoodSuggestionsResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
