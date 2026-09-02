// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'allergy_catalog_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AllergyCatalogItem extends AllergyCatalogItem {
  @override
  final String? allergyId;
  @override
  final String? name;
  @override
  final AllergyType? allergyType;
  @override
  final String? description;

  factory _$AllergyCatalogItem(
          [void Function(AllergyCatalogItemBuilder)? updates]) =>
      (AllergyCatalogItemBuilder()..update(updates))._build();

  _$AllergyCatalogItem._(
      {this.allergyId, this.name, this.allergyType, this.description})
      : super._();
  @override
  AllergyCatalogItem rebuild(
          void Function(AllergyCatalogItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AllergyCatalogItemBuilder toBuilder() =>
      AllergyCatalogItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AllergyCatalogItem &&
        allergyId == other.allergyId &&
        name == other.name &&
        allergyType == other.allergyType &&
        description == other.description;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, allergyId.hashCode);
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, allergyType.hashCode);
    _$hash = $jc(_$hash, description.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AllergyCatalogItem')
          ..add('allergyId', allergyId)
          ..add('name', name)
          ..add('allergyType', allergyType)
          ..add('description', description))
        .toString();
  }
}

class AllergyCatalogItemBuilder
    implements Builder<AllergyCatalogItem, AllergyCatalogItemBuilder> {
  _$AllergyCatalogItem? _$v;

  String? _allergyId;
  String? get allergyId => _$this._allergyId;
  set allergyId(String? allergyId) => _$this._allergyId = allergyId;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  AllergyType? _allergyType;
  AllergyType? get allergyType => _$this._allergyType;
  set allergyType(AllergyType? allergyType) =>
      _$this._allergyType = allergyType;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  AllergyCatalogItemBuilder() {
    AllergyCatalogItem._defaults(this);
  }

  AllergyCatalogItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _allergyId = $v.allergyId;
      _name = $v.name;
      _allergyType = $v.allergyType;
      _description = $v.description;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AllergyCatalogItem other) {
    _$v = other as _$AllergyCatalogItem;
  }

  @override
  void update(void Function(AllergyCatalogItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AllergyCatalogItem build() => _build();

  _$AllergyCatalogItem _build() {
    final _$result = _$v ??
        _$AllergyCatalogItem._(
          allergyId: allergyId,
          name: name,
          allergyType: allergyType,
          description: description,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
