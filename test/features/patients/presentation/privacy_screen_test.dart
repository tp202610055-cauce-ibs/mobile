import 'package:cauce_mobile/core/auth/token_storage_provider.dart';
import 'package:cauce_mobile/core/errors/cauce_api_error.dart';
import 'package:cauce_mobile/core/theme/app_theme.dart';
import 'package:cauce_mobile/core/widgets/widgets.dart';
import 'package:cauce_mobile/features/auth/data/auth_repository.dart';
import 'package:cauce_mobile/features/onboarding/presentation/widgets/onboarding_labels.dart';
import 'package:cauce_mobile/features/patients/application/consent_download_notifier.dart';
import 'package:cauce_mobile/features/patients/data/patients_repository.dart';
import 'package:cauce_mobile/features/patients/presentation/privacy_screen.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations_es.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import '../../../helpers/fake_auth_repository.dart';
import '../../../helpers/fake_patients_repository.dart';
import '../../../helpers/fake_token_storage.dart';

final AppLocalizations l10n = AppLocalizationsEs();

class _FakeSharer implements ConsentPdfSharer {
  final List<ConsentPdf> shared = <ConsentPdf>[];

  @override
  Future<String> share(ConsentPdf pdf) async {
    shared.add(pdf);
    return '/tmp/${pdf.fileName}';
  }
}

Future<_FakeSharer> _pump(
  WidgetTester tester, {
  FakePatientsRepository? repository,
}) async {
  final sharer = await _pumpWithoutSettle(tester, repository: repository);
  await tester.pumpAndSettle();
  return sharer;
}

/// Igual que [_pump] pero sin asentar los frames, para mirar el estado de
/// carga mientras el consentimiento todavia no resolvio.
Future<_FakeSharer> _pumpWithoutSettle(
  WidgetTester tester, {
  FakePatientsRepository? repository,
}) async {
  final sharer = _FakeSharer();
  await tester.pumpWidget(
    ProviderScope(
      overrides: <Override>[
        patientsRepositoryProvider
            .overrideWithValue(repository ?? FakePatientsRepository()),
        consentPdfSharerProvider.overrideWithValue(sharer),
        authRepositoryProvider.overrideWithValue(FakeAuthRepository()),
        tokenStorageProvider.overrideWithValue(FakeTokenStorage()),
      ],
      // Con router minimo: la pantalla lleva boton de retroceso, y ese boton
      // consulta `GoRouter.canPop()`. Montarla suelta la dejaria sin el
      // contexto que legitimamente necesita.
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
              builder: (_, __) => const PrivacyScreen(),
            ),
          ],
        ),
      ),
    ),
  );
  await tester.pump();
  return sharer;
}

void main() {
  group('PrivacyScreen · CP004 paso 2', () {
    testWidgets('muestra la seccion con el consentimiento aceptado',
        (tester) async {
      await _pump(tester);

      expect(find.text(l10n.privacyTitle), findsOneWidget);
      expect(find.byKey(const Key('privacy_consent_card')), findsOneWidget);
      expect(find.text(l10n.privacyConsentTitle), findsOneWidget);
      expect(find.text(l10n.privacyConsentBody), findsOneWidget);
    });

    testWidgets('el texto afirma que el registro es inmutable', (tester) async {
      // Es la contraparte visible de los triggers que bloquean UPDATE y
      // DELETE, verificados en los pasos 4 y 5 del caso de prueba.
      await _pump(tester);

      expect(
        l10n.privacyConsentBody.toLowerCase(),
        contains('no puede modificarse ni eliminarse'),
      );
    });

    testWidgets('ofrece la descarga y explica que pasara', (tester) async {
      await _pump(tester);

      expect(find.byKey(const Key('privacy_consent_download')), findsOneWidget);
      expect(find.text(l10n.privacyConsentDownloadHint), findsOneWidget);
    });
  });

  group('PrivacyScreen · CP004 pasos 6 y 7', () {
    testWidgets('pulsar el boton descarga el comprobante', (tester) async {
      final sharer = await _pump(tester);

      await tester.tap(find.byKey(const Key('privacy_consent_download')));
      await tester.pumpAndSettle();

      expect(sharer.shared, hasLength(1));
      expect(sharer.shared.single.fileName, 'consentimiento-1.0.pdf');
    });

    testWidgets('tras descargar confirma que corresponde a lo aceptado',
        (tester) async {
      await _pump(tester);

      await tester.tap(find.byKey(const Key('privacy_consent_download')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('privacy_consent_done')), findsOneWidget);
      expect(find.text(l10n.privacyConsentDownloaded), findsOneWidget);
    });
  });

  group('PrivacyScreen · fallos', () {
    testWidgets('un 404 muestra el mensaje especifico, no uno generico',
        (tester) async {
      // Depende de que ErrorMapper decodifique el problem+json que llega como
      // bytes en los endpoints de descarga. Sin eso, el paciente veria
      // "ocurrio un error inesperado".
      final repository = FakePatientsRepository()
        ..consentPdfError = const CauceApiError.consentRecordNotFound();
      await _pump(tester, repository: repository);

      await tester.tap(find.byKey(const Key('privacy_consent_download')));
      await tester.pumpAndSettle();

      expect(find.text(l10n.errorConsentRecordNotFound), findsOneWidget);
      expect(find.text(l10n.errorUnknown), findsNothing);
      expect(find.byKey(const Key('privacy_consent_done')), findsNothing);
    });

    testWidgets('un fallo de red invita a reintentar', (tester) async {
      final repository = FakePatientsRepository()
        ..consentPdfError = const CauceApiError.network();
      await _pump(tester, repository: repository);

      await tester.tap(find.byKey(const Key('privacy_consent_download')));
      await tester.pumpAndSettle();

      expect(find.text(l10n.errorNetwork), findsOneWidget);
      // El boton sigue disponible: el reintento es la accion util.
      expect(find.byKey(const Key('privacy_consent_download')), findsOneWidget);
    });
  });

  group('PrivacyScreen · version y fecha de la aceptacion', () {
    testWidgets('muestra la version que el paciente acepto', (tester) async {
      // No la vigente hoy: el backend las distingue desde que existe
      // consent_documents, y la pantalla tiene que mostrar la aceptada.
      final repository = FakePatientsRepository()
        ..acceptedConsentValue = AcceptedConsent(
          documentVersion: '1.0',
          acceptedAt: DateTime.utc(2026, 9, 12, 14, 5),
          textHash: 'a' * 64,
          textAvailable: true,
        );
      await _pump(tester, repository: repository);

      expect(find.byKey(const Key('privacy_consent_version')), findsOneWidget);
      expect(find.text(l10n.privacyConsentVersion('1.0')), findsOneWidget);
    });

    testWidgets('muestra la fecha de aceptacion en hora local', (tester) async {
      final acceptedAt = DateTime.utc(2026, 9, 12, 14, 5);
      final repository = FakePatientsRepository()
        ..acceptedConsentValue = AcceptedConsent(
          documentVersion: '1.0',
          acceptedAt: acceptedAt,
          textHash: 'a' * 64,
          textAvailable: true,
        );
      await _pump(tester, repository: repository);

      // La conversion a local se hace aqui tambien porque la fecha del dia
      // depende del huso del equipo que corre la prueba, y fijarla literal
      // dejaria el test rojo fuera de Lima.
      expect(
        find.text(
          l10n.privacyConsentAcceptedOn(
            OnboardingLabels.date(acceptedAt.toLocal()),
          ),
        ),
        findsOneWidget,
      );
    });

    testWidgets('mientras resuelve avisa que esta cargando', (tester) async {
      final repository = FakePatientsRepository()
        ..delay = const Duration(milliseconds: 50);
      await _pumpWithoutSettle(tester, repository: repository);

      expect(find.text(l10n.privacyConsentLoading), findsOneWidget);
      expect(find.byKey(const Key('privacy_consent_card')), findsNothing);

      await tester.pumpAndSettle();
      expect(find.byKey(const Key('privacy_consent_card')), findsOneWidget);
    });

    testWidgets('si no puede resolverlo ofrece reintentar', (tester) async {
      final repository = FakePatientsRepository()
        ..acceptedConsentError = const CauceApiError.network();
      await _pump(tester, repository: repository);

      expect(find.text(l10n.errorNetwork), findsOneWidget);
      expect(find.byKey(const Key('privacy_consent_retry')), findsOneWidget);
      // Sin el dato de la aceptacion no se ofrece la descarga: el boton
      // colgaria de una version que no se conoce.
      expect(find.byKey(const Key('privacy_consent_download')), findsNothing);
    });
  });

  group('PrivacyScreen · aceptacion sin texto guardado', () {
    FakePatientsRepository buildRepository() => FakePatientsRepository()
      ..acceptedConsentValue = AcceptedConsent(
        documentVersion: '0.9',
        acceptedAt: DateTime.utc(2026, 1, 20, 10, 30),
        textHash: 'b' * 64,
        textAvailable: false,
      );

    testWidgets('explica por que no hay PDF y que la aceptacion sigue valida',
        (tester) async {
      await _pump(tester, repository: buildRepository());

      expect(
        find.byKey(const Key('privacy_consent_unavailable')),
        findsOneWidget,
      );
      expect(find.text(l10n.privacyConsentTextUnavailable), findsOneWidget);
      // La version y la fecha se siguen mostrando: es lo que prueba que la
      // aceptacion quedo registrada.
      expect(find.text(l10n.privacyConsentVersion('0.9')), findsOneWidget);
    });

    testWidgets('deshabilita la descarga en vez de dejarla fallar con 404',
        (tester) async {
      final sharer = await _pump(tester, repository: buildRepository());

      final button = tester.widget<CauceButton>(
        find.byKey(const Key('privacy_consent_download')),
      );
      expect(button.onPressed, isNull);
      // La pista de "se abrira el menu para compartir" sobra si no va a abrirse.
      expect(find.text(l10n.privacyConsentDownloadHint), findsNothing);

      await tester.tap(
        find.byKey(const Key('privacy_consent_download')),
        warnIfMissed: false,
      );
      await tester.pumpAndSettle();

      expect(sharer.shared, isEmpty);
      expect(find.byKey(const Key('privacy_consent_done')), findsNothing);
    });
  });
}
