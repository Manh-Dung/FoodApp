import 'package:flutter/material.dart';
import 'package:ints/base/base_controller.dart';

import '../../../models/product/product.dart';
import '../../../x_utils/utilities.dart';
import '../../../x_utils/widgets/my_loading_image.dart';

class HomeProductHotDealsWidget extends StatelessWidget {
  final Product product;

  const HomeProductHotDealsWidget({super.key, required this.product});

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
        constraints: BoxConstraints(maxWidth: 140, maxHeight: 225),
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      Utilities().moneyFormater(
                                  product.prices?[listMaxMinPrice[0]].price) !=
                              Utilities().moneyFormater(
                                  product.prices?[listMaxMinPrice[1]].price)
                          ? Utilities().moneyFormater(
                                  product.prices?[listMaxMinPrice[0]].price) +
                              " - " +
                              Utilities().moneyFormater(
                                  product.prices?[listMaxMinPrice[1]].price)
                          : Utilities().moneyFormater(
                              product.prices?[listMaxMinPrice[0]].price),
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 16,
                        color: MyColor.PRICE_COLOR,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    Utilities().moneyFormater(discountPrice.toString()),
                    style: TextStyle(
                      fontSize: 10,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: MyColor.BORDER_COLOR,
                      color: MyColor.BORDER_COLOR,
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
