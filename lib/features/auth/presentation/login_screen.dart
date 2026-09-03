import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/error_messages.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/login_notifier.dart';

/// US05. Inicio de sesion.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    // Cierra el teclado: el banner de error aparece arriba del formulario y
    // con el teclado abierto quedaria fuera de vista.
    FocusScope.of(context).unfocus();

    await ref.read(loginNotifierProvider.notifier).submit(
          email: _emailController.text,
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(loginNotifierProvider);
    final error = state.error;

    // Errores por campo que devuelve el backend, en camelCase desde v1.1.
    final fieldErrors = error?.fieldErrors ?? const <String, List<String>>{};

    void clearError(String _) =>
        ref.read(loginNotifierProvider.notifier).clearError();

    return CauceScaffold(
      scrollable: true,
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(l10n.loginTitle, style: textTheme.displayLarge),
            const SizedBox(height: CauceSpacing.space2),
            Text(l10n.loginSubtitle, style: textTheme.bodyMedium),
            const SizedBox(height: CauceSpacing.space6),

            if (error != null) ...<Widget>[
              CauceErrorBanner(error: error),
              const SizedBox(height: CauceSpacing.space4),
            ],

            CauceTextField.email(
              key: const Key('login_email'),
              controller: _emailController,
              label: l10n.loginEmailLabel,
              hint: l10n.loginEmailHint,
              errorText: fieldErrors['email']?.first,
              enabled: !state.isSubmitting,
              validator: (value) => Validators.email(value, l10n),
              onChanged: clearError,
            ),
            const SizedBox(height: CauceSpacing.space4),

            CauceTextField.password(
              key: const Key('login_password'),
              controller: _passwordController,
              label: l10n.loginPasswordLabel,
              hint: l10n.loginPasswordHint,
              errorText: fieldErrors['password']?.first,
              autofillHints: const <String>[AutofillHints.password],
              enabled: !state.isSubmitting,
              validator: (value) => Validators.requiredPassword(value, l10n),
              onChanged: clearError,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: CauceSpacing.space6),

            CauceButton(
              key: const Key('login_submit'),
              label: l10n.loginSubmit,
              loading: state.isSubmitting,
              onPressed: _submit,
            ),
            const SizedBox(height: CauceSpacing.space2),

            CauceButton.tertiary(
              key: const Key('login_forgot_password'),
              label: l10n.loginForgotPassword,
              onPressed: state.isSubmitting
                  ? null
                  : () => context.push(AppRoutes.passwordRecovery),
            ),
            const SizedBox(height: CauceSpacing.space4),

            // Wrap y no Row: con el texto de es_PE y la fuente Inter, el par
            // pregunta mas boton desborda en pantallas angostas.
            Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(l10n.loginNoAccountPrompt, style: textTheme.bodyMedium),
                CauceButton.tertiary(
                  key: const Key('login_create_account'),
                  label: l10n.loginCreateAccount,
                  onPressed: state.isSubmitting
                      ? null
                      : () => context.push(AppRoutes.register),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
