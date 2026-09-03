import 'package:cauce_api_client/cauce_api_client.dart' as api;
import 'package:cauce_mobile/core/auth/authenticated_user_snapshot.dart';
import 'package:flutter_test/flutter_test.dart';

api.AuthenticatedUser _apiUser({
  String? userId = '79974080-cfbb-4ce8-b003-4e80e7e9e84f',
  String? keycloakId = 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd',
  String? email = 'paciente.demo@cauce.local',
  String? role = 'patient',
  String? fullName = 'Paciente Demo',
  bool? emailVerified = true,
  bool? isInActivePilot = true,
}) {
  return api.AuthenticatedUser(
    (b) => b
      ..userId = userId
      ..keycloakId = keycloakId
      ..email = email
      ..role = role
      ..fullName = fullName
      ..emailVerified = emailVerified
      ..isInActivePilot = isInActivePilot,
  );
}

void main() {
  group('AuthenticatedUserSnapshot · traduccion desde el cliente generado', () {
    test('copia los siete campos del paciente demo', () {
      final snapshot = AuthenticatedUserSnapshot.fromApi(_apiUser());

      expect(snapshot.userId, '79974080-cfbb-4ce8-b003-4e80e7e9e84f');
      expect(snapshot.keycloakId, 'b8ebd09c-3bb3-4e7b-90dd-a55124bae0fd');
      expect(snapshot.email, 'paciente.demo@cauce.local');
      expect(snapshot.role, 'patient');
      expect(snapshot.fullName, 'Paciente Demo');
      expect(snapshot.emailVerified, isTrue);
      expect(snapshot.isInActivePilot, isTrue);
    });

    test('un campo ausente falla en vez de persistir identidad a medias', () {
      // El esquema OpenAPI no marca estos campos como required, de modo que el
      // generador los emite nullable aunque el contrato garantice su presencia.
      // Degradar en silencio guardaria una sesion corrupta en almacenamiento
      // seguro, que reventaria en cada arranque posterior.
      expect(
        () => AuthenticatedUserSnapshot.fromApi(_apiUser(email: null)),
        throwsA(
          isA<FormatException>().having(
            (e) => e.message,
            'message',
            contains('email'),
          ),
        ),
      );
    });

    test('nombra el campo faltante, sea cual sea', () {
      final missing = <String, api.AuthenticatedUser>{
        'userId': _apiUser(userId: null),
        'keycloakId': _apiUser(keycloakId: null),
        'role': _apiUser(role: null),
        'fullName': _apiUser(fullName: null),
        'emailVerified': _apiUser(emailVerified: null),
        'isInActivePilot': _apiUser(isInActivePilot: null),
      };

      for (final entry in missing.entries) {
        expect(
          () => AuthenticatedUserSnapshot.fromApi(entry.value),
          throwsA(
            isA<FormatException>().having(
              (e) => e.message,
              'message',
              contains(entry.key),
            ),
          ),
          reason: entry.key,
        );
      }
    });
  });

  group('AuthenticatedUserSnapshot · serializacion', () {
    test('sobrevive un ciclo completo de json', () {
      // Es lo que se persiste bajo la key auth_user_snapshot del acta M11.
      final original = AuthenticatedUserSnapshot.fromApi(_apiUser());

      expect(
        AuthenticatedUserSnapshot.fromJson(original.toJson()),
        original,
      );
    });
  });

  group('AuthenticatedUserSnapshot · reglas de sesion', () {
    test('canAccessApp sigue a emailVerified', () {
      expect(
        AuthenticatedUserSnapshot.fromApi(_apiUser()).canAccessApp,
        isTrue,
      );
      expect(
        AuthenticatedUserSnapshot.fromApi(
          _apiUser(emailVerified: false),
        ).canAccessApp,
        isFalse,
      );
    });
  });
}
