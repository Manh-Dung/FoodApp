import 'dart:convert';

import '../auth/user.dart';
import '../image_model/image_model.dart';

FeedbackProduct feedbackProductFromJson(String str) => FeedbackProduct.fromJson(json.decode(str));

String feedbackProductToJson(FeedbackProduct data) => json.encode(data.toJson());

class FeedbackProduct {
  FeedbackProduct({
    this.entity,
    this.id,
    this.userId,
    this.productId,
    this.rating,
    this.content,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
    this.image,
    this.cartItem,
  });

  FeedbackProduct.fromJson(dynamic json) {
    entity = json['__entity'];
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    rating = json['rating'];
    content = json['content'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(ImageModel.fromJson(v));
      });
    }
    cartItem = json['__cartItem__'] != null ? CartItem.fromJson(json['__cartItem__']) : null;
  }

  String? entity;
  num? id;
  num? userId;
  num? productId;
  num? rating;
  String? content;
  num? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  User? user;
  List<ImageModel>? image;
  CartItem? cartItem;

  FeedbackProduct copyWith({
    String? entity,
    num? id,
    num? userId,
    num? productId,
    num? rating,
    String? content,
    num? status,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    User? user,
    List<ImageModel>? image,
    CartItem? cartItem,
  }) =>
      FeedbackProduct(
        entity: entity ?? this.entity,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        productId: productId ?? this.productId,
        rating: rating ?? this.rating,
        content: content ?? this.content,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        user: user ?? this.user,
        image: image ?? this.image,
        cartItem: cartItem ?? this.cartItem,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = entity;
    map['id'] = id;
    map['user_id'] = userId;
    map['product_id'] = productId;
    map['rating'] = rating;
    map['content'] = content;
    map['status'] = status;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    if (cartItem != null) {
      map['__cartItem__'] = cartItem?.toJson();
    }
    return map;
  }
}

CartItem cartItemFromJson(String str) => CartItem.fromJson(json.decode(str));

String cartItemToJson(CartItem data) => json.encode(data.toJson());

class CartItem {
  CartItem({
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
    this.orderId,
    this.storeId,
    this.userId,
    this.feedbackId,
  });

  CartItem.fromJson(dynamic json) {
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
    orderId = json['order_id'];
    storeId = json['store_id'];
    userId = json['user_id'];
    feedbackId = json['feedback_id'];
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
  num? orderId;
  num? storeId;
  String? userId;
  num? feedbackId;

  CartItem copyWith({
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
    num? orderId,
    num? storeId,
    String? userId,
    num? feedbackId,
  }) =>
      CartItem(
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
        orderId: orderId ?? this.orderId,
        storeId: storeId ?? this.storeId,
        userId: userId ?? this.userId,
        feedbackId: feedbackId ?? this.feedbackId,
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
    map['order_id'] = orderId;
    map['store_id'] = storeId;
    map['user_id'] = userId;
    map['feedback_id'] = feedbackId;
    return map;
  }
}
