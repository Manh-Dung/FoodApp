import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/x_utils/utilities.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/auth/user.dart';
import '../../../models/feedback/feedback_user.dart';
import '../../../x_res/my_config.dart';
import '../../../x_res/x_r.dart';
import '../../../x_utils/widgets/my_loading_image.dart';

class FeedBackItemUser extends StatelessWidget {
  final FeedbackUser feedback;
  final VoidCallback onTapEditFeedback;
  final VoidCallback onTapProductDetail;
  final bool isCheckShimmerLoading;
  final User? user;

  const FeedBackItemUser(
      {super.key,
      required this.feedback,
      required this.user,
      required this.isCheckShimmerLoading,
      required this.onTapEditFeedback,
      required this.onTapProductDetail});

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
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, bottom: 8, right: 16),
      width: double.infinity,
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          MyLoadingImage(
            imageUrl: user?.image?.length == 0
                ? "https://picsum.photos/200/300"
                : user?.image?[0].path ?? "",
            size: 24,
            isCircle: true,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: IntrinsicWidth(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.fullName ?? "Họ tên",
                    style:
                        TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                  RatingBar(
                    initialRating: feedback.feedback?.rating?.toDouble() ?? 1,
                    direction: Axis.horizontal,
                    allowHalfRating: false,
                    itemCount: 5,
                    ignoreGestures: true,
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
                  const SizedBox(height: 10),
                  Text(
                    "${Utilities().formatDate(feedback.createdAt ?? "")} | Loại ${feedback.optionName ?? ""}:${feedback.optionAttributesName ?? ""}",
                    style: TextStyle(
                        color: MyColor.TEXT_COLOR_NEW, fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    feedback.feedback?.content ?? "",
                    style: TextStyle(
                        color: MyColor.TEXT_COLOR_NEW, fontWeight: FontWeight.w400, fontSize: 12),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              color: MyColor.BACKGROUND_COLOR,
                              borderRadius: BorderRadius.circular(4)),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              InkWell(
                                  onTap: () {
                                    onTapProductDetail();
                                  },
                                  child: MyLoadingImage(
                                    borderRadius: 4,
                                    imageUrl: feedback.product?.image?.length == 0
                                        ? "https://picsum.photos/200/300"
                                        : feedback.product?.image?[0].path ?? "",
                                    size: 40,
                                  )),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  feedback.productName ?? "",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400),
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      InkWell(
                        onTap: () {
                          onTapEditFeedback();
                        },
                        child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                            decoration: BoxDecoration(
                                color: MyColor.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: MyColor.PRIMARY_COLOR, width: 1)),
                            child: Center(
                              child: Text(
                                "Sửa",
                                style: TextStyle(
                                    color: MyColor.PRIMARY_COLOR,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400),
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
