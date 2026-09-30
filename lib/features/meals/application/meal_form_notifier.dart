import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

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
  ///
  /// Tambien cuando habia red pero el envio no llego al servidor: la fila ya
  /// estaba guardada y el worker la sube despues (acta M50).
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

    /// `client_guid` de esta comida: se genera en el primer envio y se repite
    /// en cada reintento (acta M50, que extiende M48). El notifier es
    /// `autoDispose` y [MealFormNotifier.reset] lo vacia, asi que la clave dura
    /// lo que dura una comida.
    String? clientGuid,

    /// Momento del registro, fijado junto con [clientGuid]. Viaja en la carga,
    /// y el backend compara la carga entera: un reintento con otro momento
    /// recibiria 409 en vez de 200.
    DateTime? clientCreatedAt,
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
  ///
  /// **Una comida, una clave** (acta M50). La clave y el momento del registro
  /// se fijan en el primer envio y se repiten en cada reintento. Antes cada
  /// envio generaba una clave nueva, y tres toques tras un corte de red
  /// dejaban tres comidas que el servidor no podia reconocer como la misma.
  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    final clientGuid = state.clientGuid ?? const Uuid().v4();
    final clientCreatedAt = state.clientCreatedAt ?? DateTime.now().toUtc();
    // Todo en la misma asignacion y antes del primer `await`: un segundo toque
    // ya encuentra `submitting` en true y no entra.
    state = state.copyWith(
      submitting: true,
      error: null,
      clientGuid: clientGuid,
      clientCreatedAt: clientCreatedAt,
    );

    final draft = state.draft;
    final localStore = ref.read(mealsLocalStoreProvider);

    // La fila local se escribe siempre, con o sin red, y con la misma clave que
    // viaja al servidor: si la respuesta se pierde, el lote repite ese UUID y
    // esa carga, y el backend deduplica en vez de crear una segunda comida.
    await localStore.enqueue(
      draft,
      clientGuid: clientGuid,
      now: clientCreatedAt,
    );

    if (!await ref.read(connectivityMonitorProvider).isOnline()) {
      state = state.copyWith(
        submitting: false,
        outcome: MealSubmitOutcome.queuedOffline,
      );
      return true;
    }

    try {
      final created = await ref.read(mealsRepositoryProvider).create(
            draft,
            clientGuid: clientGuid,
            clientCreatedAt: clientCreatedAt,
          );

      await localStore.markSynced(clientGuid, created.mealId);

      state = state.copyWith(
        submitting: false,
        outcome: MealSubmitOutcome.registered,
        aggregatedFodmap: created.aggregatedFodmap,
      );
      return true;
    } on CauceApiError catch (error) {
      if (error is NetworkError) {
        // **Un fallo de red no es un rechazo.** La radio decia que habia red,
        // pero el envio no llego: la comida ya esta guardada y queda igual que
        // si se hubiera registrado sin conexion. Mostrarlo como error invitaba
        // a tocar "Registrar" otra vez sobre algo que ya estaba a salvo.
        state = state.copyWith(
          submitting: false,
          outcome: MealSubmitOutcome.queuedOffline,
        );
        return true;
      }

      // La fila local queda pendiente a proposito. El paciente ya anoto lo que
      // comio y perder eso por un fallo del servidor seria lo peor que puede
      // pasar en un registro clinico; el worker reintenta, y si el motivo es
      // permanente la fila pasa a `failed` con su salida de descarte. Un
      // reintento desde el formulario conserva la clave y reemplaza la fila.
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
