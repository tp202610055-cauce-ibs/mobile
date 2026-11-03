import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'api_guard.dart';
import 'dio_provider.dart';
import 'refresh_interceptor.dart';

part 'session_renewal.g.dart';

/// Renovacion de sesion a pedido, sobre el mismo interceptor que usa la red.
/// Las fallas salen como `CauceApiError`, y una sesion vencida como
/// `SessionExpiredException`.
class SessionRenewal {
  const SessionRenewal(this._interceptor);

  final RefreshInterceptor _interceptor;

  Future<void> renew() => guardApiCall(_interceptor.renewNow);
}

@Riverpod(keepAlive: true)
SessionRenewal sessionRenewal(Ref ref) => SessionRenewal(
      ref
          .watch(dioProvider)
          .interceptors
          .whereType<RefreshInterceptor>()
          .single,
    );
