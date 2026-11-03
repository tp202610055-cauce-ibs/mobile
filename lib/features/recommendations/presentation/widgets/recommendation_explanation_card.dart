import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/glossary/glossary_catalog.dart';
import '../../../../core/glossary/glossary_repository.dart';
import '../../../../core/glossary/glossary_term_view.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../l10n/generated/app_localizations.dart';
import 'recommendation_detail_sections.dart';

/// Explicacion del sistema (bloque 1), con los terminos del glosario
/// tocables y la atribucion FODMAP al pie cuando corresponde.
///
/// El texto llega sin marcas: se marca la primera aparicion de cada termino
/// del glosario (CP068 paso 7). Sin glosario cargado, el texto va tal cual.
class RecommendationExplanationCard extends ConsumerWidget {
  const RecommendationExplanationCard({
    required this.explanation,
    required this.showsAttribution,
    super.key,
  });

  final String explanation;
  final bool showsAttribution;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final style = Theme.of(context).textTheme.bodyMedium?.copyWith(
          height: 1.55,
        );
    final catalog = ref.watch(glossaryCatalogProvider).valueOrNull;
    final matches =
        catalog?.termsIn(explanation) ?? const <GlossaryTermMatch>[];

    return RecommendationSectionCard(
      key: const Key('recommendation_explanation'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (matches.isEmpty)
            Text(explanation, style: style)
          else
            Text.rich(_spans(context, matches, style), style: style),
          if (showsAttribution) const _Attribution(),
        ],
      ),
    );
  }

  TextSpan _spans(
    BuildContext context,
    List<GlossaryTermMatch> matches,
    TextStyle? style,
  ) {
    final children = <InlineSpan>[];
    var cursor = 0;
    for (final match in matches) {
      if (match.start > cursor) {
        children.add(
          TextSpan(text: explanation.substring(cursor, match.start)),
        );
      }
      children.add(
        WidgetSpan(
          alignment: PlaceholderAlignment.baseline,
          baseline: TextBaseline.alphabetic,
          child: _GlossaryTermLink(
            text: explanation.substring(match.start, match.end),
            entry: match.entry,
            style: style,
          ),
        ),
      );
      cursor = match.end;
    }
    if (cursor < explanation.length) {
      children.add(TextSpan(text: explanation.substring(cursor)));
    }
    return TextSpan(children: children);
  }
}

/// Un termino tocable: subrayado, en color de marca y anunciado como boton.
class _GlossaryTermLink extends StatelessWidget {
  const _GlossaryTermLink({
    required this.text,
    required this.entry,
    required this.style,
  });

  final String text;
  final GlossaryEntry entry;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Semantics(
      button: true,
      label: l10n.recommendationGlossaryTermSemantics(entry.term),
      excludeSemantics: true,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => showGlossaryTermSheet(context, entry),
        child: Text(
          text,
          key: Key('recommendation_term_${entry.term}'),
          style: style?.copyWith(
            color: CauceColors.brandStrong,
            decoration: TextDecoration.underline,
            decorationColor: CauceColors.brandStrong,
          ),
        ),
      ),
    );
  }
}

/// Atribucion FODMAP fija al pie de la explicacion (decision 6).
///
/// Texto literal del mockup 11, no generado. Se muestra siempre que la
/// explicacion no sea manual.
class _Attribution extends StatelessWidget {
  const _Attribution();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: CauceSpacing.space3),
      padding: const EdgeInsets.only(top: CauceSpacing.space2),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: CauceColors.bgDivider,
            width: CauceBorders.subtle,
          ),
        ),
      ),
      child: Text(
        AppLocalizations.of(context).recommendationAttribution,
        key: const Key('recommendation_attribution'),
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: CauceColors.textTertiary,
            ),
      ),
    );
  }
}
