import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../application/consent_download_notifier.dart';

/// Abre el texto completo del consentimiento en una hoja desplazable.
Future<void> showConsentTextSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _ConsentTextSheet(),
  );
}

class _ConsentTextSheet extends ConsumerWidget {
  const _ConsentTextSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final document = ref.watch(consentDocumentProvider);

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.9,
      builder: (context, controller) => ListView(
        controller: controller,
        padding: const EdgeInsets.all(CauceSpacing.space4),
        children: <Widget>[
          Text(l10n.consentTextTitle, style: textTheme.titleLarge),
          const SizedBox(height: CauceSpacing.space3),
          ...document.when(
            loading: () => <Widget>[
              CauceLoadingIndicator.fullscreen(message: l10n.commonLoading),
            ],
            error: (_, __) => <Widget>[
              Text(l10n.consentTextLoadError),
              const SizedBox(height: CauceSpacing.space3),
              CauceButton.secondary(
                label: l10n.commonRetry,
                onPressed: () => ref.invalidate(consentDocumentProvider),
              ),
            ],
            data: (consent) => <Widget>[
              Text(
                l10n.consentTextVersion(consent.version),
                key: const Key('consent_text_version'),
                style: textTheme.labelMedium,
              ),
              const SizedBox(height: CauceSpacing.space3),
              SelectableText(
                consent.text,
                key: const Key('consent_text_body'),
                style: textTheme.bodyMedium,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
