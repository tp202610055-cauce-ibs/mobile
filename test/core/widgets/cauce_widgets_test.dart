import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/theme/design_tokens.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
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
        CauceButton.tertiary(label: 'Olvidé mi contraseña', onPressed: () {}),
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

      expect(find.textContaining('Sin conexión'), findsOneWidget);
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

  group('CauceSlider · distingue sin responder de responder cero', () {
    testWidgets('sin valor no muestra numero', (tester) async {
      await _pump(
        tester,
        CauceSlider(value: null, onChanged: (_) {}),
      );

      // Un slider de Material siempre tiene posicion. Mostrar el numero de esa
      // posicion leeria como una respuesta que el paciente no dio.
      expect(
        tester.widget<Text>(find.byKey(const Key('cauce_slider_value'))).data,
        isEmpty,
      );
    });

    testWidgets('un cero explicito si muestra el numero', (tester) async {
      // Cero es una respuesta clinica valida: el paciente no tuvo el sintoma.
      await _pump(
        tester,
        CauceSlider(value: 0, onChanged: (_) {}),
      );

      expect(
        tester.widget<Text>(find.byKey(const Key('cauce_slider_value'))).data,
        '0',
      );
    });

    testWidgets('muestra el valor elegido', (tester) async {
      await _pump(
        tester,
        CauceSlider(value: 73, onChanged: (_) {}),
      );

      expect(
        tester.widget<Text>(find.byKey(const Key('cauce_slider_value'))).data,
        '73',
      );
    });
  });

  group('CauceSlider · escala del instrumento', () {
    testWidgets('va de 0 a 100 con una division por unidad', (tester) async {
      await _pump(
        tester,
        CauceSlider(value: 50, onChanged: (_) {}),
      );

      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.min, 0);
      expect(slider.max, 100);
      // Sin divisiones discretas saldrian decimales, que el backend rechaza.
      expect(slider.divisions, 100);
    });

    testWidgets('entrega enteros, nunca decimales', (tester) async {
      int? received;
      await _pump(
        tester,
        CauceSlider(value: 50, onChanged: (value) => received = value),
      );

      await tester.drag(find.byType(Slider), const Offset(60, 0));
      await tester.pump();

      expect(received, isNotNull);
      expect(received, isA<int>());
      expect(received, inInclusiveRange(0, 100));
    });

    testWidgets('deshabilitado no emite cambios', (tester) async {
      int? received;
      await _pump(
        tester,
        CauceSlider(
          value: 50,
          enabled: false,
          onChanged: (value) => received = value,
        ),
      );

      await tester.drag(find.byType(Slider), const Offset(60, 0));
      await tester.pump();

      expect(received, isNull);
    });

    testWidgets('respeta el area tactil minima de 48px', (tester) async {
      await _pump(
        tester,
        CauceSlider(value: 50, onChanged: (_) {}),
      );

      final box = tester.renderObject<RenderBox>(find.byType(Slider));
      expect(box.size.height, greaterThanOrEqualTo(CauceSizes.touchTargetMin));
    });

    testWidgets('muestra las etiquetas de los extremos', (tester) async {
      await _pump(
        tester,
        CauceSlider(
          value: 20,
          minLabel: 'Sin dolor',
          maxLabel: 'Muy intenso',
          onChanged: (_) {},
        ),
      );

      expect(find.text('Sin dolor'), findsOneWidget);
      expect(find.text('Muy intenso'), findsOneWidget);
    });
  });

  group('CauceChoiceField · seleccion unica', () {
    List<CauceChoice<String>> choices() => const <CauceChoice<String>>[
          CauceChoice<String>(value: 'a', label: 'Femenino'),
          CauceChoice<String>(value: 'b', label: 'Masculino'),
          CauceChoice<String>(value: 'c', label: 'Otro'),
        ];

    testWidgets('pinta todas las opciones a la vez', (tester) async {
      // Con tres o cuatro alternativas, un desplegable esconderia el conjunto
      // tras un toque extra.
      await _pump(
        tester,
        CauceChoiceField<String>(
          label: 'Sexo biologico',
          choices: choices(),
          value: null,
          onChanged: (_) {},
        ),
      );

      expect(find.text('Femenino'), findsOneWidget);
      expect(find.text('Masculino'), findsOneWidget);
      expect(find.text('Otro'), findsOneWidget);
      expect(find.text('Sexo biologico'), findsOneWidget);
    });

    testWidgets('un toque emite el valor de dominio, no la etiqueta',
        (tester) async {
      String? received;
      await _pump(
        tester,
        CauceChoiceField<String>(
          label: 'Sexo biologico',
          choices: choices(),
          value: null,
          onChanged: (value) => received = value,
        ),
      );

      await tester.tap(find.text('Masculino'));
      await tester.pump();

      expect(received, 'b');
    });

    testWidgets('deshabilitado ignora los toques', (tester) async {
      String? received;
      await _pump(
        tester,
        CauceChoiceField<String>(
          label: 'Sexo biologico',
          choices: choices(),
          value: null,
          enabled: false,
          onChanged: (value) => received = value,
        ),
      );

      await tester.tap(find.text('Otro'));
      await tester.pump();

      expect(received, isNull);
    });

    testWidgets('muestra el error bajo el grupo', (tester) async {
      await _pump(
        tester,
        CauceChoiceField<String>(
          label: 'Sexo biologico',
          choices: choices(),
          value: null,
          errorText: 'Este campo es obligatorio',
          onChanged: (_) {},
        ),
      );

      expect(find.text('Este campo es obligatorio'), findsOneWidget);
    });

    testWidgets('la glosa opcional se pinta bajo la etiqueta', (tester) async {
      // "IBS-D" no le dice nada a un paciente sin la aclaracion.
      await _pump(
        tester,
        CauceChoiceField<String>(
          label: 'Subtipo',
          choices: const <CauceChoice<String>>[
            CauceChoice<String>(
              value: 'd',
              label: 'SII-D',
              description: 'Con predominio de diarrea',
            ),
          ],
          value: null,
          onChanged: (_) {},
        ),
      );

      expect(find.text('Con predominio de diarrea'), findsOneWidget);
    });
  });

  group('CauceSlider · escala parametrizada (Mobile-3)', () {
    testWidgets('sin parametros mantiene la escala del instrumento IBS-SSS',
        (tester) async {
      // Los defaults son los de siempre: el cuestionario de US04 no cambia una
      // linea al parametrizar los extremos.
      await _pump(tester, CauceSlider(value: 50, onChanged: (_) {}));

      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.min, 0);
      expect(slider.max, 100);
      expect(slider.divisions, 100);
    });

    testWidgets('con min 1 la escala empieza en 1', (tester) async {
      // La intensidad de un sintoma va de 1 a 100: el backend rechaza el cero
      // (`Symptom.MinIntensity`, `InclusiveBetween(1, 100)`).
      await _pump(tester, CauceSlider(value: 40, min: 1, onChanged: (_) {}));

      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.min, 1);
      expect(slider.max, 100);
      // Una division por unidad sobre 99 unidades de recorrido.
      expect(slider.divisions, 99);
    });

    testWidgets('nunca entrega un valor por debajo del minimo', (tester) async {
      int? received;
      await _pump(
        tester,
        CauceSlider(value: 50, min: 1, onChanged: (value) => received = value),
      );

      // Arrastra al extremo izquierdo.
      await tester.drag(find.byType(Slider), const Offset(-500, 0));
      await tester.pump();

      expect(received, isNotNull);
      expect(received, greaterThanOrEqualTo(1));
    });

    testWidgets('sin responder, el pulgar arranca en el centro del rango real',
        (tester) async {
      await _pump(tester, CauceSlider(value: null, min: 1, onChanged: (_) {}));

      final slider = tester.widget<Slider>(find.byType(Slider));
      expect(slider.value, (1 + 100) ~/ 2);
    });

    testWidgets('la semantica anuncia el rango real de la instancia',
        (tester) async {
      // Sin esto el lector de pantalla diria 0 a 100 en una escala que empieza
      // en 1, y mandaria a buscar un valor que no existe.
      final handle = tester.ensureSemantics();
      await _pump(
        tester,
        CauceSlider(
          value: 40,
          min: 1,
          onChanged: (_) {},
          semanticLabel: 'Intensidad',
        ),
      );

      final semantics = tester.getSemantics(find.byType(Slider));
      expect(semantics.label, 'Intensidad');
      expect(semantics.value, '40 de 1 a 100');
      handle.dispose();
    });

    testWidgets('en la escala del instrumento la semantica dice 0 a 100',
        (tester) async {
      final handle = tester.ensureSemantics();
      await _pump(
        tester,
        CauceSlider(value: 50, onChanged: (_) {}, semanticLabel: 'Dolor'),
      );

      final semantics = tester.getSemantics(find.byType(Slider));
      expect(semantics.label, 'Dolor');
      expect(semantics.value, '50 de 0 a 100');
      handle.dispose();
    });

    testWidgets('las etiquetas por defecto muestran los extremos reales',
        (tester) async {
      await _pump(tester, CauceSlider(value: 40, min: 1, onChanged: (_) {}));

      expect(find.text('1'), findsOneWidget);
      expect(find.text('100'), findsOneWidget);
    });
  });

  group('CauceBadge · seccion F del design system', () {
    testWidgets('lleva icono y texto juntos, nunca solo color', (tester) async {
      await _pump(
        tester,
        const CauceBadge(
          label: 'Sincronizado',
          icon: TablerIcons.cloud_check,
          tone: CauceBadgeTone.success,
        ),
      );

      expect(find.text('Sincronizado'), findsOneWidget);
      expect(find.byIcon(TablerIcons.cloud_check), findsOneWidget);
    });

    testWidgets('cada tono toma su par de colores semanticos', (tester) async {
      for (final (CauceBadgeTone tone, Color background)
          in <(CauceBadgeTone, Color)>[
        (CauceBadgeTone.neutral, CauceColors.bgSubtle),
        (CauceBadgeTone.info, CauceColors.infoBg),
        (CauceBadgeTone.success, CauceColors.successBg),
        (CauceBadgeTone.warning, CauceColors.warningBg),
        (CauceBadgeTone.danger, CauceColors.dangerBg),
        (CauceBadgeTone.brand, CauceColors.brandSoft),
      ]) {
        await _pump(
          tester,
          CauceBadge(
            label: 'Etiqueta',
            icon: TablerIcons.leaf,
            tone: tone,
          ),
        );

        final container = tester.widget<Container>(
          find
              .ancestor(
                of: find.text('Etiqueta'),
                matching: find.byType(Container),
              )
              .first,
        );
        final decoration = container.decoration! as BoxDecoration;
        expect(decoration.color, background, reason: tone.name);
      }
    });

    testWidgets('compact aprieta el relleno sin tocar el texto',
        (tester) async {
      await _pump(
        tester,
        const CauceBadge(
          label: 'Intensidad 60',
          icon: TablerIcons.activity,
          tone: CauceBadgeTone.warning,
          compact: true,
        ),
      );
      final compactWidth = tester.getSize(find.byType(CauceBadge)).width;

      await _pump(
        tester,
        const CauceBadge(
          label: 'Intensidad 60',
          icon: TablerIcons.activity,
          tone: CauceBadgeTone.warning,
        ),
      );
      final normalWidth = tester.getSize(find.byType(CauceBadge)).width;

      expect(compactWidth, lessThan(normalWidth));
    });
  });

  group('CauceEmptyState · seccion I del design system', () {
    testWidgets('muestra icono, titulo y cuerpo', (tester) async {
      await _pump(
        tester,
        const CauceEmptyState(
          icon: TablerIcons.bowl,
          title: 'Aun no tienes comidas registradas hoy',
          message: 'Cuando registres una comida, aparecera aqui en tu diario.',
        ),
      );

      expect(find.byIcon(TablerIcons.bowl), findsOneWidget);
      expect(
        find.text('Aun no tienes comidas registradas hoy'),
        findsOneWidget,
      );
      expect(
        find.text('Cuando registres una comida, aparecera aqui en tu diario.'),
        findsOneWidget,
      );
    });

    testWidgets('sin accion no dibuja boton', (tester) async {
      await _pump(
        tester,
        const CauceEmptyState(
          icon: TablerIcons.bulb,
          title: 'Sin consejos por ahora',
          message: 'Tu nutricionista todavia no aprobo ninguno.',
        ),
      );

      expect(find.byType(CauceButton), findsNothing);
    });

    testWidgets('con accion ofrece la salida y la ejecuta', (tester) async {
      var taps = 0;
      await _pump(
        tester,
        CauceEmptyState(
          icon: TablerIcons.bowl,
          title: 'Aun no tienes comidas registradas hoy',
          message: 'Cuando registres una comida, aparecera aqui.',
          actionLabel: 'Registrar primera comida',
          onAction: () => taps++,
        ),
      );

      await tester.tap(find.text('Registrar primera comida'));
      await tester.pump();

      expect(taps, 1);
    });
  });

  group('CauceToast · seccion I del design system', () {
    testWidgets('el de exito lleva su icono y su color', (tester) async {
      await _pump(
        tester,
        Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => CauceToast.success(
              context,
              title: 'Comida guardada',
              message: 'Se sincronizara cuando recuperes conexion.',
            ),
            child: const Text('mostrar'),
          ),
        ),
      );

      await tester.tap(find.text('mostrar'));
      await tester.pump();

      expect(find.text('Comida guardada'), findsOneWidget);
      expect(find.byIcon(TablerIcons.circle_check), findsOneWidget);

      final container = tester.widget<Container>(find.byKey(cauceToastKey));
      final decoration = container.decoration! as BoxDecoration;
      expect(decoration.color, CauceColors.successBg);
    });

    testWidgets('el de error con reintento ejecuta la accion y se cierra',
        (tester) async {
      var retries = 0;
      await _pump(
        tester,
        Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () => CauceToast.error(
              context,
              title: 'No pudimos guardar tu registro',
              actionLabel: 'Reintentar',
              onAction: () => retries++,
            ),
            child: const Text('mostrar'),
          ),
        ),
      );

      await tester.tap(find.text('mostrar'));
      // Se asienta la entrada del toast antes de tocarlo: mientras el
      // SnackBar entra deslizandose, el boton todavia no esta donde el toque
      // lo busca.
      await tester.pumpAndSettle();
      expect(find.byIcon(TablerIcons.alert_circle), findsOneWidget);

      await tester.tap(find.text('Reintentar'));
      await tester.pumpAndSettle();

      expect(retries, 1);
      expect(find.byKey(cauceToastKey), findsNothing);
    });

    testWidgets('un segundo aviso reemplaza al primero', (tester) async {
      await _pump(
        tester,
        Builder(
          builder: (BuildContext context) => Column(
            children: <Widget>[
              TextButton(
                onPressed: () => CauceToast.success(context, title: 'Primero'),
                child: const Text('uno'),
              ),
              TextButton(
                onPressed: () => CauceToast.error(context, title: 'Segundo'),
                child: const Text('dos'),
              ),
            ],
          ),
        ),
      );

      await tester.tap(find.text('uno'));
      await tester.pump();
      await tester.tap(find.text('dos'));
      await tester.pumpAndSettle();

      expect(find.text('Primero'), findsNothing);
      expect(find.text('Segundo'), findsOneWidget);
    });
  });

  group('CauceConfirmDialog', () {
    Future<void> openDialog(
      WidgetTester tester,
      void Function(bool) onOutcome,
    ) async {
      await _pump(
        tester,
        Builder(
          builder: (BuildContext context) => TextButton(
            onPressed: () async {
              onOutcome(
                await CauceConfirmDialog.show(
                  context,
                  title: 'Cerrar sesión',
                  message: 'Vas a salir de tu cuenta.',
                  confirmLabel: 'Si, cerrar sesion',
                  cancelLabel: 'Cancelar',
                ),
              );
            },
            child: const Text('abrir'),
          ),
        ),
      );

      await tester.tap(find.text('abrir'));
      await tester.pumpAndSettle();
      expect(find.byKey(cauceConfirmDialogKey), findsOneWidget);
    }

    testWidgets('confirmar devuelve true', (tester) async {
      bool? outcome;
      await openDialog(tester, (value) => outcome = value);

      await tester.tap(find.byKey(cauceConfirmAcceptKey));
      await tester.pumpAndSettle();

      expect(outcome, isTrue);
      expect(find.byKey(cauceConfirmDialogKey), findsNothing);
    });

    testWidgets('cancelar devuelve false', (tester) async {
      bool? outcome;
      await openDialog(tester, (value) => outcome = value);

      await tester.tap(find.byKey(cauceConfirmCancelKey));
      await tester.pumpAndSettle();

      expect(outcome, isFalse);
      expect(find.byKey(cauceConfirmDialogKey), findsNothing);
    });

    testWidgets('descartar tocando fuera equivale a cancelar', (tester) async {
      bool? outcome;
      await openDialog(tester, (value) => outcome = value);

      // Sobre el velo modal, fuera de la caja del dialogo.
      await tester.tapAt(const Offset(10, 10));
      await tester.pumpAndSettle();

      expect(outcome, isFalse);
      expect(find.byKey(cauceConfirmDialogKey), findsNothing);
    });
  });
}
