import 'dart:convert';

import '../store/store.dart';

Favorite favoriteFromJson(String str) => Favorite.fromJson(json.decode(str));
String favoriteToJson(Favorite data) => json.encode(data.toJson());

class Favorite {
  Favorite({
    num? id,
    String? userId,
    num? storeId,
    String? createdAt,
    String? updatedAt,
    Store? store,
  }) {
    _id = id;
    _userId = userId;
    _storeId = storeId;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _store = store;
  }

  Favorite.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _storeId = json['store_id'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _store = json['store'] != null ? Store.fromJson(json['store']) : null;
  }
  num? _id;
  String? _userId;
  num? _storeId;
  String? _createdAt;
  String? _updatedAt;
  Store? _store;
  Favorite copyWith({
    num? id,
    String? userId,
    num? storeId,
    String? createdAt,
    String? updatedAt,
    Store? store,
  }) =>
      Favorite(
        id: id ?? _id,
        userId: userId ?? _userId,
        storeId: storeId ?? _storeId,
        createdAt: createdAt ?? _createdAt,
        updatedAt: updatedAt ?? _updatedAt,
        store: store ?? _store,
      );
  num? get id => _id;
  String? get userId => _userId;
  num? get storeId => _storeId;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  Store? get store => _store;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['store_id'] = _storeId;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    if (_store != null) {
      map['store'] = _store?.toJson();
    }
    return map;
  }
}
