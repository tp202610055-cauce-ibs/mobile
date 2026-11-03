import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'authenticated_user_snapshot.dart';

part 'refreshed_user.g.dart';

/// Ultimo usuario que trajo una renovacion de sesion, o `null` si ninguna.
/// Se publica aparte de la sesion en memoria para no reconstruir el router.
@Riverpod(keepAlive: true)
class RefreshedUser extends _$RefreshedUser {
  @override
  AuthenticatedUserSnapshot? build() => null;

  void publish(AuthenticatedUserSnapshot user) => state = user;
}
