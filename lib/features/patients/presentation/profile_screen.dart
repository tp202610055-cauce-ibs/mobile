import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../onboarding/presentation/widgets/onboarding_labels.dart';
import '../data/patients_repository.dart';
import '../domain/patient_profile.dart';

/// Perfil del paciente: sus datos clinicos y la entrada a privacidad.
///
/// Solo lectura. La edicion del perfil es US03 CA03, que sigue diferida: el
/// backend ya expone `PUT /patients/profile`, pero abrirla aca sin su propio
/// tratamiento de validacion y confirmacion seria adelantar media historia.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(patientProfileProvider);

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.profileTitle, showBackButton: true),
      scrollable: true,
      body: profile.when(
        loading: () => CauceLoadingIndicator.fullscreen(
          message: l10n.commonLoading,
        ),
        error: (error, _) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (error is CauceApiError)
              CauceErrorBanner(error: error)
            else
              Text(l10n.profileLoadError, textAlign: TextAlign.center),
            const SizedBox(height: CauceSpacing.space4),
            CauceButton.secondary(
              key: const Key('profile_retry'),
              label: l10n.commonRetry,
              onPressed: () => ref.invalidate(patientProfileProvider),
            ),
            const SizedBox(height: CauceSpacing.space6),
            // La privacidad no depende del perfil clinico: aunque la consulta
            // falle, el paciente tiene que poder llegar a su consentimiento.
            const _PrivacyEntry(),
          ],
        ),
        data: (value) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (value != null) ...<Widget>[
              _ClinicalCard(profile: value),
              const SizedBox(height: CauceSpacing.space6),
            ],
            const _PrivacyEntry(),
          ],
        ),
      ),
    );
  }
}

/// Resumen de los datos clinicos, en el mismo registro neutro del wizard.
class _ClinicalCard extends StatelessWidget {
  const _ClinicalCard({required this.profile});

  final PatientProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final subtype = profile.ibsSubtype;
    final category = profile.bmiCategory;

    return Container(
      key: const Key('profile_clinical_card'),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderLg,
        border: Border.all(color: CauceColors.bgDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.profileClinicalSection, style: textTheme.titleMedium),
          const SizedBox(height: CauceSpacing.space3),
          _Row(label: l10n.profileAge(profile.age)),
          if (subtype != null)
            _Row(
              label: OnboardingLabels.ibsSubtype(l10n, subtype),
              detail: OnboardingLabels.ibsSubtypeDescription(l10n, subtype),
            ),
          _Row(
            label: l10n.bmiValue(profile.bmi.toStringAsFixed(2)),
            detail: category == null
                ? null
                : OnboardingLabels.bmiCategory(l10n, category),
          ),
          _Row(
            label: profile.allergies.isEmpty
                ? l10n.profileAllergiesNone
                : l10n.profileAllergiesCount(profile.allergies.length),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, this.detail});

  final String label;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final extra = detail;

    return Padding(
      padding: const EdgeInsets.only(bottom: CauceSpacing.space2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text(label, style: textTheme.bodyLarge),
          if (extra != null) ...<Widget>[
            const SizedBox(width: CauceSpacing.space2),
            Flexible(child: Text(extra, style: textTheme.labelSmall)),
          ],
        ],
      ),
    );
  }
}

/// Acceso a la seccion de privacidad.
class _PrivacyEntry extends StatelessWidget {
  const _PrivacyEntry();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(l10n.profilePrivacySection, style: textTheme.titleMedium),
        const SizedBox(height: CauceSpacing.space3),
        Material(
          color: CauceColors.bgCard,
          borderRadius: CauceRadii.borderMd,
          child: InkWell(
            key: const Key('profile_privacy_entry'),
            borderRadius: CauceRadii.borderMd,
            onTap: () => context.go(AppRoutes.profilePrivacy),
            child: Container(
              constraints: const BoxConstraints(
                minHeight: CauceSizes.touchTargetMin,
              ),
              padding: const EdgeInsets.all(CauceSpacing.space4),
              decoration: BoxDecoration(
                borderRadius: CauceRadii.borderMd,
                border: Border.all(color: CauceColors.bgDivider),
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          l10n.profilePrivacyEntry,
                          style: textTheme.bodyLarge,
                        ),
                        Text(
                          l10n.profilePrivacyEntryHint,
                          style: textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  const Icon(TablerIcons.chevron_right, size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
