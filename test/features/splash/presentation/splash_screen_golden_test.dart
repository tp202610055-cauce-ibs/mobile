import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/splash/presentation/splash_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_token_storage.dart';

/// Golden unico del bloque (acta M18).
///
/// SplashScreen es la unica pantalla puramente visual y sin interaccion, de
/// modo que un golden aporta valor real: detecta regresiones del theme sin la
/// fragilidad que tendria sobre un formulario.
///
/// El renderizado es determinista porque Inter va empaquetada como asset
/// (Fase 2) y no depende de las fuentes del sistema.
void main() {
  testWidgets('SplashScreen coincide con su golden', (tester) async {
    tester.view.physicalSize = const Size(1080, 1920);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    final container = ProviderContainer(
      overrides: <Override>[
        // La demora mantiene la sesion sin resolver mientras se captura, que
        // es el unico estado visible del splash. Corta a proposito: una larga
        // dejaria un Timer pendiente al desmontar el arbol.
        tokenStorageProvider.overrideWithValue(
          FakeTokenStorage(readDelay: const Duration(milliseconds: 50)),
        ),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: const <LocalizationsDelegate<Object>>[
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: const Locale('es'),
          home: const SplashScreen(),
        ),
      ),
    );
    // Un frame concreto y no pumpAndSettle: el indicador circular gira sin
    // parar, asi que pumpAndSettle nunca terminaria.
    await tester.pump(const Duration(milliseconds: 10));

    await expectLater(
      find.byType(SplashScreen),
      matchesGoldenFile('goldens/splash_screen.png'),
    );

    // El bootstrap encadena tres lecturas, cada una con su demora. Se drenan
    // todas para que el test no termine con timers vivos.
    await tester.pump(const Duration(seconds: 1));
  });
}
