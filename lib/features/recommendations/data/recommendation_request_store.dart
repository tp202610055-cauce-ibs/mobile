import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../domain/pending_recommendation_request.dart';

part 'recommendation_request_store.g.dart';

/// Donde vive el marcador de la guarda anti-duplicados (decision 2).
abstract interface class RecommendationRequestStore {
  /// El marcador guardado, o `null` si no hay ninguno o no se pudo leer.
  Future<PendingRecommendationRequest?> read();

  Future<void> write(PendingRecommendationRequest request);

  Future<void> clear();
}

/// Marcador sobre `flutter_secure_storage`, con una clave propia.
///
/// **Por que aca y no en drift.** El marcador tiene que sobrevivir a un
/// reinicio de la app, o reabrirla volveria a pedir una recomendacion. Drift
/// lo lograria con una tabla, pero eso es la migracion del esquema a v3, y
/// este bloque lo deja congelado en v2 (decision 8). El almacenamiento seguro
/// ya es una dependencia, guarda pares clave-valor y un solo marcador es
/// exactamente eso (acta M47). No comparte claves con la sesion: cerrarla no
/// lo borra, y por eso el marcador lleva el paciente dueño y se descarta si
/// no coincide.
///
/// **Nunca lanza.** Un fallo de lectura se trata como "no hay marcador" y uno
/// de escritura se ignora. Lo peor que puede pasar es que la guarda se debilite
/// y se pida una recomendacion de mas, que es preferible a que la pestana de
/// Consejos se caiga por un Keystore que no responde.
class SecureRecommendationRequestStore implements RecommendationRequestStore {
  SecureRecommendationRequestStore(this._storage);

  /// Mismas opciones de plataforma que `SecureTokenStorage`.
  factory SecureRecommendationRequestStore.withDefaults() {
    return SecureRecommendationRequestStore(
      const FlutterSecureStorage(
        aOptions: AndroidOptions(encryptedSharedPreferences: true),
        iOptions: IOSOptions(
          accessibility: KeychainAccessibility.first_unlock_this_device,
        ),
      ),
    );
  }

  final FlutterSecureStorage _storage;

  @visibleForTesting
  static const String key = 'recommendations_pending_request';

  @override
  Future<PendingRecommendationRequest?> read() async {
    try {
      final raw = await _storage.read(key: key);
      return raw == null ? null : decode(raw);
    } on PlatformException {
      return null;
    } on MissingPluginException {
      return null;
    }
  }

  @override
  Future<void> write(PendingRecommendationRequest request) async {
    try {
      await _storage.write(key: key, value: encode(request));
    } on PlatformException {
      return;
    } on MissingPluginException {
      return;
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.delete(key: key);
    } on PlatformException {
      return;
    } on MissingPluginException {
      return;
    }
  }

  /// Serializa el marcador. Las fechas viajan en UTC ISO 8601.
  @visibleForTesting
  static String encode(PendingRecommendationRequest request) {
    return jsonEncode(<String, Object?>{
      'ownerUserId': request.ownerUserId,
      'idempotencyKey': request.idempotencyKey,
      'requestedAt': request.requestedAt.toUtc().toIso8601String(),
      'recommendationId': request.recommendationId,
      'expiresAt': request.expiresAt?.toUtc().toIso8601String(),
    });
  }

  /// Lee un marcador guardado. Un valor corrupto devuelve `null`.
  ///
  /// Se valida campo por campo y no con un cast directo: con `strict-casts`
  /// un tipo inesperado seria un `TypeError`, que no es una `Exception` y
  /// escaparia de los `try` de arriba.
  @visibleForTesting
  static PendingRecommendationRequest? decode(String raw) {
    final Object? decoded;
    try {
      decoded = jsonDecode(raw);
    } on FormatException {
      return null;
    }
    if (decoded is! Map<String, Object?>) {
      return null;
    }
    final owner = decoded['ownerUserId'];
    final key = decoded['idempotencyKey'];
    final requestedAt = _date(decoded['requestedAt']);
    final id = decoded['recommendationId'];
    if (owner is! String || key is! String || requestedAt == null) {
      return null;
    }
    return PendingRecommendationRequest(
      ownerUserId: owner,
      idempotencyKey: key,
      requestedAt: requestedAt,
      recommendationId: id is String ? id : null,
      expiresAt: _date(decoded['expiresAt']),
    );
  }

  static DateTime? _date(Object? value) =>
      value is String ? DateTime.tryParse(value) : null;
}

@Riverpod(keepAlive: true)
RecommendationRequestStore recommendationRequestStore(Ref ref) =>
    SecureRecommendationRequestStore.withDefaults();
