import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'token_storage.dart';

part 'token_storage_provider.g.dart';

/// Almacenamiento seguro de la sesion.
///
/// La implementacion concreta `SecureTokenStorage` llega en la Fase 4, junto
/// con `flutter_secure_storage` y las tres keys del acta M11. Hasta entonces
/// el provider falla de forma explicita en vez de devolver un doble vacio, que
/// simularia una sesion inexistente y haria pasar tests que no deberian pasar.
///
/// Los tests sobrescriben este provider con un `TokenStorage` de prueba.
@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) {
  throw UnimplementedError(
    'SecureTokenStorage se implementa en la Fase 4. '
    'Sobrescribi tokenStorageProvider en los tests hasta entonces.',
  );
}
