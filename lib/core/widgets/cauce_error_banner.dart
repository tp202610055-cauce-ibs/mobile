import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../l10n/generated/app_localizations.dart';
import '../errors/cauce_api_error.dart';
import '../errors/error_messages.dart';
import '../theme/design_tokens.dart';

/// Banner de error del design system.
///
/// Muestra el mensaje traducido de un [CauceApiError]. Cuando el error trae
/// una ventana temporal (423 con `lockedUntil`, 429 con `retryAfterSeconds`)
/// el texto se recalcula cada segundo, de modo que el paciente ve bajar la
/// espera en vez de un numero congelado que ya no es cierto.
///
/// El icono acompana al color y no lo sustituye: el design system exige que el
/// error nunca se comunique solo por color.
class CauceErrorBanner extends StatefulWidget {
  const CauceErrorBanner({required this.error, super.key});

  final CauceApiError error;

  @override
  State<CauceErrorBanner> createState() => _CauceErrorBannerState();
}

class _CauceErrorBannerState extends State<CauceErrorBanner> {
  Timer? _ticker;

  /// Momento en que se mostro este error.
  ///
  /// El 429 trae `retryAfterSeconds` como numero fijo, no como instante. Sin
  /// anclar el arranque, el contador mostraria siempre el mismo valor y el
  /// paciente veria "espera 60 segundos" indefinidamente.
  DateTime _shownAt = DateTime.now();

  @override
  void initState() {
    super.initState();
    _syncTicker();
  }

  @override
  void didUpdateWidget(CauceErrorBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.error != widget.error) {
      _shownAt = DateTime.now();
      _syncTicker();
    }
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  /// Enciende el temporizador solo para los errores con cuenta regresiva.
  void _syncTicker() {
    _ticker?.cancel();
    if (!_isTimed) {
      _ticker = null;
      return;
    }
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  bool get _isTimed =>
      widget.error.lockedUntil != null ||
      widget.error.retryAfterSeconds != null;

  /// Texto a mostrar, con la espera ya descontada cuando corresponde.
  String _message(AppLocalizations l10n) {
    final retryAfter = widget.error.retryAfterSeconds;
    if (retryAfter != null) {
      final elapsed = DateTime.now().difference(_shownAt).inSeconds;
      final remaining = retryAfter - elapsed;
      if (remaining <= 0) {
        // Se cumplio la espera. El paciente ya puede reintentar, y seguir
        // mostrando un contador en cero seria confuso.
        return l10n.commonRetry;
      }
      return l10n.errorRateLimited(remaining);
    }
    // El bloqueo de cuenta si trae un instante absoluto, asi que basta con
    // pasarle el reloj actual.
    return widget.error.localizedMessage(l10n, now: DateTime.now().toUtc());
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final message = _message(l10n);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(CauceSpacing.space3),
      decoration: const BoxDecoration(
        color: CauceColors.dangerBg,
        borderRadius: CauceRadii.borderMd,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Icon(
            TablerIcons.alert_circle,
            color: CauceColors.dangerText,
            size: 20,
          ),
          const SizedBox(width: CauceSpacing.space2),
          Expanded(
            child: Text(
              message,
              style: CauceTypography.bodyMedium.copyWith(
                color: CauceColors.dangerText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
