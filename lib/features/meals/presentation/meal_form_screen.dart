import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/meal_form_notifier.dart';
import '../domain/meal_draft.dart';
import 'widgets/food_picker_sheet.dart';
import 'widgets/meal_labels.dart';

/// Registro de una comida (US09 CA01, CA02 y CA04).
class MealFormScreen extends ConsumerWidget {
  const MealFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(mealFormNotifierProvider);
    final notifier = ref.read(mealFormNotifierProvider.notifier);

    if (state.outcome == MealSubmitOutcome.registered ||
        state.outcome == MealSubmitOutcome.queuedOffline) {
      return _MealConfirmation(state: state, onAgain: notifier.reset);
    }

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.mealsTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (state.error != null) ...<Widget>[
            CauceErrorBanner(error: state.error!),
            const SizedBox(height: CauceSpacing.space4),
          ],
          CauceChoiceField<MealTimeOption>(
            key: const Key('meal_time_field'),
            label: l10n.mealsTimeLabel,
            value: state.draft.mealTime,
            enabled: !state.submitting,
            onChanged: notifier.selectMealTime,
            choices: <CauceChoice<MealTimeOption>>[
              for (final option in MealTimeOption.values)
                CauceChoice<MealTimeOption>(
                  value: option,
                  label: MealLabels.mealTime(l10n, option),
                ),
            ],
          ),
          const SizedBox(height: CauceSpacing.space6),
          Text(
            l10n.mealsItemsLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: CauceSpacing.space2),
          if (state.draft.items.isEmpty)
            Text(
              l10n.mealsItemsEmpty,
              key: const Key('meal_items_empty'),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CauceColors.textSecondary,
                  ),
            ),
          for (final (index, item) in state.draft.items.indexed)
            _ItemRow(
              key: Key('meal_item_$index'),
              item: item,
              enabled: !state.submitting,
              onRemove: () => notifier.removeItemAt(index),
              unitLabel: MealLabels.unit(l10n, item.unit),
              removeLabel: l10n.mealsRemoveItem,
            ),
          const SizedBox(height: CauceSpacing.space3),
          CauceButton.secondary(
            key: const Key('meal_add_food'),
            label: l10n.mealsAddFood,
            onPressed:
                state.submitting ? null : () => _addFood(context, ref, l10n),
          ),
          const SizedBox(height: CauceSpacing.space6),
          // CA04: mientras algo bloquee el envio se dice **que** lo bloquea, en
          // vez de dejar un boton apagado sin explicacion.
          if (state.issues.isNotEmpty) ...<Widget>[
            for (final issue in state.issues)
              Padding(
                padding: const EdgeInsets.only(bottom: CauceSpacing.space1),
                child: Text(
                  MealLabels.issue(l10n, issue),
                  key: Key('meal_issue_${issue.name}'),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: CauceColors.textSecondary,
                      ),
                ),
              ),
            const SizedBox(height: CauceSpacing.space3),
          ],
          CauceButton(
            key: const Key('meal_submit'),
            label: l10n.mealsSubmit,
            loading: state.submitting,
            onPressed: state.canSubmit ? notifier.submit : null,
          ),
        ],
      ),
    );
  }

  /// Abre el buscador y agrega lo elegido con su cantidad.
  Future<void> _addFood(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) async {
    final selection = await showFoodPickerSheet(context);
    if (selection == null || !context.mounted) {
      return;
    }

    final item = await showModalBottomSheet<MealItemDraft>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => _QuantitySheet(selection: selection),
    );

    if (item != null) {
      ref.read(mealFormNotifierProvider.notifier).addItem(item);
    }
  }
}

/// Cantidad y unidad del alimento recien elegido.
class _QuantitySheet extends StatefulWidget {
  const _QuantitySheet({required this.selection});

  /// Lo elegido en la hoja de busqueda: un alimento del catalogo o un plato
  /// propio. La cantidad y la unidad se preguntan igual para los dos.
  final FoodPickerSelection selection;

  @override
  State<_QuantitySheet> createState() => _QuantitySheetState();
}

class _QuantitySheetState extends State<_QuantitySheet> {
  final TextEditingController _quantity = TextEditingController(text: '100');
  MeasurementUnitOption _unit = MeasurementUnitOption.grams;

  @override
  void dispose() {
    _quantity.dispose();
    super.dispose();
  }

  /// Arma el item con la referencia que corresponde a la fuente elegida.
  ///
  /// `MealItemDraft` exige **exactamente una** de las dos (`referencesExactlyOne`),
  /// que es la misma invariante XOR que valida `Meal.Register` en el backend.
  MealItemDraft _draft() {
    return switch (widget.selection) {
      CatalogSelection(:final item) => MealItemDraft(
          quantity: _parsed!,
          unit: _unit,
          food: item,
        ),
      CustomDishSelection(:final record) => MealItemDraft(
          quantity: _parsed!,
          unit: _unit,
          customFoodId: record.customFoodId,
          customFoodName: record.name,
        ),
    };
  }

  /// Cantidad valida, o `null` si lo escrito no sirve.
  ///
  /// Misma regla que `MealItemRequestValidator` del backend: mayor que cero.
  /// Validarlo aca le da al paciente la respuesta al instante en vez de un 400.
  double? get _parsed {
    final value = double.tryParse(_quantity.text.replaceAll(',', '.'));
    if (value == null || value <= 0 || value > _unit.maxQuantity) {
      return null;
    }
    return value;
  }

  /// Al cambiar de unidad, la cantidad vuelve a un valor razonable.
  ///
  /// Arrastrarla era lo que producia "100 tazas" al pasar de gramos a tazas
  /// sin tocar el numero (acta M40).
  void _changeUnit(MeasurementUnitOption unit) {
    setState(() {
      _unit = unit;
      _quantity.text = _format(unit.defaultQuantity);
    });
  }

  /// Sin decimales cuando no hacen falta: "1" y no "1.0".
  static String _format(double value) =>
      value == value.roundToDouble() ? value.round().toString() : '$value';

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
                widget.selection.displayName,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: CauceSpacing.space4),
              CauceTextField(
                key: const Key('meal_quantity_field'),
                controller: _quantity,
                label: l10n.mealsQuantityLabel,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                errorText: _parsed == null
                    ? l10n.mealsIssueQuantityOutOfRange(
                        MealLabels.unit(l10n, _unit).toLowerCase(),
                        _format(_unit.maxQuantity),
                      )
                    : null,
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: CauceSpacing.space4),
              CauceChoiceField<MeasurementUnitOption>(
                key: const Key('meal_unit_field'),
                label: l10n.mealsUnitLabel,
                value: _unit,
                onChanged: _changeUnit,
                choices: <CauceChoice<MeasurementUnitOption>>[
                  for (final option in MeasurementUnitOption.values)
                    CauceChoice<MeasurementUnitOption>(
                      value: option,
                      label: MealLabels.unit(l10n, option),
                    ),
                ],
              ),
              const SizedBox(height: CauceSpacing.space6),
              CauceButton(
                key: const Key('meal_quantity_confirm'),
                label: l10n.commonAccept,
                onPressed: _parsed == null
                    ? null
                    : () => Navigator.of(context).pop(_draft()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({
    required this.item,
    required this.enabled,
    required this.onRemove,
    required this.unitLabel,
    required this.removeLabel,
    super.key,
  });

  final MealItemDraft item;
  final bool enabled;
  final VoidCallback onRemove;
  final String unitLabel;
  final String removeLabel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(item.displayName),
      subtitle: Text('${item.quantity.toStringAsFixed(0)} $unitLabel'),
      trailing: TextButton(
        onPressed: enabled ? onRemove : null,
        child: Text(removeLabel),
      ),
    );
  }
}

/// Confirmacion del registro.
///
/// Distingue el registro que llego al servidor del que quedo en la cola local
/// (CA02, CP023). El segundo **no** es un error: el dato esta guardado y el
/// worker lo sube en cuanto vuelva la red, y decirle otra cosa al paciente lo
/// llevaria a anotar la misma comida dos veces.
class _MealConfirmation extends StatelessWidget {
  const _MealConfirmation({required this.state, required this.onAgain});

  final MealFormState state;
  final VoidCallback onAgain;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final queued = state.outcome == MealSubmitOutcome.queuedOffline;
    final fodmap = state.aggregatedFodmap;

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.mealsTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            queued ? l10n.mealsQueuedOffline : l10n.mealsRegistered,
            key: Key(queued ? 'meal_queued_offline' : 'meal_registered'),
            style: textTheme.headlineSmall,
          ),
          if (fodmap != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space4),
            Container(
              padding: const EdgeInsets.all(CauceSpacing.space4),
              decoration: BoxDecoration(
                color: CauceColors.bgCard,
                borderRadius: CauceRadii.borderLg,
                border: Border.all(color: CauceColors.bgDivider),
              ),
              child: Text(
                MealLabels.fodmapLoad(l10n, fodmap),
                key: const Key('meal_aggregated_fodmap'),
                style: textTheme.bodyLarge,
              ),
            ),
          ],
          const SizedBox(height: CauceSpacing.space6),
          CauceButton(
            key: const Key('meal_register_another'),
            label: l10n.mealsRegisterAnother,
            onPressed: onAgain,
          ),
        ],
      ),
    );
  }
}
