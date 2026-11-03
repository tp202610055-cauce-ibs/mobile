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
///
/// Abre con el buscador (CP022 paso 3); el alimento elegido queda en el
/// formulario con su cantidad y su unidad hasta guardar o agregar otro.
class MealFormScreen extends ConsumerStatefulWidget {
  const MealFormScreen({super.key});

  @override
  ConsumerState<MealFormScreen> createState() => _MealFormScreenState();
}

class _MealFormScreenState extends ConsumerState<MealFormScreen> {
  final TextEditingController _quantity = TextEditingController();

  /// Alimento elegido que todavia no esta en la lista de la comida.
  FoodPickerSelection? _pending;

  /// Arranca sin marcar; tocar la unidad elegida la quita.
  MeasurementUnitOption? _unit;

  /// Los avisos de cantidad vacia y de unidad aparecen al intentar guardar.
  bool _attempted = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _pickFood());
  }

  @override
  void dispose() {
    _quantity.dispose();
    super.dispose();
  }

  Future<void> _pickFood() async {
    final selection = await showFoodPickerSheet(context);
    if (selection == null || !mounted) {
      return;
    }
    setState(() => _pending = selection);
  }

  /// Lo escrito como numero, sin validar; acepta coma decimal.
  double? get _typed =>
      double.tryParse(_quantity.text.trim().replaceAll(',', '.'));

  /// Cantidad valida, o `null` si lo escrito no sirve.
  ///
  /// Mayor que cero como `MealItemRequestValidator`, y bajo el tope por unidad.
  double? get _parsed {
    final value = _typed;
    final max = _unit?.maxQuantity ?? double.infinity;
    if (value == null || value <= 0 || value > max) {
      return null;
    }
    return value;
  }

  /// Lo escrito no es un numero, como «cien» (CP076 variante C).
  bool get _isNotANumber => _typed == null;

  /// Elegir una unidad nunca cambia la cantidad escrita (CP022, CP076).
  void _changeUnit(MeasurementUnitOption unit) {
    setState(() => _unit = unit == _unit ? null : unit);
  }

  /// Item del alimento pendiente, o `null` si falta cantidad o unidad.
  ///
  /// `MealItemDraft` exige exactamente una referencia, como `Meal.Register`.
  MealItemDraft? _pendingItem() {
    final quantity = _parsed;
    final unit = _unit;
    if (quantity == null || unit == null) {
      return null;
    }
    return switch (_pending) {
      CatalogSelection(:final item) =>
        MealItemDraft(quantity: quantity, unit: unit, food: item),
      CustomDishSelection(:final record) => MealItemDraft(
          quantity: quantity,
          unit: unit,
          customFoodId: record.customFoodId,
          customFoodName: record.name,
        ),
      null => null,
    };
  }

  /// Pasa el alimento pendiente a la lista. Devuelve `false` si no es valido.
  bool _commitPending() {
    if (_pending == null) {
      return true;
    }
    final item = _pendingItem();
    if (item == null) {
      setState(() => _attempted = true);
      return false;
    }
    ref.read(mealFormNotifierProvider.notifier).addItem(item);
    setState(() {
      _pending = null;
      _unit = null;
      _attempted = false;
      _quantity.clear();
    });
    return true;
  }

  Future<void> _addAnother() async {
    if (_commitPending()) {
      await _pickFood();
    }
  }

  void _removePending() {
    setState(() {
      _pending = null;
      _attempted = false;
    });
  }

  /// Guarda solo si todo es valido; si no, señala lo que falta y conserva lo
  /// elegido (CP076).
  Future<void> _save() async {
    setState(() => _attempted = true);
    final pendingItem = _pendingItem();
    if (_pending != null && pendingItem == null) {
      return;
    }
    final draft = ref.read(mealFormNotifierProvider).draft;
    final candidate = pendingItem == null ? draft : draft.withItem(pendingItem);
    if (!candidate.canSubmit()) {
      return;
    }
    _commitPending();
    await ref.read(mealFormNotifierProvider.notifier).submit();
  }

  String? _quantityError(AppLocalizations l10n) {
    final unit = _unit;
    if (_parsed != null || (_quantity.text.isEmpty && !_attempted)) {
      return null;
    }
    if (_isNotANumber) {
      return l10n.mealsIssueQuantityNotANumber;
    }
    // Cero o negativo tiene su propio aviso; el rango es solo para el tope.
    if (unit == null || _typed! <= 0) {
      return l10n.mealsIssueInvalidQuantity;
    }
    return l10n.mealsIssueQuantityOutOfRange(
      MealLabels.unit(l10n, unit).toLowerCase(),
      MealLabels.quantity(unit.maxQuantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(mealFormNotifierProvider);
    final notifier = ref.read(mealFormNotifierProvider.notifier);
    final pending = _pending;

    if (state.outcome == MealSubmitOutcome.registered ||
        state.outcome == MealSubmitOutcome.queuedOffline) {
      return _MealConfirmation(state: state, onAgain: notifier.reset);
    }

    // Con un alimento pendiente, «agrega al menos uno» ya no aplica.
    final issues = <MealDraftIssue>[
      for (final issue in state.issues)
        if (pending == null || issue != MealDraftIssue.noItems) issue,
    ];

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
          if (state.draft.items.isEmpty && pending == null)
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
              amountLabel: MealLabels.amount(l10n, item.quantity, item.unit),
              removeLabel: l10n.mealsRemoveItem,
            ),
          if (pending != null)
            _PendingItemEditor(
              key: const Key('meal_pending_item'),
              name: pending.displayName,
              quantity: _quantity,
              unit: _unit,
              quantityError: _quantityError(l10n),
              unitError: _attempted && _unit == null
                  ? l10n.mealsIssueMissingUnit
                  : null,
              enabled: !state.submitting,
              onQuantityChanged: () => setState(() {}),
              onUnitChanged: _changeUnit,
              onRemove: _removePending,
            ),
          const SizedBox(height: CauceSpacing.space3),
          CauceButton.secondary(
            key: const Key('meal_add_food'),
            label: l10n.mealsAddFood,
            onPressed: state.submitting ? null : _addAnother,
          ),
          const SizedBox(height: CauceSpacing.space6),
          // CA04: mientras algo bloquee el envio se dice **que** lo bloquea.
          if (issues.isNotEmpty) ...<Widget>[
            for (final issue in issues)
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
            onPressed: state.submitting ? null : _save,
          ),
        ],
      ),
    );
  }
}

/// Cantidad y unidad del alimento recien elegido, dentro del formulario.
class _PendingItemEditor extends StatelessWidget {
  const _PendingItemEditor({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.quantityError,
    required this.unitError,
    required this.enabled,
    required this.onQuantityChanged,
    required this.onUnitChanged,
    required this.onRemove,
    super.key,
  });

  final String name;
  final TextEditingController quantity;
  final MeasurementUnitOption? unit;
  final String? quantityError;
  final String? unitError;
  final bool enabled;
  final VoidCallback onQuantityChanged;
  final ValueChanged<MeasurementUnitOption> onUnitChanged;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(name, style: Theme.of(context).textTheme.titleLarge),
          trailing: TextButton(
            onPressed: enabled ? onRemove : null,
            child: Text(l10n.mealsRemoveItem),
          ),
        ),
        CauceTextField(
          key: const Key('meal_quantity_field'),
          controller: quantity,
          label: l10n.mealsQuantityLabel,
          enabled: enabled,
          // Teclado de texto: tambien acepta letras y el signo menos, que se
          // rechazan con su aviso en vez de no poder escribirse.
          keyboardType: TextInputType.text,
          errorText: quantityError,
          onChanged: (_) => onQuantityChanged(),
        ),
        const SizedBox(height: CauceSpacing.space4),
        CauceChoiceField<MeasurementUnitOption>(
          key: const Key('meal_unit_field'),
          label: l10n.mealsUnitLabel,
          value: unit,
          enabled: enabled,
          errorText: unitError,
          onChanged: onUnitChanged,
          choices: <CauceChoice<MeasurementUnitOption>>[
            for (final option in MeasurementUnitOption.values)
              CauceChoice<MeasurementUnitOption>(
                value: option,
                label: MealLabels.unit(l10n, option),
              ),
          ],
        ),
      ],
    );
  }
}

class _ItemRow extends StatelessWidget {
  const _ItemRow({
    required this.item,
    required this.enabled,
    required this.onRemove,
    required this.amountLabel,
    required this.removeLabel,
    super.key,
  });

  final MealItemDraft item;
  final bool enabled;
  final VoidCallback onRemove;

  /// Cantidad con su unidad, ya localizada ([MealLabels.amount]).
  final String amountLabel;
  final String removeLabel;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(item.displayName),
      subtitle: Text(amountLabel),
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
