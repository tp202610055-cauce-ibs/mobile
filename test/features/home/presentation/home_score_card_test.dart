import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/home/presentation/widgets/home_cards.dart';
import 'package:cauce_mobile/features/ibs_sss/application/periodic_assessment_notifier.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

List<IbsSssEvolutionPoint> _series(List<int> scores) => <IbsSssEvolutionPoint>[
      for (final (index, score) in scores.indexed)
        IbsSssEvolutionPoint(
          assessmentId: 'a$index',
          totalScore: score,
          assessmentType: index == 0
              ? IbsSssAssessmentType.baseline
              : IbsSssAssessmentType.periodic,
          completedAt: DateTime.utc(2026, 9, 1 + index * 14),
          deltaFromBaseline: index == 0 ? null : score - scores.first,
        ),
    ];

Future<void> _pump(WidgetTester tester, List<int> scores) async {
  final series = _series(scores);
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        ibsSssEvolutionProvider.overrideWith((_) async => series),
        latestIbsSssAssessmentProvider.overrideWith(
          (_) async => IbsSssAssessmentSummaryData(
            assessmentId: series.last.assessmentId,
            totalScore: series.last.totalScore,
            assessmentType: IbsSssAssessmentType.periodic,
          ),
        ),
      ],
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
        home: const Scaffold(body: HomeScoreCard()),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

CauceSparkline _sparkline(WidgetTester tester) => tester.widget<CauceSparkline>(
      find.byKey(const Key('home_score_sparkline')),
    );

void main() {
  group('HomeScoreCard · evolución resumida (CP039)', () {
    testWidgets('A: bajo el umbral, tres puntos, línea en 270 y celebración',
        (tester) async {
      await _pump(tester, <int>[320, 280, 245]);

      expect(
        _sparkline(tester).points.map((p) => p.value),
        <double>[320, 280, 245],
      );
      expect(_sparkline(tester).referenceValue, 270);
      expect(find.byKey(const Key('home_score_celebration')), findsOneWidget);
    });

    testWidgets('B: sobre el umbral no celebra', (tester) async {
      await _pump(tester, <int>[320, 300, 290]);

      expect(_sparkline(tester).referenceValue, 270);
      expect(find.byKey(const Key('home_score_celebration')), findsNothing);
    });

    testWidgets('C: justo en el umbral también celebra', (tester) async {
      await _pump(tester, <int>[320, 300, 270]);

      expect(find.byKey(const Key('home_score_celebration')), findsOneWidget);
    });

    testWidgets('con menos de tres resultados no dibuja el gráfico',
        (tester) async {
      await _pump(tester, <int>[320, 290]);

      expect(find.byKey(const Key('home_score_sparkline')), findsNothing);
    });
  });
}
