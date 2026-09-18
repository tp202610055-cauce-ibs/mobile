/// Decide si un `errorCode` que devolvio el lote tiene arreglo por reintento.
///
/// `POST /sync/batch` clasifica cada item en aceptado, duplicado o con error, y
/// devuelve un `errorCode` por cada error. Tratarlos a todos igual tiene un
/// costo concreto: los permanentes volverian en cada reconexion, para siempre,
/// engordando un lote que siempre falla. Tratarlos a todos como terminales
/// tiene el costo opuesto, perder un registro clinico por un 500 pasajero.
abstract final class SyncFailurePolicy {
  /// Codigos que no mejoran por reintentar.
  ///
  /// Los cuatro describen una carga que el servidor nunca va a aceptar tal como
  /// esta:
  ///
  /// - `food_item_not_found` y `custom_food_not_found`: la fila referencia algo
  ///   que del lado del servidor no existe. Pasa cuando el alimento se
  ///   desactiva, y en desarrollo cada vez que se resetea la base, porque el
  ///   seeder genera los identificadores con `Guid.NewGuid()` y solo es
  ///   idempotente por nombre.
  /// - `validation_error`: FluentValidation rechazo la forma del payload.
  /// - `invalid_meal_registration`: lo lanza `Meal.Register` sobre siete
  ///   invariantes, todas de forma del payload. Las dos que miran fechas
  ///   toleran 5 minutos de desfase de reloj, asi que un dispositivo levemente
  ///   adelantado no cae aca.
  ///
  /// Todo lo demas se considera pasajero. La lista es deliberadamente corta: es
  /// la que decide descartar un registro clinico, y ante la duda conviene
  /// reintentar de mas y no de menos.
  static const Set<String> permanentCodes = <String>{
    'food_item_not_found',
    'custom_food_not_found',
    'validation_error',
    'invalid_meal_registration',
  };

  /// `true` si la fila debe pasar a un estado terminal en vez de reintentar.
  ///
  /// Un `errorCode` ausente o desconocido se trata como pasajero: si el backend
  /// agrega un codigo nuevo, la fila espera en vez de descartarse sola.
  static bool isPermanent(String? errorCode) {
    return errorCode != null && permanentCodes.contains(errorCode);
  }
}
