import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../meals/presentation/widgets/food_picker_sheet.dart';
import '../application/custom_food_form_notifier.dart';
import '../domain/custom_food.dart';
import 'widgets/custom_food_labels.dart';

/// Constructor de platos personalizados (US10 CA01, CA02 y CA03).
class CustomFoodFormScreen extends ConsumerStatefulWidget {
  const CustomFoodFormScreen({super.key});

  @override
  ConsumerState<CustomFoodFormScreen> createState() =>
      _CustomFoodFormScreenState();
}

class _CustomFoodFormScreenState extends ConsumerState<CustomFoodFormScreen> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _portion = TextEditingController();

  @override
  void initState() {
    super.initState();
    // La lista de platos ya creados alimenta el rechazo instantaneo por nombre
    // duplicado (CA02). El servidor sigue siendo la autoridad final.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(customFoodFormNotifierProvider.notifier).loadExisting();
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _portion.dispose();
    super.dispose();
  }

  Future<void> _addIngredient() async {
    final selection =
        await showFoodPickerSheet(context, allowCustomDishes: false);
    // El modo solo catalogo nunca devuelve un plato propio; el `switch` lo
    // deja escrito para que el dia que cambie no pase en silencio.
    final food = switch (selection) {
      CatalogSelection(:final item) => item,
      CustomDishSelection() || null => null,
    };
    if (food == null || !mounted) {
      return;
    }

    final grams = await showModalBottomSheet<double>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _ProportionSheet(foodName: food.name),
    );

    if (grams != null) {
      ref.read(customFoodFormNotifierProvider.notifier).addIngredient(
            CustomFoodIngredientDraft(food: food, proportionGrams: grams),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(customFoodFormNotifierProvider);
    final notifier = ref.read(customFoodFormNotifierProvider.notifier);

    if (state.awaitingAllergenConfirmation) {
      return _AllergenWarning(
        allergens: state.pendingAllergens,
        busy: state.submitting,
        onConfirm: notifier.confirmAllergensAndSubmit,
        onCancel: notifier.cancelAllergenConfirmation,
      );
    }

    final createdId = state.createdId;
    if (createdId != null) {
      // Vuelve **con el plato**, no con las manos vacias. Quien abrio esta
      // pantalla desde una busqueda sin resultados (CP025 paso 3) lo recibe ya
      // elegido, y el paso 10 se cumple sin una segunda busqueda.
      return _CustomFoodCreated(
        onBack: () => Navigator.of(context).pop(
          CustomFoodRecord(
            customFoodId: createdId,
            name: state.draft.name,
            portionSizeGrams: state.draft.portionSizeGrams,
          ),
        ),
      );
    }

    final estimate = state.estimate;

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.customFoodTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (state.error != null) ...<Widget>[
            CauceErrorBanner(error: state.error!),
            const SizedBox(height: CauceSpacing.space4),
          ],
          CauceTextField(
            key: const Key('custom_food_name'),
            controller: _name,
            label: l10n.customFoodNameLabel,
            hint: l10n.customFoodNameHint,
            enabled: !state.submitting,
            onChanged: notifier.setName,
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceTextField(
            key: const Key('custom_food_portion'),
            controller: _portion,
            label: l10n.customFoodPortionLabel,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            enabled: !state.submitting,
            onChanged: (value) => notifier.setPortion(
              double.tryParse(value.replaceAll(',', '.')) ?? 0,
            ),
          ),
          const SizedBox(height: CauceSpacing.space6),
          Text(
            l10n.customFoodIngredientsLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: CauceSpacing.space2),
          if (state.draft.ingredients.isEmpty)
            Text(
              l10n.customFoodIngredientsEmpty,
              key: const Key('custom_food_ingredients_empty'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CauceColors.textSecondary,
                  ),
            ),
          for (final (index, item) in state.draft.ingredients.indexed)
            ListTile(
              key: Key('custom_food_ingredient_$index'),
              contentPadding: EdgeInsets.zero,
              title: Text(item.food.name),
              subtitle: Text('${item.proportionGrams.toStringAsFixed(0)} g'),
              trailing: TextButton(
                onPressed: state.submitting
                    ? null
                    : () => notifier.removeIngredientAt(index),
                child: Text(l10n.mealsRemoveItem),
              ),
            ),
          const SizedBox(height: CauceSpacing.space3),
          CauceButton.secondary(
            key: const Key('custom_food_add_ingredient'),
            label: l10n.customFoodAddIngredient,
            onPressed: state.submitting ? null : _addIngredient,
          ),
          if (estimate != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space6),
            _EstimateCard(estimate: estimate),
          ],
          const SizedBox(height: CauceSpacing.space6),
          for (final issue in state.issues)
            Padding(
              padding: const EdgeInsets.only(bottom: CauceSpacing.space1),
              child: Text(
                CustomFoodLabels.issue(l10n, issue),
                key: Key('custom_food_issue_${issue.name}'),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: CauceColors.textSecondary,
                    ),
              ),
            ),
          const SizedBox(height: CauceSpacing.space3),
          CauceButton(
            key: const Key('custom_food_submit'),
            label: l10n.customFoodSubmit,
            loading: state.submitting,
            onPressed: state.canSubmit ? notifier.submit : null,
          ),
        ],
      ),
    );
  }
}

/// Cantidad en gramos que aporta el ingrediente recien elegido.
class _ProportionSheet extends StatefulWidget {
  const _ProportionSheet({required this.foodName});

  final String foodName;

  @override
  State<_ProportionSheet> createState() => _ProportionSheetState();
}

class _ProportionSheetState extends State<_ProportionSheet> {
  final TextEditingController _grams = TextEditingController(text: '100');

  @override
  void dispose() {
    _grams.dispose();
    super.dispose();
  }

  double? get _parsed {
    final value = double.tryParse(_grams.text.replaceAll(',', '.'));
    return (value == null || value <= 0) ? null : value;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

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
                widget.foodName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: CauceSpacing.space4),
              CauceTextField(
                key: const Key('custom_food_proportion_field'),
                controller: _grams,
                label: l10n.customFoodProportionLabel,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                errorText: _parsed == null
                    ? l10n.customFoodIssueInvalidProportion
                    : null,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: CauceSpacing.space6),
              CauceButton(
                key: const Key('custom_food_proportion_confirm'),
                label: l10n.commonAccept,
                onPressed: _parsed == null
                    ? null
                    : () => Navigator.of(context).pop(_parsed),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Vista previa del perfil nutricional (CA01, CP025).
class _EstimateCard extends StatelessWidget {
  const _EstimateCard({required this.estimate});

  final NutritionEstimate estimate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    String one(double value) => value.toStringAsFixed(1);

    return Container(
      key: const Key('custom_food_estimate'),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderLg,
        border: Border.all(color: CauceColors.bgDivider),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.customFoodEstimateTitle, style: textTheme.titleMedium),
          const SizedBox(height: CauceSpacing.space2),
          Text(
            l10n.customFoodEstimateCalories(
              estimate.caloriesPer100g.toStringAsFixed(0),
            ),
            key: const Key('custom_food_estimate_calories'),
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: CauceSpacing.space1),
          Text(l10n.customFoodEstimateProtein(one(estimate.proteinGPer100g))),
          Text(l10n.customFoodEstimateCarbs(one(estimate.carbsGPer100g))),
          Text(l10n.customFoodEstimateFat(one(estimate.fatGPer100g))),
          Text(l10n.customFoodEstimateFiber(one(estimate.fiberGPer100g))),
          const SizedBox(height: CauceSpacing.space3),
          // Decir que es una estimacion del dispositivo y que no se guarda
          // evita que el paciente la lea como un dato clinico del estudio.
          Text(
            l10n.customFoodEstimateNote,
            style: textTheme.bodySmall?.copyWith(
              color: CauceColors.textSecondary,
            ),
          ),
          if (estimate.isPartial) ...<Widget>[
            const SizedBox(height: CauceSpacing.space1),
            Text(
              l10n.customFoodEstimatePartial,
              key: const Key('custom_food_estimate_partial'),
              style: textTheme.bodySmall?.copyWith(
                color: CauceColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Advertencia de alergenos detectados (CA03, CP027).
///
/// El cruce lo hizo el servidor contra las alergias del perfil. Esta pantalla
/// lo muestra y pide la confirmacion explicita que habilita el reenvio con
/// `confirmedAllergens: true`.
class _AllergenWarning extends StatelessWidget {
  const _AllergenWarning({
    required this.allergens,
    required this.busy,
    required this.onConfirm,
    required this.onCancel,
  });

  final List<DetectedAllergen> allergens;
  final bool busy;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.customFoodTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            l10n.customFoodAllergenTitle,
            key: const Key('custom_food_allergen_title'),
            style: textTheme.headlineSmall,
          ),
          const SizedBox(height: CauceSpacing.space2),
          Text(l10n.customFoodAllergenBody, style: textTheme.bodyMedium),
          const SizedBox(height: CauceSpacing.space4),
          for (final (index, allergen) in allergens.indexed)
            Container(
              key: Key('custom_food_allergen_$index'),
              margin: const EdgeInsets.only(bottom: CauceSpacing.space2),
              padding: const EdgeInsets.all(CauceSpacing.space3),
              decoration: BoxDecoration(
                color: CauceColors.bgCard,
                borderRadius: CauceRadii.borderMd,
                border: Border.all(color: CauceColors.bgDivider),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    l10n.customFoodAllergenEntry(
                      allergen.ingredientName,
                      allergen.allergenName,
                    ),
                    style: textTheme.bodyLarge,
                  ),
                  const SizedBox(height: CauceSpacing.space1),
                  Text(
                    CustomFoodLabels.allergenSeverity(l10n, allergen.severity),
                    style: textTheme.bodySmall?.copyWith(
                      color: CauceColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: CauceSpacing.space4),
          CauceButton(
            key: const Key('custom_food_allergen_confirm'),
            label: l10n.customFoodAllergenConfirm,
            loading: busy,
            onPressed: busy ? null : onConfirm,
          ),
          const SizedBox(height: CauceSpacing.space2),
          // Volver y editar va primero en importancia aunque vaya segundo en
          // la pantalla: sacar el ingrediente es la salida sin riesgo.
          CauceButton.tertiary(
            key: const Key('custom_food_allergen_cancel'),
            label: l10n.customFoodAllergenCancel,
            onPressed: busy ? null : onCancel,
          ),
        ],
      ),
    );
  }
}

class _CustomFoodCreated extends StatelessWidget {
  const _CustomFoodCreated({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.customFoodTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            l10n.customFoodCreated,
            key: const Key('custom_food_created'),
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: CauceSpacing.space6),
          CauceButton(
            key: const Key('custom_food_back'),
            label: l10n.commonBack,
            onPressed: onBack,
          ),
        ],
      ),
    );
  }
}
