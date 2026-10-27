// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_recommendation_for_nutritionist_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$PatientRecommendationForNutritionistDto
    extends PatientRecommendationForNutritionistDto {
  @override
  final String? recommendationId;
  @override
  final RecommendationStatus? status;
  @override
  final RecommendationSource? source_;
  @override
  final String? title;
  @override
  final int? itemsCount;
  @override
  final DateTime? generatedAt;
  @override
  final DateTime? reviewedAt;
  @override
  final DateTime? expiresAt;
  @override
  final DateTime? validUntil;
  @override
  final bool? isActive;
  @override
  final DateTime? archivedAt;
  @override
  final ArchiveReason? archiveReason;

  factory _$PatientRecommendationForNutritionistDto(
          [void Function(PatientRecommendationForNutritionistDtoBuilder)?
              updates]) =>
      (PatientRecommendationForNutritionistDtoBuilder()..update(updates))
          ._build();

  _$PatientRecommendationForNutritionistDto._(
      {this.recommendationId,
      this.status,
      this.source_,
      this.title,
      this.itemsCount,
      this.generatedAt,
      this.reviewedAt,
      this.expiresAt,
      this.validUntil,
      this.isActive,
      this.archivedAt,
      this.archiveReason})
      : super._();
  @override
  PatientRecommendationForNutritionistDto rebuild(
          void Function(PatientRecommendationForNutritionistDtoBuilder)
              updates) =>
      (toBuilder()..update(updates)).build();

  @override
  PatientRecommendationForNutritionistDtoBuilder toBuilder() =>
      PatientRecommendationForNutritionistDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is PatientRecommendationForNutritionistDto &&
        recommendationId == other.recommendationId &&
        status == other.status &&
        source_ == other.source_ &&
        title == other.title &&
        itemsCount == other.itemsCount &&
        generatedAt == other.generatedAt &&
        reviewedAt == other.reviewedAt &&
        expiresAt == other.expiresAt &&
        validUntil == other.validUntil &&
        isActive == other.isActive &&
        archivedAt == other.archivedAt &&
        archiveReason == other.archiveReason;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recommendationId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, itemsCount.hashCode);
    _$hash = $jc(_$hash, generatedAt.hashCode);
    _$hash = $jc(_$hash, reviewedAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, archiveReason.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(
            r'PatientRecommendationForNutritionistDto')
          ..add('recommendationId', recommendationId)
          ..add('status', status)
          ..add('source_', source_)
          ..add('title', title)
          ..add('itemsCount', itemsCount)
          ..add('generatedAt', generatedAt)
          ..add('reviewedAt', reviewedAt)
          ..add('expiresAt', expiresAt)
          ..add('validUntil', validUntil)
          ..add('isActive', isActive)
          ..add('archivedAt', archivedAt)
          ..add('archiveReason', archiveReason))
        .toString();
  }
}

class PatientRecommendationForNutritionistDtoBuilder
    implements
        Builder<PatientRecommendationForNutritionistDto,
            PatientRecommendationForNutritionistDtoBuilder> {
  _$PatientRecommendationForNutritionistDto? _$v;

  String? _recommendationId;
  String? get recommendationId => _$this._recommendationId;
  set recommendationId(String? recommendationId) =>
      _$this._recommendationId = recommendationId;

  RecommendationStatus? _status;
  RecommendationStatus? get status => _$this._status;
  set status(RecommendationStatus? status) => _$this._status = status;

  RecommendationSource? _source_;
  RecommendationSource? get source_ => _$this._source_;
  set source_(RecommendationSource? source_) => _$this._source_ = source_;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  int? _itemsCount;
  int? get itemsCount => _$this._itemsCount;
  set itemsCount(int? itemsCount) => _$this._itemsCount = itemsCount;

  DateTime? _generatedAt;
  DateTime? get generatedAt => _$this._generatedAt;
  set generatedAt(DateTime? generatedAt) => _$this._generatedAt = generatedAt;

  DateTime? _reviewedAt;
  DateTime? get reviewedAt => _$this._reviewedAt;
  set reviewedAt(DateTime? reviewedAt) => _$this._reviewedAt = reviewedAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  bool? _isActive;
  bool? get isActive => _$this._isActive;
  set isActive(bool? isActive) => _$this._isActive = isActive;

  DateTime? _archivedAt;
  DateTime? get archivedAt => _$this._archivedAt;
  set archivedAt(DateTime? archivedAt) => _$this._archivedAt = archivedAt;

  ArchiveReason? _archiveReason;
  ArchiveReason? get archiveReason => _$this._archiveReason;
  set archiveReason(ArchiveReason? archiveReason) =>
      _$this._archiveReason = archiveReason;

  PatientRecommendationForNutritionistDtoBuilder() {
    PatientRecommendationForNutritionistDto._defaults(this);
  }

  PatientRecommendationForNutritionistDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recommendationId = $v.recommendationId;
      _status = $v.status;
      _source_ = $v.source_;
      _title = $v.title;
      _itemsCount = $v.itemsCount;
      _generatedAt = $v.generatedAt;
      _reviewedAt = $v.reviewedAt;
      _expiresAt = $v.expiresAt;
      _validUntil = $v.validUntil;
      _isActive = $v.isActive;
      _archivedAt = $v.archivedAt;
      _archiveReason = $v.archiveReason;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(PatientRecommendationForNutritionistDto other) {
    _$v = other as _$PatientRecommendationForNutritionistDto;
  }

  @override
  void update(
      void Function(PatientRecommendationForNutritionistDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  PatientRecommendationForNutritionistDto build() => _build();

  _$PatientRecommendationForNutritionistDto _build() {
    final _$result = _$v ??
        _$PatientRecommendationForNutritionistDto._(
          recommendationId: recommendationId,
          status: status,
          source_: source_,
          title: title,
          itemsCount: itemsCount,
          generatedAt: generatedAt,
          reviewedAt: reviewedAt,
          expiresAt: expiresAt,
          validUntil: validUntil,
          isActive: isActive,
          archivedAt: archivedAt,
          archiveReason: archiveReason,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
