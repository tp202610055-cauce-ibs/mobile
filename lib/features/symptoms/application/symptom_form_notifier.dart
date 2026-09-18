import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/sync/connectivity_monitor.dart';
import '../data/symptoms_local_store.dart';
import '../data/symptoms_repository.dart';
import '../domain/symptom_draft.dart';

part 'symptom_form_notifier.freezed.dart';
part 'symptom_form_notifier.g.dart';

/// Como termino el registro de un sintoma.
enum SymptomSubmitOutcome {
  /// El servidor lo acepto en el momento.
  registered,

  /// Quedo guardado en el dispositivo, esperando conexion.
  ///
  /// La asociacion con una comida queda sin resolver hasta que sincronice: la
  /// calcula el servidor, no el cliente.
  queuedOffline,

  /// El servidor lo rechazo. El formulario conserva lo cargado.
  rejected,
}

/// Estado del formulario de registro de sintoma (US11).
@freezed
abstract class SymptomFormState with _$SymptomFormState {
  const factory SymptomFormState({
    @Default(SymptomDraft()) SymptomDraft draft,
    @Default(false) bool submitting,
    SymptomSubmitOutcome? outcome,

    /// Lo que el servidor confirmo sobre la ventana de 4 horas, disponible
    /// recien tras el envio con conexion.
    CreatedSymptom? result,
    CauceApiError? error,
  }) = _SymptomFormState;

  const SymptomFormState._();

  List<SymptomDraftIssue> get issues => draft.issues();

  bool get canSubmit => draft.canSubmit() && !submitting;
}

/// Gobierna el armado y el envio de un sintoma.
///
/// Mismo patron que el registro de comidas: con conexion o sin ella el sintoma
/// se guarda siempre en el dispositivo, y con red se manda ademas al servidor.
@riverpod
class SymptomFormNotifier extends _$SymptomFormNotifier {
  @override
  SymptomFormState build() => const SymptomFormState();

  void selectType(SymptomTypeOption symptomType) {
    state = state.copyWith(
      draft: state.draft.copyWith(symptomType: symptomType),
      error: null,
    );
  }

  void setIntensity(int intensity) {
    state = state.copyWith(
      draft: state.draft.copyWith(intensity: intensity),
      error: null,
    );
  }

  void setOccurredAt(DateTime occurredAt) {
    state = state.copyWith(
      draft: state.draft.copyWith(occurredAt: occurredAt),
      error: null,
    );
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  /// Registra el sintoma. Devuelve `true` si el dato quedo a salvo.
  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    state = state.copyWith(submitting: true, error: null);

    final draft = state.draft;
    final localStore = ref.read(symptomsLocalStoreProvider);

    if (!await ref.read(connectivityMonitorProvider).isOnline()) {
      await localStore.enqueue(draft);
      state = state.copyWith(
        submitting: false,
        outcome: SymptomSubmitOutcome.queuedOffline,
      );
      return true;
    }

    final clientGuid = await localStore.enqueue(draft);

    try {
      final created = await ref
          .read(symptomsRepositoryProvider)
          .create(draft, clientGuid: clientGuid);

      await localStore.markSynced(
        clientGuid,
        serverId: created.symptomId,
        associatedMealId: created.associatedMealId,
        hasMealAssociation: created.hasMealAssociation,
      );

      state = state.copyWith(
        submitting: false,
        outcome: SymptomSubmitOutcome.registered,
        result: created,
      );
      return true;
    } on CauceApiError catch (error) {
      // La fila local queda pendiente: el paciente ya registro lo que sintio y
      // el worker lo sube cuando pueda.
      state = state.copyWith(
        submitting: false,
        outcome: SymptomSubmitOutcome.rejected,
        error: error,
      );
      return false;
    }
  }

  void reset() {
    state = const SymptomFormState();
  }
}
