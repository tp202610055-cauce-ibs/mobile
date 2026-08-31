import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Entornos de despliegue del cliente movil.
enum Flavor {
  dev('.env.dev'),
  staging('.env.staging'),
  prod('.env.prod');

  const Flavor(this.fileName);

  /// Archivo dotenv que corresponde a este flavor.
  final String fileName;

  static Flavor fromName(String name) {
    return Flavor.values.firstWhere(
      (flavor) => flavor.name == name,
      orElse: () => Flavor.dev,
    );
  }
}

/// Acceso tipado a la configuracion de entorno.
///
/// Se carga una vez en `main()` antes de `runApp`. Leer cualquier propiedad
/// antes de [load] lanza [StateError], para que un error de orden de arranque
/// falle de inmediato y no se manifieste como una base URL vacia.
abstract final class Env {
  static Flavor? _flavor;

  /// Flavor activo. Lanza si [load] todavia no corrio.
  static Flavor get flavor {
    final current = _flavor;
    if (current == null) {
      throw StateError(
        'Env.load() no fue invocado. Llamalo en main() antes de runApp.',
      );
    }
    return current;
  }

  /// Carga el archivo dotenv del flavor indicado.
  ///
  /// El flavor por defecto es [Flavor.dev]. Se puede fijar en tiempo de
  /// compilacion con `--dart-define=FLAVOR=staging`.
  static Future<void> load({Flavor? flavor}) async {
    final resolved = flavor ??
        Flavor.fromName(
          const String.fromEnvironment('FLAVOR', defaultValue: 'dev'),
        );
    await dotenv.load(fileName: resolved.fileName);
    _flavor = resolved;
  }

  /// Carga valores en memoria, sin tocar el sistema de archivos. Para tests.
  @visibleForTesting
  static void loadForTesting(Map<String, String> values, {Flavor? flavor}) {
    dotenv.testLoad(mergeWith: values);
    _flavor = flavor ?? Flavor.dev;
  }

  /// Descarta la configuracion cargada. Para tests.
  @visibleForTesting
  static void reset() {
    dotenv.clean();
    _flavor = null;
  }

  static String _require(String key) {
    // Toca `flavor` a proposito: convierte un acceso prematuro en un
    // StateError con mensaje util, en vez de una clave ausente.
    final _ = flavor;
    final value = dotenv.env[key];
    if (value == null || value.isEmpty) {
      throw StateError('Falta la variable $key en ${flavor.fileName}');
    }
    return value;
  }

  /// URL base del backend, sin el sufijo `/api/v1`.
  ///
  /// En [Flavor.dev] el valor del archivo apunta al emulador de Android
  /// (`10.0.2.2`). El simulador de iOS alcanza el host por `localhost`, asi
  /// que se reescribe en runtime segun la plataforma.
  static String get apiBaseUrl {
    final raw = _require('API_BASE_URL');
    if (flavor != Flavor.dev || kIsWeb) {
      return raw;
    }
    if (Platform.isIOS || Platform.isMacOS) {
      return raw.replaceFirst('10.0.2.2', 'localhost');
    }
    return raw;
  }

  /// Identificador del cliente que el backend exige en el body de login,
  /// refresh y logout.
  static String get clientId => _require('CLIENT_ID');

  /// Scheme de deep link registrado en Android e iOS.
  static String get deepLinkScheme => _require('DEEP_LINK_SCHEME');

  /// Nombre del entorno, tal como lo declara el archivo dotenv.
  static String get envName => _require('ENV_NAME');

  /// Solo en dev se monta el `LogInterceptor` de dio, que vuelca cuerpos de
  /// request y response. En staging y prod eso filtraria datos del paciente.
  static bool get isNetworkLoggingEnabled => flavor == Flavor.dev;
}
