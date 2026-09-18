import 'dart:async';

import 'package:cauce_mobile/core/database/app_database.dart';
import 'package:cauce_mobile/core/database/local_sync_status.dart';
import 'package:cauce_mobile/core/sync/connectivity_monitor.dart';
import 'package:drift/drift.dart';

/// Fuente de conectividad controlada por el test.
///
/// Evita el plugin real y su canal de plataforma, que en `flutter test` no
/// existe. Permite ademas provocar una reconexion en el momento exacto.
class FakeConnectivityMonitor implements ConnectivityMonitor {
  FakeConnectivityMonitor({this.online = true});

  bool online;

  final StreamController<void> _reconnections =
      StreamController<void>.broadcast();

  /// Simula que el dispositivo recupero conexion.
  void emitReconnection() {
    online = true;
    _reconnections.add(null);
  }

  Future<void> dispose() => _reconnections.close();

  @override
  Future<bool> isOnline() async => online;

  @override
  Stream<void> onReconnected() => _reconnections.stream;
}

/// Inserta una comida pendiente con un item, como la que deja el registro sin
/// conexion de HU0009 CA02.
Future<void> insertPendingMeal(
  AppDatabase db,
  String clientGuid, {
  String mealTime = 'Lunch',
  String foodId = 'aaaaaaaa-aaaa-4aaa-8aaa-aaaaaaaaaaaa',
  DateTime? clientCreatedAt,
  LocalSyncStatus status = LocalSyncStatus.pending,
}) async {
  final createdAt = clientCreatedAt ?? DateTime.utc(2026, 9, 18, 13, 35);

  await db.into(db.mealsLocal).insert(
        MealsLocalCompanion.insert(
          clientGuid: clientGuid,
          mealTime: mealTime,
          consumedAt: createdAt.subtract(const Duration(minutes: 5)),
          clientCreatedAt: createdAt,
          syncStatus: status,
        ),
      );

  await db.into(db.mealItemsLocal).insert(
        MealItemsLocalCompanion.insert(
          mealClientGuid: clientGuid,
          quantity: 150,
          unit: 'Grams',
          foodId: Value<String?>(foodId),
        ),
      );
}

/// Inserta un sintoma pendiente, como el que deja el registro sin conexion de
/// HU0011.
Future<void> insertPendingSymptom(
  AppDatabase db,
  String clientGuid, {
  String symptomType = 'Bloating',
  int intensity = 40,
  DateTime? clientCreatedAt,
  LocalSyncStatus status = LocalSyncStatus.pending,
}) {
  final createdAt = clientCreatedAt ?? DateTime.utc(2026, 9, 18, 15);

  return db.into(db.symptomsLocal).insert(
        SymptomsLocalCompanion.insert(
          clientGuid: clientGuid,
          symptomType: symptomType,
          intensity: intensity,
          occurredAt: createdAt.subtract(const Duration(minutes: 10)),
          clientCreatedAt: createdAt,
          syncStatus: status,
        ),
      );
}
