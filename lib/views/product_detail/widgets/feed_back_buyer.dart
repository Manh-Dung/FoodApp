import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_controller.dart';
import 'package:readmore/readmore.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/feedback/feedback_product.dart';
import '../../../x_utils/widgets/my_loading_image.dart';

class ProductFeedback extends StatelessWidget {
  final bool isCheckShimmerLoading;
  final FeedbackProduct feedbackProduct;

  ProductFeedback({super.key, required this.isCheckShimmerLoading, required this.feedbackProduct});

  @override
  Widget build(BuildContext context) {
    return isCheckShimmerLoading
        ? Shimmer.fromColors(
            baseColor: MyColor.SHIMMER_BASE_COLOR,
            highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
            child: _widget(),
          )
        : _widget();
  }

  Widget _widget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MyLoadingImage(
                imageUrl: feedbackProduct.user?.image?.length == 0
                    ? "https://picsum.photos/200/300"
                    : feedbackProduct.user?.image?[0].path ?? "",
                size: 24,
                isCircle: true,
              ),
              const SizedBox(width: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    feedbackProduct.user?.fullName ?? "Họ tên",
                    style:
                        TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      RatingBar(
                        initialRating: feedbackProduct.rating?.toDouble() ?? 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemSize: 8,
                        ratingWidget: RatingWidget(
                          full: SvgPicture.asset(XR().svgImage.ic_colored_star),
                          half: Image.asset(XR().assetsImage.img_star_color),
                          empty: Image.asset(XR().assetsImage.img_star),
                        ),
                        itemPadding: EdgeInsets.zero,
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          ReadMoreText(
            feedbackProduct.content ?? 'Nội dung đánh giá',
            trimLines: 3,
            colorClickableText: MyColor.PRIMARY_COLOR,
            trimMode: TrimMode.Line,
            trimCollapsedText: ' Xem thêm ',
            trimExpandedText: ' Thu gọn',
            moreStyle:
                TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: MyColor.PRIMARY_COLOR),
            lessStyle:
                TextStyle(fontSize: 10, fontWeight: FontWeight.w400, color: MyColor.PRIMARY_COLOR),
            style:
                TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: MyColor.TEXT_COLOR_NEW),
          ),
        ],
      ),
    );
  }
}
