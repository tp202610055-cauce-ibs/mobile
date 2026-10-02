// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_detail_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$RecommendationDetailDto extends RecommendationDetailDto {
  @override
  final String? recommendationId;
  @override
  final String? patientId;
  @override
  final String? modelVersionName;
  @override
  final RecommendationStatus? status;
  @override
  final double? confidenceScore;
  @override
  final bool? autoApproved;
  @override
  final String? reviewedByNutritionistId;
  @override
  final String? nutritionistNote;
  @override
  final String? aiExplanation;
  @override
  final ExplanationSource? explanationSource;
  @override
  final DateTime? generatedAt;
  @override
  final DateTime? reviewedAt;
  @override
  final DateTime? deliveredAt;
  @override
  final DateTime? expiresAt;
  @override
  final BuiltList<RecommendationItemDto>? items;
  @override
  final RecommendationFeedbackDto? feedback;
  @override
  final String? reviewedByNutritionistName;
  @override
  final BuiltList<String>? steps;
  @override
  final RecommendationSupportingDataDto? supportingData;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final RecommendationSource? source_;
  @override
  final bool? isActive;
  @override
  final DateTime? archivedAt;
  @override
  final ArchiveReason? archiveReason;
  @override
  final DateTime? validUntil;

  factory _$RecommendationDetailDto(
          [void Function(RecommendationDetailDtoBuilder)? updates]) =>
      (RecommendationDetailDtoBuilder()..update(updates))._build();

  _$RecommendationDetailDto._(
      {this.recommendationId,
      this.patientId,
      this.modelVersionName,
      this.status,
      this.confidenceScore,
      this.autoApproved,
      this.reviewedByNutritionistId,
      this.nutritionistNote,
      this.aiExplanation,
      this.explanationSource,
      this.generatedAt,
      this.reviewedAt,
      this.deliveredAt,
      this.expiresAt,
      this.items,
      this.feedback,
      this.reviewedByNutritionistName,
      this.steps,
      this.supportingData,
      this.title,
      this.description,
      this.source_,
      this.isActive,
      this.archivedAt,
      this.archiveReason,
      this.validUntil})
      : super._();
  @override
  RecommendationDetailDto rebuild(
          void Function(RecommendationDetailDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  RecommendationDetailDtoBuilder toBuilder() =>
      RecommendationDetailDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is RecommendationDetailDto &&
        recommendationId == other.recommendationId &&
        patientId == other.patientId &&
        modelVersionName == other.modelVersionName &&
        status == other.status &&
        confidenceScore == other.confidenceScore &&
        autoApproved == other.autoApproved &&
        reviewedByNutritionistId == other.reviewedByNutritionistId &&
        nutritionistNote == other.nutritionistNote &&
        aiExplanation == other.aiExplanation &&
        explanationSource == other.explanationSource &&
        generatedAt == other.generatedAt &&
        reviewedAt == other.reviewedAt &&
        deliveredAt == other.deliveredAt &&
        expiresAt == other.expiresAt &&
        items == other.items &&
        feedback == other.feedback &&
        reviewedByNutritionistName == other.reviewedByNutritionistName &&
        steps == other.steps &&
        supportingData == other.supportingData &&
        title == other.title &&
        description == other.description &&
        source_ == other.source_ &&
        isActive == other.isActive &&
        archivedAt == other.archivedAt &&
        archiveReason == other.archiveReason &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, recommendationId.hashCode);
    _$hash = $jc(_$hash, patientId.hashCode);
    _$hash = $jc(_$hash, modelVersionName.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, confidenceScore.hashCode);
    _$hash = $jc(_$hash, autoApproved.hashCode);
    _$hash = $jc(_$hash, reviewedByNutritionistId.hashCode);
    _$hash = $jc(_$hash, nutritionistNote.hashCode);
    _$hash = $jc(_$hash, aiExplanation.hashCode);
    _$hash = $jc(_$hash, explanationSource.hashCode);
    _$hash = $jc(_$hash, generatedAt.hashCode);
    _$hash = $jc(_$hash, reviewedAt.hashCode);
    _$hash = $jc(_$hash, deliveredAt.hashCode);
    _$hash = $jc(_$hash, expiresAt.hashCode);
    _$hash = $jc(_$hash, items.hashCode);
    _$hash = $jc(_$hash, feedback.hashCode);
    _$hash = $jc(_$hash, reviewedByNutritionistName.hashCode);
    _$hash = $jc(_$hash, steps.hashCode);
    _$hash = $jc(_$hash, supportingData.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, source_.hashCode);
    _$hash = $jc(_$hash, isActive.hashCode);
    _$hash = $jc(_$hash, archivedAt.hashCode);
    _$hash = $jc(_$hash, archiveReason.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'RecommendationDetailDto')
          ..add('recommendationId', recommendationId)
          ..add('patientId', patientId)
          ..add('modelVersionName', modelVersionName)
          ..add('status', status)
          ..add('confidenceScore', confidenceScore)
          ..add('autoApproved', autoApproved)
          ..add('reviewedByNutritionistId', reviewedByNutritionistId)
          ..add('nutritionistNote', nutritionistNote)
          ..add('aiExplanation', aiExplanation)
          ..add('explanationSource', explanationSource)
          ..add('generatedAt', generatedAt)
          ..add('reviewedAt', reviewedAt)
          ..add('deliveredAt', deliveredAt)
          ..add('expiresAt', expiresAt)
          ..add('items', items)
          ..add('feedback', feedback)
          ..add('reviewedByNutritionistName', reviewedByNutritionistName)
          ..add('steps', steps)
          ..add('supportingData', supportingData)
          ..add('title', title)
          ..add('description', description)
          ..add('source_', source_)
          ..add('isActive', isActive)
          ..add('archivedAt', archivedAt)
          ..add('archiveReason', archiveReason)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class RecommendationDetailDtoBuilder
    implements
        Builder<RecommendationDetailDto, RecommendationDetailDtoBuilder> {
  _$RecommendationDetailDto? _$v;

  String? _recommendationId;
  String? get recommendationId => _$this._recommendationId;
  set recommendationId(String? recommendationId) =>
      _$this._recommendationId = recommendationId;

  String? _patientId;
  String? get patientId => _$this._patientId;
  set patientId(String? patientId) => _$this._patientId = patientId;

  String? _modelVersionName;
  String? get modelVersionName => _$this._modelVersionName;
  set modelVersionName(String? modelVersionName) =>
      _$this._modelVersionName = modelVersionName;

  RecommendationStatus? _status;
  RecommendationStatus? get status => _$this._status;
  set status(RecommendationStatus? status) => _$this._status = status;

  double? _confidenceScore;
  double? get confidenceScore => _$this._confidenceScore;
  set confidenceScore(double? confidenceScore) =>
      _$this._confidenceScore = confidenceScore;

  bool? _autoApproved;
  bool? get autoApproved => _$this._autoApproved;
  set autoApproved(bool? autoApproved) => _$this._autoApproved = autoApproved;

  String? _reviewedByNutritionistId;
  String? get reviewedByNutritionistId => _$this._reviewedByNutritionistId;
  set reviewedByNutritionistId(String? reviewedByNutritionistId) =>
      _$this._reviewedByNutritionistId = reviewedByNutritionistId;

  String? _nutritionistNote;
  String? get nutritionistNote => _$this._nutritionistNote;
  set nutritionistNote(String? nutritionistNote) =>
      _$this._nutritionistNote = nutritionistNote;

  String? _aiExplanation;
  String? get aiExplanation => _$this._aiExplanation;
  set aiExplanation(String? aiExplanation) =>
      _$this._aiExplanation = aiExplanation;

  ExplanationSource? _explanationSource;
  ExplanationSource? get explanationSource => _$this._explanationSource;
  set explanationSource(ExplanationSource? explanationSource) =>
      _$this._explanationSource = explanationSource;

  DateTime? _generatedAt;
  DateTime? get generatedAt => _$this._generatedAt;
  set generatedAt(DateTime? generatedAt) => _$this._generatedAt = generatedAt;

  DateTime? _reviewedAt;
  DateTime? get reviewedAt => _$this._reviewedAt;
  set reviewedAt(DateTime? reviewedAt) => _$this._reviewedAt = reviewedAt;

  DateTime? _deliveredAt;
  DateTime? get deliveredAt => _$this._deliveredAt;
  set deliveredAt(DateTime? deliveredAt) => _$this._deliveredAt = deliveredAt;

  DateTime? _expiresAt;
  DateTime? get expiresAt => _$this._expiresAt;
  set expiresAt(DateTime? expiresAt) => _$this._expiresAt = expiresAt;

  ListBuilder<RecommendationItemDto>? _items;
  ListBuilder<RecommendationItemDto> get items =>
      _$this._items ??= ListBuilder<RecommendationItemDto>();
  set items(ListBuilder<RecommendationItemDto>? items) => _$this._items = items;

  RecommendationFeedbackDtoBuilder? _feedback;
  RecommendationFeedbackDtoBuilder get feedback =>
      _$this._feedback ??= RecommendationFeedbackDtoBuilder();
  set feedback(RecommendationFeedbackDtoBuilder? feedback) =>
      _$this._feedback = feedback;

  String? _reviewedByNutritionistName;
  String? get reviewedByNutritionistName => _$this._reviewedByNutritionistName;
  set reviewedByNutritionistName(String? reviewedByNutritionistName) =>
      _$this._reviewedByNutritionistName = reviewedByNutritionistName;

  ListBuilder<String>? _steps;
  ListBuilder<String> get steps => _$this._steps ??= ListBuilder<String>();
  set steps(ListBuilder<String>? steps) => _$this._steps = steps;

  RecommendationSupportingDataDtoBuilder? _supportingData;
  RecommendationSupportingDataDtoBuilder get supportingData =>
      _$this._supportingData ??= RecommendationSupportingDataDtoBuilder();
  set supportingData(RecommendationSupportingDataDtoBuilder? supportingData) =>
      _$this._supportingData = supportingData;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  RecommendationSource? _source_;
  RecommendationSource? get source_ => _$this._source_;
  set source_(RecommendationSource? source_) => _$this._source_ = source_;

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

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  RecommendationDetailDtoBuilder() {
    RecommendationDetailDto._defaults(this);
  }

  RecommendationDetailDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _recommendationId = $v.recommendationId;
      _patientId = $v.patientId;
      _modelVersionName = $v.modelVersionName;
      _status = $v.status;
      _confidenceScore = $v.confidenceScore;
      _autoApproved = $v.autoApproved;
      _reviewedByNutritionistId = $v.reviewedByNutritionistId;
      _nutritionistNote = $v.nutritionistNote;
      _aiExplanation = $v.aiExplanation;
      _explanationSource = $v.explanationSource;
      _generatedAt = $v.generatedAt;
      _reviewedAt = $v.reviewedAt;
      _deliveredAt = $v.deliveredAt;
      _expiresAt = $v.expiresAt;
      _items = $v.items?.toBuilder();
      _feedback = $v.feedback?.toBuilder();
      _reviewedByNutritionistName = $v.reviewedByNutritionistName;
      _steps = $v.steps?.toBuilder();
      _supportingData = $v.supportingData?.toBuilder();
      _title = $v.title;
      _description = $v.description;
      _source_ = $v.source_;
      _isActive = $v.isActive;
      _archivedAt = $v.archivedAt;
      _archiveReason = $v.archiveReason;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(RecommendationDetailDto other) {
    _$v = other as _$RecommendationDetailDto;
  }

  @override
  void update(void Function(RecommendationDetailDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  RecommendationDetailDto build() => _build();

  _$RecommendationDetailDto _build() {
    _$RecommendationDetailDto _$result;
    try {
      _$result = _$v ??
          _$RecommendationDetailDto._(
            recommendationId: recommendationId,
            patientId: patientId,
            modelVersionName: modelVersionName,
            status: status,
            confidenceScore: confidenceScore,
            autoApproved: autoApproved,
            reviewedByNutritionistId: reviewedByNutritionistId,
            nutritionistNote: nutritionistNote,
            aiExplanation: aiExplanation,
            explanationSource: explanationSource,
            generatedAt: generatedAt,
            reviewedAt: reviewedAt,
            deliveredAt: deliveredAt,
            expiresAt: expiresAt,
            items: _items?.build(),
            feedback: _feedback?.build(),
            reviewedByNutritionistName: reviewedByNutritionistName,
            steps: _steps?.build(),
            supportingData: _supportingData?.build(),
            title: title,
            description: description,
            source_: source_,
            isActive: isActive,
            archivedAt: archivedAt,
            archiveReason: archiveReason,
            validUntil: validUntil,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        _items?.build();
        _$failedField = 'feedback';
        _feedback?.build();

        _$failedField = 'steps';
        _steps?.build();
        _$failedField = 'supportingData';
        _supportingData?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'RecommendationDetailDto', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
