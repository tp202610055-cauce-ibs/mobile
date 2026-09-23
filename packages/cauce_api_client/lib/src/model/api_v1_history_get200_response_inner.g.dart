// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_v1_history_get200_response_inner.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ApiV1HistoryGet200ResponseInner
    extends ApiV1HistoryGet200ResponseInner {
  @override
  final OneOf oneOf;

  factory _$ApiV1HistoryGet200ResponseInner(
          [void Function(ApiV1HistoryGet200ResponseInnerBuilder)? updates]) =>
      (ApiV1HistoryGet200ResponseInnerBuilder()..update(updates))._build();

  _$ApiV1HistoryGet200ResponseInner._({required this.oneOf}) : super._();
  @override
  ApiV1HistoryGet200ResponseInner rebuild(
          void Function(ApiV1HistoryGet200ResponseInnerBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ApiV1HistoryGet200ResponseInnerBuilder toBuilder() =>
      ApiV1HistoryGet200ResponseInnerBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ApiV1HistoryGet200ResponseInner && oneOf == other.oneOf;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, oneOf.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ApiV1HistoryGet200ResponseInner')
          ..add('oneOf', oneOf))
        .toString();
  }
}

class ApiV1HistoryGet200ResponseInnerBuilder
    implements
        Builder<ApiV1HistoryGet200ResponseInner,
            ApiV1HistoryGet200ResponseInnerBuilder> {
  _$ApiV1HistoryGet200ResponseInner? _$v;

  OneOf? _oneOf;
  OneOf? get oneOf => _$this._oneOf;
  set oneOf(OneOf? oneOf) => _$this._oneOf = oneOf;

  ApiV1HistoryGet200ResponseInnerBuilder() {
    ApiV1HistoryGet200ResponseInner._defaults(this);
  }

  ApiV1HistoryGet200ResponseInnerBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _oneOf = $v.oneOf;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ApiV1HistoryGet200ResponseInner other) {
    _$v = other as _$ApiV1HistoryGet200ResponseInner;
  }

  @override
  void update(void Function(ApiV1HistoryGet200ResponseInnerBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ApiV1HistoryGet200ResponseInner build() => _build();

  _$ApiV1HistoryGet200ResponseInner _build() {
    final _$result = _$v ??
        _$ApiV1HistoryGet200ResponseInner._(
          oneOf: BuiltValueNullFieldError.checkNotNull(
              oneOf, r'ApiV1HistoryGet200ResponseInner', 'oneOf'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
