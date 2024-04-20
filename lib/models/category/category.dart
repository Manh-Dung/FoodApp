import 'dart:convert';
Category categoryFromJson(String str) => Category.fromJson(json.decode(str));
String categoryToJson(Category data) => json.encode(data.toJson());
class Category {
  Category({
      num? id, 
      String? name, 
      String? description, 
      dynamic images, 
      String? createdAt, 
      String? updatedAt, 
      dynamic deletedAt, 
      String? entity,}){
    _id = id;
    _name = name;
    _description = description;
    _images = images;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
    _deletedAt = deletedAt;
    _entity = entity;
}

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _description = json['description'];
    _images = json['images'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
    _deletedAt = json['deleted_at'];
    _entity = json['__entity'];
  }
  num? _id;
  String? _name;
  String? _description;
  dynamic _images;
  String? _createdAt;
  String? _updatedAt;
  dynamic _deletedAt;
  String? _entity;
Category copyWith({  num? id,
  String? name,
  String? description,
  dynamic images,
  String? createdAt,
  String? updatedAt,
  dynamic deletedAt,
  String? entity,
}) => Category(  id: id ?? _id,
  name: name ?? _name,
  description: description ?? _description,
  images: images ?? _images,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
  deletedAt: deletedAt ?? _deletedAt,
  entity: entity ?? _entity,
);
  num? get id => _id;
  String? get name => _name;
  String? get description => _description;
  dynamic get images => _images;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;
  dynamic get deletedAt => _deletedAt;
  String? get entity => _entity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['description'] = _description;
    map['images'] = _images;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    map['deleted_at'] = _deletedAt;
    map['__entity'] = _entity;
    return map;
  }

}