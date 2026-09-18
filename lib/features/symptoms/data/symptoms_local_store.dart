import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/database/app_database_provider.dart';
import '../../../core/database/local_sync_status.dart';
import '../domain/symptom_draft.dart';

part 'symptoms_local_store.g.dart';

/// Escribe en el dispositivo los sintomas que el paciente registra sin conexion
/// (US11, mismo patron que las comidas de HU0009 CA02).
class SymptomsLocalStore {
  const SymptomsLocalStore(this._db, this._uuid);

  final AppDatabase _db;
  final Uuid _uuid;

  /// Guarda el sintoma como pendiente y devuelve su `client_guid`.
  ///
  /// El UUID v4 se genera en el dispositivo y una sola vez: es la clave con la
  /// que el backend deduplica, y el reintento tiene que repetirla intacta.
  Future<String> enqueue(SymptomDraft draft, {DateTime? now}) async {
    final clientGuid = _uuid.v4();
    final createdAt = (now ?? DateTime.now()).toUtc();
    final symptomType = draft.symptomType;
    final intensity = draft.intensity;

    if (symptomType == null || intensity == null) {
      throw StateError(
        'El sintoma exige tipo e intensidad. La pantalla ya lo bloquea antes '
        'de llegar aca.',
      );
    }

    await _db.into(_db.symptomsLocal).insert(
          SymptomsLocalCompanion.insert(
            clientGuid: clientGuid,
            symptomType: symptomType.wireValue,
            intensity: intensity,
            occurredAt: (draft.occurredAt ?? createdAt).toUtc(),
            clientCreatedAt: createdAt,
            syncStatus: LocalSyncStatus.pending,
          ),
        );

    return clientGuid;
  }

  /// Cierra una fila local que el servidor ya acepto, con lo que respondio
  /// sobre la ventana de 4 horas.
  Future<void> markSynced(
    String clientGuid, {
    required String serverId,
    String? associatedMealId,
    required bool hasMealAssociation,
  }) {
    return (_db.update(_db.symptomsLocal)
          ..where((row) => row.clientGuid.equals(clientGuid)))
        .write(
      SymptomsLocalCompanion(
        syncStatus: const Value<LocalSyncStatus>(LocalSyncStatus.completed),
        serverId: Value<String?>(serverId),
        associatedMealId: Value<String?>(associatedMealId),
        hasMealAssociation: Value<bool?>(hasMealAssociation),
        lastErrorCode: const Value<String?>(null),
      ),
    );
  }

  /// Sintomas locales, del mas reciente al mas viejo.
  Future<List<SymptomLocal>> recent({int limit = 50}) {
    return (_db.select(_db.symptomsLocal)
          ..orderBy(<OrderClauseGenerator<$SymptomsLocalTable>>[
            (row) => OrderingTerm.desc(row.clientCreatedAt),
          ])
          ..limit(limit))
        .get();
  }
}

@Riverpod(keepAlive: true)
SymptomsLocalStore symptomsLocalStore(Ref ref) {
  return SymptomsLocalStore(ref.watch(appDatabaseProvider), const Uuid());
}
