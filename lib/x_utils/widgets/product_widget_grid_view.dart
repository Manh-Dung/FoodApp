import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_controller.dart';

import '../../models/product/product.dart';
import '../utilities.dart';
import 'my_loading_image.dart';

class ProductWidgetGridView extends StatelessWidget {
  final Product product;

  const ProductWidgetGridView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    List<int> listMaxMinPrice = Utilities().findMaxMinPrice(product.prices ?? []);

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouterName.product_detail, arguments: {'product': product.toJson()});
      },
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.white,
          borderRadius: BorderRadius.all(Radius.circular(6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyLoadingImage(
              borderRadius: 6,
              imageUrl: product.image?.length == 0
                  ? "https://picsum.photos/200/300"
                  : product.image?[0].path ?? "",
              size: Get.width / 2 - 20,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product.name ?? "Sản phẩm",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(23, 23, 23, 1),
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      RatingBar(
                        initialRating: product.rating?.toDouble() ?? 0,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemSize: 16,
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
                      Text(
                        product.vote == null ? "(0)" : " (${product.vote})",
                        style: TextStyle(
                          fontSize: 12,
                          color: const Color.fromRGBO(23, 23, 23, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          Utilities()
                                  .moneyFormater(product.prices?[listMaxMinPrice[0]].price ?? "0") +
                              " - " +
                              Utilities()
                                  .moneyFormater(product.prices?[listMaxMinPrice[1]].price ?? "0"),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 10,
                            color: MyColor.PRICE_COLOR,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Text(
                        "Đã bán ${product.quantitySold}",
                        style: TextStyle(
                          fontSize: 10,
                          color: Color.fromRGBO(23, 23, 23, 1),
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
