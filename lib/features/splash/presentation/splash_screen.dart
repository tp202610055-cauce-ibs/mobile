import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/application/session_notifier.dart';

/// Pantalla de arranque.
///
/// Su unico trabajo es disparar el bootstrap de sesion; el redirect del router
/// se encarga del resto en cuanto el estado deja de ser [SessionUnknown]. Sin
/// interaccion del usuario.
///
/// La Fase 6 le agrega el logo de Cauce. Su composicion es estable, y por eso
/// es la unica pantalla con golden test (acta M18).
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Fuera del build: leer el Keystore muta el provider, y hacerlo durante la
    // construccion del arbol dispara un error de Riverpod.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(sessionNotifierProvider.notifier).bootstrap();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(l10n.appTitle, style: textTheme.displayLarge),
            const SizedBox(height: CauceSpacing.space6),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(strokeWidth: 3),
            ),
            const SizedBox(height: CauceSpacing.space4),
            Text(l10n.splashLoading, style: textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
