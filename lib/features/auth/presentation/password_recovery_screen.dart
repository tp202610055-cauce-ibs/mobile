import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/cauce_error_banner.dart';
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

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(TablerIcons.arrow_left),
          tooltip: l10n.commonBack,
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: CauceSpacing.space4,
            vertical: CauceSpacing.space6,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    l10n.passwordRecoveryTitle,
                    style: textTheme.headlineLarge,
                  ),
                  const SizedBox(height: CauceSpacing.space2),
                  Text(
                    l10n.passwordRecoverySubtitle,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: CauceSpacing.space6),
                  if (error != null) ...<Widget>[
                    CauceErrorBanner(error: error),
                    const SizedBox(height: CauceSpacing.space4),
                  ],
                  TextFormField(
                    key: const Key('recovery_email'),
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: l10n.passwordRecoveryEmailLabel,
                      hintText: l10n.loginEmailHint,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    autofillHints: const <String>[AutofillHints.email],
                    enabled: !state.isSubmitting,
                    validator: (value) => Validators.email(value, l10n),
                    onFieldSubmitted: (_) => _submit(),
                    onChanged: (_) => ref
                        .read(passwordRecoveryNotifierProvider.notifier)
                        .clearError(),
                  ),
                  const SizedBox(height: CauceSpacing.space6),
                  ElevatedButton(
                    key: const Key('recovery_submit'),
                    onPressed: state.isSubmitting ? null : _submit,
                    child: state.isSubmitting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: CauceColors.textOnBrand,
                            ),
                          )
                        : Text(l10n.passwordRecoverySubmit),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Confirmacion de US07 CA01.
///
/// Sin logica: el backend responde 200 exista o no la cuenta, de modo que no
/// hay nada que consultar ni que distinguir. El texto lo dice explicitamente
/// para que el paciente no interprete el mensaje como confirmacion de que su
/// correo esta registrado.
class PasswordRecoverySentScreen extends StatelessWidget {
  const PasswordRecoverySentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(CauceSpacing.space6),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.all(CauceSpacing.space4),
                    decoration: const BoxDecoration(
                      color: CauceColors.successBg,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      TablerIcons.mail,
                      size: 32,
                      color: CauceColors.successText,
                    ),
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
                  ElevatedButton(
                    key: const Key('recovery_sent_back_to_login'),
                    onPressed: () => context.go(AppRoutes.login),
                    child: Text(l10n.passwordRecoverySentBackToLogin),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
