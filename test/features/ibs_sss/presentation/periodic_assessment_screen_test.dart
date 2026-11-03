import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/data/ibs_sss_repository.dart';
import 'package:cauce_mobile/features/ibs_sss/domain/ibs_sss_assessment.dart';
import 'package:cauce_mobile/features/ibs_sss/presentation/periodic_assessment_screen.dart';
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

void main() {
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
