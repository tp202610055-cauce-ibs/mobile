// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_symptom_breakdown.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recommendationSymptomBreakdownHash() =>
    r'7aa4f6db27fb21bd5ed2707e50cc66bccb860686';

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

/// Sintomas por tipo en la ventana de respaldo, contados sobre `GET /symptoms`.
/// `null` si no se pueden leer o si no suman el total que dio el servidor.
///
/// Copied from [recommendationSymptomBreakdown].
@ProviderFor(recommendationSymptomBreakdown)
const recommendationSymptomBreakdownProvider =
    RecommendationSymptomBreakdownFamily();

/// Sintomas por tipo en la ventana de respaldo, contados sobre `GET /symptoms`.
/// `null` si no se pueden leer o si no suman el total que dio el servidor.
///
/// Copied from [recommendationSymptomBreakdown].
class RecommendationSymptomBreakdownFamily
    extends Family<AsyncValue<SymptomBreakdown?>> {
  /// Sintomas por tipo en la ventana de respaldo, contados sobre `GET /symptoms`.
  /// `null` si no se pueden leer o si no suman el total que dio el servidor.
  ///
  /// Copied from [recommendationSymptomBreakdown].
  const RecommendationSymptomBreakdownFamily();

  /// Sintomas por tipo en la ventana de respaldo, contados sobre `GET /symptoms`.
  /// `null` si no se pueden leer o si no suman el total que dio el servidor.
  ///
  /// Copied from [recommendationSymptomBreakdown].
  RecommendationSymptomBreakdownProvider call(
    String id,
  ) {
    return RecommendationSymptomBreakdownProvider(
      id,
    );
  }

  @override
  RecommendationSymptomBreakdownProvider getProviderOverride(
    covariant RecommendationSymptomBreakdownProvider provider,
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
  String? get name => r'recommendationSymptomBreakdownProvider';
}

/// Sintomas por tipo en la ventana de respaldo, contados sobre `GET /symptoms`.
/// `null` si no se pueden leer o si no suman el total que dio el servidor.
///
/// Copied from [recommendationSymptomBreakdown].
class RecommendationSymptomBreakdownProvider
    extends AutoDisposeFutureProvider<SymptomBreakdown?> {
  /// Sintomas por tipo en la ventana de respaldo, contados sobre `GET /symptoms`.
  /// `null` si no se pueden leer o si no suman el total que dio el servidor.
  ///
  /// Copied from [recommendationSymptomBreakdown].
  RecommendationSymptomBreakdownProvider(
    String id,
  ) : this._internal(
          (ref) => recommendationSymptomBreakdown(
            ref as RecommendationSymptomBreakdownRef,
            id,
          ),
          from: recommendationSymptomBreakdownProvider,
          name: r'recommendationSymptomBreakdownProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recommendationSymptomBreakdownHash,
          dependencies: RecommendationSymptomBreakdownFamily._dependencies,
          allTransitiveDependencies:
              RecommendationSymptomBreakdownFamily._allTransitiveDependencies,
          id: id,
        );

  RecommendationSymptomBreakdownProvider._internal(
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
  Override overrideWith(
    FutureOr<SymptomBreakdown?> Function(
            RecommendationSymptomBreakdownRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecommendationSymptomBreakdownProvider._internal(
        (ref) => create(ref as RecommendationSymptomBreakdownRef),
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
  AutoDisposeFutureProviderElement<SymptomBreakdown?> createElement() {
    return _RecommendationSymptomBreakdownProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecommendationSymptomBreakdownProvider && other.id == id;
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
mixin RecommendationSymptomBreakdownRef
    on AutoDisposeFutureProviderRef<SymptomBreakdown?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _RecommendationSymptomBreakdownProviderElement
    extends AutoDisposeFutureProviderElement<SymptomBreakdown?>
    with RecommendationSymptomBreakdownRef {
  _RecommendationSymptomBreakdownProviderElement(super.provider);

  @override
  String get id => (origin as RecommendationSymptomBreakdownProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
