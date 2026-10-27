//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'dart:async';

import 'package:built_value/json_object.dart';
import 'package:built_value/serializer.dart';
import 'package:dio/dio.dart';

import 'package:built_collection/built_collection.dart';
import 'package:cauce_api_client/src/api_util.dart';
import 'package:cauce_api_client/src/model/api_v1_history_get200_response_inner.dart';
import 'package:cauce_api_client/src/model/assigned_patient_summary.dart';
import 'package:cauce_api_client/src/model/get_assigned_patient_detail_result.dart';
import 'package:cauce_api_client/src/model/ibs_sss_cycle_status_dto.dart';
import 'package:cauce_api_client/src/model/patient_evolution_for_nutritionist_result.dart';
import 'package:cauce_api_client/src/model/patient_recommendation_for_nutritionist_dto_paged_result.dart';
import 'package:cauce_api_client/src/model/problem_details.dart';

class NutritionistsApi {

  final Dio _dio;

  final Serializers _serializers;

  const NutritionistsApi(this._dio, this._serializers);

  /// Lista los pacientes activos asignados al nutricionista autenticado.
  /// 
  ///
  /// Parameters:
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BuiltList<AssignedPatientSummary>] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BuiltList<AssignedPatientSummary>>> apiV1NutritionistsMePatientsGet({ 
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/nutritionists/me/patients';
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
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
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    BuiltList<AssignedPatientSummary>? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(BuiltList, [FullType(AssignedPatientSummary)]),
      ) as BuiltList<AssignedPatientSummary>;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BuiltList<AssignedPatientSummary>>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Devuelve las métricas de evolución clínica de un paciente asignado (US21): serie  IBS-SSS, variación respecto de la línea base, respuesta clínica significativa y  frecuencia de registro reciente. Requiere una asignación activa; de lo contrario 403.
  /// 
  ///
  /// Parameters:
  /// * [patientId] - Identificador de la cuenta del paciente.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [PatientEvolutionForNutritionistResult] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<PatientEvolutionForNutritionistResult>> apiV1NutritionistsMePatientsPatientIdEvolutionGet({ 
    required String patientId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/nutritionists/me/patients/{patientId}/evolution'.replaceAll('{' r'patientId' '}', encodeQueryParameter(_serializers, patientId, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
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
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    PatientEvolutionForNutritionistResult? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(PatientEvolutionForNutritionistResult),
      ) as PatientEvolutionForNutritionistResult;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<PatientEvolutionForNutritionistResult>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Devuelve el diario de un paciente asignado (comidas, síntomas y notas clínicas) en un rango de  fechas, del más reciente al más antiguo. Requiere una asignación activa y queda auditado.
  /// Devuelve como máximo 500 comidas y 500 síntomas del rango; las notas clínicas no tienen tope.
  ///
  /// Parameters:
  /// * [patientId] - Identificador de la cuenta del paciente.
  /// * [from] - Inicio del rango, obligatorio e inclusivo, con zona horaria (`Z` u offset). Filtra comidas y síntomas por `clientCreatedAt` y notas por `createdAt`.
  /// * [to] - Fin del rango, obligatorio e inclusivo, con zona horaria y no anterior a `from`.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [BuiltList<ApiV1HistoryGet200ResponseInner>] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<BuiltList<ApiV1HistoryGet200ResponseInner>>> apiV1NutritionistsMePatientsPatientIdHistoryGet({ 
    required String patientId,
    required DateTime from,
    required DateTime to,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/nutritionists/me/patients/{patientId}/history'.replaceAll('{' r'patientId' '}', encodeQueryParameter(_serializers, patientId, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
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
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      r'from': encodeQueryParameter(_serializers, from, const FullType(DateTime)),
      r'to': encodeQueryParameter(_serializers, to, const FullType(DateTime)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    BuiltList<ApiV1HistoryGet200ResponseInner>? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(BuiltList, [FullType(ApiV1HistoryGet200ResponseInner)]),
      ) as BuiltList<ApiV1HistoryGet200ResponseInner>;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<BuiltList<ApiV1HistoryGet200ResponseInner>>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Devuelve el estado del ciclo vigente del cuestionario IBS-SSS de un paciente asignado. Requiere  una asignación activa y queda auditado.
  /// 
  ///
  /// Parameters:
  /// * [patientId] - Identificador de la cuenta del paciente.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [IbsSssCycleStatusDto] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<IbsSssCycleStatusDto>> apiV1NutritionistsMePatientsPatientIdIbsSssCycleGet({ 
    required String patientId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/nutritionists/me/patients/{patientId}/ibs-sss-cycle'.replaceAll('{' r'patientId' '}', encodeQueryParameter(_serializers, patientId, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
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
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    IbsSssCycleStatusDto? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(IbsSssCycleStatusDto),
      ) as IbsSssCycleStatusDto;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<IbsSssCycleStatusDto>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Lista, paginadas, todas las recomendaciones de un paciente asignado: vigentes, en revisión, con  decisión final y archivadas. Requiere una asignación activa y queda auditado.
  /// 
  ///
  /// Parameters:
  /// * [patientId] - Identificador de la cuenta del paciente.
  /// * [page] - Número de página.
  /// * [pageSize] - Tamaño de página, de 1 a 100.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [PatientRecommendationForNutritionistDtoPagedResult] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<PatientRecommendationForNutritionistDtoPagedResult>> apiV1NutritionistsMePatientsPatientIdRecommendationsGet({ 
    required String patientId,
    int? page = 1,
    int? pageSize = 20,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/nutritionists/me/patients/{patientId}/recommendations'.replaceAll('{' r'patientId' '}', encodeQueryParameter(_serializers, patientId, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
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
      validateStatus: validateStatus,
    );

    final _queryParameters = <String, dynamic>{
      if (page != null) r'page': encodeQueryParameter(_serializers, page, const FullType(int)),
      if (pageSize != null) r'pageSize': encodeQueryParameter(_serializers, pageSize, const FullType(int)),
    };

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      queryParameters: _queryParameters,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    PatientRecommendationForNutritionistDtoPagedResult? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(PatientRecommendationForNutritionistDtoPagedResult),
      ) as PatientRecommendationForNutritionistDtoPagedResult;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<PatientRecommendationForNutritionistDtoPagedResult>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

  /// Devuelve el detalle clínico de un paciente asignado. Requiere una asignación  activa con el paciente; de lo contrario responde 403. Si el paciente todavía no completó  su perfil, responde 200 con &#x60;onboardingCompleted: false&#x60; y los campos clínicos en null  (acta A69).
  /// 
  ///
  /// Parameters:
  /// * [patientUserId] - Identificador de la cuenta del paciente.
  /// * [cancelToken] - A [CancelToken] that can be used to cancel the operation
  /// * [headers] - Can be used to add additional headers to the request
  /// * [extras] - Can be used to add flags to the request
  /// * [validateStatus] - A [ValidateStatus] callback that can be used to determine request success based on the HTTP status of the response
  /// * [onSendProgress] - A [ProgressCallback] that can be used to get the send progress
  /// * [onReceiveProgress] - A [ProgressCallback] that can be used to get the receive progress
  ///
  /// Returns a [Future] containing a [Response] with a [GetAssignedPatientDetailResult] as data
  /// Throws [DioException] if API call or serialization fails
  Future<Response<GetAssignedPatientDetailResult>> apiV1NutritionistsMePatientsPatientUserIdGet({ 
    required String patientUserId,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? extra,
    ValidateStatus? validateStatus,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    final _path = r'/api/v1/nutritionists/me/patients/{patientUserId}'.replaceAll('{' r'patientUserId' '}', encodeQueryParameter(_serializers, patientUserId, const FullType(String)).toString());
    final _options = Options(
      method: r'GET',
      headers: <String, dynamic>{
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
      validateStatus: validateStatus,
    );

    final _response = await _dio.request<Object>(
      _path,
      options: _options,
      cancelToken: cancelToken,
      onSendProgress: onSendProgress,
      onReceiveProgress: onReceiveProgress,
    );

    GetAssignedPatientDetailResult? _responseData;

    try {
      final rawResponse = _response.data;
      _responseData = rawResponse == null ? null : _serializers.deserialize(
        rawResponse,
        specifiedType: const FullType(GetAssignedPatientDetailResult),
      ) as GetAssignedPatientDetailResult;

    } catch (error, stackTrace) {
      throw DioException(
        requestOptions: _response.requestOptions,
        response: _response,
        type: DioExceptionType.unknown,
        error: error,
        stackTrace: stackTrace,
      );
    }

    return Response<GetAssignedPatientDetailResult>(
      data: _responseData,
      headers: _response.headers,
      isRedirect: _response.isRedirect,
      requestOptions: _response.requestOptions,
      redirects: _response.redirects,
      statusCode: _response.statusCode,
      statusMessage: _response.statusMessage,
      extra: _response.extra,
    );
  }

}
