import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/application/session_notifier.dart';
import '../../onboarding/presentation/widgets/onboarding_labels.dart';
import '../data/patients_repository.dart';
import '../domain/patient_profile.dart';

/// Pestana de Perfil: datos clinicos, privacidad y cierre de sesion.
///
/// Solo lectura sobre el perfil. La edicion es US03 CA03, que sigue diferida:
/// el backend ya expone `PUT /patients/profile`, pero abrirla aca sin su propio
/// tratamiento de validacion y confirmacion seria adelantar media historia.
/// Mobile-4 la rehace entera sobre `GET /patients/me/summary` y los mockups
/// `12-mi-perfil-v2` y `12b-ajustes-privacidad-v1`.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(patientProfileProvider);

    return CauceScaffold(
      // Sin flecha de retroceso: desde Mobile-3.1 es una raiz de pestana.
      appBar: CauceAppBar(title: l10n.profileTitle),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Solo la tarjeta clinica depende de la consulta. La privacidad y el
          // cierre de sesion se dibujan siempre, incluso mientras el perfil
          // carga o si falla: dejar al paciente sin salida de su cuenta
          // porque el servidor no contesto seria el peor momento para
          // encerrarlo.
          profile.when(
            loading: () => CauceLoadingIndicator.fullscreen(
              message: l10n.commonLoading,
            ),
            error: (error, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (error is CauceApiError)
                  CauceErrorBanner(error: error)
                else
                  Text(l10n.profileLoadError, textAlign: TextAlign.center),
                const SizedBox(height: CauceSpacing.space4),
                CauceButton.secondary(
                  key: const Key('profile_retry'),
                  label: l10n.commonRetry,
                  onPressed: () => ref.invalidate(patientProfileProvider),
                ),
              ],
            ),
            data: (value) => value == null
                ? const SizedBox.shrink()
                : _ClinicalCard(profile: value),
          ),
          const SizedBox(height: CauceSpacing.space6),
          const _PrivacyEntry(),
          const SizedBox(height: CauceSpacing.space6),
          const _SessionSection(),
        ],
      ),
    );
  }
}

/// Resumen de los datos clinicos, en el mismo registro neutro del wizard.
class _ClinicalCard extends StatelessWidget {
  const _ClinicalCard({required this.profile});

  final PatientProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final subtype = profile.ibsSubtype;
    final category = profile.bmiCategory;

    return Container(
      key: const Key('profile_clinical_card'),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderLg,
        border: Border.all(
          color: CauceColors.bgDivider,
          width: CauceBorders.subtle,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(l10n.profileClinicalSection, style: textTheme.titleMedium),
          const SizedBox(height: CauceSpacing.space3),
          _Row(label: l10n.profileAge(profile.age)),
          if (subtype != null)
            _Row(
              label: OnboardingLabels.ibsSubtype(l10n, subtype),
              detail: OnboardingLabels.ibsSubtypeDescription(l10n, subtype),
            ),
          _Row(
            label: l10n.bmiValue(profile.bmi.toStringAsFixed(2)),
            detail: category == null
                ? null
                : OnboardingLabels.bmiCategory(l10n, category),
          ),
          _Row(
            label: profile.allergies.isEmpty
                ? l10n.profileAllergiesNone
                : l10n.profileAllergiesCount(profile.allergies.length),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, this.detail});

  final String label;
  final String? detail;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final extra = detail;

    return Padding(
      padding: const EdgeInsets.only(bottom: CauceSpacing.space2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Text(label, style: textTheme.bodyLarge),
          if (extra != null) ...<Widget>[
            const SizedBox(width: CauceSpacing.space2),
            Flexible(child: Text(extra, style: textTheme.labelSmall)),
          ],
        ],
      ),
    );
  }
}

/// Acceso a la seccion de privacidad.
class _PrivacyEntry extends StatelessWidget {
  const _PrivacyEntry();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _Section(
      title: l10n.profilePrivacySection,
      child: _Tile(
        tileKey: const Key('profile_privacy_entry'),
        title: l10n.profilePrivacyEntry,
        hint: l10n.profilePrivacyEntryHint,
        trailing: const Icon(TablerIcons.chevron_right, size: 20),
        // `push` y no `go`: privacidad se apila dentro de la rama de Perfil,
        // de modo que la flecha de su barra tiene a donde volver.
        onTap: () => context.push(AppRoutes.profilePrivacy),
      ),
    );
  }
}

/// Cierre de sesion, con la confirmacion que exige CP020 paso 3.
///
/// Vivia en Inicio hasta Mobile-3.1 y se mudo aca junto con la barra inferior:
/// el CP describe el recorrido como "acceder a la seccion Perfil y seleccionar
/// la opcion para cerrar sesion".
class _SessionSection extends ConsumerStatefulWidget {
  const _SessionSection();

  @override
  ConsumerState<_SessionSection> createState() => _SessionSectionState();
}

class _SessionSectionState extends ConsumerState<_SessionSection> {
  bool _loggingOut = false;

  Future<void> _logout() async {
    if (_loggingOut) {
      return;
    }

    final l10n = AppLocalizations.of(context);
    final confirmed = await CauceConfirmDialog.show(
      context,
      title: l10n.profileLogoutConfirmTitle,
      message: l10n.profileLogoutConfirmBody,
      confirmLabel: l10n.profileLogout,
      cancelLabel: l10n.commonCancel,
    );
    if (!confirmed || !mounted) {
      return;
    }

    setState(() => _loggingOut = true);

    // El notifier avisa al backend y limpia el almacenamiento. No falla nunca:
    // si el aviso no prospera, la sesion local se cierra igual.
    await ref.read(sessionNotifierProvider.notifier).logout();

    // El guard del router se encarga de llevar al login en cuanto el estado
    // pasa a no autenticado. Esta pantalla no navega por su cuenta.
    if (mounted) {
      setState(() => _loggingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _Section(
      title: l10n.profileSessionSection,
      child: _Tile(
        tileKey: const Key('profile_logout'),
        title: l10n.profileLogout,
        hint: l10n.profileLogoutHint,
        trailing: _loggingOut
            ? const CauceLoadingIndicator.inline(color: CauceColors.brandBase)
            : const Icon(TablerIcons.logout, size: 20),
        onTap: _loggingOut ? null : _logout,
      ),
    );
  }
}

/// Encabezado de seccion mas su contenido.
class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(title, style: textTheme.titleMedium),
        const SizedBox(height: CauceSpacing.space3),
        child,
      ],
    );
  }
}

/// Fila navegable con titulo, aclaracion y un elemento a la derecha.
class _Tile extends StatelessWidget {
  const _Tile({
    required this.tileKey,
    required this.title,
    required this.hint,
    required this.trailing,
    required this.onTap,
  });

  final Key tileKey;
  final String title;
  final String hint;
  final Widget trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: CauceColors.bgCard,
      borderRadius: CauceRadii.borderMd,
      child: InkWell(
        key: tileKey,
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
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(title, style: textTheme.bodyLarge),
                    Text(hint, style: textTheme.labelSmall),
                  ],
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
