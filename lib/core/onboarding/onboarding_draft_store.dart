import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'onboarding_draft_store.g.dart';

/// Avance del perfil clinico que el paciente aplazo con «Después» (HU0003
/// CA05). Es dato clinico: vive solo en el almacenamiento seguro.
@immutable
class OnboardingDraft {
  const OnboardingDraft({
    required this.ownerUserId,
    required this.page,
    this.fields = const <String, Object?>{},
  });

  /// Cuenta que lo guardo; otra cuenta no lo ve.
  final String ownerUserId;

  /// Paso del asistente donde quedo, base 0.
  final int page;

  /// Valores del formulario, como texto y nombres de enum.
  final Map<String, Object?> fields;
}

/// Donde vive el borrador del asistente.
abstract interface class OnboardingDraftStore {
  /// El borrador guardado, o `null` si no hay o no se pudo leer.
  Future<OnboardingDraft?> read();

  Future<void> write(OnboardingDraft draft);

  Future<void> clear();
}

/// Borrador sobre `flutter_secure_storage`, con una clave propia.
///
/// Nunca lanza: un Keystore que no responde, o un canal sin plataforma, deja
/// el asistente sin borrador, que es lo mismo que no haberlo aplazado.
class SecureOnboardingDraftStore implements OnboardingDraftStore {
  SecureOnboardingDraftStore(this._storage);

  /// Mismas opciones de plataforma que `SecureTokenStorage`.
  factory SecureOnboardingDraftStore.withDefaults() {
    return SecureOnboardingDraftStore(
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
  static const String key = 'onboarding_profile_draft';

  @override
  Future<OnboardingDraft?> read() async {
    try {
      final raw = await _storage.read(key: key);
      return raw == null ? null : decode(raw);
    } on Object {
      return null;
    }
  }

  @override
  Future<void> write(OnboardingDraft draft) async {
    try {
      await _storage.write(key: key, value: encode(draft));
    } on Object {
      return;
    }
  }

  @override
  Future<void> clear() async {
    try {
      await _storage.delete(key: key);
    } on Object {
      return;
    }
  }

  @visibleForTesting
  static String encode(OnboardingDraft draft) {
    return jsonEncode(<String, Object?>{
      'ownerUserId': draft.ownerUserId,
      'page': draft.page,
      'fields': draft.fields,
    });
  }

  /// Lee un borrador guardado. Un valor corrupto devuelve `null`.
  @visibleForTesting
  static OnboardingDraft? decode(String raw) {
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
    final page = decoded['page'];
    final fields = decoded['fields'];
    if (owner is! String || page is! int || fields is! Map<String, Object?>) {
      return null;
    }
    return OnboardingDraft(ownerUserId: owner, page: page, fields: fields);
  }
}

@Riverpod(keepAlive: true)
OnboardingDraftStore onboardingDraftStore(Ref ref) =>
    SecureOnboardingDraftStore.withDefaults();
