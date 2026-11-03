import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/errors/cauce_api_error.dart';
import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../patients/data/patients_repository.dart';
import '../../../patients/domain/allergy.dart';
import 'allergy_picker.dart';
import 'onboarding_scaffold.dart';

/// Catalogo de alergias con su ciclo de carga, error y reintento.
class AllergiesSection extends ConsumerWidget {
  const AllergiesSection({
    required this.selected,
    required this.enabled,
    required this.noneKnown,
    required this.error,
    required this.onNoneKnownChanged,
    required this.onChanged,
    super.key,
  });

  final Map<String, AllergyDeclarationDraft> selected;
  final bool enabled;
  final bool noneKnown;
  final String? error;
  final ValueChanged<bool> onNoneKnownChanged;
  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final catalog = ref.watch(allergyCatalogProvider);

    return OnboardingSection(
      title: l10n.allergiesTitle,
      subtitle: l10n.allergiesSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Fuera del catalogo: se puede marcar aunque el catalogo no cargue.
          CheckboxListTile(
            key: const Key('allergies_none_known'),
            value: noneKnown,
            onChanged:
                enabled ? (value) => onNoneKnownChanged(value ?? false) : null,
            title: Text(l10n.allergiesNoneKnown),
            controlAffinity: ListTileControlAffinity.leading,
            contentPadding: EdgeInsets.zero,
          ),
          if (error != null)
            Text(
              error!,
              key: const Key('allergies_error'),
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Theme.of(context).colorScheme.error),
            ),
          const SizedBox(height: CauceSpacing.space2),
          _catalog(context, ref, l10n, catalog),
        ],
      ),
    );
  }

  Widget _catalog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
    AsyncValue<List<AllergyCatalogEntry>> catalog,
  ) {
    return catalog.when(
      loading: () => CauceLoadingIndicator.fullscreen(
        message: l10n.allergiesLoading,
      ),
      // El catalogo no bloquea el paso: declarar alergias es opcional, asi
      // que un fallo aca ofrece reintentar sin impedir el envio del perfil.
      error: (error, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (error is CauceApiError)
            CauceErrorBanner(error: error)
          else
            Text(l10n.errorUnknown),
          const SizedBox(height: CauceSpacing.space3),
          CauceButton.secondary(
            key: const Key('allergies_retry'),
            label: l10n.commonRetry,
            onPressed: () => ref.invalidate(allergyCatalogProvider),
          ),
        ],
      ),
      data: (entries) => AllergyPicker(
        catalog: entries,
        selected: selected,
        enabled: enabled,
        onToggle: (entry, value) {
          if (value) {
            selected[entry.allergyId] = AllergyDeclarationDraft(
              allergyId: entry.allergyId,
              // Moderada es el punto medio de los tres niveles. Arrancar en
              // leve o severa sesgaria la declaracion hacia un extremo.
              severity: AllergySeverityLevel.moderate,
            );
          } else {
            selected.remove(entry.allergyId);
          }
          onChanged();
        },
        onSeverityChanged: (allergyId, value) {
          final current = selected[allergyId];
          if (current != null) {
            selected[allergyId] = current.copyWith(severity: value);
            onChanged();
          }
        },
        onNotesChanged: (allergyId, value) {
          final current = selected[allergyId];
          if (current != null) {
            selected[allergyId] = current.copyWith(notes: value);
          }
        },
      ),
    );
  }
}
