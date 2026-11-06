import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../core/auth/registration_without_invitation.dart';
import '../../../core/errors/error_messages.dart';
import '../../../core/onboarding/onboarding_draft_store.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../patients/domain/allergy.dart';
import '../../patients/domain/patient_profile.dart';
import '../application/clinical_profile_notifier.dart';
import 'widgets/allergies_section.dart';
import 'widgets/bmi_summary_card.dart';
import 'widgets/onboarding_labels.dart';
import 'widgets/onboarding_scaffold.dart';
import 'widgets/profile_date_field.dart';

/// Perfil clinico en dos pasos (US03): datos fisicos y antecedentes clinicos.
///
/// «Después» guarda el avance en cualquier paso; escribir o un intento
/// rechazado no guardan nada (CP008).
class ClinicalProfileScreen extends ConsumerStatefulWidget {
  const ClinicalProfileScreen({super.key});

  @override
  ConsumerState<ClinicalProfileScreen> createState() =>
      _ClinicalProfileScreenState();
}

class _ClinicalProfileScreenState extends ConsumerState<ClinicalProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateOfBirthController = TextEditingController();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  final _medicationsController = TextEditingController();

  /// 0: datos fisicos. 1: antecedentes clinicos.
  int _page = 0;

  DateTime? _diagnosisDate;
  BiologicalSexOption? _biologicalSex;
  IbsSubtypeOption? _ibsSubtype;

  /// Alergias marcadas, por `allergyId`.
  final Map<String, AllergyDeclarationDraft> _allergies =
      <String, AllergyDeclarationDraft>{};

  /// «Ninguna conocida»: excluye a las alergias marcadas y viceversa.
  bool _noneKnown = false;

  String? _biologicalSexError;
  String? _ibsSubtypeError;
  String? _allergiesError;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _restoreDraft());
  }

  @override
  void dispose() {
    _dateOfBirthController.dispose();
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

  double? _parse(String raw) => Validators.parseDecimal(raw);

  /// Lo escrito, como texto y nombres de enum, para el borrador.
  Map<String, Object?> _fields() => <String, Object?>{
        'dateOfBirth': _dateOfBirthController.text,
        'biologicalSex': _biologicalSex?.name,
        'weightKg': _weightController.text,
        'heightCm': _heightController.text,
        'ibsSubtype': _ibsSubtype?.name,
        'diagnosisDate': _diagnosisDate?.toIso8601String(),
        'medications': _medicationsController.text,
        'noneKnown': _noneKnown,
        'allergies': <Map<String, Object?>>[
          for (final allergy in _allergies.values)
            <String, Object?>{
              'allergyId': allergy.allergyId,
              'severity': allergy.severity.name,
              'notes': allergy.notes,
            },
        ],
      };

  Future<void> _restoreDraft() async {
    final draft =
        await ref.read(clinicalProfileNotifierProvider.notifier).loadDraft();
    if (draft == null || !mounted) {
      return;
    }
    setState(() => _apply(draft));
  }

  /// Vuelca el borrador en el formulario; un valor desconocido se ignora.
  void _apply(OnboardingDraft draft) {
    final f = draft.fields;
    String text(String key) => f[key] is String ? f[key]! as String : '';

    _page = draft.page.clamp(0, 1);
    _dateOfBirthController.text = text('dateOfBirth');
    _weightController.text = text('weightKg');
    _heightController.text = text('heightCm');
    _medicationsController.text = text('medications');
    _biologicalSex = BiologicalSexOption.values.asNameMap()[f['biologicalSex']];
    _ibsSubtype = IbsSubtypeOption.values.asNameMap()[f['ibsSubtype']];
    _diagnosisDate = DateTime.tryParse(text('diagnosisDate'));
    _noneKnown = f['noneKnown'] == true;
    final allergies = f['allergies'];
    if (allergies is List<Object?>) {
      for (final entry in allergies.whereType<Map<String, Object?>>()) {
        final id = entry['allergyId'];
        final severity =
            AllergySeverityLevel.values.asNameMap()[entry['severity']];
        if (id is String && severity != null) {
          _allergies[id] = AllergyDeclarationDraft(
            allergyId: id,
            severity: severity,
            notes: entry['notes'] is String ? entry['notes']! as String : null,
          );
        }
      }
    }
  }

  Future<void> _pickDateOfBirth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: Validators.parseDayMonthYear(_dateOfBirthController.text) ??
          DateTime(now.year - 30, now.month, now.day),
      firstDate: DateTime(now.year - 120),
      lastDate: now,
    );
    if (picked != null) {
      setState(
        () => _dateOfBirthController.text = OnboardingLabels.date(picked),
      );
    }
  }

  Future<void> _pickDiagnosisDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _diagnosisDate ?? now,
      firstDate: DateTime(now.year - 120),
      lastDate: now,
    );
    if (picked != null) {
      setState(() => _diagnosisDate = picked);
    }
  }

  String? _validateDateOfBirth(String? value, AppLocalizations l10n) {
    if (value == null || value.trim().isEmpty) {
      return l10n.validationRequired;
    }
    final date = Validators.parseDayMonthYear(value);
    if (date == null) {
      return l10n.validationDateFormat;
    }
    return Validators.dateOfBirth(date, l10n);
  }

  /// Paso 1: avanza solo con todos los datos fisicos validos.
  void _continue(AppLocalizations l10n) {
    // Los dos se evaluan siempre, para señalar todos los campos a la vez.
    final formOk = _formKey.currentState?.validate() ?? false;
    final sexError = _biologicalSex == null ? l10n.validationRequired : null;
    setState(() => _biologicalSexError = sexError);
    if (formOk && sexError == null) {
      FocusScope.of(context).unfocus();
      setState(() => _page = 1);
    }
  }

  /// Paso 2: guarda el perfil. La navegacion la resuelve el guard.
  Future<void> _submit(AppLocalizations l10n) async {
    final formOk = _formKey.currentState?.validate() ?? false;
    final subtypeError = _ibsSubtype == null ? l10n.validationRequired : null;
    final allergiesError = _allergies.isEmpty && !_noneKnown
        ? l10n.validationAllergiesRequired
        : null;
    setState(() {
      _ibsSubtypeError = subtypeError;
      _allergiesError = allergiesError;
    });
    if (!formOk || subtypeError != null || allergiesError != null) {
      return;
    }

    FocusScope.of(context).unfocus();
    await ref.read(clinicalProfileNotifierProvider.notifier).submit(
          draft: PatientProfileDraft(
            dateOfBirth:
                Validators.parseDayMonthYear(_dateOfBirthController.text)!,
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
    final busy = state.isSubmitting;

    return PopScope(
      // En el paso 2, el retroceso vuelve al paso 1.
      canPop: _page == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) {
          setState(() => _page = 0);
        }
      },
      child: OnboardingStepScaffold(
        step: _page + 1,
        title: l10n.clinicalProfileTitle,
        subtitle: _page == 0
            ? l10n.clinicalProfilePhysicalSubtitle
            : l10n.clinicalProfileHistorySubtitle,
        busy: busy,
        onDefer: () => ref
            .read(clinicalProfileNotifierProvider.notifier)
            .defer(page: _page, fields: _fields()),
        children: <Widget>[
          if (_page == 0 && ref.watch(showsNoInvitationNoticeProvider))
            const _NoInvitationNotice(),
          if (error != null) ...<Widget>[
            CauceErrorBanner(error: error),
            const SizedBox(height: CauceSpacing.space4),
          ],
          Form(
            key: _formKey,
            child: _page == 0
                ? _physicalStep(l10n, busy, error?.fieldErrors)
                : _historyStep(l10n, busy, error?.fieldErrors),
          ),
        ],
      ),
    );
  }

  Widget _physicalStep(
    AppLocalizations l10n,
    bool busy,
    Map<String, List<String>>? fieldErrors,
  ) {
    void onEdited(String _) {
      ref.read(clinicalProfileNotifierProvider.notifier).clearError();
      setState(() {});
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CauceTextField(
          key: const Key('profile_date_of_birth'),
          controller: _dateOfBirthController,
          label: l10n.clinicalProfileDateOfBirthLabel,
          hint: l10n.clinicalProfileDateHint,
          errorText: fieldErrors?['dateOfBirth']?.first,
          keyboardType: TextInputType.datetime,
          textInputAction: TextInputAction.next,
          enabled: !busy,
          validator: (value) => _validateDateOfBirth(value, l10n),
          onChanged: onEdited,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CauceButton.tertiary(
            key: const Key('profile_date_of_birth_picker'),
            label: l10n.clinicalProfilePickDate,
            onPressed: busy ? null : _pickDateOfBirth,
          ),
        ),
        const SizedBox(height: CauceSpacing.space4),
        CauceChoiceField<BiologicalSexOption>(
          key: const Key('profile_biological_sex'),
          label: l10n.clinicalProfileBiologicalSexLabel,
          value: _biologicalSex,
          errorText:
              _biologicalSexError ?? fieldErrors?['biologicalSex']?.first,
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
          errorText: fieldErrors?['weightKg']?.first,
          // Con signo: un peso negativo se escribe y se rechaza con su aviso.
          keyboardType: const TextInputType.numberWithOptions(
            signed: true,
            decimal: true,
          ),
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
          errorText: fieldErrors?['heightCm']?.first,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.done,
          enabled: !busy,
          validator: (value) => Validators.heightCm(value, l10n),
          onChanged: onEdited,
        ),
        const SizedBox(height: CauceSpacing.space4),
        BmiSummaryCard(bmi: _bmi, category: BmiCalculator.categorize(_bmi)),
        const SizedBox(height: CauceSpacing.space6),
        CauceButton(
          key: const Key('profile_continue'),
          label: l10n.commonContinue,
          onPressed: busy ? null : () => _continue(l10n),
        ),
      ],
    );
  }

  Widget _historyStep(
    AppLocalizations l10n,
    bool busy,
    Map<String, List<String>>? fieldErrors,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CauceChoiceField<IbsSubtypeOption>(
          key: const Key('profile_ibs_subtype'),
          label: l10n.clinicalProfileIbsSubtypeLabel,
          value: _ibsSubtype,
          errorText: _ibsSubtypeError ?? fieldErrors?['ibsSubtype']?.first,
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
        ProfileDateField(
          fieldKey: const Key('profile_diagnosis_date'),
          label: l10n.clinicalProfileDiagnosisDateLabel,
          value: _diagnosisDate,
          errorText: fieldErrors?['diagnosisDate']?.first,
          enabled: !busy,
          onTap: _pickDiagnosisDate,
        ),
        const SizedBox(height: CauceSpacing.space4),
        CauceTextField(
          key: const Key('profile_medications'),
          controller: _medicationsController,
          label: l10n.clinicalProfileMedicationsLabel,
          hint: l10n.clinicalProfileMedicationsHint,
          errorText: fieldErrors?['medications']?.first,
          textInputAction: TextInputAction.done,
          enabled: !busy,
          validator: (value) => Validators.medications(value, l10n),
        ),
        const SizedBox(height: CauceSpacing.space6),
        AllergiesSection(
          selected: _allergies,
          enabled: !busy,
          noneKnown: _noneKnown,
          error: _allergiesError,
          onNoneKnownChanged: (value) => setState(() {
            _noneKnown = value;
            if (value) {
              _allergies.clear();
            }
            _allergiesError = null;
          }),
          onChanged: () => setState(() {
            if (_allergies.isNotEmpty) {
              _noneKnown = false;
            }
            _allergiesError = null;
          }),
        ),
        const SizedBox(height: CauceSpacing.space6),
        CauceButton(
          key: const Key('profile_submit'),
          label: l10n.clinicalProfileSubmit,
          loading: busy,
          onPressed: () => _submit(l10n),
        ),
        const SizedBox(height: CauceSpacing.space3),
        CauceButton.secondary(
          key: const Key('profile_back'),
          label: l10n.commonBack,
          onPressed: busy ? null : () => setState(() => _page = 0),
        ),
      ],
    );
  }
}

/// Aviso fijo del registro sin codigo de invitacion (CP055 paso 5).
class _NoInvitationNotice extends StatelessWidget {
  const _NoInvitationNotice();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      key: const Key('profile_no_invitation_notice'),
      margin: const EdgeInsets.only(bottom: CauceSpacing.space4),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: const BoxDecoration(
        color: CauceColors.infoBg,
        borderRadius: CauceRadii.borderMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            TablerIcons.info_circle,
            size: 20,
            color: CauceColors.infoText,
          ),
          const SizedBox(width: CauceSpacing.space2),
          Expanded(
            child: Text(
              l10n.clinicalProfileNoInvitationNotice,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
