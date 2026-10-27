// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_reset_link_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$passwordResetLinkHash() => r'c8d02389c589925dcf4f9437301b4a20519096b3';

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

/// Valida el token del deep link antes de mostrar el formulario (US07).
///
/// Solo un token rechazado por el servidor cierra el paso; un fallo de red deja
/// ver el formulario y la confirmación informa el error.
///
/// Copied from [passwordResetLink].
@ProviderFor(passwordResetLink)
const passwordResetLinkProvider = PasswordResetLinkFamily();

/// Valida el token del deep link antes de mostrar el formulario (US07).
///
/// Solo un token rechazado por el servidor cierra el paso; un fallo de red deja
/// ver el formulario y la confirmación informa el error.
///
/// Copied from [passwordResetLink].
class PasswordResetLinkFamily
    extends Family<AsyncValue<PasswordResetLinkStatus>> {
  /// Valida el token del deep link antes de mostrar el formulario (US07).
  ///
  /// Solo un token rechazado por el servidor cierra el paso; un fallo de red deja
  /// ver el formulario y la confirmación informa el error.
  ///
  /// Copied from [passwordResetLink].
  const PasswordResetLinkFamily();

  /// Valida el token del deep link antes de mostrar el formulario (US07).
  ///
  /// Solo un token rechazado por el servidor cierra el paso; un fallo de red deja
  /// ver el formulario y la confirmación informa el error.
  ///
  /// Copied from [passwordResetLink].
  PasswordResetLinkProvider call(
    String token,
  ) {
    return PasswordResetLinkProvider(
      token,
    );
  }

  @override
  PasswordResetLinkProvider getProviderOverride(
    covariant PasswordResetLinkProvider provider,
  ) {
    return call(
      provider.token,
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
  String? get name => r'passwordResetLinkProvider';
}

/// Valida el token del deep link antes de mostrar el formulario (US07).
///
/// Solo un token rechazado por el servidor cierra el paso; un fallo de red deja
/// ver el formulario y la confirmación informa el error.
///
/// Copied from [passwordResetLink].
class PasswordResetLinkProvider
    extends AutoDisposeFutureProvider<PasswordResetLinkStatus> {
  /// Valida el token del deep link antes de mostrar el formulario (US07).
  ///
  /// Solo un token rechazado por el servidor cierra el paso; un fallo de red deja
  /// ver el formulario y la confirmación informa el error.
  ///
  /// Copied from [passwordResetLink].
  PasswordResetLinkProvider(
    String token,
  ) : this._internal(
          (ref) => passwordResetLink(
            ref as PasswordResetLinkRef,
            token,
          ),
          from: passwordResetLinkProvider,
          name: r'passwordResetLinkProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$passwordResetLinkHash,
          dependencies: PasswordResetLinkFamily._dependencies,
          allTransitiveDependencies:
              PasswordResetLinkFamily._allTransitiveDependencies,
          token: token,
        );

  PasswordResetLinkProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.token,
  }) : super.internal();

  final String token;

  @override
  Override overrideWith(
    FutureOr<PasswordResetLinkStatus> Function(PasswordResetLinkRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PasswordResetLinkProvider._internal(
        (ref) => create(ref as PasswordResetLinkRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        token: token,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PasswordResetLinkStatus> createElement() {
    return _PasswordResetLinkProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PasswordResetLinkProvider && other.token == token;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, token.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PasswordResetLinkRef
    on AutoDisposeFutureProviderRef<PasswordResetLinkStatus> {
  /// The parameter `token` of this provider.
  String get token;
}

class _PasswordResetLinkProviderElement
    extends AutoDisposeFutureProviderElement<PasswordResetLinkStatus>
    with PasswordResetLinkRef {
  _PasswordResetLinkProviderElement(super.provider);

  @override
  String get token => (origin as PasswordResetLinkProvider).token;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
