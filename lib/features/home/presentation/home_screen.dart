import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../l10n/generated/app_localizations.dart';
import '../../auth/application/session_notifier.dart';

/// Raiz autenticada, provisional.
///
/// Mobile-2 y Mobile-3 la reemplazan por el tablero real del paciente. En
/// Mobile-1b solo demuestra que la sesion llego y ofrece la salida.
///
/// El aviso al backend (`POST /auth/logout`) lo agrega la Fase 7. Aca el
/// cierre es local, que es lo que el guard necesita para redirigir.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final user = ref.watch(sessionNotifierProvider).user;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                l10n.homeGreeting(user?.fullName ?? ''),
                style: textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () =>
                    ref.read(sessionNotifierProvider.notifier).logout(),
                child: Text(l10n.homeLogout),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
