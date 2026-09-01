import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/theme/app_theme.dart';
import 'l10n/generated/app_localizations.dart';

/// Raiz de la aplicacion.
///
/// En Mobile-1b esta clase solo aporta theme y localizacion. La Fase 5
/// reemplaza el `home` por `MaterialApp.router` conectado al `GoRouter` con
/// auth guard.
class CauceApp extends StatelessWidget {
  const CauceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: AppTheme.light(),
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
      home: const _FoundationsPlaceholder(),
    );
  }
}

/// Pantalla transitoria de la Fase 2.
///
/// Existe para verificar que el theme y la localizacion quedaron cableados.
/// La Fase 5 la reemplaza por el router y sus ocho pantallas reales.
class _FoundationsPlaceholder extends StatelessWidget {
  const _FoundationsPlaceholder();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appTitle)),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(l10n.appTitle, style: textTheme.displayLarge),
              const SizedBox(height: 8),
              Text(l10n.splashLoading, style: textTheme.bodyMedium),
            ],
          ),
        ),
      ),
    );
  }
}
