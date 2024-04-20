import 'dart:convert';

import '../category/category.dart';
import '../image_model/image_model.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.entity,
    this.id,
    this.categoryId,
    this.storeId,
    this.name,
    this.minPrice,
    this.maxPrice,
    this.minPriceAfterDiscount,
    this.maxPriceAfterDiscount,
    this.vote,
    this.expiry,
    this.dateOfManufacture,
    this.origin,
    this.ingredient,
    this.description,
    this.rating,
    this.quantitySold,
    this.image,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.category,
    this.prices,
  });

  Product.fromJson(dynamic json) {
    entity = json['__entity'];
    id = json['id'];
    categoryId = json['category_id'];
    storeId = json['store_id'];
    name = json['name'];
    minPrice = json['min_price'];
    maxPrice = json['max_price'];
    minPriceAfterDiscount = json['min_price_after_discount'];
    maxPriceAfterDiscount = json['max_price_after_discount'];
    vote = json['vote'];
    expiry = json['expiry'];
    dateOfManufacture = json['date_of_manufacture'];
    origin = json['origin'];
    ingredient = json['ingredient'];
    description = json['description'];
    rating = json['rating'];
    quantitySold = json['quantity_sold'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(ImageModel.fromJson(v));
      });
    }
    if (json['thumbnail'] != null) {
      thumbnail = [];
      json['thumbnail'].forEach((v) {
        thumbnail?.add(ImageModel.fromJson(v));
      });
    }
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['prices'] != null) {
      prices = [];
      json['prices'].forEach((v) {
        prices?.add(Prices.fromJson(v));
      });
    }
  }

  String? entity;
  num? id;
  num? categoryId;
  num? storeId;
  String? name;
  dynamic minPrice;
  dynamic maxPrice;
  dynamic minPriceAfterDiscount;
  dynamic maxPriceAfterDiscount;
  num? vote;
  String? expiry;
  String? dateOfManufacture;
  dynamic origin;
  dynamic ingredient;
  String? description;
  num? rating;
  num? quantitySold;
  List<ImageModel>? image;
  List<ImageModel>? thumbnail;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Category? category;
  List<Prices>? prices;

  Product copyWith({
    String? entity,
    num? id,
    num? categoryId,
    num? storeId,
    String? name,
    dynamic minPrice,
    dynamic maxPrice,
    dynamic minPriceAfterDiscount,
    dynamic maxPriceAfterDiscount,
    num? vote,
    String? expiry,
    String? dateOfManufacture,
    dynamic origin,
    dynamic ingredient,
    String? description,
    num? rating,
    num? quantitySold,
    List<ImageModel>? image,
    List<ImageModel>? thumbnail,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    Category? category,
    List<Prices>? prices,
  }) =>
      Product(
        entity: entity ?? this.entity,
        id: id ?? this.id,
        categoryId: categoryId ?? this.categoryId,
        storeId: storeId ?? this.storeId,
        name: name ?? this.name,
        minPrice: minPrice ?? this.minPrice,
        maxPrice: maxPrice ?? this.maxPrice,
        minPriceAfterDiscount: minPriceAfterDiscount ?? this.minPriceAfterDiscount,
        maxPriceAfterDiscount: maxPriceAfterDiscount ?? this.maxPriceAfterDiscount,
        vote: vote ?? this.vote,
        expiry: expiry ?? this.expiry,
        dateOfManufacture: dateOfManufacture ?? this.dateOfManufacture,
        origin: origin ?? this.origin,
        ingredient: ingredient ?? this.ingredient,
        description: description ?? this.description,
        rating: rating ?? this.rating,
        quantitySold: quantitySold ?? this.quantitySold,
        image: image ?? this.image,
        thumbnail: thumbnail ?? this.thumbnail,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        category: category ?? this.category,
        prices: prices ?? this.prices,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = entity;
    map['id'] = id;
    map['category_id'] = categoryId;
    map['store_id'] = storeId;
    map['name'] = name;
    map['min_price'] = minPrice;
    map['max_price'] = maxPrice;
    map['min_price_after_discount'] = minPriceAfterDiscount;
    map['max_price_after_discount'] = maxPriceAfterDiscount;
    map['vote'] = vote;
    map['expiry'] = expiry;
    map['date_of_manufacture'] = dateOfManufacture;
    map['origin'] = origin;
    map['ingredient'] = ingredient;
    map['description'] = description;
    map['rating'] = rating;
    map['quantity_sold'] = quantitySold;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    if (thumbnail != null) {
      map['thumbnail'] = thumbnail?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (category != null) {
      map['category'] = category?.toJson();
    }
    if (prices != null) {
      map['prices'] = prices?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Prices pricesFromJson(String str) => Prices.fromJson(json.decode(str));

String pricesToJson(Prices data) => json.encode(data.toJson());

class Prices {
  Prices({
    this.id,
    this.productId,
    this.optionAttributeId,
    this.price,
    this.inventory,
    this.discount,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  Prices.fromJson(dynamic json) {
    id = json['id'];
    productId = json['product_id'];
    optionAttributeId = json['option_attribute_id'];
    price = json['price'];
    inventory = json['inventory'];
    discount = json['discount'];
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
  num? userId;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  Prices copyWith({
    num? id,
    num? productId,
    num? optionAttributeId,
    String? price,
    num? inventory,
    String? discount,
    num? userId,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
  }) =>
      Prices(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        optionAttributeId: optionAttributeId ?? this.optionAttributeId,
        price: price ?? this.price,
        inventory: inventory ?? this.inventory,
        discount: discount ?? this.discount,
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
    map['user_id'] = userId;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    return map;
  }
}

