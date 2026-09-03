import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/error_messages.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/cauce_error_banner.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/password_reset_notifier.dart';

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
  bool _obscure = true;

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

    final done = await ref
        .read(passwordResetNotifierProvider.notifier)
        .submit(token: widget.token, newPassword: _passwordController.text);

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
    final state = ref.watch(passwordResetNotifierProvider);
    final error = state.error;
    final fieldErrors = error?.fieldErrors ?? const <String, List<String>>{};

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: CauceSpacing.space4,
            vertical: CauceSpacing.space8,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(l10n.passwordResetTitle, style: textTheme.headlineLarge),
                  const SizedBox(height: CauceSpacing.space2),
                  Text(
                    l10n.passwordResetSubtitle,
                    style: textTheme.bodyMedium,
                  ),
                  const SizedBox(height: CauceSpacing.space6),
                  if (error != null) ...<Widget>[
                    CauceErrorBanner(error: error),
                    const SizedBox(height: CauceSpacing.space3),
                    // El enlace ya no sirve: reintentar con el mismo token no
                    // va a funcionar nunca, asi que se ofrece la salida.
                    if (state.needsFreshLink)
                      OutlinedButton(
                        key: const Key('reset_request_new_link'),
                        onPressed: () => context.go(AppRoutes.passwordRecovery),
                        child: Text(l10n.passwordResetRequestNewLink),
                      ),
                    const SizedBox(height: CauceSpacing.space3),
                  ],
                  TextFormField(
                    key: const Key('reset_password'),
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: l10n.passwordResetNewPasswordLabel,
                      hintText: l10n.registerPasswordHint,
                      errorText: fieldErrors['newPassword']?.first,
                      suffixIcon: IconButton(
                        key: const Key('reset_toggle_password'),
                        icon: Icon(
                          _obscure ? TablerIcons.eye : TablerIcons.eye_off,
                        ),
                        tooltip: _obscure
                            ? l10n.loginShowPassword
                            : l10n.loginHidePassword,
                        onPressed: () => setState(() => _obscure = !_obscure),
                      ),
                    ),
                    obscureText: _obscure,
                    textInputAction: TextInputAction.next,
                    enabled: !state.isSubmitting,
                    validator: (value) => Validators.newPassword(value, l10n),
                    onChanged: (_) => ref
                        .read(passwordResetNotifierProvider.notifier)
                        .clearError(),
                  ),
                  const SizedBox(height: CauceSpacing.space4),
                  TextFormField(
                    key: const Key('reset_password_confirmation'),
                    controller: _confirmationController,
                    decoration: InputDecoration(
                      labelText: l10n.passwordResetConfirmLabel,
                    ),
                    obscureText: _obscure,
                    textInputAction: TextInputAction.done,
                    enabled: !state.isSubmitting,
                    validator: (value) => Validators.passwordConfirmation(
                      value,
                      _passwordController.text,
                      l10n,
                    ),
                    onFieldSubmitted: (_) => _submit(),
                  ),
                  const SizedBox(height: CauceSpacing.space6),
                  ElevatedButton(
                    key: const Key('reset_submit'),
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
                        : Text(l10n.passwordResetSubmit),
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
