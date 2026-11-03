import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/errors/cauce_api_error.dart';
import '../data/auth_repository.dart';

part 'password_reset_link_notifier.g.dart';

/// Estado del enlace de recuperación al abrirlo.
enum PasswordResetLinkStatus { valid, noLongerValid }

/// Valida el token del deep link antes de mostrar el formulario (US07).
///
/// Solo un token rechazado por el servidor cierra el paso; un fallo de red deja
/// ver el formulario y la confirmación informa el error.
@riverpod
Future<PasswordResetLinkStatus> passwordResetLink(Ref ref, String token) async {
  try {
    await ref
        .read(authRepositoryProvider)
        .validatePasswordResetToken(token: token);
    return PasswordResetLinkStatus.valid;
  } on PasswordResetTokenError {
    return PasswordResetLinkStatus.noLongerValid;
  } on CauceApiError {
    return PasswordResetLinkStatus.valid;
  }
}
