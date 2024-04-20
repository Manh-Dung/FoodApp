import 'dart:convert';
AddressCity addressFromJson(String str) => AddressCity.fromJson(json.decode(str));
String addressToJson(AddressCity data) => json.encode(data.toJson());
class AddressCity {
  AddressCity({
      this.name, 
      this.slug, 
      this.type, 
      this.nameWithType, 
      this.code,});

  AddressCity.fromJson(dynamic json) {
    name = json['name'];
    slug = json['slug'];
    type = json['type'];
    nameWithType = json['name_with_type'];
    code = json['code'];
  }
  String? name;
  String? slug;
  String? type;
  String? nameWithType;
  String? code;
AddressCity copyWith({  String? name,
  String? slug,
  String? type,
  String? nameWithType,
  String? code,
}) => AddressCity(  name: name ?? this.name,
  slug: slug ?? this.slug,
  type: type ?? this.type,
  nameWithType: nameWithType ?? this.nameWithType,
  code: code ?? this.code,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['slug'] = slug;
    map['type'] = type;
    map['name_with_type'] = nameWithType;
    map['code'] = code;
    return map;
  }

}