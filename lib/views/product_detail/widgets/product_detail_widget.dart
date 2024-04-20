import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_controller.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../models/product/product.dart';
import '../../../x_utils/utilities.dart';

class ProductDetailWidget extends StatelessWidget {
  final Product product;

  const ProductDetailWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    List<int> listMaxMinPrice = Utilities().findMaxMinPrice(product.prices ?? []);

    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(RouterName.product_detail, arguments: {'product': product.toJson()});
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 140,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyLoadingImage(
              borderRadius: 6,
              imageUrl: product.image?.length == 0
                  ? "https://picsum.photos/200/300"
                  : product.image?[0].path ?? "",
              size: 140,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      product.name ?? "Sản phẩm",
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 1),
                  Row(
                    children: [
                      Container(
                        child: RatingBar(
                          initialRating: product.rating?.toDouble() ?? 0,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          itemSize: 8,
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
                  Flexible(
                    child: Text(
                      Utilities().moneyFormater(product.prices?[listMaxMinPrice[0]].price ?? "0") +
                          " - " +
                          Utilities()
                              .moneyFormater(product.prices?[listMaxMinPrice[1]].price ?? "0"),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 10,
                        color: MyColor.PRICE_COLOR,
                        fontWeight: FontWeight.w400,
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
            ),
          ],
        ),
      ),
    );
  }
}
