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
import '../../onboarding/application/onboarding_notifier.dart';
import '../../onboarding/presentation/widgets/onboarding_labels.dart';
import '../data/patients_repository.dart';
import '../domain/patient_summary.dart';

/// Diametro del avatar del hero, que el mockup fija en 72 px.
const double _avatarSize = 72;

/// Pestana de Perfil (P12, mockup `12-mi-perfil-v2`).
///
/// "Quien soy yo en este piloto": identidad y estado clinico. Se arma sobre
/// `GET /patients/me/summary`, que resuelve en una sola consulta lo que antes
/// habria exigido cuatro.
///
/// **Dos datos del mockup no se dibujan todavia y no es un olvido.** El codigo
/// de paciente (`PAC-0042`, acta A59) no viaja en ninguna respuesta de la API,
/// y las alergias no estan en `MyProfileClinicalInfo`. Los dos quedan
/// reportados y esperando al backend; completarlos desde otra llamada habria
/// sido resolver por cuenta propia un hueco de contrato.
///
/// **El cierre de sesion se queda aca**, aunque el mockup lo dibuje en P12-B:
/// CP020 paso 3 describe el recorrido como "acceder a la seccion Perfil y
/// seleccionar la opcion para cerrar sesion", y esta construido y probado
/// desde Mobile-3.1.
class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(patientSummaryProvider);

    return CauceScaffold(
      // Sin flecha de retroceso: desde Mobile-3.1 es una raiz de pestana.
      appBar: CauceAppBar(
        title: l10n.profileTitle,
        actions: <Widget>[
          IconButton(
            // El engranaje del mockup, ya con su destino definitivo: P12-B.
            // Privacidad sigue existiendo y se alcanza desde alli, en la
            // seccion "Sobre la app".
            key: const Key('profile_settings_entry'),
            icon: const Icon(TablerIcons.settings),
            tooltip: l10n.profileSettings,
            onPressed: () => context.push(AppRoutes.profileSettings),
          ),
        ],
      ),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Solo el resumen depende de la consulta. El cierre de sesion se
          // dibuja siempre, incluso mientras carga o si falla: dejar al
          // paciente sin salida de su cuenta porque el servidor no contesto
          // seria el peor momento para encerrarlo. El acceso a privacidad vive
          // en la barra superior por el mismo motivo.
          summary.when(
            loading: () => CauceLoadingIndicator.fullscreen(
              message: l10n.commonLoading,
            ),
            error: (error, _) => _LoadFailure(error: error),
            data: (value) => _Summary(summary: value),
          ),
          const SizedBox(height: CauceSpacing.space6),
          // Fuera del `when` a proposito: el reporte no necesita ningun dato
          // del resumen, y ofrecerlo igual cuando la consulta falla es lo
          // mismo que ya se hace con privacidad y con el cierre de sesion.
          const _ReportEntry(),
          const SizedBox(height: CauceSpacing.space6),
          const _SessionSection(),
        ],
      ),
    );
  }
}

/// Fallo de carga del resumen, con su reintento.
class _LoadFailure extends ConsumerWidget {
  const _LoadFailure({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final failure = error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        if (failure is CauceApiError)
          CauceErrorBanner(error: failure)
        else
          Text(l10n.profileLoadError, textAlign: TextAlign.center),
        const SizedBox(height: CauceSpacing.space4),
        CauceButton.secondary(
          key: const Key('profile_retry'),
          label: l10n.commonRetry,
          onPressed: () => ref.invalidate(patientSummaryProvider),
        ),
      ],
    );
  }
}

/// Hero mas las tres tarjetas del mockup.
class _Summary extends StatelessWidget {
  const _Summary({required this.summary});

  final PatientSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        _Hero(summary: summary),
        const SizedBox(height: CauceSpacing.space6),
        _TrackingCard(summary: summary),
        const SizedBox(height: CauceSpacing.space4),
        _ClinicalCard(summary: summary),
        const SizedBox(height: CauceSpacing.space4),
        _EvolutionCard(summary: summary),
        const SizedBox(height: CauceSpacing.space6),
        CauceButton.secondary(
          key: const Key('profile_edit'),
          label: l10n.profileEdit,
          // Sin pantalla de edicion todavia (US03 CA03 sigue diferida). Se
          // deja deshabilitado y explicado en vez de conectado a una ruta
          // inventada o de desaparecer sin decir por que.
          onPressed: null,
        ),
        const SizedBox(height: CauceSpacing.space2),
        Text(
          l10n.profileEditUnavailable,
          key: const Key('profile_edit_unavailable'),
          style: Theme.of(context).textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// Identidad: avatar con iniciales y nombre completo.
///
/// Sin foto: el contrato no expone ninguna, asi que la variante "con foto" del
/// mockup no tiene de donde salir todavia. Las iniciales no son un placeholder
/// generico, son la variante por defecto que el propio mockup declara.
class _Hero extends StatelessWidget {
  const _Hero({required this.summary});

  final PatientSummary summary;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: const Key('profile_hero'),
      padding: const EdgeInsets.symmetric(
        horizontal: CauceSpacing.space4,
        vertical: CauceSpacing.space6,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[CauceColors.brandSoft, CauceColors.bgCard],
        ),
        borderRadius: CauceRadii.borderLg,
        border: Border.all(
          color: CauceColors.bgDivider,
          width: CauceBorders.subtle,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            key: const Key('profile_avatar'),
            width: _avatarSize,
            height: _avatarSize,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: CauceColors.brandBase,
              shape: BoxShape.circle,
            ),
            child: Text(
              summary.initials,
              style: textTheme.titleLarge?.copyWith(
                color: CauceColors.textOnBrand,
              ),
            ),
          ),
          const SizedBox(height: CauceSpacing.space3),
          Text(
            summary.fullName,
            key: const Key('profile_full_name'),
            style: textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

/// "Mi seguimiento": inicio del piloto, tiempo transcurrido y nutricionista.
class _TrackingCard extends StatelessWidget {
  const _TrackingCard({required this.summary});

  final PatientSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final start = summary.pilotStartDate;
    final days = summary.daysInPilot(DateTime.now());

    return _InfoCard(
      cardKey: const Key('profile_tracking_card'),
      icon: TablerIcons.calendar_stats,
      title: l10n.profileTrackingSection,
      rows: <Widget>[
        if (start != null)
          _InfoRow(
            label: l10n.profileTrackingStart,
            value: OnboardingLabels.date(start.toLocal()),
          ),
        if (days != null)
          _InfoRow(
            label: l10n.profileTrackingElapsed,
            value: days < 7
                ? l10n.profileTrackingElapsedFresh
                : l10n.profileTrackingElapsedWeeks(days ~/ 7),
          ),
        _InfoRow(
          key: const Key('profile_nutritionist'),
          label: l10n.profileTrackingNutritionist,
          value: summary.hasNutritionist
              ? summary.nutritionistName!
              : l10n.profileTrackingNutritionistPending,
          // Sin asignar no es un fallo, es un estado normal de una cuenta
          // recien creada. Va en tono terciario y no bloquea la pantalla.
          muted: !summary.hasNutritionist,
        ),
      ],
    );
  }
}

/// "Mi perfil clinico": por ahora, solo el subtipo.
///
/// El mockup suma las alergias declaradas, que `MyProfileClinicalInfo` no
/// trae. Quedan pendientes del backend.
class _ClinicalCard extends StatelessWidget {
  const _ClinicalCard({required this.summary});

  final PatientSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final subtype = summary.ibsSubtype;

    return _InfoCard(
      cardKey: const Key('profile_clinical_card'),
      icon: TablerIcons.stethoscope,
      title: l10n.profileClinicalSection,
      rows: <Widget>[
        _InfoRow(
          label: l10n.profileClinicalSubtype,
          value: subtype == null
              ? '—'
              : OnboardingLabels.ibsSubtype(l10n, subtype),
          detail: subtype == null
              ? null
              : OnboardingLabels.ibsSubtypeDescription(l10n, subtype),
        ),
      ],
    );
  }
}

/// "Mi evolucion IBS-SSS": los tres numeros y la pildora de logro.
///
/// Sin grafico, a proposito: DEC-008 deja el sparkline en el hero de Inicio y
/// esta pantalla no lo repite.
class _EvolutionCard extends StatelessWidget {
  const _EvolutionCard({required this.summary});

  final PatientSummary summary;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (!summary.hasEvolution) {
      return _InfoCard(
        cardKey: const Key('profile_evolution_card'),
        icon: TablerIcons.chart_line,
        title: l10n.profileEvolutionSection,
        rows: <Widget>[
          Text(
            l10n.profileEvolutionEmpty,
            key: const Key('profile_evolution_empty'),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: CauceSpacing.space3),
          Consumer(
            builder: (context, ref, _) => CauceButton.secondary(
              key: const Key('profile_evolution_cta'),
              label: l10n.profileEvolutionEmptyAction,
              // Publica el paso pendiente y deja que el guard navegue, igual
              // que el recordatorio de Inicio y la pestana de Consejos. La
              // pantalla no navega sola.
              onPressed: () =>
                  ref.read(onboardingNotifierProvider.notifier).resume(),
            ),
          ),
        ],
      );
    }

    return _InfoCard(
      cardKey: const Key('profile_evolution_card'),
      icon: TablerIcons.chart_line,
      title: l10n.profileEvolutionSection,
      rows: <Widget>[
        _InfoRow(
          label: l10n.profileEvolutionBaseline,
          value: l10n.profileEvolutionScore(summary.ibsSssBaseline!),
          numeric: true,
        ),
        _InfoRow(
          label: l10n.profileEvolutionLatest,
          value: l10n.profileEvolutionScore(summary.ibsSssLatest!),
          numeric: true,
        ),
        _InfoRow(
          key: const Key('profile_evolution_change'),
          label: l10n.profileEvolutionChange,
          value: _changeLabel(l10n),
          numeric: true,
          // Verde solo si mejoro. Un empeoramiento va en el color de texto
          // normal y nunca en rojo: el mockup lo pide asi para no leer como
          // un fracaso del paciente.
          valueColor: summary.hasImproved ? CauceColors.fodmapLowText : null,
        ),
        const SizedBox(height: CauceSpacing.space3),
        if (summary.significantClinicalResponse)
          Center(
            child: CauceBadge(
              key: const Key('profile_evolution_achievement'),
              label: l10n.profileEvolutionAchievement,
              icon: TablerIcons.circle_check,
              tone: CauceBadgeTone.success,
            ),
          )
        else
          Text(
            l10n.profileEvolutionOngoing,
            key: const Key('profile_evolution_ongoing'),
            style: Theme.of(context).textTheme.labelSmall,
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: CauceSpacing.space3),
        // Punto de entrada a la pantalla de Evolucion (HU0023). Hasta
        // Mobile-4 esta tarjeta no llevaba a ningun lado.
        InkWell(
          key: const Key('profile_evolution_open'),
          borderRadius: CauceRadii.borderMd,
          onTap: () => context.push(AppRoutes.ibsSssEvolution),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: CauceSpacing.space2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Flexible y no Text suelto: la etiqueta es larga y con el
                // ancho de una pantalla chica la fila se desbordaba.
                Flexible(
                  child: Text(
                    l10n.evolutionOpen,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: CauceColors.brandBase),
                  ),
                ),
                const SizedBox(width: CauceSpacing.space1),
                const Icon(
                  TablerIcons.chevron_right,
                  size: 18,
                  color: CauceColors.brandBase,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Texto del cambio acumulado.
  ///
  /// El backend lo entrega como `latest - baseline`, de modo que **negativo es
  /// mejoria**. Se traduce a "menos" y "mas" en vez de mostrar el signo, que
  /// obligaria al paciente a recordar en que direccion se lee.
  String _changeLabel(AppLocalizations l10n) {
    final change = summary.cumulativeChange ?? 0;
    if (change == 0) {
      return l10n.profileEvolutionChangeSame;
    }
    return change < 0
        ? l10n.profileEvolutionChangeDown(-change)
        : l10n.profileEvolutionChangeUp(change);
  }
}

/// Tarjeta con encabezado de icono mas titulo, y sus filas.
///
/// Las tres tarjetas comparten estructura a proposito: el mockup lo justifica
/// en que el paciente aprende el patron en la primera y lo aplica al resto.
class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.cardKey,
    required this.icon,
    required this.title,
    required this.rows,
  });

  final Key cardKey;
  final IconData icon;
  final String title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: cardKey,
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
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, size: 18, color: CauceColors.brandBase),
              const SizedBox(width: CauceSpacing.space2),
              Expanded(child: Text(title, style: textTheme.titleMedium)),
            ],
          ),
          const SizedBox(height: CauceSpacing.space3),
          ...rows,
        ],
      ),
    );
  }
}

/// Fila de "etiqueta a la izquierda, valor a la derecha".
class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.label,
    required this.value,
    this.detail,
    this.muted = false,
    this.numeric = false,
    this.valueColor,
    super.key,
  });

  final String label;
  final String value;

  /// Aclaracion bajo el valor, como la descripcion del subtipo.
  final String? detail;

  /// Baja el valor a tono terciario, para los estados "todavia no".
  final bool muted;

  /// Usa la tipografia monoespaciada de los datos cuantitativos.
  final bool numeric;

  final Color? valueColor;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final extra = detail;

    final valueStyle =
        (numeric ? textTheme.labelMedium : textTheme.bodyLarge)?.copyWith(
      color: valueColor ??
          (muted ? CauceColors.textTertiary : CauceColors.textPrimary),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: CauceSpacing.space3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  label,
                  style: textTheme.labelSmall,
                ),
              ),
              const SizedBox(width: CauceSpacing.space3),
              Flexible(
                child: Text(
                  value,
                  style: valueStyle,
                  textAlign: TextAlign.end,
                ),
              ),
            ],
          ),
          if (extra != null) ...<Widget>[
            const SizedBox(height: CauceSpacing.space1),
            Text(
              extra,
              style: textTheme.labelSmall,
              textAlign: TextAlign.end,
            ),
          ],
        ],
      ),
    );
  }
}

/// Acceso al reporte clinico personal (HU0024).
///
/// Vive en Perfil y no en Configuracion de cuenta porque asi lo describen
/// CP062 paso 2 y CP063 paso 1: "acceder a la seccion Perfil... seleccionar la
/// opcion para generar su reporte". Mismo criterio que el cierre de sesion con
/// CP020 y que la tarjeta de Evolucion.
class _ReportEntry extends StatelessWidget {
  const _ReportEntry();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: CauceColors.bgCard,
      borderRadius: CauceRadii.borderMd,
      child: InkWell(
        key: const Key('profile_report_entry'),
        borderRadius: CauceRadii.borderMd,
        onTap: () => context.push(AppRoutes.profileReport),
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
              const Icon(
                TablerIcons.file_text,
                size: 20,
                color: CauceColors.brandBase,
              ),
              const SizedBox(width: CauceSpacing.space3),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(l10n.reportEntry, style: textTheme.bodyLarge),
                    Text(l10n.reportEntryHint, style: textTheme.labelSmall),
                  ],
                ),
              ),
              const Icon(TablerIcons.chevron_right, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

/// Cierre de sesion, con la confirmacion que exige CP020 paso 3.
///
/// Vivia en Inicio hasta Mobile-3.1 y se mudo aca junto con la barra inferior:
/// el CP describe el recorrido como "acceder a la seccion Perfil y seleccionar
/// la opcion para cerrar sesion". El mockup lo dibuja en P12-B; se queda aca
/// por decision explicita.
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
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(l10n.profileSessionSection, style: textTheme.titleMedium),
        const SizedBox(height: CauceSpacing.space3),
        Material(
          color: CauceColors.bgCard,
          borderRadius: CauceRadii.borderMd,
          child: InkWell(
            key: const Key('profile_logout'),
            borderRadius: CauceRadii.borderMd,
            onTap: _loggingOut ? null : _logout,
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
                        Text(l10n.profileLogout, style: textTheme.bodyLarge),
                        Text(
                          l10n.profileLogoutHint,
                          style: textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                  if (_loggingOut)
                    const CauceLoadingIndicator.inline(
                      color: CauceColors.brandBase,
                    )
                  else
                    const Icon(TablerIcons.logout, size: 20),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
