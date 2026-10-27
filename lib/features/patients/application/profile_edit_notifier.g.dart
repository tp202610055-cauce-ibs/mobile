// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_edit_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$editableProfileHash() => r'cfe7c6848e22a09a9f194d3db634d54c01d54d6c';

/// Perfil clínico con los valores que el formulario de edición parte.
///
/// Copied from [editableProfile].
@ProviderFor(editableProfile)
final editableProfileProvider =
    AutoDisposeFutureProvider<PatientProfile?>.internal(
  editableProfile,
  name: r'editableProfileProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$editableProfileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef EditableProfileRef = AutoDisposeFutureProviderRef<PatientProfile?>;
String _$profileEditNotifierHash() =>
    r'fcad3be66218ec8237d8fdd89092ba10666c3f33';

/// Guarda peso, estatura y subtipo, y recarga lo que el Perfil dibuja.
///
/// Copied from [ProfileEditNotifier].
@ProviderFor(ProfileEditNotifier)
final profileEditNotifierProvider =
    AutoDisposeNotifierProvider<ProfileEditNotifier, ProfileEditState>.internal(
  ProfileEditNotifier.new,
  name: r'profileEditNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$profileEditNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ProfileEditNotifier = AutoDisposeNotifier<ProfileEditState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
