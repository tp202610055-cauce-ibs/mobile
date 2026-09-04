import 'package:cauce_mobile/core/config/env.dart';
import 'package:flutter_test/flutter_test.dart';

const Map<String, String> _devValues = <String, String>{
  'API_BASE_URL': 'http://10.0.2.2:5074',
  'ENV_NAME': 'dev',
  'CLIENT_ID': 'cauce-mobile',
  'DEEP_LINK_SCHEME': 'cauce',
};

void main() {
  tearDown(Env.reset);

  group('Env · arranque', () {
    test('leer antes de load falla con un mensaje accionable', () {
      expect(
        () => Env.apiBaseUrl,
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('Env.load()'),
          ),
        ),
      );
    });

    test('expone los valores del archivo cargado', () {
      Env.loadForTesting(_devValues);

      expect(Env.apiBaseUrl, 'http://10.0.2.2:5074');
      expect(Env.clientId, 'cauce-mobile');
      expect(Env.deepLinkScheme, 'cauce');
      expect(Env.envName, 'dev');
    });

    test('una variable ausente falla nombrando el archivo', () {
      Env.loadForTesting(const <String, String>{'ENV_NAME': 'dev'});

      expect(
        () => Env.clientId,
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            allOf(contains('CLIENT_ID'), contains('.env.dev')),
          ),
        ),
      );
    });
  });

  group('Flavor', () {
    test('cada flavor apunta a su archivo', () {
      expect(Flavor.dev.fileName, '.env.dev');
      expect(Flavor.staging.fileName, '.env.staging');
      expect(Flavor.prod.fileName, '.env.prod');
    });

    test('un nombre desconocido cae en dev', () {
      expect(Flavor.fromName('staging'), Flavor.staging);
      expect(Flavor.fromName('produccion'), Flavor.dev);
      expect(Flavor.fromName(''), Flavor.dev);
    });
  });

  group('Env · resolucion de base URL por plataforma', () {
    const String androidUrl = 'http://10.0.2.2:5074';

    test('en dev sobre Apple reescribe el host del emulador', () {
      // El simulador de iOS alcanza el host por localhost; 10.0.2.2 es una
      // direccion que solo entiende el emulador de Android.
      expect(
        Env.resolveBaseUrl(
          raw: androidUrl,
          flavor: Flavor.dev,
          isApplePlatform: true,
        ),
        'http://localhost:5074',
      );
    });

    test('en dev sobre Android deja el host intacto', () {
      expect(
        Env.resolveBaseUrl(
          raw: androidUrl,
          flavor: Flavor.dev,
          isApplePlatform: false,
        ),
        androidUrl,
      );
    });

    test('staging y prod nunca se reescriben, ni siquiera en Apple', () {
      // Reescribir un host real convertiria una build de produccion en una
      // que apunta al localhost del telefono.
      for (final flavor in <Flavor>[Flavor.staging, Flavor.prod]) {
        expect(
          Env.resolveBaseUrl(
            raw: 'https://api.cauce.local',
            flavor: flavor,
            isApplePlatform: true,
          ),
          'https://api.cauce.local',
          reason: flavor.name,
        );
      }
    });
  });

  group('Env · logging de red', () {
    test('solo dev habilita el volcado de cuerpos', () {
      // En el piloto, los cuerpos llevan datos clinicos del paciente.
      Env.loadForTesting(_devValues);
      expect(Env.isNetworkLoggingEnabled, isTrue);

      Env.loadForTesting(_devValues, flavor: Flavor.staging);
      expect(Env.isNetworkLoggingEnabled, isFalse);

      Env.loadForTesting(_devValues, flavor: Flavor.prod);
      expect(Env.isNetworkLoggingEnabled, isFalse);
    });
  });
}
