import 'dart:convert';

import '../image_model/image_model.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.entity,
    this.id,
    this.email,
    this.phoneNumber,
    this.point,
    this.provider,
    this.socialId,
    this.fileId,
    this.fullName,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.image,
  });

  User.fromJson(dynamic json) {
    entity = json['__entity'];
    id = json['id'];
    email = json['email'];
    phoneNumber = json['phone_number'];
    point = json['point'];
    provider = json['provider'];
    socialId = json['socialId'];
    fileId = json['fileId'];
    fullName = json['fullName'];
    role = json['role'] != null ? Role.fromJson(json['role']) : null;
    status = json['status'] != null ? Status.fromJson(json['status']) : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    if (json['image'] != null) {
      image = [];
      json['image'].forEach((v) {
        image?.add(ImageModel.fromJson(v));
      });
    }
  }

  String? entity;
  num? id;
  String? email;
  String? phoneNumber;
  num? point;
  String? provider;
  dynamic socialId;
  dynamic fileId;
  String? fullName;
  Role? role;
  Status? status;
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;
  List<ImageModel>? image;

  User copyWith({
    String? entity,
    num? id,
    String? email,
    String? phoneNumber,
    num? point,
    String? provider,
    dynamic socialId,
    dynamic fileId,
    String? fullName,
    Role? role,
    Status? status,
    String? createdAt,
    String? updatedAt,
    dynamic deletedAt,
    List<ImageModel>? image,
  }) =>
      User(
        entity: entity ?? this.entity,
        id: id ?? this.id,
        email: email ?? this.email,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        point: point ?? this.point,
        provider: provider ?? this.provider,
        socialId: socialId ?? this.socialId,
        fileId: fileId ?? this.fileId,
        fullName: fullName ?? this.fullName,
        role: role ?? this.role,
        status: status ?? this.status,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        image: image ?? this.image,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = entity;
    map['id'] = id;
    map['email'] = email;
    map['phone_number'] = phoneNumber;
    map['point'] = point;
    map['provider'] = provider;
    map['socialId'] = socialId;
    map['fileId'] = fileId;
    map['fullName'] = fullName;
    if (role != null) {
      map['role'] = role?.toJson();
    }
    if (status != null) {
      map['status'] = status?.toJson();
    }
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['deletedAt'] = deletedAt;
    if (image != null) {
      map['image'] = image?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

Status statusFromJson(String str) => Status.fromJson(json.decode(str));

String statusToJson(Status data) => json.encode(data.toJson());

class Status {
  Status({
    this.entity,
    this.id,
    this.name,
  });

  Status.fromJson(dynamic json) {
    entity = json['__entity'];
    id = json['id'];
    name = json['name'];
  }

  String? entity;
  num? id;
  String? name;

  Status copyWith({
    String? entity,
    num? id,
    String? name,
  }) =>
      Status(
        entity: entity ?? this.entity,
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = entity;
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}

Role roleFromJson(String str) => Role.fromJson(json.decode(str));

String roleToJson(Role data) => json.encode(data.toJson());

class Role {
  Role({
    this.entity,
    this.id,
    this.name,
  });

  Role.fromJson(dynamic json) {
    entity = json['__entity'];
    id = json['id'];
    name = json['name'];
  }

  String? entity;
  num? id;
  String? name;

  Role copyWith({
    String? entity,
    num? id,
    String? name,
  }) =>
      Role(
        entity: entity ?? this.entity,
        id: id ?? this.id,
        name: name ?? this.name,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = entity;
    map['id'] = id;
    map['name'] = name;
    return map;
  }
}
