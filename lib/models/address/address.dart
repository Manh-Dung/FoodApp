import 'dart:convert';

Address addressFromJson(String str) => Address.fromJson(json.decode(str));

String addressToJson(Address data) => json.encode(data.toJson());

class Address {
  Address({
    String? entity,
    num? id,
    num? userId,
    String? fullName,
    String? phoneNumber,
    String? addressDetail,
    String? province,
    String? district,
    String? ward,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    num? isDefault,
    num? type,
    num? coordinatesLat,
    num? coordinatesLong,
  }) {
    _entity = entity;
    _id = id;
    _userId = userId;
    _fullName = fullName;
    _phoneNumber = phoneNumber;
    _addressDetail = addressDetail;
    _province = province;
    _district = district;
    _ward = ward;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _isDefault = isDefault;
    _type = type;
    _coordinatesLat = coordinatesLat;
    _coordinatesLong = coordinatesLong;
  }

  Address.fromJson(dynamic json) {
    _entity = json['__entity'];
    _id = json['id'];
    _userId = json['user_id'];
    _fullName = json['full_name'];
    _phoneNumber = json['phone_number'];
    _addressDetail = json['address_detail'];
    _province = json['province'];
    _district = json['district'];
    _ward = json['ward'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _isDefault = json['is_default'];
    _type = json['type'];
    _coordinatesLat = json['coordinates_lat'];
    _coordinatesLong = json['coordinates_long'];
  }

  String? _entity;
  num? _id;
  num? _userId;
  String? _fullName;
  String? _phoneNumber;
  String? _addressDetail;
  String? _province;
  String? _district;
  String? _ward;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  num? _isDefault;
  num? _type;
  num? _coordinatesLat;
  num? _coordinatesLong;

  Address copyWith({
    String? entity,
    num? id,
    num? userId,
    String? fullName,
    String? phoneNumber,
    String? addressDetail,
    String? province,
    String? district,
    String? ward,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    num? isDefault,
    num? type,
    num? coordinatesLat,
    num? coordinatesLong,
  }) =>
      Address(
        entity: entity ?? _entity,
        id: id ?? _id,
        userId: userId ?? _userId,
        fullName: fullName ?? _fullName,
        phoneNumber: phoneNumber ?? _phoneNumber,
        addressDetail: addressDetail ?? _addressDetail,
        province: province ?? _province,
        district: district ?? _district,
        ward: ward ?? _ward,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        isDefault: isDefault ?? _isDefault,
        type: type ?? _type,
        coordinatesLat: coordinatesLat ?? _coordinatesLat,
        coordinatesLong: coordinatesLong ?? _coordinatesLong,
      );

  String? get entity => _entity;
  num? get id => _id;
  num? get userId => _userId;
  String? get fullName => _fullName;
  String? get phoneNumber => _phoneNumber;
  String? get addressDetail => _addressDetail;
  String? get province => _province;
  String? get district => _district;
  String? get ward => _ward;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  num? get isDefault => _isDefault;
  num? get type => _type;
  num? get coordinatesLat => _coordinatesLat;
  num? get coordinatesLong => _coordinatesLong;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = _entity;
    map['id'] = _id;
    map['user_id'] = _userId;
    map['full_name'] = _fullName;
    map['phone_number'] = _phoneNumber;
    map['address_detail'] = _addressDetail;
    map['province'] = _province;
    map['district'] = _district;
    map['ward'] = _ward;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['is_default'] = _isDefault;
    map['type'] = _type;
    map['coordinates_lat'] = _coordinatesLat;
    map['coordinates_long'] = _coordinatesLong;
    return map;
  }
}
