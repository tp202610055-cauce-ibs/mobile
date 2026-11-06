import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/periodic_assessment_screen.dart';
import 'package:cauce_mobile/features/onboarding/presentation/widgets/onboarding_labels.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_ibs_sss_repository.dart';
import '../../../helpers/fake_token_storage.dart';

final AppLocalizations l10n = AppLocalizationsEs();

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

Future<void> _pumpPeriodic(
  WidgetTester tester,
  FakeIbsSssRepository repository,
) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        ibsSssRepositoryProvider.overrideWithValue(repository),
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
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
        home: const PeriodicAssessmentScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}

Finder _slider(IbsSssDimension dimension) => find.descendant(
      of: find.byKey(Key('ibs_sss_${dimension.name}')),
      matching: find.byType(Slider),
    );

/// Fija el valor del deslizador; la pregunta 2 va en días.
Future<void> _answer(
  WidgetTester tester,
  IbsSssDimension dimension,
  double value,
) async {
  await tester.ensureVisible(_slider(dimension));
  await tester.pumpAndSettle();
  tester.widget<Slider>(_slider(dimension)).onChanged!(value);
  await tester.pumpAndSettle();
}

IbsSssEvolutionPoint _point(int score, {int? delta}) => IbsSssEvolutionPoint(
      assessmentId: 'a-$score',
      totalScore: score,
      assessmentType: delta == null
          ? IbsSssAssessmentType.baseline
          : IbsSssAssessmentType.periodic,
      deltaFromBaseline: delta,
    );

IbsSssResult _periodicResult(int score) => IbsSssResult(
      assessmentId: 'p-$score',
      totalScore: score,
      severity: IbsSssSeverity.moderate,
      triggeredOnboardingCompletion: false,
    );

/// Nada del resultado está a la vista mientras se responde (CP033).
void _expectNoScore() {
  expect(find.byKey(const Key('ibs_sss_periodic_result_score')), findsNothing);
  expect(find.byKey(const Key('ibs_sss_evolution_delta')), findsNothing);
  expect(find.textContaining('245'), findsNothing);
  expect(find.textContaining('/ 500'), findsNothing);
  expect(find.textContaining('de 500'), findsNothing);
  for (final severity in IbsSssSeverity.values) {
    expect(
      find.text(OnboardingLabels.ibsSssSeverity(l10n, severity)),
      findsNothing,
    );
  }
}

void main() {
  group('CP033 · el puntaje aparece recién al enviar', () {
    testWidgets(
        'con línea base 320 responde 50, 3 días, 55, 60 y 50 sin ver puntaje '
        'y al enviar ve 245, -75 y la severidad', (tester) async {
      final repository = FakeIbsSssRepository(result: _periodicResult(245))
        ..evolutionPoints = <IbsSssEvolutionPoint>[_point(320)];
      await _pumpPeriodic(tester, repository);

      await _answer(tester, IbsSssDimension.painSeverity, 50);
      _expectNoScore();
      await _answer(tester, IbsSssDimension.painFrequency, 3);
      _expectNoScore();
      await _answer(tester, IbsSssDimension.bloatingSeverity, 55);
      await _answer(tester, IbsSssDimension.bowelHabitsDissatisfaction, 60);
      await _answer(tester, IbsSssDimension.lifeInterference, 50);
      await tester.drag(
        find.byType(Scrollable).first,
        const Offset(0, -2000),
      );
      await tester.pumpAndSettle();
      _expectNoScore();

      repository.evolutionPoints = <IbsSssEvolutionPoint>[
        _point(320),
        _point(245, delta: -75),
      ];
      await _tap(tester, find.byKey(const Key('ibs_sss_periodic_submit')));

      final sent = repository.submitted.single;
      expect(sent.valueFor(IbsSssDimension.painSeverity), 50);
      expect(sent.valueFor(IbsSssDimension.painFrequency), 30);
      expect(sent.valueFor(IbsSssDimension.bloatingSeverity), 55);
      expect(sent.valueFor(IbsSssDimension.bowelHabitsDissatisfaction), 60);
      expect(sent.valueFor(IbsSssDimension.lifeInterference), 50);
      expect(repository.submittedTypes.single, IbsSssAssessmentType.periodic);
      expect(find.text(l10n.ibsSssResultScore(245)), findsOneWidget);
      expect(find.text(l10n.ibsSssEvolutionDelta(-75)), findsOneWidget);
      expect(find.text(l10n.ibsSssSeverityModerate), findsOneWidget);
    });
  });

  group('CP032 · resultado con su evolución', () {
    testWidgets(
        'A: 320, 280 y 245 dan -75, la respuesta clínica y el gráfico en orden',
        (tester) async {
      final repository = FakeIbsSssRepository(result: _periodicResult(245))
        ..evolutionPoints = <IbsSssEvolutionPoint>[
          _point(320),
          _point(280, delta: -40),
        ];
      await _pumpPeriodic(tester, repository);

      await _answer(tester, IbsSssDimension.painSeverity, 50);
      await _answer(tester, IbsSssDimension.painFrequency, 3);
      await _answer(tester, IbsSssDimension.bloatingSeverity, 55);
      await _answer(tester, IbsSssDimension.bowelHabitsDissatisfaction, 60);
      await _answer(tester, IbsSssDimension.lifeInterference, 50);
      repository.evolutionPoints = <IbsSssEvolutionPoint>[
        _point(320),
        _point(280, delta: -40),
        _point(245, delta: -75),
      ];
      await _tap(tester, find.byKey(const Key('ibs_sss_periodic_submit')));

      expect(find.text(l10n.ibsSssResultScore(245)), findsOneWidget);
      expect(find.text(l10n.ibsSssEvolutionDelta(-75)), findsOneWidget);
      expect(find.text(l10n.ibsSssEvolutionSignificant), findsOneWidget);
      final sparkline = tester.widget<CauceSparkline>(
        find.byKey(const Key('ibs_sss_evolution_sparkline')),
      );
      expect(
        sparkline.points.map((point) => point.value),
        <double>[320, 280, 245],
      );
    });

    testWidgets(
        'B: 60, 4 días, 65, 65 y 60 dan 290 y -30, sin respuesta clínica ni '
        'gráfico', (tester) async {
      final repository = FakeIbsSssRepository(result: _periodicResult(290))
        ..evolutionPoints = <IbsSssEvolutionPoint>[_point(320)];
      await _pumpPeriodic(tester, repository);

      await _answer(tester, IbsSssDimension.painSeverity, 60);
      await _answer(tester, IbsSssDimension.painFrequency, 4);
      await _answer(tester, IbsSssDimension.bloatingSeverity, 65);
      await _answer(tester, IbsSssDimension.bowelHabitsDissatisfaction, 65);
      await _answer(tester, IbsSssDimension.lifeInterference, 60);
      repository.evolutionPoints = <IbsSssEvolutionPoint>[
        _point(320),
        _point(290, delta: -30),
      ];
      await _tap(tester, find.byKey(const Key('ibs_sss_periodic_submit')));

      final sent = repository.submitted.single;
      expect(sent.valueFor(IbsSssDimension.painFrequency), 40);
      expect(sent.valueFor(IbsSssDimension.bloatingSeverity), 65);
      expect(find.text(l10n.ibsSssResultScore(290)), findsOneWidget);
      expect(find.text(l10n.ibsSssEvolutionDelta(-30)), findsOneWidget);
      expect(find.text(l10n.ibsSssEvolutionSignificant), findsNothing);
      expect(
        find.byKey(const Key('ibs_sss_evolution_sparkline')),
        findsNothing,
      );
    });
  });

  testWidgets(
      'el resultado periodico tiene su propio texto, no el de la linea base',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: <Override>[
          ibsSssRepositoryProvider.overrideWithValue(FakeIbsSssRepository()),
          authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
          tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
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
          home: const PeriodicAssessmentScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    for (final dimension in IbsSssDimension.values) {
      final finder = find.byKey(Key('ibs_sss_${dimension.name}'));
      await tester.ensureVisible(finder);
      await tester.pumpAndSettle();
      await tester.drag(
        find.descendant(of: finder, matching: find.byType(Slider)),
        const Offset(20, 0),
      );
      await tester.pumpAndSettle();
    }
    await _tap(tester, find.byKey(const Key('ibs_sss_periodic_submit')));

    expect(
      find.byKey(const Key('ibs_sss_periodic_result_title')),
      findsOneWidget,
    );
    expect(find.text(l10n.ibsSssPeriodicResultNote), findsOneWidget);
    expect(find.text(l10n.ibsSssResultNote), findsNothing);
    expect(l10n.ibsSssPeriodicResultNote, isNot(contains('punto de partida')));
  });
}
