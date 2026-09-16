import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../theme/design_tokens.dart';

/// Una opcion del selector, con su etiqueta visible y su valor de dominio.
class CauceChoice<T> {
  const CauceChoice({
    required this.value,
    required this.label,
    this.description,
  });

  final T value;

  /// Texto que ve el paciente. Viene de l10n, nunca literal.
  final String label;

  /// Aclaracion breve bajo la etiqueta. Util en el subtipo de SII, donde
  /// "IBS-D" no le dice nada a un paciente sin la glosa.
  final String? description;
}

/// Seleccion unica sobre una lista corta de opciones.
///
/// Cubre los tres selectores del perfil clinico: sexo biologico (3 opciones),
/// subtipo de SII (4) y severidad de una alergia (3).
///
/// **Derivado, no transcrito**, igual que [CauceSlider]: el HTML del design
/// system no esta en el checkout y no define este componente.
///
/// Se usa una lista de opciones visibles y no un desplegable a proposito. Con
/// tres o cuatro alternativas, un `DropdownButton` esconde el conjunto tras un
/// toque extra y obliga a recordar lo que habia; ademas, cada opcion respeta
/// asi el area tactil minima sin depender del alto del menu emergente.
class CauceChoiceField<T> extends StatelessWidget {
  const CauceChoiceField({
    required this.label,
    required this.choices,
    required this.value,
    required this.onChanged,
    this.errorText,
    this.enabled = true,
    super.key,
  });

  /// Titulo del grupo, por ejemplo "Sexo biologico".
  final String label;

  final List<CauceChoice<T>> choices;

  /// Opcion elegida, o `null` mientras no haya ninguna.
  final T? value;

  final ValueChanged<T>? onChanged;

  /// Error bajo el grupo. Se pinta con el mismo estilo que el de los campos
  /// de texto, para que un formulario con ambos se lea parejo.
  final String? errorText;

  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final hasError = errorText != null;
    final active = enabled && onChanged != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(label, style: textTheme.bodyMedium),
        const SizedBox(height: CauceSpacing.space2),
        DecoratedBox(
          decoration: BoxDecoration(
            color: CauceColors.bgCard,
            borderRadius: CauceRadii.borderMd,
            border: Border.all(
              color: hasError ? CauceColors.dangerText : CauceColors.bgDivider,
              width: CauceBorders.strong,
            ),
          ),
          child: Column(
            children: <Widget>[
              for (int i = 0; i < choices.length; i++) ...<Widget>[
                if (i > 0)
                  const Divider(height: 1, indent: CauceSpacing.space4),
                _ChoiceTile<T>(
                  choice: choices[i],
                  selected: choices[i].value == value,
                  enabled: active,
                  onTap: () => onChanged!(choices[i].value),
                ),
              ],
            ],
          ),
        ),
        if (hasError) ...<Widget>[
          const SizedBox(height: CauceSpacing.space1),
          Text(
            errorText!,
            style: textTheme.labelSmall?.copyWith(
              color: CauceColors.dangerText,
            ),
          ),
        ],
      ],
    );
  }
}

/// Una fila del selector.
class _ChoiceTile<T> extends StatelessWidget {
  const _ChoiceTile({
    required this.choice,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final CauceChoice<T> choice;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final description = choice.description;

    return InkWell(
      onTap: enabled ? onTap : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: CauceSpacing.space4,
          vertical: CauceSpacing.space3,
        ),
        child: ConstrainedBox(
          constraints: const BoxConstraints(
            minHeight: CauceSizes.touchTargetMin - CauceSpacing.space6,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                selected ? TablerIcons.circle_dot_filled : TablerIcons.circle,
                size: 20,
                color:
                    selected ? CauceColors.brandBase : CauceColors.textTertiary,
              ),
              const SizedBox(width: CauceSpacing.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      choice.label,
                      style: textTheme.bodyLarge?.copyWith(
                        color: enabled
                            ? CauceColors.textPrimary
                            : CauceColors.textTertiary,
                      ),
                    ),
                    if (description != null)
                      Text(description, style: textTheme.labelSmall),
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
