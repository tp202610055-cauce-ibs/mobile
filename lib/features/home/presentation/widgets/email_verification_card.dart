import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../auth/application/email_verification_reminder_notifier.dart';
import '../../../auth/application/resend_verification_notifier.dart';

/// Recordatorio de verificacion del correo. No bloquea nada.
///
/// Vuelve a comprobar en silencio cada vez que la app regresa a primer plano.
class EmailVerificationCard extends ConsumerStatefulWidget {
  const EmailVerificationCard({super.key});

  @override
  ConsumerState<EmailVerificationCard> createState() =>
      _EmailVerificationCardState();
}

class _EmailVerificationCardState extends ConsumerState<EmailVerificationCard> {
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _lifecycle = AppLifecycleListener(
      onResume: () =>
          ref.read(emailVerificationReminderProvider.notifier).check(),
    );
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reminder = ref.watch(emailVerificationReminderProvider);
    if (reminder is! EmailVerificationReminderVisible) {
      return const SizedBox.shrink();
    }

    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final resend = ref.watch(resendVerificationNotifierProvider);

    return Padding(
      padding: const EdgeInsets.only(bottom: CauceSpacing.space6),
      child: Container(
        key: const Key('home_email_reminder'),
        width: double.infinity,
        padding: const EdgeInsets.all(CauceSpacing.space4),
        decoration: const BoxDecoration(
          color: CauceColors.infoBg,
          borderRadius: CauceRadii.borderMd,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              l10n.verifyEmailPendingTitle,
              style: textTheme.titleMedium?.copyWith(
                color: CauceColors.infoText,
              ),
            ),
            const SizedBox(height: CauceSpacing.space1),
            Text(
              l10n.emailReminderBody(reminder.email),
              style: textTheme.bodyMedium,
            ),
            if (resend.error != null) ...<Widget>[
              const SizedBox(height: CauceSpacing.space3),
              CauceErrorBanner(error: resend.error!),
            ],
            if (resend is ResendVerificationSent) ...<Widget>[
              const SizedBox(height: CauceSpacing.space3),
              Text(
                l10n.emailReminderResent,
                key: const Key('home_email_reminder_resent'),
                style: textTheme.bodyMedium,
              ),
            ],
            if (reminder.error != null) ...<Widget>[
              const SizedBox(height: CauceSpacing.space3),
              CauceErrorBanner(
                key: const Key('home_email_reminder_error'),
                error: reminder.error!,
              ),
            ],
            if (reminder.stillPending) ...<Widget>[
              const SizedBox(height: CauceSpacing.space3),
              Text(
                l10n.emailReminderStillPending,
                key: const Key('home_email_reminder_still_pending'),
                style: textTheme.bodyMedium,
              ),
            ],
            const SizedBox(height: CauceSpacing.space3),
            Wrap(
              spacing: CauceSpacing.space2,
              children: <Widget>[
                CauceButton.tertiary(
                  key: const Key('home_email_reminder_resend'),
                  label: l10n.verifyEmailResend,
                  loading: resend.isSending,
                  onPressed: () => ref
                      .read(resendVerificationNotifierProvider.notifier)
                      .resend(email: reminder.email),
                ),
                CauceButton.tertiary(
                  key: const Key('home_email_reminder_confirm'),
                  label: l10n.emailReminderConfirm,
                  loading: reminder.checking,
                  onPressed: () => ref
                      .read(emailVerificationReminderProvider.notifier)
                      .confirm(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
