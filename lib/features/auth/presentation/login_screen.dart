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
  bool _obscurePassword = true;

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

    return Scaffold(
      body: SafeArea(
        child: Center(
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
                    Text(l10n.loginTitle, style: textTheme.displayLarge),
                    const SizedBox(height: CauceSpacing.space2),
                    Text(l10n.loginSubtitle, style: textTheme.bodyMedium),
                    const SizedBox(height: CauceSpacing.space6),

                    if (error != null) ...<Widget>[
                      CauceErrorBanner(error: error),
                      const SizedBox(height: CauceSpacing.space4),
                    ],

                    TextFormField(
                      key: const Key('login_email'),
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: l10n.loginEmailLabel,
                        hintText: l10n.loginEmailHint,
                        errorText: fieldErrors['email']?.first,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      autofillHints: const <String>[AutofillHints.email],
                      enabled: !state.isSubmitting,
                      validator: (value) => Validators.email(value, l10n),
                      onChanged: (_) =>
                          ref.read(loginNotifierProvider.notifier).clearError(),
                    ),
                    const SizedBox(height: CauceSpacing.space4),

                    TextFormField(
                      key: const Key('login_password'),
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: l10n.loginPasswordLabel,
                        hintText: l10n.loginPasswordHint,
                        errorText: fieldErrors['password']?.first,
                        suffixIcon: IconButton(
                          key: const Key('login_toggle_password'),
                          icon: Icon(
                            _obscurePassword
                                ? TablerIcons.eye
                                : TablerIcons.eye_off,
                          ),
                          tooltip: _obscurePassword
                              ? l10n.loginShowPassword
                              : l10n.loginHidePassword,
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                      ),
                      obscureText: _obscurePassword,
                      textInputAction: TextInputAction.done,
                      autofillHints: const <String>[AutofillHints.password],
                      enabled: !state.isSubmitting,
                      validator: (value) =>
                          Validators.requiredPassword(value, l10n),
                      onFieldSubmitted: (_) => _submit(),
                      onChanged: (_) =>
                          ref.read(loginNotifierProvider.notifier).clearError(),
                    ),
                    const SizedBox(height: CauceSpacing.space6),

                    ElevatedButton(
                      key: const Key('login_submit'),
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
                          : Text(l10n.loginSubmit),
                    ),
                    const SizedBox(height: CauceSpacing.space2),

                    TextButton(
                      key: const Key('login_forgot_password'),
                      onPressed: state.isSubmitting
                          ? null
                          : () => context.push(AppRoutes.passwordRecovery),
                      child: Text(l10n.loginForgotPassword),
                    ),
                    const SizedBox(height: CauceSpacing.space4),

                    // Wrap y no Row: con el texto de es_PE y la fuente Inter,
                    // el par pregunta mas boton desborda en pantallas
                    // angostas. Wrap baja el boton a la linea siguiente en vez
                    // de recortar.
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: <Widget>[
                        Text(
                          l10n.loginNoAccountPrompt,
                          style: textTheme.bodyMedium,
                        ),
                        TextButton(
                          key: const Key('login_create_account'),
                          onPressed: state.isSubmitting
                              ? null
                              : () => context.push(AppRoutes.register),
                          child: Text(l10n.loginCreateAccount),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
