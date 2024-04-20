import 'dart:convert';

ImageModel imageModelFromJson(String str) => ImageModel.fromJson(json.decode(str));

String imageModelToJson(ImageModel data) => json.encode(data.toJson());

class ImageModel {
  ImageModel({
    this.name,
    this.path,
  });

  ImageModel.fromJson(dynamic json) {
    name = json['name'];
    path = json['path'];
  }

  String? name;
  String? path;

  ImageModel copyWith({
    String? name,
    String? path,
  }) =>
      ImageModel(
        name: name ?? this.name,
        path: path ?? this.path,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['path'] = path;
    return map;
  }
}
