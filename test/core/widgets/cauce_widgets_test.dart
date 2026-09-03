import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/theme/design_tokens.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

/// Monta un widget suelto con theme y localizacion, sin router ni providers.
Future<void> _pump(WidgetTester tester, Widget child) {
  return tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: const Locale('es'),
      home: Scaffold(body: child),
    ),
  );
}

void main() {
  group('CauceButton · variantes', () {
    testWidgets('primary se apoya en ElevatedButton', (tester) async {
      await _pump(
        tester,
        CauceButton(label: 'Continuar', onPressed: () {}),
      );

      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Continuar'), findsOneWidget);
    });

    testWidgets('secondary se apoya en OutlinedButton', (tester) async {
      await _pump(
        tester,
        CauceButton.secondary(label: 'Cancelar', onPressed: () {}),
      );

      expect(find.byType(OutlinedButton), findsOneWidget);
    });

    testWidgets('tertiary se apoya en TextButton', (tester) async {
      await _pump(
        tester,
        CauceButton.tertiary(label: 'Olvide mi contrasena', onPressed: () {}),
      );

      expect(find.byType(TextButton), findsOneWidget);
    });
  });

  group('CauceButton · estados', () {
    testWidgets('onPressed nulo lo deja deshabilitado', (tester) async {
      await _pump(tester, const CauceButton(label: 'Enviar', onPressed: null));

      final button = tester.widget<ElevatedButton>(
        find.byType(ElevatedButton),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('cargando muestra el indicador y bloquea el toque', (
      tester,
    ) async {
      // Un boton que gira pero sigue aceptando toques deja emitir la misma
      // peticion dos veces.
      var taps = 0;
      await _pump(
        tester,
        CauceButton(
          label: 'Enviar',
          loading: true,
          onPressed: () => taps++,
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Enviar'), findsNothing);

      await tester.tap(find.byType(ElevatedButton), warnIfMissed: false);
      await tester.pump();

      expect(taps, 0);
    });

    testWidgets('el toque llega cuando esta habilitado', (tester) async {
      var taps = 0;
      await _pump(
        tester,
        CauceButton(label: 'Enviar', onPressed: () => taps++),
      );

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(taps, 1);
    });

    testWidgets('respeta la altura minima tactil de 48px', (tester) async {
      await _pump(tester, CauceButton(label: 'Enviar', onPressed: () {}));

      final size = tester.getSize(find.byType(ElevatedButton));
      expect(size.height, greaterThanOrEqualTo(CauceSizes.touchTargetMin));
    });
  });

  group('CauceTextField', () {
    testWidgets('la variante password nace oculta', (tester) async {
      await _pump(tester, const CauceTextField.password(label: 'Contrasena'));

      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.obscureText, isTrue);
    });

    testWidgets('el alternador revela y vuelve a ocultar', (tester) async {
      await _pump(tester, const CauceTextField.password(label: 'Contrasena'));

      TextField field() => tester.widget<TextField>(find.byType(TextField));

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      expect(field().obscureText, isFalse);

      await tester.tap(find.byType(IconButton));
      await tester.pumpAndSettle();
      expect(field().obscureText, isTrue);
    });

    testWidgets('la variante de texto no trae alternador', (tester) async {
      await _pump(tester, const CauceTextField(label: 'Nombre'));

      expect(find.byType(IconButton), findsNothing);
    });

    testWidgets('el correo usa teclado de email', (tester) async {
      await _pump(tester, const CauceTextField.email(label: 'Correo'));

      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.keyboardType, TextInputType.emailAddress);
    });

    testWidgets('muestra el errorText del backend', (tester) async {
      await _pump(
        tester,
        const CauceTextField(label: 'Correo', errorText: 'Formato invalido'),
      );

      expect(find.text('Formato invalido'), findsOneWidget);
    });

    testWidgets('deshabilitado no acepta escritura', (tester) async {
      await _pump(
        tester,
        const CauceTextField(label: 'Nombre', enabled: false),
      );

      final field = tester.widget<TextField>(find.byType(TextField));
      expect(field.enabled, isFalse);
    });

    testWidgets('el anillo de foco aparece al enfocar y no con error', (
      tester,
    ) async {
      await _pump(tester, const CauceTextField(label: 'Nombre'));

      BoxDecoration decoration() => tester
          .widget<AnimatedContainer>(find.byType(AnimatedContainer))
          .decoration! as BoxDecoration;

      expect(decoration().boxShadow, isEmpty);

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      expect(decoration().boxShadow, hasLength(1));
      expect(decoration().boxShadow!.first.color, CauceColors.brandSoft);
    });

    testWidgets('con error el anillo no se dibuja aunque haya foco', (
      tester,
    ) async {
      // Sobre un campo en rojo, el halo coral confundiria mas de lo que
      // orienta.
      await _pump(
        tester,
        const CauceTextField(label: 'Correo', errorText: 'Invalido'),
      );

      await tester.tap(find.byType(TextField));
      await tester.pumpAndSettle();

      final decoration = tester
          .widget<AnimatedContainer>(find.byType(AnimatedContainer))
          .decoration! as BoxDecoration;
      expect(decoration.boxShadow, isEmpty);
    });
  });

  group('CauceLoadingIndicator', () {
    testWidgets('inline no muestra texto', (tester) async {
      await _pump(tester, const CauceLoadingIndicator.inline());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(Text), findsNothing);
    });

    testWidgets('fullscreen usa el mensaje generico por defecto', (
      tester,
    ) async {
      await _pump(tester, const CauceLoadingIndicator.fullscreen());

      expect(find.text('Cargando'), findsOneWidget);
    });

    testWidgets('fullscreen respeta el mensaje que se le pasa', (tester) async {
      await _pump(
        tester,
        const CauceLoadingIndicator.fullscreen(message: 'Cargando consent'),
      );

      expect(find.text('Cargando consent'), findsOneWidget);
    });
  });

  group('CauceErrorBanner', () {
    testWidgets('acompana el color con un icono', (tester) async {
      // El design system exige que el error nunca se comunique solo por color.
      await _pump(
        tester,
        const CauceErrorBanner(error: CauceApiError.invalidCredentials()),
      );

      expect(find.text('Credenciales incorrectas'), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('descuenta la espera del rate limit', (tester) async {
      // Reloj controlado: tester.pump avanza el reloj falso de asincronia,
      // no el del sistema, asi que el widget necesita el suyo.
      var now = DateTime(2026, 9, 3, 12);
      await _pump(
        tester,
        CauceErrorBanner(
          error: const CauceApiError.rateLimited(retryAfterSeconds: 5),
          clock: () => now,
        ),
      );

      expect(find.textContaining('5 segundos'), findsOneWidget);

      now = now.add(const Duration(seconds: 2));
      await tester.pump(const Duration(seconds: 2));
      expect(find.textContaining('3 segundos'), findsOneWidget);

      // Cumplida la espera, deja de mostrar un contador en cero.
      now = now.add(const Duration(seconds: 4));
      await tester.pump(const Duration(seconds: 4));
      expect(find.text('Reintentar'), findsOneWidget);
    });

    testWidgets('un error sin tiempo no arranca temporizador', (tester) async {
      await _pump(
        tester,
        const CauceErrorBanner(error: CauceApiError.network()),
      );

      expect(find.textContaining('Sin conexion'), findsOneWidget);
      // Sin timer pendiente, el test termina limpio sin bombear tiempo.
    });
  });

  group('CauceScaffold', () {
    testWidgets('pinta el fondo crema del design system', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const CauceScaffold(body: Text('contenido')),
        ),
      );

      final scaffold = tester.widget<Scaffold>(find.byType(Scaffold));
      expect(
        scaffold.backgroundColor ??
            Theme.of(
              tester.element(find.byType(Scaffold)),
            ).scaffoldBackgroundColor,
        CauceColors.bgPage,
      );
    });

    testWidgets('scrollable envuelve el contenido en un scroll', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const CauceScaffold(scrollable: true, body: Text('contenido')),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('sin scrollable no agrega scroll', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const CauceScaffold(body: Text('contenido')),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsNothing);
    });

    testWidgets('acota el ancho del contenido', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light(),
          home: const CauceScaffold(
            maxContentWidth: 320,
            body: SizedBox(height: 10, child: Text('contenido')),
          ),
        ),
      );

      final box = tester.renderObject<RenderBox>(find.text('contenido'));
      expect(box.size.width, lessThanOrEqualTo(320));
    });
  });
}
