import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'app_routes.dart';

part 'pending_password_reset_link.g.dart';

/// Token de `cauce://auth/password-reset?token=xxx`, o `null` si [uri] es otra.
/// Sin token devuelve cadena vacia: la pantalla lo informa como no valido.
String? passwordResetTokenFromUri(Uri uri) {
  final isResetLink = uri.scheme == AppRoutes.deepLinkScheme &&
      uri.host == AppRoutes.passwordResetLinkHost &&
      uri.path == AppRoutes.passwordResetLinkPath;
  return isResetLink
      ? uri.queryParameters[AppRoutes.tokenQueryParam] ?? ''
      : null;
}

/// Si la plataforma abrio la app con el enlace de restablecimiento.
/// El valor no cambia en todo el proceso, aunque el enlace ya se haya usado.
bool openedByPasswordResetLink() => _launchToken() != null;

String? _launchToken() {
  final route = WidgetsBinding.instance.platformDispatcher.defaultRouteName;
  final uri = Uri.tryParse(route);
  return uri == null ? null : passwordResetTokenFromUri(uri);
}

/// Enlace de restablecimiento en curso, que sobrevive a las reconstrucciones
/// del router. Leerlo no lo consume: se limpia solo al terminar el flujo.
@Riverpod(keepAlive: true)
class PendingPasswordResetLink extends _$PendingPasswordResetLink {
  @override
  String? build() => _launchToken();

  void capture(String token) => state = token;

  void clear() => state = null;
}
