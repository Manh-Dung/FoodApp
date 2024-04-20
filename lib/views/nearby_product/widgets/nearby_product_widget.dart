import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/models/product/product.dart';
import 'package:ints/x_utils/utilities.dart';

import '../../../base/base_view_view_model.dart';

class NearByProduct extends StatelessWidget {
  const NearByProduct({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    List<int> listMaxMinPrice =
        Utilities().findMaxMinPrice(product.prices ?? []);
    var discount =
        int.parse(product.prices?[listMaxMinPrice[0]].discount ?? "0");
    var discountPrice =
        int.parse(product.prices?[listMaxMinPrice[0]].price ?? "0") - discount;

    return Column(
      children: [
        Container(
          color: Colors.white,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 16),
          child: IntrinsicHeight(
            child: Row(children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(RouterName.product_detail,
                      arguments: {'product': product.toJson()});
                },
                child: Container(
                  height: 85,
                  width: 85,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    child: FadeInImage.assetNetwork(
                        fit: BoxFit.cover,
                        placeholder: XR().gifImage.loading_dot,
                        imageErrorBuilder: (context, error, stackTrace) {
                          return Image.asset(XR().assetsImage.img_logo,
                              fit: BoxFit.cover);
                        },
                        image: product.image?.length == 0
                            ? "https://picsum.photos/200/300"
                            : product.image?[0].path ?? ""),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    fit: FlexFit.loose,
                    child: Container(
                      child: Text(
                        product.name ?? '',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          overflow: TextOverflow.ellipsis,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        IgnorePointer(
                          child: RatingBar(
                            initialRating: product.rating?.toDouble() ?? 0,
                            direction: Axis.horizontal,
                            allowHalfRating: false,
                            itemCount: 5,
                            itemSize: 16,
                            ratingWidget: RatingWidget(
                              full: SvgPicture.asset(
                                  XR().svgImage.ic_colored_star),
                              half:
                                  Image.asset(XR().assetsImage.img_star_color),
                              empty: Image.asset(XR().assetsImage.img_star),
                            ),
                            itemPadding: EdgeInsets.zero,
                            onRatingUpdate: (rating) {},
                          ),
                        ),
                        Text(
                          product.rating != null ? '(${product.rating})' : '0',
                          style: TextStyle(
                              color: MyColor.black,
                              fontSize: 12,
                              fontWeight: FontWeight.w400),
                        ),
                      ]),
                      Text(
                        Utilities().moneyFormater(discountPrice.toString()),
                        style: TextStyle(
                          fontSize: 10,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: MyColor.BORDER_COLOR,
                          color: MyColor.BORDER_COLOR,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        width: 120,
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
                          style: TextStyle(
                            fontSize: 16,
                            color: MyColor.PRICE_COLOR,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(RouterName.product_detail,
                        arguments: {'product': product.toJson()});
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 9, horizontal: 20),
                    decoration: BoxDecoration(
                        color: MyColor.PRIMARY_COLOR,
                        borderRadius: BorderRadius.circular(8)),
                    child: Text(
                      "Mua ngay",
                      style: TextStyle(
                          color: MyColor.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
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
}
