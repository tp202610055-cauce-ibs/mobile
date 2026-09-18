import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/sync/connectivity_monitor.dart';
import '../../foods/domain/food_item.dart';
import '../data/meals_local_store.dart';
import '../data/meals_repository.dart';
import '../domain/meal_draft.dart';

part 'meal_form_notifier.freezed.dart';
part 'meal_form_notifier.g.dart';

/// Como termino el registro de una comida.
enum MealSubmitOutcome {
  /// El servidor la acepto en el momento.
  registered,

  /// Quedo guardada en el dispositivo, esperando conexion (CA02, CP023).
  queuedOffline,

  /// El servidor la rechazo. El formulario conserva lo cargado.
  rejected,
}

/// Estado del formulario de registro de comida (US09).
@freezed
abstract class MealFormState with _$MealFormState {
  const factory MealFormState({
    @Default(MealDraft()) MealDraft draft,
    @Default(false) bool submitting,

    /// Resultado del ultimo envio, o `null` si todavia no se envio.
    MealSubmitOutcome? outcome,

    /// Carga FODMAP que devolvio el servidor, cuando hubo conexion.
    FodmapLoad? aggregatedFodmap,
    CauceApiError? error,
  }) = _MealFormState;

  const MealFormState._();

  /// Motivos que bloquean el envio (CA04).
  List<MealDraftIssue> get issues => draft.issues();

  /// `true` cuando la comida se puede registrar.
  bool get canSubmit => draft.canSubmit() && !submitting;
}

/// Gobierna el armado y el envio de una comida.
///
/// **Con conexion o sin ella, la comida se guarda siempre en el dispositivo.**
/// Con red se manda ademas al servidor y la fila local queda como sincronizada;
/// sin red queda pendiente y la sube el worker. Asi el historial local muestra
/// lo mismo en los dos casos y el paciente no ve sus registros aparecer y
/// desaparecer segun la cobertura.
@riverpod
class MealFormNotifier extends _$MealFormNotifier {
  @override
  MealFormState build() => const MealFormState();

  void selectMealTime(MealTimeOption mealTime) {
    state = state.copyWith(
      draft: state.draft.copyWith(mealTime: mealTime),
      error: null,
    );
  }

  void setConsumedAt(DateTime consumedAt) {
    state = state.copyWith(
      draft: state.draft.copyWith(consumedAt: consumedAt),
      error: null,
    );
  }

  void addItem(MealItemDraft item) {
    state = state.copyWith(
      draft: state.draft.withItem(item),
      error: null,
    );
  }

  /// Quita un alimento de la comida.
  ///
  /// **No limpia el resto del formulario** (CA04): el momento del dia y los
  /// otros alimentos siguen donde estaban.
  void removeItemAt(int index) {
    state = state.copyWith(draft: state.draft.withoutItemAt(index));
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  /// Registra la comida. Devuelve `true` si el dato quedo a salvo.
  ///
  /// Que el servidor la rechace es lo unico que cuenta como fracaso: quedar en
  /// la cola offline **no** lo es, porque el registro esta guardado y el worker
  /// lo sube en cuanto vuelva la red.
  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    state = state.copyWith(submitting: true, error: null);

    final draft = state.draft;
    final localStore = ref.read(mealsLocalStoreProvider);

    if (!await ref.read(connectivityMonitorProvider).isOnline()) {
      await localStore.enqueue(draft);
      state = state.copyWith(
        submitting: false,
        outcome: MealSubmitOutcome.queuedOffline,
      );
      return true;
    }

    // El `client_guid` se genera al escribir la fila local y es el mismo que
    // viaja al servidor: si la respuesta se pierde, el reintento repite ese
    // UUID y el backend deduplica en vez de crear una segunda comida.
    final clientGuid = await localStore.enqueue(draft);

    try {
      final created = await ref
          .read(mealsRepositoryProvider)
          .create(draft, clientGuid: clientGuid);

      await localStore.markSynced(clientGuid, created.mealId);

      state = state.copyWith(
        submitting: false,
        outcome: MealSubmitOutcome.registered,
        aggregatedFodmap: created.aggregatedFodmap,
      );
      return true;
    } on CauceApiError catch (error) {
      // La fila local queda pendiente a proposito. El paciente ya anoto lo que
      // comio y perder eso por un fallo del servidor seria lo peor que puede
      // pasar en un registro clinico; el worker reintenta, y si el motivo es
      // permanente la fila pasa a `failed` con su salida de descarte.
      state = state.copyWith(
        submitting: false,
        outcome: MealSubmitOutcome.rejected,
        error: error,
      );
      return false;
    }
  }

  /// Vacia el formulario para registrar otra comida.
  void reset() {
    state = const MealFormState();
  }
}
