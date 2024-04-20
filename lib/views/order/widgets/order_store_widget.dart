import 'package:flutter/material.dart';

import '../../../base/base_view_view_model.dart';
import '../../../models/order/order.dart';

class OrderStoreWidget extends StatelessWidget {
  final Order? order;
  final Function(num storeId) onTapStore;

  const OrderStoreWidget({super.key, required this.order, required this.onTapStore});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTapStore(order?.store?.id ?? 0);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "${order?.store?.name ?? "Tên cửa hàng"}",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
            Text(
              order?.orderCode ?? "Mã đơn hàng",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: MyColor.PRIMARY_COLOR,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
