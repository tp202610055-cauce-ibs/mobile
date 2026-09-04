// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_batch_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SyncBatchRequest extends SyncBatchRequest {
  @override
  final BuiltList<MealBatchItem>? meals;
  @override
  final BuiltList<SymptomBatchItem>? symptoms;

  factory _$SyncBatchRequest(
          [void Function(SyncBatchRequestBuilder)? updates]) =>
      (SyncBatchRequestBuilder()..update(updates))._build();

  _$SyncBatchRequest._({this.meals, this.symptoms}) : super._();
  @override
  SyncBatchRequest rebuild(void Function(SyncBatchRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SyncBatchRequestBuilder toBuilder() =>
      SyncBatchRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncBatchRequest &&
        meals == other.meals &&
        symptoms == other.symptoms;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, meals.hashCode);
    _$hash = $jc(_$hash, symptoms.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SyncBatchRequest')
          ..add('meals', meals)
          ..add('symptoms', symptoms))
        .toString();
  }
}

class SyncBatchRequestBuilder
    implements Builder<SyncBatchRequest, SyncBatchRequestBuilder> {
  _$SyncBatchRequest? _$v;

  ListBuilder<MealBatchItem>? _meals;
  ListBuilder<MealBatchItem> get meals =>
      _$this._meals ??= ListBuilder<MealBatchItem>();
  set meals(ListBuilder<MealBatchItem>? meals) => _$this._meals = meals;

  ListBuilder<SymptomBatchItem>? _symptoms;
  ListBuilder<SymptomBatchItem> get symptoms =>
      _$this._symptoms ??= ListBuilder<SymptomBatchItem>();
  set symptoms(ListBuilder<SymptomBatchItem>? symptoms) =>
      _$this._symptoms = symptoms;

  SyncBatchRequestBuilder() {
    SyncBatchRequest._defaults(this);
  }

  SyncBatchRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _meals = $v.meals?.toBuilder();
      _symptoms = $v.symptoms?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SyncBatchRequest other) {
    _$v = other as _$SyncBatchRequest;
  }

  @override
  void update(void Function(SyncBatchRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncBatchRequest build() => _build();

  _$SyncBatchRequest _build() {
    _$SyncBatchRequest _$result;
    try {
      _$result = _$v ??
          _$SyncBatchRequest._(
            meals: _meals?.build(),
            symptoms: _symptoms?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'meals';
        _meals?.build();
        _$failedField = 'symptoms';
        _symptoms?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SyncBatchRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
