import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;

/// Configuración central de la API del backend Cauce.
class ApiConfig {
  ApiConfig._();

  /// Puerto del backend ASP.NET Core en desarrollo.
  static const int _devPort = 5074;

  /// Base URL del backend según el entorno de ejecución.
  /// - Android emulator: 10.0.2.2 mapea al localhost del host.
  /// - iOS simulator y web: localhost funciona directamente.
  /// - Dispositivo físico: cambiar a la IP de la laptop en LAN.
  static String get baseUrl {
    if (kIsWeb) return 'http://localhost:$_devPort';
    if (Platform.isAndroid) return 'http://10.0.2.2:$_devPort';
    return 'http://localhost:$_devPort';
  }

  /// Prefijo común de todos los endpoints versionados.
  static const String apiPrefix = '/api/v1';

  // Endpoints de autenticación
  static const String registerEndpoint = '$apiPrefix/auth/register';
  static const String loginEndpoint = '$apiPrefix/auth/login';

  // Endpoints de usuario
  static const String currentUserEndpoint = '$apiPrefix/users/me';

  /// Timeout para conexión inicial al backend.
  static const Duration connectTimeout = Duration(seconds: 10);

  /// Timeout para recepción de respuesta del backend.
  static const Duration receiveTimeout = Duration(seconds: 15);
}