import 'package:flutter/material.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../base/base_view_view_model.dart';

class FeedbackProductWidget extends StatelessWidget {
  final String imagePath;
  final String productName;
  final String productType;

  const FeedbackProductWidget(
      {super.key, required this.imagePath, required this.productName, required this.productType});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          MyLoadingImage(
            imageUrl: imagePath,
            size: 32,
            borderRadius: 2,
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                productName,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              Text(
                "Loại: $productType",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: MyColor.TEXT_COLOR_NEW,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
