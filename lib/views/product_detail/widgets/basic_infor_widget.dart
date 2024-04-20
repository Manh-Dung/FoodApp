import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../models/product/product.dart' as modelProduct;
import '../../../x_res/my_config.dart';
import '../../../x_res/x_r.dart';
import '../../../x_utils/utilities.dart';

class BasicInforWidget extends StatelessWidget {
  final modelProduct.Product? product;
  final bool shimmerLoading;
  final num totalRating;
  final num totalReview;

  const BasicInforWidget(
      {super.key,
      required this.product,
      required this.shimmerLoading,
      required this.totalRating,
      required this.totalReview});

  @override
  Widget build(BuildContext context) {
    List<int> listMaxMinPrice = [];
    num totalInventory = 0;

    if (product?.prices != null) {
      listMaxMinPrice = Utilities().findMaxMinPrice(product?.prices ?? []);
      totalInventory = Utilities().totalInventory(product?.prices ?? []);
    }

    return shimmerLoading
        ? Shimmer.fromColors(
            baseColor: MyColor.SHIMMER_BASE_COLOR,
            highlightColor: MyColor.SHIMMER_HIGHLIGHT_COLOR,
            child: _product(listMaxMinPrice: listMaxMinPrice, totalInventory: totalInventory))
        : _product(listMaxMinPrice: listMaxMinPrice, totalInventory: totalInventory);
  }

  Widget _product({required List<int> listMaxMinPrice, required num totalInventory}) {
    return Container(
      color: Colors.white,
      width: Get.width,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(product?.name ?? "Sản phẩm",
              style: TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.w600)),
          const SizedBox(height: 5),
          Row(
            children: [
              RatingBar(
                initialRating: totalRating.toDouble(),
                direction: Axis.horizontal,
                allowHalfRating: false,
                itemCount: 5,
                itemSize: 16,
                ignoreGestures: true,
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
                  style: TextStyle(fontSize: 15, color: MyColor.TEXT_COLOR_NEW)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
              Utilities().moneyFormater(product?.prices?[listMaxMinPrice[0]].price) !=
                      Utilities().moneyFormater(product?.prices?[listMaxMinPrice[1]].price)
                  ? Utilities().moneyFormater(product?.prices?[listMaxMinPrice[0]].price) +
                      " - " +
                      Utilities().moneyFormater(product?.prices?[listMaxMinPrice[1]].price)
                  : Utilities().moneyFormater(product?.prices?[listMaxMinPrice[0]].price),
              style: TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.w600)),
          const SizedBox(height: 4),
          Text("Hiện còn " + (totalInventory.toString()),
              style: TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}
