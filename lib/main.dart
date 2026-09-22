import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/config/env.dart';
import 'core/theme/design_tokens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.load();
  _configureSystemChrome();
  runApp(const ProviderScope(child: CauceApp()));
}

/// Deja que la aplicacion dibuje debajo de las barras del sistema.
///
/// Sin esto, la franja de los tres botones de Android queda del color de
/// fondo del `Scaffold` (el crema de pagina) mientras la barra de la
/// aplicacion es blanca, y el corte se nota. Con `edgeToEdge` la barra
/// inferior de [CauceBottomNav] extiende su blanco por debajo.
///
/// **El color se pide transparente y no blanco a proposito.** Desde Android 15
/// el sistema ignora `systemNavigationBarColor`, de modo que pintarla no
/// funciona y lo unico que sirve es que la aplicacion dibuje ahi. Se deja
/// declarado igual para los Android anteriores, que si lo respetan.
void _configureSystemChrome() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: CauceColors.bgCard,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
}
