import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../l10n/generated/app_localizations.dart';
import '../theme/design_tokens.dart';

/// Campo de texto del design system.
///
/// Envuelve [TextFormField] para aportar dos cosas que el tema no expresa:
///
/// 1. **El anillo de foco de 3px** en [CauceColors.brandSoft]. El design
///    system lo define como un `box-shadow` externo, e `InputDecorationTheme`
///    solo sabe de bordes; se dibuja aca con un [AnimatedContainer].
/// 2. **El alternador de contrasena**, para que las tres pantallas que piden
///    una no repitan el mismo `IconButton` con su tooltip y su estado.
class CauceTextField extends StatefulWidget {
  const CauceTextField({
    required this.label,
    this.controller,
    this.hint,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.autofillHints,
    this.enabled = true,
    this.obscure = false,
    super.key,
  });

  /// Campo de correo, con teclado y autocompletado adecuados.
  const CauceTextField.email({
    required this.label,
    this.controller,
    this.hint,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction = TextInputAction.next,
    this.enabled = true,
    super.key,
  })  : keyboardType = TextInputType.emailAddress,
        textCapitalization = TextCapitalization.none,
        autofillHints = const <String>[AutofillHints.email],
        obscure = false;

  /// Campo de contrasena, con alternador de visibilidad incorporado.
  const CauceTextField.password({
    required this.label,
    this.controller,
    this.hint,
    this.errorText,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.textInputAction = TextInputAction.done,
    this.autofillHints,
    this.enabled = true,
    super.key,
  })  : keyboardType = null,
        textCapitalization = TextCapitalization.none,
        obscure = true;

  final String label;
  final TextEditingController? controller;
  final String? hint;

  /// Error a mostrar bajo el campo. Tipicamente viene del backend; los
  /// errores locales los produce [validator].
  final String? errorText;

  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<String>? autofillHints;
  final bool enabled;

  /// Si el contenido nace oculto. Habilita el alternador.
  final bool obscure;

  @override
  State<CauceTextField> createState() => _CauceTextFieldState();
}

class _CauceTextFieldState extends State<CauceTextField> {
  final _focusNode = FocusNode();
  late bool _obscured = widget.obscure;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus != _focused) {
      setState(() => _focused = _focusNode.hasFocus);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasError = widget.errorText != null;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        borderRadius: CauceRadii.borderMd,
        // El anillo solo aparece con foco y sin error: sobre un campo en rojo
        // el halo coral confundiria mas de lo que orienta.
        boxShadow: _focused && !hasError
            ? const <BoxShadow>[
                BoxShadow(
                  color: CauceColors.brandSoft,
                  spreadRadius: CauceBorders.focusRing,
                ),
              ]
            : const <BoxShadow>[],
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          errorText: widget.errorText,
          suffixIcon: widget.obscure
              ? IconButton(
                  icon: Icon(
                    _obscured ? TablerIcons.eye : TablerIcons.eye_off,
                  ),
                  tooltip: _obscured
                      ? l10n.loginShowPassword
                      : l10n.loginHidePassword,
                  onPressed: () => setState(() => _obscured = !_obscured),
                )
              : null,
        ),
        obscureText: _obscured,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        autofillHints: widget.autofillHints,
        enabled: widget.enabled,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onFieldSubmitted: widget.onSubmitted,
      ),
    );
  }
}
