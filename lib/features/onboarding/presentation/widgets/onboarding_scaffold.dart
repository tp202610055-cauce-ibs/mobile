import 'package:flutter/material.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';

/// Encabezado y pie comunes a los dos pasos del wizard.
///
/// Aporta el indicador de progreso y el boton de aplazar (CA05), que de otro
/// modo las dos pantallas repetirian con el riesgo de que se desalineen.
class OnboardingStepScaffold extends StatelessWidget {
  const OnboardingStepScaffold({
    required this.step,
    required this.title,
    required this.subtitle,
    required this.children,
    required this.onDefer,
    this.busy = false,
    super.key,
  });

  /// Paso actual, base 1.
  final int step;

  final String title;
  final String subtitle;
  final List<Widget> children;

  /// Aplaza el onboarding. `null` lo oculta.
  final VoidCallback? onDefer;

  /// Mientras haya una peticion en vuelo, aplazar queda deshabilitado: salir a
  /// mitad de un envio dejaria al paciente sin saber si se guardo.
  final bool busy;

  static const int totalSteps = 2;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.appTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            l10n.onboardingStepLabel(step, totalSteps),
            key: const Key('onboarding_step_label'),
            style: textTheme.labelSmall?.copyWith(
              color: CauceColors.brandStrong,
            ),
          ),
          const SizedBox(height: CauceSpacing.space2),
          Text(title, style: textTheme.headlineLarge),
          const SizedBox(height: CauceSpacing.space2),
          Text(subtitle, style: textTheme.bodyMedium),
          const SizedBox(height: CauceSpacing.space6),
          ...children,
          if (onDefer != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space4),
            CauceButton.tertiary(
              key: const Key('onboarding_defer'),
              label: l10n.onboardingDefer,
              expand: true,
              onPressed: busy ? null : onDefer,
            ),
          ],
          const SizedBox(height: CauceSpacing.space6),
        ],
      ),
    );
  }
}

/// Tarjeta de seccion, con el fondo agrupado del design system.
class OnboardingSection extends StatelessWidget {
  const OnboardingSection({
    required this.title,
    required this.child,
    this.subtitle,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final description = subtitle;

    // `Material` y no un `Container` con decoracion: el selector de alergias
    // usa `CheckboxListTile`, que pinta su fondo y su tinta sobre el `Material`
    // mas cercano. Con un fondo de color en el medio, Flutter avisa que esos
    // efectos quedarian ocultos.
    return Material(
      color: CauceColors.bgSubtle,
      borderRadius: CauceRadii.borderLg,
      child: Padding(
        padding: const EdgeInsets.all(CauceSpacing.space4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(title, style: textTheme.titleMedium),
            if (description != null) ...<Widget>[
              const SizedBox(height: CauceSpacing.space1),
              Text(description, style: textTheme.bodyMedium),
            ],
            const SizedBox(height: CauceSpacing.space3),
            child,
          ],
        ),
      ),
    );
  }
}
