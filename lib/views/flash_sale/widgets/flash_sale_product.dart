import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/models/product/product.dart';

import '../../../base/base_view_view_model.dart';
import '../../../x_utils/utilities.dart';
import '../../../x_utils/widgets/my_loading_image.dart';

class FlashSaleProduct extends StatelessWidget {
  final Product product;

  const FlashSaleProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    List<int> listMaxMinPrice =
        Utilities().findMaxMinPrice(product.prices ?? []);
    var discount =
        int.parse(product.prices?[listMaxMinPrice[0]].discount ?? "0");
    var discountPrice =
        int.parse(product.prices?[listMaxMinPrice[0]].price ?? "0") - discount;

    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(
              onTap: () {
                _navigateToProductDetail(context);
              },
              child: MyLoadingImage(
                imageUrl: product.image?.length == 0
                    ? "https://picsum.photos/200/300"
                    : product.image?[0].path ?? "",
                size: 120,
                borderRadius: 6,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      product.name ?? "",
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ratingWidget(),
                      const SizedBox(height: 4),
                      Text(Utilities().moneyFormater(discountPrice.toString()),
                          style: TextStyle(
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                            decorationColor: MyColor.BORDER_COLOR,
                            color: MyColor.BORDER_COLOR,
                            fontWeight: FontWeight.w400,
                          )),
                      Flexible(
                        child: Text(
                          Utilities().moneyFormater(product
                                      .prices?[listMaxMinPrice[0]].price) !=
                                  Utilities().moneyFormater(
                                      product.prices?[listMaxMinPrice[1]].price)
                              ? Utilities().moneyFormater(product
                                      .prices?[listMaxMinPrice[0]].price) +
                                  " - " +
                                  Utilities().moneyFormater(
                                      product.prices?[listMaxMinPrice[1]].price)
                              : Utilities().moneyFormater(
                                  product.prices?[listMaxMinPrice[0]].price),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColor.FLASH_SALE_COLOR,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      _soldOutWidget(context),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _ratingWidget() {
    return Row(
      children: [
        RatingBar(
          initialRating: product.rating?.toDouble() ?? 1,
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
          onRatingUpdate: (rating) {},
        ),
        Text(
          "(${product.vote ?? 0})",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  _soldOutWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        Flexible(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 20,
              maxWidth: 120,
            ),
            child: Stack(children: [
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: 16,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: MyColor.FLASH_SALE_BAR_COLOR,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: FractionallySizedBox(
                            widthFactor: 0.66,
                            child: Container(
                              decoration: BoxDecoration(
                                color: MyColor.FLASH_SALE_COLOR,
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "Đã bán 66",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: SvgPicture.asset(XR().svgImage.ic_fire),
              )
            ]),
          ),
        ),
        InkWell(
          onTap: () {
            _navigateToProductDetail(context);
          },
          child: Container(
            decoration: BoxDecoration(
              color: MyColor.FLASH_SALE_COLOR,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
            child: Text(
              "Mua ngay",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
            ),
          ),
        )
      ],
    );
  }

  void _navigateToProductDetail(BuildContext context) {
    Navigator.of(context).pushNamed(RouterName.product_detail,
        arguments: {'product': product.toJson()});
  }
}
