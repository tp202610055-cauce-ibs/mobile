import 'package:freezed_annotation/freezed_annotation.dart';

part 'clinical_note_draft.freezed.dart';

/// Motivo por el que la nota todavia no se puede guardar.
enum ClinicalNoteIssue {
  /// El texto esta vacio.
  empty,

  /// El texto supera los 500 caracteres (CA02).
  tooLong,

  /// No se indico a que registro se asocia.
  noAssociation,

  /// Se indicaron los dos: una nota va con una comida **o** con un sintoma.
  ambiguousAssociation,
}

/// Nota de contexto en construccion (US13).
///
/// **Se asocia a exactamente uno** de [mealId] o [symptomId]. La invariante es
/// del backend, que responde 400 `invalid_clinical_note_association` si llegan
/// los dos o ninguno, y se replica aca para que la pantalla no pueda armar algo
/// que el servidor va a rechazar.
///
/// Los dos identificadores son **del servidor**: un registro que todavia esta
/// en la cola local no tiene ninguno, y por eso el historial no le ofrece la
/// accion de agregar nota.
@freezed
abstract class ClinicalNoteDraft with _$ClinicalNoteDraft {
  const factory ClinicalNoteDraft({
    @Default('') String content,
    String? mealId,
    String? symptomId,
  }) = _ClinicalNoteDraft;

  const ClinicalNoteDraft._();

  /// Tope de longitud que fija CA02.
  static const int maxLength = 500;

  /// Caracteres que le quedan al paciente.
  ///
  /// Se cuenta con `String.length`, o sea unidades UTF-16, que es exactamente
  /// lo que cuenta `content.Length` de `ClinicalNote.Create` en el backend.
  /// Contar racimos de grafemas daria un numero mas intuitivo pero distinto del
  /// que aplica el servidor, y el contador quedaria mintiendo cerca del tope.
  int get remaining => maxLength - content.length;

  List<ClinicalNoteIssue> get issues {
    final problems = <ClinicalNoteIssue>[];

    final trimmed = content.trim();
    if (trimmed.isEmpty) {
      problems.add(ClinicalNoteIssue.empty);
    }
    // Se cuenta sobre el texto crudo y no sobre el recortado: el tope es del
    // campo, y descontar los espacios del final le daria al paciente un margen
    // que el servidor no reconoce.
    if (content.length > maxLength) {
      problems.add(ClinicalNoteIssue.tooLong);
    }

    final hasMeal = mealId != null;
    final hasSymptom = symptomId != null;
    if (!hasMeal && !hasSymptom) {
      problems.add(ClinicalNoteIssue.noAssociation);
    } else if (hasMeal && hasSymptom) {
      problems.add(ClinicalNoteIssue.ambiguousAssociation);
    }

    return problems;
  }

  bool get canSubmit => issues.isEmpty;
}
