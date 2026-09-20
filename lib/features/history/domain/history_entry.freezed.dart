// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$HistoryEntry {
  HistoryEntryKind get kind => throw _privateConstructorUsedError;
  DateTime get occurredAt => throw _privateConstructorUsedError;
  HistoryEntrySyncState get syncState => throw _privateConstructorUsedError;

  /// Identificador del servidor. `null` mientras no se haya sincronizado.
  String? get serverId => throw _privateConstructorUsedError;

  /// Identificador local, para poder descartar una fila rechazada.
  String? get clientGuid => throw _privateConstructorUsedError;

  /// `errorCode` del ultimo rechazo, si lo hubo.
  String? get lastErrorCode =>
      throw _privateConstructorUsedError; // Datos de una comida.
  MealTimeOption? get mealTime => throw _privateConstructorUsedError;
  FodmapLoad? get aggregatedFodmap => throw _privateConstructorUsedError;
  List<String> get itemNames =>
      throw _privateConstructorUsedError; // Datos de un sintoma.
  SymptomTypeOption? get symptomType => throw _privateConstructorUsedError;
  int? get intensity => throw _privateConstructorUsedError;
  bool? get hasMealAssociation => throw _privateConstructorUsedError;

  /// Momento de comida con la que el **servidor** asocio este sintoma.
  ///
  /// El cliente no calcula la ventana de cuatro horas: la resuelve el
  /// backend (DEC-B3-06) y aca solo se muestra lo confirmado. Se resuelve
  /// cruzando `associatedMealId` contra las comidas del mismo rango, que ya
  /// vienen en la misma composicion del historial.
  MealTimeOption? get associatedMealTime => throw _privateConstructorUsedError;

  /// Cuanto paso entre la comida asociada y el sintoma.
  Duration? get associatedMealDelay => throw _privateConstructorUsedError;

  /// Create a copy of HistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryEntryCopyWith<HistoryEntry> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryEntryCopyWith<$Res> {
  factory $HistoryEntryCopyWith(
          HistoryEntry value, $Res Function(HistoryEntry) then) =
      _$HistoryEntryCopyWithImpl<$Res, HistoryEntry>;
  @useResult
  $Res call(
      {HistoryEntryKind kind,
      DateTime occurredAt,
      HistoryEntrySyncState syncState,
      String? serverId,
      String? clientGuid,
      String? lastErrorCode,
      MealTimeOption? mealTime,
      FodmapLoad? aggregatedFodmap,
      List<String> itemNames,
      SymptomTypeOption? symptomType,
      int? intensity,
      bool? hasMealAssociation,
      MealTimeOption? associatedMealTime,
      Duration? associatedMealDelay});
}

/// @nodoc
class _$HistoryEntryCopyWithImpl<$Res, $Val extends HistoryEntry>
    implements $HistoryEntryCopyWith<$Res> {
  _$HistoryEntryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = null,
    Object? occurredAt = null,
    Object? syncState = null,
    Object? serverId = freezed,
    Object? clientGuid = freezed,
    Object? lastErrorCode = freezed,
    Object? mealTime = freezed,
    Object? aggregatedFodmap = freezed,
    Object? itemNames = null,
    Object? symptomType = freezed,
    Object? intensity = freezed,
    Object? hasMealAssociation = freezed,
    Object? associatedMealTime = freezed,
    Object? associatedMealDelay = freezed,
  }) {
    return _then(_value.copyWith(
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as HistoryEntryKind,
      occurredAt: null == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncState: null == syncState
          ? _value.syncState
          : syncState // ignore: cast_nullable_to_non_nullable
              as HistoryEntrySyncState,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String?,
      clientGuid: freezed == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String?,
      lastErrorCode: freezed == lastErrorCode
          ? _value.lastErrorCode
          : lastErrorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      mealTime: freezed == mealTime
          ? _value.mealTime
          : mealTime // ignore: cast_nullable_to_non_nullable
              as MealTimeOption?,
      aggregatedFodmap: freezed == aggregatedFodmap
          ? _value.aggregatedFodmap
          : aggregatedFodmap // ignore: cast_nullable_to_non_nullable
              as FodmapLoad?,
      itemNames: null == itemNames
          ? _value.itemNames
          : itemNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      symptomType: freezed == symptomType
          ? _value.symptomType
          : symptomType // ignore: cast_nullable_to_non_nullable
              as SymptomTypeOption?,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int?,
      hasMealAssociation: freezed == hasMealAssociation
          ? _value.hasMealAssociation
          : hasMealAssociation // ignore: cast_nullable_to_non_nullable
              as bool?,
      associatedMealTime: freezed == associatedMealTime
          ? _value.associatedMealTime
          : associatedMealTime // ignore: cast_nullable_to_non_nullable
              as MealTimeOption?,
      associatedMealDelay: freezed == associatedMealDelay
          ? _value.associatedMealDelay
          : associatedMealDelay // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryEntryImplCopyWith<$Res>
    implements $HistoryEntryCopyWith<$Res> {
  factory _$$HistoryEntryImplCopyWith(
          _$HistoryEntryImpl value, $Res Function(_$HistoryEntryImpl) then) =
      __$$HistoryEntryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {HistoryEntryKind kind,
      DateTime occurredAt,
      HistoryEntrySyncState syncState,
      String? serverId,
      String? clientGuid,
      String? lastErrorCode,
      MealTimeOption? mealTime,
      FodmapLoad? aggregatedFodmap,
      List<String> itemNames,
      SymptomTypeOption? symptomType,
      int? intensity,
      bool? hasMealAssociation,
      MealTimeOption? associatedMealTime,
      Duration? associatedMealDelay});
}

/// @nodoc
class __$$HistoryEntryImplCopyWithImpl<$Res>
    extends _$HistoryEntryCopyWithImpl<$Res, _$HistoryEntryImpl>
    implements _$$HistoryEntryImplCopyWith<$Res> {
  __$$HistoryEntryImplCopyWithImpl(
      _$HistoryEntryImpl _value, $Res Function(_$HistoryEntryImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? kind = null,
    Object? occurredAt = null,
    Object? syncState = null,
    Object? serverId = freezed,
    Object? clientGuid = freezed,
    Object? lastErrorCode = freezed,
    Object? mealTime = freezed,
    Object? aggregatedFodmap = freezed,
    Object? itemNames = null,
    Object? symptomType = freezed,
    Object? intensity = freezed,
    Object? hasMealAssociation = freezed,
    Object? associatedMealTime = freezed,
    Object? associatedMealDelay = freezed,
  }) {
    return _then(_$HistoryEntryImpl(
      kind: null == kind
          ? _value.kind
          : kind // ignore: cast_nullable_to_non_nullable
              as HistoryEntryKind,
      occurredAt: null == occurredAt
          ? _value.occurredAt
          : occurredAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      syncState: null == syncState
          ? _value.syncState
          : syncState // ignore: cast_nullable_to_non_nullable
              as HistoryEntrySyncState,
      serverId: freezed == serverId
          ? _value.serverId
          : serverId // ignore: cast_nullable_to_non_nullable
              as String?,
      clientGuid: freezed == clientGuid
          ? _value.clientGuid
          : clientGuid // ignore: cast_nullable_to_non_nullable
              as String?,
      lastErrorCode: freezed == lastErrorCode
          ? _value.lastErrorCode
          : lastErrorCode // ignore: cast_nullable_to_non_nullable
              as String?,
      mealTime: freezed == mealTime
          ? _value.mealTime
          : mealTime // ignore: cast_nullable_to_non_nullable
              as MealTimeOption?,
      aggregatedFodmap: freezed == aggregatedFodmap
          ? _value.aggregatedFodmap
          : aggregatedFodmap // ignore: cast_nullable_to_non_nullable
              as FodmapLoad?,
      itemNames: null == itemNames
          ? _value._itemNames
          : itemNames // ignore: cast_nullable_to_non_nullable
              as List<String>,
      symptomType: freezed == symptomType
          ? _value.symptomType
          : symptomType // ignore: cast_nullable_to_non_nullable
              as SymptomTypeOption?,
      intensity: freezed == intensity
          ? _value.intensity
          : intensity // ignore: cast_nullable_to_non_nullable
              as int?,
      hasMealAssociation: freezed == hasMealAssociation
          ? _value.hasMealAssociation
          : hasMealAssociation // ignore: cast_nullable_to_non_nullable
              as bool?,
      associatedMealTime: freezed == associatedMealTime
          ? _value.associatedMealTime
          : associatedMealTime // ignore: cast_nullable_to_non_nullable
              as MealTimeOption?,
      associatedMealDelay: freezed == associatedMealDelay
          ? _value.associatedMealDelay
          : associatedMealDelay // ignore: cast_nullable_to_non_nullable
              as Duration?,
    ));
  }
}

/// @nodoc

class _$HistoryEntryImpl extends _HistoryEntry {
  const _$HistoryEntryImpl(
      {required this.kind,
      required this.occurredAt,
      required this.syncState,
      this.serverId,
      this.clientGuid,
      this.lastErrorCode,
      this.mealTime,
      this.aggregatedFodmap,
      final List<String> itemNames = const <String>[],
      this.symptomType,
      this.intensity,
      this.hasMealAssociation,
      this.associatedMealTime,
      this.associatedMealDelay})
      : _itemNames = itemNames,
        super._();

  @override
  final HistoryEntryKind kind;
  @override
  final DateTime occurredAt;
  @override
  final HistoryEntrySyncState syncState;

  /// Identificador del servidor. `null` mientras no se haya sincronizado.
  @override
  final String? serverId;

  /// Identificador local, para poder descartar una fila rechazada.
  @override
  final String? clientGuid;

  /// `errorCode` del ultimo rechazo, si lo hubo.
  @override
  final String? lastErrorCode;
// Datos de una comida.
  @override
  final MealTimeOption? mealTime;
  @override
  final FodmapLoad? aggregatedFodmap;
  final List<String> _itemNames;
  @override
  @JsonKey()
  List<String> get itemNames {
    if (_itemNames is EqualUnmodifiableListView) return _itemNames;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_itemNames);
  }

// Datos de un sintoma.
  @override
  final SymptomTypeOption? symptomType;
  @override
  final int? intensity;
  @override
  final bool? hasMealAssociation;

  /// Momento de comida con la que el **servidor** asocio este sintoma.
  ///
  /// El cliente no calcula la ventana de cuatro horas: la resuelve el
  /// backend (DEC-B3-06) y aca solo se muestra lo confirmado. Se resuelve
  /// cruzando `associatedMealId` contra las comidas del mismo rango, que ya
  /// vienen en la misma composicion del historial.
  @override
  final MealTimeOption? associatedMealTime;

  /// Cuanto paso entre la comida asociada y el sintoma.
  @override
  final Duration? associatedMealDelay;

  @override
  String toString() {
    return 'HistoryEntry(kind: $kind, occurredAt: $occurredAt, syncState: $syncState, serverId: $serverId, clientGuid: $clientGuid, lastErrorCode: $lastErrorCode, mealTime: $mealTime, aggregatedFodmap: $aggregatedFodmap, itemNames: $itemNames, symptomType: $symptomType, intensity: $intensity, hasMealAssociation: $hasMealAssociation, associatedMealTime: $associatedMealTime, associatedMealDelay: $associatedMealDelay)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryEntryImpl &&
            (identical(other.kind, kind) || other.kind == kind) &&
            (identical(other.occurredAt, occurredAt) ||
                other.occurredAt == occurredAt) &&
            (identical(other.syncState, syncState) ||
                other.syncState == syncState) &&
            (identical(other.serverId, serverId) ||
                other.serverId == serverId) &&
            (identical(other.clientGuid, clientGuid) ||
                other.clientGuid == clientGuid) &&
            (identical(other.lastErrorCode, lastErrorCode) ||
                other.lastErrorCode == lastErrorCode) &&
            (identical(other.mealTime, mealTime) ||
                other.mealTime == mealTime) &&
            (identical(other.aggregatedFodmap, aggregatedFodmap) ||
                other.aggregatedFodmap == aggregatedFodmap) &&
            const DeepCollectionEquality()
                .equals(other._itemNames, _itemNames) &&
            (identical(other.symptomType, symptomType) ||
                other.symptomType == symptomType) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.hasMealAssociation, hasMealAssociation) ||
                other.hasMealAssociation == hasMealAssociation) &&
            (identical(other.associatedMealTime, associatedMealTime) ||
                other.associatedMealTime == associatedMealTime) &&
            (identical(other.associatedMealDelay, associatedMealDelay) ||
                other.associatedMealDelay == associatedMealDelay));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      kind,
      occurredAt,
      syncState,
      serverId,
      clientGuid,
      lastErrorCode,
      mealTime,
      aggregatedFodmap,
      const DeepCollectionEquality().hash(_itemNames),
      symptomType,
      intensity,
      hasMealAssociation,
      associatedMealTime,
      associatedMealDelay);

  /// Create a copy of HistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryEntryImplCopyWith<_$HistoryEntryImpl> get copyWith =>
      __$$HistoryEntryImplCopyWithImpl<_$HistoryEntryImpl>(this, _$identity);
}

abstract class _HistoryEntry extends HistoryEntry {
  const factory _HistoryEntry(
      {required final HistoryEntryKind kind,
      required final DateTime occurredAt,
      required final HistoryEntrySyncState syncState,
      final String? serverId,
      final String? clientGuid,
      final String? lastErrorCode,
      final MealTimeOption? mealTime,
      final FodmapLoad? aggregatedFodmap,
      final List<String> itemNames,
      final SymptomTypeOption? symptomType,
      final int? intensity,
      final bool? hasMealAssociation,
      final MealTimeOption? associatedMealTime,
      final Duration? associatedMealDelay}) = _$HistoryEntryImpl;
  const _HistoryEntry._() : super._();

  @override
  HistoryEntryKind get kind;
  @override
  DateTime get occurredAt;
  @override
  HistoryEntrySyncState get syncState;

  /// Identificador del servidor. `null` mientras no se haya sincronizado.
  @override
  String? get serverId;

  /// Identificador local, para poder descartar una fila rechazada.
  @override
  String? get clientGuid;

  /// `errorCode` del ultimo rechazo, si lo hubo.
  @override
  String? get lastErrorCode; // Datos de una comida.
  @override
  MealTimeOption? get mealTime;
  @override
  FodmapLoad? get aggregatedFodmap;
  @override
  List<String> get itemNames; // Datos de un sintoma.
  @override
  SymptomTypeOption? get symptomType;
  @override
  int? get intensity;
  @override
  bool? get hasMealAssociation;

  /// Momento de comida con la que el **servidor** asocio este sintoma.
  ///
  /// El cliente no calcula la ventana de cuatro horas: la resuelve el
  /// backend (DEC-B3-06) y aca solo se muestra lo confirmado. Se resuelve
  /// cruzando `associatedMealId` contra las comidas del mismo rango, que ya
  /// vienen en la misma composicion del historial.
  @override
  MealTimeOption? get associatedMealTime;

  /// Cuanto paso entre la comida asociada y el sintoma.
  @override
  Duration? get associatedMealDelay;

  /// Create a copy of HistoryEntry
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryEntryImplCopyWith<_$HistoryEntryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
