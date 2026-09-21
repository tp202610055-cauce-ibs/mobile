import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../features/history/application/history_notifier.dart';
import '../../features/ibs_sss/application/periodic_assessment_notifier.dart';
import '../../features/onboarding/application/onboarding_notifier.dart';
import '../../l10n/generated/app_localizations.dart';
import '../widgets/widgets.dart';
import 'app_routes.dart';

/// Cuanto sobresale el FAB por encima de la barra, con su borde de recorte.
const double _fabOverhang = 32;

/// Indice de cada rama del shell, en el orden en que se declaran.
///
/// Se nombran porque `goBranch(2)` no dice nada y `goBranch(ShellBranch.advice)`
/// si. El orden es el del design system: Inicio, Diario, Consejos, Perfil, con
/// el FAB recortado entre Diario y Consejos.
abstract final class ShellBranch {
  static const int home = 0;
  static const int journal = 1;
  static const int advice = 2;
  static const int profile = 3;
}

/// Andamio de las cuatro pestanas (seccion H del design system).
///
/// Monta la barra inferior y el FAB central sobre el `StatefulShellRoute`, de
/// modo que cada rama conserva su propia pila y su estado al cambiar de
/// pestana: volver al Diario despues de pasar por Perfil devuelve la lista
/// donde estaba, no recargada desde cero.
///
/// **No usa [CauceScaffold].** Ese atomo aporta el fondo, el area segura y el
/// ancho de lectura de una pantalla, y cada pestana ya lo monta por su cuenta.
/// El shell solo aporta el cascaron con la barra y el boton.
class AppShell extends ConsumerWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);

    return PopScope(
      // El retroceso lo resuelve `_handlePop` en los tres casos, asi que nunca
      // se deja que el marco lo haga solo.
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (didPop) {
          return;
        }
        _handlePop(context);
      },
      child: Scaffold(
        // El FAB esta anclado al centro de la barra y sobresale 28 hacia
        // arriba, encima del cuerpo. Sin este respiro, lo que quede al pie de
        // una pestana cae debajo del boton y **no se puede tocar**: el cierre
        // de sesion de Perfil aterrizaba exactamente ahi. Se reserva en el
        // shell y no en cada pantalla para que ninguna futura lo olvide.
        // **Sin transicion entre pestanas, a proposito.**
        //
        // Se probo un `AnimatedSwitcher` con la rama activa como clave, que
        // es el contenedor sencillo que pedia el pedido. No sirve: al cambiar
        // la clave, el shell reconstruye la rama entera y se pierde el estado
        // que el `indexedStack` existe para conservar, con lo que el Diario
        // volveria a cargar en cada visita. Hacerlo bien exige un controlador
        // de animacion propio en un `StatefulWidget`, que es mas que un
        // contenedor, asi que queda fuera del bloque y anotado.
        body: Padding(
          padding: const EdgeInsets.only(bottom: _fabOverhang),
          child: navigationShell,
        ),
        floatingActionButton: CauceExpandableFab(
          actions: _quickActions(context, ref, l10n),
          openLabel: l10n.fabQuickAction,
          closeLabel: l10n.fabCloseMenu,
        ),
        floatingActionButtonLocation:
            FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: CauceBottomNav(
          currentIndex: navigationShell.currentIndex,
          onSelected: (int index) => _select(ref, index),
          items: <CauceBottomNavItem>[
            CauceBottomNavItem(
              label: l10n.navHome,
              icon: TablerIcons.home,
              itemKey: const Key('nav_home'),
            ),
            CauceBottomNavItem(
              label: l10n.navJournal,
              icon: TablerIcons.notebook,
              itemKey: const Key('nav_journal'),
            ),
            CauceBottomNavItem(
              label: l10n.navAdvice,
              icon: TablerIcons.bulb,
              itemKey: const Key('nav_advice'),
            ),
            CauceBottomNavItem(
              label: l10n.navProfile,
              icon: TablerIcons.user,
              itemKey: const Key('nav_profile'),
            ),
          ],
        ),
      ),
    );
  }

  /// Acciones del menu del FAB, en el orden de la seccion H.
  ///
  /// El cuestionario va arriba porque es el unico con ventana: si toca
  /// responderlo, es lo mas urgente de las tres. Registrar comida queda abajo,
  /// pegado al pulgar, porque es lo mas frecuente.
  ///
  /// Se arman aca, dentro del arbol de widgets, y no en el provider del
  /// router: dependen del ciclo del cuestionario, que cambia a menudo, y
  /// observarlo desde el provider reconstruiria el `GoRouter` entero y le
  /// reiniciaria la navegacion al paciente.
  ///
  /// **Ninguna accion restringida queda muda.** Las que no aplican conservan
  /// su lugar y explican por que, y cuando la salida es completar el
  /// onboarding, tocarlas lleva ahi.
  List<CauceFabAction> _quickActions(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    final onboarding = ref.watch(resolvedOnboardingProvider);
    final latest = ref.watch(latestIbsSssAssessmentProvider).valueOrNull;
    final canLog = onboarding.allowsJournal;

    void resumeOnboarding() =>
        ref.read(onboardingNotifierProvider.notifier).resume();

    // Tres estados del cuestionario. El tercero, "todavia no toca", es una
    // restriccion **del cliente**: verificado contra el backend, un periodico
    // enviado antes de tiempo se acepta, incrementa el ciclo y reagenda. El
    // instrumento mide sobre catorce dias y responderlo antes ensucia la
    // serie, asi que el movil lo frena y queda pedido al backend que lo
    // rechace del lado servidor (acta M38).
    final (VoidCallback? ibsSssAction, String? ibsSssHint) = switch (latest) {
      _ when !onboarding.allowsAdvice && !canLog => (
          resumeOnboarding,
          l10n.fabHintCompleteProfile,
        ),
      _ when !onboarding.allowsAdvice => (
          resumeOnboarding,
          l10n.fabHintBaselinePending,
        ),
      null => (null, null),
      final summary when summary.isDue() => (
          () => context.push(AppRoutes.ibsSssPeriodic),
          null,
        ),
      final summary => (
          null,
          summary.nextAssessmentDate == null
              ? null
              : l10n.fabHintNotDue(
                  DateFormat.yMd(
                    Localizations.localeOf(context).toLanguageTag(),
                  ).format(summary.nextAssessmentDate!.toLocal()),
                ),
        ),
    };

    return <CauceFabAction>[
      CauceFabAction(
        label: l10n.fabIbsSss,
        icon: TablerIcons.clipboard_text,
        actionKey: const Key('fab_ibs_sss'),
        onPressed: ibsSssAction,
        hint: ibsSssHint,
      ),
      CauceFabAction(
        label: l10n.fabLogSymptom,
        icon: TablerIcons.activity,
        actionKey: const Key('fab_symptom'),
        onPressed: canLog
            ? () => _openForm(context, ref, AppRoutes.symptomNew)
            : resumeOnboarding,
        hint: canLog ? null : l10n.fabHintCompleteProfile,
      ),
      CauceFabAction(
        label: l10n.fabLogMeal,
        icon: TablerIcons.bowl,
        actionKey: const Key('fab_meal'),
        onPressed: canLog
            ? () => _openForm(context, ref, AppRoutes.mealNew)
            : resumeOnboarding,
        hint: canLog ? null : l10n.fabHintCompleteProfile,
      ),
    ];
  }

  /// Abre un formulario de registro y recarga el Diario al volver.
  ///
  /// El formulario vive sobre el navigator raiz, asi que la rama del Diario
  /// no se reconstruye sola cuando se cierra. Esperarlo y recargar es lo que
  /// hace que el registro recien guardado ya este en la lista.
  Future<void> _openForm(
    BuildContext context,
    WidgetRef ref,
    String route,
  ) async {
    await context.push<void>(route);
    await ref.read(historyNotifierProvider.notifier).load();
  }

  /// Cambia de pestana, o vuelve a la raiz de la actual si ya se esta en ella.
  ///
  /// `initialLocation: true` es lo que hace que tocar Perfil estando en
  /// `Perfil > Privacidad` devuelva a Perfil, que es lo que un paciente espera
  /// de tocar la pestana en la que ya esta.
  void _select(WidgetRef ref, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );

    // El `IndexedStack` mantiene viva cada rama, de modo que el `initState`
    // del Diario corre una sola vez, la primera. Sin este disparo, entrar a
    // la pestana despues de registrar algo muestra la lista de hace un rato
    // y obliga a tirar para refrescar, que es lo que paso en el celular.
    if (index == ShellBranch.journal) {
      unawaited(ref.read(historyNotifierProvider.notifier).load());
    }
  }

  /// Retroceso de Android, en tres escalones.
  ///
  /// Primero cualquier pantalla apilada dentro de la rama. Despues, desde la
  /// raiz de Diario, Consejos o Perfil, vuelve a Inicio. Solo en la raiz de
  /// Inicio sale de la aplicacion, que es la convencion de Android y evita que
  /// el paciente quede dando vueltas entre pestanas sin poder salir.
  void _handlePop(BuildContext context) {
    final router = GoRouter.of(context);
    if (router.canPop()) {
      router.pop();
      return;
    }
    if (navigationShell.currentIndex != ShellBranch.home) {
      navigationShell.goBranch(ShellBranch.home);
      return;
    }
    SystemNavigator.pop();
  }
}

/// Rutas raiz de cada rama, en el orden de [ShellBranch].
///
/// Vive aca y no en `AppRoutes` porque es la composicion del shell y no el
/// catalogo de rutas: `AppRoutes` sigue siendo la lista plana de literales.
const List<String> shellBranchRoots = <String>[
  AppRoutes.home,
  AppRoutes.history,
  AppRoutes.recommendations,
  AppRoutes.profile,
];
