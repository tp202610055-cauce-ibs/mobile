// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_export_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dataExportLauncherHash() =>
    r'8fc0a8be9a5e85ede8c6526078341baa1a493d12';

/// See also [dataExportLauncher].
@ProviderFor(dataExportLauncher)
final dataExportLauncherProvider = Provider<DataExportLauncher>.internal(
  dataExportLauncher,
  name: r'dataExportLauncherProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dataExportLauncherHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef DataExportLauncherRef = ProviderRef<DataExportLauncher>;
String _$dataExportNotifierHash() =>
    r'7793d62599f8e18de02c84b1387d27e976de56c5';

/// Gobierna la solicitud de exportacion y la apertura de su enlace.
///
/// Copied from [DataExportNotifier].
@ProviderFor(DataExportNotifier)
final dataExportNotifierProvider =
    AutoDisposeNotifierProvider<DataExportNotifier, DataExportState>.internal(
  DataExportNotifier.new,
  name: r'dataExportNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$dataExportNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DataExportNotifier = AutoDisposeNotifier<DataExportState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
