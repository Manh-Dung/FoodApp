import 'package:flutter/material.dart';
import 'package:ints/views/order/widgets/order_buttons_widget.dart';
import 'package:ints/views/order/widgets/order_cart_item_widget.dart';
import 'package:ints/views/order/widgets/order_price_widget.dart';

import '../../../base/base_view_view_model.dart';
import '../../../models/order/order.dart';
import 'order_store_widget.dart';

class OrderItemWidget extends StatelessWidget {
  final VoidCallback onTapBuy;
  final VoidCallback onTapRating;
  final VoidCallback onTapCancel;
  final VoidCallback onTapChat;
  final Function(num id) onTapStore;
  final Function(num id) onTapProduct;
  final Function(num id) onTapOrderDetail;
  final Order order;

  const OrderItemWidget(
      {super.key,
      required this.onTapBuy,
      required this.order,
      required this.onTapRating,
      required this.onTapProduct,
      required this.onTapStore,
      required this.onTapCancel,
      required this.onTapChat,
      required this.onTapOrderDetail});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          OrderStoreWidget(
            order: order,
            onTapStore: (num storeId) {
              onTapStore(storeId);
            },
          ),
          Divider(height: 1, color: MyColor.DIVIDER_COLOR),
          OrderCartItemWidget(
            cartItem: order.cartItems?[0],
            onTap: () {
              onTapProduct(order.cartItems?[0].productId ?? 0);
            },
          ),
          Divider(height: 1, color: MyColor.DIVIDER_COLOR),
          InkWell(
              onTap: () {
                // Get.toNamed(RouterName.order_detail,
                //     arguments: {"order": order});
                onTapOrderDetail(order.id ?? 0);
              },
              child: OrderPriceWidget(order: order)),
          Divider(height: 1, color: MyColor.DIVIDER_COLOR),
          OrderButtonsWidget(
            onTapBuy: onTapBuy,
            onTapRating: onTapRating,
            order: order,
            onTapCancel: () {
              onTapCancel();
            },
            onTapChat: () {
              onTapChat();
            },
          )
        ],
      ),
    );
  }
}
