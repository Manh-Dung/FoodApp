import 'dart:convert';
AddressDistrict addressDistrictFromJson(String str) => AddressDistrict.fromJson(json.decode(str));
String addressDistrictToJson(AddressDistrict data) => json.encode(data.toJson());
class AddressDistrict {
  AddressDistrict({
      this.name, 
      this.type, 
      this.slug, 
      this.nameWithType, 
      this.path, 
      this.pathWithType, 
      this.code, 
      this.parentCode,});

  AddressDistrict.fromJson(dynamic json) {
    name = json['name'];
    type = json['type'];
    slug = json['slug'];
    nameWithType = json['name_with_type'];
    path = json['path'];
    pathWithType = json['path_with_type'];
    code = json['code'];
    parentCode = json['parent_code'];
  }
  String? name;
  String? type;
  String? slug;
  String? nameWithType;
  String? path;
  String? pathWithType;
  String? code;
  String? parentCode;
AddressDistrict copyWith({  String? name,
  String? type,
  String? slug,
  String? nameWithType,
  String? path,
  String? pathWithType,
  String? code,
  String? parentCode,
}) => AddressDistrict(  name: name ?? this.name,
  type: type ?? this.type,
  slug: slug ?? this.slug,
  nameWithType: nameWithType ?? this.nameWithType,
  path: path ?? this.path,
  pathWithType: pathWithType ?? this.pathWithType,
  code: code ?? this.code,
  parentCode: parentCode ?? this.parentCode,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['type'] = type;
    map['slug'] = slug;
    map['name_with_type'] = nameWithType;
    map['path'] = path;
    map['path_with_type'] = pathWithType;
    map['code'] = code;
    map['parent_code'] = parentCode;
    return map;
  }

}