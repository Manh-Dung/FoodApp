import 'dart:convert';

import 'package:ints/models/feedback/feedback_product.dart';

import 'package:ints/models/feedback/feedback_product.dart';

import 'package:ints/models/feedback/feedback_product.dart';

import '../image_model/image_model.dart';
import '../product/product.dart';
import '../store/store.dart';

FeedbackUser feedbackUserFromJson(String str) => FeedbackUser.fromJson(json.decode(str));

String feedbackUserToJson(FeedbackUser data) => json.encode(data.toJson());

class FeedbackUser {
  FeedbackUser({
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
    this.store,
    this.orderId,
    this.storeId,
    this.userId,
    this.feedbackId,
    this.feedback,
  });

  FeedbackUser.fromJson(dynamic json) {
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
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    orderId = json['order_id'];
    storeId = json['store_id'];
    userId = json['user_id'];
    feedbackId = json['feedback_id'];
    feedback = json['feedback'] != null ? FeedbackProduct.fromJson(json['feedback']) : null;
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
  Store? store;
  num? orderId;
  num? storeId;
  String? userId;
  num? feedbackId;
  FeedbackProduct? feedback;

  FeedbackUser copyWith({
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
    Store? store,
    num? orderId,
    num? storeId,
    String? userId,
    num? feedbackId,
    FeedbackProduct? feedback,
  }) =>
      FeedbackUser(
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
        store: store ?? this.store,
        orderId: orderId ?? this.orderId,
        storeId: storeId ?? this.storeId,
        userId: userId ?? this.userId,
        feedbackId: feedbackId ?? this.feedbackId,
        feedback: feedback ?? this.feedback,
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
    if (store != null) {
      map['store'] = store?.toJson();
    }
    map['order_id'] = orderId;
    map['store_id'] = storeId;
    map['user_id'] = userId;
    map['feedback_id'] = feedbackId;
    if (feedback != null) {
      map['feedback'] = feedback?.toJson();
    }
    return map;
  }
}

