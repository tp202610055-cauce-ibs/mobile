// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'glossary_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$glossaryRepositoryHash() =>
    r'9556a10993ff20e65de9227a092b1bc7657c796e';

/// See also [glossaryRepository].
@ProviderFor(glossaryRepository)
final glossaryRepositoryProvider = Provider<GlossaryRepository>.internal(
  glossaryRepository,
  name: r'glossaryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$glossaryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GlossaryRepositoryRef = ProviderRef<GlossaryRepository>;
String _$glossaryCatalogHash() => r'e63ede00c5c58ead3c6719d728414a1ee76c8b86';

/// Glosario completo, pedido una vez y cacheado en memoria.
///
/// `keepAlive` porque el contenido no cambia durante la sesion y volver a
/// pedirlo cada vez que se abre la pantalla costaria una peticion sin ganar
/// nada. El reintento, ante un fallo, pasa por `ref.invalidate`.
///
/// Copied from [glossaryCatalog].
@ProviderFor(glossaryCatalog)
final glossaryCatalogProvider = FutureProvider<GlossaryCatalog>.internal(
  glossaryCatalog,
  name: r'glossaryCatalogProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$glossaryCatalogHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GlossaryCatalogRef = FutureProviderRef<GlossaryCatalog>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
