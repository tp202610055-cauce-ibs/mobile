import '../../../../l10n/generated/app_localizations.dart';
import '../../../ibs_sss/domain/ibs_sss_baseline.dart';
import '../../../patients/domain/allergy.dart';
import '../../../patients/domain/patient_profile.dart';

/// Traduce los enums del dominio al texto que ve el paciente.
///
/// Vive en un solo lugar para que las dos pantallas y sus widgets no dupliquen
/// el mismo `switch`, y para que agregar un valor al dominio falle en
/// compilacion aca y no pase inadvertido en cuatro archivos. Es el mismo
/// criterio que sigue `CauceApiErrorMessage` con los errores del contrato.
abstract final class OnboardingLabels {
  static String biologicalSex(AppLocalizations l10n, BiologicalSexOption v) =>
      switch (v) {
        BiologicalSexOption.female => l10n.biologicalSexFemale,
        BiologicalSexOption.male => l10n.biologicalSexMale,
        BiologicalSexOption.other => l10n.biologicalSexOther,
      };

  static String ibsSubtype(AppLocalizations l10n, IbsSubtypeOption v) =>
      switch (v) {
        IbsSubtypeOption.ibsD => l10n.ibsSubtypeD,
        IbsSubtypeOption.ibsC => l10n.ibsSubtypeC,
        IbsSubtypeOption.ibsM => l10n.ibsSubtypeM,
        IbsSubtypeOption.ibsU => l10n.ibsSubtypeU,
      };

  /// Glosa del subtipo. "SII-D" no le dice nada a un paciente sin esto.
  static String ibsSubtypeDescription(
    AppLocalizations l10n,
    IbsSubtypeOption v,
  ) =>
      switch (v) {
        IbsSubtypeOption.ibsD => l10n.ibsSubtypeDDescription,
        IbsSubtypeOption.ibsC => l10n.ibsSubtypeCDescription,
        IbsSubtypeOption.ibsM => l10n.ibsSubtypeMDescription,
        IbsSubtypeOption.ibsU => l10n.ibsSubtypeUDescription,
      };

  static String allergySeverity(
    AppLocalizations l10n,
    AllergySeverityLevel v,
  ) =>
      switch (v) {
        AllergySeverityLevel.mild => l10n.allergySeverityMild,
        AllergySeverityLevel.moderate => l10n.allergySeverityModerate,
        AllergySeverityLevel.severe => l10n.allergySeveritySevere,
      };

  static String allergyType(AppLocalizations l10n, AllergyTypeOption v) =>
      switch (v) {
        AllergyTypeOption.allergy => l10n.allergyTypeAllergy,
        AllergyTypeOption.intolerance => l10n.allergyTypeIntolerance,
        AllergyTypeOption.sensitivity => l10n.allergyTypeSensitivity,
      };

  /// Categoria de IMC, en registro clinico neutro.
  static String bmiCategory(AppLocalizations l10n, BmiCategory v) =>
      switch (v) {
        BmiCategory.underweight => l10n.bmiCategoryUnderweight,
        BmiCategory.normal => l10n.bmiCategoryNormal,
        BmiCategory.overweight => l10n.bmiCategoryOverweight,
        BmiCategory.obese => l10n.bmiCategoryObese,
      };

  static String ibsSssSeverity(AppLocalizations l10n, IbsSssSeverity v) =>
      switch (v) {
        IbsSssSeverity.mild => l10n.ibsSssSeverityMild,
        IbsSssSeverity.moderate => l10n.ibsSssSeverityModerate,
        IbsSssSeverity.severe => l10n.ibsSssSeveritySevere,
      };

  static String ibsSssQuestion(AppLocalizations l10n, IbsSssDimension v) =>
      switch (v) {
        IbsSssDimension.painSeverity => l10n.ibsSssQuestionPainSeverity,
        IbsSssDimension.painFrequency => l10n.ibsSssQuestionPainFrequency,
        IbsSssDimension.bloatingSeverity => l10n.ibsSssQuestionBloatingSeverity,
        IbsSssDimension.bowelHabitsDissatisfaction =>
          l10n.ibsSssQuestionBowelHabits,
        IbsSssDimension.lifeInterference => l10n.ibsSssQuestionLifeInterference,
      };

  /// Etiqueta del extremo izquierdo de la escala.
  static String ibsSssMinLabel(AppLocalizations l10n, IbsSssDimension v) =>
      switch (v) {
        IbsSssDimension.painSeverity => l10n.ibsSssPainSeverityMin,
        IbsSssDimension.painFrequency => l10n.ibsSssPainFrequencyMin,
        IbsSssDimension.bloatingSeverity => l10n.ibsSssBloatingSeverityMin,
        IbsSssDimension.bowelHabitsDissatisfaction => l10n.ibsSssBowelHabitsMin,
        IbsSssDimension.lifeInterference => l10n.ibsSssLifeInterferenceMin,
      };

  static String ibsSssMaxLabel(AppLocalizations l10n, IbsSssDimension v) =>
      switch (v) {
        IbsSssDimension.painSeverity => l10n.ibsSssPainSeverityMax,
        IbsSssDimension.painFrequency => l10n.ibsSssPainFrequencyMax,
        IbsSssDimension.bloatingSeverity => l10n.ibsSssBloatingSeverityMax,
        IbsSssDimension.bowelHabitsDissatisfaction => l10n.ibsSssBowelHabitsMax,
        IbsSssDimension.lifeInterference => l10n.ibsSssLifeInterferenceMax,
      };

  /// Fecha en formato dd/MM/yyyy.
  ///
  /// Se arma a mano en vez de usar `DateFormat` con locale: `intl` exige
  /// inicializar los datos del locale antes de usarlo, y un formato numerico
  /// no gana nada con esa dependencia extra.
  static String date(DateTime value) {
    final d = value.day.toString().padLeft(2, '0');
    final m = value.month.toString().padLeft(2, '0');
    return '$d/$m/${value.year}';
  }
}
