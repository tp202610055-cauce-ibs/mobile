// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_expiry.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sessionExpiryHash() => r'c1112026a18083eb69b11ec8b409fe18c27cd7f6';

/// Aviso de que la sesion guardada dejo de servir (acta M49).
///
/// Lo levanta el `RefreshInterceptor` cuando la renovacion falla sin remedio
/// (refresh vencido o revocado, o sin refresh guardado) y ya borro el
/// almacenamiento. Lo escucha `SessionNotifier`, que pasa a no autenticado, y
/// con eso el router lleva al login.
///
/// **Existe porque nadie escuchaba.** Hasta este bloque el interceptor borraba
/// las tres keys y lanzaba `SessionExpiredException`, pero ningun codigo la
/// atrapaba: la sesion en memoria seguia autenticada y la app se quedaba en
/// sus pantallas mostrando errores hasta el proximo arranque.
///
/// Vive en `core/` para que la red no dependa de la feature de auth: el
/// interceptor solo levanta la senal, y quien la escucha es asunto de la
/// feature.
///
/// Copied from [SessionExpiry].
@ProviderFor(SessionExpiry)
final sessionExpiryProvider = NotifierProvider<SessionExpiry, int>.internal(
  SessionExpiry.new,
  name: r'sessionExpiryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sessionExpiryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SessionExpiry = Notifier<int>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
