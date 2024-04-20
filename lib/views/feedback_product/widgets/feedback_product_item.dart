import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ints/base/base_view_view_model.dart';
import '../../../models/feedback/feedback_product.dart';
import '../../../x_utils/utilities.dart';
import '../../../x_utils/widgets/my_loading_image.dart';

class FeedBackProductItem extends StatefulWidget {
  final FeedbackProduct? feedbackProduct;

  const FeedBackProductItem({
    super.key,
    required this.feedbackProduct,
  });

  @override
  State<FeedBackProductItem> createState() => _FeedBackProductItemState();
}

class _FeedBackProductItemState extends State<FeedBackProductItem> {
  late bool isExpanded;
  @override
  void initState() {
    isExpanded = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyLoadingImage(
                imageUrl: widget.feedbackProduct?.user?.image?.length == 0
                    ? "https://picsum.photos/200/300"
                    : widget.feedbackProduct?.user?.image?[0].path ?? "",
                size: 24,
                isCircle: true,
              ),
              const SizedBox(width: 7),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.feedbackProduct?.user?.fullName ?? "Họ tên",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    RatingBar(
                      initialRating:
                          widget.feedbackProduct?.rating?.toDouble() ?? 0,
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
                    const SizedBox(height: 10),
                    Text(
                      Utilities().formatDate(
                              (widget.feedbackProduct?.createdAt).toString()) +
                          " | " +
                          "Loại: " +
                          (widget.feedbackProduct?.cartItem?.optionName ?? "") +
                          ", " +
                          (widget.feedbackProduct?.cartItem
                                  ?.optionAttributesName ??
                              ""),
                      style: TextStyle(
                          color: MyColor.TEXT_COLOR_NEW,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.feedbackProduct?.content ?? "Nội dung",
                      maxLines: 3,
                      style: TextStyle(
                          color: MyColor.TEXT_COLOR_NEW,
                          fontWeight: FontWeight.w400,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            itemCount: widget.feedbackProduct?.image?.length ?? 0,
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 13,
              mainAxisSpacing: 13,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              return _imageWidget(index);
            },
          ),
          InkWell(
            onTap: () {
              setState(() {
                isExpanded = !isExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Phản hồi của người bán",
                    style: TextStyle(
                        fontSize: 10,
                        color: MyColor.TEXT_LABEL_COLOR,
                        fontWeight: FontWeight.w400)),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up_rounded
                      : Icons.keyboard_arrow_down_rounded,
                  color: MyColor.BORDER_COLOR,
                  size: 24,
                ),
              ],
            ),
          ),
          isExpanded
              ? Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(225, 226, 227, 1),
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phản hồi của người bán",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(23, 23, 23, 1),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Cảm ơn quý khách đã yêu thích sản phẩm của shop.\nMọi khiếu nại xin vui lòng gọi vào hotline: 02999999999 để mình xử lý.",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(78, 79, 84, 1),
                        ),
                      ),
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _imageWidget(int index) {
    return InkWell(
      onTap: () {
        _showImage(
            Get.context!, widget.feedbackProduct?.image?[index].path ?? "");
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: 124,
          maxWidth: 124,
        ),
        child: MyLoadingImage(
          imageUrl: widget.feedbackProduct?.image?.length == 0
              ? "https://picsum.photos/200/300"
              : widget.feedbackProduct?.image?[index].path ?? "",
          size: 124,
          borderRadius: 8,
        ),
      ),
    );
  }

  _showImage(BuildContext context, String url) {
    showDialog(
      context: context,
      builder: (context) {
        return InkWell(
          onTap: () {
            Get.back();
          },
          child: Dialog.fullscreen(
            backgroundColor: Colors.black.withOpacity(0.1),
            child: InteractiveViewer(
              panEnabled: false,
              minScale: 0.5,
              maxScale: 2,
              child: Image.network(
                url,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        );
      },
    );
  }
}
