// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_manual_recommendation_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CreateManualRecommendationRequest
    extends CreateManualRecommendationRequest {
  @override
  final String? patientId;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final BuiltList<String>? steps;
  @override
  final String? clinicalNote;
  @override
  final DateTime? validUntil;

  factory _$CreateManualRecommendationRequest(
          [void Function(CreateManualRecommendationRequestBuilder)? updates]) =>
      (CreateManualRecommendationRequestBuilder()..update(updates))._build();

  _$CreateManualRecommendationRequest._(
      {this.patientId,
      this.title,
      this.description,
      this.steps,
      this.clinicalNote,
      this.validUntil})
      : super._();
  @override
  CreateManualRecommendationRequest rebuild(
          void Function(CreateManualRecommendationRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateManualRecommendationRequestBuilder toBuilder() =>
      CreateManualRecommendationRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateManualRecommendationRequest &&
        patientId == other.patientId &&
        title == other.title &&
        description == other.description &&
        steps == other.steps &&
        clinicalNote == other.clinicalNote &&
        validUntil == other.validUntil;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, patientId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jc(_$hash, steps.hashCode);
    _$hash = $jc(_$hash, clinicalNote.hashCode);
    _$hash = $jc(_$hash, validUntil.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateManualRecommendationRequest')
          ..add('patientId', patientId)
          ..add('title', title)
          ..add('description', description)
          ..add('steps', steps)
          ..add('clinicalNote', clinicalNote)
          ..add('validUntil', validUntil))
        .toString();
  }
}

class CreateManualRecommendationRequestBuilder
    implements
        Builder<CreateManualRecommendationRequest,
            CreateManualRecommendationRequestBuilder> {
  _$CreateManualRecommendationRequest? _$v;

  String? _patientId;
  String? get patientId => _$this._patientId;
  set patientId(String? patientId) => _$this._patientId = patientId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ListBuilder<String>? _steps;
  ListBuilder<String> get steps => _$this._steps ??= ListBuilder<String>();
  set steps(ListBuilder<String>? steps) => _$this._steps = steps;

  String? _clinicalNote;
  String? get clinicalNote => _$this._clinicalNote;
  set clinicalNote(String? clinicalNote) => _$this._clinicalNote = clinicalNote;

  DateTime? _validUntil;
  DateTime? get validUntil => _$this._validUntil;
  set validUntil(DateTime? validUntil) => _$this._validUntil = validUntil;

  CreateManualRecommendationRequestBuilder() {
    CreateManualRecommendationRequest._defaults(this);
  }

  CreateManualRecommendationRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _patientId = $v.patientId;
      _title = $v.title;
      _description = $v.description;
      _steps = $v.steps?.toBuilder();
      _clinicalNote = $v.clinicalNote;
      _validUntil = $v.validUntil;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateManualRecommendationRequest other) {
    _$v = other as _$CreateManualRecommendationRequest;
  }

  @override
  void update(
      void Function(CreateManualRecommendationRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateManualRecommendationRequest build() => _build();

  _$CreateManualRecommendationRequest _build() {
    _$CreateManualRecommendationRequest _$result;
    try {
      _$result = _$v ??
          _$CreateManualRecommendationRequest._(
            patientId: patientId,
            title: title,
            description: description,
            steps: _steps?.build(),
            clinicalNote: clinicalNote,
            validUntil: validUntil,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'steps';
        _steps?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateManualRecommendationRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
