import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/errors/error_messages.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../patients/data/patients_repository.dart';
import '../../patients/domain/allergy.dart';
import '../../patients/domain/patient_profile.dart';
import '../application/clinical_profile_notifier.dart';
import '../application/onboarding_notifier.dart';
import 'widgets/allergy_picker.dart';
import 'widgets/bmi_summary_card.dart';
import 'widgets/onboarding_labels.dart';
import 'widgets/onboarding_scaffold.dart';

/// Paso 1 del wizard: perfil clinico y alergias (US03).
class ClinicalProfileScreen extends ConsumerStatefulWidget {
  const ClinicalProfileScreen({super.key});

  @override
  ConsumerState<ClinicalProfileScreen> createState() =>
      _ClinicalProfileScreenState();
}

class _ClinicalProfileScreenState extends ConsumerState<ClinicalProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _medicationsController = TextEditingController();

  DateTime? _dateOfBirth;
  DateTime? _diagnosisDate;
  BiologicalSexOption? _biologicalSex;
  IbsSubtypeOption? _ibsSubtype;

  /// Alergias marcadas, por `allergyId`.
  final Map<String, AllergyDeclarationDraft> _allergies =
      <String, AllergyDeclarationDraft>{};

  /// Errores de los controles que no son `TextFormField` y que por eso no
  /// participan del `validate()` del formulario.
  String? _dateOfBirthError;
  String? _biologicalSexError;
  String? _ibsSubtypeError;

  @override
  void dispose() {
    _weightController.dispose();
    _heightController.dispose();
    _medicationsController.dispose();
    super.dispose();
  }

  /// IMC en vivo (CA04). Se recalcula en cada cambio de peso o estatura.
  double? get _bmi => BmiCalculator.calculate(
        weightKg: _parse(_weightController.text),
        heightCm: _parse(_heightController.text),
      );

  double? _parse(String raw) =>
      double.tryParse(raw.trim().replaceAll(',', '.'));

  Future<void> _pickDate({
    required DateTime? current,
    required ValueChanged<DateTime> onPicked,
  }) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime(now.year - 30, now.month, now.day),
      firstDate: DateTime(now.year - 120),
      // Ninguna de las dos fechas puede ser futura, asi que el calendario ni
      // siquiera ofrece esos dias.
      lastDate: now,
    );
    if (picked != null) {
      onPicked(picked);
    }
  }

  /// Valida lo que el `Form` no cubre y publica los errores.
  ///
  /// Va en un paso propio porque los tres controles de seleccion y fecha no
  /// son `FormField` y quedan fuera de `validate()`.
  bool _validateNonFormFields(AppLocalizations l10n) {
    final dateOfBirthError = Validators.dateOfBirth(_dateOfBirth, l10n);
    final biologicalSexError =
        _biologicalSex == null ? l10n.validationRequired : null;
    final ibsSubtypeError =
        _ibsSubtype == null ? l10n.validationRequired : null;

    setState(() {
      _dateOfBirthError = dateOfBirthError;
      _biologicalSexError = biologicalSexError;
      _ibsSubtypeError = ibsSubtypeError;
    });

    return dateOfBirthError == null &&
        biologicalSexError == null &&
        ibsSubtypeError == null;
  }

  Future<void> _submit(AppLocalizations l10n) async {
    // Los dos se evaluan siempre, sin cortocircuito: con `&&` el paciente
    // veria los errores de a tandas en vez de todos juntos, que es lo que
    // pide CA02.
    final formOk = _formKey.currentState?.validate() ?? false;
    final extrasOk = _validateNonFormFields(l10n);
    if (!formOk || !extrasOk) {
      return;
    }

    FocusScope.of(context).unfocus();

    // La navegacion la resuelve el guard cuando el onboarding avanza de paso.
    // Esta pantalla no navega por su cuenta.
    await ref.read(clinicalProfileNotifierProvider.notifier).submit(
          draft: PatientProfileDraft(
            dateOfBirth: _dateOfBirth!,
            biologicalSex: _biologicalSex!,
            weightKg: _parse(_weightController.text)!,
            heightCm: _parse(_heightController.text)!,
            ibsSubtype: _ibsSubtype!,
            diagnosisDate: _diagnosisDate,
            medications: _medicationsController.text,
          ),
          allergies: _allergies.values.toList(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(clinicalProfileNotifierProvider);
    final error = state.error;
    final fieldErrors = error?.fieldErrors ?? const <String, List<String>>{};
    final busy = state.isSubmitting;

    void onEdited(String _) {
      ref.read(clinicalProfileNotifierProvider.notifier).clearError();
      // El IMC depende de dos campos de texto, asi que se repinta en cada
      // cambio.
      setState(() {});
    }

    return OnboardingStepScaffold(
      step: 1,
      title: l10n.clinicalProfileTitle,
      subtitle: l10n.clinicalProfileSubtitle,
      busy: busy,
      onDefer: () => ref.read(onboardingNotifierProvider.notifier).defer(),
      children: <Widget>[
        if (error != null) ...<Widget>[
          CauceErrorBanner(error: error),
          const SizedBox(height: CauceSpacing.space4),
        ],
        Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _DateField(
                fieldKey: const Key('profile_date_of_birth'),
                label: l10n.clinicalProfileDateOfBirthLabel,
                value: _dateOfBirth,
                errorText:
                    _dateOfBirthError ?? fieldErrors['dateOfBirth']?.first,
                enabled: !busy,
                onTap: () => _pickDate(
                  current: _dateOfBirth,
                  onPicked: (value) => setState(() {
                    _dateOfBirth = value;
                    _dateOfBirthError = null;
                  }),
                ),
              ),
              const SizedBox(height: CauceSpacing.space4),
              CauceChoiceField<BiologicalSexOption>(
                key: const Key('profile_biological_sex'),
                label: l10n.clinicalProfileBiologicalSexLabel,
                value: _biologicalSex,
                errorText:
                    _biologicalSexError ?? fieldErrors['biologicalSex']?.first,
                enabled: !busy,
                onChanged: (value) => setState(() {
                  _biologicalSex = value;
                  _biologicalSexError = null;
                }),
                choices: <CauceChoice<BiologicalSexOption>>[
                  for (final option in BiologicalSexOption.values)
                    CauceChoice<BiologicalSexOption>(
                      value: option,
                      label: OnboardingLabels.biologicalSex(l10n, option),
                    ),
                ],
              ),
              const SizedBox(height: CauceSpacing.space4),
              CauceTextField(
                key: const Key('profile_weight'),
                controller: _weightController,
                label: l10n.clinicalProfileWeightLabel,
                hint: l10n.clinicalProfileWeightHint,
                errorText: fieldErrors['weightKg']?.first,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                enabled: !busy,
                validator: (value) => Validators.weightKg(value, l10n),
                onChanged: onEdited,
              ),
              const SizedBox(height: CauceSpacing.space4),
              CauceTextField(
                key: const Key('profile_height'),
                controller: _heightController,
                label: l10n.clinicalProfileHeightLabel,
                hint: l10n.clinicalProfileHeightHint,
                errorText: fieldErrors['heightCm']?.first,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.next,
                enabled: !busy,
                validator: (value) => Validators.heightCm(value, l10n),
                onChanged: onEdited,
              ),
              const SizedBox(height: CauceSpacing.space4),
              BmiSummaryCard(
                bmi: _bmi,
                category: BmiCalculator.categorize(_bmi),
              ),
              const SizedBox(height: CauceSpacing.space4),
              CauceChoiceField<IbsSubtypeOption>(
                key: const Key('profile_ibs_subtype'),
                label: l10n.clinicalProfileIbsSubtypeLabel,
                value: _ibsSubtype,
                errorText: _ibsSubtypeError ?? fieldErrors['ibsSubtype']?.first,
                enabled: !busy,
                onChanged: (value) => setState(() {
                  _ibsSubtype = value;
                  _ibsSubtypeError = null;
                }),
                choices: <CauceChoice<IbsSubtypeOption>>[
                  for (final option in IbsSubtypeOption.values)
                    CauceChoice<IbsSubtypeOption>(
                      value: option,
                      label: OnboardingLabels.ibsSubtype(l10n, option),
                      description:
                          OnboardingLabels.ibsSubtypeDescription(l10n, option),
                    ),
                ],
              ),
              const SizedBox(height: CauceSpacing.space4),
              _DateField(
                fieldKey: const Key('profile_diagnosis_date'),
                label: l10n.clinicalProfileDiagnosisDateLabel,
                value: _diagnosisDate,
                errorText: fieldErrors['diagnosisDate']?.first,
                enabled: !busy,
                onTap: () => _pickDate(
                  current: _diagnosisDate,
                  onPicked: (value) => setState(() => _diagnosisDate = value),
                ),
              ),
              const SizedBox(height: CauceSpacing.space4),
              CauceTextField(
                key: const Key('profile_medications'),
                controller: _medicationsController,
                label: l10n.clinicalProfileMedicationsLabel,
                hint: l10n.clinicalProfileMedicationsHint,
                errorText: fieldErrors['medications']?.first,
                textInputAction: TextInputAction.done,
                enabled: !busy,
                validator: (value) => Validators.medications(value, l10n),
              ),
            ],
          ),
        ),
        const SizedBox(height: CauceSpacing.space6),
        _AllergiesSection(
          selected: _allergies,
          enabled: !busy,
          onChanged: () => setState(() {}),
        ),
        const SizedBox(height: CauceSpacing.space6),
        CauceButton(
          key: const Key('profile_submit'),
          label: l10n.clinicalProfileSubmit,
          loading: busy,
          onPressed: () => _submit(l10n),
        ),
      ],
    );
  }
}

/// Campo de fecha de solo lectura que abre el calendario al tocarlo.
///
/// No se usa un campo editable: una fecha tipeada a mano abre la puerta a
/// formatos ambiguos, donde 03/04 puede ser marzo o abril, y a errores de
/// tipeo en un dato del que depende la validacion de edad.
class _DateField extends StatelessWidget {
  const _DateField({
    required this.fieldKey,
    required this.label,
    required this.value,
    required this.onTap,
    this.errorText,
    this.enabled = true,
  });

  final Key fieldKey;
  final String label;
  final DateTime? value;
  final VoidCallback onTap;
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final current = value;
    final hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(label, style: textTheme.bodyMedium),
        const SizedBox(height: CauceSpacing.space2),
        InkWell(
          key: fieldKey,
          onTap: enabled ? onTap : null,
          borderRadius: CauceRadii.borderMd,
          child: Container(
            constraints: const BoxConstraints(
              minHeight: CauceSizes.touchTargetMin,
            ),
            padding: CauceSizes.inputPadding,
            decoration: BoxDecoration(
              color: CauceColors.bgCard,
              borderRadius: CauceRadii.borderMd,
              border: Border.all(
                color:
                    hasError ? CauceColors.dangerText : CauceColors.bgDivider,
                width: CauceBorders.strong,
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                current == null
                    ? l10n.clinicalProfileDatePlaceholder
                    : OnboardingLabels.date(current),
                style: textTheme.bodyLarge?.copyWith(
                  color: current == null
                      ? CauceColors.textTertiary
                      : CauceColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
        if (hasError) ...<Widget>[
          const SizedBox(height: CauceSpacing.space1),
          Text(
            errorText!,
            style: textTheme.labelSmall?.copyWith(
              color: CauceColors.dangerText,
            ),
          ),
        ],
      ],
    );
  }
}

/// Catalogo de alergias con su ciclo de carga, error y reintento.
class _AllergiesSection extends ConsumerWidget {
  const _AllergiesSection({
    required this.selected,
    required this.enabled,
    required this.onChanged,
  });

  final Map<String, AllergyDeclarationDraft> selected;
  final bool enabled;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final catalog = ref.watch(allergyCatalogProvider);

    return OnboardingSection(
      title: l10n.allergiesTitle,
      subtitle: l10n.allergiesSubtitle,
      child: catalog.when(
        loading: () => CauceLoadingIndicator.fullscreen(
          message: l10n.allergiesLoading,
        ),
        // El catalogo no bloquea el paso: declarar alergias es opcional, asi
        // que un fallo aca ofrece reintentar sin impedir el envio del perfil.
        error: (error, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (error is CauceApiError)
              CauceErrorBanner(error: error)
            else
              Text(l10n.errorUnknown),
            const SizedBox(height: CauceSpacing.space3),
            CauceButton.secondary(
              key: const Key('allergies_retry'),
              label: l10n.commonRetry,
              onPressed: () => ref.invalidate(allergyCatalogProvider),
            ),
          ],
        ),
        data: (entries) => AllergyPicker(
          catalog: entries,
          selected: selected,
          enabled: enabled,
          onToggle: (entry, value) {
            if (value) {
              selected[entry.allergyId] = AllergyDeclarationDraft(
                allergyId: entry.allergyId,
                // Moderada es el punto medio de los tres niveles. Arrancar en
                // leve o severa sesgaria la declaracion hacia un extremo.
                severity: AllergySeverityLevel.moderate,
              );
            } else {
              selected.remove(entry.allergyId);
            }
            onChanged();
          },
          onSeverityChanged: (allergyId, value) {
            final current = selected[allergyId];
            if (current != null) {
              selected[allergyId] = current.copyWith(severity: value);
              onChanged();
            }
          },
          onNotesChanged: (allergyId, value) {
            final current = selected[allergyId];
            if (current != null) {
              selected[allergyId] = current.copyWith(notes: value);
            }
          },
        ),
      ),
    );
  }
}
