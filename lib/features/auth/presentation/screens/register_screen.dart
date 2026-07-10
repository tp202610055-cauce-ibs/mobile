import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/cauce_button.dart';
import '../../../../core/widgets/cauce_error_banner.dart';
import '../../../../core/widgets/cauce_text_field.dart';
import '../../data/dtos/register_request_dto.dart';
import '../providers/auth_notifier.dart';
import '../providers/auth_state.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _passwordConfirmCtrl = TextEditingController();
  bool _obscurePassword = true;
  bool _acceptConsent = false;
  bool _consentError = false;

  @override
  void dispose() {
    _fullNameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _passwordConfirmCtrl.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final formValid = _formKey.currentState!.validate();
    setState(() => _consentError = !_acceptConsent);
    if (!formValid || !_acceptConsent) return;

    ref.read(authNotifierProvider.notifier).register(
      RegisterRequestDto(
        fullName: _fullNameCtrl.text.trim(),
        email: _emailCtrl.text.trim(),
        password: _passwordCtrl.text,
        role: 'patient',
        acceptConsent: true,
      ),
    );
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'Ingresa una contraseña.';
    if (value.length < 8) return 'Mínimo 8 caracteres.';
    if (!RegExp(r'[A-Z]').hasMatch(value)) return 'Debe incluir una mayúscula.';
    if (!RegExp(r'[a-z]').hasMatch(value)) return 'Debe incluir una minúscula.';
    if (!RegExp(r'[0-9]').hasMatch(value)) return 'Debe incluir un número.';
    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
      return 'Debe incluir un carácter especial.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authNotifierProvider);
    final isLoading = state is AuthLoading;

    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthAuthenticated) {
        context.go('/home');
      }
    });

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: isLoading ? null : () => context.go('/login'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Crea tu cuenta',
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Acompañamiento dietético para Síndrome de Intestino Irritable.',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.xl),
                if (state is AuthError) ...[
                  CauceErrorBanner(message: state.message),
                  const SizedBox(height: AppSpacing.md),
                ],
                CauceTextField(
                  controller: _fullNameCtrl,
                  label: 'Nombre completo',
                  hint: 'Ej. María González',
                  prefixIcon: Icons.person_outline,
                  enabled: !isLoading,
                  maxLength: 150,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa tu nombre completo.';
                    }
                    if (value.trim().length < 3) {
                      return 'El nombre debe tener al menos 3 caracteres.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                CauceTextField(
                  controller: _emailCtrl,
                  label: 'Correo electrónico',
                  hint: 'tu@correo.com',
                  prefixIcon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Ingresa tu correo.';
                    }
                    final emailRegex =
                    RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[\w\-]{2,4}$');
                    if (!emailRegex.hasMatch(value.trim())) {
                      return 'Formato de correo inválido.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                CauceTextField(
                  controller: _passwordCtrl,
                  label: 'Contraseña',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  enabled: !isLoading,
                  validator: _validatePassword,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: AppSpacing.xs, top: AppSpacing.xs),
                  child: Text(
                    'Mínimo 8 caracteres, una mayúscula, una minúscula, un número y un carácter especial.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                CauceTextField(
                  controller: _passwordConfirmCtrl,
                  label: 'Confirma tu contraseña',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  enabled: !isLoading,
                  validator: (value) {
                    if (value != _passwordCtrl.text) {
                      return 'Las contraseñas no coinciden.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                CheckboxListTile(
                  value: _acceptConsent,
                  onChanged: isLoading
                      ? null
                      : (value) {
                    setState(() {
                      _acceptConsent = value ?? false;
                      _consentError = false;
                    });
                  },
                  title: Text(
                    'Acepto el tratamiento de mis datos de salud según la Ley 29733 y el consentimiento informado del estudio.',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  controlAffinity: ListTileControlAffinity.leading,
                  contentPadding: EdgeInsets.zero,
                  activeColor: AppColors.primary,
                ),
                if (_consentError)
                  Padding(
                    padding: const EdgeInsets.only(left: AppSpacing.md),
                    child: Text(
                      'Debes aceptar el consentimiento para registrarte.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.error,
                      ),
                    ),
                  ),
                const SizedBox(height: AppSpacing.lg),
                CauceButton(
                  label: 'Crear cuenta',
                  onPressed: _handleSubmit,
                  isLoading: isLoading,
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '¿Ya tienes cuenta? ',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: isLoading ? null : () => context.go('/login'),
                      child: const Text('Inicia sesión'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}