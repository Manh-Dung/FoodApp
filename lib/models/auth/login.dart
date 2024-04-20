import 'dart:convert';

import 'package:ints/models/auth/user.dart';

Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

class Login {
  Login({
    this.refreshToken,
    this.token,
    this.tokenExpires,
    this.user,
  });

  Login.fromJson(dynamic json) {
    refreshToken = json['refreshToken'];
    token = json['token'];
    tokenExpires = json['tokenExpires'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? refreshToken;
  String? token;
  num? tokenExpires;
  User? user;

  Login copyWith({
    String? refreshToken,
    String? token,
    num? tokenExpires,
    User? user,
  }) =>
      Login(
        refreshToken: refreshToken ?? this.refreshToken,
        token: token ?? this.token,
        tokenExpires: tokenExpires ?? this.tokenExpires,
        user: user ?? this.user,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['refreshToken'] = refreshToken;
    map['token'] = token;
    map['tokenExpires'] = tokenExpires;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}

Status statusFromJson(String str) => Status.fromJson(json.decode(str));
String statusToJson(Status data) => json.encode(data.toJson());

class Status {
  Status({
    String? entity,
    num? id,
    String? name,
  }) {
    _entity = entity;
    _id = id;
    _name = name;
  }

  Status.fromJson(dynamic json) {
    _entity = json['__entity'];
    _id = json['id'];
    _name = json['name'];
  }
  String? _entity;
  num? _id;
  String? _name;
  Status copyWith({
    String? entity,
    num? id,
    String? name,
  }) =>
      Status(
        entity: entity ?? _entity,
        id: id ?? _id,
        name: name ?? _name,
      );
  String? get entity => _entity;
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = _entity;
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

Role roleFromJson(String str) => Role.fromJson(json.decode(str));
String roleToJson(Role data) => json.encode(data.toJson());

class Role {
  Role({
    String? entity,
    num? id,
    String? name,
  }) {
    _entity = entity;
    _id = id;
    _name = name;
  }

  Role.fromJson(dynamic json) {
    _entity = json['__entity'];
    _id = json['id'];
    _name = json['name'];
  }
  String? _entity;
  num? _id;
  String? _name;
  Role copyWith({
    String? entity,
    num? id,
    String? name,
  }) =>
      Role(
        entity: entity ?? _entity,
        id: id ?? _id,
        name: name ?? _name,
      );
  String? get entity => _entity;
  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__entity'] = _entity;
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}
