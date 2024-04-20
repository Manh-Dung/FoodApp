import 'dart:convert';

ProductOptionAttribute productOptionAttributeFromJson(String str) =>
    ProductOptionAttribute.fromJson(json.decode(str));
String productOptionAttributeToJson(ProductOptionAttribute data) =>
    json.encode(data.toJson());

class ProductOptionAttribute {
  ProductOptionAttribute({
    num? id,
    num? optionId,
    num? productId,
    String? name,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    num? priceId,
  }) {
    _id = id;
    _optionId = optionId;
    _productId = productId;
    _name = name;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _priceId = priceId;
  }

  ProductOptionAttribute.fromJson(dynamic json) {
    _id = json['id'];
    _optionId = json['option_id'];
    _productId = json['product_id'];
    _name = json['name'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _priceId = json['price_id'];
  }

  num? _id;
  num? _optionId;
  num? _productId;
  String? _name;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  num? _priceId;

  ProductOptionAttribute copyWith({
    num? id,
    num? optionId,
    num? productId,
    String? name,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    num? priceId,
  }) =>
      ProductOptionAttribute(
        id: id ?? _id,
        optionId: optionId ?? _optionId,
        productId: productId ?? _productId,
        name: name ?? _name,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        deletedAt: deletedAt ?? _deletedAt,
        priceId: priceId ?? _priceId,
      );

  num? get id => _id;
  num? get optionId => _optionId;
  num? get productId => _productId;
  String? get name => _name;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  num? get priceId => _priceId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['option_id'] = _optionId;
    map['product_id'] = _productId;
    map['name'] = _name;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['price_id'] = _priceId;
    return map;
  }
}
