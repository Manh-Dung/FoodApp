import 'dart:convert';

PostFeedback postFeedbackFromJson(String str) => PostFeedback.fromJson(json.decode(str));

String postFeedbackToJson(PostFeedback data) => json.encode(data.toJson());

class PostFeedback {
  PostFeedback({
    this.productId,
    this.priceId,
    this.image,
    this.rating,
    this.content,
  });

  PostFeedback.fromJson(dynamic json) {
    productId = json['product_id'];
    priceId = json['price_id'];
    image = json['image'] != null ? json['image'].cast<String>() : [];
    rating = json['rating'];
    content = json['content'];
  }

  num? productId;
  num? priceId;
  List<String>? image;
  num? rating;
  String? content;

  PostFeedback copyWith({
    num? productId,
    num? priceId,
    List<String>? image,
    num? rating,
    String? content,
  }) =>
      PostFeedback(
        productId: productId ?? this.productId,
        priceId: priceId ?? this.priceId,
        image: image ?? this.image,
        rating: rating ?? this.rating,
        content: content ?? this.content,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['product_id'] = productId;
    map['price_id'] = priceId;
    map['image'] = image;
    map['rating'] = rating;
    map['content'] = content;
    return map;
  }
}
