import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ints/base/base_controller.dart';

import '../../../models/product/product.dart';
import '../../../x_utils/utilities.dart';
import '../../../x_utils/widgets/my_loading_image.dart';

class HomeProductFlashSaleWidget extends StatelessWidget {
  final Product product;

  const HomeProductFlashSaleWidget({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    List<int> listMaxMinPrice =
        Utilities().findMaxMinPrice(product.prices ?? []);
    var discount =
        int.parse(product.prices?[listMaxMinPrice[0]].discount ?? "0");
    var discountPrice =
        int.parse(product.prices?[listMaxMinPrice[0]].price ?? "0") - discount;

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(RouterName.product_detail,
            arguments: {'product': product.toJson()});
      },
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 225, maxWidth: 140),
        child: Column(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 8),
                  Flexible(
                    child: Text(
                      product.name ?? "Sản phẩm",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      Utilities().moneyFormater(discountPrice.toString()),
                      style: TextStyle(
                        fontSize: 16,
                        color: MyColor.FLASH_SALE_COLOR,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 20),
                      child: Stack(children: [
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            height: 16,
                            decoration: BoxDecoration(
                              color: MyColor.FLASH_SALE_BAR_COLOR,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Container(
                            width: 60,
                            height: 16,
                            decoration: BoxDecoration(
                              color: MyColor.FLASH_SALE_COLOR,
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
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
                          child: SvgPicture.asset(
                            XR().svgImage.ic_fire,
                          ),
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
