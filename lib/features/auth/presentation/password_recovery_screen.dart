import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/password_recovery_notifier.dart';

/// US07 CA01. Solicitud del enlace de recuperacion.
class PasswordRecoveryScreen extends ConsumerStatefulWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  ConsumerState<PasswordRecoveryScreen> createState() =>
      _PasswordRecoveryScreenState();
}

class _PasswordRecoveryScreenState
    extends ConsumerState<PasswordRecoveryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    FocusScope.of(context).unfocus();

    final sent = await ref
        .read(passwordRecoveryNotifierProvider.notifier)
        .submit(email: _emailController.text);

    if (sent && mounted) {
      context.push(AppRoutes.passwordRecoverySent);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(passwordRecoveryNotifierProvider);
    final error = state.error;

    return CauceScaffold(
      appBar: const CauceAppBar(showBackButton: true),
      scrollable: true,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(l10n.passwordRecoveryTitle, style: textTheme.headlineLarge),
            const SizedBox(height: CauceSpacing.space2),
            Text(l10n.passwordRecoverySubtitle, style: textTheme.bodyMedium),
            const SizedBox(height: CauceSpacing.space6),
            if (error != null) ...<Widget>[
              CauceErrorBanner(error: error),
              const SizedBox(height: CauceSpacing.space4),
            ],
            CauceTextField.email(
              key: const Key('recovery_email'),
              controller: _emailController,
              label: l10n.passwordRecoveryEmailLabel,
              hint: l10n.loginEmailHint,
              textInputAction: TextInputAction.done,
              enabled: !state.isSubmitting,
              validator: (value) => Validators.email(value, l10n),
              onChanged: (_) => ref
                  .read(passwordRecoveryNotifierProvider.notifier)
                  .clearError(),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: CauceSpacing.space6),
            CauceButton(
              key: const Key('recovery_submit'),
              label: l10n.passwordRecoverySubmit,
              loading: state.isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

/// Confirmacion de US07 CA01.
///
/// Sin logica: el backend responde 200 exista o no la cuenta, de modo que no
/// hay nada que consultar ni que distinguir. El texto lo dice explicitamente
/// para que el paciente no lo interprete como confirmacion de que su correo
/// esta registrado.
class PasswordRecoverySentScreen extends StatelessWidget {
  const PasswordRecoverySentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return CauceScaffold(
      scrollable: true,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const _CircledIcon(
            icon: TablerIcons.mail,
            background: CauceColors.successBg,
            foreground: CauceColors.successText,
          ),
          const SizedBox(height: CauceSpacing.space6),
          Text(
            l10n.passwordRecoverySentTitle,
            style: textTheme.headlineLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CauceSpacing.space3),
          Text(
            l10n.passwordRecoverySentBody,
            style: textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: CauceSpacing.space8),
          CauceButton(
            key: const Key('recovery_sent_back_to_login'),
            label: l10n.passwordRecoverySentBackToLogin,
            onPressed: () => context.go(AppRoutes.login),
          ),
        ],
      ),
    );
  }
}

/// Icono grande sobre un circulo de color, para pantallas de confirmacion.
class _CircledIcon extends StatelessWidget {
  const _CircledIcon({
    required this.icon,
    required this.background,
    required this.foreground,
  });

  final IconData icon;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: Icon(icon, size: 32, color: foreground),
    );
  }
}
