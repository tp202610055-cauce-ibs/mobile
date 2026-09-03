import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

/// Andamio compartido de las pantallas de identidad mientras son stubs.
///
/// Las Fases 6 y 7 reemplazan cada una por su implementacion real. Existir
/// ahora permite verificar el guard del router y los deep links sin esperar a
/// que la UI este escrita.
///
/// Todas las cadenas ya salen de l10n (R8): los stubs no introducen texto
/// hardcodeado que despues haya que ir a cazar.
class _StubScreen extends StatelessWidget {
  const _StubScreen({required this.title, this.detail});

  final String title;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(title, style: textTheme.headlineMedium),
              if (detail != null) ...<Widget>[
                const SizedBox(height: 8),
                Text(detail!, style: textTheme.bodyMedium),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// US05. Implementacion real en la Fase 6.
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StubScreen(title: AppLocalizations.of(context).loginTitle);
  }
}

/// US01 CA01, CA02 y CA03. Implementacion real en la Fase 7.
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StubScreen(title: AppLocalizations.of(context).registerTitle);
  }
}

/// US07 CA01. Implementacion real en la Fase 6.
class PasswordRecoveryScreen extends StatelessWidget {
  const PasswordRecoveryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StubScreen(
      title: AppLocalizations.of(context).passwordRecoveryTitle,
    );
  }
}

/// Confirmacion de US07 CA01. Implementacion real en la Fase 6.
class PasswordRecoverySentScreen extends StatelessWidget {
  const PasswordRecoverySentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _StubScreen(
      title: l10n.passwordRecoverySentTitle,
      detail: l10n.passwordRecoverySentBody,
    );
  }
}

/// US07 CA02. Se alcanza por deep link y recibe el token del enlace.
///
/// El token se muestra en el stub a proposito: es lo que permite verificar de
/// punta a punta que el deep link lo transporta antes de que exista el
/// formulario de la Fase 6.
class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({required this.token, super.key});

  final String token;

  @override
  Widget build(BuildContext context) {
    return _StubScreen(
      title: AppLocalizations.of(context).passwordResetTitle,
      detail: token,
    );
  }
}

/// Aviso posterior al registro. Implementacion real en la Fase 7.
class VerifyEmailPendingScreen extends StatelessWidget {
  const VerifyEmailPendingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return _StubScreen(
      title: AppLocalizations.of(context).verifyEmailPendingTitle,
    );
  }
}
