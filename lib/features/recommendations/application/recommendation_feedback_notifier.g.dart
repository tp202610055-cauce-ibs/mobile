// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_feedback_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recommendationFeedbackFormHash() =>
    r'36b645982ae439c50f94d2ef3358f6e30860d802';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$RecommendationFeedbackForm
    extends BuildlessAutoDisposeNotifier<RecommendationFeedbackFormState> {
  late final String id;

  RecommendationFeedbackFormState build(
    String id,
  );
}

/// Gobierna la respuesta del paciente sobre una recomendacion entregada.
///
/// **Solo en linea** (decision 8). Sin conexion el envio falla con
/// [NetworkError] y la pantalla ofrece reintentar; no hay cola local ni
/// migracion del esquema drift en este bloque. **Sin compuerta de 24 h**
/// (decision 9): el backend no la exige, las 24 h son solo la hora de su
/// recordatorio push.
///
/// Copied from [RecommendationFeedbackForm].
@ProviderFor(RecommendationFeedbackForm)
const recommendationFeedbackFormProvider = RecommendationFeedbackFormFamily();

/// Gobierna la respuesta del paciente sobre una recomendacion entregada.
///
/// **Solo en linea** (decision 8). Sin conexion el envio falla con
/// [NetworkError] y la pantalla ofrece reintentar; no hay cola local ni
/// migracion del esquema drift en este bloque. **Sin compuerta de 24 h**
/// (decision 9): el backend no la exige, las 24 h son solo la hora de su
/// recordatorio push.
///
/// Copied from [RecommendationFeedbackForm].
class RecommendationFeedbackFormFamily
    extends Family<RecommendationFeedbackFormState> {
  /// Gobierna la respuesta del paciente sobre una recomendacion entregada.
  ///
  /// **Solo en linea** (decision 8). Sin conexion el envio falla con
  /// [NetworkError] y la pantalla ofrece reintentar; no hay cola local ni
  /// migracion del esquema drift en este bloque. **Sin compuerta de 24 h**
  /// (decision 9): el backend no la exige, las 24 h son solo la hora de su
  /// recordatorio push.
  ///
  /// Copied from [RecommendationFeedbackForm].
  const RecommendationFeedbackFormFamily();

  /// Gobierna la respuesta del paciente sobre una recomendacion entregada.
  ///
  /// **Solo en linea** (decision 8). Sin conexion el envio falla con
  /// [NetworkError] y la pantalla ofrece reintentar; no hay cola local ni
  /// migracion del esquema drift en este bloque. **Sin compuerta de 24 h**
  /// (decision 9): el backend no la exige, las 24 h son solo la hora de su
  /// recordatorio push.
  ///
  /// Copied from [RecommendationFeedbackForm].
  RecommendationFeedbackFormProvider call(
    String id,
  ) {
    return RecommendationFeedbackFormProvider(
      id,
    );
  }

  @override
  RecommendationFeedbackFormProvider getProviderOverride(
    covariant RecommendationFeedbackFormProvider provider,
  ) {
    return call(
      provider.id,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'recommendationFeedbackFormProvider';
}

/// Gobierna la respuesta del paciente sobre una recomendacion entregada.
///
/// **Solo en linea** (decision 8). Sin conexion el envio falla con
/// [NetworkError] y la pantalla ofrece reintentar; no hay cola local ni
/// migracion del esquema drift en este bloque. **Sin compuerta de 24 h**
/// (decision 9): el backend no la exige, las 24 h son solo la hora de su
/// recordatorio push.
///
/// Copied from [RecommendationFeedbackForm].
class RecommendationFeedbackFormProvider
    extends AutoDisposeNotifierProviderImpl<RecommendationFeedbackForm,
        RecommendationFeedbackFormState> {
  /// Gobierna la respuesta del paciente sobre una recomendacion entregada.
  ///
  /// **Solo en linea** (decision 8). Sin conexion el envio falla con
  /// [NetworkError] y la pantalla ofrece reintentar; no hay cola local ni
  /// migracion del esquema drift en este bloque. **Sin compuerta de 24 h**
  /// (decision 9): el backend no la exige, las 24 h son solo la hora de su
  /// recordatorio push.
  ///
  /// Copied from [RecommendationFeedbackForm].
  RecommendationFeedbackFormProvider(
    String id,
  ) : this._internal(
          () => RecommendationFeedbackForm()..id = id,
          from: recommendationFeedbackFormProvider,
          name: r'recommendationFeedbackFormProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recommendationFeedbackFormHash,
          dependencies: RecommendationFeedbackFormFamily._dependencies,
          allTransitiveDependencies:
              RecommendationFeedbackFormFamily._allTransitiveDependencies,
          id: id,
        );

  RecommendationFeedbackFormProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  RecommendationFeedbackFormState runNotifierBuild(
    covariant RecommendationFeedbackForm notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(RecommendationFeedbackForm Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecommendationFeedbackFormProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<RecommendationFeedbackForm,
      RecommendationFeedbackFormState> createElement() {
    return _RecommendationFeedbackFormProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecommendationFeedbackFormProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RecommendationFeedbackFormRef
    on AutoDisposeNotifierProviderRef<RecommendationFeedbackFormState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _RecommendationFeedbackFormProviderElement
    extends AutoDisposeNotifierProviderElement<RecommendationFeedbackForm,
        RecommendationFeedbackFormState> with RecommendationFeedbackFormRef {
  _RecommendationFeedbackFormProviderElement(super.provider);

  @override
  String get id => (origin as RecommendationFeedbackFormProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
