// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_detail_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$recommendationOriginMemoryHash() =>
    r'ea4aa4939e954ac54a2a367faeda7f32efe9ca34';

/// Una memoria por paciente: otra cuenta en el dispositivo empieza de cero.
///
/// Copied from [recommendationOriginMemory].
@ProviderFor(recommendationOriginMemory)
final recommendationOriginMemoryProvider =
    Provider<RecommendationOriginMemory>.internal(
  recommendationOriginMemory,
  name: r'recommendationOriginMemoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$recommendationOriginMemoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RecommendationOriginMemoryRef = ProviderRef<RecommendationOriginMemory>;
String _$recommendationDetailHash() =>
    r'10d9fa3835cfc4503acb01ff4888ac8fc02e39a6';

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

/// Detalle de una recomendacion.
///
/// Lo leen dos: la tarjeta de la lista, que lo pide para componer su titulo y
/// su pildora porque el resumen no trae items (acta M47), y la pantalla de
/// detalle, que reusa lo ya cargado. **Leerlo no entrega la recomendacion**:
/// eso es [RecommendationDelivery], y solo lo dispara abrir el detalle.
///
/// Copied from [recommendationDetail].
@ProviderFor(recommendationDetail)
const recommendationDetailProvider = RecommendationDetailFamily();

/// Detalle de una recomendacion.
///
/// Lo leen dos: la tarjeta de la lista, que lo pide para componer su titulo y
/// su pildora porque el resumen no trae items (acta M47), y la pantalla de
/// detalle, que reusa lo ya cargado. **Leerlo no entrega la recomendacion**:
/// eso es [RecommendationDelivery], y solo lo dispara abrir el detalle.
///
/// Copied from [recommendationDetail].
class RecommendationDetailFamily
    extends Family<AsyncValue<RecommendationDetail>> {
  /// Detalle de una recomendacion.
  ///
  /// Lo leen dos: la tarjeta de la lista, que lo pide para componer su titulo y
  /// su pildora porque el resumen no trae items (acta M47), y la pantalla de
  /// detalle, que reusa lo ya cargado. **Leerlo no entrega la recomendacion**:
  /// eso es [RecommendationDelivery], y solo lo dispara abrir el detalle.
  ///
  /// Copied from [recommendationDetail].
  const RecommendationDetailFamily();

  /// Detalle de una recomendacion.
  ///
  /// Lo leen dos: la tarjeta de la lista, que lo pide para componer su titulo y
  /// su pildora porque el resumen no trae items (acta M47), y la pantalla de
  /// detalle, que reusa lo ya cargado. **Leerlo no entrega la recomendacion**:
  /// eso es [RecommendationDelivery], y solo lo dispara abrir el detalle.
  ///
  /// Copied from [recommendationDetail].
  RecommendationDetailProvider call(
    String id,
  ) {
    return RecommendationDetailProvider(
      id,
    );
  }

  @override
  RecommendationDetailProvider getProviderOverride(
    covariant RecommendationDetailProvider provider,
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
  String? get name => r'recommendationDetailProvider';
}

/// Detalle de una recomendacion.
///
/// Lo leen dos: la tarjeta de la lista, que lo pide para componer su titulo y
/// su pildora porque el resumen no trae items (acta M47), y la pantalla de
/// detalle, que reusa lo ya cargado. **Leerlo no entrega la recomendacion**:
/// eso es [RecommendationDelivery], y solo lo dispara abrir el detalle.
///
/// Copied from [recommendationDetail].
class RecommendationDetailProvider
    extends AutoDisposeFutureProvider<RecommendationDetail> {
  /// Detalle de una recomendacion.
  ///
  /// Lo leen dos: la tarjeta de la lista, que lo pide para componer su titulo y
  /// su pildora porque el resumen no trae items (acta M47), y la pantalla de
  /// detalle, que reusa lo ya cargado. **Leerlo no entrega la recomendacion**:
  /// eso es [RecommendationDelivery], y solo lo dispara abrir el detalle.
  ///
  /// Copied from [recommendationDetail].
  RecommendationDetailProvider(
    String id,
  ) : this._internal(
          (ref) => recommendationDetail(
            ref as RecommendationDetailRef,
            id,
          ),
          from: recommendationDetailProvider,
          name: r'recommendationDetailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recommendationDetailHash,
          dependencies: RecommendationDetailFamily._dependencies,
          allTransitiveDependencies:
              RecommendationDetailFamily._allTransitiveDependencies,
          id: id,
        );

  RecommendationDetailProvider._internal(
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
    FutureOr<RecommendationDetail> Function(RecommendationDetailRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RecommendationDetailProvider._internal(
        (ref) => create(ref as RecommendationDetailRef),
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
  AutoDisposeFutureProviderElement<RecommendationDetail> createElement() {
    return _RecommendationDetailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecommendationDetailProvider && other.id == id;
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
mixin RecommendationDetailRef
    on AutoDisposeFutureProviderRef<RecommendationDetail> {
  /// The parameter `id` of this provider.
  String get id;
}

class _RecommendationDetailProviderElement
    extends AutoDisposeFutureProviderElement<RecommendationDetail>
    with RecommendationDetailRef {
  _RecommendationDetailProviderElement(super.provider);

  @override
  String get id => (origin as RecommendationDetailProvider).id;
}

String _$recommendationDeliveryHash() =>
    r'fb086726fbc69a9399185a7d35e7eeede6cc0d2a';

abstract class _$RecommendationDelivery
    extends BuildlessAutoDisposeNotifier<DeliveryStatus> {
  late final String id;

  DeliveryStatus build(
    String id,
  );
}

/// Marca una recomendacion como entregada la primera vez que el paciente
/// abre su detalle.
///
/// La dispara **solo** la pantalla de detalle al montarse, nunca la tarjeta
/// de la lista: el pedido del detalle que hace la tarjeta es una lectura
/// silenciosa y no equivale a que el paciente la haya visto.
///
/// Copied from [RecommendationDelivery].
@ProviderFor(RecommendationDelivery)
const recommendationDeliveryProvider = RecommendationDeliveryFamily();

/// Marca una recomendacion como entregada la primera vez que el paciente
/// abre su detalle.
///
/// La dispara **solo** la pantalla de detalle al montarse, nunca la tarjeta
/// de la lista: el pedido del detalle que hace la tarjeta es una lectura
/// silenciosa y no equivale a que el paciente la haya visto.
///
/// Copied from [RecommendationDelivery].
class RecommendationDeliveryFamily extends Family<DeliveryStatus> {
  /// Marca una recomendacion como entregada la primera vez que el paciente
  /// abre su detalle.
  ///
  /// La dispara **solo** la pantalla de detalle al montarse, nunca la tarjeta
  /// de la lista: el pedido del detalle que hace la tarjeta es una lectura
  /// silenciosa y no equivale a que el paciente la haya visto.
  ///
  /// Copied from [RecommendationDelivery].
  const RecommendationDeliveryFamily();

  /// Marca una recomendacion como entregada la primera vez que el paciente
  /// abre su detalle.
  ///
  /// La dispara **solo** la pantalla de detalle al montarse, nunca la tarjeta
  /// de la lista: el pedido del detalle que hace la tarjeta es una lectura
  /// silenciosa y no equivale a que el paciente la haya visto.
  ///
  /// Copied from [RecommendationDelivery].
  RecommendationDeliveryProvider call(
    String id,
  ) {
    return RecommendationDeliveryProvider(
      id,
    );
  }

  @override
  RecommendationDeliveryProvider getProviderOverride(
    covariant RecommendationDeliveryProvider provider,
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
  String? get name => r'recommendationDeliveryProvider';
}

/// Marca una recomendacion como entregada la primera vez que el paciente
/// abre su detalle.
///
/// La dispara **solo** la pantalla de detalle al montarse, nunca la tarjeta
/// de la lista: el pedido del detalle que hace la tarjeta es una lectura
/// silenciosa y no equivale a que el paciente la haya visto.
///
/// Copied from [RecommendationDelivery].
class RecommendationDeliveryProvider extends AutoDisposeNotifierProviderImpl<
    RecommendationDelivery, DeliveryStatus> {
  /// Marca una recomendacion como entregada la primera vez que el paciente
  /// abre su detalle.
  ///
  /// La dispara **solo** la pantalla de detalle al montarse, nunca la tarjeta
  /// de la lista: el pedido del detalle que hace la tarjeta es una lectura
  /// silenciosa y no equivale a que el paciente la haya visto.
  ///
  /// Copied from [RecommendationDelivery].
  RecommendationDeliveryProvider(
    String id,
  ) : this._internal(
          () => RecommendationDelivery()..id = id,
          from: recommendationDeliveryProvider,
          name: r'recommendationDeliveryProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$recommendationDeliveryHash,
          dependencies: RecommendationDeliveryFamily._dependencies,
          allTransitiveDependencies:
              RecommendationDeliveryFamily._allTransitiveDependencies,
          id: id,
        );

  RecommendationDeliveryProvider._internal(
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
  DeliveryStatus runNotifierBuild(
    covariant RecommendationDelivery notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(RecommendationDelivery Function() create) {
    return ProviderOverride(
      origin: this,
      override: RecommendationDeliveryProvider._internal(
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
  AutoDisposeNotifierProviderElement<RecommendationDelivery, DeliveryStatus>
      createElement() {
    return _RecommendationDeliveryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RecommendationDeliveryProvider && other.id == id;
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
mixin RecommendationDeliveryRef
    on AutoDisposeNotifierProviderRef<DeliveryStatus> {
  /// The parameter `id` of this provider.
  String get id;
}

class _RecommendationDeliveryProviderElement
    extends AutoDisposeNotifierProviderElement<RecommendationDelivery,
        DeliveryStatus> with RecommendationDeliveryRef {
  _RecommendationDeliveryProviderElement(super.provider);

  @override
  String get id => (origin as RecommendationDeliveryProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
