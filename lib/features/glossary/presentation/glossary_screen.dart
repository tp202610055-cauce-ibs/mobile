import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../data/glossary_repository.dart';
import '../domain/glossary_catalog.dart';

/// Glosario clinico-nutricional (HU0027, CP068 y CP069).
///
/// **Sin mockup.** Es la tercera pantalla del proyecto construida sin uno,
/// despues de Evolucion y del Reporte. La estructura sale de CP068: buscador,
/// lista, y al elegir un termino su definicion con la categoria.
///
/// **Todo el texto de los terminos viene del servidor, tal cual**, en español
/// y redactado para el paciente. Aca solo se traduce el cromo y las tres
/// etiquetas de categoria, que llegan como codigo.
///
/// **Fuera de esta pantalla, a proposito:** la opcion de solicitar que se
/// agregue un termino, que CP069 paso 6 exige que el paciente ni vea, y el
/// acceso desde un termino marcado dentro de una recomendacion, que depende de
/// la pestaña de Consejos de Mobile-5.
class GlossaryScreen extends ConsumerStatefulWidget {
  const GlossaryScreen({super.key});

  @override
  ConsumerState<GlossaryScreen> createState() => _GlossaryScreenState();
}

class _GlossaryScreenState extends ConsumerState<GlossaryScreen> {
  final TextEditingController _search = TextEditingController();
  String _query = '';

  /// Terminos abiertos, por nombre. El backend garantiza que es unico.
  final Set<String> _expanded = <String>{};

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _toggle(String term) {
    setState(() {
      if (!_expanded.remove(term)) {
        _expanded.add(term);
      }
    });
  }

  /// Abre una sugerencia: la busca y la deja desplegada (CP069 paso 4).
  void _openSuggestion(GlossaryEntry entry) {
    FocusScope.of(context).unfocus();
    _search.value = TextEditingValue(
      text: entry.term,
      selection: TextSelection.collapsed(offset: entry.term.length),
    );
    setState(() {
      _query = entry.term;
      _expanded.add(entry.term);
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final catalog = ref.watch(glossaryCatalogProvider);

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.glossaryTitle, showBackButton: true),
      scrollable: true,
      body: catalog.when(
        loading: () => CauceLoadingIndicator.fullscreen(
          message: l10n.commonLoading,
        ),
        error: (error, _) => _LoadFailure(error: error),
        data: (value) => _buildCatalog(context, value),
      ),
    );
  }

  Widget _buildCatalog(BuildContext context, GlossaryCatalog catalog) {
    final l10n = AppLocalizations.of(context);

    if (catalog.terms.isEmpty) {
      return CauceEmptyState(
        key: const Key('glossary_empty'),
        icon: TablerIcons.book_2,
        title: l10n.glossaryTitle,
        message: l10n.glossaryEmpty,
      );
    }

    final results = catalog.search(_query);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Atada al dato y no fija: se retira sola el dia que el backend
        // declare el contenido validado.
        if (catalog.isDraft) ...<Widget>[
          const _DraftNote(),
          const SizedBox(height: CauceSpacing.space4),
        ],
        CauceTextField(
          key: const Key('glossary_search'),
          label: l10n.glossarySearchLabel,
          hint: l10n.glossarySearchHint,
          controller: _search,
          textInputAction: TextInputAction.search,
          // Filtra en vivo, sin boton: la lista esta en memoria y no hay
          // peticion que ahorrar esperando a que el paciente termine.
          onChanged: (value) => setState(() => _query = value),
        ),
        const SizedBox(height: CauceSpacing.space4),
        if (results.isEmpty)
          _NotFound(
            suggestions: catalog.suggestionsFor(_query),
            onPick: _openSuggestion,
          )
        else
          for (final entry in results)
            _TermTile(
              entry: entry,
              expanded: _expanded.contains(entry.term),
              onTap: () => _toggle(entry.term),
            ),
      ],
    );
  }
}

/// Nota de contenido en borrador.
///
/// Mismo estilo informativo que el aviso de la contraseña del Reporte: no es
/// un error ni una advertencia, es contexto sobre lo que el paciente lee.
class _DraftNote extends StatelessWidget {
  const _DraftNote();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: const Key('glossary_draft_note'),
      padding: const EdgeInsets.all(CauceSpacing.space3),
      decoration: const BoxDecoration(
        color: CauceColors.infoBg,
        borderRadius: CauceRadii.borderMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            TablerIcons.info_circle,
            size: 18,
            color: CauceColors.infoText,
          ),
          const SizedBox(width: CauceSpacing.space2),
          Expanded(
            child: Text(
              l10n.glossaryDraftNote,
              style: textTheme.bodyMedium?.copyWith(
                color: CauceColors.infoText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Un termino, que se despliega en el lugar al tocarlo.
class _TermTile extends StatelessWidget {
  const _TermTile({
    required this.entry,
    required this.expanded,
    required this.onTap,
  });

  final GlossaryEntry entry;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final category = entry.category;

    return Padding(
      padding: const EdgeInsets.only(bottom: CauceSpacing.space2),
      child: Material(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderMd,
        child: InkWell(
          key: Key('glossary_term_${entry.term}'),
          borderRadius: CauceRadii.borderMd,
          onTap: onTap,
          child: Container(
            constraints: const BoxConstraints(
              minHeight: CauceSizes.touchTargetMin,
            ),
            padding: const EdgeInsets.all(CauceSpacing.space4),
            decoration: BoxDecoration(
              borderRadius: CauceRadii.borderMd,
              border: Border.all(
                color: CauceColors.bgDivider,
                width: CauceBorders.subtle,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(entry.term, style: textTheme.bodyLarge),
                    ),
                    Icon(
                      expanded
                          ? TablerIcons.chevron_up
                          : TablerIcons.chevron_down,
                      size: 20,
                    ),
                  ],
                ),
                if (expanded) ...<Widget>[
                  const SizedBox(height: CauceSpacing.space3),
                  Text(
                    entry.definition,
                    key: Key('glossary_definition_${entry.term}'),
                    style: textTheme.bodyMedium,
                  ),
                  if (category != null) ...<Widget>[
                    const SizedBox(height: CauceSpacing.space3),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: _CategoryBadge(category: category),
                    ),
                  ],
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Etiqueta de categoria (CP068 paso 6).
///
/// Tono neutro para las tres: la categoria clasifica, no juzga, y un ambar o
/// un rojo sugeririan una gravedad que el termino no tiene. Lo que las
/// distingue es el texto y el icono, nunca el color solo.
class _CategoryBadge extends StatelessWidget {
  const _CategoryBadge({required this.category});

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

/// Estado "no encontrado", con sus sugerencias (HU0027 CA2, CP069).
///
/// Sin opcion de solicitar que se agregue el termino: CP069 paso 6 exige que
/// el paciente no la vea.
class _NotFound extends StatelessWidget {
  const _NotFound({required this.suggestions, required this.onPick});

  final List<GlossaryEntry> suggestions;
  final ValueChanged<GlossaryEntry> onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        CauceEmptyState(
          key: const Key('glossary_not_found'),
          icon: TablerIcons.search,
          title: l10n.glossaryNotFoundTitle,
          message: l10n.glossaryNotFoundBody,
        ),
        if (suggestions.isNotEmpty) ...<Widget>[
          const SizedBox(height: CauceSpacing.space4),
          Text(
            l10n.glossarySuggestionsLabel,
            key: const Key('glossary_suggestions'),
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: CauceSpacing.space2),
          for (final entry in suggestions)
            Padding(
              padding: const EdgeInsets.only(bottom: CauceSpacing.space2),
              child: Material(
                color: CauceColors.bgCard,
                borderRadius: CauceRadii.borderMd,
                child: InkWell(
                  key: Key('glossary_suggestion_${entry.term}'),
                  borderRadius: CauceRadii.borderMd,
                  onTap: () => onPick(entry),
                  child: Container(
                    constraints: const BoxConstraints(
                      minHeight: CauceSizes.touchTargetMin,
                    ),
                    padding: const EdgeInsets.all(CauceSpacing.space4),
                    decoration: BoxDecoration(
                      borderRadius: CauceRadii.borderMd,
                      border: Border.all(
                        color: CauceColors.bgDivider,
                        width: CauceBorders.subtle,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(entry.term, style: textTheme.bodyLarge),
                        ),
                        const Icon(TablerIcons.chevron_right, size: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ],
    );
  }
}

/// Fallo de carga, con su reintento.
class _LoadFailure extends ConsumerWidget {
  const _LoadFailure({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final failure = error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (failure is CauceApiError)
          CauceErrorBanner(key: const Key('glossary_error'), error: failure)
        else
          Text(
            l10n.glossaryLoadError,
            key: const Key('glossary_error'),
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: CauceSpacing.space4),
        CauceButton.secondary(
          key: const Key('glossary_retry'),
          label: l10n.commonRetry,
          onPressed: () => ref.invalidate(glossaryCatalogProvider),
        ),
      ],
    );
  }
}
