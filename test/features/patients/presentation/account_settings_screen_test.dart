import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/router/app_routes.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/auth/application/session_notifier.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/patients/application/data_export_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/presentation/account_settings_screen.dart';
import 'package:cauce_mobile/features/patients/presentation/privacy_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

final AppLocalizations l10n = AppLocalizationsEs();

/// Lanzador controlable: registra lo que se le pidio abrir.
class _FakeLauncher implements DataExportLauncher {
  _FakeLauncher({this.succeeds = true});

  final bool succeeds;
  final List<String> opened = <String>[];

  @override
  Future<bool> open(String url) async {
    opened.add(url);
    return succeeds;
  }
}

/// Snapshot de sesion con o sin piloto activo.
AuthenticatedUserSnapshot _user({required bool inPilot}) =>
    demoUser.copyWith(isInActivePilot: inPilot);

final PackageInfo _packageInfo = PackageInfo(
  appName: 'Cauce',
  packageName: 'pe.upc.cauce.cauce_mobile',
  version: '1.0.0',
  buildNumber: '7',
);

({_FakeLauncher launcher, FakePatientsRepository repository}) _harness({
  FakePatientsRepository? repository,
  _FakeLauncher? launcher,
}) =>
    (
      launcher: launcher ?? _FakeLauncher(),
      repository: repository ?? FakePatientsRepository(),
    );

Future<({_FakeLauncher launcher, FakePatientsRepository repository})> _pump(
  WidgetTester tester, {
  FakePatientsRepository? repository,
  _FakeLauncher? launcher,
  bool inPilot = false,
}) async {
  final h = _harness(repository: repository, launcher: launcher);

  final container = ProviderContainer(
    overrides: <Override>[
      patientsRepositoryProvider.overrideWithValue(h.repository),
      dataExportLauncherProvider.overrideWithValue(h.launcher),
      appPackageInfoProvider.overrideWith((ref) async => _packageInfo),
      authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
      tokenStorageProvider.overrideWithValue(
        FakeTokenStorage(
          accessToken: 'access-1',
          refreshToken: 'refresh-1',
          userSnapshot: _user(inPilot: inPilot),
        ),
      ),
    ],
  );
  addTearDown(container.dispose);

  // La pantalla lee `isInActivePilot` del snapshot de sesion, y el notifier
  // arranca en `unknown` hasta que alguien resuelve el almacenamiento. En la
  // app lo hace el splash; aca se hace a mano.
  await container.read(sessionNotifierProvider.notifier).bootstrap();

  await tester.pumpWidget(
    UncontrolledProviderScope(
      container: container,
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
              builder: (_, __) => const AccountSettingsScreen(),
              routes: <RouteBase>[
                GoRoute(
                  path: AppRoutes.profilePrivacy.substring(1),
                  builder: (_, __) => const PrivacyScreen(),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return h;
}

/// Toca una fila que puede estar fuera de la pantalla.
Future<void> _tapRow(WidgetTester tester, String key) async {
  final finder = find.byKey(Key(key));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

/// Las claves de las once filas accionables del mockup.
const List<String> _allRows = <String>[
  'settings_notif_assessment',
  'settings_notif_advice',
  'settings_export',
  'settings_delete',
  'settings_correct',
  'settings_object',
  'settings_terms',
  'settings_privacy',
  'settings_version',
  'settings_logout',
];

/// Las seis que nacen con guarda.
const List<String> _guardedRows = <String>[
  'settings_notif_assessment',
  'settings_notif_advice',
  'settings_correct',
  'settings_object',
  'settings_terms',
];

void main() {
  group('AccountSettingsScreen · las cinco secciones del mockup', () {
    testWidgets('dibuja todas las filas, en orden', (tester) async {
      await _pump(tester);

      for (final key in _allRows) {
        expect(
          find.byKey(Key(key)),
          findsOneWidget,
          reason: 'falta la fila $key',
        );
      }
      expect(find.byKey(const Key('settings_red_flags')), findsOneWidget);
      expect(find.byKey(const Key('settings_credits')), findsOneWidget);
    });

    testWidgets('las banderas rojas se ven sin un toque extra', (tester) async {
      // El mockup lo pide asi: si es informacion que puede salvar al paciente,
      // no debe exigir un toque mas para verla.
      await _pump(tester);

      expect(find.text(l10n.settingsRedFlagBlood), findsOneWidget);
      expect(find.text(l10n.settingsRedFlagStool), findsOneWidget);
      expect(find.text(l10n.settingsEmergencyValue), findsOneWidget);
    });
  });

  group('AccountSettingsScreen · guardas de la Ley N.o 29733', () {
    testWidgets('las seis filas con guarda estan deshabilitadas de verdad',
        (tester) async {
      await _pump(tester);

      for (final key in _guardedRows) {
        final row = tester.widget<InkWell>(find.byKey(Key(key)));
        expect(
          row.onTap,
          isNull,
          reason: '$key responde al toque y no deberia',
        );
      }
    });

    testWidgets('cada guarda lleva su etiqueta en la fila misma',
        (tester) async {
      await _pump(tester);

      // Cinco filas con etiqueta: los dos avisos, correccion, oposicion y
      // terminos. La etiqueta va en la fila y no en un tooltip, que no existe
      // para quien toca con el dedo.
      expect(
        find.text(l10n.settingsComingSoon),
        findsNWidgets(_guardedRows.length),
      );
    });

    testWidgets('los interruptores no se mueven ni recuerdan nada',
        (tester) async {
      await _pump(tester);

      final switches = tester.widgetList<Switch>(find.byType(Switch)).toList();
      expect(switches.length, 2);
      for (final s in switches) {
        expect(s.value, isFalse);
        expect(
          s.onChanged,
          isNull,
          reason: 'un switch que se mueve sin nada detras simula una '
              'configuracion que no ocurrio',
        );
      }
    });

    testWidgets('tocar una guarda no dispara ninguna confirmacion',
        (tester) async {
      await _pump(tester);

      for (final key in _guardedRows) {
        final finder = find.byKey(Key(key));
        await tester.ensureVisible(finder);
        await tester.pumpAndSettle();
        await tester.tap(finder, warnIfMissed: false);
        await tester.pumpAndSettle();
      }

      // Ni toast de exito, ni dialogo, ni nada que parezca haber pasado.
      expect(find.byType(SnackBar), findsNothing);
      expect(find.byType(Dialog), findsNothing);
      expect(find.byType(AlertDialog), findsNothing);
    });
  });

  group('AccountSettingsScreen · exportacion (HU0025, CP064 y CP065)', () {
    testWidgets('primero avisa el alcance y no exporta nada', (tester) async {
      // CP064 paso 3: el aviso va antes de la llamada.
      final h = await _pump(tester);

      await _tapRow(tester, 'settings_export');

      expect(find.text(l10n.settingsExportConfirmTitle), findsOneWidget);
      expect(h.repository.exportDataCalls, 0);
    });

    testWidgets('cancelar deja todo como estaba', (tester) async {
      final h = await _pump(tester);

      await _tapRow(tester, 'settings_export');
      await tester.tap(find.text(l10n.commonCancel));
      await tester.pumpAndSettle();

      expect(h.repository.exportDataCalls, 0);
      expect(h.launcher.opened, isEmpty);
    });

    testWidgets('al confirmar pide el enlace y lo abre afuera', (tester) async {
      final h = await _pump(tester);

      await _tapRow(tester, 'settings_export');
      await tester.tap(find.text(l10n.settingsExportConfirmAction));
      await tester.pumpAndSettle();

      expect(h.repository.exportDataCalls, 1);
      expect(
        h.launcher.opened,
        <String>['https://minio.local/exports/paciente-demo.zip'],
      );
      expect(find.text(l10n.settingsExportOpened), findsOneWidget);
    });

    testWidgets('CP065: sin registros la exportacion sale igual',
        (tester) async {
      // El backend responde 200 con los CSV vacios y sus encabezados. El
      // cliente no ramifica: un paciente sin datos no es un error.
      final repository = FakePatientsRepository()
        ..exportLinkValue = DataExportLink(
          downloadUrl: 'https://minio.local/exports/vacio.zip',
          expiresAt: DateTime.utc(2026, 9, 23, 15, 5),
        );
      final h = await _pump(tester, repository: repository);

      await _tapRow(tester, 'settings_export');
      await tester.tap(find.text(l10n.settingsExportConfirmAction));
      await tester.pumpAndSettle();

      expect(
        h.launcher.opened,
        <String>['https://minio.local/exports/vacio.zip'],
      );
      expect(find.text(l10n.settingsExportOpened), findsOneWidget);
    });

    testWidgets('si el sistema no abre el enlace lo dice sin llamarlo error',
        (tester) async {
      final h = await _pump(tester, launcher: _FakeLauncher(succeeds: false));

      await _tapRow(tester, 'settings_export');
      await tester.tap(find.text(l10n.settingsExportConfirmAction));
      await tester.pumpAndSettle();

      expect(h.repository.exportDataCalls, 1);
      expect(find.text(l10n.settingsExportNotOpened), findsOneWidget);
      expect(find.text(l10n.settingsExportOpened), findsNothing);
    });

    testWidgets('un fallo del servidor se muestra como error', (tester) async {
      final repository = FakePatientsRepository()
        ..exportDataError = const CauceApiError.network();
      final h = await _pump(tester, repository: repository);

      await _tapRow(tester, 'settings_export');
      await tester.tap(find.text(l10n.settingsExportConfirmAction));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('settings_error')), findsOneWidget);
      expect(h.launcher.opened, isEmpty);
    });
  });

  group('AccountSettingsScreen · baja de cuenta (HU0026, CP066 y CP067)', () {
    testWidgets('el primer aviso explica que se borra y que se conserva',
        (tester) async {
      final h = await _pump(tester);

      await _tapRow(tester, 'settings_delete');

      expect(find.text(l10n.settingsDeleteConfirmTitle), findsOneWidget);
      expect(find.text(l10n.settingsDeleteConfirmBody), findsOneWidget);
      expect(h.repository.deleteAcknowledgements, isEmpty);
    });

    testWidgets('sin piloto activo basta una confirmacion', (tester) async {
      final h = await _pump(tester);

      await _tapRow(tester, 'settings_delete');
      await tester.tap(find.text(l10n.settingsDeleteConfirmAction));
      await tester.pumpAndSettle();

      expect(h.repository.deleteAcknowledgements, <bool>[false]);
    });

    testWidgets('con piloto activo aparece el segundo aviso', (tester) async {
      final h = await _pump(tester, inPilot: true);

      await _tapRow(tester, 'settings_delete');
      await tester.tap(find.text(l10n.settingsDeleteConfirmAction));
      await tester.pumpAndSettle();

      expect(find.text(l10n.settingsDeletePilotTitle), findsOneWidget);
      // Todavia no se llamo a nada.
      expect(h.repository.deleteAcknowledgements, isEmpty);
    });

    testWidgets('CP067 paso 5: cerrar el segundo aviso no elimina nada',
        (tester) async {
      final h = await _pump(tester, inPilot: true);

      await _tapRow(tester, 'settings_delete');
      await tester.tap(find.text(l10n.settingsDeleteConfirmAction));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.commonCancel));
      await tester.pumpAndSettle();

      expect(h.repository.deleteAcknowledgements, isEmpty);
    });

    testWidgets('CP067 paso 6: con la segunda confirmacion si elimina',
        (tester) async {
      final h = await _pump(tester, inPilot: true);

      await _tapRow(tester, 'settings_delete');
      await tester.tap(find.text(l10n.settingsDeleteConfirmAction));
      await tester.pumpAndSettle();
      await tester.tap(find.text(l10n.settingsDeletePilotAction));
      await tester.pumpAndSettle();

      expect(h.repository.deleteAcknowledgements, <bool>[true]);
    });

    testWidgets('un fallo del servidor no cierra la sesion', (tester) async {
      final repository = FakePatientsRepository()
        ..deleteAccountError = const CauceApiError.network();
      await _pump(tester, repository: repository);

      await _tapRow(tester, 'settings_delete');
      await tester.tap(find.text(l10n.settingsDeleteConfirmAction));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('settings_error')), findsOneWidget);
      expect(find.text(l10n.settingsDeleteDone), findsNothing);
    });
  });

  group('AccountSettingsScreen · sobre la app', () {
    testWidgets('la fila de privacidad abre la pantalla ya construida',
        (tester) async {
      await _pump(tester);

      await _tapRow(tester, 'settings_privacy');

      expect(find.byType(PrivacyScreen), findsOneWidget);
    });

    testWidgets('la version sale de package_info y no de una constante',
        (tester) async {
      await _pump(tester);

      expect(
        find.text(l10n.settingsVersionValue('1.0.0', '7')),
        findsOneWidget,
      );
    });
  });

  group('AccountSettingsScreen · cierre de sesion', () {
    testWidgets('pide confirmacion antes de cerrar', (tester) async {
      await _pump(tester);

      await _tapRow(tester, 'settings_logout');

      expect(find.text(l10n.profileLogoutConfirmTitle), findsOneWidget);
    });
  });
}
