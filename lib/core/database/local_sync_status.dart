/// Estado de sincronizacion de una fila registrada en el dispositivo.
///
/// **Es contabilidad interna del cliente y nunca viaja al servidor.** El
/// `SyncStatus` del contrato tiene dos valores (`SyncPending`,
/// `SyncCompleted`) y sigue teniendo dos: [failed] existe solo aca.
///
/// El tercer valor resuelve un atasco concreto. `POST /sync/batch` clasifica
/// cada item en aceptado, duplicado o con error, y varios de esos errores son
/// permanentes: un `food_item_not_found` o un `invalid_meal_registration` no
/// mejoran por reintentar. Sin un estado terminal, esas filas volverian en
/// cada reconexion, para siempre, engordando un lote que siempre falla.
enum LocalSyncStatus {
  /// Registrada en el dispositivo, todavia no aceptada por el servidor.
  pending,

  /// El servidor la acepto, o ya la tenia. En los dos casos el dato clinico
  /// esta a salvo del lado del servidor.
  completed,

  /// El servidor la rechazo por un motivo que no mejora con el reintento.
  ///
  /// Se le muestra al paciente con un estado visual distinto del de [pending],
  /// con su explicacion y una accion de descartar. Sin esa salida el atasco
  /// solo se volveria visible en vez de resolverse.
  failed,
}
