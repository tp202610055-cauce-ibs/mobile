import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// Una respuesta preparada para un endpoint.
class CannedResponse {
  const CannedResponse({
    required this.statusCode,
    this.body,
    this.headers = const <String, List<String>>{},
  });

  /// Respuesta exitosa con cuerpo JSON.
  const CannedResponse.ok(Map<String, dynamic> this.body)
      : statusCode = 200,
        headers = const <String, List<String>>{};

  /// Respuesta 201 con cuerpo JSON.
  const CannedResponse.created(Map<String, dynamic> this.body)
      : statusCode = 201,
        headers = const <String, List<String>>{};

  /// Respuesta sin contenido.
  const CannedResponse.noContent()
      : statusCode = 204,
        body = null,
        headers = const <String, List<String>>{};

  /// Envelope de error RFC 7807, como lo emite el backend.
  factory CannedResponse.problem({
    required int statusCode,
    String? errorCode,
    Map<String, dynamic> extra = const <String, dynamic>{},
  }) {
    return CannedResponse(
      statusCode: statusCode,
      body: <String, dynamic>{
        'type': null,
        'title': 'Titulo en espanol',
        'status': statusCode,
        'detail': 'Detalle de la excepcion',
        'instance': null,
        'traceId': '00-3f1a9c2e7b4d-1a2b3c4d-00',
        if (errorCode != null) 'errorCode': errorCode,
        ...extra,
      },
    );
  }

  final int statusCode;
  final Map<String, dynamic>? body;
  final Map<String, List<String>> headers;
}

/// Respuesta preparada para una lista JSON de raiz.
///
/// `GET /api/v1/allergies` y `GET /api/v1/patients/allergies` devuelven arrays
/// en la raiz, no objetos, y [CannedResponse] solo admite `Map` en el cuerpo.
class CannedListResponse extends CannedResponse {
  const CannedListResponse(this.items, {super.statusCode = 200})
      : super(body: null);

  final List<Map<String, dynamic>> items;
}

/// Peticion capturada, para verificar lo que el cliente realmente envio.
class CapturedRequest {
  const CapturedRequest({
    required this.method,
    required this.path,
    required this.body,
    required this.headers,
  });

  final String method;
  final String path;

  /// Cuerpo ya deserializado. Es lo que el cliente generado serializo con
  /// `built_value`, de modo que verificarlo prueba el mapeo completo.
  final Map<String, dynamic> body;

  final Map<String, dynamic> headers;
}

/// Adapter de dio que responde con lo preparado y registra lo recibido.
///
/// Permite ejercitar el cliente OpenAPI generado de punta a punta (
/// serializacion `built_value`, rutas, cabeceras) sin levantar un servidor.
///
/// Tiene dos modos, y el segundo es una ampliacion de Mobile-2:
///
/// 1. **Respuesta unica.** El constructor por defecto responde lo mismo a toda
///    peticion. Sirve cuando el caso bajo prueba hace una sola llamada, que es
///    lo que necesitan los tests de identidad.
/// 2. **Por ruta.** [CannedHttpAdapter.routed] resuelve por metodo y sufijo de
///    path. El onboarding clinico toca cuatro endpoints en un mismo flujo y no
///    se puede describir con una sola respuesta.
///
/// En el modo por ruta, cada entrada admite **varias** respuestas en orden: se
/// consumen de a una y la ultima se repite. Asi se expresa un `GET` que primero
/// devuelve 404 y despues 200, que es exactamente la forma del onboarding.
class CannedHttpAdapter implements HttpClientAdapter {
  CannedHttpAdapter([this.response = const CannedResponse.noContent()])
      : _routes = <String, List<CannedResponse>>{};

  /// Adapter que resuelve por metodo y ruta.
  ///
  /// Las claves van como `'GET /api/v1/patients/profile'`. El valor puede ser
  /// una [CannedResponse] o una `List<CannedResponse>` con la secuencia.
  /// [fallback] responde a lo que no matchee ninguna ruta.
  CannedHttpAdapter.routed(
    Map<String, Object> routes, {
    CannedResponse fallback = const CannedResponse.noContent(),
  })  : response = fallback,
        _routes = routes.map(
          (key, value) => MapEntry(_normalizeKey(key), _asQueue(value)),
        );

  /// Respuesta por defecto. Mutable a proposito: varios tests la reemplazan
  /// entre dos ejecuciones del mismo caso.
  CannedResponse response;

  final Map<String, List<CannedResponse>> _routes;

  final List<CapturedRequest> requests = <CapturedRequest>[];

  CapturedRequest get lastRequest => requests.last;

  /// Peticiones capturadas para un metodo y ruta concretos.
  List<CapturedRequest> requestsFor(String method, String path) {
    return requests
        .where(
          (request) =>
              request.method.toUpperCase() == method.toUpperCase() &&
              Uri.parse(request.path).path.endsWith(path),
        )
        .toList();
  }

  /// Prepara o reemplaza la respuesta de una ruta despues de construir el
  /// adapter. Acepta una [CannedResponse] o una `List<CannedResponse>`.
  void stub(String method, String path, Object response) {
    _routes[_normalizeKey('$method $path')] = _asQueue(response);
  }

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(
      CapturedRequest(
        method: options.method,
        path: options.path,
        body: _decodeBody(options.data),
        headers: options.headers,
      ),
    );

    final resolved = _resolve(options);
    return ResponseBody.fromString(
      _encode(resolved),
      resolved.statusCode,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
        ...resolved.headers,
      },
    );
  }

  /// Busca la ruta que matchee y consume su siguiente respuesta.
  ///
  /// La ultima de la cola no se consume: se repite. Un test que prepara una
  /// sola respuesta obtiene el comportamiento de siempre, y uno que prepara
  /// dos obtiene la segunda en todas las llamadas posteriores a la primera.
  CannedResponse _resolve(RequestOptions options) {
    final method = options.method.toUpperCase();
    final path = Uri.parse(options.path).path;

    for (final entry in _routes.entries) {
      final separator = entry.key.indexOf(' ');
      final routeMethod = entry.key.substring(0, separator);
      final routePath = entry.key.substring(separator + 1);

      if (routeMethod != method || !path.endsWith(routePath)) {
        continue;
      }

      final queue = entry.value;
      return queue.length == 1 ? queue.first : queue.removeAt(0);
    }

    return response;
  }

  String _encode(CannedResponse response) {
    if (response is CannedListResponse) {
      return jsonEncode(response.items);
    }
    final body = response.body;
    return body == null ? '' : jsonEncode(body);
  }

  Map<String, dynamic> _decodeBody(Object? data) {
    if (data == null) {
      return const <String, dynamic>{};
    }
    if (data is Map<String, dynamic>) {
      return data;
    }
    if (data is Map) {
      return data.map((key, value) => MapEntry(key.toString(), value));
    }
    if (data is String && data.isNotEmpty) {
      final decoded = jsonDecode(data);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    }
    return const <String, dynamic>{};
  }

  /// Normaliza `'get  /api/v1/x'` a `'GET /api/v1/x'`.
  static String _normalizeKey(String key) {
    final separator = key.indexOf(' ');
    if (separator < 0) {
      throw ArgumentError.value(
        key,
        'key',
        'La clave de ruta va como "METODO /path".',
      );
    }
    final method = key.substring(0, separator).toUpperCase();
    final path = key.substring(separator + 1).trim();
    return '$method $path';
  }

  static List<CannedResponse> _asQueue(Object value) {
    if (value is CannedResponse) {
      return <CannedResponse>[value];
    }
    if (value is List<CannedResponse>) {
      if (value.isEmpty) {
        throw ArgumentError.value(
          value,
          'value',
          'La secuencia de respuestas no puede estar vacia.',
        );
      }
      return List<CannedResponse>.of(value);
    }
    throw ArgumentError.value(
      value,
      'value',
      'Se esperaba CannedResponse o List<CannedResponse>.',
    );
  }

  @override
  void close({bool force = false}) {}
}
