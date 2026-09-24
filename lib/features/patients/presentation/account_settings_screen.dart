import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../core/router/app_routes.dart';
import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../../auth/application/session_notifier.dart';
import '../application/account_deletion_notifier.dart';
import '../application/data_export_notifier.dart';

/// Version y compilacion de la app, para la seccion "Sobre la app".
///
/// Provider aparte y no una lectura dentro de la pantalla: asi el test la
/// sustituye sin depender del canal de plataforma de `package_info_plus`, que
/// en un entorno de prueba no responde.
final appPackageInfoProvider = FutureProvider<PackageInfo>(
  (ref) => PackageInfo.fromPlatform(),
);

/// Configuracion de la cuenta (mockup 12b, P12-B).
///
/// Cinco secciones en el orden del mockup: notificaciones, derechos sobre los
/// datos, banderas rojas, sobre la app y cierre de sesion.
///
/// **Seis de las once filas van con guarda "Proximamente"**, y la guarda es
/// literal: `onTap` en `null`, etiqueta visible en la propia fila, y ningun
/// toque que simule una confirmacion. Una accion gris que igual responde con
/// un aviso de exito es peor que una deshabilitada, porque el paciente creeria
/// haber ejercido un derecho que la Ley N.° 29733 le reconoce y que el sistema
/// todavia no puede atender.
///
/// **Privacidad no se absorbe.** `PrivacyScreen` conserva su ruta y su
/// pantalla; la fila "Tu consentimiento y tus datos" la enlaza.
class AccountSettingsScreen extends ConsumerWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.settingsTitle, showBackButton: true),
      scrollable: true,
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _NotificationsSection(),
          SizedBox(height: CauceSpacing.space6),
          _RightsSection(),
          SizedBox(height: CauceSpacing.space6),
          _RedFlagsSection(),
          SizedBox(height: CauceSpacing.space6),
          _AboutSection(),
          SizedBox(height: CauceSpacing.space6),
          _LogoutSection(),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// 1. Notificaciones
// ---------------------------------------------------------------------------

/// Los dos avisos del mockup, los dos con guarda.
///
/// **Sin estado local a proposito.** Un switch que se mueve y recuerda su
/// posicion sin nada detras es la confirmacion falsa que la condicion prohibe:
/// el paciente creeria haber configurado algo. Van fijos y apagados.
///
/// No hay historia de usuario que los respalde: el backlog tiene HU0012 y
/// HU0014, que son de **recibir** una notificacion, no de configurarlas.
class _NotificationsSection extends StatelessWidget {
  const _NotificationsSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _Section(
      title: l10n.settingsNotificationsSection,
      children: <Widget>[
        _SettingsRow(
          rowKey: const Key('settings_notif_assessment'),
          icon: TablerIcons.calendar_repeat,
          title: l10n.settingsNotifAssessmentTitle,
          body: l10n.settingsNotifAssessmentBody,
          comingSoon: true,
          trailing: const _DeadSwitch(),
        ),
        _SettingsRow(
          rowKey: const Key('settings_notif_advice'),
          icon: TablerIcons.bulb,
          title: l10n.settingsNotifAdviceTitle,
          body: l10n.settingsNotifAdviceBody,
          comingSoon: true,
          trailing: const _DeadSwitch(),
        ),
      ],
    );
  }
}

/// Interruptor apagado que no responde al toque.
///
/// `onChanged` en `null` y no un `setState`: es lo que lo deja inerte de
/// verdad, y lo que impide que el gesto insinue que algo quedo guardado.
class _DeadSwitch extends StatelessWidget {
  const _DeadSwitch();

  @override
  Widget build(BuildContext context) {
    return const ExcludeSemantics(
      child: Switch(value: false, onChanged: null),
    );
  }
}

// ---------------------------------------------------------------------------
// 2. Mis derechos sobre mis datos
// ---------------------------------------------------------------------------

class _RightsSection extends ConsumerWidget {
  const _RightsSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final export = ref.watch(dataExportNotifierProvider);
    final deletion = ref.watch(accountDeletionNotifierProvider);
    final failure = export.error ?? deletion.error;

    return _Section(
      title: l10n.settingsRightsSection,
      intro: l10n.settingsRightsIntro,
      children: <Widget>[
        if (failure != null) ...<Widget>[
          CauceErrorBanner(key: const Key('settings_error'), error: failure),
          const SizedBox(height: CauceSpacing.space3),
        ],
        _SettingsRow(
          rowKey: const Key('settings_export'),
          icon: TablerIcons.download,
          title: l10n.settingsExportTitle,
          body: l10n.settingsExportBody,
          busy: export.isRequesting,
          onTap: export.isRequesting ? null : () => _export(context, ref),
        ),
        _SettingsRow(
          rowKey: const Key('settings_delete'),
          icon: TablerIcons.trash,
          title: l10n.settingsDeleteTitle,
          body: l10n.settingsDeleteBody,
          destructive: true,
          busy: deletion.isDeleting,
          onTap: deletion.isDeleting ? null : () => _delete(context, ref),
        ),
        // Es edicion de perfil (HU0003 CA3 y HU0028 CA2), bloqueada hasta que
        // se corrija el dato de prueba de CP071.
        _SettingsRow(
          rowKey: const Key('settings_correct'),
          icon: TablerIcons.edit,
          title: l10n.settingsCorrectTitle,
          body: l10n.settingsCorrectBody,
          comingSoon: true,
        ),
        // Sin endpoint: el contrato no tiene nada de oposicion al tratamiento.
        _SettingsRow(
          rowKey: const Key('settings_object'),
          icon: TablerIcons.hand_stop,
          title: l10n.settingsObjectTitle,
          body: l10n.settingsObjectBody,
          comingSoon: true,
        ),
      ],
    );
  }

  /// CP064 paso 3: primero el aviso con el alcance, y recien al confirmar la
  /// llamada. Un toque no dispara la exportacion por su cuenta.
  Future<void> _export(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await CauceConfirmDialog.show(
      context,
      title: l10n.settingsExportConfirmTitle,
      message: l10n.settingsExportConfirmBody,
      confirmLabel: l10n.settingsExportConfirmAction,
      cancelLabel: l10n.commonCancel,
    );
    if (!confirmed || !context.mounted) {
      return;
    }

    final opened =
        await ref.read(dataExportNotifierProvider.notifier).request();
    if (!context.mounted) {
      return;
    }

    final state = ref.read(dataExportNotifierProvider);
    if (opened) {
      CauceToast.success(context, title: l10n.settingsExportOpened);
    } else if (state is DataExportNotOpened) {
      // El archivo existe y el enlace sigue vivo: no es un fallo, es que el
      // sistema no tenia con que abrirlo.
      CauceToast.info(context, title: l10n.settingsExportNotOpened);
    }
  }

  /// CP066 y CP067: un aviso siempre, y un segundo aviso adicional cuando hay
  /// piloto clinico activo. La baja se ejecuta recien tras el ultimo.
  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final l10n = AppLocalizations.of(context);

    final first = await CauceConfirmDialog.show(
      context,
      title: l10n.settingsDeleteConfirmTitle,
      message: l10n.settingsDeleteConfirmBody,
      confirmLabel: l10n.settingsDeleteConfirmAction,
      cancelLabel: l10n.commonCancel,
    );
    if (!first || !context.mounted) {
      return;
    }

    // El estado de piloto ya viaja en el snapshot de sesion desde Mobile-1b.
    // No se consulta de nuevo ni se deduce de otra cosa.
    final inPilot =
        ref.read(sessionNotifierProvider).user?.isInActivePilot ?? false;

    if (inPilot) {
      final second = await CauceConfirmDialog.show(
        context,
        title: l10n.settingsDeletePilotTitle,
        message: l10n.settingsDeletePilotBody,
        confirmLabel: l10n.settingsDeletePilotAction,
        cancelLabel: l10n.commonCancel,
      );
      // CP067 paso 5: cerrar el aviso sin la confirmacion adicional deja la
      // cuenta activa y no ejecuta nada.
      if (!second || !context.mounted) {
        return;
      }
    }

    final deleted = await ref
        .read(accountDeletionNotifierProvider.notifier)
        .delete(activePilotAcknowledged: inPilot);

    // Sin navegacion propia: el guard del router lleva al login en cuanto la
    // sesion pasa a no autenticada.
    if (deleted && context.mounted) {
      CauceToast.success(context, title: l10n.settingsDeleteDone);
    }
  }
}

// ---------------------------------------------------------------------------
// 3. Banderas rojas
// ---------------------------------------------------------------------------

/// Contenido educativo, visible sin toque adicional.
///
/// El mockup lo justifica: si es informacion que puede salvar al paciente, no
/// debe exigir un toque mas para verla. Sin iconos de alarma ni rojos
/// saturados, con el mismo criterio del resto de la app.
class _RedFlagsSection extends StatelessWidget {
  const _RedFlagsSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    final flags = <String>[
      l10n.settingsRedFlagBlood,
      l10n.settingsRedFlagVomiting,
      l10n.settingsRedFlagWeightLoss,
      l10n.settingsRedFlagFever,
      l10n.settingsRedFlagPain,
      l10n.settingsRedFlagStool,
    ];

    return _Section(
      title: l10n.settingsRedFlagsSection,
      intro: l10n.settingsRedFlagsIntro,
      children: <Widget>[
        Container(
          key: const Key('settings_red_flags'),
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
              for (final flag in flags)
                Padding(
                  padding: const EdgeInsets.only(bottom: CauceSpacing.space2),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Icon(
                          TablerIcons.point_filled,
                          size: 10,
                          color: CauceColors.brandBase,
                        ),
                      ),
                      const SizedBox(width: CauceSpacing.space2),
                      Expanded(
                        child: Text(flag, style: textTheme.bodyMedium),
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: CauceSpacing.space2),
              Container(
                padding: const EdgeInsets.all(CauceSpacing.space3),
                decoration: const BoxDecoration(
                  color: CauceColors.brandSoft,
                  borderRadius: CauceRadii.borderMd,
                ),
                child: Row(
                  children: <Widget>[
                    const Icon(
                      TablerIcons.phone,
                      size: 18,
                      color: CauceColors.brandBase,
                    ),
                    const SizedBox(width: CauceSpacing.space2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            l10n.settingsEmergencyLabel,
                            style: textTheme.labelSmall,
                          ),
                          Text(
                            l10n.settingsEmergencyValue,
                            style: textTheme.bodyLarge?.copyWith(
                              color: CauceColors.brandStrong,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 4. Sobre la app
// ---------------------------------------------------------------------------

class _AboutSection extends ConsumerWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final info = ref.watch(appPackageInfoProvider);

    return _Section(
      title: l10n.settingsAboutSection,
      children: <Widget>[
        // Sin documento legal propio todavia.
        _SettingsRow(
          rowKey: const Key('settings_terms'),
          icon: TablerIcons.file_text,
          title: l10n.settingsTerms,
          comingSoon: true,
        ),
        // El mockup la llama "Politica de privacidad". El destino real es la
        // pantalla de Privacidad ya construida, que muestra y descarga el
        // consentimiento aceptado, asi que la fila se renombra para no
        // prometer un documento que no existe.
        _SettingsRow(
          rowKey: const Key('settings_privacy'),
          icon: TablerIcons.shield_lock,
          title: l10n.settingsPrivacyPolicy,
          body: l10n.settingsPrivacyPolicyHint,
          onTap: () => context.push(AppRoutes.profilePrivacy),
        ),
        _SettingsRow(
          rowKey: const Key('settings_version'),
          icon: TablerIcons.info_circle,
          title: l10n.settingsVersion,
          // Sin chevron ni toque: es un dato, no una navegacion.
          trailing: Text(
            info.maybeWhen(
              data: (value) =>
                  l10n.settingsVersionValue(value.version, value.buildNumber),
              orElse: () => '—',
            ),
            key: const Key('settings_version_value'),
            style: textTheme.labelMedium,
          ),
        ),
        const SizedBox(height: CauceSpacing.space4),
        Text(
          l10n.settingsCredits,
          key: const Key('settings_credits'),
          style: textTheme.labelSmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// 5. Cerrar sesion
// ---------------------------------------------------------------------------

/// Reutiliza el flujo de Perfil: confirmacion y `SessionNotifier.logout()`.
class _LogoutSection extends ConsumerStatefulWidget {
  const _LogoutSection();

  @override
  ConsumerState<_LogoutSection> createState() => _LogoutSectionState();
}

class _LogoutSectionState extends ConsumerState<_LogoutSection> {
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
    await ref.read(sessionNotifierProvider.notifier).logout();
    if (mounted) {
      setState(() => _loggingOut = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return _Section(
      title: l10n.profileSessionSection,
      children: <Widget>[
        _SettingsRow(
          rowKey: const Key('settings_logout'),
          icon: TablerIcons.logout,
          title: l10n.profileLogout,
          body: l10n.profileLogoutHint,
          destructive: true,
          busy: _loggingOut,
          onTap: _loggingOut ? null : _logout,
        ),
      ],
    );
  }
}

// ---------------------------------------------------------------------------
// Piezas compartidas
// ---------------------------------------------------------------------------

/// Encabezado de seccion, con su introduccion opcional.
class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.children,
    this.intro,
  });

  final String title;
  final String? intro;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final lead = intro;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(title, style: textTheme.titleMedium),
        if (lead != null) ...<Widget>[
          const SizedBox(height: CauceSpacing.space2),
          Text(lead, style: textTheme.bodyMedium),
        ],
        const SizedBox(height: CauceSpacing.space3),
        ...children,
      ],
    );
  }
}

/// Fila de configuracion: icono, titulo, aclaracion y algo a la derecha.
///
/// Con [comingSoon] queda **inerte**: sin `onTap`, con la etiqueta visible en
/// la fila y en tono terciario. La etiqueta no va en un tooltip porque un
/// tooltip no existe para quien toca con el dedo.
class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.rowKey,
    required this.icon,
    required this.title,
    this.body,
    this.onTap,
    this.trailing,
    this.comingSoon = false,
    this.destructive = false,
    this.busy = false,
  });

  final Key rowKey;
  final IconData icon;
  final String title;
  final String? body;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool comingSoon;
  final bool destructive;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final hint = body;

    final titleColor = comingSoon
        ? CauceColors.textTertiary
        : (destructive ? CauceColors.fodmapHighText : CauceColors.textPrimary);

    final Widget? right = busy
        ? const CauceLoadingIndicator.inline(color: CauceColors.brandBase)
        : trailing ??
            (onTap == null
                ? null
                : const Icon(TablerIcons.chevron_right, size: 20));

    final content = Container(
      constraints: const BoxConstraints(minHeight: CauceSizes.touchTargetMin),
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
          Icon(
            icon,
            size: 20,
            color:
                comingSoon ? CauceColors.textTertiary : CauceColors.brandBase,
          ),
          const SizedBox(width: CauceSpacing.space3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: textTheme.bodyLarge?.copyWith(color: titleColor),
                ),
                if (hint != null) Text(hint, style: textTheme.labelSmall),
                if (comingSoon) ...<Widget>[
                  const SizedBox(height: CauceSpacing.space2),
                  CauceBadge(
                    label: l10n.settingsComingSoon,
                    icon: TablerIcons.clock,
                    tone: CauceBadgeTone.neutral,
                    compact: true,
                  ),
                ],
              ],
            ),
          ),
          if (right != null) ...<Widget>[
            const SizedBox(width: CauceSpacing.space3),
            right,
          ],
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: CauceSpacing.space3),
      child: Material(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderMd,
        child: InkWell(
          key: rowKey,
          borderRadius: CauceRadii.borderMd,
          // `null` cuando la fila esta con guarda. Es lo que la deja
          // deshabilitada de verdad y no solo gris.
          onTap: onTap,
          child: content,
        ),
      ),
    );
  }
}
