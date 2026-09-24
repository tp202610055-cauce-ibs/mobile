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
