import 'dart:convert';

AttributePrice attributePriceFromJson(String str) =>
    AttributePrice.fromJson(json.decode(str));

String attributePriceToJson(AttributePrice data) => json.encode(data.toJson());

class AttributePrice {
  AttributePrice({
    this.id,
    this.productId,
    this.optionAttributeId,
    this.price,
    this.inventory,
    this.discount,
    this.point,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  AttributePrice.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    optionAttributeId = json['option_attribute_id'];
    price = json['price'];
    inventory = json['inventory'];
    discount = json['discount'];
    point = json['point'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
  }

  num? id;
  num? productId;
  num? optionAttributeId;
  String? price;
  num? inventory;
  String? discount;
  num? point;
  num? userId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  AttributePrice copyWith({
    num? id,
    num? productId,
    num? optionAttributeId,
    String? price,
    num? inventory,
    String? discount,
    num? point,
    num? userId,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      AttributePrice(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        optionAttributeId: optionAttributeId ?? this.optionAttributeId,
        price: price ?? this.price,
        inventory: inventory ?? this.inventory,
        discount: discount ?? this.discount,
        point: point ?? this.point,
        userId: userId ?? this.userId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['product_id'] = productId;
    map['option_attribute_id'] = optionAttributeId;
    map['price'] = price;
    map['inventory'] = inventory;
    map['discount'] = discount;
    map['point'] = point;
    map['user_id'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }
}
