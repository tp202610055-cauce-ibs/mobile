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
class CannedHttpAdapter implements HttpClientAdapter {
  CannedHttpAdapter([this.response = const CannedResponse.noContent()]);

  CannedResponse response;

  final List<CapturedRequest> requests = <CapturedRequest>[];

  CapturedRequest get lastRequest => requests.last;

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

    final body = response.body;
    return ResponseBody.fromString(
      body == null ? '' : jsonEncode(body),
      response.statusCode,
      headers: <String, List<String>>{
        Headers.contentTypeHeader: <String>[Headers.jsonContentType],
        ...response.headers,
      },
    );
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

  @override
  void close({bool force = false}) {}
}
