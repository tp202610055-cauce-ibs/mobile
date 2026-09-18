import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'symptom_draft.freezed.dart';

/// Los nueve tipos de sintoma del contrato, mas `otro`.
///
/// **No hay catalogo ni endpoint**: es el enum `SymptomType`, que el cliente
/// generado ya expone. `GlossaryTermsSeeder` del backend es otra cosa, un
/// glosario de terminologia clinica para tooltips, no la lista del selector.
///
/// El orden de declaracion es el de presentacion al paciente, agrupado por
/// familia, y **no** el orden numerico del enum del backend, donde `Other` cae
/// en el medio por razones historicas.
enum SymptomTypeOption {
  abdominalPain,
  bloating,
  flatulence,
  diarrhea,
  constipation,
  nausea,
  reflux,
  urgency,
  other;

  /// Valor tal como lo serializa el contrato, que es la forma en que se guarda
  /// en `symptoms_local` y la que viaja en el lote.
  String get wireValue => switch (this) {
        SymptomTypeOption.abdominalPain => 'AbdominalPain',
        SymptomTypeOption.bloating => 'Bloating',
        SymptomTypeOption.flatulence => 'Flatulence',
        SymptomTypeOption.diarrhea => 'Diarrhea',
        SymptomTypeOption.constipation => 'Constipation',
        SymptomTypeOption.nausea => 'Nausea',
        SymptomTypeOption.reflux => 'Reflux',
        SymptomTypeOption.urgency => 'Urgency',
        SymptomTypeOption.other => 'Other',
      };

  api.SymptomType toApi() => switch (this) {
        SymptomTypeOption.abdominalPain => api.SymptomType.abdominalPain,
        SymptomTypeOption.bloating => api.SymptomType.bloating,
        SymptomTypeOption.flatulence => api.SymptomType.flatulence,
        SymptomTypeOption.diarrhea => api.SymptomType.diarrhea,
        SymptomTypeOption.constipation => api.SymptomType.constipation,
        SymptomTypeOption.nausea => api.SymptomType.nausea,
        SymptomTypeOption.reflux => api.SymptomType.reflux,
        SymptomTypeOption.urgency => api.SymptomType.urgency,
        SymptomTypeOption.other => api.SymptomType.other,
      };

  static SymptomTypeOption? fromWire(String? value) {
    for (final option in SymptomTypeOption.values) {
      if (option.wireValue == value) {
        return option;
      }
    }
    return null;
  }

  static SymptomTypeOption? fromApi(api.SymptomType? value) {
    return switch (value) {
      api.SymptomType.abdominalPain => SymptomTypeOption.abdominalPain,
      api.SymptomType.bloating => SymptomTypeOption.bloating,
      api.SymptomType.flatulence => SymptomTypeOption.flatulence,
      api.SymptomType.diarrhea => SymptomTypeOption.diarrhea,
      api.SymptomType.constipation => SymptomTypeOption.constipation,
      api.SymptomType.nausea => SymptomTypeOption.nausea,
      api.SymptomType.reflux => SymptomTypeOption.reflux,
      api.SymptomType.urgency => SymptomTypeOption.urgency,
      api.SymptomType.other => SymptomTypeOption.other,
      _ => null,
    };
  }
}

/// Motivo por el que el sintoma todavia no se puede registrar.
enum SymptomDraftIssue {
  /// No se eligio el tipo.
  missingType,

  /// No se movio la escala de intensidad.
  missingIntensity,

  /// La intensidad quedo fuera de 1 a 100.
  intensityOutOfRange,

  /// El momento en que ocurrio esta en el futuro.
  futureOccurredAt,
}

/// Sintoma en construccion, antes de salir del dispositivo.
@freezed
abstract class SymptomDraft with _$SymptomDraft {
  const factory SymptomDraft({
    SymptomTypeOption? symptomType,

    /// De 1 a 100, o `null` mientras el paciente no responda.
    int? intensity,
    DateTime? occurredAt,
  }) = _SymptomDraft;

  const SymptomDraft._();

  /// Extremos que acepta `Symptom.Report` del backend.
  ///
  /// **El minimo es 1, no 0.** `CauceSlider` se instancia con `min: 1` por esto.
  static const int minIntensity = 1;
  static const int maxIntensity = 100;

  /// Tolerancia de reloj que aplica el backend (`ClockSkewToleranceMinutes`).
  static const Duration clockSkewTolerance = Duration(minutes: 5);

  List<SymptomDraftIssue> issues({DateTime? now}) {
    final problems = <SymptomDraftIssue>[];

    if (symptomType == null) {
      problems.add(SymptomDraftIssue.missingType);
    }

    final value = intensity;
    if (value == null) {
      problems.add(SymptomDraftIssue.missingIntensity);
    } else if (value < minIntensity || value > maxIntensity) {
      problems.add(SymptomDraftIssue.intensityOutOfRange);
    }

    final occurred = occurredAt;
    if (occurred != null) {
      final limit = (now ?? DateTime.now()).toUtc().add(clockSkewTolerance);
      if (occurred.toUtc().isAfter(limit)) {
        problems.add(SymptomDraftIssue.futureOccurredAt);
      }
    }

    return problems;
  }

  bool canSubmit({DateTime? now}) => issues(now: now).isEmpty;
}

/// Resultado de registrar un sintoma contra el servidor.
///
/// **La asociacion con una comida la resuelve el servidor.** DEC-B3-06 deja el
/// calculo de la ventana de 4 horas del lado del servidor como autoridad; el
/// cliente no la replica y solo muestra lo que se le confirma.
@freezed
abstract class CreatedSymptom with _$CreatedSymptom {
  const factory CreatedSymptom({
    required String symptomId,

    /// Comida con la que el servidor lo asocio, si hubo alguna en la ventana.
    String? associatedMealId,

    /// Lo que respondio el servidor sobre la asociacion (CA02).
    @Default(false) bool hasMealAssociation,
  }) = _CreatedSymptom;

  const CreatedSymptom._();
}

/// Un sintoma del historial del paciente.
@freezed
abstract class SymptomRecord with _$SymptomRecord {
  const factory SymptomRecord({
    required String symptomId,
    required DateTime occurredAt,
    required int intensity,
    String? clientGuid,
    SymptomTypeOption? symptomType,
    String? associatedMealId,
    @Default(false) bool hasMealAssociation,
  }) = _SymptomRecord;

  const SymptomRecord._();
}

/// Una pagina del historial de sintomas.
@freezed
abstract class SymptomHistoryPage with _$SymptomHistoryPage {
  const factory SymptomHistoryPage({
    @Default(<SymptomRecord>[]) List<SymptomRecord> items,
    @Default(1) int page,
    @Default(50) int pageSize,
    @Default(0) int totalCount,
  }) = _SymptomHistoryPage;

  const SymptomHistoryPage._();

  bool get hasMore => page * pageSize < totalCount;
}
