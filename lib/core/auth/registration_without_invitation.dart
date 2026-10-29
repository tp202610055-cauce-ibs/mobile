import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/session_notifier.dart';

part 'registration_without_invitation.g.dart';

/// `userId` de la cuenta recien registrada sin codigo de invitacion.
///
/// Vive solo en memoria: el aviso que alimenta no sobrevive a un reinicio.
@Riverpod(keepAlive: true)
class RegisteredWithoutInvitation extends _$RegisteredWithoutInvitation {
  @override
  String? build() => null;

  void mark(String userId) => state = userId;
}

/// `true` si la sesion actual es la de esa cuenta (CP055 paso 5).
@riverpod
bool showsNoInvitationNotice(Ref ref) {
  final owner = ref.watch(registeredWithoutInvitationProvider);
  return owner != null &&
      ref.watch(sessionNotifierProvider).user?.userId == owner;
}
