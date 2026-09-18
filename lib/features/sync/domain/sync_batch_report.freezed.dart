// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'sync_batch_report.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SyncAccepted {
  String get clientGuid => throw _privateConstructorUsedError;
  String? get serverId => throw _privateConstructorUsedError;

  /// `meal` o `symptom`, segun lo que el servidor haya creado.
  String? get entityType => throw _privateConstructorUsedError;

  /// Create a copy of SyncAccepted
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncAcceptedCopyWith<SyncAccepted> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncAcceptedCopyWith<$Res> {
  factory $SyncAcceptedCopyWith(
          SyncAccepted value, $Res Function(SyncAccepted) then) =
      _$SyncAcceptedCopyWithImpl<$Res, SyncAccepted>;
  @useResult
  $Res call({String clientGuid, String? serverId, String? entityType});
}

/// @nodoc
class _$SyncAcceptedCopyWithImpl<$Res, $Val extends SyncAccepted>
    implements $SyncAcceptedCopyWith<$Res> {
  _$SyncAcceptedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncAccepted
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientGuid = null,
    Object? serverId = freezed,
    Object? entityType = freezed,
  }) {
    return _then(_value.copyWith(
      clientGuid: null == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String?,
      entityType: freezed == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncAcceptedImplCopyWith<$Res>
    implements $SyncAcceptedCopyWith<$Res> {
  factory _$$SyncAcceptedImplCopyWith(
          _$SyncAcceptedImpl value, $Res Function(_$SyncAcceptedImpl) then) =
      __$$SyncAcceptedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String clientGuid, String? serverId, String? entityType});
}

/// @nodoc
class __$$SyncAcceptedImplCopyWithImpl<$Res>
    extends _$SyncAcceptedCopyWithImpl<$Res, _$SyncAcceptedImpl>
    implements _$$SyncAcceptedImplCopyWith<$Res> {
  __$$SyncAcceptedImplCopyWithImpl(
      _$SyncAcceptedImpl _value, $Res Function(_$SyncAcceptedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncAccepted
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientGuid = null,
    Object? serverId = freezed,
    Object? entityType = freezed,
  }) {
    return _then(_$SyncAcceptedImpl(
      clientGuid: null == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String?,
      entityType: freezed == entityType
          ? _value.entityType
          : entityType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SyncAcceptedImpl extends _SyncAccepted {
  const _$SyncAcceptedImpl(
      {required this.clientGuid, this.serverId, this.entityType})
      : super._();

  @override
  final String clientGuid;
  @override
  final String? serverId;

  /// `meal` o `symptom`, segun lo que el servidor haya creado.
  @override
  final String? entityType;

  @override
  String toString() {
    return 'SyncAccepted(clientGuid: $clientGuid, serverId: $serverId, entityType: $entityType)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncAcceptedImpl &&
            (identical(other.clientGuid, clientGuid) ||
                other.clientGuid == clientGuid) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.entityType, entityType) ||
                other.entityType == entityType));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, clientGuid, serverId, entityType);

  /// Create a copy of SyncAccepted
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncAcceptedImplCopyWith<_$SyncAcceptedImpl> get copyWith =>
      __$$SyncAcceptedImplCopyWithImpl<_$SyncAcceptedImpl>(this, _$identity);
}

abstract class _SyncAccepted extends SyncAccepted {
  const factory _SyncAccepted(
      {required final String clientGuid,
      final String? serverId,
      final String? entityType}) = _$SyncAcceptedImpl;
  const _SyncAccepted._() : super._();

  @override
  String get clientGuid;
  @override
  String? get serverId;

  /// `meal` o `symptom`, segun lo que el servidor haya creado.
  @override
  String? get entityType;

  /// Create a copy of SyncAccepted
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncAcceptedImplCopyWith<_$SyncAcceptedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SyncDuplicate {
  String get clientGuid => throw _privateConstructorUsedError;
  String? get existingServerId => throw _privateConstructorUsedError;

  /// Create a copy of SyncDuplicate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncDuplicateCopyWith<SyncDuplicate> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncDuplicateCopyWith<$Res> {
  factory $SyncDuplicateCopyWith(
          SyncDuplicate value, $Res Function(SyncDuplicate) then) =
      _$SyncDuplicateCopyWithImpl<$Res, SyncDuplicate>;
  @useResult
  $Res call({String clientGuid, String? existingServerId});
}

/// @nodoc
class _$SyncDuplicateCopyWithImpl<$Res, $Val extends SyncDuplicate>
    implements $SyncDuplicateCopyWith<$Res> {
  _$SyncDuplicateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncDuplicate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientGuid = null,
    Object? existingServerId = freezed,
  }) {
    return _then(_value.copyWith(
      clientGuid: null == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String,
      existingServerId: freezed == existingServerId
          ? _value.existingServerId
          : existingServerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncDuplicateImplCopyWith<$Res>
    implements $SyncDuplicateCopyWith<$Res> {
  factory _$$SyncDuplicateImplCopyWith(
          _$SyncDuplicateImpl value, $Res Function(_$SyncDuplicateImpl) then) =
      __$$SyncDuplicateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String clientGuid, String? existingServerId});
}

/// @nodoc
class __$$SyncDuplicateImplCopyWithImpl<$Res>
    extends _$SyncDuplicateCopyWithImpl<$Res, _$SyncDuplicateImpl>
    implements _$$SyncDuplicateImplCopyWith<$Res> {
  __$$SyncDuplicateImplCopyWithImpl(
      _$SyncDuplicateImpl _value, $Res Function(_$SyncDuplicateImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncDuplicate
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientGuid = null,
    Object? existingServerId = freezed,
  }) {
    return _then(_$SyncDuplicateImpl(
      clientGuid: null == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String,
      existingServerId: freezed == existingServerId
          ? _value.existingServerId
          : existingServerId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SyncDuplicateImpl extends _SyncDuplicate {
  const _$SyncDuplicateImpl({required this.clientGuid, this.existingServerId})
      : super._();

  @override
  final String clientGuid;
  @override
  final String? existingServerId;

  @override
  String toString() {
    return 'SyncDuplicate(clientGuid: $clientGuid, existingServerId: $existingServerId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncDuplicateImpl &&
            (identical(other.clientGuid, clientGuid) ||
                other.clientGuid == clientGuid) &&
            (identical(other.existingServerId, existingServerId) ||
                other.existingServerId == existingServerId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientGuid, existingServerId);

  /// Create a copy of SyncDuplicate
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncDuplicateImplCopyWith<_$SyncDuplicateImpl> get copyWith =>
      __$$SyncDuplicateImplCopyWithImpl<_$SyncDuplicateImpl>(this, _$identity);
}

abstract class _SyncDuplicate extends SyncDuplicate {
  const factory _SyncDuplicate(
      {required final String clientGuid,
      final String? existingServerId}) = _$SyncDuplicateImpl;
  const _SyncDuplicate._() : super._();

  @override
  String get clientGuid;
  @override
  String? get existingServerId;

  /// Create a copy of SyncDuplicate
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncDuplicateImplCopyWith<_$SyncDuplicateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SyncRejected {
  String get clientGuid => throw _privateConstructorUsedError;

  /// `errorCode` del contrato. Decide si la fila reintenta o queda terminal.
  String? get errorCode => throw _privateConstructorUsedError;

  /// Mensaje del servidor, en español y sin garantia de estabilidad. Sirve
  /// para diagnostico, no para mostrarselo al paciente tal cual.
  String? get message => throw _privateConstructorUsedError;

  /// Create a copy of SyncRejected
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncRejectedCopyWith<SyncRejected> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncRejectedCopyWith<$Res> {
  factory $SyncRejectedCopyWith(
          SyncRejected value, $Res Function(SyncRejected) then) =
      _$SyncRejectedCopyWithImpl<$Res, SyncRejected>;
  @useResult
  $Res call({String clientGuid, String? errorCode, String? message});
}

/// @nodoc
class _$SyncRejectedCopyWithImpl<$Res, $Val extends SyncRejected>
    implements $SyncRejectedCopyWith<$Res> {
  _$SyncRejectedCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncRejected
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientGuid = null,
    Object? errorCode = freezed,
    Object? message = freezed,
  }) {
    return _then(_value.copyWith(
      clientGuid: null == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncRejectedImplCopyWith<$Res>
    implements $SyncRejectedCopyWith<$Res> {
  factory _$$SyncRejectedImplCopyWith(
          _$SyncRejectedImpl value, $Res Function(_$SyncRejectedImpl) then) =
      __$$SyncRejectedImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String clientGuid, String? errorCode, String? message});
}

/// @nodoc
class __$$SyncRejectedImplCopyWithImpl<$Res>
    extends _$SyncRejectedCopyWithImpl<$Res, _$SyncRejectedImpl>
    implements _$$SyncRejectedImplCopyWith<$Res> {
  __$$SyncRejectedImplCopyWithImpl(
      _$SyncRejectedImpl _value, $Res Function(_$SyncRejectedImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncRejected
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? clientGuid = null,
    Object? errorCode = freezed,
    Object? message = freezed,
  }) {
    return _then(_$SyncRejectedImpl(
      clientGuid: null == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String,
      errorCode: freezed == errorCode
          ? _value.errorCode
          : errorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      message: freezed == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SyncRejectedImpl extends _SyncRejected {
  const _$SyncRejectedImpl(
      {required this.clientGuid, this.errorCode, this.message})
      : super._();

  @override
  final String clientGuid;

  /// `errorCode` del contrato. Decide si la fila reintenta o queda terminal.
  @override
  final String? errorCode;

  /// Mensaje del servidor, en español y sin garantia de estabilidad. Sirve
  /// para diagnostico, no para mostrarselo al paciente tal cual.
  @override
  final String? message;

  @override
  String toString() {
    return 'SyncRejected(clientGuid: $clientGuid, errorCode: $errorCode, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncRejectedImpl &&
            (identical(other.clientGuid, clientGuid) ||
                other.clientGuid == clientGuid) &&
            (identical(other.errorCode, errorCode) ||
                other.errorCode == errorCode) &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, clientGuid, errorCode, message);

  /// Create a copy of SyncRejected
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncRejectedImplCopyWith<_$SyncRejectedImpl> get copyWith =>
      __$$SyncRejectedImplCopyWithImpl<_$SyncRejectedImpl>(this, _$identity);
}

abstract class _SyncRejected extends SyncRejected {
  const factory _SyncRejected(
      {required final String clientGuid,
      final String? errorCode,
      final String? message}) = _$SyncRejectedImpl;
  const _SyncRejected._() : super._();

  @override
  String get clientGuid;

  /// `errorCode` del contrato. Decide si la fila reintenta o queda terminal.
  @override
  String? get errorCode;

  /// Mensaje del servidor, en español y sin garantia de estabilidad. Sirve
  /// para diagnostico, no para mostrarselo al paciente tal cual.
  @override
  String? get message;

  /// Create a copy of SyncRejected
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncRejectedImplCopyWith<_$SyncRejectedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SyncBatchReport {
  List<SyncAccepted> get accepted => throw _privateConstructorUsedError;
  List<SyncDuplicate> get duplicates => throw _privateConstructorUsedError;
  List<SyncRejected> get errors => throw _privateConstructorUsedError;

  /// Create a copy of SyncBatchReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SyncBatchReportCopyWith<SyncBatchReport> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SyncBatchReportCopyWith<$Res> {
  factory $SyncBatchReportCopyWith(
          SyncBatchReport value, $Res Function(SyncBatchReport) then) =
      _$SyncBatchReportCopyWithImpl<$Res, SyncBatchReport>;
  @useResult
  $Res call(
      {List<SyncAccepted> accepted,
      List<SyncDuplicate> duplicates,
      List<SyncRejected> errors});
}

/// @nodoc
class _$SyncBatchReportCopyWithImpl<$Res, $Val extends SyncBatchReport>
    implements $SyncBatchReportCopyWith<$Res> {
  _$SyncBatchReportCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SyncBatchReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accepted = null,
    Object? duplicates = null,
    Object? errors = null,
  }) {
    return _then(_value.copyWith(
      accepted: null == accepted
          ? _value.accepted
          : accepted // ignore: cast_nullable_to_non_nullable
              as List<SyncAccepted>,
      duplicates: null == duplicates
          ? _value.duplicates
          : duplicates // ignore: cast_nullable_to_non_nullable
              as List<SyncDuplicate>,
      errors: null == errors
          ? _value.errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<SyncRejected>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SyncBatchReportImplCopyWith<$Res>
    implements $SyncBatchReportCopyWith<$Res> {
  factory _$$SyncBatchReportImplCopyWith(_$SyncBatchReportImpl value,
          $Res Function(_$SyncBatchReportImpl) then) =
      __$$SyncBatchReportImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<SyncAccepted> accepted,
      List<SyncDuplicate> duplicates,
      List<SyncRejected> errors});
}

/// @nodoc
class __$$SyncBatchReportImplCopyWithImpl<$Res>
    extends _$SyncBatchReportCopyWithImpl<$Res, _$SyncBatchReportImpl>
    implements _$$SyncBatchReportImplCopyWith<$Res> {
  __$$SyncBatchReportImplCopyWithImpl(
      _$SyncBatchReportImpl _value, $Res Function(_$SyncBatchReportImpl) _then)
      : super(_value, _then);

  /// Create a copy of SyncBatchReport
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? accepted = null,
    Object? duplicates = null,
    Object? errors = null,
  }) {
    return _then(_$SyncBatchReportImpl(
      accepted: null == accepted
          ? _value._accepted
          : accepted // ignore: cast_nullable_to_non_nullable
              as List<SyncAccepted>,
      duplicates: null == duplicates
          ? _value._duplicates
          : duplicates // ignore: cast_nullable_to_non_nullable
              as List<SyncDuplicate>,
      errors: null == errors
          ? _value._errors
          : errors // ignore: cast_nullable_to_non_nullable
              as List<SyncRejected>,
    ));
  }
}

/// @nodoc

class _$SyncBatchReportImpl extends _SyncBatchReport {
  const _$SyncBatchReportImpl(
      {final List<SyncAccepted> accepted = const <SyncAccepted>[],
      final List<SyncDuplicate> duplicates = const <SyncDuplicate>[],
      final List<SyncRejected> errors = const <SyncRejected>[]})
      : _accepted = accepted,
        _duplicates = duplicates,
        _errors = errors,
        super._();

  final List<SyncAccepted> _accepted;
  @override
  @JsonKey()
  List<SyncAccepted> get accepted {
    if (_accepted is EqualUnmodifiableListView) return _accepted;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_accepted);
  }

  final List<SyncDuplicate> _duplicates;
  @override
  @JsonKey()
  List<SyncDuplicate> get duplicates {
    if (_duplicates is EqualUnmodifiableListView) return _duplicates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_duplicates);
  }

  final List<SyncRejected> _errors;
  @override
  @JsonKey()
  List<SyncRejected> get errors {
    if (_errors is EqualUnmodifiableListView) return _errors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_errors);
  }

  @override
  String toString() {
    return 'SyncBatchReport(accepted: $accepted, duplicates: $duplicates, errors: $errors)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SyncBatchReportImpl &&
            const DeepCollectionEquality().equals(other._accepted, _accepted) &&
            const DeepCollectionEquality()
                .equals(other._duplicates, _duplicates) &&
            const DeepCollectionEquality().equals(other._errors, _errors));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_accepted),
      const DeepCollectionEquality().hash(_duplicates),
      const DeepCollectionEquality().hash(_errors));

  /// Create a copy of SyncBatchReport
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SyncBatchReportImplCopyWith<_$SyncBatchReportImpl> get copyWith =>
      __$$SyncBatchReportImplCopyWithImpl<_$SyncBatchReportImpl>(
          this, _$identity);
}

abstract class _SyncBatchReport extends SyncBatchReport {
  const factory _SyncBatchReport(
      {final List<SyncAccepted> accepted,
      final List<SyncDuplicate> duplicates,
      final List<SyncRejected> errors}) = _$SyncBatchReportImpl;
  const _SyncBatchReport._() : super._();

  @override
  List<SyncAccepted> get accepted;
  @override
  List<SyncDuplicate> get duplicates;
  @override
  List<SyncRejected> get errors;

  /// Create a copy of SyncBatchReport
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SyncBatchReportImplCopyWith<_$SyncBatchReportImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
