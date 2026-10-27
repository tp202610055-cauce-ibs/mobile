import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/domain/patient_profile.dart';
import 'package:cauce_mobile/features/patients/presentation/profile_edit_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/fake_patients_repository.dart';

final AppLocalizations l10n = AppLocalizationsEs();

Future<FakePatientsRepository> _pump(WidgetTester tester) async {
  final repository = FakePatientsRepository(
    profile: demoProfile.copyWith(weightKg: 62, heightCm: 165),
  );
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        patientsRepositoryProvider.overrideWithValue(repository),
      ],
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
          initialLocation: '/edit',
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (_, __) => const Scaffold(body: Text('origen')),
              routes: <RouteBase>[
                GoRoute(
                  path: 'edit',
                  builder: (_, __) => const ProfileEditScreen(),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return repository;
}

Finder _field(String key) => find.descendant(
      of: find.byKey(Key(key)),
      matching: find.byType(EditableText),
    );

String _text(WidgetTester tester, String key) =>
    tester.widget<EditableText>(_field(key)).controller.text;

Future<void> _save(WidgetTester tester) async {
  await tester.ensureVisible(find.byKey(const Key('profile_edit_save')));
  await tester.tap(find.byKey(const Key('profile_edit_save')));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('arranca con los valores actuales del perfil', (tester) async {
    await _pump(tester);

    expect(_text(tester, 'profile_edit_weight'), '62');
    expect(_text(tester, 'profile_edit_height'), '165');
    expect(find.text(l10n.ibsSubtypeD), findsOneWidget);
  });

  testWidgets('CP078 A: un peso negativo se señala y conserva la estatura',
      (tester) async {
    final repository = await _pump(tester);

    await tester.enterText(_field('profile_edit_weight'), '-68');
    await tester.enterText(_field('profile_edit_height'), '166');
    await _save(tester);

    expect(find.text(l10n.validationWeightNegative), findsOneWidget);
    expect(_text(tester, 'profile_edit_height'), '166');
    expect(repository.updatedProfiles, isEmpty);
  });

  testWidgets('CP078 B: una estatura con letras pide un número',
      (tester) async {
    final repository = await _pump(tester);

    await tester.enterText(_field('profile_edit_weight'), '64');
    await tester.enterText(_field('profile_edit_height'), 'ciento setenta');
    await _save(tester);

    expect(find.text(l10n.validationHeightNotNumber), findsOneWidget);
    expect(_text(tester, 'profile_edit_weight'), '64');
    expect(repository.updatedProfiles, isEmpty);
  });

  testWidgets('CP078 C: el peso vacío es obligatorio', (tester) async {
    final repository = await _pump(tester);

    await tester.enterText(_field('profile_edit_weight'), '');
    await tester.enterText(_field('profile_edit_height'), '166');
    await _save(tester);

    expect(find.text(l10n.validationWeightRequired), findsOneWidget);
    expect(_text(tester, 'profile_edit_height'), '166');
    expect(repository.updatedProfiles, isEmpty);
  });

  testWidgets('CP071: guarda peso, estatura y subtipo y confirma',
      (tester) async {
    final repository = await _pump(tester);

    await tester.enterText(_field('profile_edit_weight'), '64');
    await tester.enterText(_field('profile_edit_height'), '166');
    await tester.ensureVisible(find.text(l10n.ibsSubtypeM));
    await tester.tap(find.text(l10n.ibsSubtypeM));
    await tester.pump();
    await _save(tester);

    expect(repository.updatedProfiles.single.weightKg, 64);
    expect(repository.updatedProfiles.single.heightCm, 166);
    expect(repository.updatedProfiles.single.subtype, IbsSubtypeOption.ibsM);
    expect(find.text(l10n.profileEditSaved), findsOneWidget);
    expect(find.text('origen'), findsOneWidget);
  });
}
