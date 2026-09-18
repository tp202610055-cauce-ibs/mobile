import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../foods/application/food_search_notifier.dart';
import '../../../foods/domain/food_item.dart';

/// Buscador de alimentos del catalogo (HU0009 CA03).
///
/// Dos momentos, como describe el CA: antes de escribir muestra las tres
/// secciones de sugerencias que arma el servidor; al escribir, el autocompletado
/// sobre el catalogo completo, que corre **local** contra la caja de drift para
/// que funcione en modo avion (CP023).
///
/// Devuelve el [FoodItem] elegido, ya con su composicion nutricional resuelta
/// cuando se pudo, o `null` si el paciente cerro la hoja.
Future<FoodItem?> showFoodPickerSheet(BuildContext context) {
  return showModalBottomSheet<FoodItem>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _FoodPickerSheet(),
  );
}

class _FoodPickerSheet extends ConsumerStatefulWidget {
  const _FoodPickerSheet();

  @override
  ConsumerState<_FoodPickerSheet> createState() => _FoodPickerSheetState();
}

class _FoodPickerSheetState extends ConsumerState<_FoodPickerSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _resolving = false;

  @override
  void initState() {
    super.initState();
    // Las sugerencias son del servidor. Sin conexion la seccion no aparece y la
    // busqueda por texto sigue disponible igual.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(foodSearchNotifierProvider.notifier).loadSuggestions();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _choose(FoodItem item) async {
    setState(() => _resolving = true);
    final resolved =
        await ref.read(foodSearchNotifierProvider.notifier).resolveDetail(item);

    if (!mounted) {
      return;
    }
    Navigator.of(context).pop(resolved);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(foodSearchNotifierProvider);
    final notifier = ref.read(foodSearchNotifierProvider.notifier);
    final suggestions = state.suggestions;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(CauceSpacing.space4),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                l10n.mealsSearchTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: CauceSpacing.space3),
              CauceTextField(
                key: const Key('food_picker_query'),
                controller: _controller,
                label: l10n.mealsSearchTitle,
                hint: l10n.mealsSearchHint,
                enabled: !_resolving,
                onChanged: notifier.search,
              ),
              const SizedBox(height: CauceSpacing.space3),
              Flexible(
                child: _resolving
                    ? const CauceLoadingIndicator.fullscreen()
                    : ListView(
                        shrinkWrap: true,
                        children: <Widget>[
                          if (state.isBrowsing &&
                              suggestions != null) ...<Widget>[
                            _Section(
                              title: l10n.mealsSuggestionsRecent,
                              items: suggestions.recentLast24Hours,
                              onTap: _choose,
                            ),
                            _Section(
                              title: l10n.mealsSuggestionsFrequent,
                              items: suggestions.frequentLast30Days,
                              onTap: _choose,
                            ),
                            _Section(
                              title: l10n.mealsSuggestionsCatalog,
                              items: suggestions.catalogSuggestions,
                              onTap: _choose,
                            ),
                          ],
                          if (state.hasNoResults)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: CauceSpacing.space4,
                              ),
                              child: Text(
                                l10n.mealsSearchNoResults,
                                key: const Key('food_picker_no_results'),
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          for (final item in state.results)
                            _FoodTile(item: item, onTap: _choose),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Una seccion de sugerencias. Se omite entera si viene vacia.
class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.items,
    required this.onTap,
  });

  final String title;
  final List<FoodItem> items;
  final ValueChanged<FoodItem> onTap;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: CauceSpacing.space3),
          child: Text(
            title,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: CauceColors.textSecondary,
                ),
          ),
        ),
        for (final item in items) _FoodTile(item: item, onTap: onTap),
      ],
    );
  }
}

class _FoodTile extends StatelessWidget {
  const _FoodTile({required this.item, required this.onTap});

  final FoodItem item;
  final ValueChanged<FoodItem> onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: Key('food_option_${item.foodId}'),
      contentPadding: EdgeInsets.zero,
      title: Text(item.name),
      subtitle: item.category.isEmpty ? null : Text(item.category),
      onTap: () => onTap(item),
    );
  }
}
