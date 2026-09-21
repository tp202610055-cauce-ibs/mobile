import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/router/app_router.dart';
import 'core/services/background_services.dart';
import 'core/theme/app_theme.dart';
import 'l10n/generated/app_localizations.dart';

/// Raiz de la aplicacion.
class CauceApp extends ConsumerWidget {
  const CauceApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // **Este watch es el que enciende la sincronizacion y el catalogo.**
    //
    // Sin el, `SyncWorker` y `FoodCatalogRefresher` no se instancian nunca y
    // la app queda sin cola y sin catalogo local, que es lo que la
    // verificacion en dispositivo encontro al cierre de Mobile-3.1. No se
    // borra ni se mueve sin leer el acta M39 y la regla R12.
    ref.watch(sessionBackgroundServicesProvider);

    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light(),
      routerConfig: ref.watch(appRouterProvider),
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      // El piloto corre en Lima. es_PE resuelve al bundle `es`, que es el
      // template de las traducciones (acta M8).
      locale: const Locale('es', 'PE'),
      debugShowCheckedModeBanner: false,
    );
  }
}
