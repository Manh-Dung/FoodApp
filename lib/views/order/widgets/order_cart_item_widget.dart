import 'package:flutter/material.dart';
import 'package:ints/x_utils/widgets/my_loading_image.dart';

import '../../../base/base_view_view_model.dart';
import '../../../models/cart/cart.dart';
import '../../../x_utils/utilities.dart';

class OrderCartItemWidget extends StatelessWidget {
  final CartItems? cartItem;
  final VoidCallback onTap;

  const OrderCartItemWidget({super.key, this.cartItem, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                onTap();
              },
              child: MyLoadingImage(
                imageUrl: cartItem?.product?.image?.length == 0
                    ? "https://picsum.photos/200/300"
                    : cartItem?.product?.image?[0].path ?? "",
                size: 85,
                borderRadius: 8,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    cartItem?.productName ?? "Tên sản phẩm",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Loại: " +
                                    (cartItem?.optionName ?? "Loại sản phẩm") +
                                    " " +
                                    (cartItem?.optionAttributesName ?? "Thuộc tính sản phẩm"),
                                style: TextStyle(fontSize: 12, color: MyColor.TEXT_COLOR_NEW)),
                            Text(
                              "x${cartItem?.quantity ?? 1}",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.TEXT_COLOR_NEW,
                              ),
                            ),
                          ],
                        ),
                        Text(Utilities().moneyFormater(cartItem?.priceAtPurchase.toString()),
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: MyColor.PRIMARY_COLOR)),
                      ],
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
