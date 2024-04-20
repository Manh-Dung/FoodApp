import 'dart:convert';
import '../image_model/image_model.dart';
import '../product/product.dart';

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
  Store({
    this.entity,
    this.id,
    this.userId,
    this.name,
    this.phoneNumber,
    this.addressDetail,
    this.description,
    this.province,
    this.district,
    this.ward,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.coordinatesLat,
    this.coordinatesLong,
    this.totalProduct,
    this.totalFavorite,
    this.product,
  });

  Store.fromJson(dynamic json) {
    entity = json['__entity'];
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    addressDetail = json['address_detail'];
    description = json['description'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    rating = json['rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(ImageModel.fromJson(v));
      });
    }
    coordinatesLat = json['coordinates_lat'];
    coordinatesLong = json['coordinates_long'];
    totalProduct = json['totalProduct'];
    totalFavorite = json['totalFavorite'];
    if (json['products'] != null) {
      product = [];
      json['products'].forEach((v) {
        product?.add(Product.fromJson(v));
      });
    }
  }

  String? entity;
  num? id;
  num? userId;
  String? name;
  String? phoneNumber;
  String? addressDetail;
  dynamic description;
  String? province;
  String? district;
  String? ward;
  num? rating;
  String? createdAt;
  String? updatedAt;
  List<ImageModel>? image;
  dynamic coordinatesLat;
  dynamic coordinatesLong;
  num? totalProduct;
  num? totalFavorite;
  List<Product>? product;

  Store copyWith({
    String? entity,
    num? id,
    num? userId,
    String? name,
    String? phoneNumber,
    String? addressDetail,
    dynamic description,
    String? province,
    String? district,
    String? ward,
    num? rating,
    String? createdAt,
    String? updatedAt,
    List<ImageModel>? image,
    dynamic coordinatesLat,
    dynamic coordinatesLong,
    num? totalProduct,
    num? totalFavorite,
    List<Product>? product,
  }) =>
      Store(
        entity: entity ?? this.entity,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        addressDetail: addressDetail ?? this.addressDetail,
        description: description ?? this.description,
        province: province ?? this.province,
        district: district ?? this.district,
        ward: ward ?? this.ward,
        rating: rating ?? this.rating,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        image: image ?? this.image,
        coordinatesLat: coordinatesLat ?? this.coordinatesLat,
        coordinatesLong: coordinatesLong ?? this.coordinatesLong,
        totalProduct: totalProduct ?? this.totalProduct,
        totalFavorite: totalFavorite ?? this.totalFavorite,
        product: product ?? this.product,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = entity;
    map['id'] = id;
    map['user_id'] = userId;
    map['name'] = name;
    map['phone_number'] = phoneNumber;
    map['address_detail'] = addressDetail;
    map['description'] = description;
    map['province'] = province;
    map['district'] = district;
    map['ward'] = ward;
    map['rating'] = rating;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    map['coordinates_lat'] = coordinatesLat;
    map['coordinates_long'] = coordinatesLong;
    map['totalProduct'] = totalProduct;
    map['totalFavorite'] = totalFavorite;
    if (product != null) {
      map['products'] = product?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}
