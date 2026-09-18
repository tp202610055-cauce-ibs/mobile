import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/symptom_draft.dart';

/// Traduce los enums del registro de sintomas al texto que ve el paciente.
///
/// Mismo criterio que `OnboardingLabels`, `MealLabels` y `CustomFoodLabels`: un
/// `switch` exhaustivo en un solo lugar, de modo que agregar un valor al enum
/// del contrato falle en compilacion aca.
abstract final class SymptomLabels {
  /// Los nueve tipos del contrato, mas `otro`.
  ///
  /// Los nombres son los que usa el paciente, no los clinicos: "distension
  /// abdominal" y no "meteorismo", "urgencia para evacuar" y no "tenesmo".
  static String symptomType(AppLocalizations l10n, SymptomTypeOption v) =>
      switch (v) {
        SymptomTypeOption.abdominalPain => l10n.symptomTypeAbdominalPain,
        SymptomTypeOption.bloating => l10n.symptomTypeBloating,
        SymptomTypeOption.flatulence => l10n.symptomTypeFlatulence,
        SymptomTypeOption.diarrhea => l10n.symptomTypeDiarrhea,
        SymptomTypeOption.constipation => l10n.symptomTypeConstipation,
        SymptomTypeOption.nausea => l10n.symptomTypeNausea,
        SymptomTypeOption.reflux => l10n.symptomTypeReflux,
        SymptomTypeOption.urgency => l10n.symptomTypeUrgency,
        SymptomTypeOption.other => l10n.symptomTypeOther,
      };

  static String issue(AppLocalizations l10n, SymptomDraftIssue v) =>
      switch (v) {
        SymptomDraftIssue.missingType => l10n.symptomsIssueMissingType,
        SymptomDraftIssue.missingIntensity =>
          l10n.symptomsIssueMissingIntensity,
        SymptomDraftIssue.intensityOutOfRange =>
          l10n.symptomsIssueIntensityOutOfRange,
        SymptomDraftIssue.futureOccurredAt =>
          l10n.symptomsIssueFutureOccurredAt,
      };
}
