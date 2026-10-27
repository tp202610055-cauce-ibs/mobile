import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/design_tokens.dart';
import '../widgets/widgets.dart';
import 'glossary_catalog.dart';

/// Etiqueta de categoria de un termino (CP068 pasos 4 a 6).
///
/// Tono neutro para las tres: la categoria clasifica, no juzga. Lo que las
/// distingue es el texto y el icono, nunca el color solo.
class GlossaryCategoryBadge extends StatelessWidget {
  const GlossaryCategoryBadge({required this.category, super.key});

  final GlossaryCategoryOption category;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    final (String label, IconData icon) = switch (category) {
      GlossaryCategoryOption.nutritional => (
          l10n.glossaryCategoryNutritional,
          TablerIcons.salad,
        ),
      GlossaryCategoryOption.clinicalIbs => (
          l10n.glossaryCategoryClinicalIbs,
          TablerIcons.stethoscope,
        ),
      GlossaryCategoryOption.system => (
          l10n.glossaryCategorySystem,
          TablerIcons.device_mobile,
        ),
    };

    return CauceBadge(
      key: const Key('glossary_category'),
      label: label,
      icon: icon,
      tone: CauceBadgeTone.neutral,
    );
  }
}

/// Abre la definicion de [entry] en una hoja, con el mismo contenido que el
/// termino desplegado del glosario: definicion y categoria.
Future<void> showGlossaryTermSheet(BuildContext context, GlossaryEntry entry) {
  return showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    showDragHandle: true,
    builder: (context) => _GlossaryTermSheet(entry: entry),
  );
}

class _GlossaryTermSheet extends StatelessWidget {
  const _GlossaryTermSheet({required this.entry});

  final GlossaryEntry entry;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final category = entry.category;

    return SafeArea(
      child: Padding(
        key: const Key('glossary_term_sheet'),
        padding: const EdgeInsets.fromLTRB(
          CauceSpacing.space4,
          0,
          CauceSpacing.space4,
          CauceSpacing.space6,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(entry.term, style: textTheme.titleLarge),
            const SizedBox(height: CauceSpacing.space3),
            Text(entry.definition, style: textTheme.bodyMedium),
            if (category != null) ...<Widget>[
              const SizedBox(height: CauceSpacing.space3),
              Align(
                alignment: Alignment.centerLeft,
                child: GlossaryCategoryBadge(category: category),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
