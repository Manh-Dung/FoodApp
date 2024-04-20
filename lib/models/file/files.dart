import 'dart:convert';

Files filesFromJson(String str) => Files.fromJson(json.decode(str));

String filesToJson(Files data) => json.encode(data.toJson());

class Files {
  Files({
    String? id,
    String? path,
    String? name,
  }) {
    _id = id;
    _path = path;
    _name = name;
  }

  Files.fromJson(dynamic json) {
    _id = json['id'];
    _path = json['path'];
    _name = json['name'];
  }

  String? _id;
  String? _path;
  String? _name;

  Files copyWith({
    String? id,
    String? path,
    String? name,
  }) =>
      Files(
        id: id ?? _id,
        path: path ?? _path,
        name: name ?? _name,
      );

  String? get id => _id;

  String? get path => _path;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['path'] = _path;
    map['name'] = _name;
    return map;
  }
}
