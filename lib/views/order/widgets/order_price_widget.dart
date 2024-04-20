import 'package:flutter/material.dart';

import '../../../base/base_view_view_model.dart';
import '../../../models/order/order.dart';
import '../../../x_res/my_config.dart';
import '../../../x_utils/utilities.dart';

class OrderPriceWidget extends StatelessWidget {
  final Order order;

  const OrderPriceWidget({super.key, required this.order});

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text((order.cartItems?.length.toString() ?? "1") + " sản phẩm",
              style: TextStyle(
                  fontSize: 12, fontWeight: FontWeight.w400, color: MyColor.TEXT_COLOR_NEW)),
          RichText(
              text: TextSpan(
            text: "Thành tiền: ",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: MyColor.black,
            ),
            children: [
              TextSpan(
                text: Utilities().moneyFormater(order.totalMoney.toString()),
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: MyColor.PRIMARY_COLOR,
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
