import 'package:drift/drift.dart';

import '../local_sync_status.dart';

/// Tablas locales del registro clinico diario (EP0002), esquema v2.
///
/// **Los enums se guardan con su valor de contrato**, en PascalCase, tal como
/// el backend los serializa (`Breakfast`, `AbdominalPain`, `Grams`). No con el
/// nombre del enum de Dart. La razon: estas filas son un area de preparacion
/// del payload que va a `POST /sync/batch`, y guardarlas ya en la forma que
/// viaja evita una tabla de traduccion que se desincronice con el contrato.
/// La conversion a los enums del dominio ocurre en la capa de datos.
///
/// **Sin tabla `sync_operations`.** Cada tabla lleva su propia
/// [LocalSyncStatus] y el worker consulta directo con `WHERE sync_status =
/// 'pending'`. Una tabla menos que mantener consistente con las otras dos.
///
/// **Sin cifrado en reposo.** Estas filas son datos de salud bajo la Ley N.°
/// 29733 y viven en el mismo sqlite sin cifrar de siempre, protegidas solo por
/// el sandboxing del sistema operativo. El comentario de `AppDatabase`
/// explicaba por que el token de sesion no vive aca; nunca fue una decision
/// tomada a proposito sobre el dato clinico, que hasta este bloque no existia
/// en disco. Queda pendiente resolverlo antes de que el piloto real en el
/// Complejo Hospitalario Guillermo Kaelin de la Fuente corra con pacientes
/// reales y no solo con datos de prueba.

/// Comidas registradas en el dispositivo (US09).
@DataClassName('MealLocal')
class MealsLocal extends Table {
  /// UUID v4 generado en el dispositivo. Es la clave de idempotencia que el
  /// backend usa para deduplicar, asi que se genera **una sola vez** y el
  /// reintento la repite intacta. Reusarla con otra carga da 409
  /// `idempotency_mismatch`.
  TextColumn get clientGuid => text()();

  /// Valor de contrato de `MealTime`: `Breakfast`, `Lunch`, `Dinner`, `Snack`.
  TextColumn get mealTime => text()();

  /// Momento en que el paciente comio.
  DateTimeColumn get consumedAt => dateTime()();

  /// Momento en que el registro se creo en el dispositivo.
  ///
  /// El servidor lo valida contra su propio reloj con 5 minutos de tolerancia,
  /// y ademas es el ancla de la ventana de 4 horas al asociar sintomas.
  DateTimeColumn get clientCreatedAt => dateTime()();

  TextColumn get syncStatus => textEnum<LocalSyncStatus>()();

  /// Identificador que asigno el servidor, disponible recien tras sincronizar.
  ///
  /// Mientras sea `null` la fila no puede recibir notas de contexto: US13 exige
  /// un `mealId` del servidor.
  TextColumn get serverId => text().nullable()();

  /// Ultimo `errorCode` que devolvio el lote para esta fila.
  TextColumn get lastErrorCode => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{clientGuid};
}

/// Items de una comida local. Entre 1 y 50, como exige `Meal.Register`.
///
/// Tabla hija y no una columna JSON: cada item lleva la invariante de
/// referenciar **exactamente uno** de [foodId] o [customFoodId], y esconder una
/// referencia clinica dentro de un blob la dejaria invisible para cualquier
/// consulta o migracion futura.
@DataClassName('MealItemLocal')
class MealItemsLocal extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get mealClientGuid =>
      text().references(MealsLocal, #clientGuid, onDelete: KeyAction.cascade)();

  /// Alimento del catalogo. Excluyente con [customFoodId].
  TextColumn get foodId => text().nullable()();

  /// Plato personalizado del paciente. Excluyente con [foodId].
  ///
  /// Un plato personalizado no se puede crear sin conexion (`POST
  /// /custom-foods` no entra al lote de sincronizacion), asi que una comida
  /// offline solo puede referenciar uno que ya existe en el servidor.
  TextColumn get customFoodId => text().nullable()();

  RealColumn get quantity => real()();

  /// Valor de contrato de `MeasurementUnit`: `Grams`, `Cups`, `Units`,
  /// `Ounces`, `Tablespoons`.
  TextColumn get unit => text()();
}

/// Sintomas registrados en el dispositivo (US11).
@DataClassName('SymptomLocal')
class SymptomsLocal extends Table {
  TextColumn get clientGuid => text()();

  /// Valor de contrato de `SymptomType`. Nueve valores mas `Other`.
  TextColumn get symptomType => text()();

  /// De 1 a 100. El backend rechaza el cero (`Symptom.MinIntensity`).
  IntColumn get intensity => integer()();

  DateTimeColumn get occurredAt => dateTime()();

  DateTimeColumn get clientCreatedAt => dateTime()();

  TextColumn get syncStatus => textEnum<LocalSyncStatus>()();

  TextColumn get serverId => text().nullable()();

  /// Comida que el **servidor** asocio dentro de la ventana de 4 horas.
  ///
  /// El cliente no la calcula (DEC-B3-06 deja el calculo del lado del
  /// servidor como autoridad), asi que queda en `null` hasta sincronizar.
  TextColumn get associatedMealId => text().nullable()();

  /// Lo que respondio el servidor sobre la asociacion, o `null` si la fila
  /// todavia no se sincronizo. Nullable a proposito: un `false` significaria
  /// que el servidor ya dijo que no hay comida asociada, que no es lo mismo
  /// que no haber preguntado todavia.
  BoolColumn get hasMealAssociation => boolean().nullable()();

  TextColumn get lastErrorCode => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{clientGuid};
}

/// Copia local del catalogo de alimentos, para que la busqueda funcione sin
/// red (HU0009 CA02 y CA03, CP023).
///
/// Se reemplaza entera al arrancar la sesion y al recuperar conexion. Hoy son
/// 26 filas; el seeder del backend apunta a las ~928 de TPCA-CENAN (TS12), y
/// aun asi un reemplazo completo sigue siendo barato.
@DataClassName('FoodCatalogEntry')
class FoodCatalogCache extends Table {
  /// UUID que asigna el servidor.
  ///
  /// **No es estable entre bases de datos distintas**: el seeder los genera con
  /// `Guid.NewGuid()` y solo es idempotente por nombre, de modo que resetear la
  /// base del backend los cambia todos. En el piloto no pasa; en desarrollo si,
  /// y por eso una comida offline puede volver del lote con
  /// `food_item_not_found`.
  TextColumn get foodId => text()();

  TextColumn get name => text()();

  /// [name] en minusculas y sin diacriticos, precomputado al escribir la fila.
  ///
  /// Normalizar el catalogo entero en cada pulsacion seria recorrer 928 filas
  /// por tecla. Con la columna lista, buscar es un `LIKE` sobre un indice.
  TextColumn get nameNormalized => text()();

  TextColumn get category => text()();

  /// Valor de contrato de `FodmapLevel`: `Low`, `Moderate`, `High`.
  TextColumn get fodmapLevel => text()();

  BoolColumn get isPeruvian => boolean()();

  // Los seis campos que solo trae `FoodItemDetail`. El listado, la busqueda y
  // las sugerencias devuelven `FoodItemSummary`, que no los incluye, asi que se
  // completan de forma oportunista cuando el paciente abre el detalle de un
  // alimento. HU0010 los necesita para estimar el perfil nutricional del plato.

  RealColumn get caloriesPer100g => real().nullable()();
  RealColumn get proteinGPer100g => real().nullable()();
  RealColumn get carbsGPer100g => real().nullable()();
  RealColumn get fatGPer100g => real().nullable()();
  RealColumn get fiberGPer100g => real().nullable()();

  /// Etiquetas FODMAP separadas por coma (`fructans`, `lactose,polyols`).
  TextColumn get fodmapTags => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{foodId};
}
