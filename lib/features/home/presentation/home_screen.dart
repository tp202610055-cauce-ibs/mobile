import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/application/session_notifier.dart';

/// Raiz autenticada, provisional (US08 CA01).
///
/// Mobile-2 y Mobile-3 la reemplazan por el tablero real del paciente. En
/// Mobile-1b demuestra que la sesion llego y ofrece el cierre.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _loggingOut = false;

  Future<void> _logout() async {
    if (_loggingOut) {
      return;
    }
    setState(() => _loggingOut = true);

    // El notifier avisa al backend y limpia el almacenamiento. No falla nunca:
    // si el aviso no prospera, la sesion local se cierra igual.
    await ref.read(sessionNotifierProvider.notifier).logout();

    // El guard del router se encarga de llevar al login en cuanto el estado
    // pasa a no autenticado. Esta pantalla no navega por su cuenta.
    if (mounted) {
      setState(() => _loggingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final user = ref.watch(sessionNotifierProvider).user;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(CauceSpacing.space6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  l10n.homeGreeting(user?.fullName ?? ''),
                  style: textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: CauceSpacing.space6),
                OutlinedButton(
                  key: const Key('home_logout'),
                  onPressed: _loggingOut ? null : _logout,
                  child: _loggingOut
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.homeLogout),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
