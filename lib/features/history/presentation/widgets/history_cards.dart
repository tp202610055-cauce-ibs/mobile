import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/design_tokens.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../../foods/domain/food_item.dart';
import '../../../meals/presentation/widgets/meal_labels.dart';
import '../../../symptoms/presentation/widgets/symptom_labels.dart';
import '../../domain/history_entry.dart';

/// Badge del estado de sincronizacion (seccion F del design system).
///
/// El design system define dos estados, pendiente y sincronizado. El tercero,
/// `failed`, lo estreno el acta M34 y **no existe en el catalogo**: se diseno
/// aca siguiendo la misma forma (icono mas texto, fondo semantico, nunca solo
/// color) con la familia de la nube y el registro de peligro.
///
/// Se dibuja **siempre**, tambien cuando esta sincronizado. Un badge que solo
/// aparece cuando algo va mal obliga al paciente a deducir el estado bueno de
/// una ausencia.
CauceBadge _syncBadge(AppLocalizations l10n, HistoryEntrySyncState state) {
  return switch (state) {
    HistoryEntrySyncState.pending => CauceBadge(
        label: l10n.historySyncPending,
        icon: TablerIcons.cloud_upload,
        tone: CauceBadgeTone.info,
        compact: true,
      ),
    HistoryEntrySyncState.synced => CauceBadge(
        label: l10n.historySyncDone,
        icon: TablerIcons.cloud_check,
        tone: CauceBadgeTone.success,
        compact: true,
      ),
    HistoryEntrySyncState.failed => CauceBadge(
        label: l10n.historySyncFailed,
        icon: TablerIcons.cloud_x,
        tone: CauceBadgeTone.danger,
        compact: true,
      ),
  };
}

/// Registro del badge de intensidad de un sintoma.
///
/// **La regla se declara aca a proposito.** El design system solo da un
/// ejemplo, "Intensidad 60" en ambar, y no publica los cortes. Se fijan en
/// tercios de la escala 1 a 100 que usa el instrumento.
///
/// El tramo bajo va en **gris y no en verde**. Verde felicitaria al paciente
/// por un dia de poco dolor, que es un juicio clinico que la app no esta en
/// condiciones de hacer y que contradice el encuadre neutro con el que se
/// dibujo la evolucion del IBS-SSS. Gris registra el dato sin opinar. Ambar y
/// rojo si escalan, porque escalan sobre lo que el propio paciente reporto.
CauceBadgeTone intensityTone(int intensity) {
  if (intensity <= 33) {
    return CauceBadgeTone.neutral;
  }
  if (intensity <= 66) {
    return CauceBadgeTone.warning;
  }
  return CauceBadgeTone.danger;
}

/// Registro del badge de carga FODMAP, tal como lo fija la seccion F.
///
/// Acá el color si valora, y corresponde: califica al alimento, no al
/// paciente.
({CauceBadgeTone tone, IconData icon, String label}) _fodmap(
  AppLocalizations l10n,
  FodmapLoad load,
) {
  return switch (load) {
    FodmapLoad.low => (
        tone: CauceBadgeTone.success,
        icon: TablerIcons.leaf,
        label: l10n.historyFodmapLow,
      ),
    FodmapLoad.moderate => (
        tone: CauceBadgeTone.warning,
        icon: TablerIcons.alert_triangle,
        label: l10n.historyFodmapModerate,
      ),
    FodmapLoad.high => (
        tone: CauceBadgeTone.danger,
        icon: TablerIcons.circle_x,
        label: l10n.historyFodmapHigh,
      ),
  };
}

/// Formatea la distancia entre la comida y el sintoma.
String formatDelay(AppLocalizations l10n, Duration delay) {
  final minutes = delay.inMinutes.abs();
  final hours = minutes ~/ 60;
  return hours == 0
      ? l10n.historyDelayMinutes(minutes)
      : l10n.historyDelayHoursMinutes(hours, minutes % 60);
}

/// Tarjeta de una entrada del diario (seccion G del design system).
///
/// Una sola clase para comida y sintoma porque comparten el 80 por ciento: el
/// encabezado con icono, etiqueta, hora y badge de sincronizacion, y el pie
/// con las acciones. Lo que cambia es el cuerpo y el acento lateral.
class HistoryCard extends StatelessWidget {
  const HistoryCard({
    required this.entry,
    required this.onDiscard,
    required this.onAddNote,
    super.key,
  });

  final HistoryEntry entry;
  final VoidCallback? onDiscard;
  final VoidCallback onAddNote;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isSymptom = entry.kind == HistoryEntryKind.symptom;
    final accent = _accent;

    return Container(
      margin: const EdgeInsets.only(bottom: CauceSpacing.space3),
      padding: const EdgeInsets.all(CauceSpacing.space4),
      decoration: BoxDecoration(
        color: CauceColors.bgCard,
        borderRadius: CauceRadii.borderLg,
        border: Border(
          top: _side,
          right: _side,
          bottom: _side,
          // La tarjeta de sintoma lleva un acento lateral de 4, que es lo que
          // la distingue de un vistazo dentro de una lista mezclada.
          left: isSymptom && accent != null
              ? BorderSide(color: accent, width: 4)
              : _side,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _Header(entry: entry),
          ..._body(context, l10n, textTheme),
          ..._actions(l10n, textTheme),
        ],
      ),
    );
  }

  static const BorderSide _side = BorderSide(
    color: CauceColors.bgDivider,
    width: CauceBorders.subtle,
  );

  /// Color del acento lateral del sintoma, segun su intensidad.
  Color? get _accent {
    final value = entry.intensity;
    if (entry.kind != HistoryEntryKind.symptom || value == null) {
      return null;
    }
    return switch (intensityTone(value)) {
      CauceBadgeTone.warning => CauceColors.warningText,
      CauceBadgeTone.danger => CauceColors.dangerText,
      _ => CauceColors.bgDivider,
    };
  }

  List<Widget> _body(
    BuildContext context,
    AppLocalizations l10n,
    TextTheme textTheme,
  ) {
    return switch (entry.kind) {
      HistoryEntryKind.meal => _mealBody(l10n, textTheme),
      HistoryEntryKind.symptom => _symptomBody(l10n, textTheme),
    };
  }

  List<Widget> _mealBody(AppLocalizations l10n, TextTheme textTheme) {
    final fodmap = entry.aggregatedFodmap;

    return <Widget>[
      if (entry.itemNames.isNotEmpty) ...<Widget>[
        const SizedBox(height: CauceSpacing.space1),
        Text(entry.itemNames.join(' · '), style: textTheme.bodyMedium),
      ],
      if (fodmap != null) ...<Widget>[
        const SizedBox(height: CauceSpacing.space2),
        Builder(
          builder: (BuildContext context) {
            final spec = _fodmap(l10n, fodmap);
            return Align(
              alignment: Alignment.centerLeft,
              child: CauceBadge(
                key: const Key('history_fodmap_badge'),
                label: spec.label,
                icon: spec.icon,
                tone: spec.tone,
                compact: true,
              ),
            );
          },
        ),
      ],
    ];
  }

  List<Widget> _symptomBody(AppLocalizations l10n, TextTheme textTheme) {
    final mealTime = entry.associatedMealTime;
    final delay = entry.associatedMealDelay;

    return <Widget>[
      // La asociacion la resolvio el servidor (DEC-B3-06). El cliente no
      // calcula la ventana de cuatro horas: solo muestra lo confirmado.
      if ((entry.hasMealAssociation ?? false) &&
          mealTime != null &&
          delay != null) ...<Widget>[
        const SizedBox(height: CauceSpacing.space2),
        Row(
          key: const Key('history_meal_associated'),
          children: <Widget>[
            const Icon(
              TablerIcons.arrow_up,
              size: 14,
              color: CauceColors.textTertiary,
            ),
            const SizedBox(width: CauceSpacing.space1),
            Flexible(
              child: Text(
                l10n.historyMealAssociatedWith(
                  MealLabels.mealTime(l10n, mealTime).toLowerCase(),
                  formatDelay(l10n, delay),
                ),
                style: textTheme.bodySmall?.copyWith(
                  color: CauceColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ] else if (entry.hasMealAssociation ?? false) ...<Widget>[
        // El servidor confirmo la asociacion pero la comida no esta en el
        // rango cargado. Se dice lo que se sabe, sin inventar cual fue.
        const SizedBox(height: CauceSpacing.space2),
        Text(
          l10n.historyMealAssociated,
          key: const Key('history_meal_associated_generic'),
          style: textTheme.bodySmall?.copyWith(
            color: CauceColors.textSecondary,
          ),
        ),
      ],
    ];
  }

  /// Acciones que ya existian antes de Mobile-3.1 y que no se pierden al
  /// partir la tarjeta: descartar una fila terminal y adjuntarle una nota.
  List<Widget> _actions(AppLocalizations l10n, TextTheme textTheme) {
    return <Widget>[
      // Una fila terminal necesita una salida, no solo un cartel: sin el
      // descarte el atasco se vuelve visible pero no se resuelve (acta M34).
      if (entry.isDiscardable) ...<Widget>[
        const SizedBox(height: CauceSpacing.space2),
        Text(l10n.historyFailedExplanation, style: textTheme.bodySmall),
        const SizedBox(height: CauceSpacing.space1),
        Align(
          alignment: Alignment.centerLeft,
          child: CauceButton.tertiary(
            key: const Key('history_discard'),
            label: l10n.historyDiscard,
            onPressed: onDiscard,
          ),
        ),
      ],
      const SizedBox(height: CauceSpacing.space1),
      // US13 exige un mealId o symptomId **del servidor**. Sin sincronizar no
      // existe, y dejar el boton activo llevaria a un 404 despues de escribir
      // la nota.
      if (entry.acceptsNote)
        Align(
          alignment: Alignment.centerLeft,
          child: CauceButton.tertiary(
            key: const Key('history_add_note'),
            label: l10n.historyAddNote,
            onPressed: onAddNote,
          ),
        )
      else
        Text(
          l10n.historyNoteUnavailable,
          key: const Key('history_note_unavailable'),
          style: textTheme.labelSmall?.copyWith(
            color: CauceColors.textTertiary,
          ),
        ),
    ];
  }
}

/// Encabezado comun: icono del tipo, etiqueta, hora y estado.
class _Header extends StatelessWidget {
  const _Header({required this.entry});

  final HistoryEntry entry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final textTheme = Theme.of(context).textTheme;
    final isSymptom = entry.kind == HistoryEntryKind.symptom;
    final intensity = entry.intensity;

    // Hora corta y en el locale de la aplicacion. Antes se imprimia la fecha
    // completa en cada fila, en el locale del sistema: en un telefono en
    // ingles salia "Sep 18, 2026 13:00". La fecha ahora encabeza el grupo.
    final time = DateFormat.jm(
      Localizations.localeOf(context).toLanguageTag(),
    ).format(entry.occurredAt.toLocal());

    return Row(
      children: <Widget>[
        Icon(
          isSymptom ? TablerIcons.activity : TablerIcons.bowl,
          size: 18,
          color: isSymptom ? CauceColors.warningText : CauceColors.brandBase,
        ),
        const SizedBox(width: CauceSpacing.space2),
        Flexible(
          child: Text(
            _title(l10n),
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium?.copyWith(
              color: CauceColors.textSecondary,
            ),
          ),
        ),
        const SizedBox(width: CauceSpacing.space2),
        Text(
          time,
          style: textTheme.labelSmall?.copyWith(
            color: CauceColors.textTertiary,
          ),
        ),
        const Spacer(),
        if (isSymptom && intensity != null)
          Padding(
            padding: const EdgeInsets.only(right: CauceSpacing.space2),
            child: CauceBadge(
              key: const Key('history_intensity_badge'),
              label: l10n.historyIntensityBadge(intensity),
              icon: TablerIcons.wave_saw_tool,
              tone: intensityTone(intensity),
              compact: true,
            ),
          ),
        _syncBadge(l10n, entry.syncState),
      ],
    );
  }

  String _title(AppLocalizations l10n) {
    return switch (entry.kind) {
      HistoryEntryKind.meal => entry.mealTime == null
          ? l10n.mealsTitle
          : MealLabels.mealTime(l10n, entry.mealTime!),
      HistoryEntryKind.symptom => entry.symptomType == null
          ? l10n.symptomsTitle
          : SymptomLabels.symptomType(l10n, entry.symptomType!),
    };
  }
}
