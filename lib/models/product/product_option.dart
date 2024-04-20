import 'dart:convert';

import '../image_model/image_model.dart';

ProductOption productOptionFromJson(String str) =>
    ProductOption.fromJson(json.decode(str));
String productOptionToJson(ProductOption data) => json.encode(data.toJson());

class ProductOption {
  ProductOption({
    num? id,
    num? userId,
    num? productId,
    String? name,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    List<ImageModel>? image,
  }) {
    _id = id;
    _userId = userId;
    _productId = productId;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _image = image;
  }

  ProductOption.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _productId = json['product_id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    if (json['image'] != null) {
      _image = [];
      json['image'].forEach((v) {
        _image?.add(ImageModel.fromJson(v));
      });
    }
  }
  num? _id;
  num? _userId;
  num? _productId;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  List<ImageModel>? _image;
  ProductOption copyWith({
    num? id,
    num? userId,
    num? productId,
    String? name,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    List<ImageModel>? image,
  }) =>
      ProductOption(
        id: id ?? _id,
        userId: userId ?? _userId,
        productId: productId ?? _productId,
        name: name ?? _name,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        image: image ?? _image,
      );
  num? get id => _id;
  num? get userId => _userId;
  num? get productId => _productId;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  List<ImageModel>? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['product_id'] = _productId;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    if (_image != null) {
      map['image'] = _image?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

