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
mixin _$HistoryMealItem {
  double get quantity => throw _privateConstructorUsedError;

  /// Nombre del catalogo local; `null` si el dispositivo no lo conoce.
  String? get name => throw _privateConstructorUsedError;
  MeasurementUnitOption? get unit => throw _privateConstructorUsedError;

  /// `true` si es un plato personalizado, cuyo nombre el dispositivo no
  /// guarda.
  bool get isCustom => throw _privateConstructorUsedError;

  /// Create a copy of HistoryMealItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryMealItemCopyWith<HistoryMealItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryMealItemCopyWith<$Res> {
  factory $HistoryMealItemCopyWith(
          HistoryMealItem value, $Res Function(HistoryMealItem) then) =
      _$HistoryMealItemCopyWithImpl<$Res, HistoryMealItem>;
  @useResult
  $Res call(
      {double quantity,
      String? name,
      MeasurementUnitOption? unit,
      bool isCustom});
}

/// @nodoc
class _$HistoryMealItemCopyWithImpl<$Res, $Val extends HistoryMealItem>
    implements $HistoryMealItemCopyWith<$Res> {
  _$HistoryMealItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryMealItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? name = freezed,
    Object? unit = freezed,
    Object? isCustom = null,
  }) {
    return _then(_value.copyWith(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnitOption?,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryMealItemImplCopyWith<$Res>
    implements $HistoryMealItemCopyWith<$Res> {
  factory _$$HistoryMealItemImplCopyWith(_$HistoryMealItemImpl value,
          $Res Function(_$HistoryMealItemImpl) then) =
      __$$HistoryMealItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double quantity,
      String? name,
      MeasurementUnitOption? unit,
      bool isCustom});
}

/// @nodoc
class __$$HistoryMealItemImplCopyWithImpl<$Res>
    extends _$HistoryMealItemCopyWithImpl<$Res, _$HistoryMealItemImpl>
    implements _$$HistoryMealItemImplCopyWith<$Res> {
  __$$HistoryMealItemImplCopyWithImpl(
      _$HistoryMealItemImpl _value, $Res Function(_$HistoryMealItemImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryMealItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? quantity = null,
    Object? name = freezed,
    Object? unit = freezed,
    Object? isCustom = null,
  }) {
    return _then(_$HistoryMealItemImpl(
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as double,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      unit: freezed == unit
          ? _value.unit
          : unit // ignore: cast_nullable_to_non_nullable
              as MeasurementUnitOption?,
      isCustom: null == isCustom
          ? _value.isCustom
          : isCustom // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$HistoryMealItemImpl implements _HistoryMealItem {
  const _$HistoryMealItemImpl(
      {required this.quantity, this.name, this.unit, this.isCustom = false});

  @override
  final double quantity;

  /// Nombre del catalogo local; `null` si el dispositivo no lo conoce.
  @override
  final String? name;
  @override
  final MeasurementUnitOption? unit;

  /// `true` si es un plato personalizado, cuyo nombre el dispositivo no
  /// guarda.
  @override
  @JsonKey()
  final bool isCustom;

  @override
  String toString() {
    return 'HistoryMealItem(quantity: $quantity, name: $name, unit: $unit, isCustom: $isCustom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryMealItemImpl &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unit, unit) || other.unit == unit) &&
            (identical(other.isCustom, isCustom) ||
                other.isCustom == isCustom));
  }

  @override
  int get hashCode => Object.hash(runtimeType, quantity, name, unit, isCustom);

  /// Create a copy of HistoryMealItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryMealItemImplCopyWith<_$HistoryMealItemImpl> get copyWith =>
      __$$HistoryMealItemImplCopyWithImpl<_$HistoryMealItemImpl>(
          this, _$identity);
}

abstract class _HistoryMealItem implements HistoryMealItem {
  const factory _HistoryMealItem(
      {required final double quantity,
      final String? name,
      final MeasurementUnitOption? unit,
      final bool isCustom}) = _$HistoryMealItemImpl;

  @override
  double get quantity;

  /// Nombre del catalogo local; `null` si el dispositivo no lo conoce.
  @override
  String? get name;
  @override
  MeasurementUnitOption? get unit;

  /// `true` si es un plato personalizado, cuyo nombre el dispositivo no
  /// guarda.
  @override
  bool get isCustom;

  /// Create a copy of HistoryMealItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryMealItemImplCopyWith<_$HistoryMealItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HistoryNote {
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Create a copy of HistoryNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HistoryNoteCopyWith<HistoryNote> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HistoryNoteCopyWith<$Res> {
  factory $HistoryNoteCopyWith(
          HistoryNote value, $Res Function(HistoryNote) then) =
      _$HistoryNoteCopyWithImpl<$Res, HistoryNote>;
  @useResult
  $Res call({String content, DateTime createdAt});
}

/// @nodoc
class _$HistoryNoteCopyWithImpl<$Res, $Val extends HistoryNote>
    implements $HistoryNoteCopyWith<$Res> {
  _$HistoryNoteCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HistoryNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$HistoryNoteImplCopyWith<$Res>
    implements $HistoryNoteCopyWith<$Res> {
  factory _$$HistoryNoteImplCopyWith(
          _$HistoryNoteImpl value, $Res Function(_$HistoryNoteImpl) then) =
      __$$HistoryNoteImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String content, DateTime createdAt});
}

/// @nodoc
class __$$HistoryNoteImplCopyWithImpl<$Res>
    extends _$HistoryNoteCopyWithImpl<$Res, _$HistoryNoteImpl>
    implements _$$HistoryNoteImplCopyWith<$Res> {
  __$$HistoryNoteImplCopyWithImpl(
      _$HistoryNoteImpl _value, $Res Function(_$HistoryNoteImpl) _then)
      : super(_value, _then);

  /// Create a copy of HistoryNote
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = null,
    Object? createdAt = null,
  }) {
    return _then(_$HistoryNoteImpl(
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$HistoryNoteImpl implements _HistoryNote {
  const _$HistoryNoteImpl({required this.content, required this.createdAt});

  @override
  final String content;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'HistoryNote(content: $content, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HistoryNoteImpl &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @override
  int get hashCode => Object.hash(runtimeType, content, createdAt);

  /// Create a copy of HistoryNote
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HistoryNoteImplCopyWith<_$HistoryNoteImpl> get copyWith =>
      __$$HistoryNoteImplCopyWithImpl<_$HistoryNoteImpl>(this, _$identity);
}

abstract class _HistoryNote implements HistoryNote {
  const factory _HistoryNote(
      {required final String content,
      required final DateTime createdAt}) = _$HistoryNoteImpl;

  @override
  String get content;
  @override
  DateTime get createdAt;

  /// Create a copy of HistoryNote
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HistoryNoteImplCopyWith<_$HistoryNoteImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$HistoryEntry {
  HistoryEntryKind get kind => throw _privateConstructorUsedError;
  DateTime get occurredAt => throw _privateConstructorUsedError;
  HistoryEntrySyncState get syncState => throw _privateConstructorUsedError;

  /// Identificador del servidor. `null` mientras no se haya sincronizado.
  String? get serverId => throw _privateConstructorUsedError;

  /// Identificador local, para poder descartar una fila que no llego al
  /// servidor.
  String? get clientGuid => throw _privateConstructorUsedError;

  /// `errorCode` del ultimo rechazo, si lo hubo.
  String? get lastErrorCode =>
      throw _privateConstructorUsedError; // Datos de una comida.
  MealTimeOption? get mealTime => throw _privateConstructorUsedError;
  FodmapLoad? get aggregatedFodmap => throw _privateConstructorUsedError;
  List<HistoryMealItem> get items => throw _privateConstructorUsedError;

  /// Notas de contexto del registro, de la más antigua a la más reciente.
  List<HistoryNote> get notes =>
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

  /// Alimentos de la comida asociada, o `null` si ninguno tiene nombre local.
  String? get associatedMealName => throw _privateConstructorUsedError;

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
      List<HistoryMealItem> items,
      List<HistoryNote> notes,
      SymptomTypeOption? symptomType,
      int? intensity,
      bool? hasMealAssociation,
      MealTimeOption? associatedMealTime,
      String? associatedMealName,
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
    Object? items = null,
    Object? notes = null,
    Object? symptomType = freezed,
    Object? intensity = freezed,
    Object? hasMealAssociation = freezed,
    Object? associatedMealTime = freezed,
    Object? associatedMealName = freezed,
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
      items: null == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<HistoryMealItem>,
      notes: null == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<HistoryNote>,
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
      associatedMealName: freezed == associatedMealName
          ? _value.associatedMealName
          : associatedMealName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      List<HistoryMealItem> items,
      List<HistoryNote> notes,
      SymptomTypeOption? symptomType,
      int? intensity,
      bool? hasMealAssociation,
      MealTimeOption? associatedMealTime,
      String? associatedMealName,
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
    Object? items = null,
    Object? notes = null,
    Object? symptomType = freezed,
    Object? intensity = freezed,
    Object? hasMealAssociation = freezed,
    Object? associatedMealTime = freezed,
    Object? associatedMealName = freezed,
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
      items: null == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<HistoryMealItem>,
      notes: null == notes
          ? _value._notes
          : notes // ignore: cast_nullable_to_non_nullable
              as List<HistoryNote>,
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
      associatedMealName: freezed == associatedMealName
          ? _value.associatedMealName
          : associatedMealName // ignore: cast_nullable_to_non_nullable
              as String?,
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
      final List<HistoryMealItem> items = const <HistoryMealItem>[],
      final List<HistoryNote> notes = const <HistoryNote>[],
      this.symptomType,
      this.intensity,
      this.hasMealAssociation,
      this.associatedMealTime,
      this.associatedMealName,
      this.associatedMealDelay})
      : _items = items,
        _notes = notes,
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

  /// Identificador local, para poder descartar una fila que no llego al
  /// servidor.
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
  final List<HistoryMealItem> _items;
  @override
  @JsonKey()
  List<HistoryMealItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Notas de contexto del registro, de la más antigua a la más reciente.
  final List<HistoryNote> _notes;

  /// Notas de contexto del registro, de la más antigua a la más reciente.
  @override
  @JsonKey()
  List<HistoryNote> get notes {
    if (_notes is EqualUnmodifiableListView) return _notes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_notes);
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

  /// Alimentos de la comida asociada, o `null` si ninguno tiene nombre local.
  @override
  final String? associatedMealName;

  /// Cuanto paso entre la comida asociada y el sintoma.
  @override
  final Duration? associatedMealDelay;

  @override
  String toString() {
    return 'HistoryEntry(kind: $kind, occurredAt: $occurredAt, syncState: $syncState, serverId: $serverId, clientGuid: $clientGuid, lastErrorCode: $lastErrorCode, mealTime: $mealTime, aggregatedFodmap: $aggregatedFodmap, items: $items, notes: $notes, symptomType: $symptomType, intensity: $intensity, hasMealAssociation: $hasMealAssociation, associatedMealTime: $associatedMealTime, associatedMealName: $associatedMealName, associatedMealDelay: $associatedMealDelay)';
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
            const DeepCollectionEquality().equals(other._items, _items) &&
            const DeepCollectionEquality().equals(other._notes, _notes) &&
            (identical(other.symptomType, symptomType) ||
                other.symptomType == symptomType) &&
            (identical(other.intensity, intensity) ||
                other.intensity == intensity) &&
            (identical(other.hasMealAssociation, hasMealAssociation) ||
                other.hasMealAssociation == hasMealAssociation) &&
            (identical(other.associatedMealTime, associatedMealTime) ||
                other.associatedMealTime == associatedMealTime) &&
            (identical(other.associatedMealName, associatedMealName) ||
                other.associatedMealName == associatedMealName) &&
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
      const DeepCollectionEquality().hash(_items),
      const DeepCollectionEquality().hash(_notes),
      symptomType,
      intensity,
      hasMealAssociation,
      associatedMealTime,
      associatedMealName,
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
      final List<HistoryMealItem> items,
      final List<HistoryNote> notes,
      final SymptomTypeOption? symptomType,
      final int? intensity,
      final bool? hasMealAssociation,
      final MealTimeOption? associatedMealTime,
      final String? associatedMealName,
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

  /// Identificador local, para poder descartar una fila que no llego al
  /// servidor.
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
  List<HistoryMealItem> get items;

  /// Notas de contexto del registro, de la más antigua a la más reciente.
  @override
  List<HistoryNote> get notes; // Datos de un sintoma.
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

  /// Alimentos de la comida asociada, o `null` si ninguno tiene nombre local.
  @override
  String? get associatedMealName;

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
