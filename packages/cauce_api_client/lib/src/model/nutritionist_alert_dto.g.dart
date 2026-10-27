// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutritionist_alert_dto.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$NutritionistAlertDto extends NutritionistAlertDto {
  @override
  final String? id;
  @override
  final NutritionistAlertType? type;
  @override
  final String? patientId;
  @override
  final String? patientName;
  @override
  final String? patientCode;
  @override
  final String? message;
  @override
  final DateTime? occurredAt;
  @override
  final bool? isRead;
  @override
  final DateTime? readAt;

  factory _$NutritionistAlertDto(
          [void Function(NutritionistAlertDtoBuilder)? updates]) =>
      (NutritionistAlertDtoBuilder()..update(updates))._build();

  _$NutritionistAlertDto._(
      {this.id,
      this.type,
      this.patientId,
      this.patientName,
      this.patientCode,
      this.message,
      this.occurredAt,
      this.isRead,
      this.readAt})
      : super._();
  @override
  NutritionistAlertDto rebuild(
          void Function(NutritionistAlertDtoBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  NutritionistAlertDtoBuilder toBuilder() =>
      NutritionistAlertDtoBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is NutritionistAlertDto &&
        id == other.id &&
        type == other.type &&
        patientId == other.patientId &&
        patientName == other.patientName &&
        patientCode == other.patientCode &&
        message == other.message &&
        occurredAt == other.occurredAt &&
        isRead == other.isRead &&
        readAt == other.readAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, patientId.hashCode);
    _$hash = $jc(_$hash, patientName.hashCode);
    _$hash = $jc(_$hash, patientCode.hashCode);
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jc(_$hash, occurredAt.hashCode);
    _$hash = $jc(_$hash, isRead.hashCode);
    _$hash = $jc(_$hash, readAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'NutritionistAlertDto')
          ..add('id', id)
          ..add('type', type)
          ..add('patientId', patientId)
          ..add('patientName', patientName)
          ..add('patientCode', patientCode)
          ..add('message', message)
          ..add('occurredAt', occurredAt)
          ..add('isRead', isRead)
          ..add('readAt', readAt))
        .toString();
  }
}

class NutritionistAlertDtoBuilder
    implements Builder<NutritionistAlertDto, NutritionistAlertDtoBuilder> {
  _$NutritionistAlertDto? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  NutritionistAlertType? _type;
  NutritionistAlertType? get type => _$this._type;
  set type(NutritionistAlertType? type) => _$this._type = type;

  String? _patientId;
  String? get patientId => _$this._patientId;
  set patientId(String? patientId) => _$this._patientId = patientId;

  String? _patientName;
  String? get patientName => _$this._patientName;
  set patientName(String? patientName) => _$this._patientName = patientName;

  String? _patientCode;
  String? get patientCode => _$this._patientCode;
  set patientCode(String? patientCode) => _$this._patientCode = patientCode;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  DateTime? _occurredAt;
  DateTime? get occurredAt => _$this._occurredAt;
  set occurredAt(DateTime? occurredAt) => _$this._occurredAt = occurredAt;

  bool? _isRead;
  bool? get isRead => _$this._isRead;
  set isRead(bool? isRead) => _$this._isRead = isRead;

  DateTime? _readAt;
  DateTime? get readAt => _$this._readAt;
  set readAt(DateTime? readAt) => _$this._readAt = readAt;

  NutritionistAlertDtoBuilder() {
    NutritionistAlertDto._defaults(this);
  }

  NutritionistAlertDtoBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _type = $v.type;
      _patientId = $v.patientId;
      _patientName = $v.patientName;
      _patientCode = $v.patientCode;
      _message = $v.message;
      _occurredAt = $v.occurredAt;
      _isRead = $v.isRead;
      _readAt = $v.readAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(NutritionistAlertDto other) {
    _$v = other as _$NutritionistAlertDto;
  }

  @override
  void update(void Function(NutritionistAlertDtoBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  NutritionistAlertDto build() => _build();

  _$NutritionistAlertDto _build() {
    final _$result = _$v ??
        _$NutritionistAlertDto._(
          id: id,
          type: type,
          patientId: patientId,
          patientName: patientName,
          patientCode: patientCode,
          message: message,
          occurredAt: occurredAt,
          isRead: isRead,
          readAt: readAt,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
