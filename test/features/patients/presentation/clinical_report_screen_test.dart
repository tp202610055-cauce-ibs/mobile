import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/features/patients/application/data_export_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/presentation/clinical_report_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/fake_patients_repository.dart';

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

Future<({_FakeLauncher launcher, FakePatientsRepository repository})> _pump(
  WidgetTester tester, {
  FakePatientsRepository? repository,
  _FakeLauncher? launcher,
}) async {
  final h = (
    launcher: launcher ?? _FakeLauncher(),
    repository: repository ?? FakePatientsRepository(),
  );

  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        patientsRepositoryProvider.overrideWithValue(h.repository),
        dataExportLauncherProvider.overrideWithValue(h.launcher),
      ],
      // Con router minimo: la pantalla lleva boton de retroceso, y ese boton
      // consulta `GoRouter.canPop()`.
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
              builder: (_, __) => const ClinicalReportScreen(),
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pumpAndSettle();
  return h;
}

Future<void> _submit(WidgetTester tester) async {
  final finder = find.byKey(const Key('report_submit'));
  await tester.ensureVisible(finder);
  await tester.pumpAndSettle();
  await tester.tap(finder);
  await tester.pumpAndSettle();
}

void main() {
  group('ClinicalReportScreen · periodo', () {
    testWidgets('arranca en los ultimos 30 dias', (tester) async {
      await _pump(tester);

      expect(find.byKey(const Key('report_period')), findsOneWidget);
      expect(find.text(l10n.reportPeriodLast30), findsOneWidget);
      expect(find.text(l10n.reportPeriodLast90), findsOneWidget);
    });

    testWidgets('el rango por defecto pide 30 dias, calculados aca',
        (tester) async {
      // El contrato declara el cuerpo opcional, pero el cliente lo manda
      // siempre: sin el, el servidor caeria a su ventana de 90 dias contra su
      // propio reloj.
      final h = await _pump(tester);

      await _submit(tester);

      expect(h.repository.requestedReportPeriods.length, 1);
      final period = h.repository.requestedReportPeriods.single;
      expect(period.end.difference(period.start).inDays, 30);
    });

    testWidgets('elegir 90 dias cambia el rango que se pide', (tester) async {
      final h = await _pump(tester);

      await tester.tap(find.text(l10n.reportPeriodLast90));
      await tester.pumpAndSettle();
      await _submit(tester);

      final period = h.repository.requestedReportPeriods.single;
      expect(period.end.difference(period.start).inDays, 90);
    });
  });

  group('ClinicalReportScreen · exito (CP062)', () {
    testWidgets('genera el reporte y abre su enlace', (tester) async {
      final h = await _pump(tester);

      await _submit(tester);

      expect(
        h.launcher.opened,
        <String>['https://minio.local/reports/paciente-demo.pdf'],
      );
      expect(find.byKey(const Key('report_ready')), findsOneWidget);
    });

    testWidgets('no promete que el correo haya llegado', (tester) async {
      // El backend manda los dos correos despues de responder y no confirma la
      // entrega. La pantalla describe el paso esperado, no un hecho.
      await _pump(tester);

      await _submit(tester);

      expect(find.byKey(const Key('report_password_note')), findsOneWidget);
      expect(find.text(l10n.reportReadyPassword), findsOneWidget);
      expect(find.byKey(const Key('report_retry_hint')), findsOneWidget);
      // El titulo afirma solo lo verificado.
      expect(find.text(l10n.reportReadyTitle), findsOneWidget);
    });

    testWidgets('reabrir la descarga no genera un reporte nuevo',
        (tester) async {
      // Un reporte nuevo significa otra contraseña y dos correos mas.
      final h = await _pump(tester);

      await _submit(tester);
      expect(h.repository.requestedReportPeriods.length, 1);

      final open = find.byKey(const Key('report_open_download'));
      await tester.ensureVisible(open);
      await tester.pumpAndSettle();
      await tester.tap(open);
      await tester.pumpAndSettle();

      expect(h.repository.requestedReportPeriods.length, 1);
      expect(h.launcher.opened.length, 2);
    });

    testWidgets('si el sistema no abre el enlace lo dice sin llamarlo error',
        (tester) async {
      await _pump(tester, launcher: _FakeLauncher(succeeds: false));

      await _submit(tester);

      expect(find.byKey(const Key('report_ready')), findsOneWidget);
      expect(find.text(l10n.reportNotOpened), findsOneWidget);
      expect(find.byKey(const Key('report_error')), findsNothing);
    });
  });

  group('ClinicalReportScreen · sin datos (CP063)', () {
    testWidgets('avisa y sugiere otro rango, sin presentarlo como fallo',
        (tester) async {
      final repository = FakePatientsRepository()
        ..generateReportError = const CauceApiError.patientHasNoDataInPeriod();
      final h = await _pump(tester, repository: repository);

      await _submit(tester);

      expect(find.byKey(const Key('report_no_data')), findsOneWidget);
      expect(find.text(l10n.errorPatientHasNoDataInPeriod), findsOneWidget);
      expect(find.byKey(const Key('report_no_data_hint')), findsOneWidget);
      // No es un error: no hay banner, y no se abrio ninguna descarga.
      expect(find.byKey(const Key('report_error')), findsNothing);
      expect(h.launcher.opened, isEmpty);
      expect(find.byKey(const Key('report_ready')), findsNothing);
    });
  });

  group('ClinicalReportScreen · errores', () {
    testWidgets('un periodo invalido se muestra con su mensaje propio',
        (tester) async {
      final repository = FakePatientsRepository()
        ..generateReportError = const CauceApiError.reportPeriodInvalid();
      await _pump(tester, repository: repository);

      await _submit(tester);

      expect(find.byKey(const Key('report_error')), findsOneWidget);
      expect(find.text(l10n.errorReportPeriodInvalid), findsOneWidget);
    });

    testWidgets('un fallo de red se muestra como error', (tester) async {
      final repository = FakePatientsRepository()
        ..generateReportError = const CauceApiError.network();
      final h = await _pump(tester, repository: repository);

      await _submit(tester);

      expect(find.byKey(const Key('report_error')), findsOneWidget);
      expect(find.text(l10n.errorNetwork), findsOneWidget);
      expect(h.launcher.opened, isEmpty);
    });
  });

  group('ClinicalReportScreen · doble envio', () {
    testWidgets(
        'el boton queda deshabilitado mientras la solicitud esta en '
        'vuelo', (tester) async {
      final repository = FakePatientsRepository()
        ..delay = const Duration(milliseconds: 60);
      final h = await _pump(tester, repository: repository);

      await tester.tap(find.byKey(const Key('report_submit')));
      await tester.pump();

      expect(find.byKey(const Key('report_generating')), findsOneWidget);
      final button = tester.widget<ElevatedButton>(
        find.descendant(
          of: find.byKey(const Key('report_submit')),
          matching: find.byType(ElevatedButton),
        ),
      );
      expect(button.onPressed, isNull);

      await tester.pumpAndSettle();
      expect(h.repository.requestedReportPeriods.length, 1);
    });
  });
}
