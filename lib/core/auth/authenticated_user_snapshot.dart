import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authenticated_user_snapshot.freezed.dart';
part 'authenticated_user_snapshot.g.dart';

/// Copia local del usuario autenticado que devuelve el backend en el login.
///
/// Existe como tipo propio y no se reutiliza `api.AuthenticatedUser` porque el
/// modelo generado es `built_value` y esta atado al ciclo de regeneracion del
/// cliente OpenAPI. Este snapshot se serializa a JSON y se persiste en
/// `flutter_secure_storage` bajo la key `auth_user_snapshot` (acta M11), asi
/// que necesita un contrato de serializacion estable e independiente.
@freezed
abstract class AuthenticatedUserSnapshot with _$AuthenticatedUserSnapshot {
  const factory AuthenticatedUserSnapshot({
    required String userId,
    required String keycloakId,
    required String email,

    /// `patient` o `nutritionist`. Se guarda como String y no como enum para
    /// que un rol nuevo en el backend no invalide la sesion persistida de un
    /// paciente que ya tiene la app instalada.
    required String role,
    required String fullName,
    required bool emailVerified,
    required bool isInActivePilot,
  }) = _AuthenticatedUserSnapshot;

  const AuthenticatedUserSnapshot._();

  factory AuthenticatedUserSnapshot.fromJson(Map<String, dynamic> json) =>
      _$AuthenticatedUserSnapshotFromJson(json);

  /// Traduce el modelo generado del cliente OpenAPI al snapshot local.
  ///
  /// El esquema OpenAPI del backend no marca estos campos como `required`, de
  /// modo que el generador los emite nullable aunque el contrato garantice su
  /// presencia. La traduccion valida en vez de asumir: una identidad a medias
  /// es peor que un fallo ruidoso, porque se persistiria en almacenamiento
  /// seguro y corromperia la sesion en cada arranque posterior.
  ///
  /// Lanza [FormatException] si el backend omite algun campo.
  factory AuthenticatedUserSnapshot.fromApi(api.AuthenticatedUser user) {
    return AuthenticatedUserSnapshot(
      userId: _require(user.userId, 'userId'),
      keycloakId: _require(user.keycloakId, 'keycloakId'),
      email: _require(user.email, 'email'),
      role: _require(user.role, 'role'),
      fullName: _require(user.fullName, 'fullName'),
      emailVerified: _require(user.emailVerified, 'emailVerified'),
      isInActivePilot: _require(user.isInActivePilot, 'isInActivePilot'),
    );
  }

  static T _require<T extends Object>(T? value, String field) {
    if (value == null) {
      throw FormatException(
        'El backend devolvio un AuthenticatedUser sin el campo $field.',
      );
    }
    return value;
  }

  /// El paciente ya verifico su correo y puede operar con normalidad.
  bool get canAccessApp => emailVerified;
}
