import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_expiry.g.dart';

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
@Riverpod(keepAlive: true)
class SessionExpiry extends _$SessionExpiry {
  /// Cantidad de vencimientos. Solo importa que cambie: dos seguidos tambien
  /// avisan.
  @override
  int build() => 0;

  void raise() => state = state + 1;
}
