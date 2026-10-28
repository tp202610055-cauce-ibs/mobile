import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/application/session_notifier.dart';

part 'local_record_owner.g.dart';

/// Cuenta duena de las filas locales: la de la sesion, o `null` sin sesion.
///
/// Se lee en cada consulta, de modo que un cambio de cuenta no deja filas
/// ajenas a la vista ni en la cola.
@Riverpod(keepAlive: true)
String? Function() localRecordOwner(Ref ref) =>
    () => ref.read(sessionNotifierProvider).user?.userId;
