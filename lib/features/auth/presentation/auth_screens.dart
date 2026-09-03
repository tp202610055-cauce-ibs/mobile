import 'package:flutter/material.dart';

import '../../../l10n/generated/app_localizations.dart';

// Pantallas ya implementadas. Se reexportan para que el router tenga un unico
// punto de entrada al arbol de identidad.
export 'login_screen.dart';
export 'password_recovery_screen.dart';
export 'password_reset_screen.dart';

/// Andamio de las pantallas de identidad que siguen pendientes.
///
/// La Fase 7 reemplaza las dos que quedan. Sus textos ya salen de l10n (R8),
/// de modo que la sustitucion no arrastra strings hardcodeados.
class _StubScreen extends StatelessWidget {
  const _StubScreen({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(title, style: textTheme.headlineMedium),
        ),
      ),
    );
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
