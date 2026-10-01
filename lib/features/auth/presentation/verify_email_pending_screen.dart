import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/resend_verification_notifier.dart';
import '../application/session_notifier.dart';

/// Aviso posterior al registro (US01 CA01).
///
/// Sin polling. El paciente cierra la app, sigue el enlace del correo y en su
/// proximo login llega con `emailVerified` en true.
///
/// **Con boton de reenvio.** Cuando se escribio esta pantalla el backend no
/// tenia el endpoint y se derivaba a soporte; despues sumo
/// `POST /auth/verification-email/resend`, pero el boton nunca llego y el
/// "soporte" no existe (revision manual del 28-sep). El limite lo aplica el
/// backend, tres por hora por correo, y el 429 se muestra con su espera.
class VerifyEmailPendingScreen extends ConsumerWidget {
  const VerifyEmailPendingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final email = ref.watch(sessionNotifierProvider).email ?? '';
    final resend = ref.watch(resendVerificationNotifierProvider);

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
          if (resend.error != null) ...<Widget>[
            CauceErrorBanner(error: resend.error!),
            const SizedBox(height: CauceSpacing.space4),
          ],
          if (resend is ResendVerificationSent) ...<Widget>[
            Text(
              l10n.verifyEmailResent,
              key: const Key('verify_email_resent'),
              style: textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: CauceSpacing.space4),
          ],
          CauceButton(
            key: const Key('verify_email_resend'),
            label: l10n.verifyEmailResend,
            loading: resend.isSending,
            onPressed: email.isEmpty
                ? null
                : () => ref
                    .read(resendVerificationNotifierProvider.notifier)
                    .resend(email: email),
          ),
          const SizedBox(height: CauceSpacing.space3),
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
