import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/error_messages.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/router/pending_password_reset_link.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/password_reset_link_notifier.dart';
import '../application/password_reset_notifier.dart';
import 'widgets/password_requirements.dart';

/// US07 CA02. Restablecimiento con el token del deep link.
class PasswordResetScreen extends ConsumerStatefulWidget {
  const PasswordResetScreen({required this.token, super.key});

  /// Token que viaja en `cauce://auth/password-reset?token=xxx`.
  ///
  /// Puede llegar vacio si el enlace estaba mal formado. En ese caso el envio
  /// falla contra el backend y la pantalla ofrece pedir uno nuevo, que es mas
  /// util que bloquear el formulario de entrada.
  final String token;

  @override
  ConsumerState<PasswordResetScreen> createState() =>
      _PasswordResetScreenState();
}

class _PasswordResetScreenState extends ConsumerState<PasswordResetScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmationController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    FocusScope.of(context).unfocus();

    final pendingLink = ref.read(pendingPasswordResetLinkProvider.notifier);
    final done = await ref
        .read(passwordResetNotifierProvider.notifier)
        .submit(token: widget.token, newPassword: _passwordController.text);

    if (done) {
      pendingLink.clear();
    }
    if (!done || !mounted) {
      return;
    }
    await _showSuccessDialog();
  }

  Future<void> _showSuccessDialog() async {
    final l10n = AppLocalizations.of(context);
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.passwordResetSuccessTitle),
        content: Text(l10n.passwordResetSuccessBody),
        actions: <Widget>[
          TextButton(
            key: const Key('reset_success_ok'),
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(l10n.commonAccept),
          ),
        ],
      ),
    );
    if (mounted) {
      // `go` y no `push`: la sesion anterior quedo invalidada del lado
      // servidor, asi que no hay pila a la que volver.
      context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final link = ref.watch(passwordResetLinkProvider(widget.token));
    if (link.isLoading) {
      return const CauceScaffold(body: CauceLoadingIndicator.fullscreen());
    }
    if (link.valueOrNull == PasswordResetLinkStatus.noLongerValid) {
      return _LinkNoLongerValid(l10n: l10n);
    }

    final state = ref.watch(passwordResetNotifierProvider);
    final error = state.error;
    final fieldErrors = error?.fieldErrors ?? const <String, List<String>>{};

    void clearError(String _) =>
        ref.read(passwordResetNotifierProvider.notifier).clearError();

    return CauceScaffold(
      scrollable: true,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(l10n.passwordResetTitle, style: textTheme.headlineLarge),
            const SizedBox(height: CauceSpacing.space2),
            Text(l10n.passwordResetSubtitle, style: textTheme.bodyMedium),
            const SizedBox(height: CauceSpacing.space6),
            if (error != null) ...<Widget>[
              CauceErrorBanner(error: error),
              const SizedBox(height: CauceSpacing.space3),
              // El enlace ya no sirve: reintentar con el mismo token no va a
              // funcionar nunca, asi que se ofrece la salida.
              if (state.needsFreshLink)
                CauceButton.secondary(
                  key: const Key('reset_request_new_link'),
                  label: l10n.passwordResetRequestNewLink,
                  onPressed: () => _requestNewLink(context, ref),
                ),
              const SizedBox(height: CauceSpacing.space3),
            ],
            CauceTextField.password(
              key: const Key('reset_password'),
              controller: _passwordController,
              label: l10n.passwordResetNewPasswordLabel,
              errorText: fieldErrors['newPassword']?.first,
              textInputAction: TextInputAction.next,
              enabled: !state.isSubmitting,
              validator: (value) => Validators.newPassword(value, l10n),
              onChanged: clearError,
            ),
            PasswordRequirements(controller: _passwordController),
            const SizedBox(height: CauceSpacing.space4),
            CauceTextField.password(
              key: const Key('reset_password_confirmation'),
              controller: _confirmationController,
              label: l10n.passwordResetConfirmLabel,
              enabled: !state.isSubmitting,
              validator: (value) => Validators.passwordConfirmation(
                value,
                _passwordController.text,
                l10n,
              ),
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: CauceSpacing.space6),
            CauceButton(
              key: const Key('reset_submit'),
              label: l10n.passwordResetSubmit,
              loading: state.isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

/// Abandona el enlace actual y lleva a pedir uno nuevo.
void _requestNewLink(BuildContext context, WidgetRef ref) {
  ref.read(pendingPasswordResetLinkProvider.notifier).clear();
  context.go(AppRoutes.passwordRecovery);
}

/// El enlace ya no sirve: se informa y se ofrece pedir uno nuevo, sin formulario.
class _LinkNoLongerValid extends ConsumerWidget {
  const _LinkNoLongerValid({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textTheme = Theme.of(context).textTheme;
    return CauceScaffold(
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l10n.passwordResetTitle, style: textTheme.headlineLarge),
          const SizedBox(height: CauceSpacing.space4),
          Text(
            l10n.passwordResetLinkInvalid,
            key: const Key('reset_link_invalid'),
            style: textTheme.bodyLarge,
          ),
          const SizedBox(height: CauceSpacing.space6),
          CauceButton(
            key: const Key('reset_request_new_link'),
            label: l10n.passwordResetRequestNewLink,
            onPressed: () => _requestNewLink(context, ref),
          ),
        ],
      ),
    );
  }
}
