import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/errors/error_messages.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/utils/validators.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/register_notifier.dart';
import '../data/auth_repository.dart';

/// US01 CA01, CA02 y CA03. Registro de paciente con consentimiento informado.
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmationController = TextEditingController();
  final _invitationCodeController = TextEditingController();

  /// US01 CA03. El envio queda bloqueado hasta que el paciente lo marque.
  bool _consentAccepted = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmationController.dispose();
    _invitationCodeController.dispose();
    super.dispose();
  }

  Future<void> _submit(CurrentConsent consent) async {
    if (!(_formKey.currentState?.validate() ?? false) || !_consentAccepted) {
      return;
    }
    FocusScope.of(context).unfocus();

    final ok = await ref.read(registerNotifierProvider.notifier).submit(
          email: _emailController.text,
          fullName: _fullNameController.text,
          password: _passwordController.text,
          // Se reenvian los del backend, sin recalcular el hash.
          consentDocumentVersion: consent.version,
          consentTextHash: consent.hash,
          invitationCode: _invitationCodeController.text,
        );

    if (!ok &&
        mounted &&
        ref.read(registerNotifierProvider).needsConsentReload) {
      // El consentimiento cambio mientras el paciente completaba el
      // formulario. Se recarga y se obliga a aceptarlo de nuevo: aceptar un
      // texto y firmar otro invalidaria el consentimiento.
      setState(() => _consentAccepted = false);
      ref.invalidate(currentConsentProvider);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final consent = ref.watch(currentConsentProvider);

    return CauceScaffold(
      appBar: const CauceAppBar(showBackButton: true),
      scrollable: true,
      body: consent.when(
        loading: () => _CenteredMessage(
          child: CauceLoadingIndicator.fullscreen(
            message: l10n.registerConsentLoading,
          ),
        ),
        // Sin consentimiento no hay registro posible: el backend rechaza
        // cualquier intento sin version y hash vigentes.
        error: (error, _) => _CenteredMessage(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // El repositorio traduce todo a CauceApiError antes de
              // propagarlo, asi que el `else` solo cubre un fallo inesperado
              // del propio provider.
              if (error is CauceApiError)
                CauceErrorBanner(error: error)
              else
                Text(l10n.errorUnknown, textAlign: TextAlign.center),
              const SizedBox(height: CauceSpacing.space4),
              CauceButton(
                key: const Key('register_retry_consent'),
                label: l10n.commonRetry,
                expand: false,
                onPressed: () => ref.invalidate(currentConsentProvider),
              ),
            ],
          ),
        ),
        data: (value) => _buildForm(context, l10n, value),
      ),
    );
  }

  Widget _buildForm(
    BuildContext context,
    AppLocalizations l10n,
    CurrentConsent consent,
  ) {
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(registerNotifierProvider);
    final error = state.error;
    final fieldErrors = error?.fieldErrors ?? const <String, List<String>>{};

    void onEdited(String _) =>
        ref.read(registerNotifierProvider.notifier).clearError();

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l10n.registerTitle, style: textTheme.headlineLarge),
          const SizedBox(height: CauceSpacing.space2),
          Text(l10n.registerSubtitle, style: textTheme.bodyMedium),
          const SizedBox(height: CauceSpacing.space6),
          if (error != null) ...<Widget>[
            CauceErrorBanner(error: error),
            const SizedBox(height: CauceSpacing.space4),
          ],
          CauceTextField(
            key: const Key('register_full_name'),
            controller: _fullNameController,
            label: l10n.registerFullNameLabel,
            hint: l10n.registerFullNameHint,
            errorText: fieldErrors['fullName']?.first,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            enabled: !state.isSubmitting,
            validator: (value) => Validators.fullName(value, l10n),
            onChanged: onEdited,
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceTextField.email(
            key: const Key('register_email'),
            controller: _emailController,
            label: l10n.registerEmailLabel,
            hint: l10n.registerEmailHint,
            errorText: fieldErrors['email']?.first,
            enabled: !state.isSubmitting,
            validator: (value) => Validators.email(value, l10n),
            onChanged: onEdited,
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceTextField.password(
            key: const Key('register_password'),
            controller: _passwordController,
            label: l10n.registerPasswordLabel,
            hint: l10n.registerPasswordHint,
            errorText: fieldErrors['password']?.first,
            textInputAction: TextInputAction.next,
            enabled: !state.isSubmitting,
            validator: (value) => Validators.newPassword(value, l10n),
            onChanged: onEdited,
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceTextField.password(
            key: const Key('register_password_confirmation'),
            controller: _confirmationController,
            label: l10n.registerPasswordConfirmLabel,
            textInputAction: TextInputAction.next,
            enabled: !state.isSubmitting,
            validator: (value) => Validators.passwordConfirmation(
              value,
              _passwordController.text,
              l10n,
            ),
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceTextField(
            key: const Key('register_invitation_code'),
            controller: _invitationCodeController,
            label: l10n.registerInvitationCodeLabel,
            hint: l10n.registerInvitationCodeHint,
            errorText: fieldErrors['invitationCode']?.first,
            textCapitalization: TextCapitalization.characters,
            textInputAction: TextInputAction.done,
            enabled: !state.isSubmitting,
            validator: (value) => Validators.invitationCode(value, l10n),
            onChanged: onEdited,
          ),
          const SizedBox(height: CauceSpacing.space6),
          _ConsentSection(
            consent: consent,
            accepted: _consentAccepted,
            enabled: !state.isSubmitting,
            onChanged: (value) => setState(() => _consentAccepted = value),
          ),
          const SizedBox(height: CauceSpacing.space6),
          CauceButton(
            key: const Key('register_submit'),
            label: l10n.registerSubmit,
            loading: state.isSubmitting,
            // US01 CA03: sin aceptacion, el boton no existe como accion.
            onPressed: _consentAccepted ? () => _submit(consent) : null,
          ),
          const SizedBox(height: CauceSpacing.space4),
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: <Widget>[
              Text(
                l10n.registerHasAccountPrompt,
                style: textTheme.bodyMedium,
              ),
              TextButton(
                key: const Key('register_go_to_login'),
                onPressed: state.isSubmitting ? null : () => context.pop(),
                child: Text(l10n.loginSubmit),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Texto del consentimiento vigente mas la casilla de aceptacion.
class _ConsentSection extends StatefulWidget {
  const _ConsentSection({
    required this.consent,
    required this.accepted,
    required this.enabled,
    required this.onChanged,
  });

  final CurrentConsent consent;
  final bool accepted;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  State<_ConsentSection> createState() => _ConsentSectionState();
}

class _ConsentSectionState extends State<_ConsentSection> {
  /// Controller propio del scroll del consentimiento.
  ///
  /// Sin el, el [Scrollbar] se engancha al `PrimaryScrollController`, que aqui
  /// es el scroll del formulario entero. Dos posiciones sobre un mismo
  /// controller cuelgan el layout.
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          l10n.registerConsentSectionTitle,
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: CauceSpacing.space3),
        // Altura acotada con scroll propio: el consentimiento del piloto es
        // largo y sin limite empujaria el boton de envio fuera de alcance.
        Container(
          constraints: const BoxConstraints(maxHeight: 200),
          padding: const EdgeInsets.all(CauceSpacing.space3),
          decoration: BoxDecoration(
            color: CauceColors.bgSubtle,
            borderRadius: CauceRadii.borderMd,
            border: Border.all(color: CauceColors.bgDivider),
          ),
          child: Scrollbar(
            controller: _scrollController,
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Text(
                widget.consent.text,
                key: const Key('register_consent_text'),
                style: textTheme.bodyMedium,
              ),
            ),
          ),
        ),
        const SizedBox(height: CauceSpacing.space2),
        CheckboxListTile(
          key: const Key('register_consent_checkbox'),
          value: widget.accepted,
          onChanged: widget.enabled
              ? (value) => widget.onChanged(value ?? false)
              : null,
          title: Text(
            l10n.registerConsentCheckbox,
            style: textTheme.bodyMedium,
          ),
          controlAffinity: ListTileControlAffinity.leading,
          contentPadding: EdgeInsets.zero,
        ),
      ],
    );
  }
}

class _CenteredMessage extends StatelessWidget {
  const _CenteredMessage({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(CauceSpacing.space6),
        child: child,
      ),
    );
  }
}
