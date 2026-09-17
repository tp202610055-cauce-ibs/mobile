// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'consent_download_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$consentPdfSharerHash() => r'7af673c6efa26a56ee17095ccacfe756a397aab2';

/// See also [consentPdfSharer].
@ProviderFor(consentPdfSharer)
final consentPdfSharerProvider = Provider<ConsentPdfSharer>.internal(
  consentPdfSharer,
  name: r'consentPdfSharerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$consentPdfSharerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ConsentPdfSharerRef = ProviderRef<ConsentPdfSharer>;
String _$consentDownloadNotifierHash() =>
    r'b485649eb11ecb93f71b80c62b7132e86e82ab05';

/// Gobierna la descarga del comprobante del consentimiento.
///
/// Copied from [ConsentDownloadNotifier].
@ProviderFor(ConsentDownloadNotifier)
final consentDownloadNotifierProvider = AutoDisposeNotifierProvider<
    ConsentDownloadNotifier, ConsentDownloadState>.internal(
  ConsentDownloadNotifier.new,
  name: r'consentDownloadNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$consentDownloadNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ConsentDownloadNotifier = AutoDisposeNotifier<ConsentDownloadState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
