import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../x_res/my_config.dart';

class DetailInforWidget extends StatelessWidget {
  final String description;
  final bool isExpanded;
  final VoidCallback onTap;
  final bool shimmerLoading;

  const DetailInforWidget(
      {super.key,
      required this.description,
      required this.isExpanded,
      required this.onTap,
      required this.shimmerLoading});

  @override
  Widget build(BuildContext context) {
    return shimmerLoading
        ? Shimmer.fromColors(
            baseColor: MyColor.SHIMMER_BASE_COLOR,
            highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
            child: Container(
                color: Colors.white,
                width: Get.width,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Mô tả sản phẩm",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w700)),
                    Text(description,
                        maxLines: isExpanded ? 100 : 3,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.w400)),
                    InkWell(
                      onTap: () {
                        onTap();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(isExpanded ? "Thu gọn" : "Xem thêm",
                              style: TextStyle(
                                  fontSize: 10,
                                  color: MyColor.SEE_MORE_COLOR,
                                  fontWeight: FontWeight.w500)),
                          Icon(
                            isExpanded
                                ? Icons.keyboard_arrow_up_rounded
                                : Icons.keyboard_arrow_down_rounded,
                            color: MyColor.PRIMARY_COLOR,
                            size: 14,
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          )
        : Container(
            color: Colors.white,
            width: Get.width,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Mô tả sản phẩm",
                      style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w400)),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(description,
                      maxLines: isExpanded ? 100 : 2,
                      style: TextStyle(
                          fontSize: 12,
                          color: MyColor.TEXT_COLOR_NEW,
                          fontWeight: FontWeight.w400)),
                ),
                const SizedBox(height: 10),
                Divider(
                  height: 1,
                  color: Color(0xFFD9D9D9),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: InkWell(
                    onTap: () {
                      onTap();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(isExpanded ? "Thu gọn" : "Xem thêm",
                            style: TextStyle(
                                fontSize: 12,
                                color: MyColor.SEE_MORE_COLOR,
                                fontWeight: FontWeight.w400)),
                        Icon(
                          isExpanded
                              ? Icons.keyboard_arrow_up_rounded
                              : Icons.keyboard_arrow_down_rounded,
                          color: MyColor.PRIMARY_COLOR,
                          size: 24,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ));
  }
}
