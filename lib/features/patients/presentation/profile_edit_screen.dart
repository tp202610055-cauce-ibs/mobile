import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../onboarding/presentation/widgets/onboarding_labels.dart';
import '../application/profile_edit_notifier.dart';
import '../domain/patient_profile.dart';

/// Edición de peso, estatura y subtipo de SII (HU0028, CP009, CP071, CP078).
class ProfileEditScreen extends ConsumerWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(editableProfileProvider);

    return CauceScaffold(
      key: const Key('profile_edit_screen'),
      // El mismo camino que el atrás del sistema: respeta un PopScope.
      appBar: CauceAppBar(
        title: l10n.profileEditTitle,
        showBackButton: true,
        onBack: () => Navigator.of(context).maybePop(),
      ),
      scrollable: true,
      body: profile.when(
        loading: () =>
            CauceLoadingIndicator.fullscreen(message: l10n.commonLoading),
        error: (_, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(l10n.profileLoadError, textAlign: TextAlign.center),
            const SizedBox(height: CauceSpacing.space4),
            CauceButton.secondary(
              label: l10n.commonRetry,
              onPressed: () => ref.invalidate(editableProfileProvider),
            ),
          ],
        ),
        data: (value) => value == null
            ? Text(l10n.profileLoadError, textAlign: TextAlign.center)
            : _EditForm(profile: value),
      ),
    );
  }
}

class _EditForm extends ConsumerStatefulWidget {
  const _EditForm({required this.profile});

  final PatientProfile profile;

  @override
  ConsumerState<_EditForm> createState() => _EditFormState();
}

class _EditFormState extends ConsumerState<_EditForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _weight =
      TextEditingController(text: _format(widget.profile.weightKg));
  late final TextEditingController _height =
      TextEditingController(text: _format(widget.profile.heightCm));
  late IbsSubtypeOption? _subtype = widget.profile.ibsSubtype;

  @override
  void dispose() {
    _weight.dispose();
    _height.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final l10n = AppLocalizations.of(context);
    final subtype = _subtype;
    if (!(_formKey.currentState?.validate() ?? false) || subtype == null) {
      return;
    }
    final saved = await ref.read(profileEditNotifierProvider.notifier).save(
          weightKg: parseBiometric(_weight.text)!,
          heightCm: parseBiometric(_height.text)!,
          ibsSubtype: subtype,
        );
    if (!saved || !mounted) {
      return;
    }
    CauceToast.success(context, title: l10n.profileEditSaved);
    context.pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(profileEditNotifierProvider);
    final error = state.error;

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (error != null) ...<Widget>[
            CauceErrorBanner(error: error),
            const SizedBox(height: CauceSpacing.space4),
          ],
          CauceTextField(
            key: const Key('profile_edit_weight'),
            controller: _weight,
            label: l10n.clinicalProfileWeightLabel,
            keyboardType: const TextInputType.numberWithOptions(
              decimal: true,
              signed: true,
            ),
            enabled: !state.saving,
            validator: (value) => validateEditedWeight(value, l10n),
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceTextField(
            key: const Key('profile_edit_height'),
            controller: _height,
            label: l10n.clinicalProfileHeightLabel,
            keyboardType: TextInputType.text,
            enabled: !state.saving,
            validator: (value) => validateEditedHeight(value, l10n),
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceChoiceField<IbsSubtypeOption>(
            key: const Key('profile_edit_subtype'),
            label: l10n.clinicalProfileIbsSubtypeLabel,
            value: _subtype,
            enabled: !state.saving,
            onChanged: (value) => setState(() => _subtype = value),
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
          const SizedBox(height: CauceSpacing.space6),
          CauceButton(
            key: const Key('profile_edit_save'),
            label: l10n.profileEditSave,
            loading: state.saving,
            onPressed: state.saving ? null : _save,
          ),
        ],
      ),
    );
  }

  String _format(double value) => value == value.roundToDouble()
      ? value.toInt().toString()
      : value.toString();
}

/// Lee un número escrito con coma o punto decimal; `null` si no es finito.
double? parseBiometric(String? value) => Validators.parseDecimal(value);

/// Peso editado: obligatorio, numérico, no negativo y en el rango del perfil.
@visibleForTesting
String? validateEditedWeight(String? value, AppLocalizations l10n) => _validate(
      value,
      required: l10n.validationWeightRequired,
      notNumber: l10n.validationWeightNotNumber,
      negative: l10n.validationWeightNegative,
      inRange: (raw) => Validators.weightKg(raw, l10n),
    );

/// Estatura editada, con las mismas reglas que el peso.
@visibleForTesting
String? validateEditedHeight(String? value, AppLocalizations l10n) => _validate(
      value,
      required: l10n.validationHeightRequired,
      notNumber: l10n.validationHeightNotNumber,
      negative: l10n.validationHeightNegative,
      inRange: (raw) => Validators.heightCm(raw, l10n),
    );

String? _validate(
  String? value, {
  required String required,
  required String notNumber,
  required String negative,
  required String? Function(String raw) inRange,
}) {
  final raw = (value ?? '').trim();
  if (raw.isEmpty) {
    return required;
  }
  final number = parseBiometric(raw);
  if (number == null) {
    return notNumber;
  }
  if (number < 0) {
    return negative;
  }
  return inRange(raw);
}
