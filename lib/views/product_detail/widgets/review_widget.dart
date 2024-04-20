import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_controller.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/feedback/feedback_product.dart';
import '../../../models/product/product.dart';

class ReviewWidget extends StatelessWidget {
  final num totalRating;
  final num totalReview;
  final bool shimmerLoading;
  final List<FeedbackProduct> feedbackProductList;
  final Product? product;

  const ReviewWidget({
    super.key,
    required this.totalRating,
    required this.shimmerLoading,
    required this.totalReview,
    required this.feedbackProductList,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return shimmerLoading
        ? Shimmer.fromColors(
            baseColor: MyColor.SHIMMER_BASE_COLOR,
            highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
            child: Container(
              color: Colors.white,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        XR().svgImage.ic_star,
                      ),
                      SvgPicture.asset(
                        XR().svgImage.ic_star,
                      ),
                      SvgPicture.asset(
                        XR().svgImage.ic_star,
                      ),
                      SvgPicture.asset(
                        XR().svgImage.ic_star,
                      ),
                      SvgPicture.asset(
                        XR().svgImage.ic_star,
                      ),
                      const SizedBox(width: 5),
                      Container(
                        height: 20,
                        child: VerticalDivider(
                          color: Colors.grey,
                          thickness: 1,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text("$totalReview đánh giá",
                          style: TextStyle(fontSize: 15, color: Colors.black)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Divider(
                    color: Colors.grey.shade300,
                    thickness: 1,
                  ),
                ],
              ),
            ),
          )
        : Container(
            color: Colors.white,
            width: Get.width,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Đánh giá sản phẩm",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                fontSize: 12),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            children: [
                              RatingBar(
                                initialRating: totalRating.toDouble(),
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemCount: 5,
                                ignoreGestures: true,
                                itemSize: 16,
                                ratingWidget: RatingWidget(
                                  full: SvgPicture.asset(
                                      XR().svgImage.ic_colored_star),
                                  half: Image.asset(
                                      XR().assetsImage.img_star_color),
                                  empty: Image.asset(XR().assetsImage.img_star),
                                ),
                                itemPadding: EdgeInsets.zero,
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              const SizedBox(width: 9),
                              Row(
                                children: [
                                  Text("$totalRating/5",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: MyColor.PRIMARY_COLOR)),
                                  const SizedBox(width: 2),
                                  Text("($totalReview đánh giá)",
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: MyColor.TEXT_COLOR_NEW)),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                      Obx(() => feedbackProductList.length == 0
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                Get.toNamed(RouterName.feedback_product,
                                    arguments: {
                                      "feedbackProductList":
                                          feedbackProductList,
                                      "product": product
                                    });
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: MyColor.PRIMARY_COLOR),
                                    borderRadius: BorderRadius.circular(8)),
                                child: Text(
                                  "Xem tất cả",
                                  style: TextStyle(
                                      color: MyColor.PRIMARY_COLOR,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ))
                    ],
                  ),
                ),
                Divider(
                  height: 0,
                  color: Colors.grey.shade300,
                  thickness: 1,
                ),
              ],
            ),
          );
  }
}
