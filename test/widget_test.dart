import 'package:cauce_mobile/app.dart';
import 'package:cauce_mobile/core/theme/design_tokens.dart';
import 'package:cauce_mobile/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CauceApp', () {
    testWidgets('resuelve la localizacion en espanol', (tester) async {
      await tester.pumpWidget(const CauceApp());
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(Scaffold));

      // La app pide es_PE, pero las traducciones viven en app_es.arb, asi que
      // Flutter resuelve a `es`. Es el comportamiento que describe el acta M8:
      // default es_PE con fallback a es. Lo que importa verificar es que el
      // bundle resuelto sea el espanol, no que el tag conserve la region.
      expect(Localizations.localeOf(context).languageCode, 'es');
      expect(AppLocalizations.of(context).appTitle, 'Cauce');
      expect(AppLocalizations.of(context).loginSubmit, 'Iniciar sesion');
    });

    testWidgets('aplica el theme del design system', (tester) async {
      await tester.pumpWidget(const CauceApp());
      await tester.pumpAndSettle();

      final theme = Theme.of(tester.element(find.byType(Scaffold)));
      expect(theme.scaffoldBackgroundColor, CauceColors.bgPage);
      expect(theme.colorScheme.primary, CauceColors.brandBase);
      expect(theme.textTheme.bodyLarge?.fontFamily, 'Inter');
    });
  });
}
