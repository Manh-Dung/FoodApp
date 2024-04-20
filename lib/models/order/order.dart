import 'dart:convert';

import '../cart/cart.dart';
import '../store/store.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.entity,
    this.id,
    this.userId,
    this.storeId,
    this.note,
    this.status,
    this.typePayment,
    this.totalMoney,
    this.feeShipping,
    this.fullname,
    this.phoneNumber,
    this.addressDetail,
    this.province,
    this.district,
    this.ward,
    this.expectedShippingDate,
    this.actualShippingDate,
    this.point,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.store,
    this.cartItems,
    this.orderCode,
  });

  Order.fromJson(dynamic json) {
    entity = json['__entity'];
    id = json['id'];
    userId = json['user_id'];
    storeId = json['store_id'];
    note = json['note'];
    status = json['status'];
    typePayment = json['type_payment'];
    totalMoney = json['total_money'];
    feeShipping = json['fee_shipping'];
    fullname = json['fullname'];
    phoneNumber = json['phone_number'];
    addressDetail = json['address_detail'];
    province = json['province'];
    district = json['district'];
    ward = json['ward'];
    expectedShippingDate = json['expected_shipping_date'];
    actualShippingDate = json['actual_shipping_date'];
    point = json['point'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    store = json['store'] != null ? Store.fromJson(json['store']) : null;
    if (json['cartItems'] != null) {
      cartItems = [];
      json['cartItems'].forEach((v) {
        cartItems?.add(CartItems.fromJson(v));
      });
    }
    orderCode = json['order_code'];
  }

  String? entity;
  num? id;
  num? userId;
  num? storeId;
  String? note;
  String? status;
  String? typePayment;
  String? totalMoney;
  String? feeShipping;
  String? fullname;
  String? phoneNumber;
  String? addressDetail;
  String? province;
  String? district;
  String? ward;
  String? expectedShippingDate;
  dynamic actualShippingDate;
  num? point;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  Store? store;
  List<CartItems>? cartItems;
  String? orderCode;

  Order copyWith({
    String? entity,
    num? id,
    num? userId,
    num? storeId,
    String? note,
    String? status,
    String? typePayment,
    String? totalMoney,
    String? feeShipping,
    String? fullname,
    String? phoneNumber,
    String? addressDetail,
    String? province,
    String? district,
    String? ward,
    String? expectedShippingDate,
    dynamic actualShippingDate,
    num? point,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    Store? store,
    List<CartItems>? cartItems,
    String? orderCode,
  }) =>
      Order(
        entity: entity ?? this.entity,
        id: id ?? this.id,
        userId: userId ?? this.userId,
        storeId: storeId ?? this.storeId,
        note: note ?? this.note,
        status: status ?? this.status,
        typePayment: typePayment ?? this.typePayment,
        totalMoney: totalMoney ?? this.totalMoney,
        feeShipping: feeShipping ?? this.feeShipping,
        fullname: fullname ?? this.fullname,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        addressDetail: addressDetail ?? this.addressDetail,
        province: province ?? this.province,
        district: district ?? this.district,
        ward: ward ?? this.ward,
        expectedShippingDate: expectedShippingDate ?? this.expectedShippingDate,
        actualShippingDate: actualShippingDate ?? this.actualShippingDate,
        point: point ?? this.point,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        store: store ?? this.store,
        cartItems: cartItems ?? this.cartItems,
        orderCode: orderCode ?? this.orderCode,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = entity;
    map['id'] = id;
    map['user_id'] = userId;
    map['store_id'] = storeId;
    map['note'] = note;
    map['status'] = status;
    map['type_payment'] = typePayment;
    map['total_money'] = totalMoney;
    map['fee_shipping'] = feeShipping;
    map['fullname'] = fullname;
    map['phone_number'] = phoneNumber;
    map['address_detail'] = addressDetail;
    map['province'] = province;
    map['district'] = district;
    map['ward'] = ward;
    map['expected_shipping_date'] = expectedShippingDate;
    map['actual_shipping_date'] = actualShippingDate;
    map['point'] = point;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['deleted_at'] = deletedAt;
    if (store != null) {
      map['store'] = store?.toJson();
    }
    if (cartItems != null) {
      map['cartItems'] = cartItems?.map((v) => v.toJson()).toList();
    }
    map['order_code'] = orderCode;
    return map;
  }
}
