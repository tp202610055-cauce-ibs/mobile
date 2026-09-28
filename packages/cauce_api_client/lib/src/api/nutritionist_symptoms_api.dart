//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:cauce_api_client/src/api_util.dart';
import 'package:cauce_api_client/src/model/problem_details.dart';
import 'package:cauce_api_client/src/model/set_symptom_meal_association_request.dart';

class NutritionistSymptomsApi {

  final Dio _dio;

  final Serializers _serializers;

  const NutritionistSymptomsApi(this._dio, this._serializers);

  /// Corrige a mano la comida asociada a un síntoma de un paciente asignado: con &#x60;mealId&#x60; la fija a  esa comida, sin sujeción a la ventana de 4 horas; con &#x60;mealId: null&#x60; la desvincula. La comida  debe ser del mismo paciente. Requiere el header &#x60;Idempotency-Key&#x60;.
  /// 
  ///
  /// Parameters:
  /// * [id] - Identificador del síntoma.
  /// * [idempotencyKey] - Clave de idempotencia del header `Idempotency-Key`.
  /// * [setSymptomMealAssociationRequest] - Comida que se asocia, o null para desvincular.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future]
  /// Throws [DioException] if API call or serialization fails
  Future<Response<void>> apiV1SymptomsIdMealAssociationPut({ 
    required String id,
    String? idempotencyKey,
    SetSymptomMealAssociationRequest? setSymptomMealAssociationRequest,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/symptoms/{id}/meal-association'.replaceAll('{' r'id' '}', encodeQueryParameter(_serializers, id, const FullType(String)).toString());
    final _options = Options(
      method: r'PUT',
      headers: <String, dynamic>{
        if (idempotencyKey != null) r'Idempotency-Key': idempotencyKey,
        ...?headers,
      },
      extra: <String, dynamic>{
        'secure': <Map<String, String>>[
          {
            'type': 'http',
            'scheme': 'bearer',
            'name': 'Bearer',
          },
        ],
        ...?extra,
      },
      contentType: 'application/json',
      validateStatus: validateStatus,
    );

    dynamic _bodyData;

    try {
      const _type = FullType(SetSymptomMealAssociationRequest);
      _bodyData = setSymptomMealAssociationRequest == null ? null : _serializers.serialize(setSymptomMealAssociationRequest, specifiedType: _type);

    } catch(error, stackTrace) {
      throw DioException(
         requestOptions: _options.compose(
          _dio.options,
          _path,
        ),
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    final _response = await _dio.request<Object>(
      _path,
      data: _bodyData,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    return _response;
  }

}
