// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'clinical_report_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$ClinicalReportState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() generating,
    required TResult Function(ClinicalReport report, bool openedDownload) ready,
    required TResult Function() noData,
    required TResult Function(CauceApiError error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(ClinicalReport report, bool openedDownload)? ready,
    TResult? Function()? noData,
    TResult? Function(CauceApiError error)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(ClinicalReport report, bool openedDownload)? ready,
    TResult Function()? noData,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClinicalReportIdle value) idle,
    required TResult Function(ClinicalReportGenerating value) generating,
    required TResult Function(ClinicalReportReady value) ready,
    required TResult Function(ClinicalReportNoData value) noData,
    required TResult Function(ClinicalReportFailure value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClinicalReportIdle value)? idle,
    TResult? Function(ClinicalReportGenerating value)? generating,
    TResult? Function(ClinicalReportReady value)? ready,
    TResult? Function(ClinicalReportNoData value)? noData,
    TResult? Function(ClinicalReportFailure value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClinicalReportIdle value)? idle,
    TResult Function(ClinicalReportGenerating value)? generating,
    TResult Function(ClinicalReportReady value)? ready,
    TResult Function(ClinicalReportNoData value)? noData,
    TResult Function(ClinicalReportFailure value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClinicalReportStateCopyWith<$Res> {
  factory $ClinicalReportStateCopyWith(
          ClinicalReportState value, $Res Function(ClinicalReportState) then) =
      _$ClinicalReportStateCopyWithImpl<$Res, ClinicalReportState>;
}

/// @nodoc
class _$ClinicalReportStateCopyWithImpl<$Res, $Val extends ClinicalReportState>
    implements $ClinicalReportStateCopyWith<$Res> {
  _$ClinicalReportStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc
abstract class _$$ClinicalReportIdleImplCopyWith<$Res> {
  factory _$$ClinicalReportIdleImplCopyWith(_$ClinicalReportIdleImpl value,
          $Res Function(_$ClinicalReportIdleImpl) then) =
      __$$ClinicalReportIdleImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClinicalReportIdleImplCopyWithImpl<$Res>
    extends _$ClinicalReportStateCopyWithImpl<$Res, _$ClinicalReportIdleImpl>
    implements _$$ClinicalReportIdleImplCopyWith<$Res> {
  __$$ClinicalReportIdleImplCopyWithImpl(_$ClinicalReportIdleImpl _value,
      $Res Function(_$ClinicalReportIdleImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClinicalReportIdleImpl extends ClinicalReportIdle {
  const _$ClinicalReportIdleImpl() : super._();

  @override
  String toString() {
    return 'ClinicalReportState.idle()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$ClinicalReportIdleImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() generating,
    required TResult Function(ClinicalReport report, bool openedDownload) ready,
    required TResult Function() noData,
    required TResult Function(CauceApiError error) failure,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(ClinicalReport report, bool openedDownload)? ready,
    TResult? Function()? noData,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(ClinicalReport report, bool openedDownload)? ready,
    TResult Function()? noData,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClinicalReportIdle value) idle,
    required TResult Function(ClinicalReportGenerating value) generating,
    required TResult Function(ClinicalReportReady value) ready,
    required TResult Function(ClinicalReportNoData value) noData,
    required TResult Function(ClinicalReportFailure value) failure,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClinicalReportIdle value)? idle,
    TResult? Function(ClinicalReportGenerating value)? generating,
    TResult? Function(ClinicalReportReady value)? ready,
    TResult? Function(ClinicalReportNoData value)? noData,
    TResult? Function(ClinicalReportFailure value)? failure,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClinicalReportIdle value)? idle,
    TResult Function(ClinicalReportGenerating value)? generating,
    TResult Function(ClinicalReportReady value)? ready,
    TResult Function(ClinicalReportNoData value)? noData,
    TResult Function(ClinicalReportFailure value)? failure,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class ClinicalReportIdle extends ClinicalReportState {
  const factory ClinicalReportIdle() = _$ClinicalReportIdleImpl;
  const ClinicalReportIdle._() : super._();
}

/// @nodoc
abstract class _$$ClinicalReportGeneratingImplCopyWith<$Res> {
  factory _$$ClinicalReportGeneratingImplCopyWith(
          _$ClinicalReportGeneratingImpl value,
          $Res Function(_$ClinicalReportGeneratingImpl) then) =
      __$$ClinicalReportGeneratingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClinicalReportGeneratingImplCopyWithImpl<$Res>
    extends _$ClinicalReportStateCopyWithImpl<$Res,
        _$ClinicalReportGeneratingImpl>
    implements _$$ClinicalReportGeneratingImplCopyWith<$Res> {
  __$$ClinicalReportGeneratingImplCopyWithImpl(
      _$ClinicalReportGeneratingImpl _value,
      $Res Function(_$ClinicalReportGeneratingImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClinicalReportGeneratingImpl extends ClinicalReportGenerating {
  const _$ClinicalReportGeneratingImpl() : super._();

  @override
  String toString() {
    return 'ClinicalReportState.generating()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicalReportGeneratingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() generating,
    required TResult Function(ClinicalReport report, bool openedDownload) ready,
    required TResult Function() noData,
    required TResult Function(CauceApiError error) failure,
  }) {
    return generating();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(ClinicalReport report, bool openedDownload)? ready,
    TResult? Function()? noData,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return generating?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(ClinicalReport report, bool openedDownload)? ready,
    TResult Function()? noData,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (generating != null) {
      return generating();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClinicalReportIdle value) idle,
    required TResult Function(ClinicalReportGenerating value) generating,
    required TResult Function(ClinicalReportReady value) ready,
    required TResult Function(ClinicalReportNoData value) noData,
    required TResult Function(ClinicalReportFailure value) failure,
  }) {
    return generating(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClinicalReportIdle value)? idle,
    TResult? Function(ClinicalReportGenerating value)? generating,
    TResult? Function(ClinicalReportReady value)? ready,
    TResult? Function(ClinicalReportNoData value)? noData,
    TResult? Function(ClinicalReportFailure value)? failure,
  }) {
    return generating?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClinicalReportIdle value)? idle,
    TResult Function(ClinicalReportGenerating value)? generating,
    TResult Function(ClinicalReportReady value)? ready,
    TResult Function(ClinicalReportNoData value)? noData,
    TResult Function(ClinicalReportFailure value)? failure,
    required TResult orElse(),
  }) {
    if (generating != null) {
      return generating(this);
    }
    return orElse();
  }
}

abstract class ClinicalReportGenerating extends ClinicalReportState {
  const factory ClinicalReportGenerating() = _$ClinicalReportGeneratingImpl;
  const ClinicalReportGenerating._() : super._();
}

/// @nodoc
abstract class _$$ClinicalReportReadyImplCopyWith<$Res> {
  factory _$$ClinicalReportReadyImplCopyWith(_$ClinicalReportReadyImpl value,
          $Res Function(_$ClinicalReportReadyImpl) then) =
      __$$ClinicalReportReadyImplCopyWithImpl<$Res>;
  @useResult
  $Res call({ClinicalReport report, bool openedDownload});
}

/// @nodoc
class __$$ClinicalReportReadyImplCopyWithImpl<$Res>
    extends _$ClinicalReportStateCopyWithImpl<$Res, _$ClinicalReportReadyImpl>
    implements _$$ClinicalReportReadyImplCopyWith<$Res> {
  __$$ClinicalReportReadyImplCopyWithImpl(_$ClinicalReportReadyImpl _value,
      $Res Function(_$ClinicalReportReadyImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? report = null,
    Object? openedDownload = null,
  }) {
    return _then(_$ClinicalReportReadyImpl(
      report: null == report
          ? _value.report
          : report // ignore: cast_nullable_to_non_nullable
              as ClinicalReport,
      openedDownload: null == openedDownload
          ? _value.openedDownload
          : openedDownload // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ClinicalReportReadyImpl extends ClinicalReportReady {
  const _$ClinicalReportReadyImpl(
      {required this.report, required this.openedDownload})
      : super._();

  @override
  final ClinicalReport report;
  @override
  final bool openedDownload;

  @override
  String toString() {
    return 'ClinicalReportState.ready(report: $report, openedDownload: $openedDownload)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicalReportReadyImpl &&
            (identical(other.report, report) || other.report == report) &&
            (identical(other.openedDownload, openedDownload) ||
                other.openedDownload == openedDownload));
  }

  @override
  int get hashCode => Object.hash(runtimeType, report, openedDownload);

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicalReportReadyImplCopyWith<_$ClinicalReportReadyImpl> get copyWith =>
      __$$ClinicalReportReadyImplCopyWithImpl<_$ClinicalReportReadyImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() generating,
    required TResult Function(ClinicalReport report, bool openedDownload) ready,
    required TResult Function() noData,
    required TResult Function(CauceApiError error) failure,
  }) {
    return ready(report, openedDownload);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(ClinicalReport report, bool openedDownload)? ready,
    TResult? Function()? noData,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return ready?.call(report, openedDownload);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(ClinicalReport report, bool openedDownload)? ready,
    TResult Function()? noData,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(report, openedDownload);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClinicalReportIdle value) idle,
    required TResult Function(ClinicalReportGenerating value) generating,
    required TResult Function(ClinicalReportReady value) ready,
    required TResult Function(ClinicalReportNoData value) noData,
    required TResult Function(ClinicalReportFailure value) failure,
  }) {
    return ready(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClinicalReportIdle value)? idle,
    TResult? Function(ClinicalReportGenerating value)? generating,
    TResult? Function(ClinicalReportReady value)? ready,
    TResult? Function(ClinicalReportNoData value)? noData,
    TResult? Function(ClinicalReportFailure value)? failure,
  }) {
    return ready?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClinicalReportIdle value)? idle,
    TResult Function(ClinicalReportGenerating value)? generating,
    TResult Function(ClinicalReportReady value)? ready,
    TResult Function(ClinicalReportNoData value)? noData,
    TResult Function(ClinicalReportFailure value)? failure,
    required TResult orElse(),
  }) {
    if (ready != null) {
      return ready(this);
    }
    return orElse();
  }
}

abstract class ClinicalReportReady extends ClinicalReportState {
  const factory ClinicalReportReady(
      {required final ClinicalReport report,
      required final bool openedDownload}) = _$ClinicalReportReadyImpl;
  const ClinicalReportReady._() : super._();

  ClinicalReport get report;
  bool get openedDownload;

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicalReportReadyImplCopyWith<_$ClinicalReportReadyImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ClinicalReportNoDataImplCopyWith<$Res> {
  factory _$$ClinicalReportNoDataImplCopyWith(_$ClinicalReportNoDataImpl value,
          $Res Function(_$ClinicalReportNoDataImpl) then) =
      __$$ClinicalReportNoDataImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$ClinicalReportNoDataImplCopyWithImpl<$Res>
    extends _$ClinicalReportStateCopyWithImpl<$Res, _$ClinicalReportNoDataImpl>
    implements _$$ClinicalReportNoDataImplCopyWith<$Res> {
  __$$ClinicalReportNoDataImplCopyWithImpl(_$ClinicalReportNoDataImpl _value,
      $Res Function(_$ClinicalReportNoDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
}

/// @nodoc

class _$ClinicalReportNoDataImpl extends ClinicalReportNoData {
  const _$ClinicalReportNoDataImpl() : super._();

  @override
  String toString() {
    return 'ClinicalReportState.noData()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicalReportNoDataImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() generating,
    required TResult Function(ClinicalReport report, bool openedDownload) ready,
    required TResult Function() noData,
    required TResult Function(CauceApiError error) failure,
  }) {
    return noData();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(ClinicalReport report, bool openedDownload)? ready,
    TResult? Function()? noData,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return noData?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(ClinicalReport report, bool openedDownload)? ready,
    TResult Function()? noData,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (noData != null) {
      return noData();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClinicalReportIdle value) idle,
    required TResult Function(ClinicalReportGenerating value) generating,
    required TResult Function(ClinicalReportReady value) ready,
    required TResult Function(ClinicalReportNoData value) noData,
    required TResult Function(ClinicalReportFailure value) failure,
  }) {
    return noData(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClinicalReportIdle value)? idle,
    TResult? Function(ClinicalReportGenerating value)? generating,
    TResult? Function(ClinicalReportReady value)? ready,
    TResult? Function(ClinicalReportNoData value)? noData,
    TResult? Function(ClinicalReportFailure value)? failure,
  }) {
    return noData?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClinicalReportIdle value)? idle,
    TResult Function(ClinicalReportGenerating value)? generating,
    TResult Function(ClinicalReportReady value)? ready,
    TResult Function(ClinicalReportNoData value)? noData,
    TResult Function(ClinicalReportFailure value)? failure,
    required TResult orElse(),
  }) {
    if (noData != null) {
      return noData(this);
    }
    return orElse();
  }
}

abstract class ClinicalReportNoData extends ClinicalReportState {
  const factory ClinicalReportNoData() = _$ClinicalReportNoDataImpl;
  const ClinicalReportNoData._() : super._();
}

/// @nodoc
abstract class _$$ClinicalReportFailureImplCopyWith<$Res> {
  factory _$$ClinicalReportFailureImplCopyWith(
          _$ClinicalReportFailureImpl value,
          $Res Function(_$ClinicalReportFailureImpl) then) =
      __$$ClinicalReportFailureImplCopyWithImpl<$Res>;
  @useResult
  $Res call({CauceApiError error});

  $CauceApiErrorCopyWith<$Res> get error;
}

/// @nodoc
class __$$ClinicalReportFailureImplCopyWithImpl<$Res>
    extends _$ClinicalReportStateCopyWithImpl<$Res, _$ClinicalReportFailureImpl>
    implements _$$ClinicalReportFailureImplCopyWith<$Res> {
  __$$ClinicalReportFailureImplCopyWithImpl(_$ClinicalReportFailureImpl _value,
      $Res Function(_$ClinicalReportFailureImpl) _then)
      : super(_value, _then);

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
  }) {
    return _then(_$ClinicalReportFailureImpl(
      null == error
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as CauceApiError,
    ));
  }

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $CauceApiErrorCopyWith<$Res> get error {
    return $CauceApiErrorCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc

class _$ClinicalReportFailureImpl extends ClinicalReportFailure {
  const _$ClinicalReportFailureImpl(this.error) : super._();

  @override
  final CauceApiError error;

  @override
  String toString() {
    return 'ClinicalReportState.failure(error: $error)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClinicalReportFailureImpl &&
            (identical(other.error, error) || other.error == error));
  }

  @override
  int get hashCode => Object.hash(runtimeType, error);

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ClinicalReportFailureImplCopyWith<_$ClinicalReportFailureImpl>
      get copyWith => __$$ClinicalReportFailureImplCopyWithImpl<
          _$ClinicalReportFailureImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() idle,
    required TResult Function() generating,
    required TResult Function(ClinicalReport report, bool openedDownload) ready,
    required TResult Function() noData,
    required TResult Function(CauceApiError error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? idle,
    TResult? Function()? generating,
    TResult? Function(ClinicalReport report, bool openedDownload)? ready,
    TResult? Function()? noData,
    TResult? Function(CauceApiError error)? failure,
  }) {
    return failure?.call(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? idle,
    TResult Function()? generating,
    TResult Function(ClinicalReport report, bool openedDownload)? ready,
    TResult Function()? noData,
    TResult Function(CauceApiError error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(ClinicalReportIdle value) idle,
    required TResult Function(ClinicalReportGenerating value) generating,
    required TResult Function(ClinicalReportReady value) ready,
    required TResult Function(ClinicalReportNoData value) noData,
    required TResult Function(ClinicalReportFailure value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(ClinicalReportIdle value)? idle,
    TResult? Function(ClinicalReportGenerating value)? generating,
    TResult? Function(ClinicalReportReady value)? ready,
    TResult? Function(ClinicalReportNoData value)? noData,
    TResult? Function(ClinicalReportFailure value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(ClinicalReportIdle value)? idle,
    TResult Function(ClinicalReportGenerating value)? generating,
    TResult Function(ClinicalReportReady value)? ready,
    TResult Function(ClinicalReportNoData value)? noData,
    TResult Function(ClinicalReportFailure value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class ClinicalReportFailure extends ClinicalReportState {
  const factory ClinicalReportFailure(final CauceApiError error) =
      _$ClinicalReportFailureImpl;
  const ClinicalReportFailure._() : super._();

  CauceApiError get error;

  /// Create a copy of ClinicalReportState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ClinicalReportFailureImplCopyWith<_$ClinicalReportFailureImpl>
      get copyWith => throw _privateConstructorUsedError;
}
