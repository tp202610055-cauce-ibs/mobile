import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../onboarding/presentation/widgets/onboarding_labels.dart';
import '../application/consent_download_notifier.dart';
import '../data/patients_repository.dart';

/// Privacidad y derechos del paciente (HU0001 escenario 4, CP004 paso 2).
///
/// Por ahora expone un solo derecho, la descarga del consentimiento. El resto
/// de los que declara la Ley N° 29733 y que el backend ya publica, la
/// exportacion de datos y la baja de cuenta, aterrizan en un bloque posterior;
/// la pantalla esta armada como lista de secciones para que sumarlos sea
/// agregar una tarjeta.
class PrivacyScreen extends ConsumerWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final consent = ref.watch(acceptedConsentProvider);

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.privacyTitle, showBackButton: true),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l10n.privacySubtitle, style: textTheme.bodyMedium),
          const SizedBox(height: CauceSpacing.space6),
          consent.when(
            loading: () => CauceLoadingIndicator.fullscreen(
              message: l10n.privacyConsentLoading,
            ),
            error: (error, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (error is CauceApiError)
                  CauceErrorBanner(error: error)
                else
                  Text(l10n.errorUnknown, textAlign: TextAlign.center),
                const SizedBox(height: CauceSpacing.space3),
                CauceButton.secondary(
                  key: const Key('privacy_consent_retry'),
                  label: l10n.commonRetry,
                  onPressed: () => ref.invalidate(acceptedConsentProvider),
                ),
              ],
            ),
            data: (value) => _ConsentCard(consent: value),
          ),
        ],
      ),
    );
  }
}

/// Tarjeta del consentimiento aceptado, con su descarga.
class _ConsentCard extends ConsumerWidget {
  const _ConsentCard({required this.consent});

  final AcceptedConsent consent;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(consentDownloadNotifierProvider);
    final error = state.error;

    return Container(
      key: const Key('privacy_consent_card'),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderLg,
        border: Border.all(color: CauceColors.bgDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l10n.privacyConsentTitle, style: textTheme.titleMedium),
          const SizedBox(height: CauceSpacing.space2),
          // Version y fecha de lo que el paciente acepto, no de lo vigente
          // hoy. Los resuelve `GET /patients/me/consent`.
          Text(
            l10n.privacyConsentVersion(consent.documentVersion),
            key: const Key('privacy_consent_version'),
            style: textTheme.bodyLarge,
          ),
          Text(
            l10n.privacyConsentAcceptedOn(
              OnboardingLabels.date(consent.acceptedAt.toLocal()),
            ),
            key: const Key('privacy_consent_date'),
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: CauceSpacing.space3),
          Text(l10n.privacyConsentBody, style: textTheme.bodyMedium),
          if (!consent.textAvailable) ...<Widget>[
            const SizedBox(height: CauceSpacing.space4),
            // Sin texto guardado el backend responde 404. Se avisa antes en
            // vez de dejar que el paciente toque un boton que va a fallar, y
            // se aclara que su aceptacion sigue siendo valida: lo que falta es
            // la copia, no el consentimiento.
            Container(
              key: const Key('privacy_consent_unavailable'),
              padding: const EdgeInsets.all(CauceSpacing.space3),
              decoration: const BoxDecoration(
                color: CauceColors.warningBg,
                borderRadius: CauceRadii.borderMd,
              ),
              child: Text(
                l10n.privacyConsentTextUnavailable,
                style: textTheme.bodyMedium?.copyWith(
                  color: CauceColors.warningText,
                ),
              ),
            ),
          ],
          if (error != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space4),
            CauceErrorBanner(error: error),
          ],
          if (state is ConsentShared) ...<Widget>[
            const SizedBox(height: CauceSpacing.space4),
            Container(
              key: const Key('privacy_consent_done'),
              padding: const EdgeInsets.all(CauceSpacing.space3),
              decoration: const BoxDecoration(
                color: CauceColors.successBg,
                borderRadius: CauceRadii.borderMd,
              ),
              child: Text(
                l10n.privacyConsentDownloaded,
                style: textTheme.bodyMedium?.copyWith(
                  color: CauceColors.successText,
                ),
              ),
            ),
          ],
          const SizedBox(height: CauceSpacing.space4),
          CauceButton(
            key: const Key('privacy_consent_download'),
            label: l10n.privacyConsentDownload,
            loading: state.isDownloading,
            // Sin texto no hay PDF que emitir: el boton queda deshabilitado y
            // el aviso de arriba explica por que.
            onPressed: consent.textAvailable
                ? () => ref
                    .read(consentDownloadNotifierProvider.notifier)
                    .download()
                : null,
          ),
          if (consent.textAvailable) ...<Widget>[
            const SizedBox(height: CauceSpacing.space2),
            Text(
              l10n.privacyConsentDownloadHint,
              style: textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
