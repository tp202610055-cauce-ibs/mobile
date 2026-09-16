import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_baseline.dart';
import 'package:cauce_mobile/features/onboarding/presentation/ibs_sss_baseline_screen.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_ibs_sss_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

final AppLocalizations l10n = AppLocalizationsEs();

Future<FakeIbsSssRepository> _pump(
  WidgetTester tester, {
  FakeIbsSssRepository? repository,
}) async {
  final ibsSss = repository ?? FakeIbsSssRepository();
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        ibsSssRepositoryProvider.overrideWithValue(ibsSss),
        patientsRepositoryProvider
            .overrideWithValue(FakePatientsRepository(profile: demoProfile)),
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
        home: const IbsSssBaselineScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return ibsSss;
}

/// Responde una dimension moviendo su control.
///
/// Se arrastra en vez de fijar el valor a mano: es lo que hace el paciente, y
/// asi el test cubre tambien el cableado del slider con el notifier.
Future<void> _answer(WidgetTester tester, IbsSssDimension dimension) async {
  final finder = find.byKey(Key('ibs_sss_${dimension.name}'));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.drag(
    find.descendant(of: finder, matching: find.byType(Slider)),
    const Offset(20, 0),
  );
  await tester.pumpAndSettle();
}

Future<void> _answerAll(WidgetTester tester) async {
  for (final dimension in IbsSssDimension.values) {
    await _answer(tester, dimension);
  }
}

Future<void> _tap(WidgetTester tester, Finder finder) async {
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  group('IbsSssBaselineScreen · composicion', () {
    testWidgets('muestra el indicador de paso 2 de 2', (tester) async {
      await _pump(tester);

      expect(
        tester
            .widget<Text>(find.byKey(const Key('onboarding_step_label')))
            .data,
        l10n.onboardingStepLabel(2, 2),
      );
    });

    testWidgets('presenta las cinco preguntas con su escala', (tester) async {
      await _pump(tester);

      expect(find.byType(CauceSlider), findsNWidgets(5));
      for (final dimension in IbsSssDimension.values) {
        expect(
          find.byKey(Key('ibs_sss_${dimension.name}')),
          findsOneWidget,
          reason: dimension.name,
        );
      }
    });

    testWidgets('encuadra las respuestas en los ultimos diez dias',
        (tester) async {
      await _pump(tester);

      expect(find.text(l10n.ibsSssSubtitle), findsOneWidget);
      expect(l10n.ibsSssSubtitle, contains('diez'));
    });
  });

  group('IbsSssBaselineScreen · obligatoriedad de las cinco (CA02)', () {
    testWidgets('el envio nace deshabilitado', (tester) async {
      await _pump(tester);

      final button = tester.widget<CauceButton>(
        find.byKey(const Key('ibs_sss_submit')),
      );
      expect(button.onPressed, isNull);
    });

    testWidgets('con cuatro de cinco sigue deshabilitado', (tester) async {
      final repository = await _pump(tester);

      for (final dimension in IbsSssDimension.values.take(4)) {
        await _answer(tester, dimension);
      }

      final button = tester.widget<CauceButton>(
        find.byKey(const Key('ibs_sss_submit')),
      );
      expect(button.onPressed, isNull);
      expect(repository.submitted, isEmpty);
    });

    testWidgets('el contador dice cuantas faltan', (tester) async {
      await _pump(tester);

      await _answer(tester, IbsSssDimension.painSeverity);

      expect(
        tester.widget<Text>(find.byKey(const Key('ibs_sss_pending'))).data,
        l10n.ibsSssPending(4),
      );
    });

    testWidgets('con las cinco el contador desaparece y el envio se habilita',
        (tester) async {
      await _pump(tester);

      await _answerAll(tester);

      expect(find.byKey(const Key('ibs_sss_pending')), findsNothing);
      final button = tester.widget<CauceButton>(
        find.byKey(const Key('ibs_sss_submit')),
      );
      expect(button.onPressed, isNotNull);
    });
  });

  group('IbsSssBaselineScreen · envio y resultado', () {
    testWidgets('envia las cinco dimensiones', (tester) async {
      final repository = await _pump(tester);

      await _answerAll(tester);
      await _tap(tester, find.byKey(const Key('ibs_sss_submit')));

      expect(repository.submitted, hasLength(1));
      expect(repository.submitted.single.isComplete, isTrue);
    });

    testWidgets('tras enviar muestra el resultado del servidor',
        (tester) async {
      await _pump(tester);

      await _answerAll(tester);
      await _tap(tester, find.byKey(const Key('ibs_sss_submit')));

      expect(find.byKey(const Key('ibs_sss_result_title')), findsOneWidget);
      expect(
        tester.widget<Text>(find.byKey(const Key('ibs_sss_result_score'))).data,
        l10n.ibsSssResultScore(220),
      );
      expect(
        tester
            .widget<Text>(find.byKey(const Key('ibs_sss_result_severity')))
            .data,
        l10n.ibsSssSeverityModerate,
      );
    });

    testWidgets('el resultado va en registro neutro, sin alarma',
        (tester) async {
      await _pump(tester);

      await _answerAll(tester);
      await _tap(tester, find.byKey(const Key('ibs_sss_submit')));

      expect(find.text(l10n.ibsSssResultNote), findsOneWidget);
      expect(l10n.ibsSssResultNote.toLowerCase(), contains('nutricionista'));
      expect(l10n.ibsSssResultNote, isNot(contains('!')));
    });

    testWidgets('el resultado ofrece continuar al inicio', (tester) async {
      await _pump(tester);

      await _answerAll(tester);
      await _tap(tester, find.byKey(const Key('ibs_sss_submit')));

      expect(
        find.byKey(const Key('ibs_sss_result_continue')),
        findsOneWidget,
      );
    });

    testWidgets(
        'un error del backend vuelve al cuestionario con las respuestas',
        (tester) async {
      // Volver a pedir las cinco tras un 429 seria castigar al paciente por un
      // limite que no depende de el.
      final repository = FakeIbsSssRepository(
        error: const CauceApiError.rateLimited(retryAfterSeconds: 45),
      );
      await _pump(tester, repository: repository);

      await _answerAll(tester);
      await _tap(tester, find.byKey(const Key('ibs_sss_submit')));

      expect(find.byKey(const Key('ibs_sss_result_title')), findsNothing);
      expect(find.byType(CauceSlider), findsNWidgets(5));
      expect(find.byKey(const Key('ibs_sss_pending')), findsNothing);
    });
  });

  group('IbsSssBaselineScreen · aplazar (CA05)', () {
    testWidgets('ofrece el boton de completar mas tarde', (tester) async {
      await _pump(tester);

      expect(find.byKey(const Key('onboarding_defer')), findsOneWidget);
    });
  });
}
