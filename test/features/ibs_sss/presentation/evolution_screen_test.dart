import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/theme/design_tokens.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/evolution_screen.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/widgets/ibs_sss_evolution_chart.dart';
import 'package:cauce_mobile/features/onboarding/presentation/widgets/onboarding_labels.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/fake_ibs_sss_repository.dart';

final AppLocalizations l10n = AppLocalizationsEs();

IbsSssEvolutionPoint _point({
  required int totalScore,
  required int cycleNumber,
  required DateTime completedAt,
  int? deltaFromBaseline,
  IbsSssAssessmentType type = IbsSssAssessmentType.periodic,
  DateTime? nextAssessmentDate,
}) {
  return IbsSssEvolutionPoint(
    assessmentId: 'assessment-$cycleNumber',
    totalScore: totalScore,
    assessmentType: type,
    cycleNumber: cycleNumber,
    completedAt: completedAt,
    deltaFromBaseline: deltaFromBaseline,
    nextAssessmentDate: nextAssessmentDate,
  );
}

/// Linea base mas una periodica: 220 a 130, que es -90 puntos y -40,9 %.
List<IbsSssEvolutionPoint> _twoPoints() => <IbsSssEvolutionPoint>[
      _point(
        totalScore: 220,
        cycleNumber: 0,
        completedAt: DateTime.utc(2026, 8, 10),
        type: IbsSssAssessmentType.baseline,
        nextAssessmentDate: DateTime.utc(2026, 8, 24),
      ),
      _point(
        totalScore: 130,
        cycleNumber: 1,
        completedAt: DateTime.now().toUtc().subtract(const Duration(days: 3)),
        deltaFromBaseline: -90,
        nextAssessmentDate: DateTime.utc(2026, 10, 4),
      ),
    ];

Future<FakeIbsSssRepository> _pump(
  WidgetTester tester, {
  FakeIbsSssRepository? repository,
}) async {
  final fake = repository ?? FakeIbsSssRepository();
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        ibsSssRepositoryProvider.overrideWithValue(fake),
      ],
      // Con router minimo: la pantalla lleva boton de retroceso, y ese
      // boton consulta `GoRouter.canPop()`. Montarla suelta la dejaria sin
      // el contexto que legitimamente necesita.
      child: MaterialApp.router(
        theme: AppTheme.light(),
        localizationsDelegates: const <LocalizationsDelegate<Object>>[
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: const Locale('es'),
        routerConfig: GoRouter(
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (_, __) => const EvolutionScreen(),
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pump();
  return fake;
}

void main() {
  group('IbsSssEvolutionChart · eje de tiempo real (HU0023, acta M49)', () {
    Future<LineChartData> pumpChart(
      WidgetTester tester,
      List<IbsSssEvolutionPoint> points,
    ) async {
      await tester.pumpWidget(
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
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 340,
                child: IbsSssEvolutionChart(points: points),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
      return tester.widget<LineChart>(find.byKey(evolutionChartKey)).data;
    }

    // El paciente demo: la linea base y dos periodicas respondidas con 18
    // minutos de diferencia. Por orden, las dos ultimas ocupaban media grafica
    // como una meseta de semanas (lo encontro el recorrido en el celular).
    List<IbsSssEvolutionPoint> demoSeries() => <IbsSssEvolutionPoint>[
          _point(
            totalScore: 220,
            cycleNumber: 0,
            completedAt: DateTime(2026, 8, 31, 16, 44),
            type: IbsSssAssessmentType.baseline,
          ),
          _point(
            totalScore: 130,
            cycleNumber: 1,
            completedAt: DateTime(2026, 9, 18, 13, 42),
          ),
          _point(
            totalScore: 130,
            cycleNumber: 2,
            completedAt: DateTime(2026, 9, 18, 14),
          ),
        ];

    testWidgets('cada punto va en el dia en que se respondio', (tester) async {
      final data = await pumpChart(tester, demoSeries());

      final xs = data.lineBarsData.single.spots.map((spot) => spot.x).toList();
      expect(xs, <double>[0, 18, 18]);
      expect(data.minX, lessThan(0));
      expect(data.maxX, greaterThan(18));
    });

    testWidgets('el mismo dia lleva una sola fecha debajo', (tester) async {
      await pumpChart(tester, demoSeries());

      expect(find.text('31/08'), findsOneWidget);
      expect(find.text('18/09'), findsOneWidget);
    });

    testWidgets('el globo del toque dice el puntaje y el dia del punto',
        (tester) async {
      final data = await pumpChart(tester, demoSeries());
      final bar = data.lineBarsData.single;

      final items = data.lineTouchData.touchTooltipData.getTooltipItems(
        <LineBarSpot>[LineBarSpot(bar, 0, bar.spots.first)],
      );

      expect(items.single?.text, l10n.evolutionPointTooltip(220, '31/08'));
    });

    testWidgets('el globo de un punto en el borde entra entero en el grafico',
        (tester) async {
      // Lo encontro el recorrido en el celular: el globo se centra sobre el
      // punto, y en el primero y el ultimo se salia de la pantalla. Al del
      // 18/09 le faltaba el "el".
      final data = await pumpChart(tester, demoSeries());
      final chart = tester.getRect(find.byKey(evolutionChartKey));
      // El area de dibujo empieza despues de los puntajes (36) y del borde
      // (1). El globo se pinta en sus coordenadas.
      const plotLeft = 37.0;
      final plotWidth = chart.width - plotLeft;

      for (final day in <double>[0, 18]) {
        final x = chart.left +
            plotLeft +
            (day - data.minX) / (data.maxX - data.minX) * plotWidth;
        final gesture = await tester.startGesture(Offset(x, chart.center.dy));
        await tester.pump();

        Rect? tooltip;
        expect(
          find.byKey(evolutionChartKey),
          paints
            ..something((method, arguments) {
              if (method != #drawRRect) {
                return false;
              }
              final paint = arguments[1] as Paint;
              if (paint.color.toARGB32() !=
                  CauceColors.textPrimary.toARGB32()) {
                return false;
              }
              tooltip = (arguments[0] as RRect).outerRect;
              return true;
            }),
        );
        expect(
          tooltip!.left,
          greaterThanOrEqualTo(0),
          reason: 'el globo del dia $day se sale por la izquierda',
        );
        expect(
          tooltip!.right,
          lessThanOrEqualTo(plotWidth),
          reason: 'el globo del dia $day se sale por la derecha',
        );

        await gesture.up();
        await tester.pumpAndSettle();
      }
    });
  });

  group('IbsSssEvolutionChart · etiquetas del eje (acta M49)', () {
    testWidgets('la primera y la ultima fecha entran enteras en el grafico',
        (tester) async {
      // Lo encontro el recorrido en el celular: la etiqueta del ultimo punto
      // cae centrada sobre el borde derecho y la mitad se salia.
      final points = <IbsSssEvolutionPoint>[
        _point(
          totalScore: 220,
          cycleNumber: 0,
          completedAt: DateTime(2026, 8, 31, 12),
          type: IbsSssAssessmentType.baseline,
        ),
        _point(
          totalScore: 150,
          cycleNumber: 1,
          completedAt: DateTime(2026, 9, 10, 12),
        ),
        _point(
          totalScore: 130,
          cycleNumber: 2,
          completedAt: DateTime(2026, 9, 18, 12),
        ),
      ];

      await tester.pumpWidget(
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
          home: Scaffold(
            body: Center(
              child: SizedBox(
                width: 340,
                child: IbsSssEvolutionChart(points: points),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final chart = tester.getRect(find.byKey(evolutionChartKey));
      for (final label in <String>['31/08', '10/09', '18/09']) {
        final rect = tester.getRect(find.text(label));
        expect(
          rect.left,
          greaterThanOrEqualTo(chart.left),
          reason: '$label se sale por la izquierda',
        );
        expect(
          rect.right,
          lessThanOrEqualTo(chart.right),
          reason: '$label se sale por la derecha',
        );
      }
    });
  });

  group('EvolutionScreen · CP060, con dos evaluaciones o mas', () {
    testWidgets('dibuja el grafico, el filtro y el cambio porcentual',
        (tester) async {
      await _pump(
        tester,
        repository: FakeIbsSssRepository()..evolutionPoints = _twoPoints(),
      );
      await tester.pumpAndSettle();

      expect(find.byKey(evolutionChartKey), findsOneWidget);
      expect(find.byKey(const Key('evolution_range')), findsOneWidget);
      expect(find.byKey(const Key('evolution_percent_change')), findsOneWidget);
    });

    testWidgets('una mejoria se lee como porcentaje menos', (tester) async {
      // -90 sobre una linea base de 220 es -40,9 %. Si alguien invirtiera el
      // signo, este test lo ve.
      await _pump(
        tester,
        repository: FakeIbsSssRepository()..evolutionPoints = _twoPoints(),
      );
      await tester.pumpAndSettle();

      expect(find.text(l10n.evolutionPercentDown('40.9')), findsOneWidget);
    });

    testWidgets('un empeoramiento no se pinta de rojo', (tester) async {
      final points = <IbsSssEvolutionPoint>[
        _point(
          totalScore: 200,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
        ),
        _point(
          totalScore: 250,
          cycleNumber: 1,
          completedAt: DateTime.now().toUtc().subtract(const Duration(days: 2)),
          deltaFromBaseline: 50,
        ),
      ];
      await _pump(
        tester,
        repository: FakeIbsSssRepository()..evolutionPoints = points,
      );
      await tester.pumpAndSettle();

      final value = tester.widget<Text>(
        find.byKey(const Key('evolution_percent_value')),
      );
      expect(value.data, l10n.evolutionPercentUp('25.0'));
      expect(value.style?.color, isNot(CauceColors.dangerText));
      expect(value.style?.color, isNot(CauceColors.fodmapHighText));
    });

    testWidgets('el filtro arranca en Todo', (tester) async {
      await _pump(
        tester,
        repository: FakeIbsSssRepository()..evolutionPoints = _twoPoints(),
      );
      await tester.pumpAndSettle();

      expect(find.text(l10n.evolutionRangeAll), findsOneWidget);
      expect(find.byKey(evolutionChartKey), findsOneWidget);
    });

    testWidgets('elegir "Ultimo mes" recorta la serie sin tocar el porcentaje',
        (tester) async {
      // La linea base es de agosto de 2026 y la periodica de hace tres dias:
      // con la ventana de un mes, la base queda fuera del grafico pero el
      // porcentaje se sigue calculando contra ella (decision 3.1).
      await _pump(
        tester,
        repository: FakeIbsSssRepository()..evolutionPoints = _twoPoints(),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text(l10n.evolutionRangeLastMonth));
      await tester.pumpAndSettle();

      expect(find.text(l10n.evolutionPercentDown('40.9')), findsOneWidget);
    });
  });

  group('EvolutionScreen · CP061, solo linea base', () {
    testWidgets('muestra el puntaje, el motivo y la proxima evaluacion',
        (tester) async {
      final points = <IbsSssEvolutionPoint>[
        _point(
          totalScore: 220,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
          nextAssessmentDate: DateTime.utc(2026, 8, 24),
        ),
      ];
      await _pump(
        tester,
        repository: FakeIbsSssRepository()..evolutionPoints = points,
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('evolution_baseline_only')), findsOneWidget);
      expect(find.text(l10n.evolutionScore(220)), findsOneWidget);
      expect(find.text(l10n.evolutionBaselineOnlyBody), findsOneWidget);
      expect(
        find.text(
          l10n.evolutionNextAssessment(
            OnboardingLabels.date(DateTime.utc(2026, 8, 24).toLocal()),
          ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('no dibuja grafico ni filtro', (tester) async {
      final points = <IbsSssEvolutionPoint>[
        _point(
          totalScore: 220,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
          nextAssessmentDate: DateTime.utc(2026, 8, 24),
        ),
      ];
      await _pump(
        tester,
        repository: FakeIbsSssRepository()..evolutionPoints = points,
      );
      await tester.pumpAndSettle();

      expect(find.byKey(evolutionChartKey), findsNothing);
      expect(find.byKey(const Key('evolution_range')), findsNothing);
    });

    testWidgets('sin fecha agendada omite la linea en vez de inventarla',
        (tester) async {
      final points = <IbsSssEvolutionPoint>[
        _point(
          totalScore: 220,
          cycleNumber: 0,
          completedAt: DateTime.utc(2026, 8, 10),
          type: IbsSssAssessmentType.baseline,
        ),
      ];
      await _pump(
        tester,
        repository: FakeIbsSssRepository()..evolutionPoints = points,
      );
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('evolution_baseline_only')), findsOneWidget);
      expect(find.byKey(const Key('evolution_next_assessment')), findsNothing);
    });
  });

  group('EvolutionScreen · carga, vacio y fallo', () {
    testWidgets('mientras resuelve avisa que esta cargando', (tester) async {
      await _pump(
        tester,
        repository: FakeIbsSssRepository()
          ..evolutionPoints = _twoPoints()
          ..delay = const Duration(milliseconds: 50),
      );

      expect(find.text(l10n.commonLoading), findsOneWidget);
      expect(find.byKey(evolutionChartKey), findsNothing);

      await tester.pumpAndSettle();
    });

    testWidgets('sin ninguna evaluacion lo dice', (tester) async {
      await _pump(tester);
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('evolution_empty')), findsOneWidget);
    });

    testWidgets('un fallo de red ofrece reintentar', (tester) async {
      await _pump(
        tester,
        repository: FakeIbsSssRepository()
          ..error = const CauceApiError.network(),
      );
      await tester.pumpAndSettle();

      expect(find.text(l10n.errorNetwork), findsOneWidget);
      expect(find.byKey(const Key('evolution_retry')), findsOneWidget);
    });
  });
}
