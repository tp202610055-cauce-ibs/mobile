//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

import 'package:dio/dio.dart';
import 'package:built_value/serializer.dart';
import 'package:cauce_api_client/src/serializers.dart';
import 'package:cauce_api_client/src/auth/api_key_auth.dart';
import 'package:cauce_api_client/src/auth/basic_auth.dart';
import 'package:cauce_api_client/src/auth/bearer_auth.dart';
import 'package:cauce_api_client/src/auth/oauth.dart';
import 'package:cauce_api_client/src/api/admin_api.dart';
import 'package:cauce_api_client/src/api/allergies_api.dart';
import 'package:cauce_api_client/src/api/auth_api.dart';
import 'package:cauce_api_client/src/api/clinical_notes_api.dart';
import 'package:cauce_api_client/src/api/consent_api.dart';
import 'package:cauce_api_client/src/api/custom_foods_api.dart';
import 'package:cauce_api_client/src/api/foods_api.dart';
import 'package:cauce_api_client/src/api/glossary_api.dart';
import 'package:cauce_api_client/src/api/health_api.dart';
import 'package:cauce_api_client/src/api/history_api.dart';
import 'package:cauce_api_client/src/api/ibs_sss_api.dart';
import 'package:cauce_api_client/src/api/invitations_api.dart';
import 'package:cauce_api_client/src/api/meals_api.dart';
import 'package:cauce_api_client/src/api/nutritionist_recommendations_api.dart';
import 'package:cauce_api_client/src/api/nutritionists_api.dart';
import 'package:cauce_api_client/src/api/patient_recommendations_api.dart';
import 'package:cauce_api_client/src/api/patients_api.dart';
import 'package:cauce_api_client/src/api/recommendations_api.dart';
import 'package:cauce_api_client/src/api/reports_api.dart';
import 'package:cauce_api_client/src/api/symptoms_api.dart';
import 'package:cauce_api_client/src/api/sync_api.dart';
import 'package:cauce_api_client/src/api/users_api.dart';

class CauceApiClient {
  static const String basePath = r'http://localhost';

  final Dio dio;
  final Serializers serializers;

  CauceApiClient({
    Dio? dio,
    Serializers? serializers,
    String? basePathOverride,
    List<Interceptor>? interceptors,
  })  : this.serializers = serializers ?? standardSerializers,
        this.dio = dio ??
            Dio(BaseOptions(
              baseUrl: basePathOverride ?? basePath,
              connectTimeout: const Duration(milliseconds: 5000),
              receiveTimeout: const Duration(milliseconds: 3000),
            )) {
    if (interceptors == null) {
      this.dio.interceptors.addAll([
        OAuthInterceptor(),
        BasicAuthInterceptor(),
        BearerAuthInterceptor(),
        ApiKeyAuthInterceptor(),
      ]);
    } else {
      this.dio.interceptors.addAll(interceptors);
    }
  }

  void setOAuthToken(String name, String token) {
    if (this.dio.interceptors.any((i) => i is OAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is OAuthInterceptor) as OAuthInterceptor).tokens[name] = token;
    }
  }

  void setBearerAuth(String name, String token) {
    if (this.dio.interceptors.any((i) => i is BearerAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BearerAuthInterceptor) as BearerAuthInterceptor).tokens[name] = token;
    }
  }

  void setBasicAuth(String name, String username, String password) {
    if (this.dio.interceptors.any((i) => i is BasicAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((i) => i is BasicAuthInterceptor) as BasicAuthInterceptor).authInfo[name] = BasicAuthInfo(username, password);
    }
  }

  void setApiKey(String name, String apiKey) {
    if (this.dio.interceptors.any((i) => i is ApiKeyAuthInterceptor)) {
      (this.dio.interceptors.firstWhere((element) => element is ApiKeyAuthInterceptor) as ApiKeyAuthInterceptor).apiKeys[name] = apiKey;
    }
  }

  /// Get AdminApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AdminApi getAdminApi() {
    return AdminApi(dio, serializers);
  }

  /// Get AllergiesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AllergiesApi getAllergiesApi() {
    return AllergiesApi(dio, serializers);
  }

  /// Get AuthApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  AuthApi getAuthApi() {
    return AuthApi(dio, serializers);
  }

  /// Get ClinicalNotesApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ClinicalNotesApi getClinicalNotesApi() {
    return ClinicalNotesApi(dio, serializers);
  }

  /// Get ConsentApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ConsentApi getConsentApi() {
    return ConsentApi(dio, serializers);
  }

  /// Get CustomFoodsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  CustomFoodsApi getCustomFoodsApi() {
    return CustomFoodsApi(dio, serializers);
  }

  /// Get FoodsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  FoodsApi getFoodsApi() {
    return FoodsApi(dio, serializers);
  }

  /// Get GlossaryApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  GlossaryApi getGlossaryApi() {
    return GlossaryApi(dio, serializers);
  }

  /// Get HealthApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  HealthApi getHealthApi() {
    return HealthApi(dio, serializers);
  }

  /// Get HistoryApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  HistoryApi getHistoryApi() {
    return HistoryApi(dio, serializers);
  }

  /// Get IbsSssApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  IbsSssApi getIbsSssApi() {
    return IbsSssApi(dio, serializers);
  }

  /// Get InvitationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  InvitationsApi getInvitationsApi() {
    return InvitationsApi(dio, serializers);
  }

  /// Get MealsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  MealsApi getMealsApi() {
    return MealsApi(dio, serializers);
  }

  /// Get NutritionistRecommendationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  NutritionistRecommendationsApi getNutritionistRecommendationsApi() {
    return NutritionistRecommendationsApi(dio, serializers);
  }

  /// Get NutritionistsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  NutritionistsApi getNutritionistsApi() {
    return NutritionistsApi(dio, serializers);
  }

  /// Get PatientRecommendationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PatientRecommendationsApi getPatientRecommendationsApi() {
    return PatientRecommendationsApi(dio, serializers);
  }

  /// Get PatientsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  PatientsApi getPatientsApi() {
    return PatientsApi(dio, serializers);
  }

  /// Get RecommendationsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  RecommendationsApi getRecommendationsApi() {
    return RecommendationsApi(dio, serializers);
  }

  /// Get ReportsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  ReportsApi getReportsApi() {
    return ReportsApi(dio, serializers);
  }

  /// Get SymptomsApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SymptomsApi getSymptomsApi() {
    return SymptomsApi(dio, serializers);
  }

  /// Get SyncApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  SyncApi getSyncApi() {
    return SyncApi(dio, serializers);
  }

  /// Get UsersApi instance, base route and serializer can be overridden by a given but be careful,
  /// by doing that all interceptors will not be executed
  UsersApi getUsersApi() {
    return UsersApi(dio, serializers);
  }
}
