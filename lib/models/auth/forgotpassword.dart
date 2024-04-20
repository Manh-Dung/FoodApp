import 'dart:convert';
Forgotpassword forgotpasswordFromJson(String str) => Forgotpassword.fromJson(json.decode(str));
String forgotpasswordToJson(Forgotpassword data) => json.encode(data.toJson());
class Forgotpassword {
  Forgotpassword({
      this.userId,});

  Forgotpassword.fromJson(dynamic json) {
    userId = json['user_id'];
  }
  num? userId;
Forgotpassword copyWith({  num? userId,
}) => Forgotpassword(  userId: userId ?? this.userId,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = userId;
    return map;
  }

}