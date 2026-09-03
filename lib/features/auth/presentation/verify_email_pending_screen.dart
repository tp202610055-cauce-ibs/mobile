import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/session_notifier.dart';

/// Aviso posterior al registro (US01 CA01).
///
/// Sin polling ni reintentos. El paciente cierra la app, sigue el enlace del
/// correo y en su proximo login llega con `emailVerified` en true.
///
/// No hay boton de reenvio de correo: el backend no expone ese endpoint, y el
/// contrato lo declara explicitamente como inexistente. Ofrecer un boton que
/// no hace nada seria peor que no tenerlo, asi que se deriva a soporte.
class VerifyEmailPendingScreen extends ConsumerWidget {
  const VerifyEmailPendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final email = ref.watch(sessionNotifierProvider).email ?? '';

    return CauceScaffold(
      scrollable: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(CauceSpacing.space4),
            decoration: const BoxDecoration(
              color: CauceColors.infoBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              TablerIcons.mail,
              size: 32,
              color: CauceColors.infoText,
            ),
          ),
          const SizedBox(height: CauceSpacing.space6),
          Text(
            l10n.verifyEmailPendingTitle,
            style: textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CauceSpacing.space3),
          Text(
            l10n.verifyEmailPendingBody(email),
            key: const Key('verify_email_body'),
            style: textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CauceSpacing.space4),
          Text(
            l10n.verifyEmailPendingNoEmailHint,
            style: textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CauceSpacing.space8),
          CauceButton.secondary(
            key: const Key('verify_email_logout'),
            label: l10n.verifyEmailPendingLogout,
            onPressed: () =>
                ref.read(sessionNotifierProvider.notifier).logout(),
          ),
        ],
      ),
    );
  }
}
