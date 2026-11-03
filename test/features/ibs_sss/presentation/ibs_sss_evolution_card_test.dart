import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/widgets/ibs_sss_evolution_card.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

Future<void> _pump(WidgetTester tester, List<IbsSssEvolutionPoint> points) {
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
      home: Scaffold(
        body: SingleChildScrollView(child: IbsSssEvolutionCard(points: points)),
      ),
    ),
  );
}

IbsSssEvolutionPoint _point(int score, {int? delta, bool baseline = false}) =>
    IbsSssEvolutionPoint(
      assessmentId: 'a-$score',
      totalScore: score,
      assessmentType: baseline
          ? IbsSssAssessmentType.baseline
          : IbsSssAssessmentType.periodic,
      deltaFromBaseline: delta,
    );

void main() {
  group('IbsSssEvolutionCard · resultado del cuestionario (CP032)', () {
    testWidgets('con tres resultados muestra el grafico pequeño', (
      tester,
    ) async {
      await _pump(tester, <IbsSssEvolutionPoint>[
        _point(320, baseline: true),
        _point(280, delta: -40),
        _point(245, delta: -75),
      ]);

      expect(
        find.byKey(const Key('ibs_sss_evolution_sparkline')),
        findsOneWidget,
      );
    });

    testWidgets('con dos resultados no muestra el grafico pequeño', (
      tester,
    ) async {
      await _pump(tester, <IbsSssEvolutionPoint>[
        _point(320, baseline: true),
        _point(290, delta: -30),
      ]);

      expect(
        find.byKey(const Key('ibs_sss_evolution_sparkline')),
        findsNothing,
      );
      expect(find.text('-30 puntos respecto de tu línea base'), findsOneWidget);
    });

    testWidgets('con 50 puntos o mas dice «Respuesta clínica significativa»', (
      tester,
    ) async {
      await _pump(tester, <IbsSssEvolutionPoint>[
        _point(320, baseline: true),
        _point(280, delta: -40),
        _point(245, delta: -75),
      ]);

      expect(find.text('Respuesta clínica significativa'), findsOneWidget);
    });

    testWidgets('con menos de 50 puntos no lo dice', (tester) async {
      await _pump(tester, <IbsSssEvolutionPoint>[
        _point(320, baseline: true),
        _point(290, delta: -30),
      ]);

      expect(find.text('Respuesta clínica significativa'), findsNothing);
    });
  });
}
