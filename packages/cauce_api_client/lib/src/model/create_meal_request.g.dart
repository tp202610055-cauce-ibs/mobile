// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_meal_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateMealRequest extends CreateMealRequest {
  @override
  final String? clientGuid;
  @override
  final MealTime? mealTime;
  @override
  final DateTime? consumedAt;
  @override
  final DateTime? clientCreatedAt;
  @override
  final BuiltList<MealItemRequest>? items;

  factory _$CreateMealRequest(
          [void Function(CreateMealRequestBuilder)? updates]) =>
      (CreateMealRequestBuilder()..update(updates))._build();

  _$CreateMealRequest._(
      {this.clientGuid,
      this.mealTime,
      this.consumedAt,
      this.clientCreatedAt,
      this.items})
      : super._();
  @override
  CreateMealRequest rebuild(void Function(CreateMealRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateMealRequestBuilder toBuilder() =>
      CreateMealRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateMealRequest &&
        clientGuid == other.clientGuid &&
        mealTime == other.mealTime &&
        consumedAt == other.consumedAt &&
        clientCreatedAt == other.clientCreatedAt &&
        items == other.items;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, clientGuid.hashCode);
    _$hash = $jc(_$hash, mealTime.hashCode);
    _$hash = $jc(_$hash, consumedAt.hashCode);
    _$hash = $jc(_$hash, clientCreatedAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateMealRequest')
          ..add('clientGuid', clientGuid)
          ..add('mealTime', mealTime)
          ..add('consumedAt', consumedAt)
          ..add('clientCreatedAt', clientCreatedAt)
          ..add('items', items))
        .toString();
  }
}

class CreateMealRequestBuilder
    implements Builder<CreateMealRequest, CreateMealRequestBuilder> {
  _$CreateMealRequest? _$v;

  String? _clientGuid;
  String? get clientGuid => _$this._clientGuid;
  set clientGuid(String? clientGuid) => _$this._clientGuid = clientGuid;

  MealTime? _mealTime;
  MealTime? get mealTime => _$this._mealTime;
  set mealTime(MealTime? mealTime) => _$this._mealTime = mealTime;

  DateTime? _consumedAt;
  DateTime? get consumedAt => _$this._consumedAt;
  set consumedAt(DateTime? consumedAt) => _$this._consumedAt = consumedAt;

  DateTime? _clientCreatedAt;
  DateTime? get clientCreatedAt => _$this._clientCreatedAt;
  set clientCreatedAt(DateTime? clientCreatedAt) =>
      _$this._clientCreatedAt = clientCreatedAt;

  ListBuilder<MealItemRequest>? _items;
  ListBuilder<MealItemRequest> get items =>
      _$this._items ??= ListBuilder<MealItemRequest>();
  set items(ListBuilder<MealItemRequest>? items) => _$this._items = items;

  CreateMealRequestBuilder() {
    CreateMealRequest._defaults(this);
  }

  CreateMealRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _clientGuid = $v.clientGuid;
      _mealTime = $v.mealTime;
      _consumedAt = $v.consumedAt;
      _clientCreatedAt = $v.clientCreatedAt;
      _items = $v.items?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateMealRequest other) {
    _$v = other as _$CreateMealRequest;
  }

  @override
  void update(void Function(CreateMealRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateMealRequest build() => _build();

  _$CreateMealRequest _build() {
    _$CreateMealRequest _$result;
    try {
      _$result = _$v ??
          _$CreateMealRequest._(
            clientGuid: clientGuid,
            mealTime: mealTime,
            consumedAt: consumedAt,
            clientCreatedAt: clientCreatedAt,
            items: _items?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateMealRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
