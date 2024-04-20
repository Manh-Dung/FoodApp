import 'package:flutter/material.dart';

import '../../../base/base_view_view_model.dart';
import '../../../models/order/order.dart';

class OrderButtonsWidget extends StatelessWidget {
  final VoidCallback onTapBuy;
  final VoidCallback onTapRating;
  final VoidCallback onTapCancel;
  final VoidCallback onTapChat;
  final Order order;

  const OrderButtonsWidget(
      {super.key,
      required this.onTapBuy,
      required this.onTapRating,
      required this.order,
      required this.onTapCancel,
      required this.onTapChat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          order.cartItems!.every((element) => element.feedbackId == null) &&
              (order.status == "Delivered" || order.status == "Cancel")
              ? _buyAgainWidget()
              : Container(),
          const SizedBox(width: 8),
          order.cartItems!.every((element) => element.feedbackId == null) &&
                  order.status == "Delivered"
              ? _orderBtnWidget(
                  onTap: () {
                    onTapRating();
                  },
                  label: "Đánh giá")
              : const SizedBox(),
          order.cartItems!.every((element) => element.feedbackId == null) &&
                  order.status == "awaiting_confirmation"
              ? Row(
                  children: [
                    _orderBtnWidget(
                        onTap: () {
                          onTapCancel();
                        },
                        label: "Hủy đơn"),
                    const SizedBox(width: 8),
                    _orderBtnWidget(
                        onTap: () {
                          onTapChat();
                        },
                        label: "Liên hệ Shop")
                  ],
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  Widget _orderBtnWidget({required Function() onTap, required String label}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: label == "Liên hệ Shop" ? 8 : 20),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: MyColor.PRIMARY_COLOR,
            ),
          ),
          decoration: BoxDecoration(
            color: MyColor.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: MyColor.PRIMARY_COLOR, width: 1),
          )),
    );
  }

  Widget _buyAgainWidget() {
    return GestureDetector(
      onTap: onTapBuy,
      child: Container(
        decoration: BoxDecoration(
          color: MyColor.PRIMARY_COLOR,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        child: Text(
          "Mua lại",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
