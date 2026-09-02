// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sync_batch_result.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SyncBatchResult extends SyncBatchResult {
  @override
  final BuiltList<SyncAcceptedEntry>? accepted;
  @override
  final BuiltList<SyncDuplicateEntry>? duplicates;
  @override
  final BuiltList<SyncErrorEntry>? errors;

  factory _$SyncBatchResult([void Function(SyncBatchResultBuilder)? updates]) =>
      (SyncBatchResultBuilder()..update(updates))._build();

  _$SyncBatchResult._({this.accepted, this.duplicates, this.errors})
      : super._();
  @override
  SyncBatchResult rebuild(void Function(SyncBatchResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SyncBatchResultBuilder toBuilder() => SyncBatchResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SyncBatchResult &&
        accepted == other.accepted &&
        duplicates == other.duplicates &&
        errors == other.errors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, accepted.hashCode);
    _$hash = $jc(_$hash, duplicates.hashCode);
    _$hash = $jc(_$hash, errors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SyncBatchResult')
          ..add('accepted', accepted)
          ..add('duplicates', duplicates)
          ..add('errors', errors))
        .toString();
  }
}

class SyncBatchResultBuilder
    implements Builder<SyncBatchResult, SyncBatchResultBuilder> {
  _$SyncBatchResult? _$v;

  ListBuilder<SyncAcceptedEntry>? _accepted;
  ListBuilder<SyncAcceptedEntry> get accepted =>
      _$this._accepted ??= ListBuilder<SyncAcceptedEntry>();
  set accepted(ListBuilder<SyncAcceptedEntry>? accepted) =>
      _$this._accepted = accepted;

  ListBuilder<SyncDuplicateEntry>? _duplicates;
  ListBuilder<SyncDuplicateEntry> get duplicates =>
      _$this._duplicates ??= ListBuilder<SyncDuplicateEntry>();
  set duplicates(ListBuilder<SyncDuplicateEntry>? duplicates) =>
      _$this._duplicates = duplicates;

  ListBuilder<SyncErrorEntry>? _errors;
  ListBuilder<SyncErrorEntry> get errors =>
      _$this._errors ??= ListBuilder<SyncErrorEntry>();
  set errors(ListBuilder<SyncErrorEntry>? errors) => _$this._errors = errors;

  SyncBatchResultBuilder() {
    SyncBatchResult._defaults(this);
  }

  SyncBatchResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _accepted = $v.accepted?.toBuilder();
      _duplicates = $v.duplicates?.toBuilder();
      _errors = $v.errors?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SyncBatchResult other) {
    _$v = other as _$SyncBatchResult;
  }

  @override
  void update(void Function(SyncBatchResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SyncBatchResult build() => _build();

  _$SyncBatchResult _build() {
    _$SyncBatchResult _$result;
    try {
      _$result = _$v ??
          _$SyncBatchResult._(
            accepted: _accepted?.build(),
            duplicates: _duplicates?.build(),
            errors: _errors?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'accepted';
        _accepted?.build();
        _$failedField = 'duplicates';
        _duplicates?.build();
        _$failedField = 'errors';
        _errors?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SyncBatchResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
