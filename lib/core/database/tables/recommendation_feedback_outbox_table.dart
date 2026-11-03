import 'package:drift/drift.dart';

import '../local_sync_status.dart';

/// Respuestas a recomendaciones guardadas sin conexion, a la espera de envio.
///
/// Una fila por recomendacion y se borra al llegar al servidor: solo guarda
/// `pending` o `failed`. La carga es la que viaja, sin recalcular nada.
@DataClassName('RecommendationFeedbackOutboxRow')
class RecommendationFeedbackOutbox extends Table {
  /// El backend admite una sola respuesta por recomendacion.
  TextColumn get recommendationId => text()();

  /// Cuenta que respondio. Otra cuenta en el mismo telefono no la ve.
  TextColumn get userId => text()();

  /// Se genera una vez y se repite intacta en cada reintento.
  TextColumn get idempotencyKey => text()();

  BoolColumn get wasApplied => boolean()();

  /// Valor de contrato de `FeedbackOutcome`: `Improvement`, `NoChange`,
  /// `Worsening`.
  TextColumn get outcome => text()();

  /// Ya recortado, o `null` si quedo vacio.
  TextColumn get comment => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  TextColumn get status => textEnum<LocalSyncStatus>()();

  /// Codigo del ultimo rechazo, para explicar una fila `failed`.
  TextColumn get lastErrorCode => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{recommendationId};
}
