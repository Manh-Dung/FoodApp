import 'dart:io';

import 'package:flutter/material.dart' hide Feedback;
import 'package:ints/base/base_view_view_model.dart';
import 'package:ints/models/feedback/feedback_user.dart';
import 'package:ints/views/feedback/widgets/feedback_display_widget.dart';
import 'package:ints/views/feedback/widgets/feedback_rating_widget.dart';

import '../../../models/order/order.dart';
import 'feedback_product_widget.dart';

class FeedbackProductItem extends StatelessWidget {
  final Order? order;
  final FeedbackUser? noFeedback;
  final int index;
  final Function(double) onRatingUpdate;
  final String status;
  final TextEditingController controller;
  final List<String?> listImage;
  final Function() onPickImage;
  final Function(int index) onRemoveImage;
  final double rating;

  FeedbackProductItem({
    super.key,
    this.order,
    this.noFeedback,
    required this.index,
    required this.onRatingUpdate,
    required this.status,
    required this.controller,
    required this.listImage,
    required this.onPickImage,
    required this.onRemoveImage,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return order == null
        ? _widget(
            imagePath: noFeedback?.product?.image?[0].path ?? "",
            productName: noFeedback?.productName ?? "Tên sản phẩm",
            productType: (noFeedback?.optionName ?? "Loại sản phẩm") +
                " " +
                (noFeedback?.optionAttributesName ?? "thuộc tính sản phẩm"))
        : _widget(
            imagePath: order?.cartItems?[index].product?.image?[0].path ?? "",
            productName: order!.cartItems?[index].productName ?? "Tên sản phẩm",
            productType: (order!.cartItems?[index].optionName ?? "Loại sản phẩm") +
                " " +
                (order!.cartItems?[index].optionAttributesName ?? "thuộc tính sản phẩm"));
  }

  Widget _widget(
      {required String imagePath, required String productName, required String productType}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      FeedbackProductWidget(
        imagePath: imagePath,
        productName: productName,
        productType: productType,
      ),
      Divider(height: 1, color: MyColor.DIVIDER_COLOR),
      FeedbackRatingWidget(
        onRatingUpdate: onRatingUpdate,
        status: status,
        controller: controller,
        listImage: listImage,
        onPickImage: () {
          onPickImage();
        },
        onRemoveImage: (index) {
          onRemoveImage(index);
        },
        rating: rating,
      ),
      Divider(height: 1, color: MyColor.DIVIDER_COLOR),
      FeedbackDisplayWidget()
    ]);
  }
}
