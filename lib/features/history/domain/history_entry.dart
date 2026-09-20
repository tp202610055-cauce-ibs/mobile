import 'package:freezed_annotation/freezed_annotation.dart';

import '../../foods/domain/food_item.dart';
import '../../meals/domain/meal_draft.dart';
import '../../symptoms/domain/symptom_draft.dart';

part 'history_entry.freezed.dart';

/// Estado de una entrada del historial frente al servidor.
///
/// Espeja `LocalSyncStatus` en lo que le importa a la pantalla, sin arrastrar
/// el tipo de drift hasta la capa de presentacion.
enum HistoryEntrySyncState {
  /// Ya esta en el servidor. Es la unica que admite una nota (US13).
  synced,

  /// Registrada en el dispositivo, esperando conexion.
  pending,

  /// El servidor la rechazo por algo que no mejora reintentando.
  failed,
}

/// Que clase de registro es la entrada.
enum HistoryEntryKind { meal, symptom }

/// Una entrada del historial del paciente.
///
/// **No viene de `GET /api/v1/history`.** Ese endpoint existe, pero el contrato
/// aplana su jerarquia polimorfica a `{occurredAt}` con
/// `additionalProperties: false`, y el cliente generado descarta el payload en
/// silencio: devuelve una lista de fechas vacias. El historial se compone aca a
/// partir de `GET /meals` y `GET /symptoms`, que si devuelven tipos completos,
/// mas lo que todavia no salio del dispositivo.
@freezed
abstract class HistoryEntry with _$HistoryEntry {
  const factory HistoryEntry({
    required HistoryEntryKind kind,
    required DateTime occurredAt,
    required HistoryEntrySyncState syncState,

    /// Identificador del servidor. `null` mientras no se haya sincronizado.
    String? serverId,

    /// Identificador local, para poder descartar una fila rechazada.
    String? clientGuid,

    /// `errorCode` del ultimo rechazo, si lo hubo.
    String? lastErrorCode,

    // Datos de una comida.
    MealTimeOption? mealTime,
    FodmapLoad? aggregatedFodmap,
    @Default(<String>[]) List<String> itemNames,

    // Datos de un sintoma.
    SymptomTypeOption? symptomType,
    int? intensity,
    bool? hasMealAssociation,

    /// Momento de comida con la que el **servidor** asocio este sintoma.
    ///
    /// El cliente no calcula la ventana de cuatro horas: la resuelve el
    /// backend (DEC-B3-06) y aca solo se muestra lo confirmado. Se resuelve
    /// cruzando `associatedMealId` contra las comidas del mismo rango, que ya
    /// vienen en la misma composicion del historial.
    MealTimeOption? associatedMealTime,

    /// Cuanto paso entre la comida asociada y el sintoma.
    Duration? associatedMealDelay,
  }) = _HistoryEntry;

  const HistoryEntry._();

  /// `true` si el paciente puede adjuntarle una nota de contexto (US13).
  ///
  /// `CreateClinicalNoteRequest` exige un `mealId` o un `symptomId` **del
  /// servidor**. Una fila que todavia no sincronizo no lo tiene, asi que
  /// ofrecer la accion llevaria a un 404 despues de escribir la nota.
  bool get acceptsNote =>
      syncState == HistoryEntrySyncState.synced && serverId != null;

  /// `true` si la fila quedo trabada y espera que el paciente la descarte.
  bool get isDiscardable => syncState == HistoryEntrySyncState.failed;
}
