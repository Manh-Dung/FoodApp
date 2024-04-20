import 'package:flutter/material.dart';

import '../../base/base_view_view_model.dart';

class MyLoadingImage extends StatelessWidget {
  final double? borderRadius;
  final bool? isCircle;
  final bool? isBanner;
  final String imageUrl;
  final double size;

  const MyLoadingImage(
      {super.key,
      this.borderRadius,
      required this.imageUrl,
      required this.size,
      this.isCircle,
      this.isBanner});

  @override
  Widget build(BuildContext context) {
    return (isCircle ?? false)
        ? ClipOval(
            child: _widget(),
          )
        : ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 0)), child: _widget());
  }

  _widget() {
    return FadeInImage.assetNetwork(
        fit: BoxFit.cover,
        height: size,
        width: size,
        placeholderFit: (isBanner ?? false) ? BoxFit.fitHeight : BoxFit.cover,
        placeholder: XR().gifImage.loading_dot,
        imageErrorBuilder: (context, error, stackTrace) {
          return Image.asset(
            XR().assetsImage.img_logo,
            fit: BoxFit.cover,
            height: size,
            width: size,
          );
        },
        image: imageUrl);
  }
}
