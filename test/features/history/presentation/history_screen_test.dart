import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/history/application/history_notifier.dart';
import 'package:cauce_mobile/features/history/domain/history_entry.dart';
import 'package:cauce_mobile/features/history/presentation/history_screen.dart';
import 'package:cauce_mobile/features/history/presentation/widgets/history_cards.dart';
import 'package:cauce_mobile/features/meals/domain/meal_draft.dart';
import 'package:cauce_mobile/features/onboarding/application/onboarding_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/symptoms/domain/symptom_draft.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

/// El Diario, con las entradas ya resueltas.
///
/// **Existe por lo que se vio en el celular:** entre las comidas aparecian
/// dos tarjetas blancas, completamente vacias, y el sintoma registrado no
/// figuraba en ningun lado. Los 814 tests en verde no lo veian porque nadie
/// montaba esta pantalla con datos.
class _FixedHistory extends HistoryNotifier {
  _FixedHistory(this._entries);

  final List<HistoryEntry> _entries;

  @override
  HistoryState build() => HistoryState(entries: _entries);

  @override
  Future<void> load({DateTime? from, DateTime? to}) async {}
}

HistoryEntry _meal({
  required DateTime at,
  HistoryEntrySyncState sync = HistoryEntrySyncState.synced,
  String? serverId = 'meal-1',
  MealTimeOption mealTime = MealTimeOption.lunch,
  List<String> items = const <String>['Arroz blanco cocido'],
}) {
  return HistoryEntry(
    kind: HistoryEntryKind.meal,
    occurredAt: at,
    syncState: sync,
    serverId: serverId,
    clientGuid: 'guid-meal',
    mealTime: mealTime,
    itemNames: items,
  );
}

HistoryEntry _symptom({
  required DateTime at,
  int intensity = 60,
  bool associated = false,
  MealTimeOption? associatedMealTime,
  Duration? delay,
}) {
  return HistoryEntry(
    kind: HistoryEntryKind.symptom,
    occurredAt: at,
    syncState: HistoryEntrySyncState.synced,
    serverId: 'symptom-1',
    clientGuid: 'guid-symptom',
    symptomType: SymptomTypeOption.diarrhea,
    intensity: intensity,
    hasMealAssociation: associated,
    associatedMealTime: associatedMealTime,
    associatedMealDelay: delay,
  );
}

Future<void> _pump(WidgetTester tester, List<HistoryEntry> entries) async {
  final container = ProviderContainer(
    overrides: <Override>[
      patientsRepositoryProvider.overrideWithValue(
        FakePatientsRepository(
          profile: demoProfile.copyWith(onboardingCompleted: true),
        ),
      ),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
      historyNotifierProvider.overrideWith(() => _FixedHistory(entries)),
    ],
  );
  addTearDown(container.dispose);

  await container.read(sessionNotifierProvider.notifier).loginSucceeded(
        accessToken: 'access-1',
        refreshToken: 'refresh-1',
        user: demoUser,
      );
  await container.read(onboardingNotifierProvider.future);

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
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
        home: const HistoryScreen(),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 300));
}

void main() {
  final hoy = DateTime.now().toLocal();
  DateTime aLas(int hora, {int dias = 0}) =>
      DateTime(hoy.year, hoy.month, hoy.day - dias, hora, 30);

  group('Diario · las tres clases de fila se ven', () {
    testWidgets('comida, sintoma y pendiente aparecen, y ninguna vacia',
        (tester) async {
      await _pump(tester, <HistoryEntry>[
        _meal(at: aLas(13)),
        _symptom(at: aLas(15)),
        _meal(
          at: aLas(20),
          sync: HistoryEntrySyncState.pending,
          serverId: null,
          mealTime: MealTimeOption.dinner,
          items: <String>['Brócoli cocido'],
        ),
      ]);

      expect(find.byType(HistoryCard), findsNWidgets(3));

      // **Ninguna tarjeta vacia.** Cada fila dibuja exactamente un icono de
      // tipo en su encabezado, asi que contar iconos cuenta tarjetas con
      // contenido. En el celular habia tarjetas sin nada: esta cuenta no
      // habria dado.
      final iconos = tester.widgetList<Icon>(find.byType(Icon)).where(
            (icon) =>
                icon.icon == TablerIcons.bowl ||
                icon.icon == TablerIcons.activity,
          );
      expect(iconos, hasLength(3));

      // Y las dos comidas muestran lo que el paciente registro.
      expect(find.text('Arroz blanco cocido'), findsOneWidget);
      expect(find.text('Brócoli cocido'), findsOneWidget);
    });

    testWidgets('el sintoma muestra su tipo y su intensidad', (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('es'));
      await _pump(
        tester,
        <HistoryEntry>[_symptom(at: aLas(15), intensity: 60)],
      );

      expect(find.text(l10n.historyIntensityBadge(60)), findsOneWidget);
    });

    testWidgets('una fila pendiente muestra su badge y no ofrece nota',
        (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('es'));
      await _pump(tester, <HistoryEntry>[
        _meal(
          at: aLas(20),
          sync: HistoryEntrySyncState.pending,
          serverId: null,
        ),
      ]);

      expect(find.text(l10n.historySyncPending), findsOneWidget);
      expect(find.byKey(const Key('history_note_unavailable')), findsOneWidget);
      expect(find.byKey(const Key('history_add_note')), findsNothing);
    });
  });

  group('Diario · agrupacion por dia', () {
    testWidgets('Hoy encabeza, y los dias anteriores van debajo',
        (tester) async {
      final l10n = await AppLocalizations.delegate.load(const Locale('es'));
      await _pump(tester, <HistoryEntry>[
        _meal(at: aLas(13, dias: 2)),
        _meal(at: aLas(9)),
      ]);

      final hoyY = tester.getTopLeft(find.text(l10n.historyToday)).dy;
      final tarjetas =
          tester.widgetList<HistoryCard>(find.byType(HistoryCard)).toList();

      expect(tarjetas, hasLength(2));
      // La primera tarjeta de la lista es la de hoy.
      expect(tarjetas.first.entry.occurredAt.day, hoy.day);
      expect(
        hoyY,
        lessThan(tester.getTopLeft(find.byType(HistoryCard).last).dy),
      );
    });

    testWidgets('sin registros de hoy aparece la invitacion corta',
        (tester) async {
      await _pump(tester, <HistoryEntry>[_meal(at: aLas(13, dias: 3))]);

      expect(
        find.byKey(const Key('history_today_invitation')),
        findsOneWidget,
      );
    });

    testWidgets('sin ningun registro aparece el estado vacio completo',
        (tester) async {
      await _pump(tester, <HistoryEntry>[]);

      expect(find.byKey(const Key('history_empty')), findsOneWidget);
      expect(find.byType(HistoryCard), findsNothing);
    });
  });

  group('Diario · la asociacion con la comida', () {
    testWidgets('con la comida resuelta dice cual y a que distancia',
        (tester) async {
      await _pump(tester, <HistoryEntry>[
        _symptom(
          at: aLas(15),
          associated: true,
          associatedMealTime: MealTimeOption.lunch,
          delay: const Duration(hours: 1, minutes: 30),
        ),
      ]);

      expect(find.byKey(const Key('history_meal_associated')), findsOneWidget);
      expect(find.textContaining('1 h 30 min'), findsOneWidget);
    });

    testWidgets('sin la comida en el rango, lo dice sin inventar cual',
        (tester) async {
      await _pump(tester, <HistoryEntry>[
        _symptom(at: aLas(15), associated: true),
      ]);

      expect(
        find.byKey(const Key('history_meal_associated_generic')),
        findsOneWidget,
      );
      expect(find.byKey(const Key('history_meal_associated')), findsNothing);
    });

    testWidgets('con distancia negativa omite la distancia', (tester) async {
      // El servidor ancla la ventana en `clientCreatedAt`, de modo que un
      // sintoma de ayer registrado hoy puede quedar asociado con una comida
      // posterior. Decir "3 h despues" seria falso.
      await _pump(tester, <HistoryEntry>[
        _symptom(
          at: aLas(15),
          associated: true,
          associatedMealTime: MealTimeOption.lunch,
          delay: const Duration(hours: -3),
        ),
      ]);

      expect(
        find.byKey(const Key('history_meal_associated_generic')),
        findsOneWidget,
      );
    });

    testWidgets('mas alla de las cuatro horas tambien la omite',
        (tester) async {
      await _pump(tester, <HistoryEntry>[
        _symptom(
          at: aLas(15),
          associated: true,
          associatedMealTime: MealTimeOption.lunch,
          delay: const Duration(hours: 6),
        ),
      ]);

      expect(
        find.byKey(const Key('history_meal_associated_generic')),
        findsOneWidget,
      );
    });
  });
}
