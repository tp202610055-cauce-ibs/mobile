// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MealsLocalTable extends MealsLocal
    with TableInfo<$MealsLocalTable, MealLocal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientGuidMeta =
      const VerificationMeta('clientGuid');
  @override
  late final GeneratedColumn<String> clientGuid = GeneratedColumn<String>(
      'client_guid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _mealTimeMeta =
      const VerificationMeta('mealTime');
  @override
  late final GeneratedColumn<String> mealTime = GeneratedColumn<String>(
      'meal_time', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _consumedAtMeta =
      const VerificationMeta('consumedAt');
  @override
  late final GeneratedColumn<DateTime> consumedAt = GeneratedColumn<DateTime>(
      'consumed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _clientCreatedAtMeta =
      const VerificationMeta('clientCreatedAt');
  @override
  late final GeneratedColumn<DateTime> clientCreatedAt =
      GeneratedColumn<DateTime>('client_created_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<LocalSyncStatus, String>
      syncStatus = GeneratedColumn<String>('sync_status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<LocalSyncStatus>(
              $MealsLocalTable.$convertersyncStatus);
  static const VerificationMeta _serverIdMeta =
      const VerificationMeta('serverId');
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
      'server_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _lastErrorCodeMeta =
      const VerificationMeta('lastErrorCode');
  @override
  late final GeneratedColumn<String> lastErrorCode = GeneratedColumn<String>(
      'last_error_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        clientGuid,
        mealTime,
        consumedAt,
        clientCreatedAt,
        syncStatus,
        serverId,
        lastErrorCode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meals_local';
  @override
  VerificationContext validateIntegrity(Insertable<MealLocal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_guid')) {
      context.handle(
          _clientGuidMeta,
          clientGuid.isAcceptableOrUnknown(
              data['client_guid']!, _clientGuidMeta));
    } else if (isInserting) {
      context.missing(_clientGuidMeta);
    }
    if (data.containsKey('meal_time')) {
      context.handle(_mealTimeMeta,
          mealTime.isAcceptableOrUnknown(data['meal_time']!, _mealTimeMeta));
    } else if (isInserting) {
      context.missing(_mealTimeMeta);
    }
    if (data.containsKey('consumed_at')) {
      context.handle(
          _consumedAtMeta,
          consumedAt.isAcceptableOrUnknown(
              data['consumed_at']!, _consumedAtMeta));
    } else if (isInserting) {
      context.missing(_consumedAtMeta);
    }
    if (data.containsKey('client_created_at')) {
      context.handle(
          _clientCreatedAtMeta,
          clientCreatedAt.isAcceptableOrUnknown(
              data['client_created_at']!, _clientCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_clientCreatedAtMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    }
    if (data.containsKey('last_error_code')) {
      context.handle(
          _lastErrorCodeMeta,
          lastErrorCode.isAcceptableOrUnknown(
              data['last_error_code']!, _lastErrorCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientGuid};
  @override
  MealLocal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealLocal(
      clientGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_guid'])!,
      mealTime: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}meal_time'])!,
      consumedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}consumed_at'])!,
      clientCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}client_created_at'])!,
      syncStatus: $MealsLocalTable.$convertersyncStatus.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}sync_status'])!),
      serverId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}server_id']),
      lastErrorCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error_code']),
    );
  }

  @override
  $MealsLocalTable createAlias(String alias) {
    return $MealsLocalTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LocalSyncStatus, String, String>
      $convertersyncStatus =
      const EnumNameConverter<LocalSyncStatus>(LocalSyncStatus.values);
}

class MealLocal extends DataClass implements Insertable<MealLocal> {
  /// UUID v4 generado en el dispositivo. Es la clave de idempotencia que el
  /// backend usa para deduplicar, asi que se genera **una sola vez** y el
  /// reintento la repite intacta. Reusarla con otra carga da 409
  /// `idempotency_mismatch`.
  final String clientGuid;

  /// Valor de contrato de `MealTime`: `Breakfast`, `Lunch`, `Dinner`, `Snack`.
  final String mealTime;

  /// Momento en que el paciente comio.
  final DateTime consumedAt;

  /// Momento en que el registro se creo en el dispositivo.
  ///
  /// El servidor lo valida contra su propio reloj con 5 minutos de tolerancia,
  /// y ademas es el ancla de la ventana de 4 horas al asociar sintomas.
  final DateTime clientCreatedAt;
  final LocalSyncStatus syncStatus;

  /// Identificador que asigno el servidor, disponible recien tras sincronizar.
  ///
  /// Mientras sea `null` la fila no puede recibir notas de contexto: US13 exige
  /// un `mealId` del servidor.
  final String? serverId;

  /// Ultimo `errorCode` que devolvio el lote para esta fila.
  final String? lastErrorCode;
  const MealLocal(
      {required this.clientGuid,
      required this.mealTime,
      required this.consumedAt,
      required this.clientCreatedAt,
      required this.syncStatus,
      this.serverId,
      this.lastErrorCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_guid'] = Variable<String>(clientGuid);
    map['meal_time'] = Variable<String>(mealTime);
    map['consumed_at'] = Variable<DateTime>(consumedAt);
    map['client_created_at'] = Variable<DateTime>(clientCreatedAt);
    {
      map['sync_status'] = Variable<String>(
          $MealsLocalTable.$convertersyncStatus.toSql(syncStatus));
    }
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    if (!nullToAbsent || lastErrorCode != null) {
      map['last_error_code'] = Variable<String>(lastErrorCode);
    }
    return map;
  }

  MealsLocalCompanion toCompanion(bool nullToAbsent) {
    return MealsLocalCompanion(
      clientGuid: Value(clientGuid),
      mealTime: Value(mealTime),
      consumedAt: Value(consumedAt),
      clientCreatedAt: Value(clientCreatedAt),
      syncStatus: Value(syncStatus),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      lastErrorCode: lastErrorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorCode),
    );
  }

  factory MealLocal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealLocal(
      clientGuid: serializer.fromJson<String>(json['clientGuid']),
      mealTime: serializer.fromJson<String>(json['mealTime']),
      consumedAt: serializer.fromJson<DateTime>(json['consumedAt']),
      clientCreatedAt: serializer.fromJson<DateTime>(json['clientCreatedAt']),
      syncStatus: $MealsLocalTable.$convertersyncStatus
          .fromJson(serializer.fromJson<String>(json['syncStatus'])),
      serverId: serializer.fromJson<String?>(json['serverId']),
      lastErrorCode: serializer.fromJson<String?>(json['lastErrorCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientGuid': serializer.toJson<String>(clientGuid),
      'mealTime': serializer.toJson<String>(mealTime),
      'consumedAt': serializer.toJson<DateTime>(consumedAt),
      'clientCreatedAt': serializer.toJson<DateTime>(clientCreatedAt),
      'syncStatus': serializer.toJson<String>(
          $MealsLocalTable.$convertersyncStatus.toJson(syncStatus)),
      'serverId': serializer.toJson<String?>(serverId),
      'lastErrorCode': serializer.toJson<String?>(lastErrorCode),
    };
  }

  MealLocal copyWith(
          {String? clientGuid,
          String? mealTime,
          DateTime? consumedAt,
          DateTime? clientCreatedAt,
          LocalSyncStatus? syncStatus,
          Value<String?> serverId = const Value.absent(),
          Value<String?> lastErrorCode = const Value.absent()}) =>
      MealLocal(
        clientGuid: clientGuid ?? this.clientGuid,
        mealTime: mealTime ?? this.mealTime,
        consumedAt: consumedAt ?? this.consumedAt,
        clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
        syncStatus: syncStatus ?? this.syncStatus,
        serverId: serverId.present ? serverId.value : this.serverId,
        lastErrorCode:
            lastErrorCode.present ? lastErrorCode.value : this.lastErrorCode,
      );
  MealLocal copyWithCompanion(MealsLocalCompanion data) {
    return MealLocal(
      clientGuid:
          data.clientGuid.present ? data.clientGuid.value : this.clientGuid,
      mealTime: data.mealTime.present ? data.mealTime.value : this.mealTime,
      consumedAt:
          data.consumedAt.present ? data.consumedAt.value : this.consumedAt,
      clientCreatedAt: data.clientCreatedAt.present
          ? data.clientCreatedAt.value
          : this.clientCreatedAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      lastErrorCode: data.lastErrorCode.present
          ? data.lastErrorCode.value
          : this.lastErrorCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealLocal(')
          ..write('clientGuid: $clientGuid, ')
          ..write('mealTime: $mealTime, ')
          ..write('consumedAt: $consumedAt, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverId: $serverId, ')
          ..write('lastErrorCode: $lastErrorCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clientGuid, mealTime, consumedAt,
      clientCreatedAt, syncStatus, serverId, lastErrorCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealLocal &&
          other.clientGuid == this.clientGuid &&
          other.mealTime == this.mealTime &&
          other.consumedAt == this.consumedAt &&
          other.clientCreatedAt == this.clientCreatedAt &&
          other.syncStatus == this.syncStatus &&
          other.serverId == this.serverId &&
          other.lastErrorCode == this.lastErrorCode);
}

class MealsLocalCompanion extends UpdateCompanion<MealLocal> {
  final Value<String> clientGuid;
  final Value<String> mealTime;
  final Value<DateTime> consumedAt;
  final Value<DateTime> clientCreatedAt;
  final Value<LocalSyncStatus> syncStatus;
  final Value<String?> serverId;
  final Value<String?> lastErrorCode;
  final Value<int> rowid;
  const MealsLocalCompanion({
    this.clientGuid = const Value.absent(),
    this.mealTime = const Value.absent(),
    this.consumedAt = const Value.absent(),
    this.clientCreatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.serverId = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MealsLocalCompanion.insert({
    required String clientGuid,
    required String mealTime,
    required DateTime consumedAt,
    required DateTime clientCreatedAt,
    required LocalSyncStatus syncStatus,
    this.serverId = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : clientGuid = Value(clientGuid),
        mealTime = Value(mealTime),
        consumedAt = Value(consumedAt),
        clientCreatedAt = Value(clientCreatedAt),
        syncStatus = Value(syncStatus);
  static Insertable<MealLocal> custom({
    Expression<String>? clientGuid,
    Expression<String>? mealTime,
    Expression<DateTime>? consumedAt,
    Expression<DateTime>? clientCreatedAt,
    Expression<String>? syncStatus,
    Expression<String>? serverId,
    Expression<String>? lastErrorCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientGuid != null) 'client_guid': clientGuid,
      if (mealTime != null) 'meal_time': mealTime,
      if (consumedAt != null) 'consumed_at': consumedAt,
      if (clientCreatedAt != null) 'client_created_at': clientCreatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (serverId != null) 'server_id': serverId,
      if (lastErrorCode != null) 'last_error_code': lastErrorCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MealsLocalCompanion copyWith(
      {Value<String>? clientGuid,
      Value<String>? mealTime,
      Value<DateTime>? consumedAt,
      Value<DateTime>? clientCreatedAt,
      Value<LocalSyncStatus>? syncStatus,
      Value<String?>? serverId,
      Value<String?>? lastErrorCode,
      Value<int>? rowid}) {
    return MealsLocalCompanion(
      clientGuid: clientGuid ?? this.clientGuid,
      mealTime: mealTime ?? this.mealTime,
      consumedAt: consumedAt ?? this.consumedAt,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      serverId: serverId ?? this.serverId,
      lastErrorCode: lastErrorCode ?? this.lastErrorCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientGuid.present) {
      map['client_guid'] = Variable<String>(clientGuid.value);
    }
    if (mealTime.present) {
      map['meal_time'] = Variable<String>(mealTime.value);
    }
    if (consumedAt.present) {
      map['consumed_at'] = Variable<DateTime>(consumedAt.value);
    }
    if (clientCreatedAt.present) {
      map['client_created_at'] = Variable<DateTime>(clientCreatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
          $MealsLocalTable.$convertersyncStatus.toSql(syncStatus.value));
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (lastErrorCode.present) {
      map['last_error_code'] = Variable<String>(lastErrorCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealsLocalCompanion(')
          ..write('clientGuid: $clientGuid, ')
          ..write('mealTime: $mealTime, ')
          ..write('consumedAt: $consumedAt, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverId: $serverId, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MealItemsLocalTable extends MealItemsLocal
    with TableInfo<$MealItemsLocalTable, MealItemLocal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MealItemsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _mealClientGuidMeta =
      const VerificationMeta('mealClientGuid');
  @override
  late final GeneratedColumn<String> mealClientGuid = GeneratedColumn<String>(
      'meal_client_guid', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES meals_local (client_guid) ON DELETE CASCADE'));
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
      'food_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _customFoodIdMeta =
      const VerificationMeta('customFoodId');
  @override
  late final GeneratedColumn<String> customFoodId = GeneratedColumn<String>(
      'custom_food_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _quantityMeta =
      const VerificationMeta('quantity');
  @override
  late final GeneratedColumn<double> quantity = GeneratedColumn<double>(
      'quantity', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
      'unit', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, mealClientGuid, foodId, customFoodId, quantity, unit];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'meal_items_local';
  @override
  VerificationContext validateIntegrity(Insertable<MealItemLocal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('meal_client_guid')) {
      context.handle(
          _mealClientGuidMeta,
          mealClientGuid.isAcceptableOrUnknown(
              data['meal_client_guid']!, _mealClientGuidMeta));
    } else if (isInserting) {
      context.missing(_mealClientGuidMeta);
    }
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    }
    if (data.containsKey('custom_food_id')) {
      context.handle(
          _customFoodIdMeta,
          customFoodId.isAcceptableOrUnknown(
              data['custom_food_id']!, _customFoodIdMeta));
    }
    if (data.containsKey('quantity')) {
      context.handle(_quantityMeta,
          quantity.isAcceptableOrUnknown(data['quantity']!, _quantityMeta));
    } else if (isInserting) {
      context.missing(_quantityMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
          _unitMeta, unit.isAcceptableOrUnknown(data['unit']!, _unitMeta));
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MealItemLocal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MealItemLocal(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      mealClientGuid: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}meal_client_guid'])!,
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_id']),
      customFoodId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}custom_food_id']),
      quantity: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}quantity'])!,
      unit: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unit'])!,
    );
  }

  @override
  $MealItemsLocalTable createAlias(String alias) {
    return $MealItemsLocalTable(attachedDatabase, alias);
  }
}

class MealItemLocal extends DataClass implements Insertable<MealItemLocal> {
  final int id;
  final String mealClientGuid;

  /// Alimento del catalogo. Excluyente con [customFoodId].
  final String? foodId;

  /// Plato personalizado del paciente. Excluyente con [foodId].
  ///
  /// Un plato personalizado no se puede crear sin conexion (`POST
  /// /custom-foods` no entra al lote de sincronizacion), asi que una comida
  /// offline solo puede referenciar uno que ya existe en el servidor.
  final String? customFoodId;
  final double quantity;

  /// Valor de contrato de `MeasurementUnit`: `Grams`, `Cups`, `Units`,
  /// `Ounces`, `Tablespoons`.
  final String unit;
  const MealItemLocal(
      {required this.id,
      required this.mealClientGuid,
      this.foodId,
      this.customFoodId,
      required this.quantity,
      required this.unit});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['meal_client_guid'] = Variable<String>(mealClientGuid);
    if (!nullToAbsent || foodId != null) {
      map['food_id'] = Variable<String>(foodId);
    }
    if (!nullToAbsent || customFoodId != null) {
      map['custom_food_id'] = Variable<String>(customFoodId);
    }
    map['quantity'] = Variable<double>(quantity);
    map['unit'] = Variable<String>(unit);
    return map;
  }

  MealItemsLocalCompanion toCompanion(bool nullToAbsent) {
    return MealItemsLocalCompanion(
      id: Value(id),
      mealClientGuid: Value(mealClientGuid),
      foodId:
          foodId == null && nullToAbsent ? const Value.absent() : Value(foodId),
      customFoodId: customFoodId == null && nullToAbsent
          ? const Value.absent()
          : Value(customFoodId),
      quantity: Value(quantity),
      unit: Value(unit),
    );
  }

  factory MealItemLocal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MealItemLocal(
      id: serializer.fromJson<int>(json['id']),
      mealClientGuid: serializer.fromJson<String>(json['mealClientGuid']),
      foodId: serializer.fromJson<String?>(json['foodId']),
      customFoodId: serializer.fromJson<String?>(json['customFoodId']),
      quantity: serializer.fromJson<double>(json['quantity']),
      unit: serializer.fromJson<String>(json['unit']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'mealClientGuid': serializer.toJson<String>(mealClientGuid),
      'foodId': serializer.toJson<String?>(foodId),
      'customFoodId': serializer.toJson<String?>(customFoodId),
      'quantity': serializer.toJson<double>(quantity),
      'unit': serializer.toJson<String>(unit),
    };
  }

  MealItemLocal copyWith(
          {int? id,
          String? mealClientGuid,
          Value<String?> foodId = const Value.absent(),
          Value<String?> customFoodId = const Value.absent(),
          double? quantity,
          String? unit}) =>
      MealItemLocal(
        id: id ?? this.id,
        mealClientGuid: mealClientGuid ?? this.mealClientGuid,
        foodId: foodId.present ? foodId.value : this.foodId,
        customFoodId:
            customFoodId.present ? customFoodId.value : this.customFoodId,
        quantity: quantity ?? this.quantity,
        unit: unit ?? this.unit,
      );
  MealItemLocal copyWithCompanion(MealItemsLocalCompanion data) {
    return MealItemLocal(
      id: data.id.present ? data.id.value : this.id,
      mealClientGuid: data.mealClientGuid.present
          ? data.mealClientGuid.value
          : this.mealClientGuid,
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      customFoodId: data.customFoodId.present
          ? data.customFoodId.value
          : this.customFoodId,
      quantity: data.quantity.present ? data.quantity.value : this.quantity,
      unit: data.unit.present ? data.unit.value : this.unit,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MealItemLocal(')
          ..write('id: $id, ')
          ..write('mealClientGuid: $mealClientGuid, ')
          ..write('foodId: $foodId, ')
          ..write('customFoodId: $customFoodId, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, mealClientGuid, foodId, customFoodId, quantity, unit);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MealItemLocal &&
          other.id == this.id &&
          other.mealClientGuid == this.mealClientGuid &&
          other.foodId == this.foodId &&
          other.customFoodId == this.customFoodId &&
          other.quantity == this.quantity &&
          other.unit == this.unit);
}

class MealItemsLocalCompanion extends UpdateCompanion<MealItemLocal> {
  final Value<int> id;
  final Value<String> mealClientGuid;
  final Value<String?> foodId;
  final Value<String?> customFoodId;
  final Value<double> quantity;
  final Value<String> unit;
  const MealItemsLocalCompanion({
    this.id = const Value.absent(),
    this.mealClientGuid = const Value.absent(),
    this.foodId = const Value.absent(),
    this.customFoodId = const Value.absent(),
    this.quantity = const Value.absent(),
    this.unit = const Value.absent(),
  });
  MealItemsLocalCompanion.insert({
    this.id = const Value.absent(),
    required String mealClientGuid,
    this.foodId = const Value.absent(),
    this.customFoodId = const Value.absent(),
    required double quantity,
    required String unit,
  })  : mealClientGuid = Value(mealClientGuid),
        quantity = Value(quantity),
        unit = Value(unit);
  static Insertable<MealItemLocal> custom({
    Expression<int>? id,
    Expression<String>? mealClientGuid,
    Expression<String>? foodId,
    Expression<String>? customFoodId,
    Expression<double>? quantity,
    Expression<String>? unit,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (mealClientGuid != null) 'meal_client_guid': mealClientGuid,
      if (foodId != null) 'food_id': foodId,
      if (customFoodId != null) 'custom_food_id': customFoodId,
      if (quantity != null) 'quantity': quantity,
      if (unit != null) 'unit': unit,
    });
  }

  MealItemsLocalCompanion copyWith(
      {Value<int>? id,
      Value<String>? mealClientGuid,
      Value<String?>? foodId,
      Value<String?>? customFoodId,
      Value<double>? quantity,
      Value<String>? unit}) {
    return MealItemsLocalCompanion(
      id: id ?? this.id,
      mealClientGuid: mealClientGuid ?? this.mealClientGuid,
      foodId: foodId ?? this.foodId,
      customFoodId: customFoodId ?? this.customFoodId,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (mealClientGuid.present) {
      map['meal_client_guid'] = Variable<String>(mealClientGuid.value);
    }
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (customFoodId.present) {
      map['custom_food_id'] = Variable<String>(customFoodId.value);
    }
    if (quantity.present) {
      map['quantity'] = Variable<double>(quantity.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MealItemsLocalCompanion(')
          ..write('id: $id, ')
          ..write('mealClientGuid: $mealClientGuid, ')
          ..write('foodId: $foodId, ')
          ..write('customFoodId: $customFoodId, ')
          ..write('quantity: $quantity, ')
          ..write('unit: $unit')
          ..write(')'))
        .toString();
  }
}

class $SymptomsLocalTable extends SymptomsLocal
    with TableInfo<$SymptomsLocalTable, SymptomLocal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SymptomsLocalTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _clientGuidMeta =
      const VerificationMeta('clientGuid');
  @override
  late final GeneratedColumn<String> clientGuid = GeneratedColumn<String>(
      'client_guid', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _symptomTypeMeta =
      const VerificationMeta('symptomType');
  @override
  late final GeneratedColumn<String> symptomType = GeneratedColumn<String>(
      'symptom_type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _intensityMeta =
      const VerificationMeta('intensity');
  @override
  late final GeneratedColumn<int> intensity = GeneratedColumn<int>(
      'intensity', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _occurredAtMeta =
      const VerificationMeta('occurredAt');
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
      'occurred_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _clientCreatedAtMeta =
      const VerificationMeta('clientCreatedAt');
  @override
  late final GeneratedColumn<DateTime> clientCreatedAt =
      GeneratedColumn<DateTime>('client_created_at', aliasedName, false,
          type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  late final GeneratedColumnWithTypeConverter<LocalSyncStatus, String>
      syncStatus = GeneratedColumn<String>('sync_status', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<LocalSyncStatus>(
              $SymptomsLocalTable.$convertersyncStatus);
  static const VerificationMeta _serverIdMeta =
      const VerificationMeta('serverId');
  @override
  late final GeneratedColumn<String> serverId = GeneratedColumn<String>(
      'server_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _associatedMealIdMeta =
      const VerificationMeta('associatedMealId');
  @override
  late final GeneratedColumn<String> associatedMealId = GeneratedColumn<String>(
      'associated_meal_id', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _hasMealAssociationMeta =
      const VerificationMeta('hasMealAssociation');
  @override
  late final GeneratedColumn<bool> hasMealAssociation = GeneratedColumn<bool>(
      'has_meal_association', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("has_meal_association" IN (0, 1))'));
  static const VerificationMeta _lastErrorCodeMeta =
      const VerificationMeta('lastErrorCode');
  @override
  late final GeneratedColumn<String> lastErrorCode = GeneratedColumn<String>(
      'last_error_code', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        clientGuid,
        symptomType,
        intensity,
        occurredAt,
        clientCreatedAt,
        syncStatus,
        serverId,
        associatedMealId,
        hasMealAssociation,
        lastErrorCode
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'symptoms_local';
  @override
  VerificationContext validateIntegrity(Insertable<SymptomLocal> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('client_guid')) {
      context.handle(
          _clientGuidMeta,
          clientGuid.isAcceptableOrUnknown(
              data['client_guid']!, _clientGuidMeta));
    } else if (isInserting) {
      context.missing(_clientGuidMeta);
    }
    if (data.containsKey('symptom_type')) {
      context.handle(
          _symptomTypeMeta,
          symptomType.isAcceptableOrUnknown(
              data['symptom_type']!, _symptomTypeMeta));
    } else if (isInserting) {
      context.missing(_symptomTypeMeta);
    }
    if (data.containsKey('intensity')) {
      context.handle(_intensityMeta,
          intensity.isAcceptableOrUnknown(data['intensity']!, _intensityMeta));
    } else if (isInserting) {
      context.missing(_intensityMeta);
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
          _occurredAtMeta,
          occurredAt.isAcceptableOrUnknown(
              data['occurred_at']!, _occurredAtMeta));
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    if (data.containsKey('client_created_at')) {
      context.handle(
          _clientCreatedAtMeta,
          clientCreatedAt.isAcceptableOrUnknown(
              data['client_created_at']!, _clientCreatedAtMeta));
    } else if (isInserting) {
      context.missing(_clientCreatedAtMeta);
    }
    if (data.containsKey('server_id')) {
      context.handle(_serverIdMeta,
          serverId.isAcceptableOrUnknown(data['server_id']!, _serverIdMeta));
    }
    if (data.containsKey('associated_meal_id')) {
      context.handle(
          _associatedMealIdMeta,
          associatedMealId.isAcceptableOrUnknown(
              data['associated_meal_id']!, _associatedMealIdMeta));
    }
    if (data.containsKey('has_meal_association')) {
      context.handle(
          _hasMealAssociationMeta,
          hasMealAssociation.isAcceptableOrUnknown(
              data['has_meal_association']!, _hasMealAssociationMeta));
    }
    if (data.containsKey('last_error_code')) {
      context.handle(
          _lastErrorCodeMeta,
          lastErrorCode.isAcceptableOrUnknown(
              data['last_error_code']!, _lastErrorCodeMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clientGuid};
  @override
  SymptomLocal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SymptomLocal(
      clientGuid: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}client_guid'])!,
      symptomType: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}symptom_type'])!,
      intensity: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}intensity'])!,
      occurredAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}occurred_at'])!,
      clientCreatedAt: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}client_created_at'])!,
      syncStatus: $SymptomsLocalTable.$convertersyncStatus.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}sync_status'])!),
      serverId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}server_id']),
      associatedMealId: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}associated_meal_id']),
      hasMealAssociation: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}has_meal_association']),
      lastErrorCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_error_code']),
    );
  }

  @override
  $SymptomsLocalTable createAlias(String alias) {
    return $SymptomsLocalTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LocalSyncStatus, String, String>
      $convertersyncStatus =
      const EnumNameConverter<LocalSyncStatus>(LocalSyncStatus.values);
}

class SymptomLocal extends DataClass implements Insertable<SymptomLocal> {
  final String clientGuid;

  /// Valor de contrato de `SymptomType`. Nueve valores mas `Other`.
  final String symptomType;

  /// De 1 a 100. El backend rechaza el cero (`Symptom.MinIntensity`).
  final int intensity;
  final DateTime occurredAt;
  final DateTime clientCreatedAt;
  final LocalSyncStatus syncStatus;
  final String? serverId;

  /// Comida que el **servidor** asocio dentro de la ventana de 4 horas.
  ///
  /// El cliente no la calcula (DEC-B3-06 deja el calculo del lado del
  /// servidor como autoridad), asi que queda en `null` hasta sincronizar.
  final String? associatedMealId;

  /// Lo que respondio el servidor sobre la asociacion, o `null` si la fila
  /// todavia no se sincronizo. Nullable a proposito: un `false` significaria
  /// que el servidor ya dijo que no hay comida asociada, que no es lo mismo
  /// que no haber preguntado todavia.
  final bool? hasMealAssociation;
  final String? lastErrorCode;
  const SymptomLocal(
      {required this.clientGuid,
      required this.symptomType,
      required this.intensity,
      required this.occurredAt,
      required this.clientCreatedAt,
      required this.syncStatus,
      this.serverId,
      this.associatedMealId,
      this.hasMealAssociation,
      this.lastErrorCode});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['client_guid'] = Variable<String>(clientGuid);
    map['symptom_type'] = Variable<String>(symptomType);
    map['intensity'] = Variable<int>(intensity);
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    map['client_created_at'] = Variable<DateTime>(clientCreatedAt);
    {
      map['sync_status'] = Variable<String>(
          $SymptomsLocalTable.$convertersyncStatus.toSql(syncStatus));
    }
    if (!nullToAbsent || serverId != null) {
      map['server_id'] = Variable<String>(serverId);
    }
    if (!nullToAbsent || associatedMealId != null) {
      map['associated_meal_id'] = Variable<String>(associatedMealId);
    }
    if (!nullToAbsent || hasMealAssociation != null) {
      map['has_meal_association'] = Variable<bool>(hasMealAssociation);
    }
    if (!nullToAbsent || lastErrorCode != null) {
      map['last_error_code'] = Variable<String>(lastErrorCode);
    }
    return map;
  }

  SymptomsLocalCompanion toCompanion(bool nullToAbsent) {
    return SymptomsLocalCompanion(
      clientGuid: Value(clientGuid),
      symptomType: Value(symptomType),
      intensity: Value(intensity),
      occurredAt: Value(occurredAt),
      clientCreatedAt: Value(clientCreatedAt),
      syncStatus: Value(syncStatus),
      serverId: serverId == null && nullToAbsent
          ? const Value.absent()
          : Value(serverId),
      associatedMealId: associatedMealId == null && nullToAbsent
          ? const Value.absent()
          : Value(associatedMealId),
      hasMealAssociation: hasMealAssociation == null && nullToAbsent
          ? const Value.absent()
          : Value(hasMealAssociation),
      lastErrorCode: lastErrorCode == null && nullToAbsent
          ? const Value.absent()
          : Value(lastErrorCode),
    );
  }

  factory SymptomLocal.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SymptomLocal(
      clientGuid: serializer.fromJson<String>(json['clientGuid']),
      symptomType: serializer.fromJson<String>(json['symptomType']),
      intensity: serializer.fromJson<int>(json['intensity']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
      clientCreatedAt: serializer.fromJson<DateTime>(json['clientCreatedAt']),
      syncStatus: $SymptomsLocalTable.$convertersyncStatus
          .fromJson(serializer.fromJson<String>(json['syncStatus'])),
      serverId: serializer.fromJson<String?>(json['serverId']),
      associatedMealId: serializer.fromJson<String?>(json['associatedMealId']),
      hasMealAssociation:
          serializer.fromJson<bool?>(json['hasMealAssociation']),
      lastErrorCode: serializer.fromJson<String?>(json['lastErrorCode']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clientGuid': serializer.toJson<String>(clientGuid),
      'symptomType': serializer.toJson<String>(symptomType),
      'intensity': serializer.toJson<int>(intensity),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
      'clientCreatedAt': serializer.toJson<DateTime>(clientCreatedAt),
      'syncStatus': serializer.toJson<String>(
          $SymptomsLocalTable.$convertersyncStatus.toJson(syncStatus)),
      'serverId': serializer.toJson<String?>(serverId),
      'associatedMealId': serializer.toJson<String?>(associatedMealId),
      'hasMealAssociation': serializer.toJson<bool?>(hasMealAssociation),
      'lastErrorCode': serializer.toJson<String?>(lastErrorCode),
    };
  }

  SymptomLocal copyWith(
          {String? clientGuid,
          String? symptomType,
          int? intensity,
          DateTime? occurredAt,
          DateTime? clientCreatedAt,
          LocalSyncStatus? syncStatus,
          Value<String?> serverId = const Value.absent(),
          Value<String?> associatedMealId = const Value.absent(),
          Value<bool?> hasMealAssociation = const Value.absent(),
          Value<String?> lastErrorCode = const Value.absent()}) =>
      SymptomLocal(
        clientGuid: clientGuid ?? this.clientGuid,
        symptomType: symptomType ?? this.symptomType,
        intensity: intensity ?? this.intensity,
        occurredAt: occurredAt ?? this.occurredAt,
        clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
        syncStatus: syncStatus ?? this.syncStatus,
        serverId: serverId.present ? serverId.value : this.serverId,
        associatedMealId: associatedMealId.present
            ? associatedMealId.value
            : this.associatedMealId,
        hasMealAssociation: hasMealAssociation.present
            ? hasMealAssociation.value
            : this.hasMealAssociation,
        lastErrorCode:
            lastErrorCode.present ? lastErrorCode.value : this.lastErrorCode,
      );
  SymptomLocal copyWithCompanion(SymptomsLocalCompanion data) {
    return SymptomLocal(
      clientGuid:
          data.clientGuid.present ? data.clientGuid.value : this.clientGuid,
      symptomType:
          data.symptomType.present ? data.symptomType.value : this.symptomType,
      intensity: data.intensity.present ? data.intensity.value : this.intensity,
      occurredAt:
          data.occurredAt.present ? data.occurredAt.value : this.occurredAt,
      clientCreatedAt: data.clientCreatedAt.present
          ? data.clientCreatedAt.value
          : this.clientCreatedAt,
      syncStatus:
          data.syncStatus.present ? data.syncStatus.value : this.syncStatus,
      serverId: data.serverId.present ? data.serverId.value : this.serverId,
      associatedMealId: data.associatedMealId.present
          ? data.associatedMealId.value
          : this.associatedMealId,
      hasMealAssociation: data.hasMealAssociation.present
          ? data.hasMealAssociation.value
          : this.hasMealAssociation,
      lastErrorCode: data.lastErrorCode.present
          ? data.lastErrorCode.value
          : this.lastErrorCode,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SymptomLocal(')
          ..write('clientGuid: $clientGuid, ')
          ..write('symptomType: $symptomType, ')
          ..write('intensity: $intensity, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverId: $serverId, ')
          ..write('associatedMealId: $associatedMealId, ')
          ..write('hasMealAssociation: $hasMealAssociation, ')
          ..write('lastErrorCode: $lastErrorCode')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      clientGuid,
      symptomType,
      intensity,
      occurredAt,
      clientCreatedAt,
      syncStatus,
      serverId,
      associatedMealId,
      hasMealAssociation,
      lastErrorCode);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SymptomLocal &&
          other.clientGuid == this.clientGuid &&
          other.symptomType == this.symptomType &&
          other.intensity == this.intensity &&
          other.occurredAt == this.occurredAt &&
          other.clientCreatedAt == this.clientCreatedAt &&
          other.syncStatus == this.syncStatus &&
          other.serverId == this.serverId &&
          other.associatedMealId == this.associatedMealId &&
          other.hasMealAssociation == this.hasMealAssociation &&
          other.lastErrorCode == this.lastErrorCode);
}

class SymptomsLocalCompanion extends UpdateCompanion<SymptomLocal> {
  final Value<String> clientGuid;
  final Value<String> symptomType;
  final Value<int> intensity;
  final Value<DateTime> occurredAt;
  final Value<DateTime> clientCreatedAt;
  final Value<LocalSyncStatus> syncStatus;
  final Value<String?> serverId;
  final Value<String?> associatedMealId;
  final Value<bool?> hasMealAssociation;
  final Value<String?> lastErrorCode;
  final Value<int> rowid;
  const SymptomsLocalCompanion({
    this.clientGuid = const Value.absent(),
    this.symptomType = const Value.absent(),
    this.intensity = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.clientCreatedAt = const Value.absent(),
    this.syncStatus = const Value.absent(),
    this.serverId = const Value.absent(),
    this.associatedMealId = const Value.absent(),
    this.hasMealAssociation = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SymptomsLocalCompanion.insert({
    required String clientGuid,
    required String symptomType,
    required int intensity,
    required DateTime occurredAt,
    required DateTime clientCreatedAt,
    required LocalSyncStatus syncStatus,
    this.serverId = const Value.absent(),
    this.associatedMealId = const Value.absent(),
    this.hasMealAssociation = const Value.absent(),
    this.lastErrorCode = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : clientGuid = Value(clientGuid),
        symptomType = Value(symptomType),
        intensity = Value(intensity),
        occurredAt = Value(occurredAt),
        clientCreatedAt = Value(clientCreatedAt),
        syncStatus = Value(syncStatus);
  static Insertable<SymptomLocal> custom({
    Expression<String>? clientGuid,
    Expression<String>? symptomType,
    Expression<int>? intensity,
    Expression<DateTime>? occurredAt,
    Expression<DateTime>? clientCreatedAt,
    Expression<String>? syncStatus,
    Expression<String>? serverId,
    Expression<String>? associatedMealId,
    Expression<bool>? hasMealAssociation,
    Expression<String>? lastErrorCode,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clientGuid != null) 'client_guid': clientGuid,
      if (symptomType != null) 'symptom_type': symptomType,
      if (intensity != null) 'intensity': intensity,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (clientCreatedAt != null) 'client_created_at': clientCreatedAt,
      if (syncStatus != null) 'sync_status': syncStatus,
      if (serverId != null) 'server_id': serverId,
      if (associatedMealId != null) 'associated_meal_id': associatedMealId,
      if (hasMealAssociation != null)
        'has_meal_association': hasMealAssociation,
      if (lastErrorCode != null) 'last_error_code': lastErrorCode,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SymptomsLocalCompanion copyWith(
      {Value<String>? clientGuid,
      Value<String>? symptomType,
      Value<int>? intensity,
      Value<DateTime>? occurredAt,
      Value<DateTime>? clientCreatedAt,
      Value<LocalSyncStatus>? syncStatus,
      Value<String?>? serverId,
      Value<String?>? associatedMealId,
      Value<bool?>? hasMealAssociation,
      Value<String?>? lastErrorCode,
      Value<int>? rowid}) {
    return SymptomsLocalCompanion(
      clientGuid: clientGuid ?? this.clientGuid,
      symptomType: symptomType ?? this.symptomType,
      intensity: intensity ?? this.intensity,
      occurredAt: occurredAt ?? this.occurredAt,
      clientCreatedAt: clientCreatedAt ?? this.clientCreatedAt,
      syncStatus: syncStatus ?? this.syncStatus,
      serverId: serverId ?? this.serverId,
      associatedMealId: associatedMealId ?? this.associatedMealId,
      hasMealAssociation: hasMealAssociation ?? this.hasMealAssociation,
      lastErrorCode: lastErrorCode ?? this.lastErrorCode,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clientGuid.present) {
      map['client_guid'] = Variable<String>(clientGuid.value);
    }
    if (symptomType.present) {
      map['symptom_type'] = Variable<String>(symptomType.value);
    }
    if (intensity.present) {
      map['intensity'] = Variable<int>(intensity.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (clientCreatedAt.present) {
      map['client_created_at'] = Variable<DateTime>(clientCreatedAt.value);
    }
    if (syncStatus.present) {
      map['sync_status'] = Variable<String>(
          $SymptomsLocalTable.$convertersyncStatus.toSql(syncStatus.value));
    }
    if (serverId.present) {
      map['server_id'] = Variable<String>(serverId.value);
    }
    if (associatedMealId.present) {
      map['associated_meal_id'] = Variable<String>(associatedMealId.value);
    }
    if (hasMealAssociation.present) {
      map['has_meal_association'] = Variable<bool>(hasMealAssociation.value);
    }
    if (lastErrorCode.present) {
      map['last_error_code'] = Variable<String>(lastErrorCode.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SymptomsLocalCompanion(')
          ..write('clientGuid: $clientGuid, ')
          ..write('symptomType: $symptomType, ')
          ..write('intensity: $intensity, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('clientCreatedAt: $clientCreatedAt, ')
          ..write('syncStatus: $syncStatus, ')
          ..write('serverId: $serverId, ')
          ..write('associatedMealId: $associatedMealId, ')
          ..write('hasMealAssociation: $hasMealAssociation, ')
          ..write('lastErrorCode: $lastErrorCode, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FoodCatalogCacheTable extends FoodCatalogCache
    with TableInfo<$FoodCatalogCacheTable, FoodCatalogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodCatalogCacheTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _foodIdMeta = const VerificationMeta('foodId');
  @override
  late final GeneratedColumn<String> foodId = GeneratedColumn<String>(
      'food_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameNormalizedMeta =
      const VerificationMeta('nameNormalized');
  @override
  late final GeneratedColumn<String> nameNormalized = GeneratedColumn<String>(
      'name_normalized', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _fodmapLevelMeta =
      const VerificationMeta('fodmapLevel');
  @override
  late final GeneratedColumn<String> fodmapLevel = GeneratedColumn<String>(
      'fodmap_level', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isPeruvianMeta =
      const VerificationMeta('isPeruvian');
  @override
  late final GeneratedColumn<bool> isPeruvian = GeneratedColumn<bool>(
      'is_peruvian', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("is_peruvian" IN (0, 1))'));
  static const VerificationMeta _caloriesPer100gMeta =
      const VerificationMeta('caloriesPer100g');
  @override
  late final GeneratedColumn<double> caloriesPer100g = GeneratedColumn<double>(
      'calories_per100g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _proteinGPer100gMeta =
      const VerificationMeta('proteinGPer100g');
  @override
  late final GeneratedColumn<double> proteinGPer100g = GeneratedColumn<double>(
      'protein_g_per100g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _carbsGPer100gMeta =
      const VerificationMeta('carbsGPer100g');
  @override
  late final GeneratedColumn<double> carbsGPer100g = GeneratedColumn<double>(
      'carbs_g_per100g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fatGPer100gMeta =
      const VerificationMeta('fatGPer100g');
  @override
  late final GeneratedColumn<double> fatGPer100g = GeneratedColumn<double>(
      'fat_g_per100g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fiberGPer100gMeta =
      const VerificationMeta('fiberGPer100g');
  @override
  late final GeneratedColumn<double> fiberGPer100g = GeneratedColumn<double>(
      'fiber_g_per100g', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fodmapTagsMeta =
      const VerificationMeta('fodmapTags');
  @override
  late final GeneratedColumn<String> fodmapTags = GeneratedColumn<String>(
      'fodmap_tags', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        foodId,
        name,
        nameNormalized,
        category,
        fodmapLevel,
        isPeruvian,
        caloriesPer100g,
        proteinGPer100g,
        carbsGPer100g,
        fatGPer100g,
        fiberGPer100g,
        fodmapTags
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_catalog_cache';
  @override
  VerificationContext validateIntegrity(Insertable<FoodCatalogEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('food_id')) {
      context.handle(_foodIdMeta,
          foodId.isAcceptableOrUnknown(data['food_id']!, _foodIdMeta));
    } else if (isInserting) {
      context.missing(_foodIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('name_normalized')) {
      context.handle(
          _nameNormalizedMeta,
          nameNormalized.isAcceptableOrUnknown(
              data['name_normalized']!, _nameNormalizedMeta));
    } else if (isInserting) {
      context.missing(_nameNormalizedMeta);
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('fodmap_level')) {
      context.handle(
          _fodmapLevelMeta,
          fodmapLevel.isAcceptableOrUnknown(
              data['fodmap_level']!, _fodmapLevelMeta));
    } else if (isInserting) {
      context.missing(_fodmapLevelMeta);
    }
    if (data.containsKey('is_peruvian')) {
      context.handle(
          _isPeruvianMeta,
          isPeruvian.isAcceptableOrUnknown(
              data['is_peruvian']!, _isPeruvianMeta));
    } else if (isInserting) {
      context.missing(_isPeruvianMeta);
    }
    if (data.containsKey('calories_per100g')) {
      context.handle(
          _caloriesPer100gMeta,
          caloriesPer100g.isAcceptableOrUnknown(
              data['calories_per100g']!, _caloriesPer100gMeta));
    }
    if (data.containsKey('protein_g_per100g')) {
      context.handle(
          _proteinGPer100gMeta,
          proteinGPer100g.isAcceptableOrUnknown(
              data['protein_g_per100g']!, _proteinGPer100gMeta));
    }
    if (data.containsKey('carbs_g_per100g')) {
      context.handle(
          _carbsGPer100gMeta,
          carbsGPer100g.isAcceptableOrUnknown(
              data['carbs_g_per100g']!, _carbsGPer100gMeta));
    }
    if (data.containsKey('fat_g_per100g')) {
      context.handle(
          _fatGPer100gMeta,
          fatGPer100g.isAcceptableOrUnknown(
              data['fat_g_per100g']!, _fatGPer100gMeta));
    }
    if (data.containsKey('fiber_g_per100g')) {
      context.handle(
          _fiberGPer100gMeta,
          fiberGPer100g.isAcceptableOrUnknown(
              data['fiber_g_per100g']!, _fiberGPer100gMeta));
    }
    if (data.containsKey('fodmap_tags')) {
      context.handle(
          _fodmapTagsMeta,
          fodmapTags.isAcceptableOrUnknown(
              data['fodmap_tags']!, _fodmapTagsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {foodId};
  @override
  FoodCatalogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodCatalogEntry(
      foodId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}food_id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      nameNormalized: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}name_normalized'])!,
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      fodmapLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fodmap_level'])!,
      isPeruvian: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_peruvian'])!,
      caloriesPer100g: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}calories_per100g']),
      proteinGPer100g: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}protein_g_per100g']),
      carbsGPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs_g_per100g']),
      fatGPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat_g_per100g']),
      fiberGPer100g: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fiber_g_per100g']),
      fodmapTags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}fodmap_tags']),
    );
  }

  @override
  $FoodCatalogCacheTable createAlias(String alias) {
    return $FoodCatalogCacheTable(attachedDatabase, alias);
  }
}

class FoodCatalogEntry extends DataClass
    implements Insertable<FoodCatalogEntry> {
  /// UUID que asigna el servidor.
  ///
  /// **No es estable entre bases de datos distintas**: el seeder los genera con
  /// `Guid.NewGuid()` y solo es idempotente por nombre, de modo que resetear la
  /// base del backend los cambia todos. En el piloto no pasa; en desarrollo si,
  /// y por eso una comida offline puede volver del lote con
  /// `food_item_not_found`.
  final String foodId;
  final String name;

  /// [name] en minusculas y sin diacriticos, precomputado al escribir la fila.
  ///
  /// Normalizar el catalogo entero en cada pulsacion seria recorrer 928 filas
  /// por tecla. Con la columna lista, buscar es un `LIKE` sobre un indice.
  final String nameNormalized;
  final String category;

  /// Valor de contrato de `FodmapLevel`: `Low`, `Moderate`, `High`.
  final String fodmapLevel;
  final bool isPeruvian;
  final double? caloriesPer100g;
  final double? proteinGPer100g;
  final double? carbsGPer100g;
  final double? fatGPer100g;
  final double? fiberGPer100g;

  /// Etiquetas FODMAP separadas por coma (`fructans`, `lactose,polyols`).
  final String? fodmapTags;
  const FoodCatalogEntry(
      {required this.foodId,
      required this.name,
      required this.nameNormalized,
      required this.category,
      required this.fodmapLevel,
      required this.isPeruvian,
      this.caloriesPer100g,
      this.proteinGPer100g,
      this.carbsGPer100g,
      this.fatGPer100g,
      this.fiberGPer100g,
      this.fodmapTags});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['food_id'] = Variable<String>(foodId);
    map['name'] = Variable<String>(name);
    map['name_normalized'] = Variable<String>(nameNormalized);
    map['category'] = Variable<String>(category);
    map['fodmap_level'] = Variable<String>(fodmapLevel);
    map['is_peruvian'] = Variable<bool>(isPeruvian);
    if (!nullToAbsent || caloriesPer100g != null) {
      map['calories_per100g'] = Variable<double>(caloriesPer100g);
    }
    if (!nullToAbsent || proteinGPer100g != null) {
      map['protein_g_per100g'] = Variable<double>(proteinGPer100g);
    }
    if (!nullToAbsent || carbsGPer100g != null) {
      map['carbs_g_per100g'] = Variable<double>(carbsGPer100g);
    }
    if (!nullToAbsent || fatGPer100g != null) {
      map['fat_g_per100g'] = Variable<double>(fatGPer100g);
    }
    if (!nullToAbsent || fiberGPer100g != null) {
      map['fiber_g_per100g'] = Variable<double>(fiberGPer100g);
    }
    if (!nullToAbsent || fodmapTags != null) {
      map['fodmap_tags'] = Variable<String>(fodmapTags);
    }
    return map;
  }

  FoodCatalogCacheCompanion toCompanion(bool nullToAbsent) {
    return FoodCatalogCacheCompanion(
      foodId: Value(foodId),
      name: Value(name),
      nameNormalized: Value(nameNormalized),
      category: Value(category),
      fodmapLevel: Value(fodmapLevel),
      isPeruvian: Value(isPeruvian),
      caloriesPer100g: caloriesPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(caloriesPer100g),
      proteinGPer100g: proteinGPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(proteinGPer100g),
      carbsGPer100g: carbsGPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(carbsGPer100g),
      fatGPer100g: fatGPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(fatGPer100g),
      fiberGPer100g: fiberGPer100g == null && nullToAbsent
          ? const Value.absent()
          : Value(fiberGPer100g),
      fodmapTags: fodmapTags == null && nullToAbsent
          ? const Value.absent()
          : Value(fodmapTags),
    );
  }

  factory FoodCatalogEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodCatalogEntry(
      foodId: serializer.fromJson<String>(json['foodId']),
      name: serializer.fromJson<String>(json['name']),
      nameNormalized: serializer.fromJson<String>(json['nameNormalized']),
      category: serializer.fromJson<String>(json['category']),
      fodmapLevel: serializer.fromJson<String>(json['fodmapLevel']),
      isPeruvian: serializer.fromJson<bool>(json['isPeruvian']),
      caloriesPer100g: serializer.fromJson<double?>(json['caloriesPer100g']),
      proteinGPer100g: serializer.fromJson<double?>(json['proteinGPer100g']),
      carbsGPer100g: serializer.fromJson<double?>(json['carbsGPer100g']),
      fatGPer100g: serializer.fromJson<double?>(json['fatGPer100g']),
      fiberGPer100g: serializer.fromJson<double?>(json['fiberGPer100g']),
      fodmapTags: serializer.fromJson<String?>(json['fodmapTags']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'foodId': serializer.toJson<String>(foodId),
      'name': serializer.toJson<String>(name),
      'nameNormalized': serializer.toJson<String>(nameNormalized),
      'category': serializer.toJson<String>(category),
      'fodmapLevel': serializer.toJson<String>(fodmapLevel),
      'isPeruvian': serializer.toJson<bool>(isPeruvian),
      'caloriesPer100g': serializer.toJson<double?>(caloriesPer100g),
      'proteinGPer100g': serializer.toJson<double?>(proteinGPer100g),
      'carbsGPer100g': serializer.toJson<double?>(carbsGPer100g),
      'fatGPer100g': serializer.toJson<double?>(fatGPer100g),
      'fiberGPer100g': serializer.toJson<double?>(fiberGPer100g),
      'fodmapTags': serializer.toJson<String?>(fodmapTags),
    };
  }

  FoodCatalogEntry copyWith(
          {String? foodId,
          String? name,
          String? nameNormalized,
          String? category,
          String? fodmapLevel,
          bool? isPeruvian,
          Value<double?> caloriesPer100g = const Value.absent(),
          Value<double?> proteinGPer100g = const Value.absent(),
          Value<double?> carbsGPer100g = const Value.absent(),
          Value<double?> fatGPer100g = const Value.absent(),
          Value<double?> fiberGPer100g = const Value.absent(),
          Value<String?> fodmapTags = const Value.absent()}) =>
      FoodCatalogEntry(
        foodId: foodId ?? this.foodId,
        name: name ?? this.name,
        nameNormalized: nameNormalized ?? this.nameNormalized,
        category: category ?? this.category,
        fodmapLevel: fodmapLevel ?? this.fodmapLevel,
        isPeruvian: isPeruvian ?? this.isPeruvian,
        caloriesPer100g: caloriesPer100g.present
            ? caloriesPer100g.value
            : this.caloriesPer100g,
        proteinGPer100g: proteinGPer100g.present
            ? proteinGPer100g.value
            : this.proteinGPer100g,
        carbsGPer100g:
            carbsGPer100g.present ? carbsGPer100g.value : this.carbsGPer100g,
        fatGPer100g: fatGPer100g.present ? fatGPer100g.value : this.fatGPer100g,
        fiberGPer100g:
            fiberGPer100g.present ? fiberGPer100g.value : this.fiberGPer100g,
        fodmapTags: fodmapTags.present ? fodmapTags.value : this.fodmapTags,
      );
  FoodCatalogEntry copyWithCompanion(FoodCatalogCacheCompanion data) {
    return FoodCatalogEntry(
      foodId: data.foodId.present ? data.foodId.value : this.foodId,
      name: data.name.present ? data.name.value : this.name,
      nameNormalized: data.nameNormalized.present
          ? data.nameNormalized.value
          : this.nameNormalized,
      category: data.category.present ? data.category.value : this.category,
      fodmapLevel:
          data.fodmapLevel.present ? data.fodmapLevel.value : this.fodmapLevel,
      isPeruvian:
          data.isPeruvian.present ? data.isPeruvian.value : this.isPeruvian,
      caloriesPer100g: data.caloriesPer100g.present
          ? data.caloriesPer100g.value
          : this.caloriesPer100g,
      proteinGPer100g: data.proteinGPer100g.present
          ? data.proteinGPer100g.value
          : this.proteinGPer100g,
      carbsGPer100g: data.carbsGPer100g.present
          ? data.carbsGPer100g.value
          : this.carbsGPer100g,
      fatGPer100g:
          data.fatGPer100g.present ? data.fatGPer100g.value : this.fatGPer100g,
      fiberGPer100g: data.fiberGPer100g.present
          ? data.fiberGPer100g.value
          : this.fiberGPer100g,
      fodmapTags:
          data.fodmapTags.present ? data.fodmapTags.value : this.fodmapTags,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodCatalogEntry(')
          ..write('foodId: $foodId, ')
          ..write('name: $name, ')
          ..write('nameNormalized: $nameNormalized, ')
          ..write('category: $category, ')
          ..write('fodmapLevel: $fodmapLevel, ')
          ..write('isPeruvian: $isPeruvian, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinGPer100g: $proteinGPer100g, ')
          ..write('carbsGPer100g: $carbsGPer100g, ')
          ..write('fatGPer100g: $fatGPer100g, ')
          ..write('fiberGPer100g: $fiberGPer100g, ')
          ..write('fodmapTags: $fodmapTags')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      foodId,
      name,
      nameNormalized,
      category,
      fodmapLevel,
      isPeruvian,
      caloriesPer100g,
      proteinGPer100g,
      carbsGPer100g,
      fatGPer100g,
      fiberGPer100g,
      fodmapTags);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodCatalogEntry &&
          other.foodId == this.foodId &&
          other.name == this.name &&
          other.nameNormalized == this.nameNormalized &&
          other.category == this.category &&
          other.fodmapLevel == this.fodmapLevel &&
          other.isPeruvian == this.isPeruvian &&
          other.caloriesPer100g == this.caloriesPer100g &&
          other.proteinGPer100g == this.proteinGPer100g &&
          other.carbsGPer100g == this.carbsGPer100g &&
          other.fatGPer100g == this.fatGPer100g &&
          other.fiberGPer100g == this.fiberGPer100g &&
          other.fodmapTags == this.fodmapTags);
}

class FoodCatalogCacheCompanion extends UpdateCompanion<FoodCatalogEntry> {
  final Value<String> foodId;
  final Value<String> name;
  final Value<String> nameNormalized;
  final Value<String> category;
  final Value<String> fodmapLevel;
  final Value<bool> isPeruvian;
  final Value<double?> caloriesPer100g;
  final Value<double?> proteinGPer100g;
  final Value<double?> carbsGPer100g;
  final Value<double?> fatGPer100g;
  final Value<double?> fiberGPer100g;
  final Value<String?> fodmapTags;
  final Value<int> rowid;
  const FoodCatalogCacheCompanion({
    this.foodId = const Value.absent(),
    this.name = const Value.absent(),
    this.nameNormalized = const Value.absent(),
    this.category = const Value.absent(),
    this.fodmapLevel = const Value.absent(),
    this.isPeruvian = const Value.absent(),
    this.caloriesPer100g = const Value.absent(),
    this.proteinGPer100g = const Value.absent(),
    this.carbsGPer100g = const Value.absent(),
    this.fatGPer100g = const Value.absent(),
    this.fiberGPer100g = const Value.absent(),
    this.fodmapTags = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FoodCatalogCacheCompanion.insert({
    required String foodId,
    required String name,
    required String nameNormalized,
    required String category,
    required String fodmapLevel,
    required bool isPeruvian,
    this.caloriesPer100g = const Value.absent(),
    this.proteinGPer100g = const Value.absent(),
    this.carbsGPer100g = const Value.absent(),
    this.fatGPer100g = const Value.absent(),
    this.fiberGPer100g = const Value.absent(),
    this.fodmapTags = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : foodId = Value(foodId),
        name = Value(name),
        nameNormalized = Value(nameNormalized),
        category = Value(category),
        fodmapLevel = Value(fodmapLevel),
        isPeruvian = Value(isPeruvian);
  static Insertable<FoodCatalogEntry> custom({
    Expression<String>? foodId,
    Expression<String>? name,
    Expression<String>? nameNormalized,
    Expression<String>? category,
    Expression<String>? fodmapLevel,
    Expression<bool>? isPeruvian,
    Expression<double>? caloriesPer100g,
    Expression<double>? proteinGPer100g,
    Expression<double>? carbsGPer100g,
    Expression<double>? fatGPer100g,
    Expression<double>? fiberGPer100g,
    Expression<String>? fodmapTags,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (foodId != null) 'food_id': foodId,
      if (name != null) 'name': name,
      if (nameNormalized != null) 'name_normalized': nameNormalized,
      if (category != null) 'category': category,
      if (fodmapLevel != null) 'fodmap_level': fodmapLevel,
      if (isPeruvian != null) 'is_peruvian': isPeruvian,
      if (caloriesPer100g != null) 'calories_per100g': caloriesPer100g,
      if (proteinGPer100g != null) 'protein_g_per100g': proteinGPer100g,
      if (carbsGPer100g != null) 'carbs_g_per100g': carbsGPer100g,
      if (fatGPer100g != null) 'fat_g_per100g': fatGPer100g,
      if (fiberGPer100g != null) 'fiber_g_per100g': fiberGPer100g,
      if (fodmapTags != null) 'fodmap_tags': fodmapTags,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FoodCatalogCacheCompanion copyWith(
      {Value<String>? foodId,
      Value<String>? name,
      Value<String>? nameNormalized,
      Value<String>? category,
      Value<String>? fodmapLevel,
      Value<bool>? isPeruvian,
      Value<double?>? caloriesPer100g,
      Value<double?>? proteinGPer100g,
      Value<double?>? carbsGPer100g,
      Value<double?>? fatGPer100g,
      Value<double?>? fiberGPer100g,
      Value<String?>? fodmapTags,
      Value<int>? rowid}) {
    return FoodCatalogCacheCompanion(
      foodId: foodId ?? this.foodId,
      name: name ?? this.name,
      nameNormalized: nameNormalized ?? this.nameNormalized,
      category: category ?? this.category,
      fodmapLevel: fodmapLevel ?? this.fodmapLevel,
      isPeruvian: isPeruvian ?? this.isPeruvian,
      caloriesPer100g: caloriesPer100g ?? this.caloriesPer100g,
      proteinGPer100g: proteinGPer100g ?? this.proteinGPer100g,
      carbsGPer100g: carbsGPer100g ?? this.carbsGPer100g,
      fatGPer100g: fatGPer100g ?? this.fatGPer100g,
      fiberGPer100g: fiberGPer100g ?? this.fiberGPer100g,
      fodmapTags: fodmapTags ?? this.fodmapTags,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (foodId.present) {
      map['food_id'] = Variable<String>(foodId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (nameNormalized.present) {
      map['name_normalized'] = Variable<String>(nameNormalized.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (fodmapLevel.present) {
      map['fodmap_level'] = Variable<String>(fodmapLevel.value);
    }
    if (isPeruvian.present) {
      map['is_peruvian'] = Variable<bool>(isPeruvian.value);
    }
    if (caloriesPer100g.present) {
      map['calories_per100g'] = Variable<double>(caloriesPer100g.value);
    }
    if (proteinGPer100g.present) {
      map['protein_g_per100g'] = Variable<double>(proteinGPer100g.value);
    }
    if (carbsGPer100g.present) {
      map['carbs_g_per100g'] = Variable<double>(carbsGPer100g.value);
    }
    if (fatGPer100g.present) {
      map['fat_g_per100g'] = Variable<double>(fatGPer100g.value);
    }
    if (fiberGPer100g.present) {
      map['fiber_g_per100g'] = Variable<double>(fiberGPer100g.value);
    }
    if (fodmapTags.present) {
      map['fodmap_tags'] = Variable<String>(fodmapTags.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodCatalogCacheCompanion(')
          ..write('foodId: $foodId, ')
          ..write('name: $name, ')
          ..write('nameNormalized: $nameNormalized, ')
          ..write('category: $category, ')
          ..write('fodmapLevel: $fodmapLevel, ')
          ..write('isPeruvian: $isPeruvian, ')
          ..write('caloriesPer100g: $caloriesPer100g, ')
          ..write('proteinGPer100g: $proteinGPer100g, ')
          ..write('carbsGPer100g: $carbsGPer100g, ')
          ..write('fatGPer100g: $fatGPer100g, ')
          ..write('fiberGPer100g: $fiberGPer100g, ')
          ..write('fodmapTags: $fodmapTags, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MealsLocalTable mealsLocal = $MealsLocalTable(this);
  late final $MealItemsLocalTable mealItemsLocal = $MealItemsLocalTable(this);
  late final $SymptomsLocalTable symptomsLocal = $SymptomsLocalTable(this);
  late final $FoodCatalogCacheTable foodCatalogCache =
      $FoodCatalogCacheTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [mealsLocal, mealItemsLocal, symptomsLocal, foodCatalogCache];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('meals_local',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('meal_items_local', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$MealsLocalTableCreateCompanionBuilder = MealsLocalCompanion Function({
  required String clientGuid,
  required String mealTime,
  required DateTime consumedAt,
  required DateTime clientCreatedAt,
  required LocalSyncStatus syncStatus,
  Value<String?> serverId,
  Value<String?> lastErrorCode,
  Value<int> rowid,
});
typedef $$MealsLocalTableUpdateCompanionBuilder = MealsLocalCompanion Function({
  Value<String> clientGuid,
  Value<String> mealTime,
  Value<DateTime> consumedAt,
  Value<DateTime> clientCreatedAt,
  Value<LocalSyncStatus> syncStatus,
  Value<String?> serverId,
  Value<String?> lastErrorCode,
  Value<int> rowid,
});

final class $$MealsLocalTableReferences
    extends BaseReferences<_$AppDatabase, $MealsLocalTable, MealLocal> {
  $$MealsLocalTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$MealItemsLocalTable, List<MealItemLocal>>
      _mealItemsLocalRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.mealItemsLocal,
              aliasName: $_aliasNameGenerator(
                  db.mealsLocal.clientGuid, db.mealItemsLocal.mealClientGuid));

  $$MealItemsLocalTableProcessedTableManager get mealItemsLocalRefs {
    final manager = $$MealItemsLocalTableTableManager($_db, $_db.mealItemsLocal)
        .filter((f) => f.mealClientGuid.clientGuid
            .sqlEquals($_itemColumn<String>('client_guid')!));

    final cache = $_typedResult.readTableOrNull(_mealItemsLocalRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$MealsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $MealsLocalTable> {
  $$MealsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientGuid => $composableBuilder(
      column: $table.clientGuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get mealTime => $composableBuilder(
      column: $table.mealTime, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get consumedAt => $composableBuilder(
      column: $table.consumedAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<LocalSyncStatus, LocalSyncStatus, String>
      get syncStatus => $composableBuilder(
          column: $table.syncStatus,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get serverId => $composableBuilder(
      column: $table.serverId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastErrorCode => $composableBuilder(
      column: $table.lastErrorCode, builder: (column) => ColumnFilters(column));

  Expression<bool> mealItemsLocalRefs(
      Expression<bool> Function($$MealItemsLocalTableFilterComposer f) f) {
    final $$MealItemsLocalTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientGuid,
        referencedTable: $db.mealItemsLocal,
        getReferencedColumn: (t) => t.mealClientGuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MealItemsLocalTableFilterComposer(
              $db: $db,
              $table: $db.mealItemsLocal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MealsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $MealsLocalTable> {
  $$MealsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientGuid => $composableBuilder(
      column: $table.clientGuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get mealTime => $composableBuilder(
      column: $table.mealTime, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get consumedAt => $composableBuilder(
      column: $table.consumedAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serverId => $composableBuilder(
      column: $table.serverId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastErrorCode => $composableBuilder(
      column: $table.lastErrorCode,
      builder: (column) => ColumnOrderings(column));
}

class $$MealsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealsLocalTable> {
  $$MealsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientGuid => $composableBuilder(
      column: $table.clientGuid, builder: (column) => column);

  GeneratedColumn<String> get mealTime =>
      $composableBuilder(column: $table.mealTime, builder: (column) => column);

  GeneratedColumn<DateTime> get consumedAt => $composableBuilder(
      column: $table.consumedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalSyncStatus, String> get syncStatus =>
      $composableBuilder(
          column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get lastErrorCode => $composableBuilder(
      column: $table.lastErrorCode, builder: (column) => column);

  Expression<T> mealItemsLocalRefs<T extends Object>(
      Expression<T> Function($$MealItemsLocalTableAnnotationComposer a) f) {
    final $$MealItemsLocalTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clientGuid,
        referencedTable: $db.mealItemsLocal,
        getReferencedColumn: (t) => t.mealClientGuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MealItemsLocalTableAnnotationComposer(
              $db: $db,
              $table: $db.mealItemsLocal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$MealsLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MealsLocalTable,
    MealLocal,
    $$MealsLocalTableFilterComposer,
    $$MealsLocalTableOrderingComposer,
    $$MealsLocalTableAnnotationComposer,
    $$MealsLocalTableCreateCompanionBuilder,
    $$MealsLocalTableUpdateCompanionBuilder,
    (MealLocal, $$MealsLocalTableReferences),
    MealLocal,
    PrefetchHooks Function({bool mealItemsLocalRefs})> {
  $$MealsLocalTableTableManager(_$AppDatabase db, $MealsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> clientGuid = const Value.absent(),
            Value<String> mealTime = const Value.absent(),
            Value<DateTime> consumedAt = const Value.absent(),
            Value<DateTime> clientCreatedAt = const Value.absent(),
            Value<LocalSyncStatus> syncStatus = const Value.absent(),
            Value<String?> serverId = const Value.absent(),
            Value<String?> lastErrorCode = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MealsLocalCompanion(
            clientGuid: clientGuid,
            mealTime: mealTime,
            consumedAt: consumedAt,
            clientCreatedAt: clientCreatedAt,
            syncStatus: syncStatus,
            serverId: serverId,
            lastErrorCode: lastErrorCode,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String clientGuid,
            required String mealTime,
            required DateTime consumedAt,
            required DateTime clientCreatedAt,
            required LocalSyncStatus syncStatus,
            Value<String?> serverId = const Value.absent(),
            Value<String?> lastErrorCode = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              MealsLocalCompanion.insert(
            clientGuid: clientGuid,
            mealTime: mealTime,
            consumedAt: consumedAt,
            clientCreatedAt: clientCreatedAt,
            syncStatus: syncStatus,
            serverId: serverId,
            lastErrorCode: lastErrorCode,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MealsLocalTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({mealItemsLocalRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (mealItemsLocalRefs) db.mealItemsLocal
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (mealItemsLocalRefs)
                    await $_getPrefetchedData<MealLocal, $MealsLocalTable,
                            MealItemLocal>(
                        currentTable: table,
                        referencedTable: $$MealsLocalTableReferences
                            ._mealItemsLocalRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$MealsLocalTableReferences(db, table, p0)
                                .mealItemsLocalRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems.where(
                                (e) => e.mealClientGuid == item.clientGuid),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$MealsLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MealsLocalTable,
    MealLocal,
    $$MealsLocalTableFilterComposer,
    $$MealsLocalTableOrderingComposer,
    $$MealsLocalTableAnnotationComposer,
    $$MealsLocalTableCreateCompanionBuilder,
    $$MealsLocalTableUpdateCompanionBuilder,
    (MealLocal, $$MealsLocalTableReferences),
    MealLocal,
    PrefetchHooks Function({bool mealItemsLocalRefs})>;
typedef $$MealItemsLocalTableCreateCompanionBuilder = MealItemsLocalCompanion
    Function({
  Value<int> id,
  required String mealClientGuid,
  Value<String?> foodId,
  Value<String?> customFoodId,
  required double quantity,
  required String unit,
});
typedef $$MealItemsLocalTableUpdateCompanionBuilder = MealItemsLocalCompanion
    Function({
  Value<int> id,
  Value<String> mealClientGuid,
  Value<String?> foodId,
  Value<String?> customFoodId,
  Value<double> quantity,
  Value<String> unit,
});

final class $$MealItemsLocalTableReferences
    extends BaseReferences<_$AppDatabase, $MealItemsLocalTable, MealItemLocal> {
  $$MealItemsLocalTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $MealsLocalTable _mealClientGuidTable(_$AppDatabase db) =>
      db.mealsLocal.createAlias($_aliasNameGenerator(
          db.mealItemsLocal.mealClientGuid, db.mealsLocal.clientGuid));

  $$MealsLocalTableProcessedTableManager get mealClientGuid {
    final $_column = $_itemColumn<String>('meal_client_guid')!;

    final manager = $$MealsLocalTableTableManager($_db, $_db.mealsLocal)
        .filter((f) => f.clientGuid.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_mealClientGuidTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$MealItemsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $MealItemsLocalTable> {
  $$MealItemsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get customFoodId => $composableBuilder(
      column: $table.customFoodId, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnFilters(column));

  $$MealsLocalTableFilterComposer get mealClientGuid {
    final $$MealsLocalTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.mealClientGuid,
        referencedTable: $db.mealsLocal,
        getReferencedColumn: (t) => t.clientGuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MealsLocalTableFilterComposer(
              $db: $db,
              $table: $db.mealsLocal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MealItemsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $MealItemsLocalTable> {
  $$MealItemsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get customFoodId => $composableBuilder(
      column: $table.customFoodId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get quantity => $composableBuilder(
      column: $table.quantity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get unit => $composableBuilder(
      column: $table.unit, builder: (column) => ColumnOrderings(column));

  $$MealsLocalTableOrderingComposer get mealClientGuid {
    final $$MealsLocalTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.mealClientGuid,
        referencedTable: $db.mealsLocal,
        getReferencedColumn: (t) => t.clientGuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MealsLocalTableOrderingComposer(
              $db: $db,
              $table: $db.mealsLocal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MealItemsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $MealItemsLocalTable> {
  $$MealItemsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<String> get customFoodId => $composableBuilder(
      column: $table.customFoodId, builder: (column) => column);

  GeneratedColumn<double> get quantity =>
      $composableBuilder(column: $table.quantity, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  $$MealsLocalTableAnnotationComposer get mealClientGuid {
    final $$MealsLocalTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.mealClientGuid,
        referencedTable: $db.mealsLocal,
        getReferencedColumn: (t) => t.clientGuid,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$MealsLocalTableAnnotationComposer(
              $db: $db,
              $table: $db.mealsLocal,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$MealItemsLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MealItemsLocalTable,
    MealItemLocal,
    $$MealItemsLocalTableFilterComposer,
    $$MealItemsLocalTableOrderingComposer,
    $$MealItemsLocalTableAnnotationComposer,
    $$MealItemsLocalTableCreateCompanionBuilder,
    $$MealItemsLocalTableUpdateCompanionBuilder,
    (MealItemLocal, $$MealItemsLocalTableReferences),
    MealItemLocal,
    PrefetchHooks Function({bool mealClientGuid})> {
  $$MealItemsLocalTableTableManager(
      _$AppDatabase db, $MealItemsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MealItemsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MealItemsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MealItemsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> mealClientGuid = const Value.absent(),
            Value<String?> foodId = const Value.absent(),
            Value<String?> customFoodId = const Value.absent(),
            Value<double> quantity = const Value.absent(),
            Value<String> unit = const Value.absent(),
          }) =>
              MealItemsLocalCompanion(
            id: id,
            mealClientGuid: mealClientGuid,
            foodId: foodId,
            customFoodId: customFoodId,
            quantity: quantity,
            unit: unit,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String mealClientGuid,
            Value<String?> foodId = const Value.absent(),
            Value<String?> customFoodId = const Value.absent(),
            required double quantity,
            required String unit,
          }) =>
              MealItemsLocalCompanion.insert(
            id: id,
            mealClientGuid: mealClientGuid,
            foodId: foodId,
            customFoodId: customFoodId,
            quantity: quantity,
            unit: unit,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$MealItemsLocalTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({mealClientGuid = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (mealClientGuid) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.mealClientGuid,
                    referencedTable: $$MealItemsLocalTableReferences
                        ._mealClientGuidTable(db),
                    referencedColumn: $$MealItemsLocalTableReferences
                        ._mealClientGuidTable(db)
                        .clientGuid,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$MealItemsLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $MealItemsLocalTable,
    MealItemLocal,
    $$MealItemsLocalTableFilterComposer,
    $$MealItemsLocalTableOrderingComposer,
    $$MealItemsLocalTableAnnotationComposer,
    $$MealItemsLocalTableCreateCompanionBuilder,
    $$MealItemsLocalTableUpdateCompanionBuilder,
    (MealItemLocal, $$MealItemsLocalTableReferences),
    MealItemLocal,
    PrefetchHooks Function({bool mealClientGuid})>;
typedef $$SymptomsLocalTableCreateCompanionBuilder = SymptomsLocalCompanion
    Function({
  required String clientGuid,
  required String symptomType,
  required int intensity,
  required DateTime occurredAt,
  required DateTime clientCreatedAt,
  required LocalSyncStatus syncStatus,
  Value<String?> serverId,
  Value<String?> associatedMealId,
  Value<bool?> hasMealAssociation,
  Value<String?> lastErrorCode,
  Value<int> rowid,
});
typedef $$SymptomsLocalTableUpdateCompanionBuilder = SymptomsLocalCompanion
    Function({
  Value<String> clientGuid,
  Value<String> symptomType,
  Value<int> intensity,
  Value<DateTime> occurredAt,
  Value<DateTime> clientCreatedAt,
  Value<LocalSyncStatus> syncStatus,
  Value<String?> serverId,
  Value<String?> associatedMealId,
  Value<bool?> hasMealAssociation,
  Value<String?> lastErrorCode,
  Value<int> rowid,
});

class $$SymptomsLocalTableFilterComposer
    extends Composer<_$AppDatabase, $SymptomsLocalTable> {
  $$SymptomsLocalTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clientGuid => $composableBuilder(
      column: $table.clientGuid, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get symptomType => $composableBuilder(
      column: $table.symptomType, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get intensity => $composableBuilder(
      column: $table.intensity, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<LocalSyncStatus, LocalSyncStatus, String>
      get syncStatus => $composableBuilder(
          column: $table.syncStatus,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get serverId => $composableBuilder(
      column: $table.serverId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get associatedMealId => $composableBuilder(
      column: $table.associatedMealId,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get hasMealAssociation => $composableBuilder(
      column: $table.hasMealAssociation,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastErrorCode => $composableBuilder(
      column: $table.lastErrorCode, builder: (column) => ColumnFilters(column));
}

class $$SymptomsLocalTableOrderingComposer
    extends Composer<_$AppDatabase, $SymptomsLocalTable> {
  $$SymptomsLocalTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clientGuid => $composableBuilder(
      column: $table.clientGuid, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get symptomType => $composableBuilder(
      column: $table.symptomType, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get intensity => $composableBuilder(
      column: $table.intensity, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get syncStatus => $composableBuilder(
      column: $table.syncStatus, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get serverId => $composableBuilder(
      column: $table.serverId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get associatedMealId => $composableBuilder(
      column: $table.associatedMealId,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get hasMealAssociation => $composableBuilder(
      column: $table.hasMealAssociation,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastErrorCode => $composableBuilder(
      column: $table.lastErrorCode,
      builder: (column) => ColumnOrderings(column));
}

class $$SymptomsLocalTableAnnotationComposer
    extends Composer<_$AppDatabase, $SymptomsLocalTable> {
  $$SymptomsLocalTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clientGuid => $composableBuilder(
      column: $table.clientGuid, builder: (column) => column);

  GeneratedColumn<String> get symptomType => $composableBuilder(
      column: $table.symptomType, builder: (column) => column);

  GeneratedColumn<int> get intensity =>
      $composableBuilder(column: $table.intensity, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
      column: $table.occurredAt, builder: (column) => column);

  GeneratedColumn<DateTime> get clientCreatedAt => $composableBuilder(
      column: $table.clientCreatedAt, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LocalSyncStatus, String> get syncStatus =>
      $composableBuilder(
          column: $table.syncStatus, builder: (column) => column);

  GeneratedColumn<String> get serverId =>
      $composableBuilder(column: $table.serverId, builder: (column) => column);

  GeneratedColumn<String> get associatedMealId => $composableBuilder(
      column: $table.associatedMealId, builder: (column) => column);

  GeneratedColumn<bool> get hasMealAssociation => $composableBuilder(
      column: $table.hasMealAssociation, builder: (column) => column);

  GeneratedColumn<String> get lastErrorCode => $composableBuilder(
      column: $table.lastErrorCode, builder: (column) => column);
}

class $$SymptomsLocalTableTableManager extends RootTableManager<
    _$AppDatabase,
    $SymptomsLocalTable,
    SymptomLocal,
    $$SymptomsLocalTableFilterComposer,
    $$SymptomsLocalTableOrderingComposer,
    $$SymptomsLocalTableAnnotationComposer,
    $$SymptomsLocalTableCreateCompanionBuilder,
    $$SymptomsLocalTableUpdateCompanionBuilder,
    (
      SymptomLocal,
      BaseReferences<_$AppDatabase, $SymptomsLocalTable, SymptomLocal>
    ),
    SymptomLocal,
    PrefetchHooks Function()> {
  $$SymptomsLocalTableTableManager(_$AppDatabase db, $SymptomsLocalTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SymptomsLocalTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SymptomsLocalTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SymptomsLocalTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> clientGuid = const Value.absent(),
            Value<String> symptomType = const Value.absent(),
            Value<int> intensity = const Value.absent(),
            Value<DateTime> occurredAt = const Value.absent(),
            Value<DateTime> clientCreatedAt = const Value.absent(),
            Value<LocalSyncStatus> syncStatus = const Value.absent(),
            Value<String?> serverId = const Value.absent(),
            Value<String?> associatedMealId = const Value.absent(),
            Value<bool?> hasMealAssociation = const Value.absent(),
            Value<String?> lastErrorCode = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SymptomsLocalCompanion(
            clientGuid: clientGuid,
            symptomType: symptomType,
            intensity: intensity,
            occurredAt: occurredAt,
            clientCreatedAt: clientCreatedAt,
            syncStatus: syncStatus,
            serverId: serverId,
            associatedMealId: associatedMealId,
            hasMealAssociation: hasMealAssociation,
            lastErrorCode: lastErrorCode,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String clientGuid,
            required String symptomType,
            required int intensity,
            required DateTime occurredAt,
            required DateTime clientCreatedAt,
            required LocalSyncStatus syncStatus,
            Value<String?> serverId = const Value.absent(),
            Value<String?> associatedMealId = const Value.absent(),
            Value<bool?> hasMealAssociation = const Value.absent(),
            Value<String?> lastErrorCode = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              SymptomsLocalCompanion.insert(
            clientGuid: clientGuid,
            symptomType: symptomType,
            intensity: intensity,
            occurredAt: occurredAt,
            clientCreatedAt: clientCreatedAt,
            syncStatus: syncStatus,
            serverId: serverId,
            associatedMealId: associatedMealId,
            hasMealAssociation: hasMealAssociation,
            lastErrorCode: lastErrorCode,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$SymptomsLocalTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $SymptomsLocalTable,
    SymptomLocal,
    $$SymptomsLocalTableFilterComposer,
    $$SymptomsLocalTableOrderingComposer,
    $$SymptomsLocalTableAnnotationComposer,
    $$SymptomsLocalTableCreateCompanionBuilder,
    $$SymptomsLocalTableUpdateCompanionBuilder,
    (
      SymptomLocal,
      BaseReferences<_$AppDatabase, $SymptomsLocalTable, SymptomLocal>
    ),
    SymptomLocal,
    PrefetchHooks Function()>;
typedef $$FoodCatalogCacheTableCreateCompanionBuilder
    = FoodCatalogCacheCompanion Function({
  required String foodId,
  required String name,
  required String nameNormalized,
  required String category,
  required String fodmapLevel,
  required bool isPeruvian,
  Value<double?> caloriesPer100g,
  Value<double?> proteinGPer100g,
  Value<double?> carbsGPer100g,
  Value<double?> fatGPer100g,
  Value<double?> fiberGPer100g,
  Value<String?> fodmapTags,
  Value<int> rowid,
});
typedef $$FoodCatalogCacheTableUpdateCompanionBuilder
    = FoodCatalogCacheCompanion Function({
  Value<String> foodId,
  Value<String> name,
  Value<String> nameNormalized,
  Value<String> category,
  Value<String> fodmapLevel,
  Value<bool> isPeruvian,
  Value<double?> caloriesPer100g,
  Value<double?> proteinGPer100g,
  Value<double?> carbsGPer100g,
  Value<double?> fatGPer100g,
  Value<double?> fiberGPer100g,
  Value<String?> fodmapTags,
  Value<int> rowid,
});

class $$FoodCatalogCacheTableFilterComposer
    extends Composer<_$AppDatabase, $FoodCatalogCacheTable> {
  $$FoodCatalogCacheTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nameNormalized => $composableBuilder(
      column: $table.nameNormalized,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fodmapLevel => $composableBuilder(
      column: $table.fodmapLevel, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isPeruvian => $composableBuilder(
      column: $table.isPeruvian, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get caloriesPer100g => $composableBuilder(
      column: $table.caloriesPer100g,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get proteinGPer100g => $composableBuilder(
      column: $table.proteinGPer100g,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbsGPer100g => $composableBuilder(
      column: $table.carbsGPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fatGPer100g => $composableBuilder(
      column: $table.fatGPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fiberGPer100g => $composableBuilder(
      column: $table.fiberGPer100g, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fodmapTags => $composableBuilder(
      column: $table.fodmapTags, builder: (column) => ColumnFilters(column));
}

class $$FoodCatalogCacheTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodCatalogCacheTable> {
  $$FoodCatalogCacheTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get foodId => $composableBuilder(
      column: $table.foodId, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nameNormalized => $composableBuilder(
      column: $table.nameNormalized,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fodmapLevel => $composableBuilder(
      column: $table.fodmapLevel, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isPeruvian => $composableBuilder(
      column: $table.isPeruvian, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get caloriesPer100g => $composableBuilder(
      column: $table.caloriesPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get proteinGPer100g => $composableBuilder(
      column: $table.proteinGPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbsGPer100g => $composableBuilder(
      column: $table.carbsGPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fatGPer100g => $composableBuilder(
      column: $table.fatGPer100g, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fiberGPer100g => $composableBuilder(
      column: $table.fiberGPer100g,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fodmapTags => $composableBuilder(
      column: $table.fodmapTags, builder: (column) => ColumnOrderings(column));
}

class $$FoodCatalogCacheTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodCatalogCacheTable> {
  $$FoodCatalogCacheTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get foodId =>
      $composableBuilder(column: $table.foodId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get nameNormalized => $composableBuilder(
      column: $table.nameNormalized, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get fodmapLevel => $composableBuilder(
      column: $table.fodmapLevel, builder: (column) => column);

  GeneratedColumn<bool> get isPeruvian => $composableBuilder(
      column: $table.isPeruvian, builder: (column) => column);

  GeneratedColumn<double> get caloriesPer100g => $composableBuilder(
      column: $table.caloriesPer100g, builder: (column) => column);

  GeneratedColumn<double> get proteinGPer100g => $composableBuilder(
      column: $table.proteinGPer100g, builder: (column) => column);

  GeneratedColumn<double> get carbsGPer100g => $composableBuilder(
      column: $table.carbsGPer100g, builder: (column) => column);

  GeneratedColumn<double> get fatGPer100g => $composableBuilder(
      column: $table.fatGPer100g, builder: (column) => column);

  GeneratedColumn<double> get fiberGPer100g => $composableBuilder(
      column: $table.fiberGPer100g, builder: (column) => column);

  GeneratedColumn<String> get fodmapTags => $composableBuilder(
      column: $table.fodmapTags, builder: (column) => column);
}

class $$FoodCatalogCacheTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodCatalogCacheTable,
    FoodCatalogEntry,
    $$FoodCatalogCacheTableFilterComposer,
    $$FoodCatalogCacheTableOrderingComposer,
    $$FoodCatalogCacheTableAnnotationComposer,
    $$FoodCatalogCacheTableCreateCompanionBuilder,
    $$FoodCatalogCacheTableUpdateCompanionBuilder,
    (
      FoodCatalogEntry,
      BaseReferences<_$AppDatabase, $FoodCatalogCacheTable, FoodCatalogEntry>
    ),
    FoodCatalogEntry,
    PrefetchHooks Function()> {
  $$FoodCatalogCacheTableTableManager(
      _$AppDatabase db, $FoodCatalogCacheTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodCatalogCacheTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodCatalogCacheTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodCatalogCacheTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> foodId = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> nameNormalized = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<String> fodmapLevel = const Value.absent(),
            Value<bool> isPeruvian = const Value.absent(),
            Value<double?> caloriesPer100g = const Value.absent(),
            Value<double?> proteinGPer100g = const Value.absent(),
            Value<double?> carbsGPer100g = const Value.absent(),
            Value<double?> fatGPer100g = const Value.absent(),
            Value<double?> fiberGPer100g = const Value.absent(),
            Value<String?> fodmapTags = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FoodCatalogCacheCompanion(
            foodId: foodId,
            name: name,
            nameNormalized: nameNormalized,
            category: category,
            fodmapLevel: fodmapLevel,
            isPeruvian: isPeruvian,
            caloriesPer100g: caloriesPer100g,
            proteinGPer100g: proteinGPer100g,
            carbsGPer100g: carbsGPer100g,
            fatGPer100g: fatGPer100g,
            fiberGPer100g: fiberGPer100g,
            fodmapTags: fodmapTags,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String foodId,
            required String name,
            required String nameNormalized,
            required String category,
            required String fodmapLevel,
            required bool isPeruvian,
            Value<double?> caloriesPer100g = const Value.absent(),
            Value<double?> proteinGPer100g = const Value.absent(),
            Value<double?> carbsGPer100g = const Value.absent(),
            Value<double?> fatGPer100g = const Value.absent(),
            Value<double?> fiberGPer100g = const Value.absent(),
            Value<String?> fodmapTags = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              FoodCatalogCacheCompanion.insert(
            foodId: foodId,
            name: name,
            nameNormalized: nameNormalized,
            category: category,
            fodmapLevel: fodmapLevel,
            isPeruvian: isPeruvian,
            caloriesPer100g: caloriesPer100g,
            proteinGPer100g: proteinGPer100g,
            carbsGPer100g: carbsGPer100g,
            fatGPer100g: fatGPer100g,
            fiberGPer100g: fiberGPer100g,
            fodmapTags: fodmapTags,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoodCatalogCacheTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodCatalogCacheTable,
    FoodCatalogEntry,
    $$FoodCatalogCacheTableFilterComposer,
    $$FoodCatalogCacheTableOrderingComposer,
    $$FoodCatalogCacheTableAnnotationComposer,
    $$FoodCatalogCacheTableCreateCompanionBuilder,
    $$FoodCatalogCacheTableUpdateCompanionBuilder,
    (
      FoodCatalogEntry,
      BaseReferences<_$AppDatabase, $FoodCatalogCacheTable, FoodCatalogEntry>
    ),
    FoodCatalogEntry,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MealsLocalTableTableManager get mealsLocal =>
      $$MealsLocalTableTableManager(_db, _db.mealsLocal);
  $$MealItemsLocalTableTableManager get mealItemsLocal =>
      $$MealItemsLocalTableTableManager(_db, _db.mealItemsLocal);
  $$SymptomsLocalTableTableManager get symptomsLocal =>
      $$SymptomsLocalTableTableManager(_db, _db.symptomsLocal);
  $$FoodCatalogCacheTableTableManager get foodCatalogCache =>
      $$FoodCatalogCacheTableTableManager(_db, _db.foodCatalogCache);
}
