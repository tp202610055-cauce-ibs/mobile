import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../../core/theme/design_tokens.dart';
import '../../../core/widgets/widgets.dart';
import '../../../l10n/generated/app_localizations.dart';
import '../application/clinical_report_notifier.dart';

/// Reporte clinico personal (HU0024, CP062 y CP063).
///
/// **Sin mockup.** Es la segunda pantalla del proyecto construida sin uno,
/// despues de Evolucion: `docs/03-mockups/mobile/` cierra en 12b y el design
/// system no tiene seccion para reportes. La estructura sale de CP062, cuyo
/// paso 3 pide "el formulario de generacion del reporte personal".
///
/// **Lo que la pantalla afirma y lo que no.** El backend cifra el PDF y manda
/// la contraseña en un correo aparte, **despues** de haber respondido 200; si
/// ese envio falla solo lo registra en su log y el movil no se entera. Por eso
/// el estado de exito afirma unicamente lo que el servidor confirmo (el
/// reporte existe, el enlace vive 24 horas) y describe el correo como el paso
/// esperado, nunca como un hecho.
class ClinicalReportScreen extends ConsumerStatefulWidget {
  const ClinicalReportScreen({super.key});

  @override
  ConsumerState<ClinicalReportScreen> createState() =>
      _ClinicalReportScreenState();
}

class _ClinicalReportScreenState extends ConsumerState<ClinicalReportScreen> {
  /// Periodo elegido. Arranca en 30 dias.
  ClinicalReportPeriod _period = ClinicalReportPeriod.last30;

  Future<void> _generate() async {
    final l10n = AppLocalizations.of(context);
    final generated =
        await ref.read(clinicalReportNotifierProvider.notifier).generate(
              _period,
            );

    if (!generated || !mounted) {
      return;
    }

    final state = ref.read(clinicalReportNotifierProvider);
    if (state is ClinicalReportReady && !state.openedDownload) {
      // El reporte existe y el enlace sigue vivo: lo que fallo fue abrir el
      // navegador. Se dice sin llamarlo error, y el boton queda a mano.
      CauceToast.info(context, title: l10n.reportNotOpened);
    }
  }

  Future<void> _openDownload() async {
    final l10n = AppLocalizations.of(context);
    final opened =
        await ref.read(clinicalReportNotifierProvider.notifier).openDownload();

    if (!mounted) {
      return;
    }
    if (opened) {
      CauceToast.success(context, title: l10n.reportOpened);
    } else {
      CauceToast.info(context, title: l10n.reportNotOpened);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final state = ref.watch(clinicalReportNotifierProvider);
    final busy = state.isGenerating;

    return CauceScaffold(
      appBar: CauceAppBar(title: l10n.reportTitle, showBackButton: true),
      scrollable: true,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(l10n.reportIntro, style: textTheme.bodyMedium),
          const SizedBox(height: CauceSpacing.space6),
          CauceChoiceField<ClinicalReportPeriod>(
            key: const Key('report_period'),
            label: l10n.reportPeriodLabel,
            value: _period,
            // Cambiar de periodo mientras se genera dejaria al paciente
            // creyendo que pidio otra cosa de la que esta en vuelo.
            onChanged: busy ? null : (value) => setState(() => _period = value),
            choices: <CauceChoice<ClinicalReportPeriod>>[
              CauceChoice<ClinicalReportPeriod>(
                value: ClinicalReportPeriod.last30,
                label: l10n.reportPeriodLast30,
              ),
              CauceChoice<ClinicalReportPeriod>(
                value: ClinicalReportPeriod.last90,
                label: l10n.reportPeriodLast90,
              ),
            ],
          ),
          const SizedBox(height: CauceSpacing.space6),
          CauceButton(
            key: const Key('report_submit'),
            label: l10n.reportSubmit,
            loading: busy,
            // `null` mientras hay una solicitud en vuelo: un doble toque
            // generaria dos reportes, con dos contraseñas y cuatro correos.
            onPressed: busy ? null : _generate,
          ),
          if (busy) ...<Widget>[
            const SizedBox(height: CauceSpacing.space3),
            Text(
              l10n.reportGenerating,
              key: const Key('report_generating'),
              style: textTheme.labelSmall,
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: CauceSpacing.space6),
          switch (state) {
            ClinicalReportReady(:final report) => _ReadyCard(
                expiresAt: report.expiresAt,
                onOpen: _openDownload,
              ),
            ClinicalReportNoData() => const _NoDataCard(),
            ClinicalReportFailure(:final error) =>
              CauceErrorBanner(key: const Key('report_error'), error: error),
            _ => const SizedBox.shrink(),
          },
        ],
      ),
    );
  }
}

/// Estado de exito, con lo que el servidor si confirmo.
class _ReadyCard extends StatelessWidget {
  const _ReadyCard({required this.expiresAt, required this.onOpen});

  final DateTime expiresAt;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: const Key('report_ready'),
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
          Row(
            children: <Widget>[
              const Icon(
                TablerIcons.file_check,
                size: 20,
                color: CauceColors.successText,
              ),
              const SizedBox(width: CauceSpacing.space2),
              Expanded(
                child: Text(
                  l10n.reportReadyTitle,
                  style: textTheme.titleMedium,
                ),
              ),
            ],
          ),
          const SizedBox(height: CauceSpacing.space2),
          Text(l10n.reportReadyBody, style: textTheme.bodyMedium),
          const SizedBox(height: CauceSpacing.space3),
          // El aviso de la contraseña va en tono informativo y no de exito:
          // describe lo que deberia pasar, no lo que el servidor confirmo.
          Container(
            padding: const EdgeInsets.all(CauceSpacing.space3),
            decoration: const BoxDecoration(
              color: CauceColors.infoBg,
              borderRadius: CauceRadii.borderMd,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.reportReadyPassword,
                  key: const Key('report_password_note'),
                  style: textTheme.bodyMedium
                      ?.copyWith(color: CauceColors.infoText),
                ),
                const SizedBox(height: CauceSpacing.space2),
                Text(
                  l10n.reportReadyRetryHint,
                  key: const Key('report_retry_hint'),
                  style: textTheme.labelSmall
                      ?.copyWith(color: CauceColors.infoText),
                ),
              ],
            ),
          ),
          const SizedBox(height: CauceSpacing.space4),
          CauceButton.secondary(
            key: const Key('report_open_download'),
            label: l10n.reportOpenDownload,
            onPressed: onOpen,
          ),
        ],
      ),
    );
  }
}

/// CP063: el periodo no tiene registros.
///
/// No usa [CauceErrorBanner] a proposito. El servidor se nego a generar un PDF
/// vacio, que es lo correcto; presentarlo como un fallo haria pensar al
/// paciente que algo se rompio.
class _NoDataCard extends StatelessWidget {
  const _NoDataCard();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;

    return Container(
      key: const Key('report_no_data'),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: const BoxDecoration(
        color: CauceColors.warningBg,
        borderRadius: CauceRadii.borderMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            TablerIcons.calendar_question,
            size: 20,
            color: CauceColors.warningText,
          ),
          const SizedBox(width: CauceSpacing.space2),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.errorPatientHasNoDataInPeriod,
                  style: textTheme.bodyMedium
                      ?.copyWith(color: CauceColors.warningText),
                ),
                const SizedBox(height: CauceSpacing.space1),
                Text(
                  l10n.reportNoDataHint,
                  key: const Key('report_no_data_hint'),
                  style: textTheme.labelSmall
                      ?.copyWith(color: CauceColors.warningText),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
