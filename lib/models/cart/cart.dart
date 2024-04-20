import 'dart:convert';

import '../product/product.dart';
import '../store/store.dart';

Cart cartFromJson(String str) => Cart.fromJson(json.decode(str));

String cartToJson(Cart data) => json.encode(data.toJson());

class Cart {
  Cart({
    this.entity,
    this.id,
    this.userId,
    this.storeId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.cartItems,
    this.store,
  });

  Cart.fromJson(dynamic json) {
    entity = json['__entity'];
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['cart_items'] != null) {
      cartItems = [];
      json['cart_items'].forEach((v) {
        cartItems?.add(CartItems.fromJson(v));
      });
    }
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }

  String? entity;
  num? id;
  num? userId;
  num? storeId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<CartItems>? cartItems;
  Store? store;

  Cart copyWith({
    String? entity,
    num? id,
    num? userId,
    num? storeId,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    List<CartItems>? cartItems,
    Store? store,
  }) =>
      Cart(
        entity: entity ?? this.entity,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        storeId: storeId ?? this.storeId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        cartItems: cartItems ?? this.cartItems,
        store: store ?? this.store,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = entity;
    map['id'] = id;
    map['user_id'] = userId;
    map['store_id'] = storeId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (cartItems != null) {
      map['cart_items'] = cartItems?.map((v) => v.toJson()).toList();
    }
    if (store != null) {
      map['store'] = store?.toJson();
    }
    return map;
  }
}

CartItems cartItemsFromJson(String str) => CartItems.fromJson(json.decode(str));

String cartItemsToJson(CartItems data) => json.encode(data.toJson());

class CartItems {
  CartItems({
    this.entity,
    this.id,
    this.cartId,
    this.productId,
    this.priceId,
    this.optionName,
    this.productName,
    this.optionAttributesName,
    this.quantity,
    this.priceAtPurchase,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.product,
    this.orderId,
    this.storeId,
    this.userId,
    this.feedbackId,
    this.price,
  });

  CartItems.fromJson(dynamic json) {
    entity = json['__entity'];
    id = json['id'];
    cartId = json['cart_id'];
    productId = json['product_id'];
    priceId = json['price_id'];
    optionName = json['option_name'];
    productName = json['product_name'];
    optionAttributesName = json['option_attributes_name'];
    quantity = json['quantity'];
    priceAtPurchase = json['price_at_purchase'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    orderId = json['order_id'];
    storeId = json['store_id'];
    userId = json['user_id'];
    feedbackId = json['feedback_id'];
    price = json['price'] != null ? Price.fromJson(json['price']) : null;
  }

  String? entity;
  num? id;
  num? cartId;
  num? productId;
  num? priceId;
  String? optionName;
  String? productName;
  String? optionAttributesName;
  num? quantity;
  num? priceAtPurchase;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Product? product;
  num? orderId;
  num? storeId;
  String? userId;
  dynamic feedbackId;
  Price? price;

  CartItems copyWith({
    String? entity,
    num? id,
    num? cartId,
    num? productId,
    num? priceId,
    String? optionName,
    String? productName,
    String? optionAttributesName,
    num? quantity,
    num? priceAtPurchase,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    Product? product,
    num? orderId,
    num? storeId,
    String? userId,
    dynamic feedbackId,
    Price? price,
  }) =>
      CartItems(
        entity: entity ?? this.entity,
        id: id ?? this.id,
        cartId: cartId ?? this.cartId,
        productId: productId ?? this.productId,
        priceId: priceId ?? this.priceId,
        optionName: optionName ?? this.optionName,
        productName: productName ?? this.productName,
        optionAttributesName: optionAttributesName ?? this.optionAttributesName,
        quantity: quantity ?? this.quantity,
        priceAtPurchase: priceAtPurchase ?? this.priceAtPurchase,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        product: product ?? this.product,
        orderId: orderId ?? this.orderId,
        storeId: storeId ?? this.storeId,
        userId: userId ?? this.userId,
        feedbackId: feedbackId ?? this.feedbackId,
        price: price ?? this.price,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = entity;
    map['id'] = id;
    map['cart_id'] = cartId;
    map['product_id'] = productId;
    map['price_id'] = priceId;
    map['option_name'] = optionName;
    map['product_name'] = productName;
    map['option_attributes_name'] = optionAttributesName;
    map['quantity'] = quantity;
    map['price_at_purchase'] = priceAtPurchase;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (product != null) {
      map['product'] = product?.toJson();
    }
    map['order_id'] = orderId;
    map['store_id'] = storeId;
    map['user_id'] = userId;
    map['feedback_id'] = feedbackId;
    if (price != null) {
      map['price'] = price?.toJson();
    }
    return map;
  }
}

Price priceFromJson(String str) => Price.fromJson(json.decode(str));

String priceToJson(Price data) => json.encode(data.toJson());

class Price {
  Price({
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

  Price.fromJson(dynamic json) {
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

  Price copyWith({
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
      Price(
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