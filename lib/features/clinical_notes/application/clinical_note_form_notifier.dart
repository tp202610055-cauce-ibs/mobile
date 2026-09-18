import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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
  }) = _ClinicalNoteFormState;

  const ClinicalNoteFormState._();

  List<ClinicalNoteIssue> get issues => draft.issues;

  bool get canSubmit => draft.canSubmit && !submitting;

  /// Caracteres restantes, para el contador visible (CA02).
  int get remaining => draft.remaining;
}

/// Gobierna la escritura y el envio de una nota de contexto.
///
/// **Exige conexion.** El endpoint no es idempotente, asi que la nota no entra
/// a la cola offline: reintentarla sin una clave de deduplicacion crearia una
/// segunda nota sobre el mismo registro clinico.
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
  Future<bool> submit() async {
    if (!state.canSubmit) {
      return false;
    }
    state = state.copyWith(submitting: true, error: null);

    try {
      final noteId =
          await ref.read(clinicalNotesRepositoryProvider).create(state.draft);

      state = state.copyWith(submitting: false, createdId: noteId);
      return true;
    } on CauceApiError catch (error) {
      state = state.copyWith(submitting: false, error: error);
      return false;
    }
  }
}
