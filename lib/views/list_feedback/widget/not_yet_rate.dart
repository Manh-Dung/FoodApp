import 'package:flutter/material.dart';
import 'package:ints/models/feedback/feedback_user.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../base/base_view_view_model.dart';

class NotYetRate extends StatelessWidget {
  final FeedbackUser noFeedback;

  const NotYetRate({super.key, required this.noFeedback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _store(),
        Divider(height: 1, color: Colors.grey.shade300),
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: IntrinsicHeight(
            child: Row(children: [
              MyLoadingImage(
                imageUrl: noFeedback.product?.image?.length == 0
                    ? "https://picsum.photos/200/300"
                    : noFeedback.product?.image?[0].path ?? "",
                size: 85,
                borderRadius: 8,
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        noFeedback.productName ?? "Tên sản phẩm",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Loại: " +
                            (noFeedback.optionName ?? "Loại sản phẩm") +
                            ", " +
                            (noFeedback.optionAttributesName ?? "Thuộc tính"),
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
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    Get.toNamed(RouterName.feedback, arguments: {'feedback': noFeedback});
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: MyColor.PRIMARY_COLOR),
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Đánh giá",
                      style: TextStyle(
                          color: MyColor.PRIMARY_COLOR, fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _store() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      width: double.infinity,
      color: Colors.white,
      child: Text(
        noFeedback.store?.name ?? "",
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),
      ),
    );
  }
}
