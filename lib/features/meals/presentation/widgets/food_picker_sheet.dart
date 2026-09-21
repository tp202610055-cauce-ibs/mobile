import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../custom_foods/application/custom_foods_cache.dart';
import '../../../custom_foods/domain/custom_food.dart';
import '../../../foods/application/food_search_notifier.dart';
import '../../../foods/domain/food_item.dart';

/// Lo que el paciente eligio en la hoja de busqueda.
///
/// Es una suma de dos y no un `FoodItem` porque el backend distingue las dos
/// referencias: `MealItemRequest` acepta `foodId` **o** `customFoodId`, nunca
/// los dos, y `MealItemDraft` replica esa invariante.
sealed class FoodPickerSelection {
  const FoodPickerSelection();

  /// Nombre a mostrar, sea cual sea la fuente.
  String get displayName;
}

/// Un alimento del catalogo TPCA-CENAN.
final class CatalogSelection extends FoodPickerSelection {
  const CatalogSelection(this.item);

  final FoodItem item;

  @override
  String get displayName => item.name;
}

/// Un plato personalizado del propio paciente (HU0010).
final class CustomDishSelection extends FoodPickerSelection {
  const CustomDishSelection(this.record);

  final CustomFoodRecord record;

  @override
  String get displayName => record.name;
}

/// Buscador de alimentos del catalogo y de los platos propios (HU0009 CA03,
/// HU0010, CP025).
///
/// Dos momentos, como describe el CA: antes de escribir muestra las tres
/// secciones de sugerencias que arma el servidor; al escribir, el
/// autocompletado sobre el catalogo completo, que corre **local** contra la
/// caja de drift para que funcione en modo avion (CP023).
///
/// **Desde Mobile-3.1 tambien encuentra los platos del paciente.** Hasta
/// entonces un plato personalizado se podia crear y no se podia usar: no
/// aparecia en la busqueda y no habia ninguna otra via para agregarlo a una
/// comida, de modo que HU0010 terminaba en un callejon sin salida.
///
/// [allowCustomDishes] en `false` deja solo el catalogo. Lo usa el constructor
/// de platos personalizados: un ingrediente viaja como `foodId` y el contrato
/// no admite anidar un plato dentro de otro, asi que ofrecerlos ahi seria
/// ofrecer algo que el servidor rechaza.
Future<FoodPickerSelection?> showFoodPickerSheet(
  BuildContext context, {
  bool allowCustomDishes = true,
}) {
  return showModalBottomSheet<FoodPickerSelection>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => _FoodPickerSheet(allowCustomDishes: allowCustomDishes),
  );
}

class _FoodPickerSheet extends ConsumerStatefulWidget {
  const _FoodPickerSheet({required this.allowCustomDishes});

  final bool allowCustomDishes;

  @override
  ConsumerState<_FoodPickerSheet> createState() => _FoodPickerSheetState();
}

class _FoodPickerSheetState extends ConsumerState<_FoodPickerSheet> {
  final TextEditingController _controller = TextEditingController();
  bool _resolving = false;

  @override
  void initState() {
    super.initState();
    // Las sugerencias y los platos propios son del servidor. Sin conexion las
    // sugerencias no aparecen y los platos avisan; la busqueda por texto sobre
    // el catalogo sigue disponible igual.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(foodSearchNotifierProvider.notifier).loadSuggestions();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _chooseCatalog(FoodItem item) async {
    setState(() => _resolving = true);
    final resolved =
        await ref.read(foodSearchNotifierProvider.notifier).resolveDetail(item);

    if (!mounted) {
      return;
    }
    Navigator.of(context).pop(CatalogSelection(resolved));
  }

  void _chooseCustom(CustomFoodRecord record) {
    Navigator.of(context).pop(CustomDishSelection(record));
  }

  /// Abre el constructor de platos y vuelve con el recien creado ya elegido.
  ///
  /// CP025 paso 3 lleva al paciente aca desde una busqueda sin resultados, y
  /// el paso 10 espera encontrarlo despues. Devolverlo seleccionado ahorra la
  /// segunda busqueda y evita el unico momento en que el plato existe y el
  /// paciente todavia no lo tiene a mano.
  Future<void> _createCustomFood() async {
    final created =
        await context.push<CustomFoodRecord>(AppRoutes.customFoodNew);

    if (created == null || !mounted) {
      return;
    }
    ref.read(customFoodsCacheProvider.notifier).remember(created);
    if (mounted) {
      Navigator.of(context).pop(CustomDishSelection(created));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(foodSearchNotifierProvider);
    final cache = ref.watch(customFoodsCacheProvider);
    final suggestions = state.suggestions;

    // Sin texto se listan todos los platos propios; con texto, los que
    // coinciden. En los dos casos es la misma seccion.
    final ownDishes = !widget.allowCustomDishes
        ? const <CustomFoodRecord>[]
        : state.isBrowsing
            ? cache.items
            : state.customResults;
    final showDishesNotice = widget.allowCustomDishes && cache.unavailable;

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
                onChanged: ref.read(foodSearchNotifierProvider.notifier).search,
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
                              onTap: _chooseCatalog,
                            ),
                            _Section(
                              title: l10n.mealsSuggestionsFrequent,
                              items: suggestions.frequentLast30Days,
                              onTap: _chooseCatalog,
                            ),
                            _Section(
                              title: l10n.mealsSuggestionsCatalog,
                              items: suggestions.catalogSuggestions,
                              onTap: _chooseCatalog,
                            ),
                          ],

                          // Los platos propios van antes que el catalogo: son
                          // pocos, son del paciente, y si busco algo que el
                          // mismo creo es lo que espera ver primero.
                          if (ownDishes.isNotEmpty) ...<Widget>[
                            _SectionTitle(title: l10n.mealsMyDishes),
                            for (final record in ownDishes)
                              _CustomDishTile(
                                record: record,
                                onTap: _chooseCustom,
                              ),
                          ] else if (showDishesNotice) ...<Widget>[
                            // No desaparece: avisa. Una seccion que se esfuma
                            // sin red se lee como que el plato se perdio.
                            _SectionTitle(title: l10n.mealsMyDishes),
                            Padding(
                              padding: const EdgeInsets.only(
                                bottom: CauceSpacing.space2,
                              ),
                              child: Text(
                                l10n.mealsOwnDishesOffline,
                                key: const Key('food_picker_dishes_offline'),
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],

                          if (state.hasNoResults)
                            CauceEmptyState(
                              key: const Key('food_picker_no_results'),
                              icon: TablerIcons.search_off,
                              title: l10n.mealsSearchNoResultsTitle,
                              message: l10n.mealsSearchNoResultsBody,
                              // Crear un plato desde el buscador de
                              // ingredientes sacaria al paciente del plato que
                              // esta armando, asi que ahi solo se informa.
                              actionLabel: widget.allowCustomDishes
                                  ? l10n.mealsCreateCustomFood
                                  : null,
                              onAction: widget.allowCustomDishes
                                  ? _createCustomFood
                                  : null,
                            ),
                          for (final item in state.results)
                            _FoodTile(item: item, onTap: _chooseCatalog),
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

/// Encabezado de una seccion de la hoja.
class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: CauceSpacing.space3),
      child: Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: CauceColors.textSecondary,
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
        _SectionTitle(title: title),
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

/// Un plato propio, marcado como tal.
///
/// CP025 paso 9 exige que se vea diferenciado del catalogo oficial: el
/// TPCA-CENAN es una fuente validada y la preparacion del paciente no, aunque
/// las dos se elijan igual.
class _CustomDishTile extends StatelessWidget {
  const _CustomDishTile({required this.record, required this.onTap});

  final CustomFoodRecord record;
  final ValueChanged<CustomFoodRecord> onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListTile(
      key: Key('custom_food_option_${record.customFoodId}'),
      contentPadding: EdgeInsets.zero,
      title: Text(record.name),
      subtitle: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(top: CauceSpacing.space1),
          child: CauceBadge(
            label: l10n.mealsOwnDishBadge,
            icon: TablerIcons.chef_hat,
            tone: CauceBadgeTone.brand,
            compact: true,
          ),
        ),
      ),
      onTap: () => onTap(record),
    );
  }
}
