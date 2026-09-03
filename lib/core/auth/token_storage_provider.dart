import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'secure_token_storage.dart';
import 'token_storage.dart';

part 'token_storage_provider.g.dart';

/// Almacenamiento seguro de la sesion.
///
/// `keepAlive` porque la sesion es estado de aplicacion, no de pantalla:
/// descartarla al desmontarse el ultimo consumidor obligaria a releer del
/// Keystore en cada navegacion.
///
/// Los tests lo sobrescriben con un `TokenStorage` en memoria; el plugin real
/// habla por canal de plataforma y no existe en la VM del host.
@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) => SecureTokenStorage.withDefaults();
