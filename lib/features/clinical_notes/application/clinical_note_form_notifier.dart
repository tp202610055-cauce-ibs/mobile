import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/clinical_notes_repository.dart';
import '../domain/clinical_note_draft.dart';

part 'clinical_note_form_notifier.freezed.dart';
part 'clinical_note_form_notifier.g.dart';

/// Estado del formulario de nota de contexto (US13).
@freezed
abstract class ClinicalNoteFormState with _$ClinicalNoteFormState {
  const factory ClinicalNoteFormState({
    @Default(ClinicalNoteDraft()) ClinicalNoteDraft draft,
    @Default(false) bool submitting,

    /// Identificador de la nota creada, tras un envio exitoso.
    String? createdId,
    CauceApiError? error,

    /// `clientGuid` de esta nota: se genera en el primer envio y se repite en
    /// cada reintento mientras la pantalla siga abierta (acta M48).
    String? clientGuid,
  }) = _ClinicalNoteFormState;

  const ClinicalNoteFormState._();

  List<ClinicalNoteIssue> get issues => draft.issues;

  bool get canSubmit => draft.canSubmit && !submitting;

  /// Caracteres restantes, para el contador visible (CA02).
  int get remaining => draft.remaining;
}

/// Gobierna la escritura y el envio de una nota de contexto.
///
/// **Exige conexion.** La nota no entra a la cola offline ni se guarda en el
/// dispositivo: sin red, el envio falla y el paciente reintenta desde la misma
/// pantalla.
///
/// **La idempotencia vive aca, en el alcance de la pantalla** (acta M48). El
/// `clientGuid` se genera en el primer envio, cuando el borrador ya paso
/// `canSubmit`, y se repite en cada reintento. Si un envio llego al servidor
/// pero la respuesta se perdio, el reintento devuelve la misma nota en vez de
/// crear otra. El provider se libera al salir de la pantalla, y con el la
/// clave: una nota nueva es una clave nueva.
@riverpod
class ClinicalNoteFormNotifier extends _$ClinicalNoteFormNotifier {
  @override
  ClinicalNoteFormState build() => const ClinicalNoteFormState();

  /// Fija a que registro del servidor se asocia la nota.
  ///
  /// Exactamente uno: pasar los dos o ninguno deja el borrador invalido y la
  /// pantalla lo dice, en vez de esperar el 400
  /// `invalid_clinical_note_association`.
  void attachTo({String? mealId, String? symptomId}) {
    state = state.copyWith(
      draft: state.draft.copyWith(mealId: mealId, symptomId: symptomId),
      error: null,
    );
  }

  void setContent(String content) {
    state = state.copyWith(
      draft: state.draft.copyWith(content: content),
      error: null,
    );
  }

  void clearError() {
    if (state.error != null) {
      state = state.copyWith(error: null);
    }
  }

  /// Envia la nota. Devuelve `true` si el servidor la acepto.
  ///
  /// Ante un rechazo el texto queda intacto (CA02): el paciente ya lo escribio
  /// y perderlo por un fallo del servidor lo obligaria a redactarlo de nuevo.
  ///
  /// La clave **no** se renueva si el paciente corrige el texto entre un
  /// fallo y el reintento. Si el primer envio si habia llegado, el servidor
  /// responde 409 `idempotency_mismatch` en lugar de guardar una segunda nota
  /// con el texto corregido: se prefiere el aviso al duplicado en el registro
  /// clinico (acta M48).
  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    final clientGuid = state.clientGuid ?? const Uuid().v4();
    state = state.copyWith(
      submitting: true,
      error: null,
      clientGuid: clientGuid,
    );

    try {
      final noteId = await ref
          .read(clinicalNotesRepositoryProvider)
          .create(state.draft, clientGuid: clientGuid);

      state = state.copyWith(submitting: false, createdId: noteId);
      return true;
    } on CauceApiError catch (error) {
      state = state.copyWith(submitting: false, error: error);
      return false;
    }
  }
}
